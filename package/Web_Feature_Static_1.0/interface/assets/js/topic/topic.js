$(document).ready(function(){
    $(".site_two_word").mouseenter(function(){
        $(this).stop().animate({
            width:'670px'
        });
        $(this).siblings('div').stop().animate({
            width:'390px'
        });
        $(this).addClass('backcolor');
        $(this).find(".fit").removeClass('none');
        $(this).find(".flow").removeClass('none');
        $(this).find(".price").removeClass('none');
    });
    $(".site_two_word").mouseleave(function(){
        $(this).stop().animate({
            width:'455px'
        });
        $(this).siblings('div').stop().animate({
            width:'590px'
        });
        $(this).removeClass('backcolor');
        $(this).find(".fit").addClass('none');
        $(this).find(".flow").addClass('none');
        $(this).find(".price").addClass('none');
    });

    $(".site_one_word").mouseenter(function(){
        $(this).stop().animate({
            width:'670px'
        });
        $(this).siblings('div').stop().animate({
            width:'350px'
        });
        $(this).addClass('backcolor');
        $(this).find(".fit").removeClass('none');
        $(this).find(".flow").removeClass('none');
        $(this).find(".price").removeClass('none');
        $('.site_one_img1').css("width","290px");
    });
    $(".site_one_word").mouseleave(function(){
        $(this).stop().animate({
            width:'285px'
        });
        $(this).siblings('div').stop().animate({
            width:'733px'
        });
        $(this).removeClass('backcolor');
        $(this).find(".fit").addClass('none');
        $(this).find(".flow").addClass('none');
        $(this).find(".price").addClass('none');
        $('.site_one_img1').css("width","673px");
    });
});
function get_click(e) {
    // var name = $(e).data('clickname');
    // YunSpace.api('get/click/sum.jsonp', {
    //     name: name
    // }, function (data) {
    //     console.log(data.data);
    // });
    var tsid = $(e).data('tsid');
    YunSpace.api('get/click/sum.jsonp', {
        tsid: tsid
    }, function (data) {
        console.log(data.data);
    });


}