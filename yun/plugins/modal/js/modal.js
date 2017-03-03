/**
 * Created by Administrator on 2015/7/13.
 */
var plugin = {
    showModalMove:function(element,args,callback){
        var cover=$(".cover");
        var modal=$(".modal-move");
        cover.fadeIn(400);
        modal.css({
            animation:"showModalMove 0.8s"
        });
        modal.fadeIn(400);
        cover.on("click",function(){
            $(".cover").fadeOut(400);
            modal.fadeOut(400);
        })
    },
    showModalPc:function(element,args,callback){
        var cover=$(".cover");
        var modal=$(".modal-pc");
        $(".modal-title").html(args['title']);
        cover.fadeIn(400);
        modal.css({
            animation:"showModalPc 0.8s"
        });
        modal.fadeIn(400);
        cover.on("click",function(){
            $(".cover").fadeOut(400);
            modal.fadeOut(400);
        })
    },
    sure:function(element,args,callback){
        var modal=$(".modal-pc");
        $(".cover").fadeOut(400);
        modal.fadeOut(400);
        if(callback){
            callback();
        }
    }
}
