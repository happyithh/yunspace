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
    <link href="css/bootstrap-datetimepicker.min.css" rel="stylesheet"/>
    

</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->

<body style="background:#FaFaFa !important">

<div class="portlet tabbable">
    <div class="portlet-title">
        <div class="caption">
            <i class="fa fa-search"></i>搜索条件
        </div>
    </div>
    <div class="portlet-body">
        <div class="portlet-tabs">
            <div class="clearfix"></div>
            <div>
                {*{var_dump($_REQUEST)}*}
                <form action="?" method="get" class="clearfix">
                    <input type="hidden" name="type" value="{$type}">
                    <div class="form-body clearfix">
                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">城市</label>

                            <div class="col-md-4">
                                <select class="form-control input-sm" name="search[notice_city]">
                                    <option value=0>全部</option>
                                    {foreach $_REQUEST['cities'] as $value}
                                        <option {if $value==$_REQUEST['search']['notice_city']}selected {/if}
                                                value="{$value}">{$value}</option>
                                    {/foreach}
                                </select>
                            </div>
                        </div>
                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">创建时间</label>

                            <div class="col-md-4">
                                <input type='text' class="form-control date" placeholder="请选择开始时间"
                                       name="search[start_time]" value="{if !empty($_REQUEST['search']['start_time'])}{$_REQUEST['search']['start_time']}{/if}"/>
                            </div>
                            <div class="col-md-4">
                                <input type='text' class="form-control date" placeholder="请选择结束时间"
                                       name="search[end_time]" value="{if !empty($_REQUEST['search']['end_time'])}{$_REQUEST['search']['end_time']}{/if}"/>
                            </div>

                        </div>
                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">订单类型</label>

                            <div class="col-md-4">
                                <select class="form-control input-sm" name="search[demand_type]">
                                    <option value=''>全部</option>
                                    <option {if $_REQUEST['search']['demand_type'] == '线上'}selected {/if} value='线上'>线上</option>
                                    <option {if $_REQUEST['search']['demand_type'] == '线下'}selected {/if} value='线下'>线下</option>

                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="form-actions">
                        <div class="" style="text-align: center">
                            <button type="submit" class="btn btn-primary" style="width: 150px">
                                <i class="fa fa-search"></i>
                                搜索
                            </button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<div class="portlet">
    <div class="portlet-body">
        <div class="portlet-body">
            <div class="tab-content clearfix">
                <div class="table-responsive">
                    <table class="table table-striped table-bordered ">
                        <thead>
                        <tr class="mHidden">
                            <th>创建时间</th>
                            {foreach $grab_order_step as $k=>$v}
                                <th>{$v}</th>
                            {/foreach}
                            <th>总计</th>
                        </tr>
                        </thead>
                        <tbody>
                        {foreach $data as $k=>$v}
                            <tr class="mHidden">
                                <td>{$k}</td>
                                {foreach $v as $kk=>$vv}
                                    <td>{$vv}</td>
                                {/foreach}
                                <td>{array_sum($v)}</td>
                            </tr>
                        {/foreach}
                        {*<tr>*}

                        {*</tr>*}
                        </tbody>
                    </table>
                </div>

            </div>
        </div>
    </div>

    <script src="{$_assets}plugins/jquery-1.11.0.min.js" type="text/javascript"></script>
    <script src="{$_assets}plugins/bootstrap/js/bootstrap.min.js"
            type="text/javascript"></script>
    {*<script src="js/demands/demands_change_select.js" type="text/javascript"></script>*}
    <script type="text/javascript" src="js/moment.min.js"></script>
    <script type="text/javascript" src="js/zh-cn.js"></script>
    <script type="text/javascript" src="js/bootstrap-datetimepicker.min.js"></script>
<script type="text/javascript">
    $(document).ready(function () {
        $('.date').datetimepicker({
            format: 'YYYY-MM',
            locale: 'zh-cn'
        });

    });

</script>

</body>
<!-- END BODY -->
</html>