/**
 * Created by pzl on 15/8/26.
 */

function changeModel(ele){
    var id=ele.data("id");
    var me=ele.data("me");
    ele.on("click",function(){
        var w=$(".login-modal").eq(me);
        var s=$(".login-modal").eq(id);
        w.addClass("leave-modal");
        s.addClass("enter").addClass("login-modal-active");
        setTimeout(function(){
            w.removeClass("enter").removeClass("login-modal-active  leave-modal");
        },200);
    })
}
function init(){
    $(".login-modal").eq(1).addClass("enter").addClass("login-modal-active");
    $(".fast-send-code2").attr("disabled",true).css({
        background:"#e0e0e0"
    });
}
$(function(){
    var src;
    changeModel($(".phone-login"));
    changeModel($(".login-normal"));
    changeModel($(".login-normal2"));
    changeModel($(".register-fast"));
    $(".pre-booking").on("click",function(){
        var username=$("#user_stat").data("username")||null;
        src=$(this).data("href");
        if(username==null){
            $("input[name='url_back']").val(src);
            $(".cover-login").fadeIn(400);
            init();
        }else{
            window.location.href=src;

        }
    })
    $(".i-close,.cover-login").on("click",function(){
        $(".cover-login").fadeOut(400);
        $(".login-modal").removeClass("enter login-modal-active leave-modal")
    });
    $(".checkbox").on("click",function(){
        var span=$(this).find("span");
        span.toggleClass("ion-android-done");
        if(span.hasClass("ion-android-done")){
            $(this).parent().find(".agree-input").attr("checked",true);
        }else{
            $(this).parent().find(".agree-input").attr("checked",false);
        }
        if($(".agree-check").length>0&&$(".agree-check").parent().find(".agree-input").attr("checked")=="checked"){
            $(".free-register").attr("disabled",false);
            $(".free-register").css({
                background:"#3bd5bb"
            });
        }else{
            $(".free-register").attr("disabled",true);
            $(".free-register").css({
                background:"#e0e0e0"
            });
        }
    });

    //检测手机是否已经注册验证
    $(".fast-register1").on("keyup",phoneReged);
    $(".fast-register1").on("blur",phoneReged);
    $(".reg-name").on("keyup",nameReged);
    $(".reg-name").on("blur",nameReged);

    //判断名称是否注册
    function nameReged(){
        var url=$(this).data("url");
        var vv = $(this).val();
        var vn = $(this).attr("name");
        console.log(url);
        if(vv!=""){
            if(url!=undefined&&url!="") {
                YunSpace.api(url, {
                    username: vv
                }, function (data) {
                    console.log(data);
                    if (data.status == 1) {
                        $(".name-error").show();
                        $(".reg-name").addClass("error1");
                    } else {
                        $(".name-error").hide();
                        $(".reg-name").removeClass("error1");
                    }
                })
            }
        }
    }

    //判断手机是否注册
    function phoneReged(){
        var url=$(this).data("url");
        var vv = $(this).val();
        var vn = $(this).attr("name");
        //var ajax_err = $(this).data("ajax_error");
        //var json_obj = {};
        //json_obj[vn] = vv;
        if(isPhone(vv)){
            if(url!=undefined&&url!="") {
                YunSpace.api(url, {
                    phone: vv
                }, function (data) {
                    if (data.status == 1) {
                        $(".tip-ajax").show();
                        $(".fast-register1").addClass("error1");
                        $(".fast-send-code2").attr("disabled",true).css({
                            background:"#e0e0e0"
                        });
                        return false;
                    } else {
                        $(".tip-ajax").hide();
                        $(".fast-register1").removeClass("error1");
                        $(".fast-send-code2").attr("disabled",false).css({
                            background:"#77cfc1"
                        });
                        return true;
                    }
                })
            }
        }else{
            $(".tip-ajax").hide();
        }
    }
});






function isPhone(phone){
    if(!phone){
        return false;
    }
    var exp= /^(0|86|17951)?(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$/;
    if(phone.length=11&&exp.test(phone)){
        return true;
    }else{
        return false;
    }
}


