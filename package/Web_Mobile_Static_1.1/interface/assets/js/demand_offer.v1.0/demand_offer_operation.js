/**
 * Created by zzc on 2015/10/22.
 */
var operation = {

    result_id: '',
    demand_id: '',
    clickGetContact: function (e) {
        $('.demand-popup').fadeIn().after('<div class="popup_bg"></div>');
        $('.popup-exchange-ph').fadeIn();
        this.result_id = $(e).attr('data-result-id');
        this.demand_id = $(e).attr('data-demand-id');
    },
    switchTags: function (e) {
        var _index = $(e).find('option:selected').index();
        $(".filling-mkt .mkt").hide();
        $(".filling-mkt  a").hide();
        $(".filling-mkt .mkt").eq(_index).show();
        $(".filling-mkt  a").eq(_index).show();
    },
    deleteAlert: function (e) {
        $('.demand-popup').fadeIn().after('<div class="popup_bg"></div>');
        $('.popup-exchange-ph').fadeIn();
        this.result_id = $(e).attr('data-result-id');
        this.demand_id = $(e).attr('data-demand-id');
    }, mkSubmit: function (e) {
        var _result_id = $(e).attr('result-id');
        var _item_id = $(e).attr('item-id');
        var TagId = new Array;
        var _Tid = '';

        $('.mk-edit .icon-c').each(function () {
            _Tid = $(this).parent('li').attr('data-value');
            TagId[_Tid] = -1;
        });
        YunSpace.api('demand/offer/match/result/update.json', {
            action: 'del_tags',
            item_id: _item_id,
            tags_ids: TagId,
            result_id: _result_id
        }, function (data) {
            alert(data.msg);
            $(".js-cancel").click();
            location.replace(location.href)

        });
    },
    changePhone: function () {
        YunSpace.api('demand/offer/match/result/update.json', {
            action: 'changePhone',
            result_id: this.result_id,
            demand_id: this.demand_id
        }, function (data) {
            location.replace(location.href);
        });
    },
    vendorBid: function () {

        var result_id = $("input[name=result_id]").val();
        var offer_id = $("input[name=offer_id]").val();

        var demand_id = $("input[name=demand_id]").val();
        var item_id = $("select[name=product]").find('option:selected').val();
        var contact = $("input[name=contact]").val();

        if (contact.length > 5) {
            $("input[name=contact]").focus();
            alert('联系人名称过长~不能超过4个字节！');
        }
        var contact_phone = $("input[name=contact_phone]").val();
        var remark = $("textarea[name=remark]").val();
        var quote = $("input[name=quote]").val();
        if (!item_id) {
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
        YunSpace.api('demand/offer/match/result/update.json', {
            offer_id: offer_id,
            demand_id: demand_id,
            result_id: result_id,
            item_id: item_id,
            offer_price: quote,
            offer_info: {
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
    },
    callServiceTel: function (_type) {

    },
    MyEditSubmit: function (e) {
        var people = $(".dmd-tend-my select[name=people]").find('option:selected').text();
        var activity_type = $(".dmd-tend-my select[name=activity_type]").find('option:selected').text();
        var price_up = $(".dmd-tend-my  input[name=price_up]").val();
        var price_down = $(".dmd-tend-my  input[name=price_down]").val();
        var tags_ids = new Array;

        $(".dmd-tend-my .icon-close-d").each(function () {
            var _Tid = $(this).attr('data-value');
            tags_ids[_Tid] = 1;
        });

        var demand_id = $(e).attr('demand-id');
        var offer_id = $(e).attr('offer-id');
        YunSpace.api('demand/offer/MyDemandOfferEdit.json', {
            people: people,
            offer_id: offer_id,
            demand_id: demand_id,
            activity_type: activity_type,
            price_up: price_up,
            price_down: price_down,
            tags_data: tags_ids
        }, function (data) {
            alert(data.msg);
            window.location.href = 'http://' + location.host + '/m/demand_offer/customer?demand_id=' + demand_id;

        });
    },
    CustomerUpdateStatus: function (type, status) {
        var offer_id = $(".js-data-offer").attr('data-offer-id');
        $('.js-pop-cont').fadeOut();
        $('.popup_bg').remove();
        if (status) {
            document.cookie = type + offer_id + 's=1';
        }
        YunSpace.api('demand/offer/customer/waiting/update.json', {
            offer_id: offer_id,
            type: type,
            waiting_time: status ? '' : -1
        }, function (data) {
            window.location.replace(location.href);
        });

    },
    goEdit: function (type, status) {

        var demand_id = $(".js-noScheme").attr('data-demand-id');
        if (status) {
            document.cookie = type + demand_id + 's=1';
        }
        window.open('?action=demand_edit&demand_id=' + demand_id);
    }
};