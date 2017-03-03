$(document).ready(function () {
    var win_id = 0;

    //弹窗
    $('.js-close').click(function () {
        $('.pop-consl').hide();
        $('.pop-viewpdf').hide();
        $('.popup_bg').remove();
    });
    $('.btn-hz').click(function () {
        $("input[name=winchance_username]").val($("#user_stat").attr('data-username'));
        $("input[name=winchance_phone]").val($("#user_stat").attr('data-phone'));
        $('.pop-consl').show().after('<div class="popup_bg"></div>');
        win_id = $(this).attr('data-id');

    });

    $('.js-load').click(function(){
        $('.pop-viewpdf').show().after('<div class="popup_bg"></div>');
    });



    //点击差号删掉条件筛选
    $('.shut').click(function() {
        $(this).parent('.selected').remove();
        window.location.href='/winchance/list';
    });



    $('.pop-consl .btn-confirm').click(function () {
        YunSpace.api('demand/winchance/create.json', {
            'contact': $("input[name=winchance_username]").val(),
            'contact_phone': $("input[name=winchance_phone]").val(),
            'id': win_id,
            'content': $("textarea[name=content]").val()

        }, function (data) {
            if (data.status == 1) {
                $('.js-close').click();
            }
            alert(data.msg);
        });

    });

    //去文创主页面合作活动第二个的边框
    $('.js-act-bordernone').find('.col-cont').eq(1).css('border-bottom','none');

    //鼠标滑上悬浮
    $('.col-ct-tit>p').hover(function(){
        $(this).siblings('.xuanf').stop().slideToggle(200);
    });
});