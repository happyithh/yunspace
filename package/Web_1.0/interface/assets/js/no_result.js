/**
 * Created by Administrator on 2015/9/17.
 */

$(document).ready(function () {
    $(".submit_btn").on('click',function(){
        var contact_name=$("input[name='username']").val();
        if(!contact_name){
            var msg = "请填写您的称呼";
            $(".error_msg").show();
            $("#error").html(msg);
            return false;
        }
        var contact_phone=$("input[name='phone']").val();
        if(!contact_phone){
            var msg = "请填写您的手机号码";
            $(".error_msg").show();
            $("#error").html(msg);
            return false;
        }
        var content=$("#select-person").find("option:selected").text();
        var demand_style=$("#select-activity").find("option:selected").text();
        var  demand_city =  $("#select-city").find("option:selected").text();
        var  demand_other = 0;
        if($("#demand_other").is(":checked")){
            demand_other = 1;
        }
        YunSpace.api('demand/create.jsonp', {
            demand_city: demand_city,
            people: content,
            username: contact_name,
            phone: contact_phone,
            content: demand_style+'--'+content,
            demand_style:demand_style,
            demand_other:demand_other,
            action: 'events'
        }, function (data) {
            if (data.status == 1) {
                alert(data.msg);
                location.reload()
            }else{
                alert(data.msg);
            }
        });
    });
});