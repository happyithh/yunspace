/**
 * Created by Administrator on 2016/5/12.
 *
 * 审核拒绝
 */
$(".reject").click(function(){
    var id = $(this).data('reject-id');
    var rejectReason = $(".rejectReason").val();
    var url =  $(this).data('re-url');
    //if(rejectReason=''){
    //    alert('请填写拒绝理由！');
    //    return false;
    //}
    YunSpace.api('winchance/new/ip/check/submit.jsonp', {
        id: id,
        rejectReason: rejectReason
    }, function (data) {
        if (data.status == 1) {
            alert(data.msg);
            window.location.href = url;
        } else {
            top.alert(data.msg);
        }
    });
});
