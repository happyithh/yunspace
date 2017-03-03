<!DOCTYPE html>
<html>
<head>
    {include file="inc/html_head.tpl" owl=1}
    <link rel="stylesheet" type="text/css" href="css/supplier.css">
</head>
<body>
<span class="hide product_name"></span>
{include 'inc/header_nav.tpl'}
<div class="supplier_head_outside">
    <div class="supplier_head">
        <span class="back"><a href="javascript:history.go(-1)">
                &lt;返回</a></span>

        <p class="site_location">
            <a href="{$_root}vendor">{$smarty.cookies.city}</a>

           > 服务商户 > {$page->vendorInfo['vendor_name']}</p>

        <div class="supplier_name">
            <h2>{$page->vendorInfo['vendor_name']}
                {if $page->vendorInfo['vendor_account_id']}
                    <a href="javascript:;" class="btn btn-primary "
                       onclick="yun('chatBar/index.js::openTab', { index:0, url:'{$_root}m/chat/chat_body?to_account_id={$page->vendorInfo['vendor_account_id']}'});">
                        <i class="glyphicon glyphicon-hand-right"></i>&nbsp;发消息</a>
                {else}
                    <a data-toggle="modal" href="#openDemanAsk" ask_id="{$page->id}" ask_type="10"
                       class="btn btn-primary demandAsk">
                        <i class="glyphicon glyphicon-hand-right"></i>&nbsp;联系供应商</a>
                {/if}
            </h2>
        </div>
        <div class="supplier_icon">
            <h5 class="icon">
                <a href="javascript:;" class="collect" data-url="{$_root}ajax_collect"
                   data-uid="{$smarty.session.user.id}"
                   data-status data-id="{$page->vendorInfo['id']}" data-type="vendor"><i
                            class="glyphicon glyphicon-heart-empty"></i>&nbsp;<span>收藏</span></a>
            </h5>
            <h5 class="icon" id="share">
                <a onclick="showBox('{$_assets}')" href="javascript:;"><span class="fa fa-share-alt"></span>&nbsp;分享</a>
            </h5>
        </div>
        <div class="clearfix"></div>
    </div>
</div>
<div class="supplier_head_outside2">
    <div class="supplier_head">
        <div class="row head_content">
            <div class="col-md-2 head_content_left">

                <img class="vendorlogo" src="{Page_Site_Global::displayLogo($page->vendorInfo['logo'])}"
                     class="img-thumbnail">

                {if $page->vendorInfo['vendor_remarks']['签约状态']}
                    <div class="pag"><img src="img/pag.png" style="border: none">
                    </div>
                {/if}
            </div>

            <div class="col-md-10 head_content_right">
                <div class="row">
                    <div class="col-md-6">
                        <p><span>服务评分：</span>
                            {if $page->vendorInfo['vendor_remarks']['内部评分']==''}
                                4.5
                            {else}
                                {$page->vendorInfo['vendor_remarks']['内部评分']}
                            {/if}
                        </p>

                        {if $page->vendorInfo['attr']['城市']}
                            <p>
                                <span>服务区域：</span>{$page->vendorInfo['attr']['城市']}
                            </p>
                        {/if}
                        {if $page->vendorInfo['attr']['公司规模']}
                            <p>
                                <span>公司规模：</span>{$page->vendorInfo['attr']['公司规模']}</p>
                        {/if}
                        {*<p>*}
                        {*<span>资质认证：</span>{$page->vendorInfo['attr']['资质认证']}*}
                        {*</p>*}
                    </div>
                    <div class="col-md-6">
                        {*<p>*}
                        {*<span>品牌名称：</span>{$page->vendorInfo['base_info']['品牌名称']}*}
                        {*</p>*}

                        {if $page->vendorInfo['category_name']}
                            <p>
                                <span>服务类型：</span>{$page->vendorInfo['category_name']}
                            </p>
                        {/if}
                        {if $page->vendorInfo['attr']['服务行业']}
                            <p>
                                <span>行业领域：</span>{$page->vendorInfo['attr']['服务行业']}
                            </p>
                        {/if}
                        {if $page->vendorInfo['base_info']['公司地址']}
                            <p>
                                <span>公司地址：</span>{$page->vendorInfo['addr']|default:$page->vendorInfo['base_info']['公司地址']}
                            </p>
                        {/if}
                    </div>
                </div>
                <p>
                    <span>公司简介：</span>{mb_substr(strip_tags($page->vendorInfo['des']),0,150,'utf-8')}...</p>
            </div>
        </div>
    </div>
</div>


<div class="wrap con">
    {if $page->vendorInfo['is_space']}
        {include 'inc/vendor_info/vendor_info_space.tpl'}
    {else}
        {include 'inc/vendor_info/vendor_info_service.tpl'}
    {/if}
    {if $page->setInfo}
        <div class="supplier_all">
            <h4 class="brief_title">所有套餐</h4>
            <ul class="list">
                {foreach $page->setInfo as $k=>$v}
                    <li>
                        <div class="supplier_img">
                            <a href="{$_root}set_info/{$v['id']}.html">
                                {if $v['logo']}
                                    <img src="{Page_Site_Global::displayMedia($v['logo'],275,195)}">
                                {else}
                                    <img src="images/vendor.jpg">
                                {/if}
                            </a>
                        </div>
                        <h4>
                            <a href="{$_root}set_info/{$v['id']}.html">{$v['set_name']}</a>
                        </h4>
                        <small>
                            {$v['addr']}
                        </small>
                    </li>
                {/foreach}
            </ul>
        </div>
    {/if}
    <div class="clearfix"></div>
</div>
{include "inc/pop_consult.tpl"}
{include file="inc/html_share.tpl"}
{include file="inc/html_demand_ask.tpl"}

{include file="Web_Static::v2.0/html_footer.tpl"}
<script type="text/javascript" src='js/collect.js'></script>
{*<script src='js/look_price.js'></script>*}
{static "js/look_price.js"}

</body>
</html>