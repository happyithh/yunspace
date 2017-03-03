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


{*<div class="portlet tabbable">*}
{*<div class="portlet-title">*}
{*<div class="caption">*}
{*<i class="fa fa-search"></i>搜索条件*}
{*</div>*}
{*</div>*}
{*<div class="portlet-body">*}
{*<div class="portlet-tabs">*}
{*<div class="clearfix"></div>*}
{*<div>*}
{*<form action="?" method="get" class="clearfix">*}
{*<input type="hidden" name="list_type" value="product">*}
{*<input type="hidden" name="handle_type" value="{$handle_type}">*}
{*<div class="form-body clearfix">*}
{*<div class="form-group col-md-5">*}
{*<label class="col-md-3 control-label">文创标题</label>*}

{*<div class="col-md-9">*}
{*<input type="text" class="form-control input-sm" placeholder="文创ID / 标题关键字" name="search[title]" value="{$_REQUEST['search']['title']}">*}
{*</div>*}
{*</div>*}
{*<div class="form-group col-md-5">*}
{*<label class="col-md-3 control-label">创建者</label>*}

{*<div class="col-md-9">*}
{*<input type="text" class="form-control input-sm" placeholder="创建者名称" name="search[author]" value="{$_REQUEST['search']['author']}">*}
{*</div>*}
{*</div>*}

{*<div class="form-group col-md-5">*}
{*<label class="col-md-3 control-label">状态</label>*}
{*<div class="col-md-9">*}

{*<select class="form-control input-sm" name="search[status]">*}
{*<option value=''>全部*}
{*</option>*}
{*{foreach $status as $key=>$value}*}
{*<option {if {$_REQUEST['search']['status']==$key}}selected {/if} value="{$key}">{$value}</option>*}
{*{/foreach}*}
{*</select>*}
{*</div>*}
{*</div>*}



{*<div class="form-group col-md-5">*}
{*<label class="col-md-3 control-label">创建时间</label>*}
{*<div class="col-md-4">*}
{*<input type='text' class="form-control date" placeholder="请选择开始时间" name="search[start_time]" value="{$_REQUEST['search']['start_time']}"/>*}
{*</div>*}
{*<div class="col-md-4 col-md-offset-1">*}
{*<input type='text' class="form-control date" placeholder="请选择结束时间" name="search[end_time]" value="{$_REQUEST['search']['end_time']}"/>*}
{*</div>*}
{*</div>*}
{*</div>*}
{*<div class="form-actions">*}
{*<div class="" style="text-align: center">*}
{*<button type="submit" class="btn btn-primary" style="width: 150px">*}
{*<i class="fa fa-search"></i>*}
{*搜索*}
{*</button>*}
{*</div>*}
{*</div>*}
{*</form>*}
{*</div>*}

{*</div>*}
{*</div>*}
{*</div>*}
<div class="portlet">
    <div class="portlet-title">
    </div>
    <div class="portlet-tabs" style="position:relative">
        {*<div style="position: absolute;left:10px;bottom:0px;color: #444444;font-size: 16px"><a href="?action=add" class="btn btn-success"><span class="glyphicon glyphicon-plus"></span></a></div>*}
        <div style="position: absolute;left:10px;bottom:0px;color: #bd362f;font-size: 16px">（点击“处理”按钮，等待页面程序执行完毕，并提示“处理成功”之后，方可进行下一操作） <a class="btn btn-info" style="float: right" href="?action=change_status">淘会场更新状态（临时）</a></div>
        <ul class="nav nav-tabs" style="overflow: inherit; padding-left: 100px">
            <li class="{if $handle_type=='pass'}active{/if}">
                <a href="?handle_type=pass">已处理</a>
            </li>
            <li class="{if $handle_type=='waiting'}active{/if}">
                <a href="?handle_type=waiting">待处理</a>
            </li>
        </ul>
    </div>
    <div class="portlet-body">
        <div class="table-responsive clearfix">
            <table class="table table-striped table-bordered table-hover" id="data_table" style="word-break: break-all">
                <thead>
                <tr>
                    <th>#ID</th>
                    <th>产品名称</th>
                    <th>来源网址</th>
                    {if $handle_type=='waiting'}<th>操作</th>{/if}
                </tr>
                </thead>
                <tbody>
                {foreach $data['rows'] as $key=>$value}
                    <tr>
                        <td>#{$value['id']}</td>
                        <td>{$value['product_name']}</td>
                        <td>{$value['from_where']}</td>
                        {if $handle_type=='waiting'}
                            <td><a href="?action=deal&id={$value['id']}" class="btn btn-primary btn-xs"><i class="fa fa-pencil"></i>处理</a>&nbsp;&nbsp;</td>
                        {/if}
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

<script tab="text/javascript"
        src="{$_assets}plugins/select2/select2.min.js"></script>

<script>
    ListOperator = {

        online: function (obj) {
            var status = $(obj).find('option:selected').val();
            var id =$(obj).attr('data-id');
            $.getJSON('?', {
                id: id,
                status: status,
                action:'update_status'
            }, function (data) {
                top.alert(data.msg);
            })
        },
        changeCategory: function (o) {

            var category_id = $(o).find('option:selected').val();
            var id =$(o).attr('data-id');
            if (!category_id) {
                category_id = $(o).find('td:first').val();
            }
            $.post("?", {
                id: id,
                category_id: category_id,
                action:'update_category'
            }, function (data) {
                top.alert(data.msg);
                window.location.reload();
            });
        },
//        delProductSet: function (e) {
//            if (!confirm('您确定要删除吗？？')) {
//                return false;
//            }
//        },
        updatePageView: function(id){
            $.post("?", {
                id: id,
                action: 'update_pv'
            }, function(data) {
                top.alert(data.msg);
                window.location.reload();
            });
        }
    }
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