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
                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">供应商名称/ID</label>

                            <div class="col-md-9">
                                <input type="text" class="form-control input-sm" placeholder="供应商名称/ID" name="vendor_name" value="{$_REQUEST['vendor_name']}">
                            </div>
                        </div>
                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">手机号</label>

                            <div class="col-md-9">
                                <input type="text" class="form-control input-sm" placeholder="手机号" name="phone" value="{$_REQUEST['phone']}">
                            </div>
                        </div>
                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">城市</label>

                            <div class="col-md-9">
                                {*<select class="form-control" name="city">*}
                                    {*<option {if !$_REQUEST['city']}selected {/if} value="">全部</option>*}
                                    {*{foreach $_vendor_attr['attr']['城市'] as $k=>$v}*}
                                        {*<option {if $_REQUEST['city']==$v}selected {/if}>{$v}</option>*}
                                    {*{/foreach}*}
                                {*</select>*}
                                <input type="text" class="form-control input-sm" placeholder="请输入要搜索的城市" name="city" value="{$_REQUEST['city']}">
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
            激活供应商列表
        </div>
    </div>
    <div class="portlet-tabs" style="position:relative">
        <ul class="nav nav-tabs">
            {*<li class="{if $_REQUEST['handle_type']=='overdue'}active{/if}">*}
                {*<a href="?handle_type=overdue">过期未激活</a>*}
            {*</li>*}
            <li class="{if $_REQUEST['handle_type']=='activate'}active{/if}">
                <a href="?handle_type=activate">已激活</a>
            </li>
            <li class="{if $_REQUEST['handle_type']=='waiting'}active{/if}">
                <a href="?handle_type=waiting">待激活</a>
            </li>
        </ul>
    </div>
    <div class="portlet-body">

        <div class="tab-content clearfix">
            <div class="table-responsive">
                <table class="table table-striped table-bordered table-advance table-hover">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>供应商名称</th>
                    <th>账户名</th>
                    <th>联系方式</th>
                    <th>邮箱</th>
                    <th>城市</th>
                    <th>创建时间</th>
                    {if $_REQUEST['handle_type'] == "activate"}
                        <th>激活时间</th>
                    {/if}
                    {*<th>操作</th>*}
                </tr>
                </thead>
                <tbody>
                {foreach $_data['rows'] as $k=>$v}
                    <tr>
                        <td>{$v['id']}</td>
                        <td>{$v['vendor_name']}</td>
                        <td>{$v['username']}</td>
                        <td>{$v['phone']}</td>
                        <td>{$v['email']}</td>
                        <td>{$v['city']}</td>
                        <td>{date("Y-m-d H:i:s",$v['create_time'])}</td>
                        {if $_REQUEST['handle_type'] == "activate"}
                            <td>{date("Y-m-d H:i:s",$v['update_time'])}</td>
                        {/if}
                        {*<td>*}
                            {*<a class="btn btn-xs btn-primary" href="?action=add_expand&vendor_id={$v['id']}">添加拓展信息</a>*}
                        {*</td>*}
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
                            /{$_data['page']['dt']}
                            )</a></li>

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
</div>
</body>

<!-- END BODY -->
</html>