/**
 * Created by Alex Shen on 2015/7/16.
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
    //手机号输入框失去焦点时，验证手机号并向后台发送用户验证请求
    $("#js-phone-num").blur(function(){
        var num = $(this).val();
        var phone = $(this);
        if(verifyPhone(num)){
            $.ajax({
                type:'post',
                url:$(this).attr("data-url"),
                data:{
                    tel:num
                },
                success:function(data){
                    if(data.code=='error'){
                        phone.attr("data-is-ready","false");
                        phone.removeClass("correct").addClass("error");
                        $(".js-info-phone").addClass("active");
                        $(".js-info-phone p").text("该用户不存在!");
                        $(".js-info-phone p").removeClass().addClass("error");
                        $(".js-send").attr("disabled",true);
                        $(".js-next-step").attr("disabled",true);
                    }else{
                        phone.attr("data-is-ready","true");
                        phone.removeClass("error").addClass("correct");
                        $(".js-send").attr("disabled",false);
                        $(".js-info-phone").removeClass("active");
                        $(".js-info-phone p").text("");
                        $(".js-info-phone p").removeClass().addClass("correct");
                    }
                    refreshNextStepButton();
                },
                error:function(data){
                    phone.attr("data-is-ready","false");
                    phone.removeClass("correct").addClass("error");
                    $(".js-info-phone").addClass("active");
                    $(".js-info-phone p").text("未知错误!");
                    $(".js-info-phone p").removeClass().addClass("error");
                    $(".js-send").attr("disabled",true);
                    refreshNextStepButton();
                },
                dataType:'json'
            });
        }else{
            phone.removeClass("correct").addClass("error");
            $(this).attr("data-is-ready","false");
            $(".js-send").attr("disabled",true);
        }
        refreshNextStepButton();
        return;
    });
    //验证码输入框失去焦点时，向服务请求验证码的正确性
    $("#js-verify-code").blur(function(){
        var code=$(this).val();
        var verify = $(this);
        if(!$("#js-phone-num").val()){
            $(this).attr("data-is-ready","false");
            refreshNextStepButton();
            return false;
        }
        if(!code){
            $(this).attr("data-is-ready","false");
            refreshNextStepButton();
            return false;
        }
        $.ajax({
            type: 'post',
            url:$(this).attr("data-url"),
            data:{
                "code":code
            },
            success:function(data){
                if(data.msg==='验证失败'){
                    verify.attr("data-is-ready","false");
                    verify.removeClass("correct").addClass("error");
                    $(".js-info-code").addClass("active");
                    $(".js-info-code p").text("验证码错误!");
                    $(".js-info-code p").removeClass().addClass("error");
                }else{
                    verify.attr("data-is-ready","true");
                    verify.removeClass("error").addClass("correct");
                    $(".js-info-code").removeClass("active");
                    $(".js-info-code p").text("");
                    $(".js-info-code p").removeClass().addClass("correct");
                }
                refreshNextStepButton();
            },
            error:function(data){
                verify.attr("data-is-ready","false");
                refreshNextStepButton();
            },
            dataType:'json'
        })
    });
    //点击下一步，并向后台提交验证码和手机号并验证
    $(".js-next-step").click(function(){
        var tel = $("#js-phone-num").val();
        var code = $("#js-verify-code").val();
        $.ajax({
            type: 'post',
            url:$(this).attr("data-url"),
            data: {
                phone: tel,
                code: code
            },
            success: function (data) {
                $(".js-icon2-arrow").addClass("active");
                $(".js-icon2-p").removeClass("icon2").addClass("icon2-act");
                $(".js-icon2-p p").addClass("active");
                $(".js-nav-tab-verify").removeClass("active");
                $(".js-nav-tab-finish").addClass("active");
            },
            dataType: 'json'
        })
    });
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
    //新密码输入框失去焦点时，验证密码格式
    $(".js-new-pass-word").blur(function(){
        var pass = $(this).val();
        if(pass === ""){
            $(this).removeClass("correct").removeClass("error");
            $(".js-info-new-pass").removeClass("active");
            $(".js-info-new-pass p").removeClass();
            $(this).attr("data-is-ready","false");
            resetSubmitChgPass();
            return;
        }
        if( ($(".js-repeat-pass-word").attr("data-is-ready") === "true")&&(pass !== $(".js-repeat-pass-word").val())){
            $(".js-repeat-pass-word").attr("data-is-ready","false");
            $(".js-info-repeat-pass").addClass("active");
            $(".js-repeat-pass-word").removeClass("correct").addClass("error");
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
            result["msg"]="";
            $(".js-info-new-pass p").removeClass().addClass("correct");
        }
        $(".js-info-new-pass p").text(result["msg"]);
        resetSubmitChgPass();
    });
    //重复新密码失去焦点时，验证两次输入的密码是否一致
    $(".js-repeat-pass-word").blur(function(){
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
                $(this).removeClass("correct").addClass("error");
                $(this).attr("data-is-ready","false");
                $(".js-info-repeat-pass").addClass("active");
                $(".js-info-repeat-pass p").text("两次输入的密码不一致").removeClass().addClass("error");
            }else{
                $(this).removeClass("error").addClass("correct");
                $(this).attr("data-is-ready","true");
                $(".js-info-repeat-pass").removeClass("active");
                $(".js-info-repeat-pass p").text("").removeClass().addClass("correct");
            }
        }
        resetSubmitChgPass();
    });
    //重置完成密码修改是否可以点击的状态
    function refreshNextStepButton(){
        if(($("#js-phone-num").attr("data-is-ready") === "true")&&($("#js-verify-code").attr("data-is-ready") === "true")){
            $(".js-next-step").attr("disabled",false);
        }else{
            $(".js-next-step").attr("disabled",true);
        }
    }
    //重置完成密码修改是否可以点击的状态
    function resetSubmitChgPass(){
        if(($(".js-new-pass-word").attr("data-is-ready") === "true")&&($(".js-repeat-pass-word").attr("data-is-ready") === "true")){
            $(".js-finish").attr("disabled",false);
        }else{
            $(".js-finish").attr("disabled",true);
        }
    }
});