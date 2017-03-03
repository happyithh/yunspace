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
    <link href="{$_assets}/css/bootstrap-datetimepicker.min.css" rel="stylesheet"/>
</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->

<body style="background:#FaFaFa !important">
<div class="portlet tabbable">
    {*<div class="portlet-title">*}
    {*<div class="caption">*}
    {*<i class="fa fa-database"></i> (当前共<a href="#"> {$_alltotal} </a>个需求)*}
    {*</div>*}
    {*</div>*}
</div>

<div class="portlet">
    <div class="portlet-body">
        <div class="tab-content clearfix">
            <ul class="nav nav-tabs">

                <li class="{if $otherData['type']=='done' || !isset($otherData['type'])}active{/if}">
                    <a href="?action=detail&type=done&broke_time={$otherData['broke_time']}&account_id={$otherData['account_id']}">已通过</a>
                </li>
                <li class="{if $otherData['type']=='waiting'}active{/if}">
                    <a href="?action=detail&type=waiting&broke_time={$otherData['broke_time']}&account_id={$otherData['account_id']}">待处理</a>
                </li>
                <li class="{if $otherData['type']=='abandon'}active{/if}">
                    <a href="?action=detail&type=abandon&broke_time={$otherData['broke_time']}&account_id={$otherData['account_id']}">已放弃</a>
                </li>
            </ul>
            <div class="table-responsive">
                <table class="table table-striped table-bordered table-advance table-hover">
                    <thead>
                    <tr>
                        <th class="list_none">爆料人</th>
                        <th class="list_none">爆料日期</th>
                        <th>活动联系方式</th>
                        <th>活动方联系方式</th>
                        <th>活动地点</th>
                        <th class="list_none">业务类型</th>
                        <th>具体要求</th>
                        <th>操作</th>
                    </tr>
                    </thead>
                    <tbody>
                    {if !empty($data)}
                        {foreach $data as $k=>$v}
                            <tr>
                                <td class="">{$v['user_info']['nickname']}</td>
                                <td class="list_none">{date('Y-m-d',$v['create_time'])}</td>
                                <td class="list_none">{$v['submit_person']}</td>
                                <td class="red">{$v['phone']}</td>
                                <td>{$v['city']}</td>
                                <td class="list_none">{$v['demand_type']}</td>
                                <td>{$v['demand']['具体要求']}</td>
                                <td>

                                    {if $v['demand_status']==0}
                                        <a href="?action=detailStatus&id={$v['id']}&type=waiting"
                                           class="btn btn-xs btn-danger">审核</a>
                                    {/if}
                                    {if $v['demand_status']==1}
                                        <a href="?action=detailStatus&id={$v['id']}&type=done"
                                           class="btn btn-xs btn-info">查看</a>
                                    {/if}
                                    {if $v['demand_status']< 0}
                                        <a href="?action=detailStatus&id={$v['id']}&type=abandon"
                                           class="btn btn-xs btn-default"
                                           style="background-color: rgba(238, 238, 238,0.8);">已放弃</a>
                                    {/if}
                                </td>

                            </tr>
                        {/foreach}
                    {else}
                        <tr>
                            <td colspan="8"
                                style="text-align: center;font-size: 16px;">
                                {if !isset($otherData['type']) || $otherData['type']=='done'}
                                    暂无已通过爆料信息
                                    {elseif $otherData['type']=='waiting'}
                                    暂无待处理爆料信息
                                {elseif $otherData['type']=='abandon'}
                                    暂无已放弃爆料信息
                                {/if}
                            </td>
                        </tr>
                    {/if}
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<script src="{$_assets}plugins/jquery-1.11.0.min.js" type="text/javascript"></script>
<script type="text/javascript" src="js/moment.min.js"></script>
<script type="text/javascript" src="js/bootstrap-datetimepicker.min.js"></script>
</body>
<!-- END BODY -->
</html>