//验证手机号输入后，显示/隐藏验证码
$(function(){
    $(".js-oninput").on("input propertychange",function(){
        var phone = $("input[name='yearmeeting_phone']").val();
        //console.log(phone);
        if(phone.match(/^(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$/)&&phone.length==11){
            $(".look-more").slideDown();
        }else{
            $(".look-more").slideUp();
        }
    });
});