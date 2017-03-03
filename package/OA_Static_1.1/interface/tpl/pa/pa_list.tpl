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

<div class="cols-md-3 " style="text-align: center;margin: 15px 0px">
    <a href="?">
        <div class="btn btn-default {if $handle_type=='adver' || !isset($handle_type)} btn-success{/if} active go_switch_window">
            广告管理
        </div>
    </a>
    <a href="?action=site_list">
        <div class="btn btn-default {if $handle_type=='adver_site'} btn-success{/if} go_switch_window">广告位管理</div>
    </a>
    <a href="?action=adver_statistics">
        <div class="btn btn-default {if $handle_type=='adver_statistics'} btn-success{/if} go_switch_window">广告位统计</div>
    </a>
</div>

</div>
<div class="portlet">
    <div class="portlet-title">
        <div class="caption">
            <i class="fa fa-search"></i>搜索条件
        </div>
        <div style="float: right;">
            <a href="?action=paAdd" class="btn btn-info btn-xs" style="font-size:15px!important;"><i
                        class="fa fa-plus"></i>添加广告</a>&nbsp;&nbsp;
            {*<a href="?action=site_list" class="btn btn-success btn-xs" style="font-size:15px!important;"><i*}
            {*class="fa "></i>广告位管理</a>&nbsp;&nbsp;*}
        </div>
    </div>
    <div class="portlet-body">
        <div class="portlet-tabs">
            <div class="clearfix"></div>
            <div>
                <form action="?" method="get" class="clearfix">
                    <input type="hidden" name="type" value="{$type}">

                    <div class="form-body clearfix">
                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">广告名称</label>

                            <div class="col-md-5">
                                <input type='text' class="form-control" placeholder="广告名称"
                                       name="search[advertising_title]"
                                       value="{$_REQUEST['search']['advertising_title']}"/>
                            </div>
                        </div>
                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">广告位置</label>

                            <div class="col-md-5">
                                <select class="form-control input-sm" name="search[site]">
                                    <option value="0">请选择</option>
                                    {foreach $site as $k=>$v}
                                        <option {if $_REQUEST['search']['site']==$v['site']}selected {/if}
                                                value="{$v['site']}">{$v['site']}</option>
                                    {/foreach}
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="form-body clearfix">
                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">状态</label>

                            <div class="col-md-5">
                                <select class="form-control input-sm" name="search[status]">
                                    <option value=0>全部</option>
                                    <option {if $_REQUEST['search']['status']==1}selected {/if} value=1>上架</option>
                                    <option {if $_REQUEST['search']['status']==-1}selected {/if} value=-1>下架</option>

                                </select>
                            </div>
                        </div>
                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">投放城市</label>

                            <div class="col-md-5">
                                <select class="form-control input-sm" name="search[city]">
                                    <option value="0">请选择</option>
                                    <option {if $_REQUEST['search']['city']=='全国'} selected {/if} value="全国">全国</option>
                                    {foreach $_REQUEST['cities'] as $value}
                                        <option {if $_REQUEST['search']['city']==$value} selected {/if}
                                                value="{$value}">{$value}</option>
                                    {/foreach}
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

    <div class="portlet-body">
        <div class="table-responsive clearfix">
            <table class="table table-striped table-bordered table-hover" id="data_table" style="word-break: break-all">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>排序</th>
                    <th>广告位置</th>
                    <th>广告名称</th>
                    <th>投放公司</th>
                    <th>广告有效期</th>
                    <th>城市</th>
                    <th>状态</th>
                    <th>默认广告</th>
                    <th>备注</th>
                    <th>操作</th>
                </tr>
                </thead>
                {foreach $data['rows'] as $k=>$v}
                    <tr>
                        <td>{$v['id']}</td>
                        <td>{$v['rank']}</td>
                        <td>{$v['site']}</td>
                        <td>{$v['advertising_title']}</td>
                        <td>{$v['company']}</td>
                        <td>{if $v['start_time']!=0}{date('Y-m-d',$v['start_time'])}{/if} {if $v['end_time']!=0}--
                                {date('Y-m-d',$v['end_time'])}{/if}
                        </td>
                        <td>{if empty($v['city'])}全国{else}{$v['city']}{/if}</td>
                        <td>{if $v['status']==1}上架{elseif $v['status']==-1}下架{/if}</td>
                        <td>{if $v['default_adver']==0}否{elseif $v['default_adver']==1}是{/if}</td>
                        <td>{$v['note']}</td>
                        <td>
                            <a href="?action=adver_edit&id={$v['id']}" class="btn btn-info btn-xs"><i
                                        class="fa fa-pencil"></i>
                                修改</a>
                            {*<a href="?action=adver_statistics&adv_id={$v['id']}&site_id={$v['site_id']}" class="btn btn-success btn-xs"><i*}
                                        {*class="fa fa-eye"></i>*}
                                {*统计</a>*}
                        </td>
                    </tr>
                {/foreach}
                </thead>
                <tbody>

            </table>
        </div>
        <div class="pull-left" style="width:30%; padding: 10px 0;">

        </div>
        <div class="pull-right">
            <ul class="pagination">
                {if $data['page']['dpll']}
                    <li class="prev">
                        <a href="{$data['page']['dup']}1" title="First"><i class="fa fa-angle-double-left"></i></a>
                    </li>
                    <li class="prev">
                        <a href="{$data['page']['dup']}{$data['page']['dp']-1}" title="Prev"><i
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
                {for $i=$data['page']['dpl'] to $data['page']['dpr']}
                    <li{if $i==$data['page']['dp']} class="active"{/if}>
                        <a href="{$data['page']['dup']}{$i}">{$i}</a>
                    </li>
                {/for}
                <li class="disabled">
                    <a> {$data['page']['dtp']}
                        ( {$data['page']['dp']*$data['page']['dn']}
                        /{$data['page']['dt']} )</a>
                </li>

                {if $data['page']['dprr']}
                    <li class="next">
                        <a href="{$data['page']['dup']}{$data['page']['dp']+1}" title="Next"><i
                                    class="fa fa-angle-right"></i></a>
                    </li>
                    <li class="next">
                        <a href="{$data['page']['dup']}{$data['page']['dtp']}" title="Last"><i
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

<!-- BEGIN JAVASCRIPTS(Load javascripts at bottom, this will reduce page load time) -->
<!-- BEGIN CORE PLUGINS -->
</body>
<!-- END BODY -->
</html>