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
    {include "OA_Static::public_css/public_css.tpl"}

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

                    <div class="form-body clearfix">
                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">百科名称</label>

                            <div class="col-md-9">
                                <input type="text" class="form-control input-sm" placeholder="百科ID / 名称"
                                       name="search[title]" value="{$_REQUEST['search']['title']}">
                            </div>
                        </div>
                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">城市</label>

                            <div class="col-md-9">
                                <input type="text" class="form-control input-sm" placeholder="请输入要搜索的城市"
                                       name="search[city]" value="{$_REQUEST['search']['city']}">
                            </div>
                        </div>
                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">创建时间</label>

                            <div class="col-md-9">
                                <input type='text' class="form-control date" placeholder="请选择创建时间"
                                       name="search[create_time]" value="{$_REQUEST['search']['create_time']}"/>
                            </div>
                        </div>
                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">更新时间</label>

                            <div class="col-md-4">
                                <input type='text' class="form-control date" placeholder="请选择开始时间"
                                       name="search[start_time]" value="{$_REQUEST['search']['start_time']}"/>
                            </div>
                            <div class="col-md-4 col-md-offset-1">
                                <input type='text' class="form-control date" placeholder="请选择结束时间"
                                       name="search[end_time]" value="{$_REQUEST['search']['end_time']}"/>
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
            场地百科列表
        </div>
    </div>
    <div class="portlet-tabs" style="position:relative">
        {if !$is_my}
            <div style="position: absolute;left:10px;top:10px;color: #444444;font-size: 16px">
                {*<a href="#spacepedia" data-toggle="modal" class="btn btn-primary">新建百科</a>*}
                <a href="javascript:;" class="btn btn-primary create_warn">新建百科</a>
            </div>
        {/if}
        <div style="float:right;margin-top:10px;margin-right:30px;color: #444444;font-size: 16px">
            <a href="?{if !empty($_REQUEST['search'])}search[level]=100&{$_data['other']['urls']}{else}search[level]=100{/if}" class="btn {if !isset($_REQUEST['search']['level']) || $_REQUEST['search']['level']==100}btn-success{/if} btn-default">全部</a>
            <a href="?{if !empty($_REQUEST['search'])}search[level]=4&{$_data['other']['urls']}{else}search[level]=4{/if}" class="btn {if $_REQUEST['search']['level']==4}btn-success{/if} btn-default">A级</a>
            <a href="?{if !empty($_REQUEST['search'])}search[level]=3&{$_data['other']['urls']}{else}search[level]=3{/if}" class="btn {if $_REQUEST['search']['level']==3}btn-success{/if} btn-default">B级</a>
            <a href="?{if !empty($_REQUEST['search'])}search[level]=0&{$_data['other']['urls']}{else}search[level]=0{/if}" class="btn {if isset($_REQUEST['search']['level']) && $_REQUEST['search']['level']==0}btn-success{/if} btn-default">C级</a>
            <a href="?{if !empty($_REQUEST['search'])}search[level]=-1&{$_data['other']['urls']}{else}search[level]=-1{/if}" class="btn {if $_REQUEST['search']['level']==-1}btn-success{/if} btn-default">D级</a>
            <a href="?{if !empty($_REQUEST['search'])}search[level]=-2&{$_data['other']['urls']}{else}search[level]=-2{/if}" class="btn {if $_REQUEST['search']['level']==-2}btn-success{/if} btn-default">E级</a>
        </div>
        <ul class="nav nav-tabs" style="overflow: inherit; padding-left: 100px">
            <li class="{if $_data['other']['handle_type']=='deleted'}active{/if}">
                <a href="?{if !empty($_REQUEST['search'])}handle_type=deleted&{$_data['other']['urls']}{else}&handle_type=deleted{/if}">已删除</a>
            </li>
            <li class="{if $_data['other']['handle_type']=='offline'}active{/if}">
                <a href="?{if !empty($_REQUEST['search'])}handle_type=offline&{$_data['other']['urls']}{else}&handle_type=offline{/if}">已下线</a>
            </li>
            <li class="{if $_data['other']['handle_type']=='online'}active{/if}">
                <a href="?{if !empty($_REQUEST['search'])}handle_type=online&{$_data['other']['urls']}{else}&handle_type=online{/if}">已上线</a>
            </li>
            <li class="{if $_data['other']['handle_type']=='all'}active{/if}">
                <a href="?{if !empty($_REQUEST['search'])}handle_type=all&{$_data['other']['urls']}{else}&handle_type=all{/if}">全部</a>
            </li>
        </ul>
    </div>
    <div class="portlet-body">
        <div class="table-responsive clearfix">
            <table class="table table-striped table-bordered table-hover" id="data_table" style="word-break: break-all">
                <thead>
                <tr>
                    <th>百科ID</th>
                    <th>百科名称</th>
                    <th>百科别名</th>
                    <th>百科类型</th>
                    <th>级别</th>
                    <th>状态</th>
                    <th>城市</th>
                    <th>创建时间</th>
                    <th>更新时间</th>
                    <th>操作</th
                </tr>
                </thead>
                <tbody>
                {foreach $_data['rows'] as $k=>$v}
                    <tr data-sid="{$v['id']}">
                        <td class="list_none">{$v['id']}{if $v['new_id']}<button class="btn btn-warning btn-xs" disabled>场地出租</button>{/if}</td>
                        <td class="list_size">
                            <a target="_blank"
                               href="http://{Core::$urls['host']}/site/{Func_Url::str_urlencode($v['space_name'])}">{$v['space_name']}</a>
                            <div style="text-align: center;">
                                <a target="_blank"
                                href="http://{Core::$urls['host']}/site/{Func_Url::str_urlencode($v['space_name'])}?update_page_cache=1">

                                <button class="btn btn-danger btn-xs">
                                    清除缓存并查看
                                </button>
                                    </a>
                            </div>
                            {foreach $history as $key =>$val}
                                {if $v['status']==1 && $v['id']==$val['object_id'] && $val['status']==0 }
                                    <button class="btn btn-warning btn-xs" disabled>有待审核的文件</button>
                                {/if}
                            {/foreach}
                        </td>
                        <td>
                            {$v['nickname']}
                        </td>
                        {if $v['category_id']!=200 && $v['category_id']!=300 && $v['category_id']!=400}
                            <td class="list_size">

                                {foreach $category_name as $key=>$value}
                                    {if  $v['category_id']==$value['id']}{$value['name']}{/if}
                                {/foreach}
                            </td>
                            <td>
                                    {foreach $level as $key=>$value}
                                        {if $v['level']==$value}{$key}{/if}
                                    {/foreach}
                            </td>
                            <td class="list_size">
                                {foreach $status as $ks=>$vs}
                                    {if $v['status']==$ks}
                                        <span style="color: {if $ks==2}#ecbc29{elseif $ks==3}#f3565d{elseif $ks==-1}#f3565d{/if};">{$vs}</span>
                                    {/if}
                                {/foreach}
                            </td>
                        {else}
                            <td class="list_size">

                                <select class="form-control input-sm" onchange="OperateSpacepedia.changeCategory(this)">
                                {foreach $category_name as $key=>$value}
                                <option {if {$v['category_id']==$value['id']}}selected {/if} value="{$value['id']}">{if $value['parent']==0}{$value['name']}{else}&nbsp;&nbsp;--{$value['name']}{/if}</option>
                                {/foreach}
                                </select>
                            </td>
                            <td>
                                {if $is_admin}
                                <select class="form-control input-sm" onchange="OperateSpacepedia.changeLevel(this)">
                                {foreach $level as $key=>$value}
                                <option {if $v['level']==$value}selected {/if} value="{$value}">{$key}</option>
                                {/foreach}
                                </select>
                                {else}
                                {foreach $level as $key=>$value}
                                    {if $v['level']==$value}{$key}{/if}
                                {/foreach}
                                {/if}
                            </td>
                            <td class="list_size">
                                {if $v['status']==2}
                                <span style="color: #ecbc29;">审核中</span>
                                {elseif $v['status']==0 || $v['status']==1}
                                <select class="form-control input-sm" onchange="OperateSpacepedia.online(this)">
                                <option value="1" {if $v['status']==1}selected {/if}>上线</option>
                                <option value="0" {if $v['status']==0}selected {/if}>下线</option>
                                </select>
                                {elseif $v['status']==3}
                                <span style="color: #f3565d;;">已拒绝</span>
                                <div class="show-reason"></div>
                                <a class="btn btn-danger btn-xs alertreason" style="width:60px;"
                                onclick="OperateSpacepedia.alertReason(this)" reason="{$v['refuse_reason']}"
                                style="margin-left: 0px;"><span class="look-reason">查看理由</span>
                                </a>
                                {elseif $v['status']==-1}
                                <span style="color: #f3565d;">已删除</span>
                                {/if}
                            </td>
                        {/if}
                        <td class="list_none">{$v['city']}</td>
                        <td class="list_none">{if $v['update_time']>1430713953}{date('Y-m-d H:i:s',$v['create_time'])}{else}--{/if}</td>
                        <td class="list_none">{if $v['update_time']>1430713953}{date('Y-m-d H:i:s',$v['update_time'])}{else}--{/if}</td>
                        <td>
                            <a href="?action=case&space_id={$v['id']}" class="btn btn-primary btn-xs list_size"><i
                                        class="fa fa-eye"></i>文章</a>
                            {if $v['category_id']!=200 && $v['category_id']!=300 && $v['category_id']!=400}
                            <a href="javascript:;" class="btn btn-info btn-xs list_size warn"><i
                                        class="fa fa-eye"></i>编辑</a>
                            {else}
                                <a href="?action=edit&space_id={$v['id']}" class="btn btn-info btn-xs list_size"><i
                                class="fa fa-eye"></i>编辑</a>
                            {/if}
                            {if !$is_my}
                            <a href="?action=assign&space_id={$v['id']}" class="btn btn-success btn-xs list_size"><i
                                        class="fa fa-eye"></i>授权</a>
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


