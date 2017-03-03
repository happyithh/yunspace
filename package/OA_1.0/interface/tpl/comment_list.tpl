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
        <i class="fa fa-database"></i>{$page_name}
    </div>
</div>
<div class="portlet-body">
    <div class="portlet-tabs">
        <ul class="nav nav-tabs" style="overflow: inherit; padding-left: 100px">
            <li class="{if $page_nav=='rejected'}active{/if}">
                <a href="?{if !empty($_REQUEST['search']['title'])}page_nav=rejected{$urls}{else}page_nav=rejected{/if}">已拒绝</a>
            </li>
            <li class="{if $page_nav=='notYet'}active{/if}">
                <a href="?{if !empty($_REQUEST['search']['title'])}page_nav=notYet{$urls}{else}page_nav=notYet{/if}">待审核</a>
            </li>
            <li class="{if $page_nav=='yet'}active{/if}">
                <a href="?{if !empty($_REQUEST['search']['title'])}page_nav=yet{$urls}{else}page_nav=yet{/if}">已审核</a>
            </li>
        </ul>

        <div class="clearfix"></div>
        <div class="tab-content">
            <div class="tab-pane active">
                <div class="pull-left" style="width:30%; padding: 10px 0;">
                    <form action="?">
                        <div class="input-group">
                            {foreach $_REQUEST as $k=>$v}
                                {if $k!=='search'&& $k!=='cities'}
                                    <input type="hidden" name="{$k}" value="{$v}">
                                {/if}
                            {/foreach}
                            <input type="text" class="form-control" placeholder="ID" name="search[title]" value="{$_REQUEST['search']['title']}">
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
                            <a> {$_data['page']['dtp']} ( {$_data['page']['dp']*$_data['page']['dn']}/{$_data['page']['dt']} )</a></li>

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
                        <td>#ID</td>
                        <td>评论人</td>
                        <td>评论对象</td>
                        <td>内容</td>
                        <td>文章类型</td>
                        <td>ip地址</td>
                        {if $page_nav=='rejected'}
                            <td>拒绝原因</td>
                        {/if}
                        <td>操作</td>

                    </tr>
                    </thead>
                    <tbody>
                    {foreach $_data['rows'] as $k => $v}

                            <tr>
                                <td>{$v['id']}</td>
                                <td>{$v['fullname']}</td>
                                <td>{$v['title']}</td>
                                <td>{$v['cont']}</td>
                                <td>{$type['1']}</td>
                                <td>{$v['ip']}</td>
                                {if $page_nav=='rejected'}
                                    <td>{$v['marks']}</td>
                                {/if}
                                {if $page_nav=='notYet'}
                                <td>
                                    <a href="?action=detail&id={$v['id']}" class="btn btn-danger btn-xs"><i class="fa fa-pencil"></i> 审核</a>
                                </td>
                                    {else}
                                    <td></td>
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
<script src="{$_assets}scripts/_page.js"></script>
</body>

<!-- END BODY -->
</html>