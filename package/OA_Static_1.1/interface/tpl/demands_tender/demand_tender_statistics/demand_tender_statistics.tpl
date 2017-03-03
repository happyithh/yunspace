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
                       {* <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">负责人</label>
                            <div class="col-md-4">
                                <select class="form-control input-sm" name="search[response_account_id]">
                                    <option value=0>全部</option>
                                    {foreach $admin as $key=>$value}
                                        <option {if {$_REQUEST['search']['response_account_id']==$key}}selected {/if}
                                                value="{$key}">{$value}</option>
                                    {/foreach}
                                </select>
                            </div>
                        </div>*}

                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">城市</label>

                            <div class="col-md-4">
                                <select class="form-control input-sm" name="search[city]">
                                    <option value=0>全部</option>
                                    {foreach $_REQUEST['cities'] as $value}
                                        <option {if $value==$_REQUEST['search']['city']}selected {/if}
                                                value="{$value}">{$value}</option>
                                    {/foreach}
                                </select>
                            </div>
                        </div>
                     {*   <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">统计类型</label>

                            <div class="col-md-4">
                                <select class="form-control input-sm" name="search[statisticsType]">
                                    <option value='step'>需求跟进</option>
                                    <option {if $_REQUEST['search']['statisticsType'] == 'demand_type'}selected {/if} value='demand_type'>需求来源</option>
                                    <option {if $_REQUEST['search']['statisticsType'] == 'hours'}selected {/if} value='hours'>需求时间点</option>
                                    <option {if $_REQUEST['search']['statisticsType'] == 'citys'}selected {/if} value='citys'>需求城市</option>
                                    <option {if $_REQUEST['search']['statisticsType'] == 'admin'}selected {/if} value='admin'>负责人</option>

                                </select>
                            </div>
                        </div>*}
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
{*{if $_REQUEST['search']['statisticsType']=='demand_type'}
{include 'OA_Static::demands_tender/demand_tender_statistics/inc/demand_type_list.inc.tpl' index=1}
{elseif $_REQUEST['search']['statisticsType']=='hours'}
{include 'OA_Static::demands_tender/demand_tender_statistics/inc/demand_hours_list.inc.tpl' index=1}
{elseif $_REQUEST['search']['statisticsType']=='citys'}
    {include 'OA_Static::demands_tender/demand_tender_statistics/inc/citys_list.inc.tpl' index=1}
{elseif $_REQUEST['search']['statisticsType']=='admin'}
    {include 'OA_Static::demands_tender/demand_tender_statistics/inc/admin_list.inc.tpl' index=1}
{else}*}
{include 'OA_Static::demands_tender/demand_tender_statistics/inc/step_list.inc.tpl' index=1}
{*{/if}*}


<script type="text/javascript" src="js/moment.min.js"></script>
<script type="text/javascript" src="js/bootstrap-datetimepicker.min.js"></script>
<script type="text/javascript" src="js/zh-cn.js"></script>
<script type="text/javascript" src="js/date.js"></script>
<script type="text/javascript">
    $(document).ready(function () {
        $('.date').datetimepicker({
            format: 'YYYY-MM-DD',
            locale: 'zh-cn'
        });

    });

</script>

</body>
<!-- END BODY -->
</html>