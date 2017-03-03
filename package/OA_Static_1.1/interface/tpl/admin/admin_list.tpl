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
                    <input type="hidden" name="action" value="list">
                    <input type="hidden" name="handle_type" value="{$_REQUEST['handle_type']}">

                    <div class="form-body clearfix">
                        {*<div class="form-group col-md-5">*}
                        {*<label class="col-md-3 control-label">姓名</label>*}

                        {*<div class="col-md-9">*}
                        {*<input type="text" class="form-control input-sm" placeholder="管理员名称" name="search[fullname]" value="{$_REQUEST['search']['fullname']}">*}
                        {*</div>*}
                        {*</div>*}
                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">姓名/登录名</label>

                            <div class="col-md-9">
                                <input type="text" class="form-control input-sm" placeholder="管理员姓名/登录名"
                                       name="search[username]" value="{$_REQUEST['search']['username']}">
                            </div>
                        </div>
                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">手机号</label>

                            <div class="col-md-9">
                                <input type="text" class="form-control input-sm" placeholder="请输入手机号"
                                       name="search[phone]" value="{$_REQUEST['search']['phone']}">
                            </div>
                        </div>
                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">职位</label>

                            <div class="col-md-9">
                                <input type="text" class="form-control input-sm" placeholder="管理员职位"
                                       name="search[position]" value="{$_REQUEST['search']['position']}">
                            </div>
                        </div>
                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">城市</label>

                            <div class="col-md-9">
                                <select class="form-control input-sm" name="search[city]">
                                    <option value=''>全部</option>
                                    {foreach Web_Global::getAllCities() as $v}
                                        <option {if $_REQUEST['search']['city']==$v}selected {/if}
                                                value="{$v}">{$v}</option>
                                    {/foreach}
                                </select>
                            </div>
                        </div>
                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">部门</label>

                            <div class="col-md-5">
                                <select class="form-control input-sm" name="search[department_name]">
                                    <option value=''>全部</option>
                                    {foreach $department as $k=>$v}
                                        <option {if $_REQUEST['search']['department_name']== $v}selected {/if}
                                                value={$v}>{$v}</option>
                                    {/foreach}
                                </select>
                            </div>
                            <a href="#department" data-toggle="modal" class="btn btn-info">添加新部门</a>
                            <a href="#remove_department" data-toggle="modal" class="btn btn-danger">移除部门</a>
                        </div>
                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">组别</label>

                            <div class="col-md-9">
                                <input type="text" class="form-control input-sm" placeholder="管理员所属组"
                                       name="search[team_name]" value="{$_REQUEST['search']['team_name']}">
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
            管理员列表&nbsp;(共查询到{$_data['page']['dt']}个管理员)
        </div>
    </div>
    <div class="portlet-tabs" style="position:relative">
        <ul class="nav nav-tabs">
            <li class="{if $_REQUEST['handle_type']=='recycle'}active{/if}">
                <a href="?handle_type=recycle{if !empty($urls)}&{$urls}{/if}">回收站</a>
            </li>
            {*<li class="{if $_REQUEST['handle_type']=='stop'}active{/if}">*}
            {*<a href="?handle_type=stop">停用</a>*}
            {*</li>*}
            <li class="{if $_REQUEST['handle_type']=='normal'}active{/if}">
                <a href="?handle_type=normal{if !empty($urls)}&{$urls}{/if}">正常</a>
            </li>
            <li class="{if $_REQUEST['handle_type']=='waiting'}active{/if}">
                <a href="?handle_type=waiting{if !empty($urls)}&{$urls}{/if}">待审核</a>
            </li>
        </ul>
    </div>
    <div class="portlet-body">
        <a href="?action=detail" class="btn btn-success">创建管理员</a>

        <div class="table-responsive clearfix">
            <table class="table table-striped table-bordered table-hover"
                   id="data_table" style="word-break: break-all">
                <thead>
                <tr>
                    <th>姓名</th>
                    <th>登录名</th>
                    <th>职位</th>
                    <th>电话</th>
                    <th>邮箱</th>
                    <th>城市</th>
                    <th>部门</th>
                    <th>组别</th>
                    {if $_REQUEST['handle_type']=='normal'}
                        <th>积分</th>
                    {/if}
                    <th>注册时间</th>
                    <th>登录次数</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                {foreach $_data['rows'] as $k=>$v}
                    <tr>
                        <td>{$v['fullname']}</td>
                        <td>{$v['username']}</td>
                        <td>{$v['position']}</td>
                        <td>{$v['phone']}</td>
                        <td>{$v['email']}</td>
                        <td>{$v['city']}</td>
                        <td>{$v['department_name']}</td>
                        <td>{$v['team_name']}</td>
                        {if $_REQUEST['handle_type']=='normal'}
                            <th>{intval($v['integral'])}</th>
                        {/if}
                        <td>{date("Y-m-d H:i:s",$v['register_time'])}</td>
                        <td>{$v['login_times']}</td>
                        <td>
                            {if $_REQUEST['handle_type']=='normal'}
                                <a class="btn btn-xs btn-success js-integral-operation"
                                   data-phone="{$v['phone']}">积分操作</a>
                            {/if}
                            {if $_REQUEST['handle_type']=="waiting"}
                                <a class="btn btn-xs btn-success"
                                   href="?action=pass&admin_id={$v['id']}&handle_type={$_REQUEST['handle_type']}">审核</a>
                            {/if}
                            {if $_REQUEST['handle_type']=="recycle"}
                                <a class="btn btn-xs btn-success"
                                   href="?action=recovery&admin_id={$v['id']}&handle_type={$_REQUEST['handle_type']}">恢复</a>
                            {else}
                                <a class="btn btn-xs btn-primary"
                                   href="?action=detail&admin_id={$v['id']}&department_name={$v['department_name']}&handle_type={$_REQUEST['handle_type']}">修改</a>
                                <a class="btn btn-xs btn-danger"
                                   href="?action=delete_admin&admin_id={$v['id']}&department_name={$v['department_name']}&handle_type={$_REQUEST['handle_type']}">删除</a>
                                {*<a class="btn btn-xs btn-warning"*}
                                   {*href="?action=change_admin_session&admin_id={$v['id']}&handle_type={$_REQUEST['handle_type']}">变身</a>*}
                            {/if}
                        </td>
                    </tr>
                {/foreach}
                </tbody>
            </table>
            <div class="text-center">
                <ul class="pagination pull-right">
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

