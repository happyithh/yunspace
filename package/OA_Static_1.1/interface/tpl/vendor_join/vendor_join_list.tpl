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
    <meta content="" name="vendor_join"/>
    {include "Admin::inc/html_head.tpl"}
    <script src="{$_assets}plugins/jquery-1.11.0.min.js" type="text/javascript"></script>
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
                    <input type="hidden" name="type" value="{$type}">

                    <div class="form-body clearfix">
                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">供应商名称</label>

                            <div class="col-md-9">
                                <input type='text' class="form-control " placeholder="供应商名称"
                                       name="search[vendor_name]" value="{$_REQUEST['search']['vendor_name']}"/>
                            </div>
                        </div>
                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">创建时间</label>

                            <div class="col-md-4">
                                <input type='text' class="form-control date" placeholder="请选择开始时间"
                                       name="search[start_time]" value="{$_REQUEST['search']['start_time']}"/>
                            </div>
                            <div class="col-md-4 col-md-offset-1">
                                <input type='text' class="form-control date" placeholder="请选择结束时间"
                                       name="search[end_time]" value="{$_REQUEST['search']['end_time']}"/>
                            </div>
                        </div>
                    </div>
                    <div class="form-body clearfix">

                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">城市</label>

                            <div class="col-md-4">
                                <select class="form-control input-sm" name="search[city]">
                                    <option value=0>全部</option>
                                    {foreach $city as $value}
                                        <option {if $value==$_REQUEST['search']['city']}selected {/if}
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
</div>
<div class="portlet">
    <div class="portlet-body">

        <ul class="nav nav-tabs">
            <li class="{if $type=='all'}active{/if}">
                <a href="?type=all{if !empty($_REQUEST['search'])}&{$urls}{/if}">全部（{($total[2])}）</a>
            </li>
            <li class="{if $type=='waiting'}active{/if}">
                <a href="?type=waiting{if !empty($_REQUEST['search'])}&{$urls}{/if}">未开始（{($total[0])}
                    ）</a>
            </li>
            <li class="{if $type=='pass'}active{/if}">
                <a href="?type=pass{if !empty($_REQUEST['search'])}&{$urls}{/if}">已通过（{($total['1'])}）</a>
            </li>
            <li class="{if $type=='abandon'}active{/if}">
                <a href="?type=abandon{if !empty($_REQUEST['search'])}&{$urls}{/if}">已放弃（{($total['-1'])}
                    ）</a>
            </li>
        </ul>
        <div class="portlet-body">
            <div class="tab-content clearfix">
                <div class="table-responsive">
                    <table class="table table-striped table-bordered">
                        <thead>
                        <tr>
                            <th>#ID</th>
                            <th class="list_none">创建时间</th>
                            <th class="list_none">城市</th>
                            <th class="list_none">主营业务</th>
                            <th class="list_none">供应商名称</th>
                            <th class="list_none">商品名称</th>
                            <th>联系人</th>
                            <th>联系电话</th>
                            <th>操作</th>
                            {*<th width="8%">操作</th>*}
                        </tr>
                        </thead>
                        <tbody>
                        {foreach $_data['rows'] as $k=>$v}
                            <tr>
                                <td>#{$v['id']}</td>
                                <td class="list_none">{Func_time::format($v['create_time'])}</td>
                                <td class="list_none">{$v['city']}</td>
                                <td class="list_none">
                                    {foreach $category as $key =>$val}
                                        {foreach $val as $kk=>$vv}
                                            {if  $v['category_id']==$kk}
                                                {$key}-->{$vv}
                                            {/if}
                                        {/foreach}
                                    {/foreach}
                                </td>
                                <td class="red">{$v['vendor_name']}</td>
                                <td class="list_none">{$v['product_name']}</td>
                                <td class="red">{$v['contact_people']}</td>
                                <td class="red">{$v['phone']}</td>
                                <td class="red">
                                    {if $v['status']==0}
                                        <a href="?action=detail&vendor_join_id={$v['id']}"
                                           class="btn btn-xs btn-danger">审核</a>
                                    {/if}
                                    {if $v['status']==1}
                                        <a href="?action=detail&vendor_join_id={$v['id']}"
                                           class="btn btn-xs btn-info">查看</a>
                                    {/if}
                                    {if $v['status']< 0}
                                        <a href="?action=detail&vendor_join_id={$v['id']}"
                                           class="btn btn-xs btn-default"
                                           style="background-color: rgba(238, 238, 238,0.8);">已放弃</a>
                                    {/if}
                                </td>
                                {*<td>*}
                                {*<a href="?action=detail&vendor_join_id={$v['id']}"*}
                                {*class="btn btn-info btn-xs">管理</a>*}
                                {*</td>*}
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
                                        <a href="{$_data['page']['dup']}1" title="First"><i
                                                    class="fa fa-angle-double-left"></i></a>
                                    </li>
                                    <li class="prev">
                                        <a href="{$_data['page']['dup']}{$_waiting['page']['dp']-1}" title="Prev"><i
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
        </div>
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