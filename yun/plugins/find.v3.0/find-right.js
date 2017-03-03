/**
 * Created by pzl on 15/10/12.
 */
var plugin={
    init:function(){
        var minH=$(".side-find").outerHeight()+60;
        var okArray=document.cookie.split(";");
        var id=$(".zan-click").data("title_id");
        var l=$(".swiper-slide").length;
        var hrefCode=window.location.href;
        $(".share-link").each(function(index,dom){
            var url1=$(dom).attr("href");
            var url2=url1+hrefCode;
            $(dom).attr("href",url2);
        })
        $(".content").css({
            minHeight:minH+"px"
        });
        $(".pick-select").each(function(index,dom){
            $(dom).find("li").last().css({
                border:"0"
            })
        })
        if(okArray[0].indexOf(id)>=0){
            $(".zan-img > img").addClass("none");
            $(".zan-img > img:last").removeClass("none");
        }




        $(".find-list-body > li").each(function(index,dom){
            if($(dom).find(".find-body-img").length<=0){
                $(dom).find(".find-body-content").css({
                    width:"100%"
                });
                $(dom).find(".find-body-content").css({
                    padding:"0px",
                    width:"791px",
                    paddingRight:"10px"
                });
            }
        });
        $(".side-top-p").each(function(index,dom){
            $(dom).hover(function(){
                $(".side-top-p").removeClass("side-top-p-active");
                $(this).addClass("side-top-p-active");
                $(".side-top-list").addClass("none");
                $(".side-top-list").eq(index).removeClass("none");
            },function(){})
        });
        $(".pick-list > li").each(function(index,dom){
            $(dom).hover(function(){
                $(".pick-li-body").hide();
                $(dom).find(".pick-li-body").show();
                $(dom).find(".pick-li span").addClass("ion-ios-arrow-up");
            },function(){
                $(dom).find(".pick-li-body").hide();
                $(dom).find(".pick-li span").removeClass("ion-ios-arrow-up");
            })
        });
        $(".share-weixin").hover(function(){
            $(".code-weixin").stop();
            $(".code-weixin").show();
            $(".code-weixin").animate({
                opacity: 1,
                filter:"alpha(opacity=100)",
                top:"-150px"
            },500);
        },function(){
            $(".code-weixin").stop();
            $(".code-weixin").animate({
                opacity: 0,
                filter:"alpha(opacity=100)",
                top:"-130px"
            },500);
            $(".code-weixin").hide();
        });
        $(".side-footer-recommend > li").hover(function(){
            $(this).find(".side-footer-recommend-li-cover,.side-footer-recommend-li-p1,.side-footer-recommend-li-p2").stop();
            $(this).find(".side-footer-recommend-li-cover").css({
                background:"#000"
            });
            $(this).find(".side-footer-recommend-li-p1,.side-footer-recommend-li-p2").css({
                color:"#fff"
            });
            $(this).find(".side-footer-recommend-li-cover").animate({
                opacity:"0.5",
                height:"270px"
            },300);
            $(this).find(".side-footer-recommend-li-p1").animate({
                top:"100px"
            },300);
            $(this).find(".side-footer-recommend-li-p2").animate({
                top:"130px"
            },300);
            $(this).find(".side-footer-recommend-li-link").show();
        },function(){
            $(this).find(".side-footer-recommend-li-cover,.side-footer-recommend-li-p1,.side-footer-recommend-li-p2").stop();
            $(this).find(".side-footer-recommend-li-cover").css({
                background:"#fff"
            });
            $(this).find(".side-footer-recommend-li-p1,.side-footer-recommend-li-p2").css({
                color:"#000"
            });
            $(this).find(".side-footer-recommend-li-cover").animate({
                opacity:"0.8",
                height:"95px"
            },300);
            $(this).find(".side-footer-recommend-li-p1").animate({
                top:"190px"
            },300);
            $(this).find(".side-footer-recommend-li-p2").animate({
                top:"237px"
            },300);
            $(this).find(".side-footer-recommend-li-link").hide();
        });


        if($(".code-weixin").length>0){
            $(".code-weixin-img").qrcode({
                render: "table", //table方式
                width:100, //宽度
                height:100, //高度
                text: hrefCode //任意内容
            });
        }


        if($(".side-find").length>0){
            sideScroll.init();
            var mySwiper = new Swiper('.swiper-container',{
                prevButton:'.swiper-button-prev',
                nextButton:'.swiper-button-next',
                loop : true,
                autoplay: 3000,
                effect : 'fade',
                fade: {
                    crossFade: true
                },
                onSlideChangeEnd: function(swiper){
                    var acttiveIndex=swiper.activeIndex;
                    if(acttiveIndex>l){
                        acttiveIndex=1;
                    }
                    var index=acttiveIndex+"/"+l;
                    $(".roll-index").text(index);
                }
            });
            if($(".side-find").height()>$(".side-left-content").height()&&$(".side-left-content").length>0){
                $(".side-find").css({ top:"74px" });return false;
            }
            sideScroll.setScrollPosition();
            $(window).on("scroll",function(){
                sideScroll.setScrollPosition();
            });
        }



    },

    zanAdd:function(ele) {
        //ToDo::以下在点赞成功之后执行
        var id = $(ele).data("title_id");
        var okArray = document.cookie.split(";");
        if (okArray[0].indexOf(id) >= 0) {
            //alert("请勿重复点赞！！");
            return false;
        }
        this.setCookie(id);
        var num = parseInt($(ele).find(".zan-num").text());
        YunSpace.api('raiders/praise/up.json', {
                id: id
            }, function (data) {
                if(data.status == 1) {
                    localStorage.ok = true;
                    num = num+1;
                    $(ele).find(".zan-num").text(num);
                    $(ele).find(".zan-img > img").addClass("none");
                    $(ele).find(".zan-img > img:last").removeClass("none");

                } else {
                alert(data.msg);
            }
        });
        //$(ele).find(".zan-img > img").addClass("none");
        //$(ele).find(".zan-img > img:last").removeClass("none");
        //var num=parseInt($(ele).find(".zan-num").text())+1;
        //$(ele).find(".zan-num").text(num);
        //this.setCookie(id);
    },
    setCookie:function(value){
        var Days = 30;
        var exp = new Date();
        exp.setTime(exp.getTime() + Days*24*60*60*1000);
        if(document.cookie.indexOf("ok=")<0){
            document.cookie ="ok="+value;
        }else{
            var cookieArray=document.cookie.split(";");
            cookieArray[0]+=","+value;
            document.cookie =cookieArray[0] ;
        }
    },
    shareAdd:function(ele){
        $(ele).addClass("none");
        $(".code-weixin").addClass("code-weixin-add");
        $(".share-img").animate({
            width: "240px"
        }, 100 );
    }
}
if($(".side-find").length>0) {

    var sideScroll = {
        scrollT: $(window).scrollTop(),
        window: {H: $(window).height(), W: $(window).width()},
        sideOffset: {
            top: $(".side-find").offset().top,
            right: $(".content").width() < $(window).width() ? $(".content").offset().left : $(window).width() - $(".content").width()
        },
        sideH: $(".side-find").height(),
        maxOffset: $(".footer-outside").offset().top,
        toBottom: "",
        fromBottom: "",
        init: function () {

            $(window).on("resize", function () {
                sideScroll.sideOffset.right = $(".content").width() < $(window).width() ? $(".content").offset().left : $(window).width() - $(".content").width();
                //$(".side-find").css({
                //    right:sideScroll.sideOffset.right+"px"
                //});
            })
        },
        setScrollPosition: function () {
            var __self = this;
            __self.sideOffset.right = $(".content").width() < $(window).width() ? $(".content").offset().left : $(window).width() - $(".content").width();
            __self.scrollT = $(window).scrollTop();
            if (__self.scrollT + __self.window.H > __self.maxOffset - 60) {
                $(".side-find").css({
                    position: "absolute",
                    top: "auto",
                    bottom: "0px",
                    right: "0px"
                });
                __self.toBottom = true;
                return false;
            }
            if (__self.scrollT == 0) {
                __self.formBottom = false;
            }
            __self.scrollToBottom();
            __self.scrollTopLg();

        },
        scrollToBottom: function () {
            var __self = this;
            //到达底部后的操作
            if (__self.toBottom == true) {
                var bottomUp = $("body").height() - $(".side-find").height() - $(".footer-outside").height();
                var bottomDown = $("body").height() - $(".footer-outside").height() - __self.window.H;
                if (__self.scrollT - 300 >= bottomUp && __self.scrollT - 300 <= bottomDown) {
                    $(".side-find").css({
                        position: "absolute",
                        top: "auto",
                        bottom: "0px",
                        right: "0px"
                    });
                }
                if (__self.scrollT < bottomUp) {
                    $(".side-find").css({
                        position: "fixed",
                        top: "70px",
                        right: __self.sideOffset.right + "px"
                    });
                    __self.toBottom = false;
                    __self.formBottom = true;
                }
                return false;
            }

        },
        scrollTopLg: function () {
            var __self = this;
            //当滚动高度大于side-find偏移高度
            if (__self.scrollT > __self.sideOffset.top) {
                //判断是否出现底部
                if ((__self.scrollT + __self.window.H) > (__self.sideOffset.top + __self.sideH)) {
                    if (__self.formBottom == true) {
                        $(".side-find").css({
                            position: "fixed",
                            top: "70px",
                            right: __self.sideOffset.right + "px"
                        });
                    } else {
                        $(".side-find").css({
                            position: "fixed",
                            top: "auto",
                            bottom: "0px",
                            right: __self.sideOffset.right + "px"
                        });
                    }

                    //当滚到底部后向上滚动且未出现side-find顶部时，一直处于absolute状态
                    if ((__self.scrollT + __self.window.H) - 60 > __self.maxOffset) {
                        var fixBottom = $(".footer-outside").height();
                        $(".side-find").css({
                            position: "absolute",
                            top: "auto",
                            bottom: "0px",
                            right: "0px"
                        });
                    }
                } else {
                    $(".side-find").css({
                        position: "absolute",
                        top: "74px",
                        right: "0px"
                    });
                }
            } else {
                $(".side-find").css({
                    position: "absolute",
                    top: "74px",
                    right: "0px"
                });
            }
        }
    }
}

