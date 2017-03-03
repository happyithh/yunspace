/**
 * Created by Alex Shen on 2015/7/15.
 */
$(document).ready(function(){
    //通过正则验证手机号的合法性
    function verifyPhone(num){
        if (num.length === 0) {
            $(".js-info-phone").addClass("active");
            $(".js-info-phone p").text("手机号不能为空!");
            $(".js-info-phone p").removeClass().addClass("error");
            return false;
        }
        if (num.length != 11) {
            $(".js-info-phone").addClass("active");
            $(".js-info-phone p").text("手机号码必须为十一位数字!");
            $(".js-info-phone p").removeClass().addClass("error");
            return false;
        }
        var myReg = /^((1[3|5|7|8]{1})+\d{9})$/;
        if (!myReg.test(num)) {
            $(".js-info-phone").addClass("active");
            $(".js-info-phone p").text(num+"并不是合法的手机号码!");
            $(".js-info-phone p").removeClass().addClass("error");
            return false;
        }
        return true;
    }
    //验证输入密码是否合法
    function verifyPass(pass){
        if (pass.length < 6) {
            return {
                result:"error",
                msg:"密码不能小于6位!"
            };
        }
        if (pass.length > 18) {
            return {
                result:"error",
                msg:"密码不能超过18位!"
            };
        }
        var myReg = /^\w{6,18}$/;
        if (!myReg.test(pass)) {
            return {
                result:"error",
                msg:"密码必须由字母，数字，下滑线组成!"
            };
        }
        return {
            result:"success",
            msg:"密码格式正确"
        };
    }
    //更新 提交按钮是否可用
    function refreshSubmitButton(){
        if(
            ($(".js-username").attr("data-is-ready") === "true")&&
                //($(".js-mail").attr("data-is-ready") === "true")&&
            ($(".js-phone-num").attr("data-is-ready") === "true")&&
            ($(".js-verify-code").attr("data-is-ready") === "true")&&
            ($(".js-new-pass-word").attr("data-is-ready") === "true")&&
            ($(".js-repeat-pass-word").attr("data-is-ready") === "true")&&
            ($(".js-check-protocol").attr("data-is-ready") === "true")
        //($(".js-read").attr("data-is-ready") === "true")
        ){
            $(".js-btn-register").removeAttr("disabled");
        }else{
            $(".js-btn-register").attr("disabled",'disabled');
        }
        console.log($(".js-btn-register").attr("disabled"));
        if( $(".js-btn-register").attr("disabled")=="disabled"){
            console.log(1);
            $(".js-btn-register").css({
                background:"#e0e0e0"
            })
        }else{
            console.log(2);
            $(".js-btn-register").css({
                background:"#3bd5bb"
            })
        }
    }
    //更新 发送验证码按钮是否可用
    function refreshSendButton(){
        if($(".js-phone-num").attr("data-is-ready") === "true"){
            $(".js-send").removeAttr("disabled");
        }else{
            $(".js-send").attr("disabled",'disabled');
        }
    }
    //Todo 临时注释 可能会恢复
    //$(".js-mail").blur(function(){
    //    var mail = $(this).val();
    //    if(mail === ""){
    //        $(this).attr("data-is-ready","true");
    //        $(this).removeClass("error").addClass("correct");
    //        $(".js-info-phone").removeClass("active");
    //        $(".js-info-phone p").text("");
    //        $(".js-info-phone p").removeClass("error");
    //    }else{
    //        var mailReg = /^[A-Za-zd0-9]+([-_.][A-Za-zd0-9]+)*@([A-Za-zd0-9]+[-.])+[A-Za-zd]{2,5}$/;
    //        if(mailReg.test(mail)){
    //            $(this).removeClass("error").addClass("correct");
    //            $(this).attr("data-is-ready","true");
    //            $(".js-info-mail").removeClass("active");
    //            $(".js-info-mail p").text("");
    //            $(".js-info-mail p").removeClass("error");
    //        }else{
    //            $(this).removeClass("correct").addClass("error");
    //            $(this).addClass("active");
    //            $(this).attr("data-is-ready","true");
    //            $(".js-info-mail").addClass("active");
    //            $(".js-info-mail p").text("邮箱格式错误!");
    //            $(".js-info-mail p").addClass("error");
    //        }
    //    }
    //    refreshSubmitButton();
    //});
    $(".js-username").blur(usernameValidate);
    $(".js-username").keyup(usernameValidate);
    function usernameValidate(){
        var name = $(this).val();
        var userName = $(this);
        if((name.length < 2)||( 50 <= name.length)){
            $(this).attr("data-is-ready",'false');
            $(this).removeClass("correct").addClass("error");
            $(".js-info-name").addClass("active");
            $(".js-info-name p").text("用户名必须在2-50个字符内");
            $(".js-info-name p").removeClass().addClass("error");
        }else{
            $.ajax({
                type:'post',
                url:$(this).attr("data-url"),
                data:{
                    username:name
                },
                success:function(data){
                    if(data.status==0){
                        userName.attr("data-is-ready",'true');
                        userName.removeClass("error").addClass("correct");
                        $(".js-info-name").removeClass("active");
                        $(".js-info-name p").text("");
                        $(".js-info-name p").removeClass("error");
                    }else{
                        userName.attr("data-is-ready",'false');
                        userName.removeClass("correct").addClass("error");
                        $(".js-info-name").addClass("active");
                        $(".js-info-name p").text("该用户名已存在");
                        $(".js-info-name p").removeClass().addClass("error");
                    }
                    refreshSubmitButton();
                },
                error:function(data){
                    userName.attr("data-is-ready","false");
                    userName.removeClass("correct").addClass("error");
                    $(".js-info-name").addClass("active");
                    $(".js-info-name p").text("未知错误");
                    $(".js-info-name p").removeClass().addClass("error");
                    refreshSubmitButton();
                },
                dataType:'json'
            });
        }
    }
    $(".js-phone-num").blur(phoneValidate);
    $(".js-phone-num").keyup(phoneValidate);

    function phoneValidate(){
        var num = $(this).val();
        var phoneNum = $(this);
        if(verifyPhone(num)){
            $.ajax({
                type:'post',
                url:$(this).attr("data-url"),
                data:{
                    phone:num
                },
                success:function(data){
                    //这里借用了验证码输入时手机验证的方案，只不过逻辑正好相反
                    if(data.status==0){
                        phoneNum.attr("data-is-ready",'true');
                        phoneNum.removeClass("error").addClass("correct");
                        $(".js-info-phone").removeClass("active");
                        $(".js-info-phone p").text("");
                        $(".js-info-phone p").removeClass("error");
                        $(".js-send").attr("disabled",false).css({
                            background:"rgb(59, 213, 187)"
                        });
                    }else{
                        phoneNum.attr("data-is-ready",'false');
                        phoneNum.removeClass("correct").addClass("error");
                        $(".js-info-phone").addClass("active");
                        $(".js-info-phone p").text('');
                        //'手机号已经注册'+""<a href='http://"+window.location.host+"/user_center/login' style='color: #39d6bb;  font-weight: 600;text-decoration: underline;'>点击登录</a>&bnsq;&nbsq;
                        $("<div>"+"手机号已经注册:"+"<a href='http://"+window.location.host+"/user_center/login' style='color: #39d6bb;  font-weight: 600;text-decoration: underline;'>点击登录</a>"+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+"<a href='http://"+window.location.host+"/user_center/reset_password' style='color: #39d6bb;  font-weight: 600;text-decoration: underline;'>点击修改密码</a></div>").appendTo(".js-info-phone p");
                        $(".js-info-phone p").removeClass().addClass("error");
                        $(".js-send").attr("disabled",true).css({
                            background:"rgb(224, 224, 224"
                        });;
                    }
                    refreshSubmitButton();
                    refreshSendButton();
                },
                error:function(data){
                    phoneNum.attr("data-is-ready","false");
                    phoneNum.removeClass("correct").addClass("error");
                    $(".js-info-phone").addClass("active");
                    $(".js-info-phone p").text("未知错误");
                    $(".js-info-phone p").removeClass().addClass("error");
                    refreshSubmitButton();
                    refreshSendButton();
                },
                dataType:'json'
            });
        }else{
            refreshSubmitButton();
            refreshSendButton();
        }
        return;
    }
    //验证码输入框失去焦点时，向服务请求验证码的正确性
    $(".js-verify-code").blur(codeValidate);
    $(".js-verify-code").keyup(codeValidate);

    function codeValidate(){
        var verifyCode = $(this);
        var code=$(this).val();
        var phone = $(".js-phone-num").val();
        if(!phone){
            return false;
        }
        if(!code){
            return false;
        }
        $.ajax({
            type: 'post',
            url:$(this).attr("data-url"),
            data:{
                "phone":phone,
                "auth_code":code
            },
            success:function(data){
                if(data.status==0){
                    verifyCode.attr("data-is-ready","false");
                    verifyCode.removeClass("correct").addClass("error");
                    $(".js-info-code").addClass("active");
                    $(".js-info-code p").text("验证码错误!");
                    $(".js-info-code p").removeClass().addClass("error");
                }else{
                    verifyCode.attr("data-is-ready","true");
                    verifyCode.removeClass("error").addClass("correct");
                    $(".js-info-code").removeClass("active");
                    $(".js-info-code p").text('');
                    $(".js-info-code p").removeClass();
                }
                refreshSubmitButton();
            },
            error:function(data){
                verifyCode.attr("data-is-ready","false");
                verifyCode.removeClass("correct").addClass("error");
                $(".js-info-code").addClass("active");
                $(".js-info-code p").text("验证码错误!");
                $(".js-info-code p").removeClass().addClass("error");
                refreshSubmitButton();
            },
            dataType:'json'
        })
    }
    //新密码输入框失去焦点时，验证密码格式
    $(".js-new-pass-word").blur(passwordValidate);
    $(".js-new-pass-word").keyup(passwordValidate);
    function passwordValidate(){
        var pass = $(this).val();
        if(pass === ""){
            $(this).attr("data-is-ready","false");
            refreshSubmitButton();
            return;
        }
        if( ($(".js-repeat-pass-word").attr("data-is-ready") === "true")&&(pass !== $(".js-repeat-pass-word").val())){
            $(".js-repeat-pass-word").removeClass("correct").addClass("error");
            $(".js-repeat-pass-word").attr("data-is-ready","false");
            $(".js-info-repeat-pass").addClass("active");
            $(".js-info-repeat-pass p").text("两次输入的密码不一致").removeClass().addClass("error");
        }
        var result = verifyPass(pass);
        if(result["result"] === "error"){
            $(this).removeClass("correct").addClass("error");
            $(".js-info-new-pass").addClass("active");
            $(".js-info-new-pass p").removeClass().addClass("error");
            $(this).attr("data-is-ready","false");
        }else{
            $(this).removeClass("error").addClass("correct");
            $(this).attr("data-is-ready","true");
            $(".js-info-new-pass").removeClass("active");
            $(".js-info-new-pass p").removeClass("error");
            result["msg"] = "";
        }
        $(".js-info-new-pass p").text(result["msg"]);
        refreshSubmitButton();
    }
    //重复新密码失去焦点时，验证两次输入的密码是否一致
    $(".js-repeat-pass-word").blur(repassValidate);
    $(".js-repeat-pass-word").keyup(repassValidate);
    function repassValidate(){
        var rePass = $(this).val();
        if($(".js-new-pass-word").attr("data-is-ready") === "false"){
            $(this).attr("data-is-ready","false");
        }else{
            if(rePass === ""){
                $(this).attr("data-is-ready","false");
                $(this).removeClass("correct").addClass("error");
                $(".js-info-repeat-pass").addClass("active");
                $(".js-info-repeat-pass p").text("确认密码不能为空").removeClass().addClass("error");
            }else if(rePass !== $(".js-new-pass-word").val()){
                $(this).attr("data-is-ready","false");
                $(this).removeClass("correct").addClass("error");
                $(".js-info-repeat-pass").addClass("active");
                $(".js-info-repeat-pass p").text("两次输入的密码不一致").removeClass().addClass("error");
            }else{
                $(this).attr("data-is-ready","true");
                $(this).removeClass("error").addClass("correct");
                $(".js-info-repeat-pass").removeClass("active");
                $(".js-info-repeat-pass p").text("").removeClass("error");
            }
        }
        refreshSubmitButton();
    }
    //阅读协议checkbox值发生变化事件在此监听
    $("#tnc").change(function(){
        if($(this).is(":checked")){
            $(this).attr("data-is-ready","true");
        }else{
            $(this).attr("data-is-ready","false");
        }
        refreshSubmitButton();
    });
    $('form').submit(function () {
        //window.event.stopPropagation();
        //return true;
        if (!$('#tnc:checked').val()) {
            alert('请阅读并同意《云SPACE用户协议注册协议》');
            return false;
        } else {
            return true;
        }
    });
});