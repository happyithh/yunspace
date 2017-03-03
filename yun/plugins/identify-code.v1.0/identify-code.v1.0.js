/**
 * Created by Administrator on 2015/6/24.
 */
yun('global/jquery-1.9.1.min.js');
var plugin = {
    /*
     * 发送验证码
     * ele  绑定插件的元素
     * args.phone 存储手机号的输入框dom
     * args.second 倒计时间（秒）
     * callback 回调函数
     * */
    sendCode: function (ele, args, callback) {
        //if($(ele).text()=='重新发送'){
        //    window.location.reload();
        //}
        var phone = $(args.phone).val();
        if (!phone||!isMobile(phone)) {
            //if($(ele).hasClass('rend_space')){
            //    alert('手机号码不正确!!')
            //}
            alert('手机号码不正确!!')
            return false;
        }
        if($(args.phone).hasClass("error")){
            return false;
        }
        $(ele).attr("disabled", true);
        var second = args.second||60;
        var urlPath = args.url||"common/send/auth/code.jsonp";
        var setTime = setInterval(function (e) {
            $(ele).attr("disabled", true);
            second--;
            var info = "重新发送(" + second + ")";
            $(ele).text(info);
            if($(".modal").length!=0&&!$(".modal").hasClass("in")&&args.modal!=undefined&&args.modal==true){
                clearInterval(setTime);
                second=args.second;
                $(".send-code").text("重新发送");
                $(".modal").find("input").val("");
            }
            if (second < 1) {
                info = "重新发送";
                $(ele).text(info);
                clearInterval(setTime);
                $("#yzm_captcha").show();
                $(ele).attr("disabled", false);
                $(ele).hide();
                $(".yzm-ipt").hide();
            }
            if($(ele).attr("disabled")=="disabled"){
                $(ele).css({
                    background:"#e0e0e0"
                })
            }else{
                $(ele).css({
                    background:"#f36f25"
                })
            }
        }, 1000);
        YunSpace.api(urlPath,{
            phone: phone,
            //auth_code_img: ''
            geetest_challenge: $('.geetest_challenge').val(),
            geetest_validate: $('.geetest_validate').val(),
            geetest_seccode: $('.geetest_seccode').val()
        },function(data){
            console.log(data.msg);
        })
        //$.ajax({
        //    type: 'post',
        //    url: urlPath,
        //    dataType: 'json',
        //    data: {
        //        phone: phone,
        //        auth_code_img: ''
        //    },
        //    success: function (data) {
        //        console.log(data.msg);
        //    },
        //    error:function (XMLHttpRequest, textStatus, errorThrown) {
        //        console.log(XMLHttpRequest);
        //        console.log(textStatus);
        //        console.log(errorThrown);
        //        console.log(XMLHttpRequest.responseText);
        //    }
        //})
    }
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