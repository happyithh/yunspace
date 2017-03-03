<!DOCTYPE html>
<html>
<head>
    {include file="inc/html_head.tpl"}
    <link type="text/css" href="css/lrtk.css" rel="stylesheet"/>
    <link href="css/product.css?v=1" rel="stylesheet">
    <link href="css/fullcalendar.min.css" rel="stylesheet">
    <link href="css/jquery.fancybox.css" rel="stylesheet">

    <script type="text/javascript" src="js/jquery.jcarousel.min.js"></script>
    <script type="text/javascript" src="js/jquery.pikachoose.js"></script>
    <script type="text/javascript" src="js/jquery.touchwipe.min.js"></script>
    <script src='js/service_info.v2.js'></script>
    <style>

        .fc-basic-view .fc-body .fc-row {
            min-height: 2em !important;
            height: 35px !important;
        }

        .fc-toolbar .fc-center h2 {
            font-size: 18px;
            padding-top: 5px;
        }

        .fc-view-container {
            margin-top: 15px;
        }

        .nav-tabs {
            border-bottom: none;
        }
    </style>
</head>
<body style="position: relative;" data-spy="scroll" data-target="#navbar-example">
{include 'inc/product_set_top_guide.tpl'}
{include 'inc/header_nav.tpl'}
<div class="pto1">
    <div class="product_top" style="margin-bottom: 20px;">
        <span class="back"><a href="javascript:history.go(-1)">
                &lt;返回</a></span>

        <p>
            <a href="#">上海
                ></a>

            <a href="#">超值套餐
                > </a>

            <a href="javascript:;">{$page->info['set_name']}</a>
        </p>

        <div class="product_top_left product_top_left1">
            <h2 style="float: left;">{$page->info['set_name']}</h2>

            <div class="product_icon" style="margin-top: 25px;">
                <h5 class="icon">
                    <a data-url="{$_root}ajax_collect" class='collect' data-uid="{$smarty.session.user.id}" data-status
                       data-id="{$page->id}" data-type="set" href="javascript:;"><i
                                class="glyphicon glyphicon-heart-empty"></i>&nbsp;<span>收藏</span></a>
                </h5>
                <h5 class="icon" id="share">
                    <a onclick="showBox('{$_assets}')" href="javascript:;"><span class="fa fa-share-alt"></span>&nbsp;分享</a>
                </h5>
            </div>
            <div class="clearfix"></div>
            {if $page->info['attr_index']['标签']}
                <div class="service_tab">

                    <span>标签：</span>
                    {foreach explode(',',$page->info['attr_index']['标签']) as $val}
                        <a href="#">{$val}</a>
                    {/foreach}

                </div>
                <div class="clearfix"></div>
            {/if}
            {*<script>*}
                {*$(function () {*}
                    {*$('[data-toggle="tooltip"]').tooltip();*}
                {*});*}
            {*</script>*}
            <div class="row brief">
                <div class="col-md-5 item">
                    <span>城市：</span>{$page->info['attr_index']['城市']}
                </div>
                <div class="col-md-7 item" data-toggle="tooltip" data-placement="top" title="{$page->info['attr_index']['天数']|default:'待定'}" style=" white-space: nowrap; ">
                    <span>天数：</span>{$page->info['attr_index']['天数']|default:'待定'}
                </div>
                <div class="col-md-5 item">
                    <span>类别：</span>{$page->info['category_name']}
                </div>
                <div class="col-md-7 item">
                    <span>有效期：</span>

                    {if $page->info['attr_index']['开始时间']}
                        {$page->info['attr_index']['开始时间']}
                        至 {$page->info['attr_index']['结束时间']}
                    {else}
                        待定
                    {/if}
                </div>
                <div class="col-md-5 item">
                    <span>人数：</span>{$page->info['attr_index']['人数']|default:'待定'}
                </div>
                <div class="col-md-7 item">
                    <span>地址：</span>{$page->info['addr']}
                </div>
                <div class="col-md-12 item">
                    <span>套餐简介：</span>
                    {$page->info['des']}
                </div>
            </div>

            <div class="clearfix"></div>
        </div>
        <script>
            $(document).ready(function () {
                $('.quality').hide().eq(0).show();
                $('.package_tab li').click(function () {
                    $(this).addClass('package_tab_active')
                            .siblings().removeClass('package_tab_active');
                    $('.quality').hide().eq($(this).index()).show();
                });
            });
        </script>
        <div class="product_top_right1">
            <ul class="package_tab">
                {foreach $page->detail as $key=>$val}
                    <li class="{if $key==0}package_tab_active{/if}" style="margin-right: 0px;">{$val['名称']}</li>
                {/foreach}
                <div class="clearfix"></div>
            </ul>
            {foreach $page->detail as $key => $val}
                <div class="quality" {if $key !=0}style="display: none" {/if}>
                    <ul class="package_tab_content">
                        {foreach $val['产品'] as $k=>$v}
                            <li>
                                <div class="package_tab_content_left">
                                    {if $k==1}
                                        配套服务
                                    {else}
                                        {*{$page->products[$v]['product_name']}*}
                                        场地
                                    {/if}
                                </div>
                                <div class="package_tab_content_right">
                                    ￥{$page->products[$v]['price']}</div>
                                <div class="clearfix"></div>
                            </li>
                        {/foreach}
                        {if $val['备注']}
                            <li class="package_tab_content_sum" style="color:#999;max-height: 89px; overflow: hidden; font-weight: normal!important;">
                                {str_replace('|','<br>',$val['备注'])}
                            </li>
                        {/if}
                        {if $val['市场价']}
                        <li class="package_tab_content_sum">
                            <div class="package_tab_content_left">
                                总计
                            </div>
                            <div class="package_tab_content_right">
                                ￥{$val['市场价']}</div>
                            <div class="clearfix"></div>
                        </li>
                        {/if}
                    </ul>
                    <h4 class="package_price">
                        <span1>优惠价：</span1>
                        ¥ {$val['价格']}
                        {if $val['市场价']}
                            <span>{$val['折扣']}折</span>
                        {/if}
                    </h4>
                    {if $page->isBegin&&!$page->isEnd}
                        <a href="{$_root}product_set_booking?id={$page->id}&version={$key}" class="btn btn-danger btn-order1"{$key}>
                            预定下单
                        </a>
                    {elseif $page->isEnd}
                        <a href="#" class="btn  btn-order1 disabled"{$key}>
                            已经结束
                        </a>
                    {else}
                        <a href="#" class="btn  btn-order1 disabled"{$key}>
                            敬请期待
                        </a>
                    {/if}
                </div>
            {/foreach}

                <a data-toggle="modal" href="#openDemanAsk" ask_id="{$page->id}" ask_type="5" class="btn set_ask demandAsk">>>咨询预约<<</a>
        </div>
        <div class="clearfix"></div>

    </div>
