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
</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->

<body style="background:#FaFaFa !important">
<div>
    <form action="?" method="post">
        <input type="hidden" name="order_id" value="{$_order['id']}">
        <input type="hidden" name="action"   value='update_order_commisson_submit'>
        <table style=''>
            <tbody>
            <tr>
                <td style="width: 85px;">订单金额:</td>
                <td>
                    <input name="commission" type="text" class="form-control input-small" value="￥{$_order['order_price']}" Disabled>
                </td>
            </tr>

            <tr>
            <td >佣金金额:</td>
            <td>
                <input name="order_commission" type="text" placeholder="请输入佣金金额" class="form-control input-small" value="{$_order['order_commission']}">
            </td>
            </tr>
            </tbody>
        </table>
        <div style="text-align: center; margin-top: 15px;margin-bottom: 30px;">
            {if !$_order['create_time5'] && $_order['status']!=10}
            <button type="submit" class="btn btn-primary" style="width: 150px" onclick="confirm('您确定填写无误？')">提交佣金设置</button>
            {/if}
        </div>
    </form>
</div>
<div class="portlet">
    <div class="portlet-title">
        <div class="caption">
            <i class="fa fa-database"></i>订单佣金详情
        </div>
    </div>
    <div class="portlet-body">
        <div class="container-fluid realidentity">
            <div class="row realidentity">
                <div class="col-md-6">
                    <div class="row">
                        <div class="col-md-2">创建时间</div>
                        <div class="col-md-10">{Date('Y-m-d H:i:s',$_order['create_time'])}</div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="row">
                         <div class="col-md-2">订单状态</div>
                        <div class="col-md-10">{$_order['order_status']}</div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="row">
                        <div class="col-md-2">负责人</div>
                        <div class="col-md-10"></div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="row">
                        <div class="col-md-2">服务名称</div>
                        <div class="col-md-10">{$_order['product_name']}</div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="row">
                        <div class="col-md-2">用户名称</div>
                        <div class="col-md-10">{$_order['username']}</div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="row">
                        <div class="col-md-2">供应商名称</div>
                        <div class="col-md-10">{$_order['vendor_name']}</div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="row">
                        <div class="col-md-2">订单号</div>
                        <div class="col-md-10">{$_order['order_no']}</div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="row">
                        <div class="col-md-2"></div>
                        <div class="col-md-10"></div>
                    </div>
                </div>
            </div>
        </div>
        <ul class="nav nav-tabs">
            <li class="{if $type=='info'}active{/if}">
                <a href="?action=commission_order_detail&type=info&order_no={$_order['order_no']}">预定信息</a>
            </li> {if $_order['create_time3']}
                <li class="{if $type=='contract'}active{/if}">
                <a href="?action=commission_order_detail&type=contract&order_no={$_order['order_no']}">合同详情</a>
                </li>
             {else}<li class="disabled">
                <a href="#">合同详情</a>
                </li>{/if}
            {if $_order['create_time4']}
            <li class="{if $type=='pay'}active{/if}">
                <a href="?action=commission_order_detail&type=pay&order_no={$_order['order_no']}">支付详情</a>
            </li>{else}  <li class="disabled">
                    <a href="#">支付详细</a>
                </li>{/if}
        </ul>
        <div class="tab-content clearfix">
            {if $type=='info' || !$_REQUEST['type']}
                {include 'order/inc/tab_order_detail_reserve.tpl'}
            {/if}
            {if $type=='contract'}
                {include 'order/inc/tab_order_detail_contract.tpl'}
            {/if}
            {if $type=='pay'}
                {include 'order/inc/tab_order_detai_pay.tpl'}
            {/if}
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