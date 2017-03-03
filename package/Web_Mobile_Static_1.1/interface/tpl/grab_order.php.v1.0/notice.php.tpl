<!DOCTYPE html>
<html>
<head lang="en">
    {include "Web_Mobile_Static::v1.0/head_meta.tpl"}
    {static "v1.0/global.css"}
    {static "grab_order.v1.0/grab.css"}
</head>
<body>
<div class="wrapper">
        <ul class="grap-notice" style="padding-bottom: 50px;overflow: auto">
            {foreach $list as $val}
                <li style="width:95%;">
                    <div class="title" style="overflow: hidden;">
                        <h5 class="fl"
                            style="width: 70%;overflow: hidden;white-space: nowrap;text-overflow: ellipsis;height: 42px;">{$val['title']}
                        </h5>

                        <p class="fr">{date('Y-m-d ',$val['create_time'])}&nbsp;</p>
                    </div>
                    <div class="cont">
                        <p>{$val['content']}</p>
                        {*<a href="">http://www.yunspace.com</a>*}
                    </div>
                </li>
            {/foreach}
        </ul>
    {include "Web_Mobile_Static::grab_order.php.v1.0/inc/menu.tpl"}

</div>
<!--wrapper-end-->
</body>
</html>