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
                <form action="?" method="post" class="clearfix">
                    <div class="form-body clearfix">
                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">标签名称</label>

                            <div class="col-md-9">
                                <input type="text" class="form-control input-sm" placeholder="标签名称"
                                       name="search[tag_value]" value="{$_REQUEST['search']['tag_value']}">
                            </div>
                        </div>
                        {*<div class="form-group col-md-5">*}
                            {*<label class="col-md-3 control-label">创建时间</label>*}

                            {*<div class="col-md-4">*}
                                {*<input type='text' class="form-control date" placeholder="请选择开始时间"*}
                                       {*name="search[start_time]" value="{$_REQUEST['search']['start_time']}"/>*}
                            {*</div>*}
                            {*<div class="col-md-4 col-md-offset-1">*}
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
            需求标签列表
        </div>
    </div>
    <div class="portlet-body">
        <div class="table-responsive clearfix">
            <table class="table table-striped table-bordered table-hover"style="word-break: break-all">
                <thead>
                <tr>
                    <th>标签ID</th>
                    <th>标签名称</th>
                    <th>操作人</th>
                    <th>创建时间</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                {foreach $_data['rows'] as $k=>$v}
                    <tr>
                        <td>{$v['id']}</td>
                        <td>{$v['tag_value']}</td>
                        <td>{$v['fullname']}</td>
                        <td>{date('Y-m-d H:i:s',$v['create_time'])}</td>
                        <td>
                            {*<a href="?action=edit&amp;id=8" class="btn btn-info btn-xs"><i class="fa fa-pencil"></i>修改</a>&nbsp;&nbsp;*}
                            <a href = '?action=del&id={$v['id']}'class="btn btn-danger btn-xs"><i class="fa fa-trash-o"></i>删除</a>&nbsp;&nbsp;
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
{*<script src="{$_assets}plugins/jquery-1.11.0.min.js"*}
        {*type="text/javascript"></script>*}
{*<script src="{$_assets}plugins/bootstrap/js/bootstrap.min.js"*}
        {*tab="text/javascript"></script>*}
{*<script src="{$_assets}scripts/_page.js"></script>*}
{*<script type="text/javascript" src="js/moment.min.js"></script>*}
{*<script type="text/javascript" src="js/bootstrap-datetimepicker.min.js"></script>*}

</body>
<!-- END BODY -->
</html>