//弹出层效果
$(document).ready(function () {

    //$('.form2-btn').click(function () {
    //    $('.dayer2').show().delay(3000).fadeOut();
    //    $('.hint').show().delay(3000).fadeOut();
    //});
    $(".mobile_phone a").click(function(){
        $('.dayer2').toggle();
        $('.mobile_phone_sao').show();
    });

    $('.hint-close').click(function () {
        window.event.preventDefault(window.event);
        $('.dayer2').hide();
        $('.hint').hide();
    });
    $('.dayer2').click(function () {
        $(this).hide();
        $('.hint').hide();
        $('.mobile_phone_sao').hide();
    });
    if($('.carousel').size()>0){

        $('.carousel').carousel({
            interval: 5000
        });
    }



});
//$(function(){
//    $(".hint").animate({opacity:0},3000,function(){
//        $(this).hide();
//    });
//    $(".dayer2").animate({opacity:0},3000,function(){
//        $(this).hide();
//    });
//});