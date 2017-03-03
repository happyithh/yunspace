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
    <link href="style/media.css" rel="stylesheet">
</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->

<body style="background:#FaFaFa !important">
<div class="portlet">
    <div class="portlet-title">
        <div class="caption">
            <i class="fa fa-database"></i>我的需求列表 (当前共<a href="#"> {$_data['page']['dt']} </a>个需求)
        </div>
    </div>
    <div class="portlet-body">
        <div class="tab-content clearfix">
            <div class="table-responsive">
                <table class="table table-striped table-bordered table-advance table-hover">
                    <thead>
                    <tr>
                        <th class="list_none">#ID</th>
                        <th class="list_none">创建时间</th>
                        <th>需求类型</th>
                        <th>联系人</th>
                        <th>城市</th>
                        <th>具体要求</th>
                        <th>操作</th>
                    </tr>
                    </thead>
                    <tbody>
                    {foreach $_data['rows'] as $k=>$v}
                        <tr>
                            <td class="list_none">#{$v['id']}</td>
                            <td class="list_none">{Func_Time::format($v['create_time'])}</td>
                            <td>{$v['demand_type']}</td>
                            <td class="red">{$v['username']}</td>
                            <td>{$v['city']}</td>
                            <td width="35%">{$v['demand']['具体要求']}</td>
                            <td>
                                {if $v['contact_id']}
                                <a href="{$_route}contact_urgent_list?tab=3&demand_id={$v['id']}&id={$v['contact_id']}" class="btn btn-info btn-xs">需求详情和推荐</a>
                                {/if}
                            </td>
                        </tr>
                    {/foreach}
                    </tbody>
                </table>
            </div>
            <div class="container-fluid">
                <div class="row">
                    <div class="col-md-12" style="padding: 0px;">
                        <ul class="pagination">
                            {if $_data['page']['dpll']}
                                <li class="prev">
                                    <a href="{$_data['page']['dup']}1" title="First"><i class="fa fa-angle-double-left"></i></a>
                                </li>
                                <li class="prev">
                                    <a href="{$_data['page']['dup']}{$_waiting['page']['dp']-1}" title="Prev"><i class="fa fa-angle-left"></i></a>
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
                                    <a href="{$_data['page']['dup']}{$_data['page']['dp']+1}" title="Next"><i class="fa fa-angle-right"></i></a>
                                </li>
                                <li class="next">
                                    <a href="{$_data['page']['dup']}{$_data['page']['dtp']}" title="Last"><i class="fa fa-angle-double-right"></i></a>
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


</body>
</body>
<!-- END BODY -->
</html>