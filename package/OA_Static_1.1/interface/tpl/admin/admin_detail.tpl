<!DOCTYPE html>
<!--[if IE 8]>
<html lang="en" class="ie8 no-js"> <![endif]-->
<!--[if IE 9]>
<html lang="en" class="ie9 no-js"> <![endif]-->
<!--[if !IE]><!-->
<html lang="en" class="no-js" xmlns="http://www.w3.org/1999/html">
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
<div class="portlet">
    <div class="portlet-title">
        <div class="caption">
            <i class="fa fa-reorder"></i>
            {if $_REQUEST['admin_id']}
                修改管理员信息
            {else}
                添加管理员
            {/if}
        </div>
    </div>
    <div class="portlet-body">
        <div class="tab-content clearfix">
            <form action="?" method="post">
            <input type="hidden" name="action" value="add_admin_submit">
            <input type="hidden" name="data[admin_id]" value="{$_REQUEST['admin_id']}">
            <input type="hidden" name="data[old_department_name]" value="{$_REQUEST['department_name']}">
            <input type="hidden" name="data[handle_type]" value="{$_REQUEST['handle_type']}">
            <div class="tab-pane fade active in" id="tab_1_1">
                <h3 >个人信息</h3>
                <div class="table-responsive clearfix">
                    <div class="col-md-9 form-group">
                        <label class="control-label col-md-2" style="font-size: 15px;">姓名</label>

                        <div class="col-sm-10">
                            <input type="text" class="form-control" placeholder="请输入管理员姓名" name="data[fullname]" value="{$_data['fullname']}">
                        </div>
                    </div>
                    <div class="col-md-9 form-group">
                        <label class="control-label col-sm-2" style="font-size: 15px;">登录名</label>

                        <div class="col-sm-10">
                            <input type="text" class="form-control" placeholder="请输入登录名称" name="data[username]" value="{$_data['username']}">
                        </div>
                    </div>
                    <div class="col-md-9 form-group">
                        <label class="control-label col-sm-2" style="font-size: 15px;">手机号</label>

                        <div class=" col-sm-10">
                            <input type="text" class="form-control" placeholder="请输入管理员手机号" name="data[phone]" value="{$_data['phone']}">
                        </div>
                    </div>
                    <div class="col-md-9 form-group">
                        <label class="control-label col-sm-2"  style="font-size: 15px;">邮箱</label>

                        <div class="col-sm-10">
                            <input type="text" class="form-control" placeholder="请输入管理员邮箱" name="data[email]" value="{$_data['email']}">
                        </div>
                    </div>
                    <div class="col-md-9 form-group">
                        <label class="control-label col-sm-2"  style="font-size: 15px;">密码</label>

                        <div class="col-sm-8">
                            <input type="password" class="form-control" placeholder="请输入密码" name="data[password]">
                        </div>
                        <span style="display: inline-block;padding-top:10px;color:#d43f3a;">初始密码为：111111</span>
                    </div>
                </div>
                <hr>
                <h3 >职位信息</h3>
                <div class="table-responsive clearfix">
                    <div class="col-md-9 form-group">
                        <label class="control-label col-md-2" style="font-size: 15px;">城市</label>

                        <div class="col-sm-10">
                            <select class="form-control input-sm" name="data[city]">
                                {foreach Web_Global::getAllCities() as $v}
                                    <option {if $_data['department_city']==$v}selected {/if} value="{$v}">{$v}</option>
                                {/foreach}
                            </select>
                        </div>
                    </div>
                    <div class="col-md-9 form-group">
                        <label class="control-label col-sm-2" style="font-size: 15px;">部门</label>
                         {*{var_dump($_data)}*}
                        <div class="col-sm-10">
                            <select class="form-control input-sm" name="data[department_name]">
                                {foreach $department as $k=>$v}
                                    <option {if $_data['department_name']== $v}selected {/if} value={$v}>{$v}</option>
                                {/foreach}
                            </select>
                        </div>
                    </div>
                    {*<div class="col-md-9 form-group">*}
                        {*<label class="control-label col-sm-2" style="font-size: 15px;">组别</label>*}

                        {*<div class=" col-sm-10">*}
                            {*<input type="text" class="form-control" placeholder="请输入管理员所属组" name="data[team_name]" value="{$_data['team_name']}">*}
                        {*</div>*}
                    {*</div>*}
                    <div class="col-md-9 form-group">
                        <label class="col-md-2 control-label">组别</label>

                        <div class="col-md-10 col-sm-12" id="changera">
                            {foreach $teams["销售部"] as $v}
                                <label class="radio-inline" ><input   type="radio" name="data[is_ka]" {if $_data['is_ka']==$v}checked {/if} value="{$v}">{$v}</label>
                            {/foreach}
                            <label class="radio-inline" ><input   type="radio" name="data[is_ka]" {if $_data['is_ka']=="测试"}checked {/if} value="测试">测试</label>
                        </div>
                    </div>
                    <div class="col-md-9 form-group">
                        <label class="col-md-2 control-label">所属组</label>

                        <div class="col-md-10 col-sm-12">
                            <input type="text" id="team_name" class="form-control" name="data[team_name]" value="{$_data['team_name']}">
                        </div>
                    </div>
                    <div class="col-md-9 form-group">
                        <label class="col-md-2 control-label"></label>
                        <div class="col-md-10 col-sm-12">
                            <span>示例分组：</span>
                            <span onclick="fillTeam(this)" class="btn btn-default btn-sm" style="margin-right: 10px;">A组</span>
                            <span onclick="fillTeam(this)" class="btn btn-default btn-sm" style="margin-right: 10px;">B组</span>
                            <span onclick="fillTeam(this)" class="btn btn-default btn-sm" style="margin-right: 10px;">C组</span>
                            <span onclick="fillTeam(this)" class="btn btn-default btn-sm" style="margin-right: 10px;">D组</span>
                        </div>
                    </div>

                    <div class="col-md-9 form-group">
                        <label class="control-label col-sm-2"  style="font-size: 15px;">职位</label>

                        <div class="col-sm-10">
                            <label class="radio-inline"><input type="radio" name="data[level]"   {if $_data['level']==1}checked {/if} value="1">主管</label>
                            <label class="radio-inline"><input type="radio" name="data[level]"   {if $_data['level']==0}checked {/if} value="0">普通</label>
                            {*<input type="text" class="form-control" placeholder="请输入管理员职位" name="data[position]" value="{$_data['position']}">*}
                        </div>
                    </div>
                    <div class="col-md-9 form-group">
                        <label class="control-label col-sm-2"  style="font-size: 15px;">权限</label>

                        <div class="col-sm-10">
                            <select multiple="multiple" class="multi-select" id="my_multi_select2" name="data[role_ids][]">
                                {foreach $roles as $k=>$v}
                                    <optgroup label="{$k}">
                                        {foreach $v as $vk=>$vv}
                                            <option value="{$vk}" {if $_data['role_ids'][$vk]}selected="selected" {/if}>{$vv}</option>
                                        {/foreach}
                                    </optgroup>
                                {/foreach}
                            </select>
                        </div>
                    </div>
                </div>
            </div>
            <div class="form-actions text-center">
                <button type=" reset" class="btn btn-default">
                    重置
                </button>
                <button type="submit" class="btn btn-success">
                    提交
                </button>
            </div>
            </form>
        </div>
    </div>
</div>
<script src="{$_assets}plugins/jquery-1.11.0.min.js" type="text/javascript"></script>
<script type="text/javascript" src="{$_assets}plugins/datatables/plugins/bootstrap/dataTables.bootstrap.js"></script>
<link rel="stylesheet" type="text/css" href="{$_assets}plugins/jquery-multi-select/css/multi-select.css"/>
<script type="text/javascript" src="{$_assets}plugins/jquery-multi-select/js/jquery.multi-select.js"></script>
<script>
    jQuery(document).ready(function () {
        $('#my_multi_select2').multiSelect({
            selectableOptgroup: true
        });
    });
    function fillTeam(o){
        var team_name=$(o).text();
        $('#team_name').val(team_name);
    }
</script>
</body>
<!-- END BODY -->
</html>