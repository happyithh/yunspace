/**
 * Created by Alex Shen on 2015/5/27.
 */
$(document).ready(function(){
    //首页焦点图控制
    var indexSwiper = new Swiper('.image-content-area .swiper-container', {
        pagination: '.image-content-area .swiper-pagination',
        direction: 'horizontal',
        paginationClickable: true,
        calculateHeight: true,
        speed: 600,
        loop: true,
        autoplay: 8000
    });

    //套餐页焦点图控制
    var packageSwiper = new Swiper('.panel-package .swiper-container', {
        speed: 600,
        loop: true,
        direction: 'vertical'
    });
    //套餐页焦点图高度重置
    $(".panel-package .swiper-container").height($(".panel-package").height() - 50);

    //这里需要在第一次加载的时候发送一次http请求得到界面模板
    //一次请求后，模板便存入到缓存中，之后的用户操作则不需要重新加载
    //这里的30来源于popup窗口的左右内边距之和，80则是按照一个字15px来计算，至多5个字也就是75px,另外的5px用于静态文字和输入框之间的距离补差
    var inputWidth = $(".popup-submit-requirement").width() - 30 - 80;
    $(".popup-submit-requirement .content").width(inputWidth);
    $(".popup-submit-requirement .larger-content").width(inputWidth);

    $(".city").bind("change",function(){
        window.location = '?df_city=' + $(this).val() + '&t=' + (new Date()).valueOf() + '&url_back=' + window.location.href;
    });
});
//弹出供应商加盟popup
function popupVendorJoin(obj) {
    window.event.preventDefault(window.event);
    $("body").addClass("active");
    $(".maskLayer").addClass("active");
    //这里需要在第一次加载的时候发送一次http请求得到界面模板
    //一次请求后，模板便存入到缓存中，之后的用户操作则不需要重新加载
    $(".popup-vendor-join").addClass("active");
    //TODO 这里使用touch仅仅是做了一个尝试，之后会根据实际情况来决定是否启用touch事件来代替click
    $(".popup-vendor-join .popup-title>div")[0].addEventListener("touchstart", clearPopupVendorJoin);
    return false;
}
function clearPopupVendorJoin() {
    window.event.preventDefault(window.event);
    $("body").removeClass("active");
    $(".maskLayer").removeClass("active");
    $(".popup-vendor-join").removeClass("active");
}
//弹出提交需求popup
function popupSubmitRequirement(obj) {
    window.event.preventDefault(window.event);
    $("body").addClass("active");
    $(".maskLayer").addClass("active");
    $(".popup-submit-requirement").addClass("active");
}
function clearPopupSubmitRequirement() {
    window.event.preventDefault(window.event);
    $("body").removeClass("active");
    $(".maskLayer").removeClass("active");
    $(".popup-submit-requirement").removeClass("active");
}

//打开超值套餐
//TODO 这里因为正式的样式还没有给到，因此暂时不做特殊处理
function openLeftPackagePanel(obj) {
    window.event.preventDefault(window.event);
    $(".panel-package").addClass("active");
    $(".fixed-phone-button").show();
}
//关闭面板
function closePanel(target){
    $(".panel-"+target).removeClass("active");
    $(".fixed-phone-button").hide();
}