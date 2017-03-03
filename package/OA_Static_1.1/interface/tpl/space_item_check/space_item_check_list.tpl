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
                <form action="?" method="get" class="clearfix">
                    <div class="form-body clearfix">
                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">子空间名称</label>

                            <div class="col-md-9">
                                <input type="text" class="form-control input-sm" placeholder="子空间ID / 名称" name="search[title]" value="{$_REQUEST['search']['title']}">
                            </div>
                        </div>
                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">百科名称</label>

                            <div class="col-md-9">
                                <input type="text" class="form-control input-sm" placeholder="请输入百科名称" name="search[space_name]" value="{$_REQUEST['search']['space_name']}">
                            </div>
                        </div>
                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">城市</label>

                            <div class="col-md-9">
                                <input type="text" class="form-control input-sm" placeholder="请输入要搜索的城市" name="search[city]" value="{$_REQUEST['search']['city']}">
                            </div>
                        </div>
                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">联系人</label>

                            <div class="col-md-9">
                                <input type="text" class="form-control input-sm" placeholder="请输入要搜索的联系人" name="search[contacts]" value="{$_REQUEST['search']['contacts']}">
                            </div>
                        </div>
                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">联系方式</label>

                            <div class="col-md-9">
                                <input type="text" class="form-control input-sm" placeholder="请输入要搜索的联系方式" name="search[phone]" value="{$_REQUEST['search']['phone']}">
                            </div>
                        </div>
                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">创建时间</label>
                            <div class="col-md-9">
                                <input type='text' class="form-control date" placeholder="请选择创建时间" name="search[create_time]" value="{$_REQUEST['search']['create_time']}"/>
                            </div>
                        </div>
                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">更新时间</label>
                            <div class="col-md-4">
                                <input type='text' class="form-control date" placeholder="请选择开始时间" name="search[start_time]" value="{$_REQUEST['search']['start_time']}"/>
                            </div>
                            <div class="col-md-4 col-md-offset-1">
                                <input type='text' class="form-control date" placeholder="请选择结束时间" name="search[end_time]" value="{$_REQUEST['search']['end_time']}"/>
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
    <div class="portlet-title">
        <div class="caption">
            <i class="fa fa-comments"></i>
            待审核子空间列表
        </div>
    </div>
    <div class="portlet-body">
        <div class="table-responsive clearfix">
            <table class="table table-striped table-bordered table-hover" id="data_table" style="word-break: break-all">
                <thead>
                <tr>
                    <th>子空间ID</th>
                    <th>子空间名称</th>
                    <th>场地百科名称</th>
                    <th>城市</th>
                    <th>联系人</th>
                    <th>联系方式</th>
                    <th>邮箱</th>
                    <th>创建时间</th>
                    <th>更新时间</th>
                    <th>操作</th
                </tr>
                </thead>
                <tbody>
                {foreach $_data['rows'] as $k=>$v}
                    <tr data-sid="{$v['id']}">
                        <td class="list_none">{$v['id']} {if $v['new_id']}<button class="btn btn-warning btn-xs" disabled>场地出租</button>{/if}</td>
                        <td class="list_size">{$v['item_name']}</td>
                        <td class="list_size">{$v['space_name']}</td>
                        <td class="list_size">{$v['city']}</td>
                        <td class="list_size">{$v['contacts']}</td>
                        <td class="list_size">{$v['phone']}</td>
                        <td class="list_size">{$v['email']}</td>
                        <td class="list_none">{if $v['create_time']>1430713953}{date('Y-m-d H:i:s',$v['create_time'])}{else}--{/if}</td>
                        <td class="list_none">{if $v['update_time']>1430713953}{date('Y-m-d H:i:s',$v['update_time'])}{else}--{/if}</td>
                        <td >
                            <a href="?action=check_detail&item_id={$v['id']}" class="btn btn-success btn-xs list_size"><i class="fa fa-eye"></i>审核</a>
                        </td>
                    </tr>
                {/foreach}
                </tbody>
            </table>
            <div class="pull-right">
                <ul class="pagination">
                    {if $_data['page']['dpll']}
                        <li class="prev">
                            <a href="{$_data['page']['dup']}1" title="First"><i class="fa fa-angle-double-left"></i></a>
                        </li>
                        <li class="prev">
                            <a href="{$_data['page']['dup']}{$_data['page']['dp']-1}" title="Prev"><i class="fa fa-angle-left"></i></a>
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
                            /{$_data['page']['dt']} )</a>
                    </li>

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
</body>
<!-- END BODY -->
</html>