</div>
<div class="product_head">
    <div id="pic"></div>
    <div class="product_head_content">
        <div class="phcl">
            <div class="tab_product">
                {foreach $page->media as $mk=>$mv}
                    <div class="tab_product_item">
                        {$mk}（{count($mv)}）
                    </div>
                {/foreach}
            </div>
            {foreach $page->media as $mk=>$mv}
                <div class="pikachoose">
                    <ul class="jcarousel-skin-pika">
                        {foreach $mv as $vv}
                            <li class="unactive">
                                {if $vv[2]}
                                    <a href="{$vv[2]}" class="imageBox videoBox" data-fancybox-group="gallery">
                                        <img src="{Page_Site_Global::displayMedia($vv[1],768,0,2)}"
                                             title="{$info['attr']['城市']}{$info['product_name']}-{$info['attr']['基本信息>适合活动类型']}-{$vv[0]}"/>
                                    </a>
                                {else}
                                    <a href="{Page_Site_Global::displayMedia($vv[1],768,0,1)}" class="imageBox"
                                       data-fancybox-group="gallery">
                                        <img src="{Page_Site_Global::displayMedia($vv[1],768,0,1)}"
                                             title="{$info['attr']['城市']}{$info['product_name']}-{$info['attr']['基本信息>适合活动类型']}-{$vv[0]}"/>
                                    </a>
                                {/if}
                            </li>
                        {/foreach}
                    </ul>
                </div>
            {/foreach}
        </div>
        <div class="phcr">
            <div class="s_logo">
                <a href="{$_root}vendor_info/{$page->vendorInfo['id']}.html">
                    {if $page->vendorInfo['logo']}
                        <img src="{$page->vendorInfo['logo']}">
                    {else}
                        <img src="img/s_logo.jpg">
                    {/if}
                </a>
            </div>
            <div class="s_title">
                <a href="{$_root}vendor_info/{$page->vendorInfo['id']}.html">{$page->vendorInfo['vendor_name']}</a>
            </div>
            <div class="s_content">
                <p>
                    <span>服务评分：</span>{$page->vendorInfo['vendor_remarks']['内部评分']|default:'待定'}
                </p>

                <p>
                    <span>服务区域：</span>{$page->vendorInfo['attr']['城市']}
                </p>

                <p>
                    <span>服务类型：</span>{$page->vendorInfo['category_name']}
                </p>

                <p>
                    <span>公司规模：</span>{$page->vendorInfo['attr']['公司规模']}
                </p>

                <p>
                    <span>活动标签：</span>{$page->vendorInfo['attr']['活动类型']}
                </p>

                <p>
                    <span>行业标签：</span>{$page->vendorInfo['attr']['服务行业']}
                </p>

            </div>
            <div class="c_button">
                <a data-toggle="modal" href="#openDemanAsk" ask_id="{$page->vendorInfo['id']}" ask_type="10" class="btn c_b1 demandAsk">联系供应商</a>
            </div>
        </div>
        <div class="clearfix"></div>
    </div>
