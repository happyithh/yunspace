<!DOCTYPE html>
<!--[if IE 8]>
<html lang="en" class="ie8 no-js"> <![endif]-->
<!--[if IE 9]>
<html lang="en" class="ie9 no-js"> <![endif]-->
<!--[if !IE]><!-->
<html lang="en" class="no-js">
<!--<![endif]-->
<!-- BEGIN HEAD -->
<head>
    <title>{$title}</title>
    <meta content="" name="description"/>
    {include "Admin::inc/html_head.tpl"}
    <link href="style/css.css" rel="stylesheet"/>
</head>
<body>
<div class="booking">

        <div class="s_title">&nbsp;<h4>{$_order['product_name']}</h4></div>
        <h6>需求档期:</h6>

    <div class="well">
        开始时间:{if $_order['start_time']}{Date('Y-m-d',$_order['start_time'])}{/if}&nbsp;</br>
        结束时间:{if $_order['end_time']}{Date('Y-m-d',$_order['end_time'])}{/if}
    </div>
        <h6>订单备注:</h6>
        <div class="well">
             <address> {$_order['remark']}</address>
        </div>
        <h6>基本属性:</h6>
        <div class="well">

            {foreach $_order['order_detail']['attr'] as $k=>$v}
                {if strpos($k,'基本信息>')===0}
                    <span><font>{tplDisplayShortAttrName($k)}
                            : </font> {$v|default:'-'}</span>
                {/if}
            {/foreach}

        </div>
        <h6>产品介绍:</h6>
        <div class="well" style="text-indent: 2em">
            {$_order['des']}
        </div>
    </div>
</div>
</body>