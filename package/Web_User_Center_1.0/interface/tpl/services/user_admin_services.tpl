<!DOCTYPE html>
<!--[if IE 8]>
<html lang="en" class="ie8 no-js"> <![endif]-->
<!--[if IE 9]>
<html lang="en" class="ie9 no-js"> <![endif]-->
<!--[if !IE]><!-->
<html lang="en" class="no-js">
<!--<![endif]-->
<head>
    {include 'inc/html_head.tpl'}
    <style>
        .btn-primary{ font-size: 12px;}
        .btn3{ padding: 3px 6px;}
        .btn-danger{ font-size: 12px;}
    </style>
</head>
<body>
{include 'inc/header_top.tpl'}
<div class="clearfix"></div>
<div class="page-container">
    {include 'inc/header_purchase_nav.tpl' index=2}

    <div class="page-content-wrapper">

        <div class="page-content" style="min-height: 973px">
            <h3 class="page-title">云服务-顾问推荐</h3>
            <div class="portlet">
                <div class="portlet-body">
                    <div class="table-responsive">
                        <ul class="nav nav-tabs">
                            <li class="{if $type=='waiting'}active{/if}">
                                <a href="?type=waiting">待处理</a>
                            </li>
                            <li class="{if $type=='done'}active{/if}">
                                <a href="?type=done">已处理</a>
                            </li>
                            <li class="{if $type=='abandon'}active{/if}">
                                <a href="?type=abandon">已放弃</a>
                            </li>
                        </ul>
                        <table class="table table-striped table-bordered table-hover">
                            <thead>
                            <tr>
                                <th>
                                    时间
                                </th>
                                <th>
                                    需求
                                </th>
                                <th>
                                   相关服务/套餐
                                </th>

                            </tr>
                            </thead>
                            <tbody>
                            {foreach $data['rows'] as $k=>$v}
                                <tr>
                                    <td>
                                        {date('Y-m-d H:i:s',$v['create_time'])}
                                    </td>
                                    <td>
                                        {$v['demand']['具体要求']}
                                    </td>
                                    <td>
                                        {if $v['demand_status']==1}
                                            <a class="btn btn-primary btn-xs" href="?action=detail&demand_id={$v['id']}&recommend_type=product">查看服务</a>
                                            <a class="btn btn-success btn-xs" href="?action=detail&demand_id={$v['id']}&recommend_type=set">查看套餐</a>
                                        {elseif $v['demand_status']==0}
                                            <span class="btn btn-primary btn3" disabled="disabled">需求处理中</span>
                                        {else}
                                            <span class="btn btn-danger btn3" disabled="disabled">需求已放弃</span>
                                        {/if}
                                        {if $type =='waiting'}
                                            <a class="btn btn-danger btn3" href="?action=cancel&demand_id={$v['id']}" >放弃</a>
                                        {/if}
                                    </td>
                                </tr>
                            {/foreach}
                            </tbody>
                        </table>
                        <div style="text-align: center;">
                            <ul class="pagination">
                                {if $data['page']['dpll']}
                                    <li class="prev">
                                        <a href="{$data['page']['dup']}1" title="First"><i class="fa fa-angle-double-left"></i></a>
                                    </li>
                                    <li class="prev">
                                        <a href="{$data['page']['dup']}{$data['page']['dp']-1}" title="Prev"><i class="fa fa-angle-left"></i></a>
                                    </li>
                                {else}
                                    <li class="prev disabled">
                                        <a href="#" title="First"><i class="fa fa-angle-double-left"></i></a>
                                    </li>
                                    <li class="prev disabled">
                                        <a href="#" title="Prev"><i class="fa fa-angle-left"></i></a>
                                    </li>
                                {/if}
                                {for $i=$data['page']['dpl'] to $data['page']['dpr']}
                                    <li{if $i==$data['page']['dp']} class="active"{/if}>
                                        <a href="{$data['page']['dup']}{$i}">{$i}</a>
                                    </li>
                                {/for}
                                <li class="disabled">
                                    <a> {$data['page']['dtp']}
                                        {if $data['page']['dt'] == 0}
                                            ( 0/{$data['page']['dt']} )
                                        {else}
                                            ({( $data['page']['dp']-1)*$data['page']['dn']+1}/{$data['page']['dt']} )
                                        {/if}
                                    </a>
                                </li>

                                {if $data['page']['dprr']}
                                    <li class="next">
                                        <a href="{$data['page']['dup']}{$data['page']['dp']+1}" title="Next"><i class="fa fa-angle-right"></i></a>
                                    </li>
                                    <li class="next">
                                        <a href="{$data['page']['dup']}{$data['page']['dtp']}" title="Last"><i class="fa fa-angle-double-right"></i></a>
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

        </div>
    </div>
    {include 'inc/footer_inbox.tpl'}
    {include 'inc/footer_script.tpl'}

</body>
</html>