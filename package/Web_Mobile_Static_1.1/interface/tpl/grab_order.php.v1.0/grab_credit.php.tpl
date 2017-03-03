<!DOCTYPE html>
<html>
<head lang="en">
    {include "Web_Mobile_Static::v1.0/head_meta.tpl"}
    {static "v1.0/global.css"}
    {static "grab_order.v1.0/grab.css"}
</head>
<body class="body-fff">
<div class="wrapper padding-bottom-68">
    <div class="grab-credit-title">
        <h2 class="fl credit-numb">{$myIntegral}</h2>
        <a href="{$_home}grab_order/credit?type=rule" class="fr credit-rule">积分规则</a>
    </div>

    <div class="grab-credit-details">
        <h3>积分明细</h3>
        {foreach $list as $val}
            <div class="col">
                <div class="state">
                    <p class="fl">{$val['intro']}</p>

                    <p class="fr">{$val['integral']}</p>
                </div>
                <div class="time">{$val['create_time']}</div>
            </div>
        {/foreach}
    </div>
    {include "Web_Mobile_Static::grab_order.php.v1.0/inc/menu.tpl"}

</div>
<!--wrapper-end-->
</body>
</html>