</div>
<div class="wrap con">
{*{var_dump($page->productInfo,$page->tags)}*}
<div id="details"></div>
<div class="product_left" style="padding-top: 10px;">
{*2015-05-25改开始*}
<div class="package_information" style="margin-top: 0px;">
    <div class="package_title1" style="margin-top: 0px;">
        套餐详情
    </div>
    {foreach $page->detailTags as $k=> $v}
        {if $v['type']==1}
            {*<div class="table-responsive">*}
                {*<table class="table table-bordered">*}
                    {*<tr>*}
                        {*<th width="16%" style="background-color: #f8f8f8;">*}
                            {*活动场地*}
                        {*</th>*}
                        {*<th style="background-color: #f8f8f8;">*}
                            {*{$page->products[$v['id']]['product_name']}*}
                            {*<a href="{$_root}service_info/{$v['id']}.html" class="package_product"></a>*}
                        {*</th>*}
                    {*</tr>*}
                    {*{foreach $v['tags'] as $vk=>$vv}*}
                        {*<tr>*}
                            {*<td>*}
                                {*{$vk}*}
                            {*</td>*}
                            {*<td class="ir1">*}
                                {*{foreach $vv as $vvk=>$vvv}*}
                                    {*{if $page->products[$v['id']]['attr_new'][$vvk]}*}
                                        {*<span><c>{$vvv['tags_name']}</c>{$page->products[$v['id']]['attr_new'][$vvk]}</span>*}
                                    {*{/if}*}
                                {*{/foreach}*}
                            {*</td>*}
                        {*</tr>*}
                    {*{/foreach}*}
                    {*{if $page->products[$v['id']]['des']}*}
                        {*<tr>*}
                            {*<td>服务描述</td>*}
                            {*<td>*}
                                {*{$page->products[$v['id']]['des']}*}
                            {*</td>*}
                        {*</tr>*}
                    {*{/if}*}
                {*</table>*}
            {*</div>*}

            <div class="sdt" style="margin-top: 20px;">
                <div class="sdt_l">
                    活动场地
                </div>
                <div class="sdt_r">
                    {$page->products[$v['id']]['product_name']}<a href="{$_root}service_info/{$v['id']}.html" class="package_product"></a>
                </div>
                <div class="clearfix"></div>
            </div>
            {foreach $v['tags'] as $vk=>$vv}
            <div class="sdc">
                <div class="sdc_l">
                    {$vk}
                </div>
                <div class="sdc_r">
                    {foreach $vv as $vvk=>$vvv}
                    <ul>
                        {if $page->products[$v['id']]['attr_new'][$vvk]}
                            <li><span>{$vvv['tags_name']}：</span>{$page->products[$v['id']]['attr_new'][$vvk]}</li>
                        {/if}

                    </ul>
                    {/foreach}
                </div>

                <div class="clearfix"></div>
            </div>
            {/foreach}
            {if $page->products[$v['id']]['des']}
            <div class="sdc" style="border-bottom: none; padding-top: 14px;">
                <div class="sdc_l" style="line-height: 35px;">
                    服务描述
                </div>
                <div class="sdc_r" style="line-height: 35px;">
                    {$page->products[$v['id']]['des']}
                </div>

                <div class="clearfix"></div>
            </div>
            {/if}

        {else}
            <div class="package_title2" style="margin:30px 0px 0px;">
                配套详情
            </div>
            <div class="table-responsive" style="margin:20px 0px 0px;">
                <table>
                    <tr>
                        <th width="145" class="spf" style="border-bottom: none;">
                            {if $k==1}
                                <div class="spft">配套服务</div>
                            {else}
                                {$page->products[$v['id']]['product_name']}
                            {/if}
                        </th>
                        {foreach $v['ids'] as $vk=>$vv}
                            <th width="367" class="spf" style="border-bottom: none;">
                               <div class="spft1"> {$vv[0]}</div>
                            </th>
                        {/foreach}
                    </tr>
                    {foreach $v['tags'] as $vk=>$vv}
                        {if $page->products[$v['ids'][0][1]]['attr_new'][$vk]||$page->products[$v['ids'][1][1]]['attr_new'][$vk]}
                            <tr>
                                <td class="spf">{$page->allTags[$vk]}</td>
                                <td class="spf" style="padding-right: 15px;">
                                    {$page->products[$v['ids'][0][1]]['attr_new'][$vk]}
                                </td>
                                <td class="spf">
                                    {$page->products[$v['ids'][1][1]]['attr_new'][$vk]}
                                </td>
                            </tr>
                        {/if}
                    {/foreach}
                    {if $page->products[$v['ids'][0][1]]['des']&&$page->products[$v['ids'][1][1]]['des']&&$page->products[$v['ids'][0][1]]['des']!=$page->products[$v['ids'][1][1]]['des']}
                        <tr>
                            <td class="spf">其他</td>
                            <td class="spf" style="padding-right: 15px;">
                                {$page->products[$v['ids'][0][1]]['des']}
                            </td>
                            <td class="spf">
                                {$page->products[$v['ids'][0][1]]['des']}
                            </td>
                        </tr>
                    {/if}

                </table>
            </div>



        {/if}
    {/foreach}
