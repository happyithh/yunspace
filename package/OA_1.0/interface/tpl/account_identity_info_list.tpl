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
                    <a href="?{if !empty($_REQUEST['search']['title'])}action=listReject{$urls}{else}action=listReject{/if}">已拒绝</a>
                </li>
                <li class="{if $page_nav=='notYet'}active{/if}">
                    <a href="?{if !empty($_REQUEST['search']['title'])}action=listUnaccepted{$urls}{else}action=listUnaccepted{/if}">待审核</a>
                </li>
                <li class="{if $page_nav=='yet'}active{/if}">
                    <a href="?{if !empty($_REQUEST['search']['title'])}action=listAccepted{$urls}{else}action=listAccepted{/if}">已审核</a>
                </li>
                <li class="{if $page_nav=='all'}active{/if}">
                    <a href="?{if !empty($_REQUEST['search']['title'])}action=listAll{$urls}{else}action=listAll{/if}">全部</a>
                </li>
            </ul>

            <div class="clearfix"></div>
            <div class="tab-content">
                <div class="tab-pane active">
                    <div class="pull-left" style="width:50%; padding: 10px 0;">
                        <div style="width: 300px;float: left;">
                            <label style="width: 100px;float: left;margin-top: 5px;margin-left: 5px;">认证状态：</label>
                            <select style="width:150px;float: left;" class="form-control input-sm"
                                    name="search[identity_type]">
                                <option value=""
                                        {if $_REQUEST['search']['identity_type']==""}selected="selected" {/if}>全部
                                </option>
                                <option value="1"
                                        {if $_REQUEST['search']['identity_type']==1}selected="selected" {/if}>个人认证
                                </option>
                                <option value="2"
                                        {if $_REQUEST['search']['identity_type']==2}selected="selected" {/if}>企业认证
                                </option>
                            </select>
                        </div>
                        <form action="?">
                            <div class="input-group">
                                {foreach $_REQUEST as $k=>$v}
                                    {if $k!=='search'&& $k!=='cities'}
                                        <input type="hidden" name="{$k}" value="{$v}">
                                    {/if}
                                {/foreach}
                                <input type="text" class="form-control" placeholder="用户名/手机号/邮箱/全名" name="search[title]"
                                       value="{$_REQUEST['search']['title']}">
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
                            {*<th class="table-checkbox"*}
                            {*style="width:16px">*}
                            {*<input type="checkbox"*}
                            {*class="group-checkable"*}
                            {*data-set="#data_table .checkboxes"/>*}
                            {*</th>*}

                            {*{foreach $table_head as $k => $v}*}
                            {*<td>*}
                            {*{$v}*}
                            {*</td>*}
                            {*{/foreach}*}
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

                        {foreach $_data['rows'] as $k => $v}
                            <tr>
                                <td>{$v['username']}</td>
                                <td>{$v['phone']}</td>
                                <td>{$v['email']}</td>
                                <td>{$v['fullname']}</td>
                                {if $page_nav=='rejected'}
                                    <td>{$v['rejectReason']}</td>
                                {/if}

                                {$attr = json_decode($v['attr'], true)}
                                {if isset($attr['new_identity']['identity_type'])}
                                    {if $attr['new_identity']['identity_type'] == 1}
                                        <td>个人认证</td>
                                    {elseif $attr['new_identity']['identity_type'] == 2}
                                        <td>企业认证</td>
                                    {/if}
                                {elseif isset($attr['identity']['identity_type'])}
                                    {if $attr['identity']['identity_type'] == 1}
                                        <td>个人认证</td>
                                    {elseif $attr['identity']['identity_type'] == 2}
                                        <td>企业认证</td>
                                    {/if}
                                {else}
                                    <td></td>
                                {/if}

                                {if $page_nav=='notYet'}
                                    <td>
                                        <a href="?action=info&id={$v['id']}" class="btn btn-danger btn-xs"><i
                                                    class="fa fa-pencil"></i> 审核</a>
                                    </td>
                                {elseif $page_nav == 'all' || $page_nav == 'yet' || $page_nav == 'rejected'}
                                    <td><a href="?action=info_show&id={$v['id']}" class="btn btn-success btn-xs"><i class="fa fa-pencil"></i>查看</a></td>
                                {else}
                                    <td></td>
                                {/if}

                            </tr>
                        {/foreach}
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