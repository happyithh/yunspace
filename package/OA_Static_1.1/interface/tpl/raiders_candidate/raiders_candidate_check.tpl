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

    <script src="{$_assets}plugins/jquery-1.11.0.min.js" type="text/javascript"></script>
    <script src="{$_assets}plugins/jquery-ui/jquery-ui-1.10.3.custom.min.js" type="text/javascript"></script>
    <script src="{$_assets}plugins/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
    <script src="{$_assets}plugins/bootstrap-hover-dropdown/bootstrap-hover-dropdown.min.js" type="text/javascript"></script>
    <script src="{$_assets}plugins/jquery-slimscroll/jquery.slimscroll.min.js" type="text/javascript"></script>
    <script src="{$_assets}plugins/jquery.blockui.min.js" type="text/javascript"></script>
    <script src="{$_assets}plugins/uniform/jquery.uniform.min.js" type="text/javascript"></script>
    <!-- END CORE PLUGINS -->
    <!-- BEGIN PAGE LEVEL PLUGINS -->
    <script type="text/javascript" src="{$_assets}plugins/select2/select2.min.js"></script>
    <!-- END PAGE LEVEL PLUGINS -->
    <!-- BEGIN PAGE LEVEL SCRIPTS -->
    <script src="{$_assets}scripts/_page.js"></script>
    <link rel="stylesheet" type="text/css" href="{$_assets}plugins/bootstrap-wysihtml5/bootstrap-wysihtml5.css"/>
    <script type="text/javascript" src="{$_assets}plugins/bootstrap-wysihtml5/wysihtml5-0.3.0.js"></script>
    <script type="text/javascript" src="{$_assets}plugins/bootstrap-wysihtml5/bootstrap-wysihtml5.js"></script>
    <link rel="stylesheet" type="text/css" href="{$_assets}plugins/jquery-tags-input/jquery.tagsinput.css"/>
    <script type="text/javascript" src="{$_assets}plugins/jquery-tags-input/jquery.tagsinput.min.js"></script>
    <link rel="stylesheet" type="text/css" href="{$_assets}plugins/jquery-multi-select/css/multi-select.css"/>
    <script type="text/javascript" src="{$_assets}plugins/jquery-multi-select/js/jquery.multi-select.js"></script>

</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->

<body style="background:#FaFaFa !important">
<!-- BEGIN PAGE HEADER-->
<h3 class="page-title" style="float: left;">
    资讯候选数据处理
</h3>
<a href="javascript:history.go(-1)" class="back"><
    <返回
</a>

