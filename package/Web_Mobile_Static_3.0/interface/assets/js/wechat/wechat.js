/**
 * Created by pzl on 16/1/19.
 */

$(function(){
    var oks=[],initOk,initFail,fails=[];
    var nodes={
        cloneOne:$("#clone-one"),
        cloneTwo:$("#clone-two"),
        articleList:$("#article-list")
    };
    function getInit(){
        initOk=localStorage.getItem('zan');
        initFail=localStorage.getItem("fail");
        if(initOk==null&&initFail==null){return false;}
        if(initOk!=null){
            oks.push(initOk);
            nodes.articleList.find(".zan").each(function(index,dom){
                var $dom=$(dom);
                var id=$dom.data("id")||0;
                if(initOk.indexOf(id)>=0){
                    $dom.addClass("fa-thumbs-up");
                }
            });
        }
        if(initFail!=null){
            fails.push(initFail);
            nodes.articleList.find(".fail").each(function(index,dom){
                var $dom=$(dom);
                var id=$dom.data("id")||0;
                if(initFail.indexOf(id)>=0){
                    $dom.addClass("fa-thumbs-down");
                }
            });
        }

    }
    function getClick(a){
        var author = a.data('author');
        var title = a.data('title');
        var url = a.data('url');
        var status = a.data('status');
        YunSpace.api('wechat/author/click.jsonp',{
            author:author
        },function(data){
            if(data.status ==1){
                if(url==''){
                    window.location="http://weixin.sogou.com/weixin?type=2&query="+title+"&ie=utf8/";
                }else{
                    window.location=url;
                }
                return false
            }else{
                alert('跳转失败');
            }
        },'json')
    }
    function zanOrFail(){
        getInit();
        $(".zan").each(function(index,dom){
            var $dom=$(dom);
            $dom.on("click",function(){
                var $this=$(this);
                if($this.hasClass("fa-thumbs-up")||$this.parents('.article-li-footer').find('.fail').hasClass("fa-thumbs-down")){return false;}
                var id=$this.data("id");
                var author=$this.data("author");
                $this.addClass("fa-thumbs-up");
                oks.push(id);
                var okStr=oks.join(",");
                localStorage.setItem('zan', okStr);
                //    TODO::AJAX更改点赞数据
                YunSpace.api('wechat/article/create/zan.jsonp',{
                    id:id,author:author
                },function(data){
                    if(data.status="1"){
                        var v=parseInt($dom.parent().find('span:last').text())+1;
                        $dom.parent().find('span:last').text(v);
                    }else{
                        alert('操作失败！！')
                    }
                },'json')

            })
        });
        $(".fail").each(function(index,dom){
            var $dom=$(dom);
            $dom.on("click",function(){
                var $this=$(this);
                if($this.hasClass("fa-thumbs-down")||$this.parents('.article-li-footer').find('.zan').hasClass("fa-thumbs-up")){return false;}
                var id=$this.data("id");
                var author=$this.data("author");
                var type = 1;
                $this.addClass("fa-thumbs-down");
                fails.push(id);
                var failsStr=fails.join(",");
                localStorage.setItem('fail', failsStr);
                //    TODO::AJAX更改点赞数据
                YunSpace.api('wechat/article/create/zan.jsonp',{
                    id:id,type:type,author:author
                },function(data){
                    if(data.status="1"){
                        $this.parents('.article-li').addClass('none');
                    }else{
                        alert('操作失败！！')
                    }
                },'json')

            })
        });
        nodes.articleList
        $(nodes.articleList).find('.article-li').each(function(index,dom){
            var $dom=$(dom);
            $dom.find('a').on('click',function(){
                var $this=$(this);
                getClick($this);
            });
        });
    }
    zanOrFail();
    var dp=2;
    $('#load-more-article').find(".more_data").click(function(){
        var $this=$(this);
        $this.parent().find(".loading").removeClass('none');
        $this.addClass('none');
        setTimeout(function(){
            YunSpace.api("wechat/article/mobile/list.jsonp",{
                dp:dp
            },function(data){
                var html="";
                if(data==""){
                    $this.parent().find(".loading").addClass('none');
                    $this.removeClass('none').text("已加载全部");
                    return false;
                }
                for(var k in data['rows']){
                    var htm="";
                    if(data['rows'][k]['img']!=""){
                        var $cloneNode=nodes.cloneOne.clone().removeClass("none");
                        $cloneNode.find(".article-li-header").text(data['rows'][k].title);
                        $cloneNode.find(".article-li-body-only img").attr('src',data['rows'][k]['img']);
                        $cloneNode.find(".article-li-footer p:first").text(data['rows'][k]['author']||'云SPACE');
                        $cloneNode.find(".zan,.fail").attr('data-id',data['rows'][k]['id']);
                        $cloneNode.find(".zan,.fail").attr('data-author',data['rows'][k]['author']);
                        $cloneNode.find(".article-li-footer>p:eq(1)>span:last").html('&nbsp'+data['rows'][k]['is_good']);
                        $cloneNode.find(".article-li-footer>p:eq(2)>span:last").html('&nbsp'+data['rows'][k]['is_bad']);
                        $cloneNode.find("a").attr("data-author",data['rows'][k]['author']);
                        $cloneNode.find("a").attr("data-title",data['rows'][k]['title']);
                        $cloneNode.find("a").attr("data-url",data['rows'][k]['article_url']);
                        htm=$cloneNode.html();
                    }else{
                        var $cloneNode=nodes.cloneTwo.clone().removeClass("none");
                        $cloneNode.find(".article-li-header").text(data['rows'][k].title);
                        $cloneNode.find(".article-li-footer p:first").text(data['rows'][k]['author']||'云SPACE');
                        $cloneNode.find(".zan,.fail").attr('data-id',data['rows'][k]['id']);
                        $cloneNode.find(".zan,.fail").attr('data-author',data['rows'][k]['author']);
                        $cloneNode.find(".zan>span").html('&nbsp'+data['rows'][k]['is_good']);
                        $cloneNode.find(".fail>span").html('&nbsp'+data['rows'][k]['is_bad']);
                        $cloneNode.find("a").attr("data-author",data['rows'][k]['author']);
                        $cloneNode.find("a").attr("data-title",data['rows'][k]['title']);
                        $cloneNode.find("a").attr("data-url",data['rows'][k]['article_url']);
                        htm=$cloneNode.html();
                    }
                    html+=htm;
                }
                nodes.articleList.append(html);
                $this.parent().find(".loading").addClass('none');
                $this.removeClass('none');
                zanOrFail();
                dp++;
            })
        },2000);


    })

})
