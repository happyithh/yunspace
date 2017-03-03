/**
 * Created by Administrator on 2015/7/14.
 */
var plugin = {
    tabChange:function(element,args,callback){
        $(".nav-click").removeClass("nav-click-active");
        $(element).addClass("nav-click-active");
        if($(element).hasClass("nav-click-active")&&$(".v-num").length>0){
            $(".v-num").css({
                display:"none"
            })
        }
        var move=100*(args['id']-1);
        $(".line").css({
            transform:"translateX("+move+"%)"
        });
        var index=parseInt(args['id'])-1;
        var tab= $(".tab").eq(index);
        tab.siblings().hide();
        tab.fadeIn(200);
    }
}
