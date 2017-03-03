/**
 * Created by Administrator on 2015/7/13.
 */
var plugin = {
    showDrop:function(element,args,callback){
        var sibClick=$(element).siblings();
        var icon=$(".drop-icon");
        var cover=$(".cover");
        var con=$(".drop-con");
        var click=$(".drop-click");
        cover.hide();
        $(element).toggleClass("drop-click-active");
        if($(element).hasClass("drop-click-active")){
            sibClick.removeClass("drop-click-active");
            sibClick.children().removeClass("drop-active");
            sibClick.find(".drop-icon").removeClass("drop-active ion-arrow-up-b");
            $(element).find("a,span").addClass("drop-active");
            $(element).find("span").addClass("ion-arrow-up-b");
            con.hide();
            cover.show();
            con.eq(args['id']).slideDown(200);
        }else{
            sibClick.removeClass("drop-click-active");
            sibClick.children().removeClass("drop-active");
            $(element).find("a,span").removeClass("drop-active");
            icon.removeClass("drop-active ion-arrow-up-b");
            cover.fadeOut(400);
            con.hide();
        }
        cover.on("click",function(){
            click.removeClass("drop-click-active");
            click.children().removeClass("drop-active");
            icon.removeClass("drop-active ion-arrow-up-b");
            cover.fadeOut(400);
            con.hide();
        })
    }
}
