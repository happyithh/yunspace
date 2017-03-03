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
        <ul class="nav nav-tabs" style="overflow: inherit; padding-left: 100px">
            <li class="{if $page_nav=='delete'}active{/if}">
                <a href="?action=listDelete">已删除</a>
            </li>
            <li class="{if $page_nav=='stop'}active{/if}">
                <a href="?action=listStop">已停用</a>
            </li>

            <li class="{if $page_nav=='normal'}active{/if}">
                <a href="?action=normal">正常</a>
            </li>
            <li class="{if $page_nav=='notYet'}active{/if}">
                <a href="?action=listUnaccepted">待审核</a>
            </li>

        </ul>
        <div class="clearfix"></div>
        <div class="tab-content">
            <div class="tab-pane active">
                <div class="pull-left" style="width:30%; padding: 10px 0;">
                    <form action="?">
                        <div class="input-group">
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
                           活动名称
                        </th>
                        <th>
                            活动时间
                        </th>
                        <th>
                            活动地址
                        </th>
                        <th>
                            活动类型
                        </th>
                        <th>
                            活动品牌
                        </th>
                        <th>
                            活动城市
                        </th>
                            <th>
                                操作
                            </th>

                    </tr>
                    </thead>
                    <tbody>
                    {*{$_data['rows']|var_dump}*}
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
                                {$v['event_name']}
                            </td>
                            <td>
                                {$v['event_time']}
                            </td>
                            <td>
                                {$v['addr']}
                            </td>
                            <td>
                                {$v['attr']['类型']}
                            </td>
                            <td>
                                {$v['attr']['品牌']}
                            </td>
                            <td>
                                {$v['attr']['城市']}
                            </td>
                            <td>
                                {if $v['status']!=98&&$v['status']!=99}
                                <a href="?action=edit&ids[]={$v['id']}"
                                   class="btn btn-danger btn-xs"><i class="fa fa-pencil"></i>编辑</a>
                                {/if}
                                {if $v['status']==98}
                                    <a href="?action=start&ids[]={$v['id']}"
                                       class="btn btn-primary btn-xs"><i class="fa fa-rotate-left"></i>启用</a>
                                {/if}
                                {if $v['status']==99}
                                    <a href="?action=start&ids[]={$v['id']}"
                                       class="btn btn-primary btn-xs"><i class="fa fa-history"></i>恢复</a>
                                    <a href="?action=downright&ids[]={$v['id']}"
                                       class="btn btn-danger btn-xs"><i class="fa fa-trash-o"></i>彻底删除</a>
                                {/if}
                                {if $v['status']==1}
                                    <a href="?action=stop&ids[]={$v['id']}"
                                       class="btn btn-danger btn-xs"><i class="fa fa-ban"></i>停用</a>

                                {/if}

                                {if $v['status']==0}
                                    <a href="?action=accept&ids[]={$v['id']}"
                                       class="btn btn-primary btn-xs"><i class="fa fa-check"></i>通过</a>
                                {/if}
                                {if $v['status']!=99}
                                    <a href="?action=del&ids[]={$v['id']}"
                                       class="btn btn-danger btn-xs"><i class="fa fa-trash-o"></i>删除</a>
                                {/if}


                            </td>
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