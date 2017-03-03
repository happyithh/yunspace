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
    <style>
        .readdata p {
            padding: 0
        }
        .text_right {
            margin-bottom: 30px;
            text-align: right;
        }
    </style>

    <!-- BEGIN JAVASCRIPTS(Load javascripts at bottom, this will reduce page load time) -->
    <!-- BEGIN CORE PLUGINS -->
    <script src="{$_assets}plugins/jquery-1.11.0.min.js"
            tab="text/javascript"></script>
    <script src="{$_assets}plugins/jquery-migrate-1.2.1.min.js"
            tab="text/javascript"></script>
    <!-- IMPORTANT! Load jquery-ui-1.10.3.custom.min.js before bootstrap.min.js to fix bootstrap tooltip conflict with jquery ui tooltip -->
    <script src="{$_assets}plugins/jquery-ui/jquery-ui-1.10.3.custom.min.js"
            tab="text/javascript"></script>
    <script src="{$_assets}plugins/bootstrap/js/bootstrap.min.js"
            tab="text/javascript"></script>
    <script src="{$_assets}plugins/bootstrap-hover-dropdown/bootstrap-hover-dropdown.min.js"
            tab="text/javascript"></script>
    <script src="{$_assets}plugins/jquery-slimscroll/jquery.slimscroll.min.js"
            tab="text/javascript"></script>
    <script src="{$_assets}plugins/jquery.blockui.min.js"
            tab="text/javascript"></script>
    <script src="{$_assets}plugins/uniform/jquery.uniform.min.js"
            tab="text/javascript"></script>
    <!-- END CORE PLUGINS -->
    <!-- BEGIN PAGE LEVEL PLUGINS -->
    <script tab="text/javascript"
            src="{$_assets}plugins/select2/select2.min.js"></script>
    <script tab="text/javascript"
            src="{$_assets}plugins/datatables/media/js/jquery.dataTables.min.js"></script>
    <script tab="text/javascript"
            src="{$_assets}plugins/datatables/plugins/bootstrap/dataTables.bootstrap.js"></script>
    <!-- END PAGE LEVEL PLUGINS -->
    <!-- BEGIN PAGE LEVEL SCRIPTS -->
    <script src="{$_assets}scripts/_page.js"></script>
</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->

<body style="background:#FaFaFa !important">
<div class="portlet tabbable">
<div class="portlet-title">
    <div class="caption">
        {if $_REQUEST['type']==21}供应商{else}客户{/if}
        信息管理 #{$accountInfo['id']}
    </div>
