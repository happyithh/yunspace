/**
 * Created by pzl on 15/12/29.
 */
var plugin={
    showCode:function(ele,args,fn){
        $(".person-code-img-one").hide();
        $(".person-code-img-one").eq(args.id).fadeIn();
        $(".cover-one").fadeIn();
        var ml=$(".person-code-one").outerWidth();
        $(".person-code-one").css({marginLeft:"-"+ml/2+"px"});
        $(".person-code-one").slideDown();
        $(".person-code-close-one,.cover-one").on("click",function(){
            $('.cover-one,.person-code-one').hide();
        });
    }
}
