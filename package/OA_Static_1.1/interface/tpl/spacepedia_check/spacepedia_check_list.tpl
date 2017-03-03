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
    <link href="style/css.css" rel="stylesheet"/>
    <link href="css/bootstrap-datetimepicker.min.css" rel="stylesheet"/>
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
                <form action="?" method="get" class="clearfix">
                    <input type="hidden" name="handle_type" value="{$_data['other']['handle_type']}">
                    <input type="hidden" name="monthdate" value="{$_data['other']['monthdate']}">
                    <div class="form-body clearfix">
                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">百科名称</label>

                            <div class="col-md-9">
                                <input type="text" class="form-control input-sm" placeholder="百科ID / 名称"
                                       name="search[title]" value="{$_REQUEST['search']['title']}">
                            </div>
                        </div>
                        {*<div class="form-group col-md-5">
                            <label class="col-md-3 control-label">供应商名称</label>

                            <div class="col-md-9">
                                <input type="text" class="form-control input-sm" placeholder="供应商名称" name="search[vendor_name]" value="{$_REQUEST['search']['vendor_name']}">
                            </div>
                        </div>
                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">城市</label>

                            <div class="col-md-9">
                                <input type="text" class="form-control input-sm" placeholder="请输入要搜索的城市" name="search[city]" value="{$_REQUEST['search']['city']}">
                            </div>
                        </div>
                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">百科类型</label>

                            <div class="col-md-9">
                                <select class="form-control input-sm" name="search[category_id]">
                                    <option value=0>不限</option>
                                    {foreach $_categoryList[112] as $k=>$v}
                                        <option value="{$k}" {if $k==$_REQUEST['search']['category_id']} selected="selected" {/if}>{$v}</option>
                                    {/foreach}
                                </select>
                            </div>
                        </div>*}
                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">创建时间</label>

                            <div class="col-md-9">
                                <input type='text' class="form-control date" placeholder="请选择创建时间"
                                       name="search[create_time]" value="{$_REQUEST['search']['create_time']}"/>
                            </div>
                        </div>
                        {* <div class="form-group col-md-5">
                             <label class="col-md-3 control-label">更新时间</label>
                             <div class="col-md-4">
                                 <input type='text' class="form-control date" placeholder="请选择开始时间" name="search[start_time]" value="{$_REQUEST['search']['start_time']}"/>
                             </div>
                             <div class="col-md-4 col-md-offset-1">
                                 <input type='text' class="form-control date" placeholder="请选择结束时间" name="search[end_time]" value="{$_REQUEST['search']['end_time']}"/>
                             </div>
                         </div>*}
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
            <i class="fa fa-comments"></i>
            场地百科列表
        </div>
    </div>
    <div class="portlet-tabs" style="position:relative">
        <ul class="nav nav-tabs" style="overflow: inherit; padding-left: 100px">
            <li class="{if $_data['other']['handle_type']=='history'}active{/if}">
                <a href="?{if !empty($_REQUEST['search'])}handle_type=history&{$_data['other']['urls']}{else}&handle_type=history{/if}">历史记录</a>
            </li>
           {* <li class="{if $_data['other']['handle_type']=='online'}active{/if}">
                <a href="?{if !empty($_REQUEST['search'])}handle_type=online&{$_data['other']['urls']}{else}&handle_type=online{/if}">已上线</a>
            </li>*}
            <li class="{if $_data['other']['handle_type']=='waiting'}active{/if}">
                 <a href="?{if !empty($_REQUEST['search'])}handle_type=waiting&{$_data['other']['urls']}{else}&handle_type=waiting{/if}">待审核</a>
            </li>
        </ul>

    </div>
    <div class="portlet-body">
        <div style="margin-bottom: 20px;">
            {foreach $month as $k=>$v}
                <a style="margin-bottom: 10px;" href="?handle_type={$_REQUEST['handle_type']}&{if !empty($_REQUEST['search'])}monthdate={$v}&{$_data['other']['urls']}{else}monthdate={$v}{/if}" class="btn {if $_data['other']['monthdate']=={$v}}btn-info{else}btn-default{/if}">
                    {if $v==date("Ym")}
                        当前月
                    {else}
                        {$v}
                    {/if}
                </a>
            {/foreach}
        </div>
        <div class="table-responsive clearfix">
            <table class="table table-striped table-bordered table-hover" id="data_table" style="word-break: break-all">
                <thead>
                <tr>
                    <th>百科ID</th>
                    <th>百科名称</th>
                    <th>百科别名</th>
                    <th>百科类型</th>
                    <th>城市</th>
                    <th>更新时间</th>
                    {if $_data['other']['handle_type']=='waiting'}
                        <th>操作</th
                    {/if}
                    {if $_data['other']['handle_type']=='history'}
                        <th>状态</th
                    {/if}
                </tr>
                </thead>
                <tbody>
                {foreach $_data['rows'] as $k=>$v}
                    <tr data-sid="{$v['object_id']}">
                        <td class="list_none">{$v['object_id']} {if $v['data_backup']['new_id']}<button class="btn btn-warning btn-xs" disabled>场地出租</button>{/if}</td>
                        <td class="list_size">
                            {$v['data_backup']['space_name']}
                            {if $v['status'] == 2}
                                <span style="color:#d9534f;">【拒绝理由：{$v['refuse_reason']}】</span>
                            {/if}
                        </td>
                        <td class="list_size">{$v['data_backup']['nickname']}</td>
                        <td class="list_size">{$category_info[$v['data_backup']['category_id']]["name"]}</td>
                        <td class="list_none">{$v['data_backup']['city']}</td>
                        <td class="list_none">{if $v['create_time']>1430713953}{date('Y-m-d H:i:s',$v['create_time'])}{else}--{/if}</td>
                        {if $_data['other']['handle_type']=='history'}
                            <td>
                                {if $v['status']==1}
                                    <button class="btn btn-success btn-xs" disabled>审核通过</button>
                                {elseif $v['status']==2}
                                    <button class="btn btn-danger btn-xs" disabled>已拒绝</button>
                                {elseif $v['status']==3}
                                    <button class="btn btn-warning btn-xs" disabled>已取消</button>
                                {elseif $v['status']< 0}
                                    <button class="btn btn-danger btn-xs" disabled>已删除</button>
                                {/if}
                            </td>
                        {/if}
                        {if $_data['other']['handle_type']=='waiting'}
                            <td>
                                <a href="?action=check_detail&history_id={$v['id']}&month={$_data['other']['monthdate']}"
                                   class="btn btn-success btn-xs list_size"><i class="fa fa-eye"></i>审核</a>
                            </td>
                        {/if}
                    </tr>
                {/foreach}
                </tbody>
            </table>
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
{*<iframe style="width: 1px; height:1px;" width="1" height="1" hidden="hidden" src="{$_home}space/pedia_space_update?action=update_spacepedia_submit"></iframe>*}

<script src="{$_assets}plugins/jquery-1.11.0.min.js"
        type="text/javascript"></script>
<script type="text/javascript" src="js/moment.min.js"></script>
<script type="text/javascript" src="js/zh-cn.js"></script>
<script type="text/javascript" src="js/bootstrap-datetimepicker.min.js"></script>
<script>
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