<div class="clear"></div>
<div class="portlet">
    <div class="portlet-body">
        <div class="portlet">
            <div class="portlet-title">
                <div class="caption">
                    <i class="fa fa-comments"></i>
                    候选数据详情列表
                </div>
            </div>
            <div class="portlet-body">
                <div class="table-responsive clearfix">
                    <table class="table table-striped table-bordered table-hover" id="data_table"
                           style="word-break: break-all">
                        <tbody >
                        <tr><th style="width:7%">文章ID</th><td>#{$_data[0]['id']}</td></tr>
                        <tr><th>文章名称</th><td>{$_data[0]['title']}</td></tr>
                        <tr><th>文章简介</th><td>{$_data[0]['des']}</td></tr>
                        {if $_data[0]['status']!=3}
                        <tr><th>操作人</th><td>{$_data[0]['username']}</td></tr>
                        {/if}
                        <tr><th>状态</th><td>{if $_data[0]['status']==1}已处理{elseif $_data[0]['status']==2}重复{elseif $_data[0]['status']==4}无效{elseif $_data[0]['status']==5}数据不完整{else}待处理{/if}</td></tr>
                        <tr><th>来源</th><td><a href="{$_data[0]['from_where']}" target="_blank">{$_data[0]['from_where']}</a></td></tr>
                        <tr><th>入库时间</th><td>{date('Y-m-d H:i:s',$_data[0]['create_time'])}</td></tr>
                        {if $_data[0]['status']!=3}
                        <tr><th>操作时间</th><td>{date('Y-m-d H:i:s',$_data[0]['update_time'])}</td></tr>
                        {/if}
                        </tbody>
                    </table>
                    <div class="pull-left" style="width:30%; padding: 10px 0;">
                    </div>

                </div>
            </div>
        </div>
        {*<div class="container-fluid">*}
        {*<div class="row form-horizontal">*}
        {*<form action="?action=check&handle_type=invalid&id={$_data[0]['id']}" method="post">*}
        {*<div class="form-group">*}
        {*<div class="form-actions text-center">*}
        {*<a href="?action=check&handle_type=pass&id={$_data[0]['id']}" class="btn btn-success">创建该产品</a>*}
        {*<a href="?action=check&handle_type=repeat&id={$_data[0]['id']}" class="btn btn-primary">标记为重复</a>*}
        {*<a href="?action=check&handle_type=less&id={$_data[0]['id']}" class="btn btn-primary" style="background-color:#FFAA33;border: 1px solid #FFAA33">数据不完整</a>*}
        {*<button type="submit" class="btn btn-danger">标记为无效</button>*}
        {*</div>*}
        {*</div>*}
        {*</form>*}
        {*</div>*}
        {*</div>*}


        <div class="portlet">
            <div class="portlet-title">
                <div class="caption">
                    <i class="fa fa-comments"></i>
                    相似文章数据列表
                </div>
            </div>
            <div class="portlet-body">
                <div class="table-responsive clearfix">
                    <table class="table table-striped table-bordered table-hover" id="data_table"
                           style="word-break: break-all">
                        <thead>
                        <tr>
                            <th>文章ID</th>
                            <th>文章名称</th>
                            <th>文章描述</th>
                            <th>状态</th>
                            <th>作者</th>
                            <th>更新时间</th>
                        </tr>
                        </thead>
                        <tbody>
                        {foreach $p_data as $k=>$v}
                            <tr role="row" data-pid="{$v['id']}">
                                <td>#{$v['id']}</td>
                                <td><a href="?action=raiders_detail&id={$v['id']}" target="_blank">{$v['title']}</a></td>
                                <td>{$v['des']}</td>
                                <td>{if $v['status']==1}上线{else}下线{/if}</td>
                                <td>{$v['author']}</td>
                                <td>{date('Y-m-d H:i:s',$v['update_time'])}</td>
                            </tr>
                        {/foreach}
                        </tbody>
                    </table>
                    <div class="pull-left" style="width:30%; padding: 10px 0;">
                    </div>

                </div>
            </div>
        </div>
        {*<div class="portlet">*}
            {*<div class="portlet-title">*}
                {*<div class="caption">*}
                    {*<i class="fa fa-comments"></i>*}
                    {*相似供应商数据列表*}
                {*</div>*}
            {*</div>*}
            {*<div class="portlet-body">*}
                {*<div class="table-responsive clearfix">*}
                    {*<table class="table table-striped table-bordered table-hover" id="data_table"*}
                           {*style="word-break: break-all">*}
                        {*<thead>*}
                        {*<tr>*}
                            {*<th>供应商ID</th>*}
                            {*<th>供应商名称</th>*}
                            {*<th>创建时间</th>*}
                        {*</tr>*}
                        {*</thead>*}
                        {*<tbody>*}
                        {*{foreach $v_data as $k=>$v}*}
                            {*<tr role="row" data-pid="{$v['id']}">*}
                                {*<td>#{$v['id']}</td>*}
                                {*<td><a href="?action=vendor_detail&vendor_id={$v['id']}"  target="_blank">{$v['vendor_name']}</a></td>*}
                                {*<td>{date('Y-m-d H:i:s',$v['create_time'])}</td>*}
                            {*</tr>*}
                        {*{/foreach}*}
                        {*</tbody>*}
                    {*</table>*}
                    {*<div class="pull-left" style="width:30%; padding: 10px 0;">*}
                    {*</div>*}

                {*</div>*}
            {*</div>*}
        {*</div>*}
        <div class="form-actions text-center">
            <a class="btn btn-success getCategory" href="javascript:;" id="{$_REQUEST['id']}">完善候选数据</a>
            <a href="?action=check&handle_type=repeat&id={$_data[0]['id']}" class="btn btn-primary">标记为重复</a>
            <a href="?action=check&handle_type=less&id={$_data[0]['id']}" class="btn btn-primary" style="background-color:#FFAA33;border: 1px solid #FFAA33">数据不完整</a>
            <a href="?action=check&handle_type=invalid&id={$_data[0]['id']}"  class="btn btn-danger">标记为无效</a>
        </div>



        {*<div class="portlet tabbable">*}
            {*<div class="portlet-title">*}
                {*<div class="caption">*}
                    {*<i class="fa fa-database"></i>供应商候选数据处理*}
                {*</div>*}
            {*</div>*}
            {*<div class="portlet-body form-horizontal">*}
                {*<div class="form-body" style="min-height: 350px;">*}
                    {*{if $_REQUEST['category_id']}*}
                        {*<form class="form-horizontal" role="form" action="?" method="post">*}
                            {*<input type="hidden" name="action" value="is_submit">*}
                            {*<input type="hidden" name="id" value="{{$_REQUEST['id']}}">*}
                            {*<div class="clear"><h3 class="form-section">联系人信息</h3>*}
                            {*</div>*}
                            {*{include file="vendor_candidate/inc/quick_contacts.tpl"}*}
                            {*<div class="clear"><h3 class="form-section">供应商信息</h3>*}
                            {*</div>*}
                            {*{include file="vendor_candidate/inc/quick_vendor.tpl"}*}
                            {*<div class="clear"><h3 class="form-section">产品信息</h3>*}
                            {*</div>*}
                            {*{include file="vendor_candidate/inc/quick_product.tpl"}*}

                            {*<div class="form-actions text-center">*}
                                {*<button type="reset" class="btn btn-default">*}
                                    {*重置*}
                                {*</button>*}
                                {*<button type="submit" class="btn btn-success">*}
                                    {*提交*}
                                {*</button>*}
                            {*</div>*}

                        {*</form>*}
                    {*{else}*}
                        {*<div class="row">*}
                            {*<div class="form-group">*}
                                {*<label class="col-md-3 control-label">请先选择服务分类</label>*}
                                {*<div class="col-md-7">*}
                                    {*<select class="form-control select2me" name="category_id" data-placeholder="Select...">*}
                                        {*{function show_category level=0}*}
                                            {*{foreach $_categories[$id] as $k=>$v}*}
                                                {*{if $v}*}
                                                    {*<option value="{$k}" {if $k==$_data['category_id']}selected="selected" {/if}>{str_repeat(' . . ', $lv)}*}
                                                        {*{$k}. {$v}*}
                                                    {*</option>*}
                                                {*{/if}*}
                                                {*{if $_categories[$k]}*}
                                                    {*{show_category data=$_categories id=$k lv=$lv+1}*}
                                                {*{/if}*}
                                            {*{/foreach}*}
                                        {*{/function}*}
                                        {*{show_category data=$_categories id=0 lv=1}*}
                                    {*</select>*}
                                {*</div>*}
                            {*</div>*}
                            {*<hr>*}
                            {*<div class="form-group">*}
                                {*<label class="col-md-3 control-label"></label>*}
                                {*<div class="col-md-8">*}
                                    {*(<font color="red">*</font>如需创建新的供应商，则不要选择供应商项)*}
                                {*</div>*}
                            {*</div>*}
                            {*<div class="form-group">*}
                                {*<label class="col-md-3 control-label">请选择供应商</label>*}

                                {*<div class="col-md-7 vendor_div">*}
                                    {*<div class="col-md-12 input-group select">*}
                                        {*<input id="select2_sample6" type="hidden" class="form-control select2">*}
                                        {*<span class="vendor_msg"></span>*}
                                    {*</div>*}
                                {*</div>*}
                            {*</div>*}
                        {*</div>*}
                        {*<div class="form-actions text-center">*}
                            {*<a class="btn btn-success getCategory" href="javascript:;" id="{$_REQUEST['id']}">完善候选数据</a>*}
                            {*<a href="?action=check&handle_type=repeat&id={$_data[0]['id']}" class="btn btn-primary">标记为重复</a>*}
                            {*<a href="?action=check&handle_type=less&id={$_data[0]['id']}" class="btn btn-primary" style="background-color:#FFAA33;border: 1px solid #FFAA33">数据不完整</a>*}
                            {*<a href="?action=check&handle_type=invalid&id={$_data[0]['id']}"  class="btn btn-danger">标记为无效</a>*}
                        {*</div>*}
                    {*{/if}*}
                {*</div>*}
            {*</div>*}
        {*</div>*}



    </div>
    {*<script src="{$_assets}plugins/jquery-1.11.0.min.js" type="text/javascript"></script>*}
    {*<link rel="stylesheet" type="text/css" href="{$_assets}plugins/jquery-multi-select/css/multi-select.css"/>*}
    {*<script type="text/javascript" src="{$_assets}plugins/jquery-multi-select/js/jquery.multi-select.js"></script>*}
    {*<script type="text/javascript" src="{$_assets}plugins/select2/select2.min.js"></script>*}
    {*<!-- END PAGE LEVEL PLUGINS -->*}
    {*<!-- BEGIN PAGE LEVEL SCRIPTS -->*}
    {*<script src="{$_assets}scripts/_page.js"></script>*}
    {*<script>*}
    {*$(document).ready(function () {*}
    {*$(".tags_select2").each(function () {*}
    {*$(this).select2({*}
    {*tags: $(this).data('values').split(',')*}
    {*})*}
    {*});*}
    {*});*}
    {*</script>*}
    <!-- BEGIN CORE PLUGINS -->
</div>
</body>
<script>
    jQuery(document).ready(function () {
        $('.wysihtml5').wysihtml5();
        $(".tags_select2").each(function () {
            $(this).select2({
                tags: $(this).data('values').split(',')
            })
        });
        $('.tags').tagsInput({
            width: 'auto'
        });
        $('#my_multi_select2').multiSelect({
            selectableOptgroup: true
        });
        $('.getCategory').click(function () {
//            var category_id = $('.select2me').val();
//            var vendor_id=$('#select2_sample6').val();
            var vendorcandidate_id = $('.getCategory').attr('id');
//            var product_name=$('.product_name').val();
//            if (!category_id) {
//                return false;
//            }
//            if(!vendor_id){
                window.location.href = '?action=detail&id=' + vendorcandidate_id;
//            }
//            else if(vendor_id && !product_name){
//                $('.product_div').addClass('has-error');
//                $(".product_msg").html('<i class="glyphicon glyphicon-remove">产品名称不能为空</i>').addClass('help-block');
//                $('.vendor_div').removeClass('has-error');
//                $(".vendor_msg").html('').removeClass('help-block');
//                return false;
//
//            }else if(product_name && !vendor_id){
//                $('.vendor_div').addClass('has-error');
//                $(".vendor_msg").html('<i class="glyphicon glyphicon-remove">请选择所属供应商</i>').addClass('help-block');
//                $('.product_div').removeClass('has-error');
//                $(".product_msg").html('').removeClass('help-block');
//                return false;
//            }
            {*else{*}
                {*$.post('?',{ action:'quickCreate',id:vendorcandidate_id,vendor_id:vendor_id,category_id:category_id },function(data){*}
                    {*if(data.status!=1){*}
                        {*top.alert(data.msg);*}
                    {*}else{*}
                        {*window.location.href = '{$_route}my_vendor_list?action=detail&tab=product&id=' + data.data['account_id']+'&product_id='+data.data['product_id']+'&is_back=vendor_candidate';*}
                    {*}*}
                    {*console.log(data);*}
                {*},'json')*}
            {*}*}

        });
        $("#select2_sample6").select2({
            placeholder: "选择供应商",
            minimumInputLength: 1,
            ajax: { // instead of writing the function to execute the request we use Select2's convenient helper
                url: "?action=check&vendor_auto_complete=1",
                dataType: 'json',
                data: function (term, page) {
                    return {
                        q: term, // search term
                        page_limit: 10
                    };
                },
                results: function (data, page) { // parse the results into the format expected by Select2.
                    // since we are using custom formatting functions we do not need to alter remote JSON data
                    return {
                        results: data.items
                    };
                }
            },
            initSelection: function (element, callback) {
                var id = $(element).val();
                if (id !== "") {
                    $.ajax("?action=check&vendor_auto_complete=1", {
                        data: {
                            id: id
                        },
                        dataType: "json"
                    }).done(function (data) {
                        console.log(data);
                        callback(data.items[0]);
                    });
                }
            },
            formatResult: formatRepo, // omitted for brevity, see the source of this page
            formatSelection: formatRepoSelection, // omitted for brevity, see the source of this page
            escapeMarkup: function (m) {
                return m;
            } // we do not want to escape markup since we are displaying html in results
        });
        function formatRepo(repo) {
            if (repo.loading) return repo.text;
            return repo.full_name;
        }

        function formatRepoSelection(repo) {
            return repo.full_name || repo.text;
        }
    });
</script>
<!-- END BODY -->
</html>