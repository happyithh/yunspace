{static "v2.0/html_sidebar.css"}
<!--网站右边悬浮-->
<ul class="sidebar-fu">
    <li class="code">
        <div class="alpha-bg"></div>
        <a href="javascript:;" class="sidebar-box"><img src="img/home.v2.0/yun_code-write.png" class="img-write"><img
                    src="img/home.v2.0/yun_code-green.png" class="img-green"></a>

        <div class="sidebar-cont code_code" style="text-align: center;background: #fff">
            <div>关注云·SPACE</div>
            <img src="img/home.v2.0/space_fwh.jpg" width="200"/>
        </div>
    </li>
    <li class="sidebar_share">
        <div class="alpha-bg"></div>
        <a href="javascript:;" class="sidebar-box">分享</a>

        <div class="sidebar-cont sidebar_code" style="text-align: center">
            <div style="margin-bottom: 10px;">分享当前页</div>
            <div id="qrCode3" style="width:180px;height:180px;" title="云·SPACE"></div>
        </div>
    </li>
    <li class="contactus">
        <div class="alpha-bg"></div>
        <a href="javascript:;" class="sidebar-box">联系<br>我们</a>

        <p class="sidebar-cont">
            服务热线：400-056-0599
        </p>
    </li>
    {*<li class="feedback">*}
    {*<a href="javascript:;" class="sidebar-box">反馈</a>*}
    {*</li>*}
</ul>
<script>
        var url = window.location.href;
        //参数1表示图像大小，取值范围1-10；参数2表示质量，取值范围'L','M','Q','H'
        var qr = qrcode(10, 'M');
        qr.addData(url);
        qr.make();
        var wording=document.createElement('p');
//        wording.innerHTML = "";
        var code=document.createElement('DIV');
        code.innerHTML = qr.createImgTag();
        var element=document.getElementById("qrCode3");
//        element.appendChild(wording);
        element.appendChild(code);
</script>
{static "v2.0/Jquery.qrcode.js"}
{static "v2.0/sidebar_fu.js"}
{static "v2.0/qrcode.js"}