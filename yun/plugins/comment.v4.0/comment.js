/**
 * Created by pzl on 15/12/16.
 */
var plugin={
    nodes:{},
    init:function(){
        this.nodes={
            jInput:$(".j-input"),
            clearInput:$(".j-input").find(".clear-input"),
            commentLogin:$("#comment-login"),
            code:$("#code-input"),
            commentContent:$("#comment-content"),
            commentSubmit:$("#comment-submit"),
            cloneComment:$("#clone-comment"),
            commentList:$(".comment-list"),
            user:$("#header-body-name > span"),
            zan:$(".message-zan").find("a"),
            zans:$(".comment-list").find(".comment-simple .message-zan"),
            userId:$("#header-body-name"),
            txImg:$("#tx-img"),
            loadMore:$("#load-more"),
            loadMoreComment:$("#load-more-comment")
        };
        this.clearInput()
            .initZan()
            .inInput()
            .commentLogin()
            .commentSubmit(this.nodes.commentSubmit)
            .clickOk(this.nodes.zan)
            .loadMore();
    },
    clearInput:function(){
        var that=this;
        that.nodes.clearInput.on("click",function(){
            var $this=$(this);
            $this.hide();
            $this.parent().find("input").val("").focus();
        });
        return this;
    },
    initZan:function(){
        var that=this;
        var lid=localStorage.getItem("zan");
        if(lid==undefined)return that;
        that.nodes.zans.each(function(index,dom){
            var $dom=$(dom);
            var id=$dom.find("a").data("id")+"";
            if(lid.indexOf(id)>-1){
                $dom.find("span").first().addClass("fa-thumbs-up");
            }
        })
        return that;
    },
    inInput:function(){
        var that=this;
        that.nodes.jInput.each(function(index,dom){
            var $dom=$(dom);
            $dom.find("input").on("keyup",function(){
                var $this=$(this);
                $this.on("keyup",function(){
                    var $this=$(this);
                    var v=$this.val();
                    if(v==""){
                        $this.parent().find(".clear-input").hide();
                        return
                    };
                    $this.parent().find(".clear-input").show();
                });
            });
        });
        return that;
    },
    commentLogin:function(){
        var that=this;
        that.nodes.code.on("keyup",function(){
            var $this=$(this);
            var v=$this.val();
            if(v.length!=6){
                that.nodes.commentLogin.attr("disabled",true).css({
                    background:"#c1c1fb"
                });
            }else{
                that.nodes.commentLogin.attr("disabled",false).css({
                    background: "rgba(122,122,250,0.8)"
                });
            }
        });
        that.nodes.commentLogin.on("click",function(){
            var $this=$(this);
            if(!$this.hasClass("ok")){
                return;
            }
            //TODO::登陆成功之后
            location.reload()
        });
        return that;
    },
    commentSubmit:function(o){
        var that=this;
        o.on("click",function(){
            YunSpace.api('common/ustatus.jsonp','',function(data){
                if(data.status==0){
                    alert('请你先登录再评论^_^');
                    var url=window.location.href;
                    var new_url = url.split("?");
                    window.location.href  = new_url+"?n_login=1";
                    return false;
                }
            })
            var v=that.nodes.commentContent.val();
            var accountId=that.nodes.userId.data("account-id");
            var spaceId=that.nodes.userId.data("space-id");
            var img=that.nodes.txImg.find("img").attr("src");
            var parentId=""||that.nodes.commentSubmit.data('id');
            if(v==""){
                var err=that.nodes.commentContent.data("error");
                if($(".comment-error").length>0){
                    $(".comment-error").text(err);
                    $(".comment-error").animate({
                        top:"5%"
                    },500);
                    setTimeout(function(){
                        $(".comment-error").animate({
                            top:"-50px"
                        },500);
                    },2000);
                }
                return false;
            }
            var $comLi=that.nodes.cloneComment.find(".comment-li").clone(),
                username=that.nodes.user.text(),
                date=new Date();
            if($(".back-input").length>0){
                $comLi.find(".message-back").remove();
            }
            var date=that.styleDate(date);
            var href=$comLi.data("href");
            var spaceName=$comLi.data("space");
            //TODO::数据更新请求
            YunSpace.api('comments/create.jsonp', {
                    content:v,
                    account_id: accountId,
                    space_id:spaceId,
                    //parent_id:parent_id,     // 回复评论时使用
                    comments_id:parentId  // 回复评论时使用
                }, function (data) {
                    if (data.status == 1){
                        var hre=href+spaceName+"-讨论组-reply-"+data.data.id;
                        var dateStr=date.month+"-"+date.day+" "+date.hour+":"+date.min;
                        $comLi.find(".message-name > span").text(username);
                        $comLi.find(".comment-person-img > img").attr("src",img);
                        $comLi.find(".message-info > span").text(v);
                        $comLi.find(".message-time > span").text(dateStr);
                        $comLi.find(".message-zan  span").last().text(0);
                        $comLi.find(".message-zan  a").attr("data-id",data.data.id);
                        $comLi.find(".message-back  span").last().text(0);
                        $comLi.find(".message-back  a").attr("href",hre);
                        that.nodes.commentList.prepend($comLi);
                        that.nodes.commentContent.val("");
                        that.nodes.clearInput.hide();
                        that.clickOk($comLi.find(".message-zan  a"));
                    }else{
                        alert(data.msg);
                        window.history.go(-1);
                        //alert(data.msg);
                    }
                },
                'json'
            );

        });
        return that;
    },
    //点赞
    clickOk:function(obj){
        var that=this;
        var zan=localStorage.getItem("zan")||"";
        obj.on("click",function(){
            var $this=$(this);
            var lid=localStorage.getItem("zan");
            //获取评论的id
            var zanId = $this.data("id");
            if(lid!=null) {
                if (lid.indexOf(zanId) > -1)return that;
            }
            var comments_id=zanId;
            //TODO::数据插入,插入成功后执行
            YunSpace.api('comments/createZan.jsonp',{
                comments_id:comments_id
            }, function (data) {
                if (data.status == 1){
                    zan+=zanId+",";
                    localStorage.setItem("zan",zan);
                    var num=parseInt($this.find("span").last().text())+1;
                    $this.find("span").last().text(num);
                    $this.find("span").first().addClass("fa-thumbs-up");
                }else{

                }
            });

        });
        return that;
    },
    styleDate:function(d){
        var date= {
            year: d.getFullYear() + "",
            month: parseInt(d.getMonth() + 1) + "",
            day: d.getDate() + "",
            hour: d.getHours() + "",
            min: d.getMinutes() + "",
            sec: d.getSeconds() + "",
        };
        for(var k in date){
            if(date[k].length==1){
                date[k]="0"+date[k];
            }
        }
        return date;
    },
    loadMore:function(){
        var that=this;
        var n=2;
        //var args=[];
        that.nodes.loadMoreComment.on("click",function(){
            var $this=$(this);
            $this.text('加载中...');
            var spaceId=that.nodes.userId.data("space-id");
            var htm="";
            //TODO::数据更新请求
            YunSpace.api('comments/getCommentsList.jsonp', {
                    dp: n,
                    id:spaceId
                }, function (data) {
                    if (data != ""){
                        var zan=localStorage.getItem("zan")||"";
                        for(var k in data){
                            var $comLi=that.nodes.cloneComment.clone();
                            var date=that.styleDate(new Date(data[k]['create_time']*1000));
                            var href=$comLi.find(".comment-li").data("href");
                            var spaceName=$comLi.find(".comment-li").data("space");
                            var simpleImg=data[k]['user_info']['headimgurl'];
                            var hre=href+spaceName+"-讨论组-reply-"+data[k]['id']+"-"+data[k]['account_id'];
                            var dateStr=date.month+"-"+date.day+" "+date.hour+":"+date.min;
                            $comLi.find(".message-name > span").text(data[k].fullname);
                            if(simpleImg){
                                $comLi.find(".comment-person-img > img").attr("src",simpleImg);
                            }
                            $comLi.find(".message-info > span").text(data[k].content);
                            $comLi.find(".message-time > span").text(dateStr);
                            $comLi.find(".message-zan  span").last().text(data[k]['is_good']);
                            if(zan.indexOf(data[k]['id']) > -1){
                                $comLi.find(".message-zan  a span:first").addClass("fa-thumbs-up");
                            }
                            $comLi.find(".message-zan  a").attr('data-id',data[k]['id']);
                            $comLi.find(".message-back  span").last().text(data[k]['count_reply']);
                            $comLi.find(".message-back  a").attr("href",hre);
                            var html=$comLi.html();
                            htm+=html;
                        }
                        that.nodes.commentList.append(htm);
                        that.clickOk(that.nodes.commentList.find(".update .message-zan a"));
                        $this.text('加载更多...');
                        n++;
                    }else{
                        $this.text('已加载全部');
                    }

                },
                'json'
            );
        })
        return that;
    }
}