</div>
<div id="case1"></div>
{if $page->eventInfo}
    <div class="case" style="margin-top: 50px;">
        <div class="package_title5">
            活动案例
        </div>
        <ul>
            {foreach $page->eventInfo as $key =>$val}
                <li style="padding-top: 10px;" class="package_case">
                    <div class="case_left">
                        <a href="{$_root}event_info/{$val['id']}.html">
                            <img src="{$val['case_logo']}">
                        </a>
                    </div>
                    <div class="case_right">
                        <p>
                            <a href="{$_root}event_info/{$val['id']}.html">{$val['case_name']}</a>
                        </p>

                        <div class="case_des">{$val['des']} </div>
                    </div>
                    <div class="clearfix"></div>
                </li>
            {/foreach}
        </ul>
    </div>
{/if}
<div id="remark"></div>
<div class="package_information">
    <div class="package_title3">
        服务备注
    </div>
    <div class="sft">
        1-预定流程
    </div>
    <div class="sfc">
        ①预定下单 → ②确认档期 → ③订单支付 → ④活动举办 → ⑤服务评价
    </div>
    <div class="sft">
        2-订单取消
    </div>
    <div class="sfc">
        ①订单支付前可随时取消订单。<br/>
        ②订单支付后取消订单（包括定金和尾款），则支付款项不予退还。
    </div>
    <div class="sft">
        3-订单变更
    </div>
    <div class="sfc">
        ①订单变更仅限于订单支付前进行活动档期的预定变更，订单支付后无法进行订单变更。<br/>
        ②订单变更后，服务人员需要重新确认变更后的活动档期，如活动档期确认可以变更，则确认订单变更操作成功；如活动档期确认无法变更，服务人员会推荐您同类型的套餐以供参考，原订单则按照订单取消流程进行后续操作。
    </div>
    <div class="sft">
        4-订单违约
    </div>
    <div class="sfc">
        ①如因我司或相关服务供应商原因，造成订单无法履行或造成损失时，我司将根据实际情况对于预定人进行赔偿。
    </div>
    {*<div class="information">*}

        {*<ul>*}
            {*<li>*}
                {*<div class="information_left">*}
                    {*预定流程*}
                {*</div>*}
                {*<div class="information_right2">*}
                    {*1.预定下单 → 2.确认档期 → 3.订单支付 → 4.活动举办 →*}
                    {*5.服务评价*}
                {*</div>*}
                {*<div class="clearfix"></div>*}
            {*</li>*}
            {*<li>*}
                {*<div class="information_left">*}
                    {*订单取消*}
                {*</div>*}
                {*<div class="information_right2">*}
                    {*1.订单支付前可随时取消订单。<br/>2.订单支付后取消订单（包括定金和尾款），则支付款项不予退还。*}
                {*</div>*}
                {*<div class="clearfix"></div>*}
            {*</li>*}
            {*<li>*}
                {*<div class="information_left">*}
                    {*订单变更*}
                {*</div>*}
                {*<div class="information_right2">*}
                    {*1.订单变更仅限于订单支付前进行活动档期的预定变更，订单支付后无法进行订单变更。<br/>*}

                    {*2.订单变更后，服务人员需要重新确认变更后的活动档期，如活动档期确认可以变更，则确认订单变更操作成功；如活动档期确认无法变更，服务人员会推荐您同类型的套餐以供参考，原订单则按照订单取消流程进行后续操作。*}

                {*</div>*}
                {*<div class="clearfix"></div>*}
            {*</li>*}
            {*<li>*}
                {*<div class="information_left">*}
                    {*订单违约*}
                {*</div>*}
                {*<div class="information_right2">*}
                    {*1.如因我司或相关服务供应商原因，造成订单无法履行或造成损失时，我司将根据实际情况对于预定人进行赔偿。*}

                {*</div>*}
                {*<div class="clearfix"></div>*}
            {*</li>*}
        {*</ul>*}
    {*</div>*}
