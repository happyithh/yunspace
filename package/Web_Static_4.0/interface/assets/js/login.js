/**
 * Created by Administrator on 2016/1/7.
 */
$(document).ready(function(){
    $("#login_user").on("click",function(){
        $(".person-code-img-one").hide();
        $(".log-cont").fadeIn();
        $(".cover-one").fadeIn();
        var ml=$(".person-code-one").outerWidth();
        $(".person-code-one").css({marginLeft:"-"+ml/2+"px"});
        $(".person-code-one").slideDown();
        $(".log-cont").addClass('active');
    });
    $(".person-code-close-one,.cover-one").on("click",function(){
        $(".cover-one,.person-code-one,.log-cont").hide();
        $(".log-cont").removeClass('active');
    });
    $('.sendcode-btn').click(function(){
        var phone = $("#phone").val();
        if (!phone||!isMobile(phone)) {
            error_msg_show('请填写正确的手机号码');
            return false;
        }
        var self =$(this);
        $(this).attr("disabled", 'true');
        var second = 60;
        var urlPath = "common/send/auth/code.jsonp";
        var setTime = setInterval(function (e) {
            self.attr("disabled", 'true');
            second--;
            var info = "重新发送(" + second + ")";
            self.text(info);
            //if($(".modal").length!=0&&!$(".modal").hasClass("in")&& $(this).modal!=undefined&& $(this).modal==true){
            //    clearInterval(setTime);
            //    second=second;
            //    $(".sendcode-btn").text("重新发送");
            //    $(".modal").find("input").val("");
            //}
            if (second < 1) {
                info = "重新发送";
                self.text(info);
                clearInterval(setTime);
                self.removeAttr("disabled");
            }
            if(self.attr("disabled")=="disabled"){
                self.css({
                    background:"#f0f0f0",
                    color:"#999"
                })
            }else{
                self.css({
                    background:"#6a96ef",
                    color:"#fff"
                })
            }
        }, 1000);
        YunSpace.api(urlPath,{
            phone: phone,
            geetest_challenge: $('.geetest_challenge').val(),
            geetest_validate: $('.geetest_validate').val(),
            geetest_seccode: $('.geetest_seccode').val()
        },function(data){
            if(data.status==1){
                $(".login_error_msg").css({
                    color:"#3cc051"
                })
            }
            error_msg_show(data.msg);
            setTimeout("$('.login_error_msg').css({ color:'red'})",4000);
        })
    });
    $(".logreg-btn").click(function(){
        var phone = $("#phone").val();
        var code = $("#code").val();
        var ipt_check = $(".ipt-check");
        if(!ipt_check.is(':checked')) {
            error_msg_show('请选择同意《云SPACE通行证注册协议》');
            return false;
        }

        if (!phone||!isMobile(phone)) {
            error_msg_show('请填写正确的手机号码');
            return false;
        }
        if(!code||code.length!=6||!isNum(code)){
            error_msg_show('请输入正确的验证码');
            return false;
        }
        YunSpace.api('account/login.jsonp',{
            phone: phone,
            auth_code:code,
            from:-6,
            new_login:1
        },function(data){
            if(data.status==1){
                $(".login_error_msg").css({
                    color:"#3cc051"
                })
                error_msg_show('登录成功');
                var login_in = '<a href="javascript:;" class="yun-icon icon-2">'+data.data.username+'</a>';
                var login_out = '<a href="/user_center/user_admin/logout" style="padding: 0">退出</a>';
                $('.login_user').after(login_out);
                $('.login_user').after(login_in);
                $('.login_user').remove();
                $('.cover-one,.person-code-one').fadeOut(500);
                $(".log-cont").removeClass('active');
            }
            if(data.status==0){
                error_msg_show(data.msg);
                return false;
            }
            //console.log(data.msg);
        })
    });
    YunSpace.api('common/ustatus.jsonp','',function(data){
        if(data.status==1){
            var login_in = '<a href="javascript:;" class="yun-icon icon-2">'+data.data.username+'</a>';
            var login_out = '<a href="/user_center/user_admin/logout" style="padding: 0;float: right;">退出</a>';
            $('.login_user').after(login_in);
            $('.login_user').after(login_out);
            $('.login_user').remove();
        }
        if(data.status==0){
            $('.login_user').html('登录/注册');
        }
    })
});
function error_msg_show(msg){
    $(".login_error_msg").removeClass('none');
    $(".login_error_msg").html(msg);
    setTimeout("$('.login_error_msg').addClass('none')",3000);
    //return false;
}
function isMobile(phone){
    if(phone==null)return false;
    var exp= /^(0|86|17951)?(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$/;
    if(exp.test(phone)){
        return true;
    }else{
        return false;
    }

}
function isNum(code){
    var exp= /^\d+$/;
    if(exp.test(code)){
        return true;
    }else{
        return false;
    }
}