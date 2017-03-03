/**
 * Created by Administrator on 2016/5/12.
 *
 * 更换负责人
 */
function changeAdmin(e){
    var admin = $(e).val();
    var id = $(e).data('id');
    var type = $(e).data('type');
    var check_id = $(e).data('check-id');
    if(confirm('确定要更换负责人？')){
        YunSpace.api('winchance/new/ip/change/admin.jsonp', {
            id: id,
            admin: admin,
            type:type,
            check_id:check_id
        }, function (data) {
            if (data.status == 1) {
                alert(data.msg);
                history.go(0);
            } else {
                top.alert(data.msg);
            }
        });
    }else{
        return false;
    }

}
