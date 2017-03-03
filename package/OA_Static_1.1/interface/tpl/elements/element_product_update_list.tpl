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
                    <input type="hidden" name="list_type" value="product">
                    <input type="hidden" name="handle_type" value="{$_data['other']['handle_type']}">
                    <div class="form-body clearfix">
                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">产品名称</label>

                            <div class="col-md-9">
                                <input type="text" class="form-control input-sm" placeholder="产品ID / 名称" name="search[title]" value="{$_REQUEST['search']['title']}">
                            </div>
                        </div>
                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">供应商名称</label>

                            <div class="col-md-9">
                                <input type="text" class="form-control input-sm" placeholder="供应商名称" name="search[vendor_name]" value="{$_REQUEST['search']['vendor_name']}">
                            </div>
                        </div>
                        {*<div class="form-group col-md-5">*}
                            {*<label class="col-md-3 control-label">城市</label>*}

                            {*<div class="col-md-9">*}
                                {*<select class="form-control input-sm" name="search[search_city]">*}
                                    {*<option value=''>全部</option>*}
                                    {*{foreach $_REQUEST['cities'] as $v}*}
                                        {*<option {if $_REQUEST['search']['search_city']==$v}selected {/if} value="{$v}">{$v}</option>*}
                                    {*{/foreach}*}
                                {*</select>*}
                            {*</div>*}
                        {*</div>*}
                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">产品类型</label>

                            <div class="col-md-9">
                                <select class="form-control input-sm" name="search[category_id]">
                                    <option value=0>不限
                                    </option>
                                    {function show_category level=0}
                                        {foreach $_data['other']['categoryList'][$id] as $k=>$v}
                                            {if $v||$k==$_REQUEST['search']['category_id']}
                                                <option value="{$k}" {if $k==$_REQUEST['search']['category_id']} selected="selected" {/if}>{str_repeat('&nbsp; ', $lv)}
                                                    {$v}
                                                </option>
                                                {if $_data['other']['categoryList'][$k]}
                                                    {show_category data=$_data['other']['categoryList'] id=$k lv=$lv+1}
                                                {/if}
                                            {/if}
                                        {/foreach}
                                    {/function}
                                    {show_category data=$_data['other']['categoryList'] id=0 lv=1}
                                </select>
                            </div>
                        </div>
                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">面积</label>

                            <div class="col-md-9">
                                <select class="form-control input-sm" name="search[size_range]">
                                    <option value=0>全部</option>
                                    {foreach $_data['other']['size_range'] as $key=>$value}
                                        <option {if {$_REQUEST['search']['size_range']==$key}}selected {/if} value="{$key}">{$value}</option>
                                    {/foreach}
                                </select>
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
                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">来源</label>
                            <div class="col-md-9">
                            <select class="form-control input-sm" name="search[is_admin]">
                                <option value=0>全部</option>
                                <option {if $_REQUEST['search']['is_admin']==1} selected {/if} value=1>商家</option>
                                <option {if $_REQUEST['search']['is_admin']==2} selected {/if} value=2>市场部</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">创建时间</label>
                            <div class="col-md-9">
                                <input type='text' class="form-control date" placeholder="创建时间" name="search[create_time]" value="{$_REQUEST['search']['create_time']}"/>
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
            产品列表
        </div>
    </div>
    <div class="portlet-tabs" style="position:relative">
        <ul class="nav nav-tabs" style="overflow: inherit; padding-left: 100px">
            <li class="{if $_data['other']['handle_type']=='online'}active{/if}">
                <a href="?{if !empty($_REQUEST['search'])}handle_type=online&{$_data['other']['urls']}{else}list_type=product&handle_type=online{/if}">上线</a>
            </li>
            <li class="{if $_data['other']['handle_type']=='all'}active{/if}">
                <a href="?{if !empty($_REQUEST['search'])}handle_type=all&{$_data['other']['urls']}{else}list_type=product&handle_type=all{/if}">全部</a>
            </li>
        </ul>
    </div>
    <div class="portlet-body">
        <div class="table-responsive clearfix">
            <table class="table table-striped table-bordered table-hover" id="data_table" style="word-break: break-all">
                <thead>
                <tr>
                    <th class="list_none">产品ID</th>
                    <th>产品名称</th>
                    <th>产品类型</th>
                    <th>供应商名称</th>
                    <th class="list_none">城市</th>
                    <th >面积</th>
                    <th class="list_none">创建时间</th>
                    <th class="list_none">更新时间</th>
                </tr>
                </thead>
                <tbody>
                {foreach $_data['rows'] as $k=>$v}
                    <tr>
                        <td class="list_none">{$v['id']}</td>
                        <td class="list_size">
                            {$v['product_name']}

                            {if $v['admin_id']!=0 && $v['create_by_quick']==1}
                                (后台快速创建)
                            {elseif $v['admin_id']!=0 && $v['create_by_quick']==2}
                                (供应商加盟)
                            {elseif $v['admin_id'] ==0}
                                (商户后台)
                            {/if}
                            {if $v['status']==2}
                                <span class="btn btn-warning btn-xs">审核中</span>
                            {elseif $v['status']==3}
                                <span class="btn btn-danger btn-xs">已拒绝</span>
                            {elseif $v['status']==-2}
                                <span class="btn btn-danger btn-xs">已删除</span>
                            {/if}
                        </td>
                        <td class="list_size">
                            {$_data['other']['_category'][$v['category_id']][0]}
                        </td>
                        <td class="list_size">{$v['vendor_name']}</td>
                        <td class="list_none">{$v['attr_new'][46]}</td>
                        <td class="list_size">{$v['product_size']}</td>
                        <td class="list_none">{date('Y-m-d H:i:s',$v['create_time'])}</td>
                        <td class="list_none">{if $v['update_time']>1430713953}{date('Y-m-d H:i:s',$v['update_time'])}{else}--{/if}</td>

                    </tr>
                {/foreach}
                </tbody>
            </table>
            <div class="pull-left" style="width:30%; padding: 10px 0;">

            </div>
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

<!-- BEGIN JAVASCRIPTS(Load javascripts at bottom, this will reduce page load time) -->
<!-- BEGIN CORE PLUGINS -->
<script src="{$_assets}plugins/jquery-1.11.0.min.js"
        type="text/javascript"></script>
<script src="{$_assets}scripts/_page.js"></script>
<script type="text/javascript" src="js/moment.min.js"></script>
<script type="text/javascript" src="js/zh-cn.js"></script>
<script type="text/javascript" src="js/bootstrap-datetimepicker.min.js"></script>
<script>
    $(document).ready(function(){
        $('.date').datetimepicker({
            format: 'YYYY-MM-DD',
            locale: 'zh-cn'
        });
    })
    $('.deleteProduct').click(function(){

        if (!confirm('您确定要删除吗？？')) {
            return false;
        }
        var product_id=$(this).attr('data-pid');
        $.post('http://{Core::$urls['host']}/static/api/product/handle.jsonp', {
            status: -2,
            product_id: product_id,
            action: 'change_status'
        }, function (data) {
            if(data.status==1){
                top.alert(" "+data.msg);
                window.location.reload();
            }else{
                top.alert(data.msg);
            }
        },"json");
    })
</script>
</body>
<!-- END BODY -->
</html>