$(document).ready(function () {
    $('.search-input').focus(function () {
        $('.search_dropdown').show();
    });
    $('.search-input').blur(function () {
        $('.search_dropdown').hide();
    });
    $('.search_dropdown li').hover(function () {
        $('.search-input:text').val($(this).text());
    });

    //$('.weixin-title a').click(function(){
    //    $('.weixin').toggle();
    //    $('.dayer1').toggle();
    //});
    //$('.close_icon').click(function(){
    //    $('.weixin').hide();
    //    $('.dayer1').hide();
    //});
    //$('.dayer1').click(function(){
    //    $('.weixin').hide();
    //    $(this).hide();
    //});
    //$(".log-outside").hover(function () {
    //    $(".log-operate").stop().slideDown();
    //}, function () {
    //    $(".log-operate").stop().slideUp();
    //});


    //导航条处的登录注册
    var log_ustat_src = $('.log-outside').attr('yun-src');
    if(log_ustat_src){
        $.get(log_ustat_src, function (data) {
            if (data) {
                $(data).appendTo('.log-outside');
            }
        });
    }


    $('.guide_mobile_outside .guide_mobile').html($('.guide4_left').html());


    $('.mobile_search').bind('click', function (event) {
        $('.search').slideToggle('fast');
        $('.guide_mobile_outside').hide();
        $('.log-outside').hide();
        $('.dayer_one').slideToggle('fast');

    });
    $('.mobile_list').bind('click', function (event) {
        $('.guide_mobile_outside').slideToggle('fast');
        $('.log-outside').toggle();
        $('.search').hide();
        $('.dayer_one').slideToggle('fast');
        isShowMask()
    });
    $('.dayer_one').bind('click', function (event) {
        $('.search').hide();
        $('.guide_mobile_outside').hide();
        $(this).fadeOut();
    });

    $(".search-btna").click(function () {
        var city = $(".search-city option:selected").val();
        var type = $(".search-type option:selected").val();
        var size = $(".search-size option:selected").val();
        document.cookie = "city=" + city;
        location.href = "/space/" + type + "?&size_range=" + size;
    });
    changeType($('#header-select'));

    //我要办活动验证码显示/隐藏
    $(".js-formoninput").on("input propertychange",function(){
        var phone = $("input[name='phone']").val();
        //console.log(phone);
        if(phone.match(/^(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$/)&&phone.length==11){
            $(".look-more").slideDown();
        }else{
            $(".look-more").slideUp();
        }
    });

});

function changeCity(o) {
    window.location = '{$_root}?df_city=' + $(o).val() + '&t=' + (new Date()).valueOf() + '&url_back=' + window.location.href;
}



function searchSubmit(mode) {
    $('#top_search input[name=mode]').val(mode);
    $('#top_search').submit();
}

function changeType(t) {
    var mode = $(t).val();
    var url = "/" + mode + "?{$filter_string}";
    $('#myform').attr('action', url);
}
