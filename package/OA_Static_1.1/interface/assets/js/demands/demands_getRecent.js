//获取最近需求记录
demand_recent = {
    getRecent: function (e, toAppend) {
        var phone = $(e).val();
        if (!phone) {
            top.alert('先输入电话号码');
            $(e).focus();
            return false;
        }
        $.ajax({
            url: '?',
            type: 'get',
            dataType: 'json',
            data: {
                'action': 'ajaxSelectRecentDemand',
                'phone': phone,
                'num': '10'
            },
            success: function (data) {
                if (data.status == 1) {
                    $(toAppend).html(data.data).fadeIn(500);
                } else {
                    $(toAppend).hide();
                    top.alert(data.msg);
                }
                updateFrameHeight();
            }
        })
    }
}