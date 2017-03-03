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
    <link href="css/bootstrap-datetimepicker.min.css" rel="stylesheet"/>
</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->

<body style="background:#FaFaFa !important">
<div class="portlet ">
    <div class="portlet-title" style="padding: 6px;">
        <div class="caption">
            <i class="fa fa-comments"></i>
            表单列表
        </div>
    </div>
    <div style="width: 50%;height: 100%; padding: 10px 0 ;float: left;" class="col-md-5">
        <form action="?">
            <div class="input-group col-md-5 ">
                <input type="hidden" name="search[type]" value="{if empty($type)}done{else}{$type}{/if}">
                <input type='text' class="form-control date" name="search[broke_time]"
                       value="{if empty($_REQUEST['search']['broke_time'])} {date('Y-m-d',time())}{else} {$_REQUEST['search']['broke_time']}{/if}"/>
        <span class="input-group-btn">
        <button class="btn btn-info" type="submit">
            <i class="fa fa-search">搜索</i>
        </button>
        </span>
            </div>
        </form>
    </div>
    <div class="portlet-body">

        <div class="table-responsive clearfix">
            <table class="table table-striped table-bordered table-hover" id="data_table"
                   style="word-break: break-all;float: left ">
                <thead>
                <ul class="nav nav-tabs">

                    <li class="{if $type=='done' || !isset($type)}active{/if}">
                        <a href="?search[type]=done&search[broke_time]={if empty($_REQUEST['search']['broke_time'])} {date('Y-m-d',time())}{else} {$_REQUEST['search']['broke_time']}{/if}">已通过</a>
                    </li>
                    <li class="{if $type=='other'}active{/if}">
                        <a href="?search[type]=other&search[broke_time]={if empty($_REQUEST['search']['broke_time'])} {date('Y-m-d',time())}{else} {$_REQUEST['search']['broke_time']}{/if}">其他</a>
                    </li>
                </ul>
                <tr>
                    <th>爆料人</th>
                    <th>联系方式</th>
                    <th>已通过爆料数</th>
                    <th>奖励金额</th>
                    <th>操作</th>
                </tr>
                </thead>
                {if !empty($data)}
                    {foreach $data as $k=>$v}
                        <tr>
                            <td>{$v['user_info']['nickname']}</td>
                            <td>{$v['submit_person']}</td>

                            <td>{if $type!='other'}{$v['sumBroke']}{else}0{/if} 条</td>
                            <td>{if $type!='other'}{$v['reward']}{else}0{/if} 元</td>
                            <td>
                                <a href="?action=detail&account_id={$v['submit_person_account_id']}&broke_time={if !empty($_REQUEST['search']['broke_time'])}{$_REQUEST['search']['broke_time']}{else}{date('Y-m',time())}{/if}">查看详情</a>
                            </td>
                        </tr>
                    {/foreach}
                {else}
                    <tr>
                        <td colspan="8" style="text-align: center;font-size: 16px;">{$_REQUEST['search']['broke_time']}
                            {if isset($type) && $type=='other'}
                                暂无爆料信息
                            {else}
                                暂无爆料奖励信息
                            {/if}
                        </td>
                    </tr>
                {/if}
                </thead>
                <tbody>

            </table>
            <div class="pull-left" style="width:30%; padding: 10px 0;">
                <a href="?action=export&search[broke_time]={if empty($_REQUEST['search']['broke_time'])} {date('Y-m',time())}{else} {$_REQUEST['search']['broke_time']}{/if}&search[type]={if empty($type)}done{else}{$type}{/if}"
                   class="btn btn-success">数据导出</a>
            </div>

        </div>
    </div>
</div>
</div>

<script src="{$_assets}plugins/jquery-1.11.0.min.js"
        type="text/javascript"></script>
<script src="{$_assets}scripts/_page.js"></script>
<script type="text/javascript" src="js/moment.min.js"></script>
<script type="text/javascript" src="js/zh-cn.js"></script>
<script type="text/javascript" src="js/bootstrap-datetimepicker.min.js"></script>
<script>
    $(document).ready(function () {
        $('.date').datetimepicker({
            format: 'YYYY-MM',
            locale: 'zh-cn'
        });
    })
</script>
</body>
<!-- END BODY -->
</html>