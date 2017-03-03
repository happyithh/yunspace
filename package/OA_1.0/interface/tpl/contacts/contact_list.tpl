<style>
    @media (max-width: 520px) {
        .list_none {
            display: none;
        }

        .table-responsive table tbody tr td {
            white-space: inherit !important;
        }

    }
</style>
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


<div class="portlet tabbable">
    <div class="portlet-title">
        <div class="caption">
            <i class="fa fa-search"></i>搜索条件
        </div>
    </div>
    <div class="portlet-body">
        <div class="portlet-tabs">
            <ul class="nav nav-tabs"
                style="overflow: inherit; padding-left: 100px">
                <li style="padding: 5px 4px 0 0">
                    <div>
                        {if $is_my}
                            <a class="btn btn-success"
                               href="{$_route}contact_detail?action=add&type={$_REQUEST['type']|default:1}&is_my=1"><i
                                        class="fa fa-plus"></i>添加我的联系人</a>
                        {else}
                            <a class="btn btn-success"
                               href="{$_route}contact_detail?action=add&type={$_REQUEST['type']|default:1}"><i
                                        class="fa fa-plus"></i>添加公共联系人</a>
                        {/if}
                    </div>
                </li>
            </ul>
            <div class="clearfix"></div>
            <div>
                <form action="?" method="get" class="clearfix">
                    <div class="form-body clearfix">
                        <div id="businessWrap">
                            <div class="col-md-5">
                                <div class="form-group col-md-12" style="padding:0">
                                    <label class="col-md-3 control-label">业务类型</label>

                                    <div class="col-md-9">
                                        <select class="form-control input-sm" name="search[business]" id="business">
                                            {if $_REQUEST['search']['business']}
                                                <option value="{$_REQUEST['search']['business']}">
                                                    {$_REQUEST['search']['business']}
                                                </option>
                                            {else}
                                                <option value="">
                                                    请选择
                                                </option>
                                            {/if}
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-5">
                                <div class="form-group col-md-12" style="padding:0">
                                    <label class="col-md-3 control-label sub_business">业务子类</label>

                                    <div class="col-md-9">
                                        <select class="form-control input-sm" disabled name="search[sub_business]"
                                                id="subBusiness">
                                            {if $_REQUEST['search']['sub_business']}
                                                <option value="{$_REQUEST['search']['sub_business']}">
                                                    {$_REQUEST['search']['sub_business']}
                                                </option>
                                            {else}
                                                <option value="">
                                                    请先选择业务类型
                                                </option>
                                            {/if}
                                        </select>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">姓名</label>

                            <div class="col-md-9">
                                <input type="text" class="form-control input-sm" placeholder="姓名"
                                       name="search[username]" value="{$_REQUEST['search']['username']}">
                            </div>
                        </div>
                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">手机号码</label>

                            <div class="col-md-9">
                                <input type="text" class="form-control input-sm" placeholder="手机号码" name="search[phone]"
                                       value="{$_REQUEST['search']['phone']}">
                            </div>
                        </div>
                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">公司/场地</label>

                            <div class="col-md-9">
                                <input type="text" class="form-control input-sm" placeholder="公司" name="search[company]"
                                       value="{$_REQUEST['search']['company']}">
                            </div>
                        </div>
                        {if $is_my == 1 || !$is_my }
                        <div class="form-group col-md-5">
                        </div>
                        {else}
                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">负责人</label>
                            <div class="col-md-9">
                                <select class="form-control input-sm" name="search[admin_id]">
                                    <option value=0>全部</option>
                                    {foreach $admin_name as $key=>$value}
                                        <option {if {$_REQUEST['search']['admin_id']==$key}}selected {/if}
                                                value="{$key}">{$value}</option>
                                    {/foreach}
                                </select>
                            </div>
                        </div>
                        {/if}
                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">分级</label>

                            <div class="col-md-9">
                                <select class="form-control input-sm" name="search[state]">
                                    <option value=0>全部</option>
                                    {foreach $state as $key=>$value}
                                        <option {if {$_REQUEST['search']['state']==$key}}selected {/if}
                                                value="{$key}">{$value}</option>
                                    {/foreach}
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="form-actions">
                        <div class="" style="text-align: center">
                            <button type="submit" class="btn btn-primary" style="width: 150px">
                                <i class="fa fa-search"></i>
                                搜索
                            </button>
                        </div>
                    </div>
                </form>
            </div>

        </div>
    </div>
