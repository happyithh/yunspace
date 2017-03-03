/**
 * Created by zzc on 2015/12/14.
 */
operation = {
    grabSingle: function (e) {
        //抢单
        var id = $(e).attr('data-id');

        YunSpace.api('grab/order/grabSingle.json', {
            id: id
        }, function (data) {
            if (data.status == 1) {
                alert(data.msg);
                location.href = "?type=B&action=detail&id=" + id;
            } else {
                alert(data.msg);
            }
        })
    },
    recordSubmit: function (e) {
        if (!confirm('确定提交进度？')) return false;
        //联系记录提交
        var id = $(e).attr('data-id');
        var _step = $("#record_step").find("option:selected").val();
        if (_step == $("#record_step").attr('data-value')) {
            alert('不可以修改~');
            return false;
        }
        $(e).attr("disabled", true).css({
            'background-color': '#ccc'
        });
        setTimeout(function () {
            $(e).attr('disabled', false).css({
                'background-color': 'rgb(241, 83, 83)'
            });
        }, 10000);
        var _conent = $("#record_content").val();
        YunSpace.api('grab/order/update/step/record.json', {
            id: id,
            step: _step,
            content: _conent
        }, function (data) {
            if (data.status == 1) {
                location.reload();
            } else {
                alert(data.msg);
            }

        });
    }, needsEditSubmit: function (e) {
        if (!confirm('请确认您修改的内容无误！')) {
            return false;
        }
        var people = $(".activity-needs-list select[name=people]").find('option:selected').text();
        var price_up = $(".activity-needs-list  input[name=price_up]").val();
        var price_down = $(".activity-needs-list  input[name=price_down]").val();
        var start_time = $(".activity-needs-list input[name=time_a]").val();
        var end_time = $(".activity-needs-list input[name=time_b]").val();
        var mark = $(".activity-needs-list textarea[name=mark]").val();
        var city = $(".activity-needs-list select[name=city]").find('option:selected').text();
        if (!mark) {
            alert('请填写具体要求！');
            return false;
        }
        var _id = $(e).attr('data-id');
        YunSpace.api('grab/order/needsEdit.json', {
            people: people,
            id: _id,
            price_up: price_up,
            price_down: price_down,
            start_time: start_time,
            end_time: end_time,
            city: city,
            mark: mark
        }, function (data) {
            alert(data.msg);
            window.location.href = "?type=B&action=detail&id=" + _id;
        });
    },
    createNeedsOrderSubmit: function (e, type) {

        var city = $("#grab_order select[name=city]").find('option:selected').val();
        var contact_phone = $("#grab_order input[name=contact_phone]").val();
        var checkPhone = /^(0|86|17951)?(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$/;

        if (!checkPhone.test(contact_phone)) {
            alert('请正确填写手机号！');
            $("#grab_order input[name=contact_phone]").focus();
            return false;
        }
        var contact = $("#grab_order input[name=contact]").val();
        if (!contact) {
            alert('请填写联系人！');
            $("#grab_order input[name=contact]").focus();
            return false;
        }
        var start_time = $("#grab_order input[name=start_time]").val();
        if (!start_time) {
            alert('请填写开始时间!');
            $("#grab_order input[name=start_time]").focus();
            return false;
        }
        var end_time = $("#grab_order input[name=end_time]").val();
        if (!end_time) {
            alert('请填写结束时间!');
            $("#grab_order input[name=end_time]").focus();
            return false;
        }
        var price_up = $("#grab_order input[name=price_up]").val();
        if (!price_up) {

            $("#grab_order input[name=price_up]").focus();
            alert('请填写预算！');
            return false;
        }
        var price_down = $("#grab_order input[name=price_down]").val();
        if (!price_down) {
            alert('请填写预算！');
            $("#grab_order input[name=price_down]").focus();
            return false;
        }

        var activity_type = $("#grab_order select[name=activity_type]").find('option:selected').val();

        var people = $("#grab_order select[name=people]").find('option:selected').val();
        var mark = $("#grab_order textarea[name=mark]").val();
        if (!mark) {
            alert('请填写具体要求！');
            $("#grab_order textarea[name=mark]").focus();
            return false;
        }
        $(e).attr("disabled", true).removeClass('fr');
        setTimeout(function () {
            $(e).attr('disabled', false).addClass('fr');
        }, 10000);

        //创建需求单
        YunSpace.api('demand/create.json', {
            demand: {
                联系人: contact,
                联系电话: contact_phone,
                开始时间: start_time,
                结束时间: end_time,
                price_up: price_up,
                price_down: price_down,
                活动人数: people,
                活动城市: city,
                活动类型: activity_type,
                具体要求: mark
            },
            phone: contact_phone,
            create_type: type,
            action: 'grab_order_create'
        }, function (data) {

            alert(data.msg);
            if (data.status == 1) {
                window.location.href = window.location.host + '/m/grab_order?type=B&action=detail&id=' + data.data;
            }
        });
    },
    allotOrderSubmit: function (e) {
        var sale_people = $(e).find('option:selected').text();
        var sale_phone = $(e).find('option:selected').val();
        var demand_id = $(e).attr('data-value');
        if (!confirm('请确定要将此单分配给【' + sale_people + '】吗？')) {
            return false;
        }
        var checkPhone = /^(0|86|17951)?(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$/;

        if (!checkPhone.test(sale_phone)) {
            alert('【' + sale_people + '】的手机号没有正确填写！无法分配！');
            return false;
        }
        YunSpace.api('grab/order/allot.json', {
            demand_id: demand_id,
            sale_phone: sale_phone
        }, function (data) {
            alert(data.msg);
            if (data.status == 1) {
                $(e).parents('.grab-comn').fadeOut();
            }
        });


    }
}
;
