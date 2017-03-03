<!DOCTYPE html>
<html>
{*抢单首页*}
<head lang="en">
    <title>订单</title>
    {include "Web_Mobile_Static::v1.0/head_meta.tpl"}
    {static "v1.0/global.css"}
    {static "grab_order.v1.0/grab.css"}
    {static "v1.0/jquery-1.11.1.min.js"}
    {static "grab_order.v1.0/grab.js"}
    {static "grab_order.v1.0/operation.js"}
</head>
<body>
<div class="wrapper padding-bottom-68">
    <div class="grab-tab">
        <a class="fl alink {if $_REQUEST['type']=='' || $_REQUEST['type']=='A'}current{/if}" href="?type=A">
            <span class="icon1 icon-grablist"></span>

            <p>待抢单</p>
        </a>
        <a class="fr alink {if $_REQUEST['type']=='B'}current{/if}" href="?type=B">
            <span class="icon2 icon-grablist"></span>

            <p>已接单</p>
        </a>
    </div>
    {if $_REQUEST['type']=='B'}

        {include "Web_Mobile_Static::grab_order.php.v1.0/inc/myGrab.tpl"}

    {else}
        {include "Web_Mobile_Static::grab_order.php.v1.0/inc/readyGrab.tpl"}
    {/if}

    {include "Web_Mobile_Static::grab_order.php.v1.0/inc/menu.tpl"}

</div>
<!--wrapper-end-->
</body>
</html>