
<script type="text/javascript" src="js/ZeroClipboard.js"></script>
<style>
    {*{窗口左边*}
    .window_right {
        position: fixed;
        top: 50%;
        right: 0px;
        width: 300px;
        height: 250px;
    }

    {*点击显示的二维码*}
    .click_share {
        border-top: 4px solid #d6255e;
        display: none;
        position: absolute;
        width: 300px;
        height: 280px;
        right: 45%;
        top: 254px;
        background-color: #fff;
        box-shadow: 0px 0px 10px #999;
        overflow: auto;
    }
</style>
{*分享显示框框*}
<div class="mask1" onclick="$('#share_box').hide(); $('.mask1').hide();"
     style="height: 100%; width: 100%; background-color: #333; position: absolute; top:0px; left: 0px; z-index: 0; display: none; opacity:0.5;filter:alpha(opacity=50); ">
</div>
<div id="share_box" class="server_inner_banner click_share">
    <div style="position: absolute; top: 0px; right: 0px; cursor: pointer;"
         onclick="$('#share_box').hide(); $('.mask1').hide();"><img src="img/close_icon.jpg" style="width: 24px;">
    </div>
    <div style="margin-bottom: 10px;text-align: center">
        <input id="copy_url" type="text" value="" style="border: 1px solid #f0f0f0; height: 27px;">
        <button id="copyid"
                style="background-color: #f0f0f0; font-size: 12px; font-weight: bold; border: 1px solid #f0f0f0; height: 26px; width: 40px;">
            复制
        </button>
    </div>
    <div style="position:relative; margin:auto; text-align: center;">
        <div id="qrCode" style="height:190px;" title="云·SPACE"></div>
    </div>
</div>
{*显示在右边的二维码*}
{*<div style="position: fixed;top: 50%;right: 10px;width: 120px;height: 120px;z-index: 10">*}
{*<div style="position:relative; margin:auto; text-align: center;">*}
{*<div id="qrCode2" style="height:120px;" title="云·SPACE"></div>*}
{*</div>*}
{*</div>*}

