<!DOCTYPE html>
<html>
<head lang="en">
    {*<script>*}
        {*//判断是否 是微信*}
        {*var ua = navigator.userAgent.toLowerCase();*}
        {*if (ua.match(/MicroMessenger/i) == "micromessenger") {*}
            {*window.location.href = "{$_root}" + 'wechat/oauth';*}
        {*}*}
    {*</script>*}
    {include "Web_Mobile_Static::v1.0/head_meta.tpl"}
    {include "Web_Mobile_Static::user_center.v1.0/inc.head_user.tpl"}
</head>
<body>
<div class="user-panel">
    <div class="pan js-login-panel  active">{include 'user_center.v1.0/inc.shortcut-login2.0.tpl'}</div>
    <div class="cover absolute js-cover"></div>
    <div class="cover2 absolute js-cover2"></div>
</div>
</body>
</html>