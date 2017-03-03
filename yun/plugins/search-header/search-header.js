/**
 * Created by bll on 15/8/11.
 */
    yun("global/jquery-1.9.1.min.js");
var plugin={
    cNode:"",
    init:function(){
        var height=$(window).height();
        var h=$(window).height()-114;
        $(".result").css({
            height:height
        });
        $(".result-list").css({
            height:h
        })
    },
    //城市选择
    showCity:function(ele,args,callback){
        $(".pull-city").fadeToggle(200,function(){
            $(".city").find("span").toggleClass("ion-arrow-up-b");
        });
    },
    citySelect:function(ele,args,callback){
       var t=$(ele).html();
        var htm=t+'&nbsp;<span class="ion-arrow-down-b"></span>';
       $(".city").html(htm);
        $(".pull-city").fadeOut(200);
    },
    //二维码
    showCode:function(ele,args,callback){
        $(".cover").fadeIn(200);
        $(".cover").css({
            zIndex:"9997"
        })
        $(".code").fadeIn(200);
    },
    searchResult:function(ele,args,callback){
        var self=this;
        self.init();
        $(ele).on("focus",this.eventFocus);
        $(ele).on("keyup",function(){
           $(".result").show();
            self.cNode=$(".result-li").first().clone().removeClass("hidden");
            var v=$(".search").find("input").val();
            $(".result").find("p").find("span").html(v);
            //请求数据
            self.resultAjax();
            $(self.cNode).find("a").html("asdasd");
            $(self.cNode).appendTo(".result-list");
        });;
    },
    eventFocus:function(){
        $(".cover").fadeIn(200);
        $(".search-title").show();
        $(".position,.header-icon,.icon1").css({
            width:"0px",
            height:"0px"
        });
        //$(".icon2").css({
        //    width:"25px",
        //    height:"25px"
        //})
        $(".icon-position").hide();
        $(".city").hide();
        $(".city").css({
            width:"0px",
            height:"0px"
        });
        $(".search").css({
            width:"87%"
        });
        $("body").css({
            overflow:"hidden"
        });
    },
    closeSearch:function(ele,args,callback){
        var w=$(window).width();
        $(".search").find("input").val("");
        $(".search-title").hide();
        $(".result-li").first().siblings().remove();
        $(".result").fadeOut(200);
        $(".cover").fadeOut(200);
        $(".code").fadeOut(200);
        $("body").css({
            overflow:"auto"
        });
        $(".cover").css({
            zIndex:"99"
        })
        $(".icon-position").show();
        //$(".city").show();
        //$(".icon2").css({
        //    width:"0px",
        //    height:"0px"
        //});
        if(w<=320){
            $(".search").css({
                width:"50%"
            });
            $(".position").css({
                width:"23%",
                height: "100%"
            });
        }else{
            $(".search").css({
                width:"60%"
            });
            $(".position").css({
                width:"17%",
                height: "100%"
            });
        }
        $(".header-icon").css({
            width:"auto",
            height:"auto"
        });
        setTimeout(function(){
            $(".icon1").css({
                width:"25px",
                height: "25px"
            });
            $(".city").css({
                width:"100%",
                height:"100%"
            });
            $(".city").show();
        },400);
    },
    //搜索后数据处理
    resultAjax:function(){
        //alert(1);
        //YunSpace.api(url, {
        //    item:self.item
        //}, function (data) {
        //    self.makeResult(data);
        //    $(this.cNode).find("a").html("asdasd");
        //});
    }

}