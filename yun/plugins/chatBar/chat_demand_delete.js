/**
 * Created by Administrator on 2015/8/10.
 */
var plugin = {
    cate: 'space',
    demand_id: '',
    demandDeleteDemo: function (element, args) {
        this.demand_id = args['demand-id'];
        $(".cover").fadeIn(400);
        $(".demand-take-look").fadeIn(400);

    },
    demandDeleteDemoSubmit: function (element, args) {
        var look_remark = $(".take-look-remark").val();
    var demo = $("select[name=take-look-month]").find('option:selected').text();
        YunSpace.api('demand/delete.jsonp', {
            demand_id: this.demand_id,
            reason: look_remark,
            demo: demo
        }, function (data) {
            /*if (data.status == 1) {
             $('.js-close').click();
             } else {
             alert(data.msg);
             }*/
            if (data.status == 1) {
                location.href = 'chat_demand';
            } else {
                alert(data.msg);
            }
        });
    }
}