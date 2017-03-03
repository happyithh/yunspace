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
    <link href="css/bootstrap-datetimepicker.min.css" rel="stylesheet"/>
</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->

<body style="background:#FaFaFa !important">
<div class="cols-md-3 " style="text-align: center;margin: 15px 0px">
    <a href="?">
        <div class="btn btn-default  go_switch_window">
            广告管理
        </div>
    </a>
    <a href="?action=site_list">
        <div class="btn btn-default go_switch_window">
            广告位管理
        </div>
    </a>
    <a href="?action=adver_statistics">
        <div class="btn btn-success go_switch_window">广告位统计</div>
    </a>
</div>
<div class="portlet">
    <div class="portlet-title">
        <div class="caption">
            <i class="fa fa-search"></i>搜索条件
        </div>
    </div>
    <div class="portlet-body">
        <div class="portlet-tabs">
            <div class="clearfix"></div>
            <div>
                <form action="?action=adver_statistics" method="post" class="clearfix">
                    <input type="hidden" name="type" value="{$type}">
                    <div class="form-body clearfix">
                        <div class="form-group col-md-5">
                            <label class="col-md-2 control-label">广告名称</label>
                            <div class="col-md-4">
                               <select class="form-control select-sm" name="search[pa]">
                                   {*<option value="0">请选择</option>*}
                                   {foreach $pa_title as $k=>$v}
                                       <option {if $_REQUEST['search']['pa']==$v['pa']}selected {/if}
                                               value="{$v['pa']}">{$v['advertising_title']}</option>
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
<div class="portlet-body">
    {*{if !empty($data['display'])}*}
    <ul class="nav nav-tabs">
        <li class="{if $type=='day' || !isset($type)}active{/if}">
            <a href="?action=adver_statistics&type=day&search[pa]={$_REQUEST['search']['pa']}">日</a>
        </li>
        <li class="{if $type=='week'}active{/if}">
            <a href="?action=adver_statistics&type=week&search[pa]={$_REQUEST['search']['pa']}">周</a>
        </li>
        <li class="{if $type=='month'}active{/if}">
            <a href="?action=adver_statistics&type=month&search[pa]={$_REQUEST['search']['pa']}">月</a>
        </li>
    </ul>
    <div class="table-responsive clearfix">

        <table class="table table-striped table-bordered table-hover" id="data_table" style="word-break: break-all">
            <thead>
            <tr>
                <th>时间</th>
                {foreach $data['type'] as $k=>$v}
                    <th>{$v}</th>
                {/foreach}
                {*<th>总计</th>*}
            </tr>
            </thead>

            {foreach $data as $k=>$v}

                {if $k!='type'}
                    <tr>
                        <td>{$k}</td>
                        <td>{$v['展示量']}</td>
                        <td>{$v['点击量']}</td>
                        <td>{$v['点击率']}</td>
                        {*<td>{array_sum($v)}</td>*}
                    </tr>
                {/if}

            {/foreach}
            </thead>
            <tbody>
        </table>

    </div>
    </div>
    </div>
    {*{else}*}
    {*<div colspan="8" style="text-align: center;font-size: 16px;">暂无统计信息</td>*}
    {*{/if}*}
</div>

<!-- BEGIN JAVASCRIPTS(Load javascripts at bottom, this will reduce page load time) -->
<!-- BEGIN CORE PLUGINS -->
</body>
<!-- END BODY -->
</html>