</div>
<div id="notice"></div>
<div class="package_information">
    <div class="package_title4">
        预定须知
    </div>
    <div class="sft">
        1-预定条件
    </div>
    <div class="sfc">
        ①本套餐类产品只接受在产品有效期和指定日期内的活动档期预定。<br/>
        ②本套餐类产品只接受预定在下单日之后的5个工作日以上的活动档期。
    </div>
    <div class="sft">
        2-进场撤场
    </div>
    <div class="sfc">
        ①预定人及活动参与者如需要提前进场进行排练，演习等事宜，预定人须在活动档期起始日前的3个工作日之前提出申请，由云空间的活动服务人员协调处理。<br/>
        ②预定人及活动参与者须在活动预定档期的规定时间内进行撤场，如逾期未撤场，云空间将保留对预定人和活动参与者遗留物品进行处理的权利。
    </div>
    <div class="sft">
        3-服务说明
    </div>
    <div class="sfc">
        ①本套餐内产品仅提供服务清单内列明的活动服务项，不包含设计，策划，活动流程编排等服务内容。<br/>
        ②云空间的活动服务人员将全权负责，解答和处理所有预定人及活动参与者关于本产品服务的所有相关问题，事宜和服务提供方的协调工作。
    </div>
    <div class="sft">
        4-支付说明
    </div>
    <div class="sfc">
        ①预定人须在预定成功后的5个工作日内进行订单的定金支付（订单总金额的30%），如预定人未在期限内支付，我司服务人员会协调处理并保留取消订单的权利。<br/>
        ②预定人须在活动举办起始日前10个工作日之前进行订单尾款支付（订单总金额的70%），若自订单确认日与活动起始日之间不满10个工作日，则甲方须在5个工作日内一次性全款支付订单金额，如甲方未按时支付，乙方会协调处理并保留取消订单的权利。
    </div>
    <div class="sft">
        5-开票说明
    </div>
    <div class="sfc">
        ①云空间（上海星期网络科技有限公司）将会开立普通发票至预定人，发票类型为“服务类发票”，发票将会在活动举办结束日之后的三个工作日内寄出。
    </div>
    <div class="sft">
        6-责任保障
    </div>
    <div class="sfc">
        ①我司线上支付合作方为第三方支付机构：银联在线，汇付天下。预定人在订单支付时，银行端显示的支付对象应为：上海银联电子支付服务有限公司，上海汇付数据服务有限公司。
    </div>
    <div class="sft">
        7-权利义务
    </div>
    <div class="sfc">
        ①权利：预定人和活动参与者如在活动举行期间，如对活动，人员和服务有意见和不满，可以通过400客户服务热线进行咨询，投诉等相关操作的权利。<br/>
        ②义务：预定人和活动参与者须在活动举行期间，遵守云空间活动服务人员的协调和安排，以保障现场活动秩序和活动设施物品的完好使用及保存。
    </div>
    <div class="sft">
        8-不可抗力
    </div>
    <div class="sfc">
        ①因不可抗力(包括地震、台风、雷击、雪灾、水灾、火灾等自然原因,以及战争、政府行为、黑客攻击、电信部门技术管制等原因)和意外事件等原因不能履行或不能继续履行已生效订单约定内容的，双方均不承担违约责任，但法律另有规定的除外。
    </div>
    <div class="sft">
        9-交易申明
    </div>
    <div class="sfc">
        ①本套餐为云空间自营产品，最终解释权归属云空间平台（上海星期网络科技有限公司）所有。
    </div>
    {*<div class="information">*}
        {*<ul>*}
            {*<li>*}
                {*<div class="information_left">*}
                    {*预定条件*}
                {*</div>*}
                {*<div class="information_right2">*}
                    {*1.本套餐类产品只接受在产品有效期和指定日期内的活动档期预定。<br/>*}

                    {*2.本套餐类产品只接受预定在下单日之后的5个工作日以上的活动档期。*}

                {*</div>*}
                {*<div class="clearfix"></div>*}
            {*</li>*}
            {*<li>*}
                {*<div class="information_left">*}
                    {*进场撤场*}
                {*</div>*}
                {*<div class="information_right2">*}
                    {*1.预定人及活动参与者如需要提前进场进行排练，演习等事宜，预定人须在活动档期起始日前的3个工作日之前提出申请，由云空间的活动服务人员协调处理。<br/>*}
                    {*2.预定人及活动参与者须在活动预定档期的规定时间内进行撤场，如逾期未撤场，云空间将保留对预定人和活动参与者遗留物品进行处理的权利。*}
                {*</div>*}
                {*<div class="clearfix"></div>*}
            {*</li>*}
            {*<li>*}
                {*<div class="information_left">*}
                    {*服务说明*}
                {*</div>*}
                {*<div class="information_right2">*}
                    {*1.本套餐内产品仅提供服务清单内列明的活动服务项，不包含设计，策划，活动流程编排等服务内容。<br/>*}
                    {*2.云空间的活动服务人员将全权负责，解答和处理所有预定人及活动参与者关于本产品服务的所有相关问题，事宜和服务提供方的协调工作。*}

                {*</div>*}
                {*<div class="clearfix"></div>*}
            {*</li>*}
            {*<li>*}
                {*<div class="information_left">*}
                    {*支付说明*}
                {*</div>*}
                {*<div class="information_right2">*}
                    {*1.预定人须在预定成功后的5个工作日内进行订单的定金支付（订单总金额的30%），如预定人未在期限内支付，我司服务人员会协调处理并保留取消订单的权利。<br/>*}
                    {*2.预定人须在活动举办起始日前10个工作日之前进行订单尾款支付（订单总金额的70%），若自订单确认日与活动起始日之间不满10个工作日，则甲方须在5个工作日内一次性全款支付订单金额，如甲方未按时支付，乙方会协调处理并保留取消订单的权利。*}

                {*</div>*}
                {*<div class="clearfix"></div>*}
            {*</li>*}
            {*<li>*}
            {*<div class="information_left">*}
            {*退款说明*}
            {*</div>*}
            {*<div class="information_right2">*}
            {*1.如发生订单取消情况，退款款项将在订单取消日之后的5个工作日内退还至预订人付款的银行卡账户。*}

            {*</div>*}
            {*<div class="clearfix"></div>*}
            {*</li>*}
            {*<li>*}
                {*<div class="information_left">*}
                    {*开票说明*}
                {*</div>*}
                {*<div class="information_right2">*}
                    {*1.云空间（上海星期网络科技有限公司）将会开立普通发票至预定人，发票类型为“服务类发票”，发票将会在活动举办结束日之后的三个工作日内寄出。*}
                {*</div>*}
                {*<div class="clearfix"></div>*}
            {*</li>*}
            {*<li>*}
                {*<div class="information_left">*}
                    {*责任保障*}
                {*</div>*}
                {*<div class="information_right2">*}
                    {*1.我司线上支付合作方为第三方支付机构：银联在线，汇付天下。预定人在订单支付时，银行端显示的支付对象应为：上海银联电子支付服务有限公司，上海汇付数据服务有限公司。*}

                {*</div>*}
                {*<div class="clearfix"></div>*}
            {*</li>*}
            {*<li>*}
                {*<div class="information_left">*}
                    {*权利义务*}
                {*</div>*}
                {*<div class="information_right2">*}
                    {*1.权利：预定人和活动参与者如在活动举行期间，如对活动，人员和服务有意见和不满，可以通过400客户服务热线进行咨询，投诉等相关操作的权利。<br/>*}

                    {*2.义务：预定人和活动参与者须在活动举行期间，遵守云空间活动服务人员的协调和安排，以保障现场活动秩序和活动设施物品的完好使用及保存。*}


                {*</div>*}
                {*<div class="clearfix"></div>*}
            {*</li>*}
            {*<li>*}
                {*<div class="information_left">*}
                    {*不可抗力*}
                {*</div>*}
                {*<div class="information_right2">*}
                    {*1.因不可抗力(包括地震、台风、雷击、雪灾、水灾、火灾等自然原因,以及战争、政府行为、黑客攻击、电信部门技术管制等原因)和意外事件等原因不能履行或不能继续履行已生效订单约定内容的，双方均不承担违约责任，但法律另有规定的除外。*}

                {*</div>*}
                {*<div class="clearfix"></div>*}
            {*</li>*}
            {*<li>*}
                {*<div class="information_left">*}
                    {*交易申明*}
                {*</div>*}
                {*<div class="information_right2">*}
                    {*1.本套餐为云空间自营产品，最终解释权归属云空间平台（上海星期网络科技有限公司）所有。*}
                {*</div>*}
                {*<div class="clearfix"></div>*}
            {*</li>*}
        {*</ul>*}
    {*</div>*}