</div>
<div class="portlet-body" style="padding:10px 10px">
<blockquote class="hero">
    <h2>{$accountInfo['username']}
        {if $accountInfo['fullname'] && $accountInfo['username'] != $accountInfo['fullname'] }
            (
            <span style="color: #999">{$accountInfo['fullname']} </span>
            )
        {/if}
    </h2>
    {if  $accountInfo['register_time']>=1432197750 &&  $accountInfo['register_time'] <= 1432198050}
        <h5>
            <span>初始密码：{$accountInfo['phone']} </span>
        </h5>
    {/if}
    {if $_REQUEST['type']==21}
        <span style="float:right;">
                {if !$accountInfo['vendors']}
                    <a class="btn btn-success" href="?action=detail&tab=vendor&id={$accountInfo['id']}">添加供应商</a>
                {/if}
            </span>
    {/if}
    {if $accountInfo['vendors']}
        <div class="form-body">
            <div class="row">
                <div class="col-md-6">
                    <div class="col-md-12">
                        <div class="form-group">
                            <label class="control-label col-md-4">供应商ID</label>

                            <div class="col-md-8">
                                <p style="font-size: 14px;" id="online_id">
                                    {$accountInfo['vendors'][0]['id']}
                                </p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-12">
                        <div class="form-group">
                            <label class="control-label col-md-4">供应商名称</label>

                            <div class="col-md-8">
                                <p style="font-size: 14px;">
                                    {$accountInfo['vendors'][0]['vendor_name']}
                                </p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-12">
                        <div class="form-group">
                            <label class="control-label col-md-4">服务类型</label>

                            <div class="col-md-8">
                                <p style="font-size: 14px;">
                                    {$accountInfo['vendors'][0]['category_name']}
                                </p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-12">
                        <div class="form-group">
                            <label class="control-label col-md-4">供应商状态</label>

                            <div class="col-md-8">
                                <p style="font-size: 14px;" id="online_message">
                                    {if $accountInfo['vendors'][0]['online_status']==0}已下线
                                    {elseif $accountInfo['vendors'][0]['online_status']==1}已上线
                                    {elseif $accountInfo['vendors'][0]['online_status']==2}审核中
                                    {elseif $accountInfo['vendors'][0]['online_status']==3}审核拒绝
                                    {elseif $accountInfo['vendors'][0]['online_status']==4}上线（存在待审核商品）
                                    {/if}
                                </p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-12">
                        <div class="form-group">
                            <label class="control-label col-md-4">签约状态</label>

                            <div class="col-md-8">
                                <p style="font-size: 14px;">
                                    {if $accountInfo['vendors'][0]['vendor_remarks']['签约状态']==0}
                                        未签约
                                    {elseif $accountInfo['vendors'][0]['vendor_remarks']['签约状态']==1}
                                        合作备忘录
                                    {else}
                                        已签约
                                    {/if}
                                </p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-12">
                        <div class="form-group">
                            <label class="control-label col-md-4">绑定银行账号</label>

                            <div class="col-md-8">
                                <p style="font-size: 14px;">
                                    {if $accountInfo['bank_account']}
                                        已绑定
                                    {else}
                                        未绑定
                                    {/if}
                                </p>
                            </div>
                        </div>
                    </div>
                    {*<div class="col-md-12">*}
                    {*<div class="form-group">*}
                    {*<label class="control-label col-md-4">负责人</label>*}
                    {*<div class="col-md-8">*}
                    {*<p style="font-size: 14px;">*}

                    {*</p>*}
                    {*</div>*}
                    {*</div>*}
                    {*</div>*}
                    <div class="col-md-12">
                        <div class="form-group">
                            <label class="control-label col-md-4">更新时间</label>

                            <div class="col-md-8">
                                <p style="font-size: 14px;">
                                    {date('Y-m-d H:i:s',$accountInfo['vendors'][0]['update_time'])}
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="col-md-12 text_right ">
                        <a class="btn  btn-info" data-toggle="modal" href="#account">更改绑定账户</a>
                    </div>
                    {*<div class="col-md-12" style="margin-bottom: 30px; text-align: right;">*}
                    {*<button type="button" class="btn btn-primary">转移负责人</button>*}
                    {*</div>*}
                    {if $accountInfo['vendors'][0]['online_status'] ==1}
                        <div class="col-md-12 text_right">
                            <button data-status={$accountInfo['vendors'][0]['online_status']} type="button" class="btn btn-danger"
                                    onclick="StatusOperator.online(this)">供应商下线
                            </button>
                        </div>
                    {else}
                        <div class="col-md-12 text_right">
                            <button data-status={$accountInfo['vendors'][0]['online_status']} type="button" class="btn btn-success"
                                    onclick="StatusOperator.online(this)">供应商上线
                            </button>
                        </div>
                    {/if}
                    <div class="col-md-12 text_right ">
                        <a class="btn  btn-success" data-toggle="modal" href="#basic">账号变更</a>
                    </div>
                </div>
            </div>
        </div>
    {/if}
