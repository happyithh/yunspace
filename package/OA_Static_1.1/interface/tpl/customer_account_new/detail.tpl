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
    <div class="caption">供应商信息管理 #</div>
</div>
<div class="portlet-body" style="padding:10px 10px">
<blockquote class="hero">
    <div class="form-body">
        <div class="row">
            <div class="col-md-6">
                <div class="col-md-12">
                    <div class="form-group">
                        <label class="control-label col-md-4">供应商ID</label>

                        <div class="col-md-8">
                            <p style="font-size: 14px;" id="online_id">
                                {$vendorInfo['id']}
                            </p>
                        </div>
                    </div>
                </div>
                <div class="col-md-12">
                    <div class="form-group">
                        <label class="control-label col-md-4">供应商名称</label>

                        <div class="col-md-8">
                            <p style="font-size: 14px;">
                                {$vendorInfo['vendor_name']}
                            </p>
                        </div>
                    </div>
                </div>
                <div class="col-md-12">
                    <div class="form-group">
                        <label class="control-label col-md-4">服务类型</label>

                        <div class="col-md-8">
                            <p style="font-size: 14px;">
                                {$vendorInfo['category_name']}
                            </p>
                        </div>
                    </div>
                </div>
                <div class="col-md-12">
                    <div class="form-group">
                        <label class="control-label col-md-4">供应商状态</label>

                        <div class="col-md-8">
                            <p style="font-size: 14px;" id="online_message">
                                {if $vendorInfo['status']==0}已下线
                                {elseif $vendorInfo['status']==1}已上线
                                {elseif $vendorInfo['status']==2}审核中
                                {elseif $vendorInfo['status']==3}审核拒绝
                                {elseif $vendorInfo['status']==4}上线（存在待审核商品）
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
                                {if $vendorInfo['vendor_remarks']['签约状态']==0}
                                    未签约
                                {elseif $vendorInfo['vendor_remarks']['签约状态']==1}
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
                        <label class="control-label col-md-4">更新时间</label>

                        <div class="col-md-8">
                            <p style="font-size: 14px;">
                                {date('Y-m-d H:i:s',$vendorInfo['update_time'])}
                            </p>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                {if $vendorInfo['status'] ==1}
                    <div class="col-md-12 text_right">
                        <button data-status={$vendorInfo['status']} type="button" class="btn btn-danger"
                                onclick="StatusOperator.online(this)">供应商下线
                        </button>
                    </div>
                {elseif $vendorInfo['status'] ==0}
                    <div class="col-md-12 text_right">
                        <button data-status={$vendorInfo['status']} type="button" class="btn btn-success"
                                onclick="StatusOperator.online(this)">供应商上线
                        </button>
                    </div>
                {/if}
            </div>
        </div>
    </div>
</blockquote>
<div class="portlet-tabs">
    <div class="tabbable">
        <ul class="nav nav-tabs">
            <li {if $tab=='vendor'}class="active"{/if}>
                <a href="?action=detail&tab=vendor&vendor_id={$vendorInfo['id']}">供应商信息</a>
            </li>
            <li class="{if $tab=='info'}active{/if}">
                <a href="?action=detail&tab=info&vendor_id={$vendorInfo['id']}">联系人信息</a>
            </li>
            <li class="{if $tab=='product'}active{/if}">
                <a href="?action=detail&tab=product&vendor_id={$vendorInfo['id']}">产品服务</a>
            </li>
            <li class="{if $tab=='set'}active{/if}">
                <a href="?action=detail&tab=set&vendor_id={$vendorInfo['id']}">套餐产品</a>
            </li>
        </ul>
        <div class="tab-content clearfix">
            {if $tab=='vendor'}
                {include 'OA_Static::customer_account_new/inc/tab_vendor.tpl'}
            {/if}
            {if $tab=='info'}
                {if $_REQUEST['identity_type']==2}
                    {include 'customer_account_new/inc/tab_info_identity_company.tpl'}
                {elseif $_REQUEST['identity_type']==1}
                    {include 'customer_account_new/inc/tab_info_identity_personal.tpl'}
                {else}
                    {include 'customer_account_new/inc/tab_info.tpl'}
                {/if}
            {/if}

            {if $tab=='product'}
                {if $_REQUEST['product_id'] && empty($_REQUEST['handle_type'])}
                    {include 'customer_account_new/inc/tab_edit_product.tpl'}
                {*{elseif $_REQUEST['product_id'] && $_REQUEST['handle_type']=='case'}*}
                    {*{include 'customer_account_new/inc/tab_add_case.tpl'}*}
                {elseif $_REQUEST['product_id'] && $_REQUEST['handle_type']=='deliver'}
                    {include 'customer_account_new/inc/raiders_edit.tpl'}
                {elseif $_REQUEST['product_id'] && $_REQUEST['handle_type']=='remark'}
                    {include 'customer_account_new/inc/tab_product_remark.tpl'}
                {*{elseif $_REQUEST['product_id'] && $_REQUEST['handle_type']=='caseshow'}*}
                    {*{include 'customer_account_new/inc/tab_product_case.tpl'}*}
                {elseif $_REQUEST['handle_type']=='add_product'}
                    {include 'customer_account_new/inc/tab_add_product.tpl'}
                {else}
                    {include 'customer_account_new/inc/tab_product.tpl'}
                {/if}
            {/if}
            {if $tab=='set'}
                {if $_REQUEST['handle_type']=='set_add'}
                    {include 'customer_account_new/inc/tab_edit_product_set.tpl'}
                {*{elseif $_REQUEST['set_id'] && $_REQUEST['handle_type']=='caseshow'}*}
                    {*{include 'customer_account_new/inc/tab_set_case.tpl'}*}
                {*{elseif $_REQUEST['set_id'] && $_REQUEST['handle_type']=='case'}*}
                    {*{include 'customer_account_new/inc/tab_add_case.tpl'}*}
                {elseif $_REQUEST['set_id'] && $_REQUEST['handle_type']=='deliver'}
                    {include 'customer_account_new/inc/raiders_edit.tpl'}
                {else}
                    {include 'customer_account_new/inc/tab_product_set.tpl'}
                {/if}
            {/if}
        </div>
    </div>
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
            $.post('http://{Core::$urls['host']}/static/api/vendor/handle.jsonp', {
                vendor_id: vendor_id,
                status: online_status,
                action: 'change_status'
            }, function (data) {
                console.log(data);
                if (data.status==0) {
                    top.alert(data.msg);
                } else {
                    $(obj).text(btn_message);
                    $(obj).removeClass().addClass(online_class);
                    $('#online_message').text(online_message);
                    $(obj).attr('data-status', online_status);
                }
            },"json")
        }
    }

</script>
</body>
<!-- END BODY -->
</html>