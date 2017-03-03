
$(function(){

    $('.creat-order-fill .fill').focus(function(){
        $(this).parents("li").addClass('focused');
    });
    $('.creat-order-fill .fill').blur(function(){
        $(this).parents("li").removeClass('focused');
    });
    //$('.creat-order-fill li').click(function () {
    //    $(this).find('.fill').focus();
    //});
});