</blockquote>
<div class="portlet-tabs">
    <div class="tabbable">
        <ul class="nav nav-tabs">
            <li class="{if $tab=='info'}active{/if}">
                <a href="?action=detail&tab=info&id={$_REQUEST['id']}">账户信息</a>
            </li>
            {*<li class="{if $tab=='contacts'}active{/if}">*}
                {*<a href="?action=detail&tab=contacts&id={$_REQUEST['id']}">联系人信息</a>*}
            {*</li>*}
            {if $_REQUEST['type']==21}
                {if $tab=='vendor' || $accountInfo['vendors'][0]['id']}
                    <li {if $tab=='vendor'}class="active"{/if}>
                        <a href="?action=detail&tab=vendor&id={$_REQUEST['id']}&vendor_id={$accountInfo['vendors'][0]['id']}">供应商信息</a>
                    </li>
                {/if}
                <li class="{if $tab=='product'}active{/if}">
                    <a href="?action=detail&tab=product&id={$_REQUEST['id']}">产品服务</a>
                </li>
                <li class="{if $tab=='set'}active{/if}">
                    <a href="?action=detail&tab=set&id={$_REQUEST['id']}">套餐产品</a>
                </li>
            {/if}
            <li class="{if $tab=='demand'}active{/if}">
                <a href="?action=detail&tab=demand&id={$_REQUEST['id']}">需求</a>
            </li>
            <li class="{if $tab=='order'}active{/if}">
                <a href="?action=detail&tab=order&id={$_REQUEST['id']}">订单交易</a>
            </li>
            <li class="{if $tab=='record'}active{/if}">
                <a href="?action=detail&tab=record&id={$_REQUEST['id']}">联系记录</a>
            </li>
            <li class="{if $tab=='operate_log'}active{/if}">
                <a href="?action=detail&tab=operate_log&id={$_REQUEST['id']}">操作日志</a>
            </li>
        </ul>
        <div class="tab-content clearfix">
            {if $tab=='info'}
                {if $_REQUEST['identity_type']==2}
                    {include 'customer_account/inc/tab_info_identity_company.tpl'}
                {elseif $_REQUEST['identity_type']==1}
                    {include 'customer_account/inc/tab_info_identity_personal.tpl'}
                {else}
                    {include 'customer_account/inc/tab_info.tpl'}
                {/if}
            {/if}
            {if $tab=='contacts'}
                {include 'customer_account/inc/tab_contacts.tpl'}
            {/if}
            {if $tab=='demand'}
                {if $_REQUEST['demand_id']}
                    {include 'customer_account/inc/tab_demand_recommend.tpl'}
                {else}
                    {include 'customer_account/inc/tab_demand.tpl'}
                {/if}
            {/if}
            {if $tab=='vendor'}
                {include 'customer_account/inc/tab_vendor.tpl'}
            {/if}
            {if $tab=='product'}
                {if $_REQUEST['vendor_id']}
                    {include 'customer_account/inc/tab_add_product.tpl'}
                {elseif $_REQUEST['product_id'] && empty($_REQUEST['handle_type'])}
                    {include 'customer_account/inc/tab_edit_product.tpl'}
                {elseif $_REQUEST['product_id'] && $_REQUEST['handle_type']=='case'}
                    {include 'customer_account/inc/tab_add_case.tpl'}
                {elseif $_REQUEST['product_id'] && $_REQUEST['handle_type']=='remark'}
                    {include 'customer_account/inc/tab_product_remark.tpl'}
                {elseif $_REQUEST['product_id'] && $_REQUEST['handle_type']=='caseshow'}
                    {include 'OA_Static::customer_account/tab_product_case.tpl'}
                    {else}
                    {include 'customer_account/inc/tab_product.tpl'}
                {/if}
            {/if}
           {* {if $tab=='case'}
                {include 'OA_Static:customer_account/tab_product_case.tpl'}
            {/if}*}
            {*套餐*}
            {if $tab=='set'}
                {if $_REQUEST['set_add']}

                    {include 'customer_account/inc/tab_edit_product_set.tpl'}

                {elseif $_REQUEST['set_id'] && empty($_REQUEST['handle_type'])}

                    {include 'customer_account/inc/tab_edit_product_set.tpl'}
                {elseif $_REQUEST['set_id'] && $_REQUEST['handle_type']=='caseshow'}
                    {include 'OA_Static::customer_account/tab_set_case.tpl'}
                {elseif $_REQUEST['set_id'] && $_REQUEST['handle_type']=='case'}

                    {include 'customer_account/inc/tab_add_case.tpl'}

                {else}

                    {include 'customer_account/inc/tab_product_set.tpl'}
                {/if}
            {/if}
            {if $tab=='order'}
                {include 'customer_account/inc/tab_order.tpl'}
            {/if}
            {if $tab=='record'}
                {include 'customer_account/inc/tab_record.tpl'}
            {/if}
            {if $tab=='operate_log'}
                {include 'customer_account/inc/tab_log.tpl'}
            {/if}
        </div>
    </div>
</div>
</div>
{*弹出层*}
<div class="modal fade" id="basic" tabindex="-1" role="basic" aria-hidden="true" style="display: none;">
    <div class="modal-dialog">
        <div class="modal-content">
            <form action="?" method="post">
                <input type="hidden" name="action" value="{$_REQUEST['action']}"/>
                <input type="hidden" name="tab" value="update_account_info"/>
                <div class="modal-body">
                    <table class="table" id="list_info">
                        <thead>
                        <th width="150px;">账户管理</th>
                        <th></th>
                        </thead>
                        <tr>
                            <td>
                                {*<label><input type="checkbox" name="account[username]" value="1"/>账户名称</label>*}
                                <label>账户名称</label>
                            </td>
                            <td>
                                <input type="text" class="col-md-12 form-control" name="username"
                                       value="{$accountInfo['username']}" placeholder="请输入账户名">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label>密码</label>
                            </td>
                            <td>
                                <input type="password" class="col-md-12 form-control" name="password"
                                         placeholder="不填写时，密码为原密码">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label>再次输入新密码</label>
                            </td>
                            <td>
                                <input type="password" class="col-md-12 form-control" name="passwordr"
                                       placeholder="再次输入新密码(密码不做更改时，无需填写此项)">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label>交易密码</label>
                            </td>
                            <td>
                                <input type="password" class="col-md-12 form-control" name="password2"
                                       placeholder="不填写时，交易密码为原交易密码">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label>再次输入交易密码</label>
                            </td>
                            <td>
                                <input type="password" class="col-md-12 form-control" name="password2r"
                                       placeholder="再次输入交易密码(交易密码不做更改时，无需填写此项)">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label>手机号</label>
                            </td>
                            <td>
                                <input type="text" class="col-md-12 form-control" name="phone"
                                       value="{$accountInfo['phone']}">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label>邮箱</label>
                            </td>
                            <td>
                                <input type="text" class="col-md-12 form-control" name="email"
                                       value="{$accountInfo['email']}">
                            </td>
                        </tr>

                        <input type="hidden" id="reset_account_id" name="id" value="{$accountInfo['id']}">
                    </table>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="submit" id="update_account_submit" class="btn btn-info">提交</button>
                </div>
        </div>
        </form>
    </div>
