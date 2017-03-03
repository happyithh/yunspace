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
    {if Core::$package['name']=='Web_Vendor_Center'}
        {include 'Web_User_Center::inc/html_head.tpl' theme='blue'}
    {else}
        {include 'Web_User_Center::inc/html_head.tpl'}
    {/if}
    <link rel="stylesheet" href="css/money.css"/>
    <link rel="stylesheet" href="css/css.css"/>
    <style>
        .pdf_btn {
            float: right;
            margin-top: 5px;;
        }
    </style>
</head>
{if Core::$package['name']=='Web_Vendor_Center'}
    {include 'Web_User_Center::inc/header_top.tpl' color='#0b679e'}
{else}
    {include 'Web_User_Center::inc/header_top.tpl'}
{/if}
<!-- END HEAD -->
<!-- BEGIN BODY -->
<body>
<div class="clearfix"></div>
<!-- BEGIN CONTAINER -->
<div class="page-container">
{include 'inc/header_purchase_nav.tpl'}
<!-- BEGIN CONTENT -->
<div class="page-content-wrapper">
<div class="page-content" style="min-height: 973px">
<h3 class="page-title">我的收藏</h3>

<div class="portlet">
<div class="portlet-body">
<ul class="nav nav-pills">
    <li {if $type=='space'}class="active"{/if}>
        <a href="?type=space" class="btn">服务内容（{$space_num}）</a>
    </li>
    <li {if $type=='set'}class="active"{/if}>
        <a href="?type=set" class="btn">超值套餐（{$set_num}）</a>
    </li>
    <li {if $type=='vendor'}class="active"{/if}>
        <a href="?type=vendor" class="btn">供应商（{$vendor_num}）</a>
    </li>
    <li {if $type=='event'}class="active"{/if}>
        <a href="?type=event" class="btn">活动案例（{$event_num}）</a>
    </li>
