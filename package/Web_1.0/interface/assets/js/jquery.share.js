/**
 * Created by Administrator on 2015/4/13.
 * user  zzc
 * 分享，点击复制，二维码
 */
//显示分享框框
function showBox(_http) {

    if ($("#share_box").is(":visible") == false) {
        createQrCode(window.location.href);
        $("#share_box").show();
        $('.mask1').show();
        $("#copy_url").attr('value', window.location.href);
        onclickCopy(_http);
    } else {
        closeBox();
    }
}
function closeBox() {
    $("#share_box").hide();
    $(".mask1").hide();
}

//复制url方法
//点击按钮id,内容id
function onclickCopy(_http) {
    var clip = new ZeroClipboard.Client(); // 新建一个对象
    ZeroClipboard.setMoviePath(_http + "js/ZeroClipboard.swf");   //设置f路径
    clip.setHandCursor(true);
    clip.setText($('#copy_url').val()); // 设置要复制的文本。
    clip.addEventListener("mouseUp", function (client) {
        alert("复制成功！");
        closeBox();
    });
    clip.glue("copyid");
}
//创建二维码
function createQrCode(text) {
    var qrsize = $('#qrCode');
    if ($('#qrCode canvas').length > 0) {
        return false;
    }
    var logos = $('.vendorCodeLogo').attr('src');
    //var logos = '/package/Web_1.0/interface/assets/img/logo_a.png';
    //生成二维码
    qrsize.qrcode({
        logoSrc: logos,			//水印图片A
        logoBgProp: 0.3,				//水印大小 按图片比例
        text: text,		//扫描出的名称
        //	url			:"";
        width: qrsize.height(),	//二维码宽度
        height: qrsize.height(),	//二维码高度
        background: "#ffffff",		//二维码第一种颜色
        foreground: "#000000"			//二维码第二种颜色
    });
    qrsize.children().css({
        'padding': '6px', 'background': '#fff'
    });	//设置阴影
}
