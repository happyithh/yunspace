<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <title>云·SPACE诚招代理商加盟</title>
    {static "v4.0/common.css"}
    {static "join/header.css"}
    {*{static "join/footer.css"}*}
    {static "join/join.css"}
    {static "join/tabChange.css"}
    {*{static "join/chat_bar.css"}*}
    {static "join/ionicons.min..css"}
    {static "join/join.js"}
    {static "v4.0/jquery-1.11.1.min.js"}

    {*<link rel="stylesheet" type="text/css" href="css/header.css">*}
    {*<link rel="stylesheet" type="text/css" href="css/footer.css"/>*}
    {*<link rel="stylesheet" type="text/css" href="css/join.css"/>*}
    {*<link rel="stylesheet" href="css/tabChange.css"/>*}
    {*<link rel="stylesheet" href="css/chat_bar.css"/>*}
    {*<link rel="stylesheet" href="css/ionicons.min.css"/>*}

    {*<script type="text/javascript" src="js/jquery-1.9.1.min.js"></script>*}
    {*<script type="text/javascript" src="js/join.js"></script>*}

</head>
<body>
<!--网站头部 -->
<div class="top">
    <div class="wrapper header">
        <nav class="clearfix nav">
            <a class="logo" href="http://www.yunspace.com.cn/" style="padding-top: 5px;"><img src="http://s2.yunspace.com.cn/package/Web_Static_4.0/interface/assets/img/logo.png" alt=""></a>
            {include file="Web_Static::inc/header_join.tpl"}

            {*<ul class="nav-list clearfix fl">*}

                {*<li><a href="http://www.yunspace.com.cn/">首页</a></li>*}
                {*<li><a href="http://www.yunspace.com.cn/sites/112">空间</a></li>*}
                {*<li><a href="http://www.yunspace.com.cn/sites/200">文创</a></li>*}
                {*<li><a href="http://www.yunspace.com.cn/sites/400">资讯</a></li>*}
                {*<li><a href="http://www.yunspace.com.cn/sites/300">发现</a></li>*}
                {*<li><a href="http://www.yunspace.com.cn/database/site">场地库</a></li>*}
                {*<li><a href="http://www.yunspace.com.cn/winchance">项目库</a></li>*}

                {*<li><a href="http://www.yunspace.com.cn/database/paper">文库</a></li>*}
                {*<li><a href="http://www.yunspace.com.cn/map2">场地地图</a></li>*}
                {*<!--<li><a href="#">|</a></li>-->*}
                {*<!--<li><a href="javascript:;" yun="inc.v4.0/header.js::showCode@click" yun-id="0">移动版</a></li>-->*}
                {*<!--<li><a href="javascript:;" yun="inc.v4.0/header.js::showCode@click" yun-id="1">公众号</a></li>-->*}
                {*<!--<li><a href="javascript:;" yun="inc.v4.0/header.js::showCode@click" yun-id="2">App</a></li>-->*}
            {*</ul>*}
            {*<ul class="nav-list clearfix fr">*}
                {*<li><a href="http://yunspace.com.cn" class="yun-icon icon-1">一键租场地</a></li>*}
                {*<!--<li><a href="javascript:;" class="yun-icon icon-2 login_user" id="login_user">登录/注册</a></li>-->*}
            {*</ul>*}
        </nav>
    </div>
</div>
<!--专题-->
<div class="join">
   <img src="img/join/form_03.jpg" alt="云·SPACE诚招代理商加盟申请">
</div>
<!--<form action="http://www.yunspace.com.cn/form" method="post">-->
    <input id="id" name="id" value="9" type="hidden">
<div class="form_content">
    <div class="form_title">请留下您的基本信息，我们会尽快与您联系</div>
    <div class="form_list">
        <div class="form_left"><span>*</span>&nbsp;&nbsp;城&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;市</div>
        <div class="form_right">
            <input id="city" type="text" placeholder="请输入您所在的省和城市,如贵州省安顺市" name="data[城市]" value="" class="input">
        </div>
        <div class="clear"></div>
    </div>
    <div class="form_list">
        <div class="form_left"><span>*</span>&nbsp;&nbsp;公司名称</div>
        <div class="form_right"><input id="name" type="text" placeholder="请输入您的公司名称" name="data[公司名称]" value=""> </div>
        <div class="clear"></div>
    </div>
    <div class="form_list">
        <div class="form_left"><span>*</span>&nbsp;&nbsp;联&nbsp;系&nbsp;&nbsp;人</div>
        <div class="form_right"><input id="person" type="text" placeholder="请输入您的称呼" name="data[联系人]" value="" class="input"> </div>
        <div class="clear"></div>
    </div>
    <div class="form_list">
        <div class="form_left"><span>*</span>&nbsp;&nbsp;联系电话</div>
        <div class="form_right"><input id="tel" type="text" placeholder="请输入联系电话" name="data[联系电话]" value="" class="input"> </div>
        <div class="clear"></div>
    </div>
    <div class="form_list">
        <div class="form_left"><span>&nbsp;&nbsp;&nbsp;</span>公司地址</div>
        <div class="form_right"><input id="address" type="text" placeholder="请输入详细地址，如县区、街道、门牌号等" name="data[公司地址]" value="" class="input"> </div>
        <div class="clear"></div>
    </div>
    <div class="form_list">
        <div class="button">
            <button>确定</button>
        </div>
        <div class="clear"></div>
    </div>
