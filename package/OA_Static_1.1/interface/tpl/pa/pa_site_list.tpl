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
        <div class="btn btn-default  {if $handle_type=='adver' } btn-success{/if} active go_switch_window">
            广告管理
        </div>
    </a>
    <a href="?action=site_list">
        <div class="btn btn-default {if $handle_type=='adver_site' || !isset($handle_type)} btn-success{/if} go_switch_window">
            广告位管理
        </div>
    </a>
    <a href="?action=adver_statistics">
        <div class="btn btn-default {if $handle_type=='adver_statistics'} btn-success{/if} go_switch_window">广告位统计</div>
    </a>
</div>

<div class="portlet">
    <div class="portlet-title">
        <div class="caption">
            <i class="fa fa-search"></i>搜索条件
        </div>
        <div style="float: right;">
            <a href="?action=siteAdd" class="btn btn-info btn-xs" style="font-size:15px!important;"><i
                        class="fa fa-plus"></i>添加广告位</a>
        </div>
    </div>
    <div class="portlet-body">
        <div class="portlet-tabs">
            <div class="clearfix"></div>
            <div>
                <form action="?action=site_list" method="post" class="clearfix">
                    <input type="hidden" name="type" value="{$type}">
                    <div class="form-body clearfix">
                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">广告位置</label>

                            <div class="col-md-4">
                                <input type='text' class="form-control" placeholder="广告位置"
                                       name="search[site]" value="{$_REQUEST['search']['site']}"/>
                            </div>
                        </div>
                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">创建时间</label>

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

    <div class="portlet-body">
        <ul class="nav nav-tabs">
            <li class="{if $type=='normal'}active{/if}">
                <a href="?action=site_list&type=normal&{if !empty($_REQUEST['search'])}search[title]={$_REQUEST['search']['title']}&search[start_time]={$_REQUEST['search']['start_time']}&search[end_time]={$_REQUEST['search']['end_time']}{/if}">正常</a>
            </li>
            <li class="{if $type=='close'}active{/if}">
                <a href="?action=site_list&type=close&{if !empty($_REQUEST['search'])}search[title]={$_REQUEST['search']['title']}&search[start_time]={$_REQUEST['search']['start_time']}&search[end_time]={$_REQUEST['search']['end_time']}{/if}">已关闭</a>
            </li>
        </ul>
        <div class="table-responsive clearfix">
            <table class="table table-striped table-bordered table-hover" id="data_table" style="word-break: break-all">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>广告位置</th>
                    <th>广告描述</th>
                    <th>版位尺寸</th>
                    <th>投放城市</th>
                    <th>创建时间</th>
                    <th>操作</th>
                </tr>
                </thead>
                {foreach $data['rows'] as $k=>$v}
                    <tr>
                        <td>{$v['id']}</td>
                        <td>{$v['site']}</td>
                        <td>{$v['description']}</td>
                        <td>{$v['size']['width']} * {$v['size']['height']} &nbsp;(宽*高)</td>
                        <td>{$v['adver_city']}</td>
                        <td>{date('Y-m-d',$v['create_time'])}</td>
                        <td>
                            {if $v['status']==0}
                            <a href="?action=site_edit&id={$v['id']}" class="btn btn-info btn-xs"><i
                                        class="fa fa-pencil"></i>
                                修改</a>

                            <a href="?action=close&id={$v['id']}" class="btn btn-danger btn-xs"><i
                                        class="fa fa-trash-o"></i>
                                关闭</a>
                                {else}
                                <a href="?action=restore&id={$v['id']}" class="btn btn-success btn-xs"><i
                                            class="fa fa-rotate-left"></i>
                                    恢复</a>
                            {/if}

                        </td>
                    </tr>
                {/foreach}
                </thead>
                <tbody>

            </table>
        </div>
    </div>
</div>

<div class="pull-left" style="width:30%; padding: 10px 0;">

</div>
<div class="pull-right">
    <ul class="pagination">
        {if $data['page']['dpll']}
            <li class="prev">
                <a href="{$data['page']['dup']}1" title="First"><i class="fa fa-angle-double-left"></i></a>
            </li>
            <li class="prev">
                <a href="{$data['page']['dup']}{$data['page']['dp']-1}" title="Prev"><i
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
        {for $i=$data['page']['dpl'] to $data['page']['dpr']}
            <li{if $i==$data['page']['dp']} class="active"{/if}>
                <a href="{$data['page']['dup']}{$i}">{$i}</a>
            </li>
        {/for}
        <li class="disabled">
            <a> {$data['page']['dtp']}
                ( {$data['page']['dp']*$data['page']['dn']}
                /{$data['page']['dt']} )</a>
        </li>

        {if $data['page']['dprr']}
            <li class="next">
                <a href="{$data['page']['dup']}{$data['page']['dp']+1}" title="Next"><i
                            class="fa fa-angle-right"></i></a>
            </li>
            <li class="next">
                <a href="{$data['page']['dup']}{$data['page']['dtp']}" title="Last"><i
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
<script type="text/javascript" src="js/moment.min.js"></script>
<script type="text/javascript" src="js/zh-cn.js"></script>
<script type="text/javascript" src="js/bootstrap-datetimepicker.min.js"></script>
<script>
    $(document).ready(function () {
        $('.date').datetimepicker({
            format: 'YYYY-MM-DD',
            locale: 'zh-cn'
        });
    })
</script>
</body>
<!-- END BODY -->
</html>