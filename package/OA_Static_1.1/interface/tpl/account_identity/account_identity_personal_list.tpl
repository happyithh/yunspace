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
            <i class="fa fa-database"></i>个人用户认证审核
        </div>
    </div>
    <div class="portlet-body">
        <div class="portlet-tabs">
            <ul class="nav nav-tabs" style="overflow: inherit; padding-left: 100px">
                <li class="{if $_REQUEST['status']==-1}active{/if}">
                    <a href="?{if !empty($_REQUEST['search_title'])}action=list&status=-1{$urls}{else}action=list&status=-1{/if}">已拒绝</a>
                </li>
                <li class="{if $_REQUEST['status']==0}active{/if}">
                    <a href="?{if !empty($_REQUEST['search_title'])}action=list&status=0{$urls}{else}action=list&status=0{/if}">待审核</a>
                </li>
                <li class="{if $_REQUEST['status']==1}active{/if}">
                    <a href="?{if !empty($_REQUEST['search_title'])}action=list&status=1{$urls}{else}action=list&status=1{/if}">已审核</a>
                </li>
                <li class="{if $_REQUEST['status']==99}active{/if}">
                    <a href="?{if !empty($_REQUEST['search_title'])}action=list&status=99{$urls}{else}action=list&status=99{/if}">全部</a>
                </li>
            </ul>

            <div class="clearfix"></div>
            <div class="tab-content">
                <div class="tab-pane active">
                    <div class="pull-left" style="width:50%; padding: 10px 0;">
                        <form action="?">
                            <div class="input-group">
                                <input type="text" class="form-control" placeholder="用户名/手机号/邮箱/认证全名" name="search_title"
                                       value="{$_REQUEST['search_title']}">
                        <span class="input-group-btn" style="position: absolute;right: 0;top:0;">
                        <button class="btn btn-info" type="submit">
                            <i class="fa fa-search"></i>
                        </button>
                        </span>
                            </div>
                        </form>
                    </div>

                    <table class="table table-striped table-bordered table-hover"
                           id="data_table" style="word-break: break-all">
                        <thead>
                        <tr>
                            <td>用户名</td>
                            <td>手机</td>
                            <td>邮箱</td>
                            <td>全名</td>
                            {if $page_nav=='rejected'}
                                <td>拒绝原因</td>
                            {/if}
                            <td>认证状态</td>
                            <td>操作</td>

                        </tr>
                        </thead>
                        <tbody>
                    {if  $_data['rows']}
                        {foreach $_data['rows'] as $k => $v}
                            <tr>
                                <td>{$v['username']}</td>
                                <td>{$v['phone']}</td>
                                <td>{$v['email']}</td>
                                <td>{$v['fullname']}</td>
                                {if $page_nav=='rejected'}
                                    <td>{$v['rejectReason']}</td>
                                {/if}
                                <td>{$status_arr[$v['status']]}</td>

                                    <td>
                                        <a href="?action=details&identity_id={$v['id']}" class="btn btn-danger btn-xs"><i
                                                    class="fa fa-pencil"></i> 审核</a>
                                    </td>
                            </tr>
                        {/foreach}
                        {else}
                        <tr>
                            <td colspan="6" style="text-align: center;font-size: 14px;font-weight: 600;">没有信息</td>
                        </tr>
                        {/if}
                        </tbody>
                    </table>
                    <div class="center-block">
                        <ul class="pagination">
                            {if $_data['page']['dpll']}
                                <li class="prev">
                                    <a href="{$_data['page']['dup']}1" title="First"><i
                                                class="fa fa-angle-double-left"></i></a>
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
                                <a> {$_data['page']['dtp']} ( {$_data['page']['dp']*$_data['page']['dn']}
                                    /{$_data['page']['dt']} )</a></li>

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