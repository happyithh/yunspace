$(function () {
    //弹窗消失
    $('.js-cancel,.js-close,.js-reminder-box').click(function () {
        $('.js-pop-cont').fadeOut();
        $('.popup_bg').remove();
    });

    //点击获取商家联系方式
    //$('.js-getnumb,.js-edit-submit').click(function () {
    //    $('.demand-popup').fadeIn().after('<div class="popup_bg"></div>');
    //    $('.popup-exchange-ph').fadeIn();
    //    scheme_id = $(this).attr('data-scheme-id');
    //});
    //$(".js-edit-submit").
    //弹出温馨提示
    $('.js-rem').click(function () {
        $(".js-reminder-box").fadeIn();
        $('.reminder').after('<div class="popup_bg"></div>');
    });

    //已关闭
    $('.js-icon-close').click(function () {
        $('.js-pop-rejudge').fadeIn().after('<div class="popup_bg"></div>');
    });

    //询价中
    $('.js-inq').click(function () {
        $('.js-judge-inq').fadeIn().after('<div class="popup_bg"></div>');
    });

    //我的活动需求页面标签删除
    $('.icon-close-d').click(function () {
        $(this).parent().remove();
    });

    //标签编辑页面
    $('.js-edit-btn').click(function () {
        var text = $(this).text();
        switch (text) {
            case '取消':
                $('.dmd-delt-btn').hide();
                $(this).text('编辑');
                $('.icon-cg').remove();

                break;
            case '编辑':
                $('.dmd-delt-btn').show();
                $(this).text('取消');
                $('.mk-edit li').append('<span class="icon-cg"></span>');
                $('.icon-cg').click(function () {
                    if ($(this).hasClass('icon-c')) {
                        $(this).removeClass('icon-c');
                    } else {
                        $(this).addClass('icon-c');
                    }
                });

                break;
            default:
                break;
        }
    });


});

/**
 *
 *
 * @type {number}
 */
var start = 0;
var Storage = new Array;

function NewTagsUpdate(a) {

    var result_id = $(".js-data-offer").attr('data-result-id');
    var demand_id = $(".js-data-offer").attr('data-demand-id');
    var _this = $(".js-pop-mk .p-mk-big");
    var last_eq = $(".js-pop-mk .p-mk-big").last().index();

    var _status = false;
    for (var i = 0; i < last_eq; i++) {
        _status = _this.eq(i).is(":visible");
        if (_status) {
            var kkk = _this.eq(i).children('span').attr('data-value');
            Storage[kkk] = a;
            _this.hide();
            if (i == last_eq - 1) {
                $(".js-pop-mk .p-mk-big").eq(last_eq - 1).show();
                YunSpace.api('demand/offer/match/result/update.json',
                    {
                        action: 'tags',
                        result_id: result_id,
                        demand_id: demand_id,
                        tags_data: Storage
                    }, function (data) {
                        document.cookie = 'perfect' + demand_id + 's=1';
                        $('.js-pop-cont').fadeOut();
                        $('.popup_bg').remove();
                        window.location.replace(location.href);

                    });
            } else {
                ++start;
                $(".js-pop-mk .p-mk-big").eq(start).show();
            }

            return false;
        }

    }

    console.log(Storage);
}


























