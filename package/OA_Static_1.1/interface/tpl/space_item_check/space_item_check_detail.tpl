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
    <link href="style/media.css" rel="stylesheet"/>
    <link href="style/css.css" rel="stylesheet"/>
    <link href="css/bootstrap-datetimepicker.min.css" rel="stylesheet"/>
    <script src="{$_assets}plugins/jquery-1.11.0.min.js"
            type="text/javascript"></script>
    <script type="text/javascript" src="{$_assets}plugins/select2/select2.min.js"></script>

</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->

<body style="background:#FaFaFa !important">

<div class="portlet tabbable">
    <div class="portlet-title">
        <div class="caption">
            <i class="fa fa-database"></i>待审核子空间信息
        </div>
    </div>
    <div class="portlet-body form-horizontal">
        <div class="portlet-tabs">
            <div class="tabbable">
                <div class="tab-content clearfix">
                    <table class="table table-striped table-bordered table-hover" id="data_table"
                           style="word-break: break-all">
                        <tbody >
                        <tr>
                            <th style="width:7%">子空间ID</th>
                            <td>#{$_data['id']}</td>
                        </tr>
                        <tr>
                            <th>子空间名称</th>
                            <td>{$_data['item_name']}</td>
                        </tr>
                        <tr>
                            <th>所属百科</th>
                            <td>{$_data['space_name']}</td>
                        </tr>
                        <tr>
                            <th>城市</th>
                            <td>{$_data['city']}</td>
                        </tr>
                        <tr>
                            <th>面积</th>
                            <td>{$_data['size']}</td>
                        </tr>
                        <tr>
                            <th>价格区间</th>
                            <td>{$_data['min_price']}/{$_data['price_unit']}~{$_data['max_price']}/{$_data['price_unit']}</td>
                        </tr>
                        <tr>
                            <th>人数区间</th>
                            <td>{$_data['min_people']}人~{$_data['max_people']}人</td>
                        </tr>
                        <tr>
                            <th>标签</th>
                            <td>{implode(",",$_data['tags'])}</td>
                        </tr>
                        <tr>
                            <th>联系人</th>
                            <td>{$_data['contacts']}</td>
                        </tr>
                        <tr>
                            <th>联系方式</th>
                            <td>{$_data['phone']}</td>
                        </tr>
                        <tr>
                            <th>邮箱</th>
                            <td>{$_data['email']}</td>
                        </tr>
                        <tr>
                            <th>logo</th>
                            <td><img width="100" height="100" src="{$_data['logo']}"></td>
                        </tr>
                        </tbody>
                    </table>
                    <div class="form-body" style="min-height: 350px;">
                        <form class="form-horizontal" role="form" action="?" method="post">
                            <input type="hidden" name="action" value="refuse">
                            <input type="hidden" name="item_id" value="{$_REQUEST['item_id']}">
                            <div class="form-group">
                                <label class="col-md-3 control-label"><strong>请输入拒绝理由:</strong></label>
                                <div class="col-md-9">
                                    <input type="text" placeholder="请输入拒绝原因" class="form-control" value="" name="reason"  id="refuseReason">
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="form-actions text-center">
                                    <a href="?action=pass&item_id={$_REQUEST['item_id']}&status=1" class="btn btn-success">通过并上线</a>
                                    <a href="?action=pass&item_id={$_REQUEST['item_id']}" class="btn btn-primary">通过</a>
                                    <button type="submit" class="btn btn-danger">拒绝</button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
<!-- END BODY -->
</html>