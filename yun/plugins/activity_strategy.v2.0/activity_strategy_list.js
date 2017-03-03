/**
 * Created by pzl on 15/9/21.
 */
var plugin={
    prevIndex:"",
    currentIndex:"",
    category_id:"",
    load_time:true,
    init:function() {
        var that=this;
        var srcTop = $(window).scrollTop();
        that.category_id=$(".yun_find_p").data("category_id");
        if(that.category_id==0){
            $(".yun_find").css({
                height:"40px"
            });
        }

        var okArray=document.cookie.split(";");
        var id=$(".up").find(".ok_num").data("title_id");
        if(okArray[0].indexOf(id)<0){
            $(".up_img").eq(0).removeClass("none");
            $(".up_img").eq(1).addClass("none");
        }
        $(".info_article img").css({
            width:"100%",
            height:"auto"
        })
        if (srcTop >=300) {
            $(".nav-fix").show();
            $(".nav-fix").css({
                left: "15px",
                opacity: "0"
            });
            setTimeout(function () {
                $(".nav-fix").css({
                    left: "85%",
                    opacity: "1"
                });
            }, 100);
        }
        //var aw=$(".author").width()+40;
        //$(".author").css({
        //    marginLeft:"-"+aw/2+"px"
        //})
        if (srcTop >=300) {
            $(".provide-activity").show();
            $(".provide-activity").css({
                left: "15px",
                opacity: "0"
            });
            setTimeout(function () {
                $(".provide-activity").css({
                    left: "85%",
                    opacity: "1"
                });
            }, 100);
        }
        if($(window).scrollTop()>windowH){
            $(".back_top").show();
        }else{
            $(".back_top").hide();
        }
        navStatus.eventScroll();
        actStatus.eventScroll();
        $(window).on("scroll",function(){
            if($(window).scrollTop()>windowH){
                $(".back_top").show();
            }else{
                $(".back_top").hide();
            }
        });
        if($(".content1").length>0){
            $(window).scroll(function(){
                var scrollTop = $(this).scrollTop();
                var scrollHeight = $(document).height();
                var windowHeight = $(this).height();
                if(scrollHeight-(scrollTop + windowHeight) <= 50){
                    that.loadMoreFinds(that);
                }
            });
        }

        var mySwiper = new Swiper('.swiper-container', {
            autoplay: 5000,  //可选选项，自动滑动
            autoplayDisableOnInteraction : false,
            speed:500,
            onInit: function(swiper){
                var index=swiper.activeIndex+1;
                var l=$(".swiper-slide").length;
                $(".img_num").text(index+"/"+l);
                //$(".swiper-slide").eq(0).find(".show_find_body_li_title").addClass("show_title_active");
                //$(".swiper-slide").eq(0).find(".show_find_body_li_des").addClass("show_des_active");
            },
            onSlideChangeStart: function(swiper){
                //$(".show_find_body_li_title").removeClass("show_title_active");
                //$(".show_find_body_li_des").removeClass("show_des_active");
            },
            onSlideChangeEnd: function(swiper){
                var index=swiper.activeIndex+1;
                var l=$(".swiper-slide").length;
                $(".img_num").text(index+"/"+l);
                var degP=90*swiper.activeIndex-45;
                if(swiper.activeIndex==0){
                    $(".show_find_square").css({
                        transform:"rotate(45deg)"
                    });
                }else{
                    $(".show_find_square").css({
                        transform:"rotate(-"+degP+"deg)"
                    });
                }
                //$(".swiper-slide").eq(swiper.activeIndex).find(".show_find_body_li_title").addClass("show_title_active");
                //$(".swiper-slide").eq(swiper.activeIndex).find(".show_find_body_li_des").addClass("show_des_active");
            }
        })
    },
    loadMoreFinds:function(o){
        if(!$(".loaded_all").hasClass("none")){
            $(".load_more").addClass("none");
            return false;
        }
        var create_time=$(".act_strategy_all").find("a").last().data("create_time");
        $(".load_more").removeClass("none");
        $(".loaded_all").addClass("none");
        if(o.load_time==false){return false};
        o.load_time=false;
        YunSpace.api('raiders/list.jsonp', {
            category_id:this.category_id,
            create_time:create_time
        }, function (data) {
            console.log(data);
            if(data.data.length<=0){
                $(".load_more").addClass("none");
                $(".loaded_all").removeClass("none");
                return false;
            }
            setTimeout(function(){
                o.load_time=true;
            },20);
            if (data.status == 1) {
                for(var k =0;k< data.data.length;k++){
                    var myDate = new Date(parseInt(data.data[k]["create_time"])*1000);//当前时间
                    var y=myDate.getFullYear();    //获取完整的年份(4位,1970-????)
                    var m=myDate.getMonth();       //获取当前月份(0-11,0代表1月)
                    var d=myDate.getDate();        //获取当前日(1-31)
                    var h=myDate.getHours();
                    var i=myDate.getMinutes();
                    var s=myDate.getSeconds();
                    var date=y+"-"+(m+1)+"-"+d+" "+h+":"+i+":"+s;
                    //var navClick=data.data[k]["author"]||"来自网络";
                    var act_strategy=$(".act_strategy_li_clone").clone().removeClass("none");
                    $(act_strategy).attr("data-create_time",data.data[k]["create_time"]);
                    var href=$(act_strategy).data("href")+data.data[k]["id"]+".html";
                    $(act_strategy).attr("href",href);
                    if(data.data[k]["logo"]!=="") {
                        $(act_strategy).find(".act_strategy_content_li_img").find("img").attr("src", data.data[k]["logo"]);
                    }else{
                        $(act_strategy).find(".act_strategy_content_li_img").remove();
                    }
                    $(act_strategy).find(".act_strategy_content_li_title").text(data.data[k]["title"]);
                    $(act_strategy).find(".act_strategy_content_li_des").text(data.data[k]["des"]);
                    //$(act_strategy).find(".act_strategy_content_li_footer").find("p").eq(0).html(author+"&nbsp;&nbsp;&nbsp;");
                    $(act_strategy).find(".act_strategy_content_li_footer").find("p").eq(1).html(date);
                    $(act_strategy).find(".act_strategy_content_li_footer").find(".ok_num").html("&nbsp;&nbsp;"+data.data[k]["counter_praise"]);
                    $(act_strategy).find(".act_strategy_content_li_footer").find(".look_num").html("&nbsp;&nbsp;"+data.data[k]["counter_view"]);
                    $(".act_strategy_all").append(act_strategy[0]);
                }
            } else {
                alert(data.msg);
            }
        });
    },
    showFinds:function(ele,args,callback){
        var self=this;
        $(args.show).toggleClass("none");
        if($(args.show).hasClass("none")){
                $(ele).find("span").removeClass("ion-ios-arrow-up");
        }else{
            $(ele).find("span").addClass("ion-ios-arrow-up");
        }
        //$(".yun_find_nav_li").on("click",
    },
    navClick:function(ele,args,callback){
        var self=this;

        $(".act_strategy_all").find("a").remove();
        var t=$(ele).find(".yun_find_nav_li_p").text();
        var src=$(ele).find("img").attr("src");
        $(".yun_find").css({
            height:"70px"
        });
        $(".find_selected").show();
        $(".find_selected_p").text(t);
        $(".find_selected_img").find("img").attr("src",src);
        self.showFindList(ele);
    },
    //TODO::ajax请求
    showFindList:function(ele){
        this.category_id = $(ele).attr('data-category_id');
        if(this.category_id==undefined){return};
        YunSpace.api('raiders/list.jsonp', {
            category_id: this.category_id
        }, function (data) {
            if(data.data.length<=0){
                $(".loaded_all").show();
                return false;
            }
            $(".act_strategy_all").find("a").remove();
            if (data.status == 1) {
                for(var k =0;k< data.data.length;k++){
                    var myDate = new Date(parseInt(data.data[k]["create_time"])*1000);//当前时间
                    var y=myDate.getFullYear();    //获取完整的年份(4位,1970-????)
                    var m=myDate.getMonth();       //获取当前月份(0-11,0代表1月)
                    var d=myDate.getDate();        //获取当前日(1-31)
                    var date=y+"-"+m+"-"+d;
                    var act_strategy=$(".act_strategy_li_clone").clone().removeClass("none");
                    var href=$(act_strategy).data("href")+data.data[k]["id"]+".html";
                    //var author=data.data[k]["author"]||"来自网络";
                    $(act_strategy).attr("href",href);
                    $(act_strategy).attr("data-create_time",data.data[k]["create_time"]);
                    $(act_strategy).find(".act_strategy_content_li_img").find("img").attr("src",data.data[k]["logo"]);
                    $(act_strategy).find(".act_strategy_content_li_title").text(data.data[k]["title"]);
                    $(act_strategy).find(".act_strategy_content_li_des").text(data.data[k]["des"]);
                    //$(act_strategy).find(".act_strategy_content_li_footer").find("p").eq(0).html(author+"&nbsp;&nbsp;&nbsp;");
                    $(act_strategy).find(".act_strategy_content_li_footer").find("p").eq(1).html("&nbsp;&nbsp;&nbsp;"+date);
                    $(act_strategy).find(".act_strategy_content_li_footer").find(".ok_num").html("&nbsp;&nbsp;"+data.data[k]["counter_praise"]);
                    $(act_strategy).find(".act_strategy_content_li_footer").find(".look_num").html("&nbsp;&nbsp;"+data.data[k]["counter_view"]);
                    $(".act_strategy_all").append(act_strategy[0]);
                }
            } else {
                alert(data.msg);
            }
        });
    },
    backTop:function(){
        var currentPosition;
        //实现返回顶部滚动
        var timer=setInterval(function(){
            currentPosition=document.body.scrollTop;
            currentPosition-=100;
            if(currentPosition>0)
            {
                window.scrollTo(0,currentPosition);
            }
            else
            {
                window.scrollTo(0,0);
                clearInterval(timer);
            }
        },1);
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

    clickOk:function(ele,args,callback) {
        var id=$(ele).find(".ok_num").data("title_id");
        var okArray=document.cookie.split(";");
        if(okArray[0].indexOf(id)>=0){
            //alert("请勿重复点赞！！");
            return false;
        }
        this.setCookie(id);
        var n = parseInt($(".ok_num").text());
        var title_id = $(".ok_num").data('title_id');
        YunSpace.api('raiders/praise/up.json', {
            id: title_id
        }, function (data) {
            if (data.status == 1) {
                localStorage.ok=true;
                //n++;
                //$(".ok_num").text(n);
                $(".ok_num").text(n+1).addClass("ok_ing");
                setTimeout(function(){
                    $(".ok_num").removeClass("ok_ing");
                },800);
                $(".up_img").addClass("none");
                $(".up_img").eq(1).removeClass("none");

            } else {
                alert(data.msg);
            }
        });
    },

    clickOk1:function(ele,args,callback){
        var n=parseInt($(".ok_num").text());
        $(ele).toggleClass("up");
        if($(ele).hasClass("up")){
            $(".ok_num").text(n+1).addClass("ok_ing");
            setTimeout(function(){
                $(".ok_num").removeClass("ok_ing");
            },800);
            $(".up_img").addClass("none");
            $(".up_img").eq(1).removeClass("none");
        }else{
            $(".ok_num").text(n-1);
            $(".up_img").addClass("none");
            $(".up_img").eq(0).removeClass("none");
        }
    }
}

$(document).on(
    ' click',
    function (e) {
        if ($(e.target).closest(".yun_find").length === 0) {
            $(".yun_find .yun_find_nav").addClass("none");
            $(".yun_find_more").find("span").removeClass("ion-ios-arrow-up");
        }
    }
)

var windowH=$(window).height();
//菜单动画
var navStatus = {
    statue: true,//默认状态;false为展开，true为圆圈
    srcTop: "",
    animateOpen: true,
    statueCircle: function () {
        var that = this;
        that.srcTop = $(window).scrollTop();
        if (navStatus.animateOpen == true) {
            if (navStatus.statue == true) {
                return;
            }
            $(".nav-fix").show();
            setTimeout(function () {
                $(".nav-fix").css({
                    left: "85%",
                    opacity: "1"
                });
            }, 5);
            navStatus.statue = true;
        } else {
            if (navStatus.statue == false) {
                return;
            }
            //$(".nav-fix").removeClass("show");
            $(".nav-fix").css({
                left: "4%",
                opacity: "0"
            })
            $(".nav-point").parent().removeClass("nav-fix-active");
            setTimeout(function () {
                $(".nav-fix").hide();
                navStatus.statue = false;
            }, 400);
        }
    },
    eventScroll: function () {
        $(window).on("scroll", function () {
            navStatus.srcTop = $(window).scrollTop();
            if (navStatus.srcTop >= 300) {
                navStatus.animateOpen = true;
                navStatus.statueCircle();
            } else {
                navStatus.animateOpen = false;
                navStatus.statueCircle();
            }
        })
    }
}

//活动按钮
var actStatus = {
    statue: false,//默认状态;false为展开，true为圆圈
    srcTop: "",
    animateOpen: false,
    statueCircle: function () {
        var that = this;
        that.srcTop = $(window).scrollTop();
        if (actStatus.animateOpen == true) {
            if (actStatus.statue == true) {
                return;
            }
            $(".provide-activity").show();
            setTimeout(function () {
                $(".provide-activity").css({
                    left: "85%",
                    opacity: "1"
                });
                //$(".provide-activity").addClass("show");
                actStatus.statue = true;
            }, 5)
        } else {
            if (actStatus.statue == false) {
                return;
            }
            //$(".provide-activity").removeClass("show");
            $(".provide-activity").css({
                left: "4%",
                opacity: "0"
            });
            setTimeout(function () {
                $(".provide-activity").hide();
                actStatus.statue = false;
            }, 400)
        }
    },
    eventScroll: function () {
        $(window).on("scroll", function () {
            actStatus.srcTop = $(window).scrollTop();
            if (actStatus.srcTop >= 300) {
                actStatus.animateOpen = true;
                actStatus.statueCircle();
            } else {
                actStatus.animateOpen = false;
                actStatus.statueCircle();
            }
        })
    }
}

$(".nav-point").on("click", function () {
    $(this).parent().toggleClass("nav-fix-active");
});
