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
                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">负责人</label>

                            <div class="col-md-9">
                                <select class="form-control input-sm" name="search[phone]">
                                    <option value=0>全部</option>
                                    {foreach $admin as $key=>$value}
                                        <option {if {$_REQUEST['search']['phone']==$value['phone']}}selected {/if}
                                                value="{$value['phone']}">{$value['fullname']}</option>
                                    {/foreach}
                                    <option {if $_REQUEST['search']['phone']==9}selected {/if}
                                            value="9">报价系统
                                    </option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group col-md-5 form-creat-time">
                            <label class="col-md-3 control-label">创建时间</label>

                            <div class="col-md-4">
                                <input type='text' class="form-control date datetime-star" placeholder="请选择开始时间"
                                       name="search[start_time]" value="{$_REQUEST['search']['start_time']}"/>
                            </div>
                            <div class="col-md-4">
                                <input type='text' class="form-control date" placeholder="请选择结束时间"
                                       name="search[end_time]" value="{$_REQUEST['search']['end_time']}"/>
                            </div>
                        </div>
                        <div class="form-group col-md-5">
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
        {if $_REQUEST['search']['statisticsType']!='hours' && $_REQUEST['search']['statisticsType']!='admin'}
        <ul class="nav nav-tabs">
            <li class="{if $type=='day'}active{/if}">
                <a href="?type=day&search[phone]={$_REQUEST['search']['phone']}&search[statisticsType]={$_REQUEST['search']['statisticsType']}&search[start_time]={$_REQUEST['search']['start_time']}&search[end_time]={$_REQUEST['search']['end_time']}">日</a>
            </li>
            <li class="{if $type=='week'}active{/if}">
                <a href="?type=week&search[phone]={$_REQUEST['search']['phone']}&search[statisticsType]={$_REQUEST['search']['statisticsType']}&search[start_time]={$_REQUEST['search']['start_time']}&search[end_time]={$_REQUEST['search']['end_time']}">周</a>
            </li>
            <li class="{if $type=='month'}active{/if}">
                <a href="?type=month&search[phone]={$_REQUEST['search']['phone']}&search[statisticsType]={$_REQUEST['search']['statisticsType']}&search[start_time]={$_REQUEST['search']['start_time']}&search[end_time]={$_REQUEST['search']['end_time']}">月</a>
            </li>
        </ul>
        {/if}
{if $_REQUEST['search']['statisticsType']=='demand_type'}
{include 'OA_Static::demands/demand_statistics/inc/demand_type_list.inc.tpl' index=1}
{elseif $_REQUEST['search']['statisticsType']=='hours'}
{include 'OA_Static::demands/demand_statistics/inc/demand_hours_list.inc.tpl' index=1}
{elseif $_REQUEST['search']['statisticsType']=='citys'}
    {include 'OA_Static::demands/demand_statistics/inc/citys_list.inc.tpl' index=1}
{elseif $_REQUEST['search']['statisticsType']=='admin'}
    {include 'OA_Static::demands/demand_statistics/inc/admin_list.inc.tpl' index=1}
{else}
{include 'OA_Static::demands/demand_statistics/inc/step_list.inc.tpl' index=1}
{/if}

    </div>
</div>
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