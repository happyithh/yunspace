$('#baike_m_brand_down').click(function(){
  $('#baike_m_brand_content').css('height','auto');
    $(this).hide();
    $("#baike_m_brand_up").show();
});

$('#baike_m_brand_up').click(function(){
    $('#baike_m_brand_content').css('height','6em');
    $(this).hide();
    $("#baike_m_brand_down").show();
});

$('#baike_m_facility_down').click(function(){
    $('.baike_m_icon').css('height','auto');
    $('#baike_m_icon_more').css('display','none');
    $(this).hide();
    $("#baike_m_facility_up").show();
});

$('#baike_m_facility_up').click(function(){
    $('.baike_m_icon').css('height','60px');
    $('#baike_m_icon_more').css('display','block');
    $(this).hide();
    $("#baike_m_facility_down").show();
});

$('#baike_m_brief_down').click(function(){
    $('#baike_m_brief_content').css('height','auto');
    $(this).hide();
    $("#baike_m_brief_up").show();
});

$('#baike_m_brief_up').click(function(){
    $('#baike_m_brief_content').css('height','6em');
    $(this).hide();
    $("#baike_m_brief_down").show();
});

//子空间底部分享
$('.js-share').on('click',function(){
    $('.share').addClass('shareOn');
    $('.share-bg').removeClass('hidden');
    $('.nav-point').hide();
});
$('.share-bg').on('click',function(){
    $('.share').removeClass('shareOn');
    $(this).addClass('hidden');
    $('.nav-point').show();
});


//场地类型弹窗

$('.con-kinds-li').on('click',function(){
    $('.show-select-list').fadeToggle(400);
    $('.icon-arrow').toggleClass('ion-arrow-up-b');
});
$(".show-select-li").on("click",function(){
    var t=$(this).find('span').text();
    $('.con-kinds-li .text').text(t);
    $('.show-select-list').fadeOut(400);
    $('.icon-arrow').removeClass('ion-arrow-up-b');
});

//select:function(ele,args,fn){
//    var id=args.select;
//    $(".cover1").fadeIn(400);
//    $(".show-select-list").eq(id).fadeIn(400);
//    $(".cover1").on("touchstart",function(){
//        $(".cover1").fadeOut(400);
//        $(".show-select-list").eq(id).fadeOut(400);
//    });
//    $(".show-select-list").eq(id).each(function(index,dom){
//        $(dom).find(".show-select-li").on("touchend",function(){
//            var t=$(this).text();
//            $(".cover1").trigger("touchstart");
//            $(ele).find(".select").val(t);
//        });
//    });
//}