{*新建百科弹出层*}
<div class="modal fade" id="spacepedia" tabindex="-1" role="basic" aria-hidden="true" style="display: none;">
    <div class="modal-dialog">
        <div class="modal-content">
            <form action="?" method="post">
                <input name="action" value="add_spacepedia" type="hidden">

                <div class="modal-body">
                    <table class="table">
                        <thead>
                        <th width="200px;">新建场地百科</th>
                        </thead>
                        <tr>
                            <td>
                                <label class="control-label">输入场地百科名称</label>
                            </td>
                            <td>
                                <input class="form-control" name="space_name" class="form-control">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label class="control-label">选择场地百科分类</label>
                            </td>
                            <td>
                                <select name="category_id" class="form-control">
                                    {foreach $category_name as $key=>$value}
                                        <option value="{$value['id']}">{if $value['parent']==0}{$value['name']}{else}&nbsp;&nbsp;--{$value['name']}{/if}</option>
                                    {/foreach}
                                </select>
                            </td>
                        </tr>
                    </table>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="submit" class="btn btn-info">提交</button>
                </div>
            </form>
        </div>
    </div>
</div>


<!-- BEGIN JAVASCRIPTS(Load javascripts at bottom, this will reduce page load time) -->
<!-- BEGIN CORE PLUGINS -->
<script src="{$_assets}plugins/jquery-1.11.0.min.js"
        type="text/javascript"></script>
