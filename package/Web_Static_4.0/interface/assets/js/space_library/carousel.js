/**
 * Created by pzl on 16/8/17.
 */
(function(window,document,$){
    var $$={
        rangeRoom:$(".range-room"),
        rrSelect:$(".r-r-select"),
        dropDownHome:$(".drop-down-home"),
        rrButton:$(".r-r-button"),
        publicContainer:$("#public-container"),
        carouselInner:$(".carousel-inner"),
        carouselIndicators:$(".carousel-indicators"),
        citySelectMap:$("#city-select-map"),
        carouselChangeCity:$("#carousel-change-city"),
        carouselExampleGeneric:$("#carousel-example-generic")
    };
    var f={
        cateData:{personNum:"50-100人",type:"路演/展览/发布会"},
        init:function(){
            var citySelectMap=$$.citySelectMap.clone();
            $$.carouselChangeCity.find("ul").html(citySelectMap.html());
            setTimeout(function(){
                $$.rangeRoom.addClass("range-room-active");
            },1000);
            f.carouselCateSelect().carouselCateSelectClick().carouselRendSpaceSubmit().initCarouselIndex();
        },
        carouselCateSelect:function(){
            $$.rrSelect.each(function(index,dom){
                var $dom=$(dom);
                $dom.hover(function(){
                    $$.dropDownHome.removeClass('drop-down-home-active');
                    $dom.find(".drop-down-home").addClass('drop-down-home-active');
                },function(){
                    $dom.find(".drop-down-home").removeClass('drop-down-home-active');
                });
            });
            return f;
        },
        carouselCateSelectClick:function(){
            $$.dropDownHome.find("li").each(function(index,dom){
                var $dom=$(dom);
                $dom.on("click",function(){
                    var $this=$(this);
                    var v=$this.text();
                    if($this.parent().hasClass("space-person-num")){
                        $this.parents(".r-r-select ").find(".par1").text(v);
                        f.cateData.personNum=v;
                    }
                    if($this.parent().hasClass("space-type")){
                        $this.parents(".r-r-select ").find(".par2").text(v);
                        f.cateData.type=v;
                    }
                });
            });
            return f;
        },
        carouselRendSpaceSubmit:function(){
            $$.rrButton.find("button").on("click",function(){
                var home=$$.carouselExampleGeneric.data('home');
                window.location.href=home+"space_library?action=form&people="+f.cateData.personNum+"&activity="+f.cateData.type;
            });
            return f;
        },
        getBannerIndex:function(){
            var getData="",getBannerIndex=0;
            if(window.location.href.indexOf("?")>-1){
                getData=window.location.href.substr(window.location.href.indexOf("?")+1)
            }else{
                return 0;
            }
            if(getData.indexOf("&")>-1){
                getData=getData.split("&");
                for(var i  in getData){
                    if(getData[i].indexOf("banner=")>-1){
                        getBannerIndex=parseInt(getData[i].split("=")[1]);
                    }
                }
            }else{
                if(getData.indexOf("banner=")>-1){
                    getBannerIndex=parseInt(getData.split("=")[1]);
                }else{
                    return 0
                }
            }
            return getBannerIndex;
        },
        initCarouselIndex:function(){
            var index=f.getBannerIndex();
            $$.carouselInner.find(".item").removeClass('active');
            $$.carouselIndicators.find(".carousel-gui").removeClass('active');
            $$.carouselInner.find(".item").eq(index).addClass('active');
            $$.carouselIndicators.find(".carousel-gui").eq(index).addClass('active');
            return f;
        }
    };
    $(function(){
        f.init();
    });
})(window,document,jQuery);