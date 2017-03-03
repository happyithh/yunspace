/**
 * Created by Administrator on 2016/5/13.
 */

//删除IP
$(".ip_delete").click(function () {
    var name = $(this).data('name');
    if (confirm('你确定要删除【' + name + '】的IP吗?')) {
        var ip_id = $(this).data('id');
        var check_id = $(this).data('check-id');
        $.ajax({
            cache: true,
            type: "get",
            url: '?action=delete',
            data: {id: ip_id,check_id:check_id},// 你的formid
            async: false,
            success: function (data) {
                if (data.status == 1) {
                    history.go(0);
                } else {
                    alert(data.msg);
                }
            }
        });
    } else {
        return false;
    }

});

// 删除形象
$(".figure_delete").click(function () {
    var name = $(this).data('name');
    if (confirm('你确定要删除【' + name + '】吗?')) {
        var figure_id = $(this).data('id');
        $.ajax({
            cache: true,
            type: "POST",
            url: '?action=figureDelete',
            data: {id: figure_id},// 你的formid
            async: false,
            success: function (data) {
                if (data.status == 1) {
                    history.go(0);
                } else {
                    alert(data.msg);
                }
            }
        });
    } else {
        return false;
    }

});

// 删除公司
$(".company_delete").click(function () {
    var name = $(this).data('name');
    if (confirm('你确定要删除【' + name + '】吗?')) {
        var company_id = $(this).data('id');
        $.ajax({
            cache: true,
            type: "POST",
            url: '?action=companyDelete',
            data: {id: company_id,company:name},// 你的formid
            async: false,
            success: function (data) {
                if (data.status == 1) {
                    history.go(0);
                } else {
                    alert(data.msg);
                }
            }
        });
    } else {
        return false;
    }
});

