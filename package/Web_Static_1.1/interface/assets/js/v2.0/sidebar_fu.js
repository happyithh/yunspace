//网站右边悬浮
$(function () {
    //二维码变色
    $('.sidebar-fu .code').hover(function () {
        $(this).find('.img-write').stop().hide();
        $(this).find('.img-green').stop().show(300);
    }, function () {
        $(this).find('.img-write').stop().show(300);
        $(this).find('.img-green').stop().hide();
    });


    $('.sidebar-fu li').hover(function () {
        $(this).find('.sidebar-cont').stop().show(300);
    }, function () {
        $(this).find('.sidebar-cont').stop().hide();
    });

    //创建显示在左边二维码
    window.onload = function createQrCodeRight() {
        var qrsize = $('#qrCode2');
        if ($('#qrCode2 canvas').length > 0) {
            return false;
        }
        var logos = $('.vendorCodeLogo').attr('src');
        if (!logos) {
            logos = '/package/Web_1.0/interface/assets/img/logo_a.png';
        }
        //TODO::经纪人分享链接，调用接口
        //生成二维码
        qrsize.qrcode({
            logoSrc: logos,			//水印图片A
            logoBgProp: 0.2,				//水印大小 按图片比例
            text: window.location.href,		//扫描出的名称
            //	url			:"";
            width: qrsize.height(),	//二维码宽度
            height: qrsize.height(),	//二维码高度
            background: "#ffffff",		//二维码第一种颜色
            foreground: "#000000"			//二维码第二种颜色
        });
        qrsize.children().css({
            'background': '#fff'
        });	//设置阴影
    }

});

