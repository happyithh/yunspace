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
                    <input type="hidden" name="handle_type" value="{$handle_type}">
                    <div class="form-body clearfix">
                            {*<div class="form-group col-md-5">*}
                                {*<label class="col-md-3 control-label">数据来源</label>*}
                                {*<div class="col-md-9">*}
                                    {*<select class="form-control input-sm" name="search[from_where]">*}
                                        {*<option value=0>全部</option>*}
                                        {*<option {if $_REQUEST['search']['from_where']=="搜会场"}selected{/if} value="搜会场">搜会场</option>*}
                                        {*<option {if $_REQUEST['search']['from_where']=="酒店哥哥"}selected{/if} value="酒店哥哥">酒店哥哥</option>*}
                                        {*<option {if $_REQUEST['search']['from_where']=="创意园"}selected{/if} value="创意园">创意园</option>*}
                                        {*<option {if $_REQUEST['search']['from_where']=="展览馆"}selected{/if} value="展览馆">展览馆</option>*}
                                        {*<option {if $_REQUEST['search']['from_where']=="淘会场"}selected{/if} value="淘会场">淘会场</option>*}
                                        {*<option {if $_REQUEST['search']['from_where']=="会小二"}selected{/if} value="会小二">会小二</option>*}
                                    {*</select>*}
                                {*</div>*}
                            {*</div>*}
                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">入库时间</label>

                            <div class="col-md-4">
                                <input type='text' class="form-control date" placeholder="请选择开始时间"
                                       name="search[create_start_time]" value="{$_REQUEST['search']['create_start_time']}"/>
                            </div>
                            <div class="col-md-4 col-md-offset-1">
                                <input type='text' class="form-control date" placeholder="请选择结束时间"
                                       name="search[create_end_time]" value="{$_REQUEST['search']['create_end_time']}"/>
                            </div>
                        </div>
                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">操作时间</label>

                            <div class="col-md-4">
                                <input type='text' class="form-control date" placeholder="请选择开始时间"
                                       name="search[update_start_time]" value="{$_REQUEST['search']['update_start_time']}"/>
                            </div>
                            <div class="col-md-4 col-md-offset-1">
                                <input type='text' class="form-control date" placeholder="请选择结束时间"
                                       name="search[update_end_time]" value="{$_REQUEST['search']['update_end_time']}"/>
                            </div>
                        </div>
                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">操作人</label>

                            <div class="col-md-9">
                                <input type="text" class="form-control input-sm" placeholder="请填写操作人名称" name="search[username]" value="{$_REQUEST['search']['username']}">
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
            <i class="fa fa-comments"></i>
                资讯采集候选数据列表
        </div>
    </div>
    <div class="portlet-tabs">
        <ul class="nav nav-tabs" style="overflow: inherit; padding-left: 100px">
            <li class="{if $handle_type=='less'}active{/if}">
                <a href="?{if !empty($_REQUEST['search'])}handle_type=less&{$urls}{else}handle_type=less{/if}">不完整数据</a>
            </li>
            <li class="{if $handle_type=='invalid'}active{/if}">
                <a href="?{if !empty($_REQUEST['search'])}handle_type=invalid&{$urls}{else}handle_type=invalid{/if}">无效数据</a>
            </li>
            <li class="{if $handle_type=='repeat'}active{/if}">
                <a href="?{if !empty($_REQUEST['search'])}handle_type=repeat&{$urls}{else}handle_type=repeat{/if}">重复数据</a>
            </li>
            <li class="{if $handle_type=='pass'}active{/if}">
                <a href="?{if !empty($_REQUEST['search'])}handle_type=pass&{$urls}{else}handle_type=pass{/if}">已处理</a>
            </li>
            <li class="{if $handle_type=='waiting'}active{/if}">
                <a href="?{if !empty($_REQUEST['search'])}handle_type=waiting&{$urls}{else}handle_type=waiting{/if}">待处理</a>
            </li>
        </ul>
    </div>
    <div class="portlet-body">
        <div class="table-responsive clearfix">
            <table class="table table-striped table-bordered table-hover" id="data_table" style="word-break: break-all">
                <thead>
                <tr>
                    <th>文章ID</th>
                    <th>文章名称</th>
                    {*<th>供应商名称</th>*}
                    {if $handle_type!=waiting}
                    <th>操作人</th>
                    {/if}
                    <th>状态</th>
                    <th>来源</th>
                    <th>入库时间</th>
                    {if $handle_type!=waiting}
                    <th>操作时间</th>
                    {/if}
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                {foreach $_data['rows'] as $k=>$v}
                    <tr role="row" data-pid="{$v['id']}">
                        <td>#{$v['id']}</td>
                        <td>{$v['title']}</td>
                        {*<td>{$v['vendor_name']}</td>*}
                        {if $handle_type!=waiting}
                        <td>{$v['username']}</td>
                        {/if}
                        <td>{if $v['status']==1}已处理{elseif $v['status']==2}重复{elseif $v['status']==4}无效{elseif $v['status']==5}数据不完整{else}待处理{/if}</td>
                        {*<td>{if $v['from_where']==1}采集{elseif $v['from_where']==2}表格导入{/if}</td>*}
                        <td><a href="{$v['from_where']}" target="_blank">{$v['from_where']}</a></td>
                        <td>{date('Y-m-d H:i:s',$v['create_time'])}</td>
                        {if $handle_type!=waiting}
                        <td>{date('Y-m-d H:i:s',$v['update_time'])}</td>
                        {/if}
                        <td><a href="?action=check&id={$v['id']}" class="btn btn-success btn-xs"><i class="fa fa-pencil"></i>{if $v['status']==3}处理{else}查看{/if}</a>
                            {*<span onclick="ListOperator.delVendorCandidate(this)" class="btn btn-danger btn-xs"><i class="fa fa-trash-o"></i>删除</span>*}
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
<script type="text/javascript" src="js/moment.min.js"></script>
<script type="text/javascript" src="js/zh-cn.js"></script>
<script type="text/javascript" src="js/bootstrap-datetimepicker.min.js"></script>
<script type="text/javascript">
    $(document).ready(function () {
        $('.date').datetimepicker({
            format: 'YYYY-MM-DD',
            locale: 'zh-cn'
        });
    });

    ListOperator = {
        delVendorCandidate: function (e) {
            if (!confirm('您确定要删除吗？？')) {
                return false;
            }
            var Candidate_id = $(e).parents('tr').data('pid');
            $.get("?", {
                del: 1,
                id: Candidate_id,
                action: 'vendor_candidate_list'
            }, function (data) {
                top.alert(data.msg);
                if (data.status == 1) {
                    $(e).parents('tr').hide();
                }
            });
        }
    }
</script>
</body>
<!-- END BODY -->
</html>