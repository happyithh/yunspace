var plugin={
    nodes:{},
    init:function(ele,args,fn){
        this.nodes={
            win:$(window),
            doc:$(document),
            publicContainer:$("#public-container"),
            publicList:$(".public-list"),
            publicSelect:$(".public-select"),
            publicDropBody:$(".public-drop-body"),
            publicDrop:$(".public-drop"),
            publicInput:$("#public-input"),
            publicInputTwo:$("#public-input2"),
            publicCateTitle:$(".public-cate-title"),
            publicSelectList:$(".public-select-list"),
            searchSpace:$("#search-space-three")
        }
        var st=this.nodes.win.scrollTop();
        if(st>=300){
            this.nodes.publicContainer.show();
        }else{
            this.nodes.publicContainer.hide();
        }
        //console.log(this.nodes.publicList.find("li:nth-of-type(4n) a").length);
        this.nodes.publicList.find("li:nth-of-type(4n) a").css({ border:"0"})
        this.showPublicSpace().showPublicDrop().docTake().searchBaidu();
    },
    showPublicSpace:function(){
        var that=this;
        var show=false;
        that.nodes.win.on("scroll",function(){
            var $this=$(this);
            var st=$this.scrollTop();
            //TODO::滚动一定高度显示
            if(st>=300){
                if( show==true)return;
                that.nodes.publicContainer.show();
                show=true;
            }else{
                if( show==false)return;
                that.nodes.publicContainer.hide();
                that.nodes.publicSelectList.addClass("none");
                that.nodes.publicDropBody.addClass("none");
                that.nodes.publicSelect.find(".down-icon").css({
                    backgroundPosition:"-89px -11px"
                });
                show=false;
            }
        });
        return that;
    },
    showPublicDrop:function(){
        var that=this;
        that.nodes.publicSelect.find("span").on("click",function(){
            that.nodes.publicSelectList.toggleClass("none");
            if(that.nodes.publicSelectList.hasClass("none")){
                that.nodes.publicSelect.find(".down-icon").css({
                    backgroundPosition:"-89px -11px"
                });
            }else{
                that.nodes.publicDropBody.addClass("none");
                that.nodes.publicSelect.find(".down-icon").css({
                    backgroundPosition:"-89px -78px"
                });
            }
        });
        that.nodes.publicSelectList.find("li").each(function(index,dom){
            var $dom=$(dom);
            $dom.on("click",function(){
                var $this=$(this);
                var v=$this.text();
                that.nodes.publicSelect.find("span").html("<code>"+v+'</code><i class="down-icon"></i>');
                switch (v){
                    case '找场地':
                        that.nodes.publicDrop.find("input[name='search_type']").val('site_library');
                        that.nodes.publicInput.addClass("none");
                        that.nodes.publicInputTwo.removeClass("none");
                        break;
                    case '找资讯':
                        that.nodes.publicDrop.find("input[name='search_type']").val('project_library');
                        that.nodes.publicInput.removeClass("none");
                        that.nodes.publicInputTwo.addClass("none");
                        break;
                    case '找公司':
                        that.nodes.publicDrop.find("input[name='search_type']").val('company_library');
                        that.nodes.publicInput.removeClass("none");
                        that.nodes.publicInputTwo.addClass("none");
                        break;
                    case '找文库':
                        that.nodes.publicDrop.find("input[name='search_type']").val('paper_library');
                        that.nodes.publicInput.removeClass("none");
                        that.nodes.publicInputTwo.addClass("none");
                        break;
                }
                that.nodes.publicSelectList.addClass("none");
                that.nodes.publicSelect.find(".down-icon").css({
                    backgroundPosition:"-89px -11px"
                });
            })
        });
        that.nodes.publicDrop.hover(function(){},function(){
            that.nodes.publicDropBody.addClass("none");
            that.nodes.publicInput.blur();
        });
        var publicInput=that.nodes.publicInput||that.nodes.publicInputTwo;
        publicInput.on("focus",function(){
            var v=that.nodes.publicInput.val();
            if(v!=""){
                that.nodes.publicDropBody.eq(1).removeClass("none");
                return that;
            }
            that.nodes.publicDropBody.addClass("none");
            that.nodes.publicDropBody.eq(0).removeClass("none");
            //that.nodes.publicDropBody.eq(1).removeClass("none");
        });
        publicInput.on("keyup",function(){
            var $this=$(this);
            var keyword=$this.val();
            var show=false;
            if(keyword!=""){
                YunSpace.api("search/get/library/list.jsonp",{
                    keyword : keyword
                },function(data){
                    if(data.status==1){
                        that.nodes.publicDropBody.eq(1).find('ul').remove();
                        that.nodes.publicDropBody.eq(1).append(data.data);
                        that.nodes.publicDropBody.eq(0).addClass("none");
                        that.nodes.publicDropBody.eq(1).removeClass("none");
                        $(".chose_keyword").click(function(){
                            var key_word  = $(this).find('span').text();
                            var search_type =  that.nodes.publicDrop.find("input[name='search_type']").val();
                            window.location.href="/database?action=is_submit&search_type="+search_type+"&keyword="+key_word;
                        });
                    }else{
                        that.nodes.publicDropBody.eq(1).addClass("none");
                        that.nodes.publicDropBody.eq(0).removeClass("none");
                    }
                })
                //if(show==true){return;}
                //that.nodes.publicDropBody.eq(0).addClass("none");
                //that.nodes.publicDropBody.eq(1).removeClass("none");
                //show=true;
                //return;
            }else{
                that.nodes.publicDropBody.eq(1).addClass("none");
                that.nodes.publicDropBody.eq(0).removeClass("none");
            }

        });
        return that;
    },
    docTake:function(){
        var that=this;
        that.nodes.doc.on("click",function(e){
            if($(e.target).closest(".public-select").length==0){
                that.nodes.publicSelectList.addClass("none");
                that.nodes.publicSelect.find(".down-icon").css({
                    backgroundPosition:"-89px -11px"
                });
            }
        })
        return that;
    },
    searchBaidu:function(){
        var that=this;
        var map = new BMap.Map("l-map");
        map.centerAndZoom("上海",12);
        var ac = new BMap.Autocomplete(    //建立一个自动完成的对象
            {
                "input" : "public-input2"
                ,"location" : map
            });
        ac.addEventListener("onconfirm", function(e) {    //鼠标点击下拉列表后的事件
            var addr=$("#public-input2").val();
            var root=that.nodes.searchSpace.data("root");
            addr = encodeURI(encodeURI(addr));
            var url= root+"map2?addr="+addr;
            window.open(url);
        });
        return that;
    },
    searchSpace:function(){
        var that=this;
        that.nodes.searchSpace.on("click",function(){
            var $this=$(this),city;
            if($("#public-input2").hasClass('none')){
                city=$("#public-input").val();
            }else{
                city=$("#public-input2").val();
            }
            if(city=="")return false;
            var root=$this.data('root');
            var url=root+"database/site?action=is_submit&search_type=site_library&keyword="+city;
            window.open(url);
        });
        return that;
    }
}