</div>
<div class="portlet">
    <div class="portlet-title">
        <div class="caption">
            {if $is_my==1}
                <i class="fa fa-comments"></i>
                我的联系人列表
            {elseif $is_my==2}
                <i class="fa fa-comments"></i>
                部门联系人列表
            {elseif $is_my==3}
                <i class="fa fa-comments"></i>
                组联系人列表
            {elseif $is_urgent}
                <i class="fa fa-comments"></i>
                紧急联系人列表
            {else}
                <i class="fa fa-comments"></i>
                公共联系人列表
            {/if}
        </div>
    </div>
    <div class="portlet-body">
        <div class="table-responsive clearfix">
            <table class="table table-striped table-bordered table-hover" id="data_table" style="word-break: break-all">
                <thead>
                <tr>
                    <th>ID</th>
                    <th class="list_none">分级</th>
                    <th>联系人</th>
                    <th class="list_none">城市</th>
                    <th class="list_none">联系业务</th>
                    <th class="list_none">业务子类</th>
                    <th width="25%">公司/场地</th>
                    <th class="list_none">公司职位</th>
                    <th class="list_none">账号状态</th>
                    <th>负责人</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                {foreach $_data['rows'] as $k=>$v}
                    <tr role="row">
                        <td style="font-size: 14px;">{$v['id']}</td>
                        <td class="list_none" style="font-size: 14px;">{$state[$v['state']]}</td>
                        <td style="font-size: 14px;">
                            {$v['username']}
                            {if (time()- $v['new_demand_time'])<= 86400*5}
                                {if $is_urgent==1||$is_my}
                                    <a href="?id={$v['id']}&phone={$v['phone']}&tab=3{if !empty($v['admin_name'])}&admin_name={$v['admin_name']}{/if}"
                                       class="btn btn-xs btn-warning">新需求:{Func_Time::format($v['new_demand_time'])}</a>
                                {/if}
                            {/if}
                        </td>
                        <td class="list_none" style="font-size: 14px;">{$v['city']}</td>
                        <td class="list_none" style="font-size: 14px;">{$v['business']}</td>
                        <td class="list_none" style="font-size: 14px;">{$v['sub_business']}</td>
                        <td style="font-size: 14px;">{if $v['vendor_id']}
                                <span class="label label-primary">
                                {$v['vendor_name']}
                                    > {$v['product_name']}</span>
                                <br/>
                                {$v['company']}{else}{$v['company']}{/if}
                        </td>
                        <td class="list_none" style="font-size: 14px;">{$v['position']}</td>
                        <td class="list_none" style="font-size: 14px;">
                            {if $v['account_id']}
                                已绑定
                                {if $is_urgent==1||$is_my}
                                    <a class="btn btn-success btn-xs"
                                       href="?action=detail&id={$v['account_id']}">查看客户信息</a>
                                {/if}
                            {else}
                                未绑定
                            {/if}
                        </td>
                        <td style="font-size: 14px;">
                            {if $is_urgent==1}
                                <a href="?search[admin_id]={if isset($_adminInfo[$v['admin_id']])}{$v['admin_id']}{/if}">{$_adminInfo[$v['admin_id']]|default:'未领取'}</a>
                            {else}
                            <a href="?search[admin_id]={$v['admin_id']}">{$v['admin_name']|default:'未领取'}</a>
                            {/if}
                        </td>
                        <td style="font-size: 14px;">
                            {if $v['phone']}
                                {*如果是紧急联系人*}
                                {if $is_urgent==1}
                                    <a href="?id={$v['id']} &admin_name={$v['admin_name']}" class="btn btn-info btn-xs"><i
                                                class="fa fa-eye"></i>
                                        分配</a>
                                {else}
                                    {if $v['creator_id']==$my_admin_id || $is_my==2}
                                        <a href="?id={$v['id']}&tab=edit" class="btn btn-success btn-xs"><i
                                                    class="fa fa-pencil"></i>
                                            修改</a>
                                    {/if}
                                    {if $is_my}
                                        <a href="?id={$v['id']}" class="btn btn-info btn-xs"><i class="fa fa-eye"></i>
                                            查看</a>
                                        <a href="?action=remove&id={$v['id']}&admin_id={$v['admin_id']}"
                                           class="btn btn-danger btn-xs"><i class="fa fa-times"></i>
                                            释放</a>
                                    {elseif $is_my==0}
                                        {if !$v['admin_name']}
                                            <a href="?action=get&id={$v['id']}" class="btn btn-primary btn-xs">
                                                <i class="fa fa-check"></i>
                                                领取
                                            </a>
                                        {/if}
                                        {if $is_admin}
                                            <a href="contact_urgent_list?id={$v['id']}&admin_name={$v['admin_name']}"
                                               class="btn btn-info btn-xs"><i class="fa fa-external-link"></i>
                                                分配</a>
                                        {/if}
                                    {/if}
                                {/if}
                            {/if}
                        </td>
                    </tr>
                {/foreach}
                </tbody>
            </table>
            <div class="pull-left" style="width:30%; padding: 10px 0;">

            </div>
            <div class="pull-right">
                <ul class="pagination">
                    {if $_data['page']['dpll']}
                        <li class="prev">
                            <a href="{$_data['page']['dup']}1" title="First"><i class="fa fa-angle-double-left"></i></a>
                        </li>
                        <li class="prev">
                            <a href="{$_data['page']['dup']}{$_data['page']['dp']-1}" title="Prev"><i
                                        class="fa fa-angle-left"></i></a>
                        </li>
                    {else}
                        <li class="prev disabled">
                            <a href="#" title="First"><i class="fa fa-angle-double-left"></i></a>
                        </li>
                        <li class="prev disabled">
                            <a href="#" title="Prev"><i class="fa fa-angle-left"></i></a>
                        </li>
                    {/if}
                    {for $i=$_data['page']['dpl'] to $_data['page']['dpr']}
                        <li{if $i==$_data['page']['dp']} class="active"{/if}>
                            <a href="{$_data['page']['dup']}{$i}">{$i}</a>
                        </li>
                    {/for}
                    <li class="disabled">
                        <a> {$_data['page']['dtp']}
                            ( {$_data['page']['dp']*$_data['page']['dn']}
                            /{$_data['page']['dt']} )</a>
                    </li>

                    {if $_data['page']['dprr']}
                        <li class="next">
                            <a href="{$_data['page']['dup']}{$_data['page']['dp']+1}" title="Next"><i
                                        class="fa fa-angle-right"></i></a>
                        </li>
                        <li class="next">
                            <a href="{$_data['page']['dup']}{$_data['page']['dtp']}" title="Last"><i
                                        class="fa fa-angle-double-right"></i></a>
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

<!-- BEGIN JAVASCRIPTS(Load javascripts at bottom, this will reduce page load time) -->
<!-- BEGIN CORE PLUGINS -->
<script src="{$_assets}plugins/jquery-1.11.0.min.js"
        type="text/javascript"></script>
<script src="{$_assets}scripts/_page.js"></script>
<script>
    var category = [
        {foreach $categoryList[0] as $k=>$v}
        {if $v}
        {
            'b': '{$k}{$v}',
            's': [
                {foreach $categoryList[$k] as $kk=>$vv}{if $vv}
                '{$kk}{$vv}',
                {/if}{/foreach}
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
        sHtml = "<option value=''>请选择</option>";
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