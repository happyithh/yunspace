<!DOCTYPE html>
<!--[if IE 8]>
<html lang="en" class="ie8 no-js"> <![endif]-->
<!--[if IE 9]>
<html lang="en" class="ie9 no-js"> <![endif]-->
<!--[if !IE]><!-->
<html lang="en" class="no-js" xmlns="http://www.w3.org/1999/html" xmlns="http://www.w3.org/1999/html">
<!--<![endif]-->
<!-- BEGIN HEAD -->
<head>
    <title>{$title}</title>
    <meta content="" name="description"/>
    {include "Admin::inc/html_head.tpl"}
    <link href="style/css.css" rel="stylesheet"/>
    <script src="js/jquery-1.9.1.min.js"></script>
</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->
<style>
    .title {

        margin: 10px 0px 10px 10px;

        float: left;
    }
</style>
<body style="background:#FaFaFa !important">
<div class="portlet">
    <div class="portlet-title" style="height: 50px;">
        <div class="caption " style="height: 40px;line-height: 35px;">
            <i class="fa fa-reorder"></i>活动售票订单管理列表
        </div>
        {*<div class="btn-group pull-right">*}
            {*<a href="?action=add" class="btn btn-success">添加新活动售票</a>*}
        {*</div>*}
    </div>
    <div class="portlet-body" style="height: auto;">
        <div class="table-responsive" style="border: 0px;">
            <table class="table table-striped table-bordered table-advance table-hover">
                <thead>
                <tr>
                    <th>活动名称</th>
                    <!--<th style="width: 30%;">活动详情</th>
                    <th>创建者</th>-->
                    <th> 检票手机号</th>
                    <th style="width: 6%;">活动开始时间</th>
                    <th style="width: 8%;">创建时间</th>
                    <th style="width: 7%;">活动有效期</th>
                    <th>活动地址</th>
                    <!--<th>门票详情</th>-->
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                {foreach $_data['rows'] as $v}
                    <tr>
                        <td>
                            {$v['title']}
                        </td>
                        <!--<td>
                            {if !empty($v['content'])}
                                {$v['content']}
                            {else}
                                ----
                            {/if}
                        </td>-->
                        <td>
                            {if !empty($v['checkticketphone'])}
                              {$v['checkticketphone']}
                            {else}
                                ----
                            {/if}
                        </td>
                        <td >
                            {if !empty($v['activity_time'])}
                                {date('Y-m-d',$v['activity_time'])}
                            {else}
                             ------
                            {/if}
                        </td>
                        <td >{date('Y-m-d H:i',$v['create_time'])}</td>
                        <td>
                            {if $newTime > $v['end_time']}
                            <span class="btn btn-warning btn-xs">活动已过期，建议下线</span>
                            {else}
                            {if !empty($v['start_time'])}{date('Y-m-d',$v['start_time'])}{/if}
                            {if !empty($v['start_time'])&&!empty($v['end_time'])}
                                --
                            {/if}
                            {if !empty($v['end_time'])}{date('Y-m-d',$v['end_time'])}{/if}
                            {if empty($v['start_time']) && empty($v['end_time'])}暂未设置{/if}
                            {/if}
                        </td>
                        <td>
                            {if !empty($v['addr'])}
                                {$v['addr']}
                            {else}
                                ----
                            {/if}
                        </td>
                        <!--<td><a href="?action=edit&id={$v['id']}">点击查看门票详情</a></td>-->
                        <td>
                            <a href="?action=order_list&event_id={$v['id']}">点击查看订单详情</a>
                        </td>
                    </tr>
                {/foreach}
                </tbody>
            </table>
        </div>
        <div>
                <ul class="pagination">
                    {if $_data['page']['dpll']}
                        <li class="prev">
                            <a href="{$_data['page']['dup']}1" title="First"><i class="fa fa-angle-double-left"></i></a>
                        </li>
                        <li class="prev">
                            <a href="{$_data['page']['dup']}{$_data['page']['dp']-1}" title="Prev"><i
                                        class="fa fa-angle-left"></i></a>
                        </li>
                    {else}
                        <li class="prev disabled">
                            <a href="#" title="First"><i class="fa fa-angle-double-left"></i></a>
                        </li>
                        <li class="prev disabled">
                            <a href="#" title="Prev"><i class="fa fa-angle-left"></i></a>
                        </li>
                    {/if}
                    {for $i=$_data['page']['dpl'] to $_data['page']['dpr']}
                        <li{if $i==$_data['page']['dp']} class="active"{/if}>
                            <a href="{$_data['page']['dup']}{$i}">{$i}</a>
                        </li>
                    {/for}
                    <li class="disabled">
                        <a> {$_data['page']['dtp']}
                            ( {$_data['page']['dp']*$_data['page']['dn']}
                            /{$_data['page']['dt']}
                            )</a></li>

                    {if $_data['page']['dprr']}
                        <li class="next">
                            <a href="{$_data['page']['dup']}{$_data['page']['dp']+1}" title="Next"><i
                                        class="fa fa-angle-right"></i></a>
                        </li>
                        <li class="next">
                            <a href="{$_data['page']['dup']}{$_data['page']['dtp']}" title="Last"><i
                                        class="fa fa-angle-double-right"></i></a>
                        </li>
                    {else}
                        <li class="next disabled">
                            <a href="#" title="Next"><i class="fa fa-angle-right"></i></a>
                        </li>
                        <li class="next disabled">
                            <a href="#" title="Last"><i class="fa fa-angle-double-right"></i></a>
                        </li>
                    {/if}
                </ul>

        </div>
    </div>
</div>
</div>
<script type="text/javascript" src="js/moment.min.js"></script>
<script type="text/javascript" src="js/zh-cn.js"></script>

</body>
<!-- END BODY -->
</html>