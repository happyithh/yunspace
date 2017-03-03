$(function () {
    $('.js-mk-edit>li').click(function () {
        if ($(this).find('.icon-cg').hasClass('icon-c')) {
            $(this).find('.icon-cg').removeClass('icon-c');
        } else {
            $(this).find('.icon-cg').addClass('icon-c');
        }

        if ($('.icon-cg').hasClass('icon-c')) {
            $(".dmd-delt-btn").show();
        } else {
            $(".dmd-delt-btn").hide();
        }
    });

    //$('.js-mk-edit-new>li').click();
    //弹窗消失
    $('.js-cancel,.js-close,.js-reminder-box').click(function () {
        $('.js-pop-cont').fadeOut();
        $('.popup_bg').remove();
    });

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

    //结束报价弹窗
    $('.js-endquote').click(function () {
        $('.js-pop-endquote').fadeIn().after('<div class="popup_bg"></div>');
    });

    //联系他电话弹窗
    $(".js-phone").click(function () {
        $('.js-pop-phone').fadeIn().after('<div class="popup_bg"></div>');
    });

    //是否接受不了判断
    $(".js-noaccept").click(function () {
        $('.js-pop-noaccept').fadeIn().after('<div class="popup_bg"></div>');
    });

    //确定接受不了（拒绝订单）弹窗
    //$(".js-btn-yes").click(function () {
    //    $('.pop-refuse').fadeIn();
    //    $(".pop-noacpt").hide();
    //});
    //$(".js-refuse-close").click(function () {
    //    $('.pop-refuse').hide();
    //    $(".pop-noacpt").fadeIn();
    //});

    //修改报价提交
    $(".form-sbt-revise").click(function () {
        $(".js-pop-revise").fadeIn().after('<div class="popup_bg"></div>');
    });

    //标签编辑页面
    //$('.js-edit-btn').click(function () {
    //    var text = $(this).text();
    //    switch (text) {
    //        case '取消':
    //            $('.dmd-delt-btn').hide();
    //            $(this).text('编辑');
    //            $('.icon-cg').remove();
    //
    //            break;
    //        case '编辑':
    //            $('.dmd-delt-btn').show();
    //            $(this).text('取消');
    //            $('.mk-edit li').append('<span class="icon-cg"></span>');
    //            $('.icon-cg').click(function () {
    //                if ($(this).hasClass('icon-c')) {
    //                    $(this).removeClass('icon-c');
    //                } else {
    //                    $(this).addClass('icon-c');
    //                }
    //            });
    //
    //            break;
    //        default:
    //            break;
    //    }
    //});
    $(".js-mk-editbtn").click(function () {
        $(".js-pop-addmarks").fadeIn().after('<div class="popup_bg"></div>');
    });
    $(".js-delt-submit").click(function () {
        $(".js-pop-dltmarks").fadeIn().after('<div class="popup_bg"></div>');
    });
    $(".js-deltmarks").click(function () {
        $(".icon-c").parent().remove();
    });
    //$(document).on('click','.recommended-marks li',function(){
    //    var mkval=$(this).text();
    //    var hasThisText = false;
    //    if($('.dmd-tend-my .mk-edit li').length > 0){
    //        $('.dmd-tend-my .mk-edit li').each(function(){
    //            if($(this).text() == mkval){
    //                hasThisText = true;
    //            }
    //        });
    //        if(!hasThisText){
    //            $('.dmd-tend-my>.mk-edit').append("<li>"+mkval+"<span class='icon-cg'></span>"+"</li>");
    //        }
    //    }else{
    //        $('.dmd-tend-my>.mk-edit').append("<li>"+mkval+"<span class='icon-cg'></span>"+"</li>");
    //        $(".nomarks-text").hide();
    //        $(".no-mk-editbtn").removeClass("no-mk-editbtn").addClass("hv-mk-editbtn");
    //    }
    //
    //});


});
function newTagsAlert(e) {
    //alert($(e).index());
    if ($(e).find('.icon-cg').hasClass('icon-c')) {
        $(e).find('.icon-cg').removeClass('icon-c');
    } else {
        $(e).find('.icon-cg').addClass('icon-c');
    }

    if ($('.icon-cg').hasClass('icon-c')) {
        $(".dmd-delt-btn").show();
    } else {
        $(".dmd-delt-btn").hide();
    }
}
/**
 *
 *
 * @type {number}
 */
//var start = 0;
//var Storage = new Array;
//
//function NewTagsUpdate(a) {
//
//    var result_id = $(".js-data-offer").attr('data-result-id');
//    var demand_id = $(".js-data-offer").attr('data-demand-id');
//    var _this = $(".js-pop-mk .p-mk-big");
//    var last_eq = $(".js-pop-mk .p-mk-big").last().index();
//
//    var _status = false;
//    for (var i = 0; i < last_eq; i++) {
//        _status = _this.eq(i).is(":visible");
//        if (_status) {
//            var kkk = _this.eq(i).children('span').attr('data-value');
//            Storage[kkk] = a;
//            _this.hide();
//            if (i == last_eq - 1) {
//                $(".js-pop-mk .p-mk-big").eq(last_eq - 1).show();
//                YunSpace.api('demand/offer/match/result/update.json',
//                    {
//                        action: 'tags',
//                        result_id: result_id,
//                        demand_id: demand_id,
//                        tags_data: Storage
//                    }, function (data) {
//                        document.cookie = 'perfect' + demand_id + 's=1';
//                        $('.js-pop-cont').fadeOut();
//                        $('.popup_bg').remove();
//                        window.location.replace(location.href);
//
//                    });
//            } else {
//                ++start;
//                $(".js-pop-mk .p-mk-big").eq(start).show();
//            }
//
//            return false;
//        }
//
//    }
//
//}


























