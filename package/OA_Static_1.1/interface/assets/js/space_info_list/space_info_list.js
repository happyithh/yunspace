/**
 * Created by zzc on 2015/8/24.
 */
spaceInfo = {
    sapce_id: '',
    passSubmit: function (e) {
        this.space_id = $(e).parent('td').attr('data-id');
        if (!this.space_id) {
            top.alert('请刷新后重试');
            window.location.reload();
            return false;
        }
        $.ajax({
            url: "?",
            type: 'get',
            dataType: 'json',
            data: {
                action: 'audit',
                space_id: this.space_id
            }, success: function (data) {
                if (data.status == 1) {
                    window.location.href = '?&action=list';
                }
                top.alert(data.msg);
            }
        });
    },
    refuseClick: function (e) {
        this.space_id = $(e).parent('td').attr('data-id');
        if (!this.space_id) {
            top.alert('请刷新后重试');
            window.location.reload();
            return false;
        }
        $("#space_refuse").modal('toggle');

    },
    refuseSubmit: function (a, b) {
        var refuse_reason = '';
        $(a).each(function () {
            if ($(this).is(':checked')) {
                refuse_reason += $(this).val() + ',';
            }
        });
        refuse_reason += $(b).val();
        console.log(refuse_reason);
        $.ajax({
            url: "?",
            type: 'get',
            dataType: 'json',
            data: {
                action: 'ajaxSpaceRefuse',
                space_id: this.space_id,
                refuse_reason: refuse_reason
            }, success: function (data) {
                top.alert(data.msg);
                window.location.href = '?&action=list';
                $("#space_refuse").modal('toggle');
            }
        });
    }
};