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
    <link href="style/media.css" rel="stylesheet"/>
</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->

<body style="background:#FaFaFa !important">
<div class="portlet">
    <div class="portlet-title">
        <div class="caption">
            <i class="fa fa-database"></i>超时订单处理
        </div>
    </div>
    <div class="portlet-body">

        <ul class="nav nav-tabs">
            <li class="{if $type=='waiting'}active{/if}">
                <a href="?type=waiting">待处理（{intval($_overtimetotal)}）</a>
            </li>
            <li class="{if $type=='done'}active{/if}">
                <a href="?type=done">当日已处理（{intval($_donetotal)}）</a>
            </li>
            <li class="{if $type=='history'}active{/if}">
                <a href="?type=history">历史已处理（{intval($_historytotal)}）</a>
            </li>
        </ul>
        <div class="tab-content clearfix"><div class="table-responsive">

                <table class="table table-striped table-bordered table-advance table-hover table-newstyle">
                    <thead>

                    <tr>
                        <th class="list_none">超时时间</th>
                        <th class="list_none">更新时间</th>
                        <th class="td-mbl-w35">订单号</th>
                        <th class="list_none">订单状态</th>
                        <th class="list_none">服务名称</th>
                        <th class="list_none">用户名称</th>
                        <th class="list_none">供应商名称</th>
                        <th class="td-mbl-w40">联系电话</th>
                        <th class="td-mbl-w25">操作</th>
                    </tr>
                    </thead>
                    <tbody>
                    {foreach $_data['rows'] as $k=>$v}

                        <tr {if $v['status']=='1'} {if $v['gap'] >1200} {'class="danger"'}{else}{'class="success"'}{/if} {/if}>

                            <td class="list_none">{Func_Time::format($v['create_time'])}
                            </td>
                            <td class="list_none">{if $v['update_time']} {Date('Y-m-d H:i',$v['update_time'])}{/if}</td>
                            <td class="td-mbl-w35">{$v['order_no']}</td>
                            <td class="red list_none">{$v['order_status']}</td>
                            <td class="list_none">{$v['order_title']}</td>
                            <td class="list_none">{$v['username']}</td>
                            <td class="list_none">{$v['vendor_name']}</td>
                            <td class="td-mbl-w30">{$v['phone']}</td>
                            <td class="red td-mbl-w25">
                                <a href="?action=detail&order_no={$v['order_no']}" class="btn btn-info btn-xs">超时订单处理</a>
                            {if $type=='history'}
                                <a href="?action=order_del&order_id={$v['id']}" class="btn  btn-danger btn-xs">删除订单</a>
                            {/if}
                            </td>
                        </tr>
                    {/foreach}
                    </tbody>
                </table>
            </div>
            <div class="container-fluid">
                <div class="row">
                    <div class="col-md-12" style="padding: 0px;">
                        <ul class="pagination">
                            {if $_data['page']['dpll']}
                                <li class="prev">
                                    <a href="{$_data['page']['dup']}1" title="First"><i class="fa fa-angle-double-left"></i></a>
                                </li>
                                <li class="prev">
                                    <a href="{$_data['page']['dup']}{$_waiting['page']['dp']-1}" title="Prev"><i class="fa fa-angle-left"></i></a>
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
</div>

</body>
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
<script src="{$_assets}scripts/_page.js"></script>
</body>
<!-- END BODY -->
</html>