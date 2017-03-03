/**
 * Created by zzc on 2015/8/24.
 */
vendorJoin = {
    vendor_join_id: '',
    passSubmit: function (e) {
        this.vendor_join_id = $(e).parent('td').attr('data-id');
        if (!this.vendor_join_id) {
            top.alert('请刷新后重试');
            window.location.reload();
            return false;
        }
        $.ajax({
            url: "?",
            type: 'get',
            dataType: 'json',
            data: {
                action: 'ajaxVendorJoinPass',
                vendor_join_id: this.vendor_join_id
            }, success: function (data) {
                if (data.status == 1) {
                    window.location.href = '?&action=list';
                }
                top.alert(data.msg);
            }
        });
    },
    refuseClick: function (e) {
        this.vendor_join_id = $(e).parent('td').attr('data-id');
        if (!this.vendor_join_id) {
            top.alert('请刷新后重试');
            window.location.reload();
            return false;
        }
        $("#vendor_join_refuse").modal('toggle');

    },
    refuseSubmit: function (a, b) {
        var refuse_reason = '';
        $(a).each(function () {
            if ($(this).is(':checked')) {
                refuse_reason += $(this).val() + ',';
            }
        });
        refuse_reason += $(b).val();
        $.ajax({
            url: "?",
            type: 'get',
            dataType: 'json',
            data: {
                action: 'ajaxVendorJoinRefuse',
                vendor_join_id: this.vendor_join_id,
                refuse_reason: refuse_reason
            }, success: function (data) {
                top.alert(data.msg);
                window.location.href = '?&action=list';
                $("#vendor_join_refuse").modal('toggle');
            }
        });
    }
};