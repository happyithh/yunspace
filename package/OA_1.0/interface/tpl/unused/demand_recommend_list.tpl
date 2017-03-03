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
                    <input type="hidden" name="handle_type" value="{$handle_type}">
                    <div class="form-body clearfix">
                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">场地名称</label>

                            <div class="col-md-9">
                                <input type="text" class="form-control input-sm" placeholder="场地ID / 名称" name="search[product_name]" value="{$_REQUEST['search']['product_name']}">
                            </div>
                        </div>
                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">操作人</label>

                            <div class="col-md-9">
                                <input type="text" class="form-control input-sm" placeholder="操作人名称" name="search[username]" value="{$_REQUEST['search']['username']}">
                            </div>
                        </div>
                        {*<div class="form-group col-md-5">*}
                            {*<label class="col-md-3 control-label">操作内容</label>*}

                            {*<div class="col-md-9">*}
                                {*<select class="form-control input-sm" name="search[operate_cont]">*}
                                    {*<option value=''>全部</option>*}
                                    {*{foreach $operate_cont as $key=>$value}*}
                                        {*<option {if {$_REQUEST['search']['operate_cont']==$key}}selected {/if} value="{$key}">{$value}</option>*}
                                    {*{/foreach}*}
                                {*</select>*}
                            {*</div>*}
                        {*</div>*}
                        {*<div class="form-group col-md-5">*}
                            {*<label class="col-md-3 control-label">操作类型</label>*}

                            {*<div class="col-md-9">*}
                                {*<select class="form-control input-sm" name="search[operate_sort]">*}
                                    {*<option value=0>全部*}
                                    {*</option>*}
                                    {*{foreach $operate_sort as $key=>$value}*}
                                        {*<option {if {$_REQUEST['search']['operate_sort']==$key}}selected {/if} value="{$key}">{$value}</option>*}
                                    {*{/foreach}*}
                                {*</select>*}
                            {*</div>*}
                        {*</div>*}
                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">需求人</label>

                            <div class="col-md-9">
                                <input type="text" class="form-control input-sm" placeholder="需求人" name="search[demand_name]" value="{$_REQUEST['search']['demand_name']}">
                            </div>
                        </div>
                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">创建时间</label>
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
    <div class="portlet-body">
        <div class="table-responsive clearfix">
            <table class="table table-striped table-bordered table-hover" id="data_table" style="word-break: break-all">
                <thead>
                <tr>
                    <th>场地名称</th>
                    <th>地址信息</th>
                    <th>推荐理由</th>
                    <th>需求人</th>
                    <th>操作人</th>
                    <th>创建时间</th>
                </tr>
                </thead>
                <tbody>
                {foreach $data['rows'] as $key=>$value}
                    <tr>
                        <td><a href="?product_info_id={$value['id']}">{$value['product_name']}</a></td>
                        <td>{$value['addr']}</td>
                        <td>{$value['demo']}</td>
                        <td> <a href="?demand_name={$value['demand_name']}">{$value['demand_name']}</td>
                        <td><a href="?administrator_username={$value['username']}">{$value['username']}</a></td>
                        <td>{date('Y-m-d H:i:s',$value['create_time'])}</td>
                        {*<td>{$value['demo']}</td>*}
                        {*<td>{$value['demand_name']}</td>*}
                        {*<td>{$value['product_name']}</td>*}
                        {*<td>{$value['addr']}</td>*}
                        {*<td>{$value['username']}</td>*}
                    </tr>
                {/foreach}
                </tbody>
            </table>
            <div class="pull-left" style="width:30%; padding: 10px 0;">
            </div>
            <div class="pull-right">
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
                            ( {$data['page']['dp']*$data['page']['dn']}
                            /{$data['page']['dt']} )</a>
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
        var product_id=$(this).attr('data-pid');
        $.post('{$__route}../marketing/contact_urgent_list?',{ del:1,product_id:product_id,tab:'product',action:'detail',id:415 },function(data){
            if(data=='success'){
                window.location.reload();
            }else{
                alert('操作错误，请重试！！');
            }
        })
    })
</script>
</body>
<!-- END BODY -->
</html>