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
        <i class="fa fa-database"></i>{$_table['name']}
    </div>
</div>
<div class="portlet-body">
    <div class="portlet-tabs">
        <ul class="nav nav-tabs"
            style="overflow: inherit; padding-left: 100px">
            {foreach $_table['filter'] as $k=>$v}
                <li{if $_table['filter_id']==$k} class="active"{/if}>
                    <a href="?filter_id={$k}">{$v}</a>
                </li>
            {/foreach}
            <li style="padding: 5px 4px 0 0">
                <div class="btn-group">
                    <a class="btn btn-info dropdown-toggle" type="button" data-toggle="dropdown">
                        <i class="fa fa-magic"></i>
                        <i class="fa fa-angle-down"></i>
                    </a>
                    <ul class="dropdown-menu" role="menu">
                        <li>
                            <a href="#"><i class="fa fa-print"></i>打印</a>
                        </li>
                        <li>
                            <a href="#"><i class="fa fa-file-pdf-o"></i>导出
                                PDF</a>
                        </li>
                        <li>
                            <a href="#"><i class="fa fa-file-excel-o"></i>导出
                                Excel</a>
                        </li>
                        {if !empty($_table['filter'])}
                            <li class="divider">
                            </li>
                        {/if}
                        {foreach $_table['filter_action'][$_table['filter_id']] as $k=>$v}
                            {if is_numeric($k)&&$_table['filter'][$k]}
                                <li>
                                    <a href="#">{$v}
                                        (批量)</a>
                                </li>
                            {/if}
                        {/foreach}
                    </ul>
                </div>
            </li>
            <li style="padding: 5px 4px 0 0">
                <div>
                    <a class="btn btn-success" href="?action=add"><i class="fa fa-plus"></i></a>
                </div>
            </li>
        </ul>
        <div class="clearfix"></div>
        <div class="tab-content">
            <div class="tab-pane active">
                <div class="pull-left" style="width:30%; padding: 10px 0;">
                    <form action="?">
                        <div class="input-group">
                            {foreach $_REQUEST as $k=>$v}
                                {if $k!=='search'}
                                    <input type="hidden" name="{$k}" value="{$v}">
                                {/if}
                            {/foreach}
                            <input type="text" class="form-control" placeholder="ID / 关键词" name="search[title]" value="{$_REQUEST['search']['title']}">
                        <span class="input-group-btn">
                        <button class="btn btn-info" type="submit">
                            <i class="fa fa-search"></i>
                        </button>
                        </span>
                        </div>
                    </form>
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

                <table class="table table-striped table-bordered table-hover"
                       id="data_table" style="word-break: break-all">
                    <thead>
                    <tr>
                        <th class="table-checkbox"
                            style="width:16px">
                            <input type="checkbox"
                                   class="group-checkable"
                                   data-set="#data_table .checkboxes"/>
                        </th>
                        <th>
                            #
                        </th>

                        <th>
                           创建者
                        </th>
                        <th>
                           分类ID
                        </th>
                        <th>
                          供应商ID
                        </th>
                        <th>
                            产品名称
                        </th>
                        <th>
                            媒体材料
                        </th>
                        <th>
                           浏览量
                        </th>
                        <th>
                            收藏量
                        </th>
                        <th>
                           取消收藏量
                        </th>
                        <th>
                           订单数
                        </th>
                        <th>
                          完成订单数
                        </th>
                        <th>
                            操作
                        </th>
                    </tr>
                    </thead>
                    <tbody>
                    {foreach $_data['rows'] as $k=>$v}

                        <tr>
                            <td>
                                <input type="checkbox"
                                       class="checkboxes"
                                       value="{$v['id']}"
                                       name="ids[]"/>
                            </td>
                            <td>
                                {$v['id']}
                            </td>
                            <td>
                                {$v['admin_id']}
                            </td>
                            <td>
                                {$v['category_id']}
                            </td>
                            <td>
                                {$v['vendor_id']}
                            </td>

                            <td>
                                {$v['product_name']}
                            </td>
                            <td>
                                {$v['media_num']}
                            </td>
                            <td>
                                {$v['counter_view']}
                            </td>
                            <td>
                                {$v['counter_follow']}
                            </td>
                            <td>
                                {$v['counter_follow_cancel']}
                            </td>
                            <td>
                                {$v['counter_order']}
                            </td>
                            <td>
                                {$v['counter_order_complete']}
                            </td>
                            {if $_table['filter_action'][$_table['filter_id']]}
                                <td>
                                    {foreach $_table['filter_action'][$_table['filter_id']] as $ak=>$av}
                                        {if is_numeric($ak)}
                                            <a href="?action=update&ids[]={$v['id']}&data[{$_table['filter_col']}]={$ak}"
                                               class="btn{if $ak>90} btn-danger{else} btn-primary{/if} btn-xs">{$av}</a>
                                        {else}
                                            <a href="?ids[]={$v['id']}&action={$ak}"
                                               class="btn btn-success btn-xs">{$av}</a>
                                        {/if}
                                    {/foreach}
                                    <a href="/service_info/{$v['id']}.html" target="_blank"
                                       class="btn btn-success btn-xs">预览</a>
                                </td>
                            {/if}
                        </tr>
                    {/foreach}
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>


<!-- BEGIN JAVASCRIPTS(Load javascripts at bottom, this will reduce page load time) -->
<!-- BEGIN CORE PLUGINS -->
<script src="{$_assets}plugins/jquery-1.11.0.min.js"
        type="text/javascript"></script>
<script src="{$_assets}plugins/jquery-migrate-1.2.1.min.js"
        type="text/javascript"></script>
<!-- IMPORTANT! Load jquery-ui-1.10.3.custom.min.js before bootstrap.min.js to fix bootstrap tooltip conflict with jquery ui tooltip -->
<script src="{$_assets}plugins/jquery-ui/jquery-ui-1.10.3.custom.min.js"
        type="text/javascript"></script>
<script src="{$_assets}plugins/bootstrap/js/bootstrap.min.js"
        type="text/javascript"></script>
<script src="{$_assets}plugins/bootstrap-hover-dropdown/bootstrap-hover-dropdown.min.js"
        type="text/javascript"></script>
<script src="{$_assets}plugins/jquery-slimscroll/jquery.slimscroll.min.js"
        type="text/javascript"></script>
<script src="{$_assets}plugins/jquery.blockui.min.js"
        type="text/javascript"></script>
<script src="{$_assets}plugins/uniform/jquery.uniform.min.js"
        type="text/javascript"></script>
<!-- END CORE PLUGINS -->
<!-- BEGIN PAGE LEVEL PLUGINS -->
<script type="text/javascript"
        src="{$_assets}plugins/select2/select2.min.js"></script>
<script type="text/javascript"
        src="{$_assets}plugins/datatables/media/js/jquery.dataTables.min.js"></script>
<script type="text/javascript"
        src="{$_assets}plugins/datatables/plugins/bootstrap/dataTables.bootstrap.js"></script>
<!-- END PAGE LEVEL PLUGINS -->
<!-- BEGIN PAGE LEVEL SCRIPTS -->
<script src="{$_assets}scripts/app.js"></script>
<script src="{$_assets}scripts/_page.js"></script>
<script>
    jQuery(document).ready(function () {
        App.init();
        TableManaged.init();
    });
</script>
</body>

<!-- END BODY -->
</html>