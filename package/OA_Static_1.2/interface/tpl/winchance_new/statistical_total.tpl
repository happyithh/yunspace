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
    <link href="style/media.css" rel="stylesheet"/>
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
            <div class="clearfix"></div>
            <div>
                <form action="?" method="post" class="clearfix">

                    <div class="form-body clearfix">
                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">场地名称</label>

                            <div class="col-md-5">
                                <input type="text" class="form-control input-sm" placeholder="场地名称" name="search[site_name]"
                                       value="{$_REQUEST['search']['site_name']}">
                            </div>
                        </div>
                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">工作状态</label>

                            <div class="col-md-5">
                                <select class="form-control input-sm" name="search[step]">
                                    <option value=0>全部</option>
                                    {foreach $step as $key=>$val}
                                        <option value="{$key}"
                                                {if $_REQUEST['search']['step'] == $key}selected{/if}>{$key}</option>
                                    {/foreach}
                                </select>
                            </div>
                        </div>
                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">场地类型</label>

                            <div class="col-md-5">
                                <select class="form-control input-sm" name="search[site_type]">
                                    <option value=0>全部</option>
                                    {foreach $site_type as $val}
                                        <option value="{$val}"
                                                {if $_REQUEST['search']['site_type'] == $val}selected{/if}>{$val}</option>
                                    {/foreach}
                                </select>
                            </div>
                        </div>
                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">负责人</label>

                            <div class="col-md-5">
                                <select class="form-control input-sm" name="search[operator]">
                                    <option value=0>全部</option>
                                    <option {if $_REQUEST['search']['operator']=='Applecheng'}selected{/if} value="Applecheng">Applecheng</option>
                                    <option {if $_REQUEST['search']['operator']=='angee'}selected{/if} value="angee">angee</option>
                                    <option {if $_REQUEST['search']['operator']=='yvon'}selected{/if} value="yvon">yvon</option>
                                    <option {if $_REQUEST['search']['operator']=='kingsley'}selected{/if} value="kingsley">kingsley</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">城市</label>

                            <div class="col-md-5">
                                <select class="form-control input-sm" name="search[city]">
                                    <option value=0>全部</option>
                                    {foreach $citys as $value}
                                        <option {if $value==$_REQUEST['search']['city']}selected {/if}
                                                value="{$value}">{$value}</option>
                                    {/foreach}
                                </select>
                            </div>
                        </div>
                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">录入类型</label>

                            <div class="col-md-5">
                                <select class="form-control input-sm" name="search[entry_type]">
                                    <option value=0>全部</option>
                                    <option {if $_REQUEST['search']['entry_type']==1}selected{/if} value=1>线上</option>
                                    <option {if $_REQUEST['search']['entry_type']==2}selected{/if} value=2>线下</option>

                                </select>
                            </div>
                        </div>
                        {*<div class="form-group col-md-5">*}
                            {*<label class="col-md-3 control-label">创建时间</label>*}

                            {*<div class="col-md-4">*}
                                {*<input type='text' class="form-control date" placeholder="请选择开始时间"*}
                                       {*name="search[start_time]" value="{$_REQUEST['search']['start_time']}"/>*}
                            {*</div>*}
                            {*<div class="col-md-4 ">*}
                                {*<input type='text' class="form-control date" placeholder="请选择结束时间"*}
                                       {*name="search[end_time]" value="{$_REQUEST['search']['end_time']}"/>*}
                            {*</div>*}
                        {*</div>*}
                    </div>
                    <div class="form-actions">
                        <div class="" style="text-align: center">
                            <button type="submit" class="btn btn-primary" style="width: 150px">
                                <i class="fa fa-search"></i>
                                搜索
                            </button>
                            <a href="?type=export{if isset($_REQUEST['search'])}&search[site_name]={$_REQUEST['search']['site_name']}&search[step]={$_REQUEST['search']['step']}&search[site_type]={$_REQUEST['search']['site_type']}&search[operator]={$_REQUEST['search']['operator']}&search[city]={$_REQUEST['search']['city']}&search[entry_type]={$_REQUEST['search']['entry_type']}{/if}" class="btn btn-success export" style="width: 150px;margin-left: 20px;">
                                <i class="fa fa-sign-out"></i>
                                导出
                            </a>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<style>
    .step_content {
        height: auto;
        overflow: hidden;
        background-color: #eee;
        padding: 2%;
        width: 96%;
        margin-top: 5px;
        display: none;
        word-break: break-all;
    }