</ul>
<hr>
{foreach $data['rows'] as $k=>$v}
    {if $type=='set'}
        <div class="se_li_list">
            <div class="fl img_list">
                <a href="{$_root}set_info/{$v['id']}.html">
                    {if $v['logo']}
                        <img src="{Data_Config_Site::displayMedia($v['logo'],264)}">
                    {else}
                        <img src="images/vendor.jpg">
                    {/if}
                </a>
            </div>
            <div class="tw clearfix">
                <div class="fl wz">
                    <h3>
                        <a target="_blank" href="{$_root}set_info/{$v['id']}.html">{$v['set_name']}</a>
                    </h3>

                    <p>
                        <span class="address">地址：{$v['addr']}</span>
                        <span class=size>标签：{$v['attr_index']['标签']}</span>
                        <span class="mold">空间类型：{$v['category_name']}</span>
                    </p>
                    <span class="date_collect"><font><i
                                    class="fa fa-clock-o"></i>&nbsp;{date('Y-m-d H:i:s',$v['create_time'])}
                        </font></span>
                </div>
                <div class="fr  ">
                    <a href="?action=pdf&set_id={$v['id']}" class="btn-success btn-sm">导出PDF</a>

                </div>
            </div>
        </div>
    {/if}
    {if $type=='space'}
        <div class="se_li_list">
            <div class="fl img_list">
                <a href="{$_root}service_info/{$v['id']}.html">
                    {if $v['logo']}
                        <img src="{Data_Config_Site::displayMedia($v['logo'],264)}">
                    {else}
                        <img src="images/vendor.jpg">
                    {/if}
                </a>
            </div>
            <div class="tw clearfix">
                <div class="fl wz">
                    <h3>
                        <a target="_blank" href="{$_root}service_info/{$v['id']}.html">{$v['product_name']}</a>
                    </h3>

                    <p>
                        <span class="address">地址：{$v['addr']}</span>
                        <span class=size>空间大小：{$v['product_size']}平方米</span>
                        <span class="mold">空间类型：{$v['category_name']}</span>
                    </p>
                    <span class="date_collect"><font><i
                                    class="fa fa-clock-o"></i>&nbsp;{date('Y-m-d H:i:s',$v['create_time'])}
                        </font></span>
                </div>
                {*{if $page->productInfo['price'] >0}*}
                {*<strong>¥ {$page->productInfo['price']} </strong>*}
                {*{else}*}
                {*面议 | <a data-toggle="modal" href="#openDemanAsk" ask_id = "{$page->id}" ask_type="1" class="demandAsk">预约咨询</a>*}
                {*{/if}*}
                {if $v['id']}
                <div class="fr mene">
                    <span class="mena_m">
                    {if ($v['price']/100) >0}
                        ￥{$v['price']}
                    {else}
                        面议
                    {/if}
                        </span>

                    <p class="pull-left">已收藏：{$v['counter_follow']}</p>

                    <p class="pull-right">成交：{$v['counter_order']}</p>

                </div>
                <div class="pdf_btn">
                    <a href="?action=pdf_product&product_id={$v['id']}" class="btn-success btn-sm"> 导出pdf</a>
                </div>
            </div>
            {else}
            <div class="fr mene" style="color: #666;text-align: center">
                已失效
            </div>
            {/if}
        </div>
    {/if}
    {if $type=='vendor'}
        <div class="se_li_list">
            <div class="fl img_list">
                <a href="{$_root}vendor_info/{$v['id']}.html">
                    {if $v['logo']}
                        <img src="{$v['logo']}">
                    {else}
                        <img src="images/vendor.jpg">
                    {/if}
                </a>
            </div>
            <div class="tw clearfix">
                <div class="fl wz">
                    <h3>
                        <a target="_blank" href="{$_root}vendor_info/{$v['id']}.html">{$v['vendor_name']}</a>
                    </h3>

                    <div class="p1">
                        <span class="mena_m1">主要联系人：{$v['base_info']['主要联系人']}</span>
                        <span class="mena_m1">联系方式：{$v['base_info']['联系方式']}</span></div>
                    <p class="p2">
                        <span class="address1"> 地址：{$v['base_info']['公司地址']}</span>
                        <span class="mold"> 服务区域：{$v['attr']['城市']} 服务类型：{$v['category_name']}</span>
                        <span class="tab1">活动标签：{{$v['attr']['活动类型']}}</span>
                        <span class="tab2">行业标签：{{$v['attr']['服务行业']}}</span>
                    </p>

                    <span class="date_collect"><font><i
                                    class="fa fa-clock-o"></i>&nbsp;{date('Y-m-d H:i:s',$v['create_time'])}
                        </font></span>
                </div>
                <div class="fr mene1">

                    <span class="mena_m1">主要联系人：{$v['base_info']['主要联系人']}</span>
                    <span class="mena_m1">联系方式：{$v['base_info']['联系方式']}</span>

                    <p class="pull-left">已收藏：{$v['counter_follow']}</p>

                    <p class="pull-right">成交：{$v['counter_order']}</p>
                </div>
            </div>
        </div>
    {/if}
    {if $type=='event'}
        <div class="se_li_list">
            <div class="fl img_list">
                <a href="{$_root}event_info/{$v['id']}.html">
                    {if $v['logo']}
                        <img src="{$v['logo']}">
                    {else}
                        <img src="images/vendor.jpg">
                    {/if}
                </a>
            </div>
            <div class="tw clearfix">
                <div class="fl wz">
                    <h3>
                        <a target="_blank" href="{$_root}event_info/{$v['id']}.html">{$v['event_name']}</a>
                    </h3>

                    <p>
                        <span class="address">活动地址：{$v['addr']}</span>
                        <span class="mold">活动类型：{$v['category_name']}</span>
                        <span class="band"> 活动品牌：{$v['attr']['品牌']}</span>
                        <span class="city"> 城市：{$v['attr']['省份']}{$v['attr']['城市']}</span>
                    </p>
                    <span class="date_collect"><font><i
                                    class="fa fa-clock-o"></i>&nbsp;{date('Y-m-d H:i:s',$v['create_time'])}
                        </font></span>
                </div>
                <div class="fr mene">

                    <p>已收藏：{$v['counter_follow']}&nbsp;&nbsp;&nbsp;</p>

                    <p>浏览量：{$v['counter_view']}</p></strong>

                </div>
            </div>
        </div>
    {/if}
{/foreach}
{*
                 <div class="table-responsive" style="border:0px;">
                      <table class="table table-hover" style="border:0px;">
                          <tbody>
                            {foreach $data['rows'] as $k=>$v}
                            {if $type=='space'}
                            <tr>
                                <td width="270px">
                                    <div>
                                        <a href="{$_root}service_info/{$v['id']}.html">
                                            {if $v['logo']}
                                            <img src="{$v['logo']}" style="width:100%;height:100%;max-width: 264px;">
                                            {else}
                                            <img src="images/vendor.jpg" style="width:100%;height:100%;max-width: 264px;">
                                            {/if}
                                        </a>
                                    </div>
                                    <div>
                                        <i class="fa fa-calendar"></i>
                                        <span>{date('Y-m-d H:i:s',$v['create_time'])}</span>
                                    </div>
                                </td>
                                <td>
                                    <div>
                                        <h3>
                                             <a target="_blank" href="{$_root}service_info/{$v['id']}.html">{$v['product_name']}</a>
                                        </h3>
                                        <p>
                                            地址：{$v['addr']}<br /> 空间大小：{$v['product_size']}平方米<br /> 空间类型：{$v['category_name']}<br />
                                        </p>
                                    </div>
                                </td>
                                <td width="200px">
                                    <div class="pull-right" style="background: #cac9d2;text-align: center;">
                                        <h3>￥{$v['price']}</h3>
                                        <strong><p class="pull-left">已收藏：{$v['counter_follow']}&nbsp;&nbsp;&nbsp;</p><p class="pull-left">成交：{$v['counter_order']}</p></strong>
                                    </div>
                                </td>
                            </tr>
                            {/if}
                            {if $type=='vendor'}
                                <tr>
                                    <td width="270px">
                                        <div>
                                            <a href="{$_root}vendor_info/{$v['id']}.html">
                                                {if $v['logo']}
                                                    <img src="{$v['logo']}" style="width:100%;height:100%;max-width: 264px;">
                                                {else}
                                                    <img src="images/vendor.jpg" style="width:100%;height:100%;max-width: 264px;">
                                                {/if}
                                            </a>
                                        </div>
                                        <div>
                                            <i class="fa fa-calendar"></i>
                                            <span>{date('Y-m-d H:i:s',$v['create_time'])}</span>
                                        </div>
                                    </td>
                                    <td>
                                        <div>
                                            <h3>
                                                <a target="_blank" href="{$_root}vendor_info/{$v['id']}.html">{$v['vendor_name']}</a>
                                            </h3>
                                            <p>
                                                地址：{$v['base_info']['公司地址']}<br /> 服务区域：{$v['attr']['城市']}<br /> 服务类型：{$v['category_name']}<br />
                                                活动标签：{{$v['attr']['活动类型']}}<br/> 行业标签：{{$v['attr']['服务行业']}}<br/>
                                            </p>
                                        </div>
                                    </td>
                                    <td width="200px">
                                        <div class="pull-right" style="text-align: center; background: #cac9d2; padding: 10px;margin-top:20px;">
                                            {foreach $v['base_info'] as $vk=>$vv}
                                                <p style="text-align: left;"> {$vk}:{$vv} </p>
                                            {/foreach}
                                            <strong><p class="pull-left">已收藏：{$v['counter_follow']}&nbsp;&nbsp;&nbsp;</p><p class="pull-left">成交：{$v['counter_order']}</p></strong>
                                        </div>
                                    </td>
                                </tr>
                            {/if}
                            {if $type=='event'}
                                <tr>
                                    <td width="270px">
                                        <div>
                                            <a href="{$_root}event_info/{$v['id']}.html">
                                                {if $v['logo']}
                                                    <img src="{$v['logo']}" style="width:100%;height:100%;max-width: 264px;">
                                                {else}
                                                    <img src="images/vendor.jpg" style="width:100%;height:100%;max-width: 264px;">
                                                {/if}
                                            </a>
                                        </div>
                                        <div>
                                            <i class="fa fa-calendar"></i>
                                            <span>{date('Y-m-d H:i:s',$v['create_time'])}</span>
                                        </div>
                                    </td>
                                    <td>
                                        <div>
                                            <h3>
                                                <a target="_blank" href="{$_root}event_info/{$v['id']}.html">{$v['event_name']}</a>
                                            </h3>
                                            <p>
                                                活动地址：{$v['addr']}<br />  活动类型：{$v['category_name']}<br />
                                                活动品牌：{$v['attr']['品牌']}<br/> 城市：{$v['attr']['省份']}{$v['attr']['城市']}<br/>
                                            </p>
                                        </div>
                                    </td>
                                    <td width="200px">
                                        <div class="pull-right" style="text-align: center; background: #cac9d2; padding: 10px;margin-top:20px;">
                                            <strong><p class="pull-left">已收藏：{$v['counter_follow']}&nbsp;&nbsp;&nbsp;</p><p class="pull-left">浏览量：{$v['counter_view']}</p></strong>
                                        </div>
                                    </td>
                                </tr>
                            {/if}
                            {/foreach}
                            <tr>
                                <td colspan="3">
                                    <div style="text-align: center;">
                                        <ul class="pagination">
                                            {if $data['page']['dpll']}
                                                <li class="prev">
                                                    <a href="{$data['page']['dup']}1" title="First"><i class="fa fa-angle-double-left"></i></a>
                                                </li>
                                                <li class="prev">
                                                    <a href="{$data['page']['dup']}{$data['page']['dp']-1}" title="Prev"><i class="fa fa-angle-left"></i></a>
                                                </li>
                                            {else}
                                                <li class="prev disabled">
                                                    <a href="#" title="First"><i class="fa fa-angle-double-left"></i></a>
                                                </li>
                                                <li class="prev disabled">
                                                    <a href="#" title="Prev"><i class="fa fa-angle-left"></i></a>
                                                </li>
                                            {/if}
                                            {for $i=$data['page']['dpl'] to $data['page']['dpr']}
                                                <li{if $i==$data['page']['dp']} class="active"{/if}>
                                                    <a href="{$data['page']['dup']}{$i}">{$i}</a>
                                                </li>
                                            {/for}
                                            <li class="disabled">
                                                <a> {$data['page']['dtp']}
                                                    ( {$data['page']['dp']*$data['page']['dn']}
                                                    /{$data['page']['dt']}
                                                    )</a></li>

                                            {if $data['page']['dprr']}
                                                <li class="next">
                                                    <a href="{$data['page']['dup']}{$data['page']['dp']+1}" title="Next"><i class="fa fa-angle-right"></i></a>
                                                </li>
                                                <li class="next">
                                                    <a href="{$data['page']['dup']}{$data['page']['dtp']}" title="Last"><i class="fa fa-angle-double-right"></i></a>
                                                </li>
                                            {else}
                                                <li class="next disabled">
                                                    <a href="#" title="Next"><i class="fa fa-angle-right"></i></a>
                                                </li>
                                                <li class="next disabled">
                                                    <a href="#" title="Last"><i class="fa fa-angle-double-right"></i></a>
                                                </li>
                                            {/if}
                                        </ul>
                                    </div>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </div>

*}
<ul class="pagination">
    {if $data['page']['dpll']}
        <li class="prev">
            <a href="{$data['page']['dup']}1" title="First"><i class="fa fa-angle-double-left"></i></a>
        </li>
        <li class="prev">
            <a href="{$data['page']['dup']}{$data['page']['dp']-1}" title="Prev"><i class="fa fa-angle-left"></i></a>
        </li>
    {else}
        <li class="prev disabled">
            <a href="#" title="First"><i class="fa fa-angle-double-left"></i></a>
        </li>
        <li class="prev disabled">
            <a href="#" title="Prev"><i class="fa fa-angle-left"></i></a>
        </li>
    {/if}
    {for $i=$data['page']['dpl'] to $data['page']['dpr']}
        <li{if $i==$data['page']['dp']} class="active"{/if}>
            <a href="{$data['page']['dup']}{$i}">{$i}</a>
        </li>
    {/for}
    <li class="disabled">
        <a> {$data['page']['dtp']}
            {if $data['page']['dt'] == 0}
                ( 0/{$data['page']['dt']} )
            {else}
                ({( $data['page']['dp']-1)*$data['page']['dn']+1}/{$data['page']['dt']} )
            {/if}
        </a>
    </li>

    {if $data['page']['dprr']}
        <li class="next">
            <a href="{$data['page']['dup']}{$data['page']['dp']+1}" title="Next"><i class="fa fa-angle-right"></i></a>
        </li>
        <li class="next">
            <a href="{$data['page']['dup']}{$data['page']['dtp']}" title="Last"><i class="fa fa-angle-double-right"></i></a>
        </li>
    {else}
        <li class="next disabled">
            <a href="#" title="Next"><i class="fa fa-angle-right"></i></a>
        </li>
        <li class="next disabled">
            <a href="#" title="Last"><i class="fa fa-angle-double-right"></i></a>
        </li>
    {/if}
</ul>
</div>
</div>
</div>
</div>
</div>

{include 'Web_User_Center::inc/footer_inbox.tpl'}
{include 'Web_User_Center::inc/footer_script.tpl'}
</body>

<!-- END BODY -->
</html>