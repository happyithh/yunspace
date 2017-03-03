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
    <link href="style/media.css" rel="stylesheet"/>
</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->

<body style="background:#FaFaFa !important">

<div class="portlet tabbable">
    <div class="portlet-title">
        <div class="caption">
            <i class="fa fa-database"></i>当前共负责
            <span style="color: #ff0000">{$_data['page']['dt']}</span>
            个{if $_REQUEST['type']==21}供应商{else}客户{/if}
        </div>
    </div>
    <div class="portlet-body">
        <form action="?" method="get">
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
                                <select class="form-control input-sm" disabled name="search[sub_business]" id="subBusiness">
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
                    <label class="col-md-3 control-label">名称</label>

                    <div class="col-md-9">
                        <input type="text" class="form-control input-sm" placeholder="名称" name="search[username]" value="{$_REQUEST['search']['username']}">
                    </div>
                </div>
                <div class="form-group col-md-5">
                    <label class="col-md-3 control-label">手机号码</label>

                    <div class="col-md-9">
                        <input type="text" class="form-control input-sm" placeholder="手机号码" name="search[phone]" value="{$_REQUEST['search']['phone']}">
                    </div>
                </div>
            </div>
            <div class="form-actions" style="margin-top: 0">
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

<div class="portlet">
    <div class="portlet-title">
        <div class="caption">
            <i class="fa fa-comments"></i>我的{if $_REQUEST['type']==21}供应商账户{else}客户{/if}
            列表
        </div>
    </div>
    <div class="portlet-body">
        <div class="table-responsive clearfix">
            <table class="table table-striped table-bordered table-hover" id="data_table" style="word-break: break-all">
                <thead>
                <tr>
                    <th class="list_none">#ID</th>
                    <th>联系人</th>
                    <th>手机号码</th>
                    <th>{if $_REQUEST['type']==21}供应商{else}客户{/if}名称
                    </th>
                    <th class="list_none">服务类型</th>
                    <th>实名认证</th>
                    <th>负责人</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                {foreach $_data['rows'] as $k=>$v}
                    <tr role="row">
                        <td class="list_none">{$v['id']}</td>
                        <td>
                            {$v['name']}
                            {if (time()- $v['new_demand_time'])<= 10*60}
                                <a href="contact_detail?id={$v['contact_id']}&phone={$v['phone']}&tab=3" class="btn btn-xs btn-warning">有新需求</a>
                            {/if}
                        </td>
                        <td>{$v['phone']}</td>
                        <td>{$v['fullname']}
                            ({$v['username']})
                        </td>
                        <td class="list_none">{$v['business']}</td>
                        <td>{if $v['identity_time']>0}已认证{elseif $v['identity_time']<-1}待认证{else}未通过{/if}</td>
                        <td>{$v['admin_name']}</td>
                        <td>
                            <a href="?action=detail&id={$v['id']}" class="btn btn-info btn-xs"><i class="fa fa-eye"></i>
                                查看</a>
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
                            <a href="{$_data['page']['dup']}{$_data['page']['dp']-1}" title="Prev"><i class="fa fa-angle-left"></i></a>
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
                            <a href="{$_data['page']['dup']}{$_data['page']['dp']+1}" title="Next"><i class="fa fa-angle-right"></i></a>
                        </li>
                        <li class="next">
                            <a href="{$_data['page']['dup']}{$_data['page']['dtp']}" title="Last"><i class="fa fa-angle-double-right"></i></a>
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


<script src="{$_assets}plugins/jquery-1.11.0.min.js" type="text/javascript"></script>
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