<script src="{$_assets}plugins/bootstrap/js/bootstrap.min.js"
        tab="text/javascript"></script>
<script src="{$_assets}scripts/_page.js"></script>
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

    OperateSpacepedia = {
        online: function (obj) {
            var online = $(obj).val();
            if (online == 0) {
                var msg = "下线";
            } else {
                var msg = "上线";
            }
            var rs = confirm("是否确定" + msg + "该场地百科？");
            if (rs == true) {
                var space_id = $(obj).parents('tr').data('sid');
                $.post('http://{Core::$urls['host']}/static/api/spacepedia/handle.jsonp', {
                    space_id: space_id,
                    status: online,
                    action: 'change_status'
                }, function (data) {
                    if (data.status == 1) {
                        top.alert(" " + data.msg);
                        window.location.reload();
                    } else {
                        top.alert(data.msg);
                    }
                }, "json")
            } else {
                $(obj).find("option[value!='" + online + "']").attr("selected", true);
            }
        },
        changeCategory: function (o) {
            var category_id = $(o).find('option:selected').val();
            var space_id = $(o).parents('tr').data('sid');
            if (!category_id) {
                category_id = $(o).find('option:first').val();
            }
            $.post('http://{Core::$urls['host']}/static/api/spacepedia/handle.jsonp', {
                space_id: space_id,
                category_id: category_id,
                action: 'change_category'
            }, function (data) {
                if (data.status == 1) {
                    top.alert(" " + data.msg);
                    window.location.reload();
                } else {
                    top.alert(data.msg);
                }
            }, "json");
        },
        changeLevel: function (o) {
            var level = $(o).find('option:selected').val();
            var space_id = $(o).parents('tr').data('sid');
            $.post('http://{Core::$urls['host']}/static/api/spacepedia/handle.jsonp', {
                space_id: space_id,
                level: level,
                action: 'change_level'
            }, function (data) {
                if (data.status == 1) {
                    top.alert(" " + data.msg);
                    window.location.reload();
                } else {
                    top.alert(data.msg);
                }
            }, "json");
        }
    };
    $('.warn').click(function(){
        alert('请进入场地大师进行操作！');
    });
    $('.create_warn').click(function(){
        alert('请进入场地大师进行创建！');
    });
</script>
</body>
<!-- END BODY -->
</html>