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

    //解决苹果机上输入法遮住输入框问题
    //$('.fill-ipt input').click(function(){
    //
    //});

    /***
     *  拨打电话
     */

    $(".js-call-phone").on('click', function () {
        var behavior = '';
        var phone = $(this).attr('data-tel');
        var schemeId = $(this).attr('data-scheme-id');
        var type = $(this).attr('data-type');
        if (type) {

            behavior = '拨打客户电话' + phone;

        } else {
            behavior = '拨打商家电话' + phone;
        }
        YunSpace.api('Log/Create.jsonp', {
            tender_id: tender_id,
            scheme_id: schemeId,
            behavior: behavior
        }, function (data) {

        });
        window.location.href = 'tel::' + phone;
    });

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
});
/**
 * 提交报价
 */
function vendorBid() {
    var demand_tender_id = $("input[name=tender_id]").val();
    var product_id = $("select[name=product]").find('option:selected').val();
    var product_type = $("select[name=product]").find('option:selected').attr('data-type');
    var contact = $("input[name=contact]").val();

    if (contact.length > 5) {
        $("input[name=contact]").focus();
        alert('联系人名称过长~不能超过4个字节！');
    }
    var contact_phone = $("input[name=contact_phone]").val();
    var remark = $("textarea[name=remark]").val();
    var quote = $("input[name=quote]").val();
    if (!product_id) {
        alert('请选择报价产品');
        $("select[name=product]").click();
        return false;
    }
    if (!quote) {
        alert('请填写产品报价');
        $("input[name=quote]").focus();
        return false;
    }
    var checkPhone = /^(0|86|17951)?(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$/;
    if (!checkPhone.test(contact_phone)) {
        $("input[name=contact_phone]").focus();
        return false;
    }
    YunSpace.api('demand/tender/vendorBid.jsonp', {
        tender_id: demand_tender_id,
        product_id: product_id,
        type: product_type,
        quote: quote,
        scheme: {
            联系人: contact,
            联系电话: contact_phone,
            其他备注: remark ? remark : ''
        }
    }, function (data) {
        if (data.status == 1) {
            window.location.reload();
        }
        alert(data.msg);
    });
}

/**
 * 交换手机号
 */
function exchangePhone() {

    YunSpace.api('Demand/Tender/ExchangePhone.jsonp', {
        tender_id: tender_id,
        scheme_id: scheme_id
    }, function (data) {
        if (data.status == 1) {
            window.location.reload();
        }
        alert(data.msg);
        $('.popup-btn').fadeOut();
        $('.popup_bg').remove();
    });
}
/**
 * 客户结束报价
 *
 */
function endDemandTender() {
    YunSpace.api('Demand/Tender/end.jsonp', {
        tender_id: tender_id
    }, function (data) {
        if (data.status == 1) {
            window.location.reload();
        }
        alert(data.msg);
    })
}
/**
 *  'class' => get_called_class(),
 //            'func' => __FUNCTION__,
 //            'tender_id' => $request['tender_id'],
 //            'behavior' => '商家提交方案'
 */

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
