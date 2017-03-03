
var plugin={
    aboutBox:function(){
        $(".box-title").on("click",function(){
            if($(this).parent().hasClass('height30')){
                $(this).parent().removeClass('height30');
                $(this).parent().siblings().addClass('height30');
            }else{
                $(this).parent().addClass('height30');
            }
        });
    }
}

