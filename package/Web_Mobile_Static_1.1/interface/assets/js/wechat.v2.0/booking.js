
$('.js-btn-copy').click(function(){
    $('.popup-copy').stop().fadeIn(800);
    setTimeout(function(){
        $('.popup-copy').stop().fadeOut(800)
    },1500);
});

$('.js-set-adress').on('click',function(){
    if($(this).find('.icon-setadress').hasClass('icon-s-ads2')){
        $('.icon-setadress').addClass('icon-s-ads1').removeClass('icon-s-ads2');
        $('.is_default').val(1);
    }else{
        $('.icon-setadress').addClass('icon-s-ads2').removeClass('icon-s-ads1');
        $('.is_default').val(0);
    }
});
$('.btn-dlt').on('click',function(){
    var address_id = $('.address_id').val();
    YunSpace.api('wechat/ticket/delete/address.jsonp', {
        address_id: address_id
    }, function (data) {
        if (data.status == 1) {
            top.alert(data.msg);
            window.location.href='manage_address';
        } else {
            top.alert(data.msg);
        }
    })
});