</div>
<!--</form>-->


<div>
    <div class="alert">
        <div class="p3"><img src="img/join/icon1.jpg"> </div>
        <div class="clear"></div>
       <div class="p1">
           <div class="p1_left"><img src="img/join/icon.jpg"> </div>
           <div class="p1_right">您的申请已经成功提交！</div>
           <div class="clear"></div>
       </div>
       <div class="p2">我们会尽快审核信息并与您联系，请耐心等待。</div>
    </div>
</div>
<div class="mark"></div>
<div style="display:none;visibility: hide">
    <script>
        var _hmt = _hmt || [];
        (function () {
            var hm = document.createElement("script");
            hm.src = "//hm.baidu.com/hm.js?db9aca0f09ae15c89745a79b5c8599bf";
            var s = document.getElementsByTagName("script")[0];
            s.parentNode.insertBefore(hm, s);
        })();
    </script>
    <script type="text/javascript">
        var _bdhmProtocol = (("https:" == document.location.protocol) ? " https://" : " http://");
        document.write(unescape("%3Cscript src='" + _bdhmProtocol + "hm.baidu.com/h.js%3Fc400699d328ada7f4739a7a5bb91acdd' type='text/javascript'%3E%3C/script%3E"));
    </script>
    <script type="text/javascript" src="http://tajs.qq.com/stats?sId=44414322" charset="UTF-8"></script>
</div>
<!--网站底部 -->
{include file="Web_Static::inc/html_footer.tpl"}

{*<div class="footer-outside">*}
    {*<div class="footer">*}
        {*<ul class="footer_left">*}
            {*<li>*}
                {*<div class="footer-item-title">我要办活动</div>*}
                {*<span class="span-line"></span>*}
                {*<p><a href="http://www.yunspace.com.cn/space">空间场地</a></p>*}
                {*<p><a href="http://www.yunspace.com.cn/service">配套服务</a></p>*}
                {*<p><a href="http://www.yunspace.com.cn/set_list">超值套餐</a></p>*}
                {*<p><a href="http://www.yunspace.com.cn/raiders">云·发现</a></p>*}
                {*<p><a href="http://www.yunspace.com.cn/vendor">服务商户</a></p>*}
                {*<p><a href="http://www.yunspace.com.cn/index_2015">2015旧版网站</a></p>*}
            {*</li>*}
            {*<li>*}
                {*<div class="footer-item-title">帮助中心</div>*}
                {*<span class="span-line"></span>*}
                {*<p><a href="http://www.yunspace.com.cn/article/3124147.html">场地加盟</a></p>*}
                {*<p><a href="http://www.yunspace.com.cn/article/3140721.html">我要投稿</a></p>*}
                {*<p><a href="http://www.yunspace.com.cn/article/3142345.html">文创项目加盟</a></p>*}
                {*<p><a href="http://www.yunspace.com.cn/article/3135554.html">关于短租/快闪店</a></p>*}
            {*</li>*}
            {*<li>*}
                {*<div class="footer-item-title">关于云·SPACE</div>*}
                {*<span class="span-line"></span>*}
                {*<p><a href="http://www.yunspace.com.cn/site/%E4%BA%91SPACE">官方新闻</a></p>*}
                {*<p><a href="http://d15.yunspace.com.cn/feature/2015.9/join/index.html">诚招代理商</a></p>*}
                {*<p><a href="http://www.yunspace.com.cn/yunspace/about_us">关于我们</a></p>*}
                {*<p><a href="http://www.yunspace.com.cn/yunspace/business">业务合作</a></p>*}
                {*<p><a href="http://www.yunspace.com.cn/yunspace/recruitment">职位招聘</a></p>*}
                {*<p><a href="http://www.yunspace.com.cn/yunspace/contact_us">联系我们</a></p>*}
            {*</li>*}
            {*<li style="margin-right: 0px;">*}
                {*<div class="footer-item-title">服务号</div>*}
                {*<p class="weixin2"><img src="http://s2.yunspace.com.cn/package/Web_Static_4.0/interface/assets/img/weixin2.jpg" width="120"></p>*}
            {*</li>*}
        {*</ul>*}
        {*<div class="footer_right">*}
            {*<p class="title_one">服务热线 - 400-056-0599</p>*}
            {*<p class="title_two">服务邮箱 - <a href="mailto:service@yunspace.com.cn">service@yunspace.com.cn</a></p>*}
            {*<p class="title_two">联系地址 - 淮海西路570号红坊创意园F211<br>（近民生美术馆）</p>*}
        {*</div>*}
        {*<div class="clear"></div>*}
    {*</div>*}
{*</div>*}
{*<div class="bottom-outside">*}
    {*<div class="bottom">*}
        {*<p>Copyright©2015 云·SPACE <a href="http://www.miibeian.gov.cn/" target="_blank">沪ICP备12039278号-2</a></p>*}
    {*</div>*}
{*</div>*}
{*<div class="mark"></div>*}

</body>


</html>
