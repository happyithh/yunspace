demand = {
    demand_id: '',
    step: '',
    getAdmin: function (e) {
        var phone = $(e).find('option:selected').val();
        var admin_id = $(e).find('option:selected').attr('data-admin-id');
        var demand_id = $(e).attr('id');
        var query = confirm('您确认您要将这个需求分配到这个销售吗？');
        if (!query) {
            return false;
        }
        YunSpace.api('grab/order/allot.jsonp', {
            action: 'allot_admin',
            demand_id: demand_id,
            sale_phone: phone
        }, function (data) {
            if (data.status == 1) {
                top.alert(data.msg);
                var adminUsername = $(e).find('option:selected').text();
                if (adminUsername != '分配负责人') {
                    $(e).parents('td').html('<a href="?search[admin_id]=' + admin_id + '">' + adminUsername + '</a>');
                }
            } else {
                top.alert(data.msg);
            }
        })
    },
//修改客户进度
    customerStepUpdate: function (o) {
        var step = $(o).data('value');
        var self = this;

        var id = $(o).data('id');
        /*console.log(id);*/
        self.demand_id = id;
        //  self.step = step;
        $(".demand_step option").each(function () {
            if ($(this).val() == step) {
                $(this).attr('selected', true);
            }
        });
    },
    demandStepReasonSubmit: function (e) {

        var reason = $(".step_reason").val();
        var step = $(".demand_step").find("option:selected").val();
        var _other = $("input[name=reason]:checked").val();
        if (_other == 2000) {
            reason = '其他：' + reason;
        } else {
            reason = reason + _other;
        }
        $.ajax({
            url: '?action=ajaxCustomerStepUpdate',
            type: 'get',
            data: {
                id: this.demand_id,
                step: step,
                reason: reason
            },
            dataType: 'json',
            success: function (data) {
                if (data.status == 1) {
                    $("#close_reason").modal("hide");
                    top.alert(data.msg);
                    window.location.reload();
                } else {
                    top.alert(data.msg);
                }

            }
        });
    },
    noticeAdmin: function (a) {
        var demand_id = $(a).data('ids');
        var sale_phone = $(a).data('phone');
        //console.log(account_id);
        $.ajax({
            url: '?action=ajaxNoticeAdmin',
            type: 'get',
            data: {
                demand_id: demand_id,
                sale_phone: sale_phone
            },
            dataType: 'json',
            success: function (data) {
                if (data.status == 1) {
                    top.alert(' ' + data.msg);
                }
            }
        })
    },
    demandStepRecord: function (d) {
        var demand_id = $(d).data('demand_id');
        $.ajax({
            url: '?action=ajaxGetStepRecord',
            type: 'post',
            data: {
                demand_id: demand_id
            },
            dataType: 'json',
            success: function (data) {
                if (data.status == 1) {
                    var htmls = '';
                    for (var k in data.data) {

                        //var k1=1;
                        var ks = k * 1 + 1;
                        htmls += '<b>' + ks + '</b> 、<span style="font-size: 13px;">操作人：' + data.data[k]['fullname'] + '</span>' +
                        '</br>联系记录：' + data.data[k]['days'] +
                        '</br>备注：' + data.data[k]['reason'] +
                        '</br></br>';
                    }
                    if (demand_id == data.data[0]['demand_id']) {
                        //alert(1)
                        var ele = $(d).next("div");
                        //var ela = $(d).prev('span');
                        ele.html('<span style="font-size: 13px;float: left;">联系记录：</span></br>' + htmls);
                        //ela.toggle();

                        if ($(d).text() == '展开联系记录↓') {
                            $(d).text('收起联系记录↑');
                            ele.show();
                        } else {
                            $(d).text('展开联系记录↓');
                            ele.hide();

                        }


                    }

                }
            }
        })
    }

}
