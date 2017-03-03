var tender_id, scheme_id;
$(document).ready(function () {
    tender_id = $(".js-data-tender-id").attr('data-tender-id');

    $('.js-getnumb').click(function () {
        $('.demand-popup').fadeIn().after('<div class="popup_bg"></div>');
        $('.popup-exchange-ph').fadeIn();
        scheme_id = $(this).attr('data-scheme-id');
    });

    $('.js-cancel').click(function () {
        $('.popup_bg').remove();
        $('.demand-popup').fadeOut();

        $('.popup-exchange-ph').fadeOut();
        $('.popup-end-quote').fadeOut();

        $('.reminder').fadeOut(200);
    });

    //弹出温馨提示
    $('.js-reminder-btn').click(function () {
        $(".js-reminder-box").show();
        $('.reminder').fadeIn().after('<div class="popup_bg"></div>');
    });

    //结束报价确认
    $('.js-end-quote').click(function () {
        $('.demand-popup').fadeIn().after('<div class="popup_bg"></div>');
        $('.popup-end-quote').fadeIn();
        scheme_id = $(this).attr('data-scheme-id');
    });

    //已报价页面点击选中状态
    $(".hvquote .alink").click(function(){
        $(".hvquote .alink").removeClass("current");
        $(this).addClass("current");
    });

    //解决苹果机上输入法遮住输入框问题
    //$('.fill-ipt input').click(function(){
    //
    //});
    //展开/收起
    $(".js-slide-onoff").click(function(){
        switch ($(this).text()){
            case "展开":
                $(this).text("收起");
                $(this).addClass("up");
                $(this).siblings(".list-hide,.edit").slideDown();
                break;
            case "收起":
                $(this).text("展开");
                $(this).removeClass("up");
                $(this).siblings(".list-hide,.edit").slideUp();
                break;

        }
    });

    //$(".select>p,.txt-screen").on("click",function(e){
    //    $(".select").toggleClass("open");
    //    e.stopPropagation();
    //});
    //
    //$(".select ul li").on("click",function(e){
    //    $(this).addClass("selected").siblings().removeClass("selected");
    //    $(".select>p").text($(this).text());
    //    $(".select").removeClass("open");
    //    e.stopPropagation();
    //});
    //$(document).on("click",function(){
    //    $(".select").removeClass("open");
    //});
    $(".select>p,.txt-screen").on("click",function(e){
        $(".select").toggleClass("open");
        $(".dcont-wrap").toggleClass("open");
        $(".dcont-wrap-bg-opty").toggleClass("open");
        e.stopPropagation();
    });

    $(".select ul li").on("click",function(e){
        $(this).addClass("selected").siblings().removeClass("selected");
        $(".select>p").text($(this).text());
        $(".select").removeClass("open");
        e.stopPropagation();
    });
    $(document).on("click",function(){
        $(".select").removeClass("open");
    });





});


function loadMore() {
    var last_id = $('.quote-needs-details li').last().attr('data-id');
    var tender_id = $('.quote-needs-details li').last().attr('data-tender-id');

    $.ajax({
        url: '?action=ajaxLoadMore',
        type: 'get',
        dataType: 'json',
        data: {
            last_id: last_id,
            tender_id: tender_id
        },
        success: function (data) {
            if (data.status == 1) {
                $(".quote-needs-details").append(data.data);
            } else {

                alert(data.msg);
            }

        }
    });
}