</style>
<div class="portlet">

    <div class="portlet-title">
    </div>
    <div class="portlet-tabs" style="position:relative">
        <div style="position: absolute;left:10px;bottom:0px;color: #444444;font-size: 16px"><a href="{$_root}admin/action/winchance_new/winchance_list?action=add" class="btn btn-success"><span class="glyphicon glyphicon-plus"></span>添加文创场地</a></div>
    </div>
    <div class="portlet-body">
        <div class="portlet-body">
            <div class="tab-content clearfix">
                <div class="table-responsive">
                    <table class="table table-striped table-bordered">
                        <thead>
                        <tr>
                            <th class="id">#ID</th>
                            <th width="8%">场地名称</th>
                            <th width="8%">工作状态</th>
                            <th width="8%">场地类型</th>
                            <th width="8%">录入类型</th>
                            <th width="6%">城市</th>
                            <th width="14%">场地基本资料以及需求</th>
                            <th width="8%">本周进展</th>
                            <th width="8%">下周计划</th>
                            <th>负责人</th>
                            <th>备注</th>
                            <th>操作</th>
                        </tr>
                        </thead>
                        <tbody>
                        {foreach $_data['rows'] as $k=>$v}
                            <tr>
                                <td>#{$v['id']}</td>
                                <td>{$v['site_name']}</td>
                                <td>{$v['step']}</td>
                                <td>{$v['site_type']}</td>
                                <td>{if $v['entry_type']==1}线上{else}线下{/if}</td>
                                <td>{$v['city']}</td>
                                <td>{if !empty($v['des'][0])}{foreach $v['des'] as $kk=>$vv}{intval($kk+1)}、{$vv}<br/>{/foreach}{/if}</td>
                                <td>{if !empty($v['plan']['本周进展'][0])}{foreach $v['plan']['本周进展'] as $kk=>$vv}{intval($kk+1)}、{$vv}<br/>{/foreach}{/if}</td>
                                <td>{if !empty($v['plan']['下周计划'][0])}{foreach $v['plan']['下周计划'] as $kk=>$vv}{intval($kk+1)}、{$vv}<br/>{/foreach}{/if}</td>
                                <td>{$v['operator']}</td>
                                <td>{if !empty($v['note'][0])}{foreach $v['note'] as $kk=>$vv}{intval($kk+1)}、{$vv}<br/>{/foreach}{/if}</td>
                                <td>
                                    <a href="{$_home}winchance/site_add?action=edit&id={$v['id']}" class="btn btn-info btn-xs">编辑</a>
                                    <a href="{$_home}winchance/site_add?action=siteDelete&id={$v['id']}" class="btn btn-danger btn-xs">删除</a>
                                </td>
                            </tr>
                        {/foreach}
                        </tbody>
                    </table>
                </div>
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-md-12" style="padding: 0px;">
                            <ul class="pagination">
                                {if $_data['page']['dpll']}
                                    <li class="prev">
                                        <a href="{$_data['page']['dup']}1" title="First"><i
                                                    class="fa fa-angle-double-left"></i></a>
                                    </li>
                                    <li class="prev">
                                        <a href="{$_data['page']['dup']}{$_waiting['page']['dp']-1}" title="Prev"><i
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
                                        /{$_data['page']['dt']}
                                        )</a></li>

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
        </div>
    </div>
</div>
<script src="{$_assets}plugins/jquery-1.11.0.min.js" type="text/javascript"></script>
<script src="{$_assets}plugins/bootstrap/js/bootstrap.min.js"
        type="text/javascript"></script>
{static "core/yunspace.js"}
<script src="js/demands/demands_change_select.js" type="text/javascript"></script>

<script type="text/javascript" src="js/moment.min.js"></script>
<script type="text/javascript" src="js/bootstrap-datetimepicker.min.js"></script>
<script type="text/javascript" src="js/zh-cn.js"></script>
<script type="text/javascript" src="js/date.js"></script>
<script type="text/javascript">
    $(document).ready(function () {
        $('.date').datetimepicker({
            format: 'YYYY-MM-DD',
            locale: 'zh-cn'
        });

    });

</script>

</body>
<!-- END BODY -->
</html>