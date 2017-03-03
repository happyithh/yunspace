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
<div class="portlet">
    <div class="portlet-title">
        <div class="caption">
            <i class="fa fa-database"></i>需求报价详情
        </div>
    </div>
    <div class="portlet-body">

        <div class="container-fluid">
            <div class="row">
                <table class="table table-hover" style="border:0px;">

                    <tbody>
                    <tr>
                        <td>创建时间：</td>
                        <td>{Date('Y-m-d H:i:s',$demand['create_time'])}</td>
                    </tr>
                    <tr>
                        <td>需求ID：</td>
                        <td>{$demand['demand_id']}</td>
                    </tr>
                    <tr>
                        <td>需求名称：</td>
                        <td>{$demand['demand_name']}</td>
                    </tr>
                    <tr>
                        <td>联系电话：</td>
                        <td>{$demand['phone']}</td>
                    </tr>
                    <tr>
                        <td>客户打开超过3次：</td>
                        <td>{intval($data[$demand['demand_id']]['order_all_num'])}</td>
                    </tr>
                    <tr>
                        <td>客户打开总次数：</td>
                        <td>{intval($data[$demand['demand_id']]['c_all_num'])}</td>
                    </tr>
                    <tr>
                        <td>客户未打开数：</td>
                        <td>{intval($data[$demand['demand_id']]['c_order_num'])}</td>
                    </tr>
                    <tr>
                        <td>商家打开总次数：</td>
                        <td>{intval($data[$demand['demand_id']]['v_all_num'])}</td>
                    </tr>
                    <tr>
                        <td>通知总次数：</td>
                        <td>{intval($data[$demand['demand_id']]['notice_num'])}</td>
                    </tr>
                    <tr>
                        <td>交换电话数：</td>
                        <td>{intval($data[$demand['demand_id']]['change_num'])}</td>
                    </tr>
                    <tr>
                        <td>交换电话总数：</td>
                        <td>{intval($data[$demand['demand_id']]['change_all_num'])}</td>
                    </tr>
                    <tr>
                        <td>无商家响应数：</td>
                        <td>{intval($data[$demand['demand_id']]['merchant_num'])}</td>
                    </tr>
                    <tr>
                        <td>报价总数：</td>
                        <td>{intval($data[$demand['demand_id']]['offer_num'])}</td>
                    </tr>
                    <tr>
                        <td>状态：</td>
                        <td>{$status[$demand['status']]}</td>
                    </tr>
                    <tr>
                        <td>客户打开超过3次：</td>
                        <td>{intval($data[$demand['demand_id']]['order_all_num'])}</td>
                    </tr>
                    </tbody>

                </table>
            </div>
        </div>

    </div>

</body>
<!-- END BODY -->
</html>