{*2015-05-25改结束*}
</div>
</div>
<div class="product_right" style="margin-top: 10px;">

    <div class="showDate border1">
        <div id="showDate">

        </div>
        <div class="datp clearfix">
            <div class="c1">
                <span></span>

                <p>已预定</p>
            </div>
            {*<div class="c2">*}
            {*<span></span>*}

            {*<p>意向预定</p>*}
            {*</div>*}
            <div class="c3">
                <span></span>

                <p>未预定</p>
            </div>
        </div>
    </div>

    <div class="case_title group_title">
        <i class="fa fa-thumbs-up"></i>&nbsp;推荐视频制作/拍摄和后期剪辑
    </div>
    <div class="product_right_body ">
        <div class="t_content2">
            <a href="/vendor_info/168.html" target="_blank">
                <img src="http://www.yunspace.com.cn/uploads/200_200/201502/o_19f7nh0forh1sm91mjcnie97ca.jpg">
            </a>
            <a href="/vendor_info/168.html" target="_blank"><span>上海临境文化传播有限公司</span></a>
        </div>
        <div class="t_content2">
            <a href="/vendor_info/3150.html" target="_blank">
                <img src="http://www.yunspace.com.cn/uploads/200_200/201504/o_19jg5plos18hlp0i5gc1iji185n8.jpg">
            </a>
            <a href="/vendor_info/3150.html" target="_blank"><span>上海豫龙文化传播有限公司 </span></a>
        </div>
        <div class="t_content2">
            <a href="/vendor_info/3046.html" target="_blank">
                <img src="http://www.yunspace.com.cn/uploads/275_195/201504/o_19j0gsbrhu7o1n7queluiie89b.png">
            </a>
            <a href="/vendor_info/3046.html" target="_blank"><span>上海安果文化传播有限公司</span></a>
        </div>
    </div>
    <div class="case_title group_title">
        <i class="fa fa-thumbs-up"></i>&nbsp;推荐餐饮外烩
    </div>
    <div class="product_right_body ">
        <div class="t_content2">
            <a href="/vendor_info/2975.html" target="_blank">
                <img src="http://www.yunspace.com.cn/uploads/200_200/201505/i_5552f94f698f1.jpg">
            </a>
            <a href="/vendor_info/2975.html" target="_blank"><span>上海蓝森宴会餐饮有限公司</span></a>
        </div>
    </div>
    <div class="case_title group_title">
        <i class="fa fa-thumbs-up"></i>&nbsp;推荐租车服务
    </div>
    <div class="product_right_body ">
        <div class="t_content2">
            <a href="/vendor_info/2835.html" target="_blank">
                <img src="http://www.yunspace.com.cn/uploads/275_195/201503/o_19haimc7knov1gkmrqr195s1bi77.JPG">
            </a>
            <a href="/vendor_info/2835.html" target="_blank"><span>上海佰胜汽车租赁有限公司</span></a>
        </div>
        <div class="t_content2">
            <a href="/vendor_info/150.html" target="_blank">
                <img src="http://www.yunspace.com.cn/uploads/275_195/201503/o_19hacjm4g4u71jturk11nuc1hjrb.jpg">
            </a>
            <a href="/vendor_info/150.html" target="_blank"><span>上海睿派汽车租赁服务有限公司 1</span></a>
        </div>
    </div>
    <div class="case_title group_title">
        <i class="fa fa-thumbs-up"></i>&nbsp;推荐安保服务
    </div>
    <div class="product_right_body ">
        <div class="t_content2">
            <a href="/vendor_info/2568.html" target="_blank">
                <img src="http://www.yunspace.com.cn/uploads/275_195/201503/o_19gooffcmdtq1fpn14fc15rc1v4td.jpg">
            </a>
            <a href="/vendor_info/2568.html" target="_blank"><span>上海市保安服务总公司</span></a>
        </div>
    </div>
