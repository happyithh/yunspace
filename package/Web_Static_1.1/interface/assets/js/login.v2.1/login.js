/**
 * Created by pzl on 15/8/25.
 */
$(".phone-login").on("click",function(){
    $(".login-method").first().removeClass("login-active");
    $(".login-method").eq(1).addClass("login-active");
});
$(".normal-login").on("click",function(){
    $(".login-method").eq(1).removeClass("login-active");
    $(".login-method").first().addClass("login-active");
});
