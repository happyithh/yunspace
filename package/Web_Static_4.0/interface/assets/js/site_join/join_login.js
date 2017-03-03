/**
 * Created by Administrator on 2016/5/18.
 */
$(document).ready(function() {
    $("#featureCarousel").featureCarousel();
    if (localStorage.maste_phone){
        $('.phone').focus();
        $(".phone").val(localStorage.maste_phone);
        $('.rember').find('input').attr('checked','checked');
        //$('.remember').attr('checked','checked');
    }
    $('.pass_login').click(function(){
        $('.auth_login').removeClass('none');
        $('.pass_login_l').removeClass('none');
        $('.auth_login_l').addClass('none');
        $(this).addClass('none');
        $('.login_ways').val('pass_login');
    });
    $('.auth_login').click(function(){
        $('.pass_login').removeClass('none');
        $('.auth_login_l').removeClass('none');
        $('.pass_login_l').addClass('none');
        $(this).addClass('none');
        $('.login_ways').val('auth_login');
    });
    $('.phone').blur(function(){
        var phone = $('.phone').val();
        if (!phone||!isMobile(phone)) {
            error_msg_color();
            error_msg_show('请填写正确的手机号码');
            return false;
        }
        YunSpace.api('http://master.yunspace.com.cn/static/api/team/member/check/phone.jsonp',{
            phone: phone
        },function(data){
            if(data.status==0){
                alert('账户不存在，请申请创建');
                //error_msg_color();
                //error_msg_show('账户不存在，请申请创建');
                setTimeout(function(){
                    location_url(data.data)
                },1000);
                return false;
            }
        });
    });
    $('.send_code_btn').click(function(){
        var phone = $(".phone").val();
        //console.log(phone);
        if (!phone||!isMobile(phone)) {
            error_msg_color();
            error_msg_show('请填写正确的手机号码');
            return false;
        }
        var self =$(this);
        $(this).attr("disabled", 'true');
        var second = 60;
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
                self.hide();
                $("#yzm_captcha").show();
                $("#origin_yzm_captcha").remove();
            }
            if(self.attr("disabled")=="disabled"){
                self.css({
                    background:"#40e7f6"
                })
            }else{
                self.css({
                    background:"##3fc9d5"
                })
            }
        }, 1000);
            YunSpace.api('http://master.yunspace.com.cn/static/api/common/send/auth/code.jsonp',{
                phone: phone,
                geetest_challenge: $('.geetest_challenge').val(),
                geetest_validate: $('.geetest_validate').val(),
                geetest_seccode: $('.geetest_seccode').val()
            },function(data){
                if(data.status==1){
                    $(".login_error_msg").css({
                        color:"#3cc051"
                    })
                    error_msg_show(data.msg);
                }else{
                    error_msg_color();
                    error_msg_show(data.msg);
                    return false;
                }

                //setTimeout("$('.login_error_msg').css({ color:'red'})",4000);
            })
    });
    $(".login_btn").click(function(){
        var phone = $(".phone").val();
        var code = $(".auth_code").val();
        var login_ways = $(".login_ways").val();
        var password = $(".password").val();
        var check_val =0;
        if($(".rember input").is(':checked')){
            check_val=1;
        }
        if (!phone||!isMobile(phone)) {
            error_msg_color();
            error_msg_show('请填写正确的手机号码');
            return false;
        }
        if(login_ways=='auth_login'){
            if(!code||code.length!=6||!isNum(code)){
                error_msg_color();
                error_msg_show('请输入正确的验证码');
                return false;
            }
        }
        if(login_ways=='pass_login'){
            if(!password||!password_length(password)){
                error_msg_color();
                error_msg_show('密码至少6个字符');
                return false;
            }
        }
        //if(login_ways=='pass_login'&&password&&){
        //    error_msg_show('密码长度不能小于6位大于18位');
        //    return false;
        //}
        if(check_val){
            localStorage.maste_phone=phone;
        }
        YunSpace.api('http://master.yunspace.com.cn/static/api/team/member/login.jsonp',{
            phone: phone,
            auth_code:code,
            login_ways:login_ways,
            password:password
        },function(data){
            if(data.status==1){
                if(data.msg){
                    alert('登录成功');
                }
                //console.log(data);
                window.location.href='http://master.yunspace.com.cn/';
            }
            if(data.status==0){
                //console.log(data);
                error_msg_color();
                error_msg_show(data.msg);
                return false;
            }
        })
    });
});
function error_msg_color(){
    $(".login_error_msg").css({
        color:"red"
    })
}
function location_url(url){
    window.location.href=url;
}
function error_msg_show(msg){
    //$(".login_error_msg").removeClass('msg_none');
    $(".error-block").removeClass('none');
    $(".login_error_msg").html(msg);
    setTimeout("$('.error-block').addClass('none')",3000);
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
function password_length(password){
    if(password.length<6){
        return false;
    }else{
        return true;
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