</div>

{*账户变更弹出层*}
<div class="modal fade" id="account" tabindex="-1" role="basic" aria-hidden="true" style="display: none;">
    <div class="modal-dialog">
        <div class="modal-content">
            <form action="?" method="post">
                <input type="hidden" name="action" value="{$_REQUEST['action']}"/>
                <input type="hidden" name="tab" value="change_bind_account"/>
                <input type="hidden" name="id" value="{$accountInfo['id']}">
                <input type="hidden" name="vendor_id" value="{$accountInfo['vendors'][0]['id']}">
                <div class="modal-body">
                    <table class="table" id="list_info">
                        <thead>
                        <th width="200px;">更改供应商绑定的账户</th>
                        </thead>
                        <tr>
                            <td>
                                <label>原账户</label>
                            </td>
                            <td>
                                <input type="text" class="form-control" name="username" value="{$accountInfo['username']}">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label>选择新账户</label>
                            </td>
                            <td>
                                <input type="hidden" id="select2_account" class="form-control" name="new_account_id" value="{$accountInfo['id']}">
                            </td>
                        </tr>
                    </table>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="submit" class="btn btn-info">提交</button>
                </div>
        </div>
        </form>
    </div>
</div>


<script type="text/javascript">
    StatusOperator = {
        online: function (obj) {
            var vendor_id = $('#online_id').text();
            var status = $(obj).attr('data-status');
            if (status == 0) {
                var btn_message = '供应商下线';
                var online_message = '已上线';
                var online_status = 1;
                var online_class = 'btn btn-danger';
            } else if (status == 1) {
                var btn_message = '供应商上线';
                var online_message = '已下线';
                var online_status = 0;
                var online_class = 'btn btn-success';
            } else if (status == 2) {
                alert('审核中的供应商不能操作上下线');
                return false;
            } else if (status == 3) {
                alert('审核拒绝的供应商不能操作上下线');
                return false;
            } else if (status == 4) {
                alert('存在待审核商品的供应商不能操作上下线');
                return false;
            }
            $.post('?', {
                vendor_id: vendor_id,
                vendor_online: status,
                id:{$accountInfo['id']},
                action: 'detail',
                tab: 'vendor'
            }, function (data) {
                if (data != 'success') {
                    alert('操作失败,可能是网络异常,请稍候再试!');
                } else {
                    $(obj).text(btn_message);
                    $(obj).removeClass().addClass(online_class);
                    $('#online_message').text(online_message);
                    $(obj).attr('data-status', online_status);
                }
            })
        }
    }

//    $(document).ready(function () {
        $("#select2_account").select2({
            placeholder: "选择已有账号",
            minimumInputLength: 1,
            ajax: { // instead of writing the function to execute the request we use Select2's convenient helper
                url: "?action=ajax_user_json",
                dataType: 'json',
                data: function (term, page) {
                    return {
                        q: term, // search term
                        page_limit: 10
                    };
                },
                results: function (data, page) { // parse the results into the format expected by Select2.
                    // since we are using custom formatting functions we do not need to alter remote JSON data
                    return {
                        results: data.items
                    };
                }
            },
            initSelection: function (element, callback) {
                var id = $(element).val();
                if (id !== "") {
                    $.ajax("?action=ajax_user_json", {
                        data: {
                            id: id
                        },
                        dataType: "json"
                    }).done(function (data) {
                                console.log(data);
                                callback(data.items[0]);
                            });
                }
            },
            formatResult: formatRepo, // omitted for brevity, see the source of this page
            formatSelection: formatRepoSelection, // omitted for brevity, see the source of this page
            escapeMarkup: function (m) {
                return m;
            } // we do not want to escape markup since we are displaying html in results
        });

        function formatRepo(repo) {
            if (repo.loading) return repo.text;
            return repo.full_name;
        }

        function formatRepoSelection(repo) {
            return repo.full_name || repo.text;
        }

//    })
</script>
</body>
<!-- END BODY -->
</html>