</div>
<div class="clearfix"></div>

{*<script type="text/javascript" src="js/jquery.js"></script>*}


{*<script type="text/javascript" src="js/fullcalendar.min.js"></script>*}
<script type="text/javascript" src="js/bootstrap-datetimepicker.js"></script>
<script type="text/javascript" src="js/jquery.lightSlider.js"></script>
<script type="text/javascript" src="js/moment.min.js"></script>


<script type="text/javascript" src='js/fullcalendar.js'></script>
<script src='js/jquery.fancybox.js'></script>
{*<script src='js/jquery.fancybox.pack.js'></script>*}
<script src='js/collect.js'></script>

<script type="text/javascript">
    $(document).ready(function () {
        var showDate = $('#showDate').fullCalendar({
            header: {
                left: 'prev',
                center: 'title',
                right: 'next'
            },
            // start: '2015-02-01',
            // defaultDate: '2015-02-12',
            aspectRatio: 1,
            height: 500,
            contentHeight: 300,
            editable: true,
            timezone: true,
            eventLimit: true, // allow "more" link when too many events
            dayNamesShort: [
                '日', '一', '二', '三', '四', '五', '六'
            ],
            events: '{$_root}json_product_schedule/?product_id={$page->id}',
            monthNamesShort: [
                '一月', '二月', '三月', '四月', '五月', '六月', '七月', '八月', '九月', '十月', '十一月', '十二月'

            ],
            monthNames: [
                '一月', '二月', '三月', '四月', '五月', '六月', '七月', '八月', '九月', '十月', '十一月', '十二月'
            ]
        });

    });
    $(document).ready(function () {
        $('.one').show();
    });
</script>


</div>
{include file="inc/html_share.tpl"}
{include file="inc/html_demand_ask.tpl"}
{include file="Web_Static::v2.0/html_footer.tpl"}
</body>
</html>