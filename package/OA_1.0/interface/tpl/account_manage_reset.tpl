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
                用户列表
                <i class="fa fa-comments"></i>
        </div>
    </div>
    <div class="portlet-body">
        <div class="pull-left" style="width:30%; padding: 10px 0;">
            <form action="?">
                <div class="input-group">
                    <input type="text" class="form-control" placeholder="姓名" name="search[fullname]" value="{$_REQUEST['search']['fullname']}">
                    <span class="input-group-btn">
                    <button class="btn btn-info" type="submit">
                        <i class="fa fa-search"></i>
                    </button>
                    </span>
                </div>
            </form>
    </div>
        <div class="table-responsive clearfix">
            <table class="table table-striped table-bordered table-hover" id="data_table" style="word-break: break-all">
                <thead>
                <tr>
                    <th class="table-checkbox" style="width:16px">
                        {*<input type="checkbox" class="group-checkable" data-set="#data_table .checkboxes">*}
                    </th>
                    <th>#</th>
                    <th>用户名</th>
                    <th>姓名</th>
                    <th>联系方式</th>
                    <th>E-mail</th>
                    <th>用户类型</th>
                    <th>注册时间</th>
                    <th>登陆次数</th>
                    <th>状态</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                {foreach $_data['rows'] as $k=>$v}
                    <tr role="row">
                        <td>
                            {*<input type="checkbox" class="checkboxes" value="1" name="ids[]"></span>*}
                        </td>
                        <td>{$v['id']}</td>
                        <td>{$v['username']}</td>
                        <td>{$v['fullname']}</td>
                        <td>{$v['phone']}</td>
                        <td>{$v['email']}</td>
                        <td>{if $tpl_account_type[$v['account_type']]}
                                {$tpl_account_type[$v['account_type']]}
                            {else}
                             {$v['account_type']}
                        {/if}</td>
                        <td>{Date('Y-m-d',$v['register_time'])}</td>
                        <td>{$v['login_times']}</td>
                        <td>{$v['status']}</td>
                        <td>{if $v['email']}
                             <a href="?id={$v['id']}&email={$v['email']}&action=reset_password_submit" class="btn btn-success btn-xs"><i class="fa fa-pencil"></i>
                                    重置密码</a>
                            {else}
                                {*<a href="?id={$v['id']}&action=reset_password_email" class="btn btn-success btn-xs"><i class="fa fa-pencil"></i>*}
                                    {*输入邮箱</a>*}
                                <a class="btn btn-default btn-xs"data-toggle="modal" href="#basic" onclick="inputEmailId({$v['id']})"><i class="fa fa-pencil"></i>请输入邮箱</a>
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
{*弹出层*}
<div class="modal fade" id="basic" tabindex="-1" role="basic" aria-hidden="true" style="display: none;">
    <div class="modal-dialog">
        <div class="modal-content">
            <form action="?action=reset_insert_email" method="post">
            {*<div class="modal-header">*}
                {*<button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>*}
                {*<h4 class="modal-title">请输入邮箱</h4>*}
            {*</div>*}
            <div class="modal-body">
                <div class="row">
                    <div class="col-md-12">
                        <h4>请输入邮箱</h4>
                        <p>
                            <input type="text" class="col-md-12 form-control" name="email">
                            <input type="hidden" id="reset_account_id" name="id" value="">
                        </p>
                    </div>
                </div>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="submit" class="btn btn-info">发送并保存该邮箱</button>
            </div>
        </div>
        </form>
    </div>
</div>
<!-- BEGIN CORE PLUGINS -->
<script src="{$_assets}plugins/jquery-1.11.0.min.js"
        type="text/javascript"></script>
<script src="{$_assets}/plugins/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
<script src="{$_assets}scripts/_page.js"></script>
<script>
    function inputEmailId(val){
        $("#reset_account_id").val(val);
    }
</script>
</body>
<!-- END BODY -->
</html>