{*新建部门名称弹出层*}
<div class="modal fade" id="department" tabindex="-1" role="basic" aria-hidden="true" style="display: none;">
    <div class="modal-dialog">
        <div class="modal-content">
            <form action="?" method="post">
                <input name="action" value="add_department" type="hidden">

                <div class="modal-body">
                    <table class="table">
                        <thead>
                        <th width="200px;">新建部门</th>
                        </thead>
                        <tr>
                            <td>
                                <label class="control-label">输入新的部门名称</label>
                            </td>
                            <td>
                                <input class="form-control" name="department_name" class="form-control">
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
{*积分操作*}
<div class="modal fade" id="integral_operation" tabindex="-1" role="basic" aria-hidden="true" style="display: none;">
    <div class="modal-dialog">
        <div class="modal-content">
            <ul class="nav nav-tabs ">
                <li class=" active">
                    <a href="#integral_add" data-toggle="tab">添加</a>
                </li>
                <li class="">
                    <a href="#integral_reduce" data-toggle="tab">减少</a>
                </li>
            </ul>
            <div class="tab-content">
                <div id='integral_add' class="tab-pane active">
                    <div class="modal-body">
                        <table class="table">
                            <tr>
                                <td>
                                    积分
                                </td>
                                <td>
                                    <input type="number" name="add" class="form-control input-sm"/>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    理由
                                </td>
                                <td>
                                    <textarea class="form-control js-reason-add"></textarea>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                        <button type="submit" class="btn btn-info" onclick="operationIntegral('add')">提交</button>
                    </div>
                </div>
                <div id='integral_reduce' class=" tab-pane">
                    <div class="modal-body">
                        <table class="table">
                            <tr>
                                <td>
                                    积分
                                </td>
                                <td>
                                    <input type="number" name="reduce" class="form-control input-sm"/>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    理由
                                </td>
                                <td>
                                    <textarea class="form-control js-reason-reduce"></textarea>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                        <button type="submit" class="btn btn-info" onclick="operationIntegral('reduce')">提交
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

{*移除部门弹出层*}
<div class="modal fade" id="remove_department" tabindex="-1" role="basic" aria-hidden="true" style="display: none;">
    <div class="modal-dialog">
        <div class="modal-content">
            <form action="?" method="post">
                <input name="action" value="remove_department" type="hidden">

                <div class="modal-body">
                    <table class="table">
                        <thead>
                        <th width="200px;">移除并替换部门名称</th>
                        </thead>
                        <tr>
                            <td>
                                <label class="control-label"><span class="required" aria-required="true">*</span>请选择要移除的部门名称</label>
                            </td>
                            <td>
                                {*<input class="form-control" name="department_name" class="form-control">*}
                                <select class="form-control input-sm" name="remove_department_name">
                                    {foreach $department as $k=>$v}
                                        <option value={$v}>{$v}</option>
                                    {/foreach}
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label class="control-label"><span class="required" aria-required="true">*</span>请选择要替换的部门名称</label>
                            </td>
                            <td>
                                <select class="form-control input-sm" name="replace_department_name">
                                    {foreach $department as $k=>$v}
                                        <option value={$v}>{$v}</option>
                                    {/foreach}
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <label class="control-label">
                                    <span class="required" aria-required="true">*</span>
                                    <span style="color:#f0ad4e;">要移除的部门的管理员将会被分配到替换的部门下</span>
                                </label>
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
<script src="{$_assets}plugins/bootstrap/js/bootstrap.min.js" tab="text/javascript"></script>
<script src="{$_assets}scripts/_page.js"></script>
{static "core/yunspace.js"}
<script>
    var phone;
    $(document).ready(function () {
        $(".js-integral-operation").on('click', function () {
            phone = $(this).attr('data-phone');
            if (!phone) {
                top.alert('当前管理没有设置手机号，不可以操作积分·');
                return false;
            }
            $("#integral_operation").modal({
                keyboard: true
            });
        });
    })

    function operationIntegral(type) {

        var integral = $("input[name=" + type + "]").val();
        if (!integral) {
            top.alert('请填写积分！');
            return false;
        }
        var type_s = type == 'add' ? '增加' : '减少';
        if (!confirm('您确认要' + type_s + integral + '积分吗？')) {
            return false;
        }
        if (!phone) {
            top.alert('手机号缺失，请刷新重试，谢谢');
        }
        var obj  = ".js-reason-"+type;

        var reason =  $(obj).val();

        YunSpace.api('administrator/integral/manage.json', {
            phone: phone,
            type: type,
            integral: integral,
            reason: reason
        }, function (data) {

            top.alert(data.msg);
            if (data.status == 1) {
//                window.location.reload();
            }
        });


    }
</script>
</body>

<!-- END BODY -->
</html>