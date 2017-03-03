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
<!-- END HEAD -->
<!-- BEGIN BODY -->

<body style="background:#FaFaFa !important">


<div class="portlet">
    <div class="portlet-title">
        <div class="caption">
            <i class="fa fa-comments"></i>
            {$list_title}
        </div>
    </div>
    <div class="portlet-body">
        <div class="table-responsive clearfix">
            <div>
                <ul class="nav nav-tabs">
                    <li{if !$_REQUEST['type']} class="active"{/if}>
                        <a href="?">待审核</a>
                    </li>
                    <li{if $_REQUEST['type']=='is_check'} class="active"{/if}>
                        <a href="?type=is_check">已收</a>
                    </li>
                    <li{if $_REQUEST['type']=='is_error'} class="active"{/if}>
                        <a href="?type=is_error">未收</a>
                    </li>
                </ul>
            </div>
            <style>
                .month_div{
                    margin-bottom: 10px;;
                }
                .month_div a:hover{
                    color:#777;
                    text-decoration: none;
                }
                .month_div a.active{
                    color:#777;
                }
                .month_div .hide_month{
                    display: none;
                }
            </style>
            <div class="month_div">
                {foreach $month as $k=>$v}
                    {if $k>5}
                        <span class="hide_span hide_month">
                            <a href="?type={$_REQUEST['type']}&month={$v}"  class="btn btn-default btn-xs {if strtotime($_REQUEST['month'])==strtotime($v)}active{/if}">&nbsp;{$v}&nbsp;</a>
                        </span>
                    {else}
                        <a href="?type={$_REQUEST['type']}&month={$v}"  class="btn btn-default btn-xs {if strtotime($_REQUEST['month'])==strtotime($v)}active{/if}">&nbsp;{$v}&nbsp;</a>
                    {/if}
                {/foreach}
                {if count($month) > 5}
                    <span class="btn btn-default btn-xs month_more"><i class="fa fa-plus-square" style="margin-right: 5px;"></i>查看更多</span>
                {/if}
            </div>
            <table class="table table-striped table-bordered table-hover" id="data_table" style="word-break: break-all">
                <thead>
                <tr>
                    <th>#</th>
                    <th>到账金额</th>
                    <th>手续费</th>
                    <th>付款方</th>
                    <th>收款方</th>
                    <th>合同</th>
                    <th>时间</th>
                    <th>状态</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                {foreach $list as $k=>$v}
                    <tr role="row">
                        <td>
                            {$v['detail']['payment_no']}
                        </td>
                        <td>{substr($v['amount'],1)}</td>
                        <td>{intval(($v['amount']+$v['detail']['amount'])*100)/100}</td>
                        <td>{$v['detail']['buyer_account']}</td>
                        <td>{$v['detail']['vendor_account_name']}</td>
                        <td>{$v['detail']['payment_title']}</td>
                        <td>{Func_Time::format($v['create_time'])}</td>
                        <td>{$v['category']}</td>
                        <td>
                            {if $v['confirm_time']<=0}
                                <a href="?id={$v['create_time']}-{$v['id']}&action=income_receive" class="btn btn-success btn-xs"><i class="fa fa-check"></i>
                                    已收</a>
                            {/if}
                            {if $v['confirm_time']>=0}
                                <a href="?id={$v['create_time']}-{$v['id']}&action=income_error" class="btn btn-danger btn-xs"><i class="fa fa-times"></i>
                                    未收</a>
                            {/if}
                        </td>
                    </tr>
                {/foreach}
                </tbody>
            </table>
        </div>
    </div>
</div>

<!-- BEGIN JAVASCRIPTS(Load javascripts at bottom, this will reduce page load time) -->
<!-- BEGIN CORE PLUGINS -->
<script src="{$_assets}plugins/jquery-1.11.0.min.js"
        type="text/javascript"></script>
<script src="{$_assets}scripts/app.js"></script>
<script src="{$_assets}scripts/_page.js"></script>
<script>
    jQuery(document).ready(function () {
        App.init();
    });
    //月份显示月隐藏
    if($('.month_div .hide_span a.active').length > 0){
        $('.month_div .hide_span').removeClass('hide_month');
        $('.month_more').hide();
    }
    if($('.month_div .hide_span').hasClass('hide_month')){
        $('.month_more').text('查看更多');
    }
    $('.month_more').click(function(){
        $('.month_div .hide_month').show();
        $('.month_more').hide();
    })
    var category = [
        {foreach $categoryList[0] as $k=>$v}
        {if $v}
        {
            'b': '{$k}{$v}',
            's': [
                {foreach $categoryList[$k] as $kk=>$vv}
                '{$kk}{$vv}',
                {/foreach}
            ]
        },
        {/if}
        {/foreach}
    ];

    var bHtml = '<option value="{$_REQUEST['search']['business']|default:''}">{$_REQUEST['search']['business']|default:'请选择'}</option>';
    $('#business').change(function () {
        var index = $('#business').get(0).selectedIndex - 1;
        if (index >= 0) {
            oSubBusiness(index);
        } else {
            {if !$_REQUEST['search']['sub_business']}
            $('#subBusiness').attr("disabled", true);
            {/if}
            $('#subBusiness').html('<option>{$_REQUEST['search']['sub_business']|default:'请先选择业务类型'}</option>');
        }

    })
    for (var i = 0; i < category.length; i++) {
        bHtml += "<option value='" + category[i]['b'] + "'>" + category[i]['b'] + "</option>";
    }

    var oSubBusiness = function (i) {
        var oSubBusinessList = category[i]['s'], sHtml;
        for (var j = 0; j < category[i]['s'].length; j++) {
            sHtml += "<option value='" + category[i]['s'][j] + "'>" + category[i]['s'][j] + "</option>";
        }
        $('#subBusiness').html(sHtml);
        $('#subBusiness').removeAttr('disabled')
    }

    $('#business').html(bHtml);

    {*$('#business').cxSelect({*}
    {*url:'{$_route}productCategoryListJson',*}
    {*url:'{$_assets}json/test.json',*}
    {*required:true,*}
    {*selects: ['business', 'sub_business'],*}
    {*nodata: 'none'*}
    {*});*}
</script>
</body>
<!-- END BODY -->
</html>