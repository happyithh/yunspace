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
    <link rel="stylesheet" type="text/css" href="{$_assets}plugins/jquery-tags-input/jquery.tagsinput.css"/>
</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->
<body style="background:#FaFaFa !important">

<div class="portlet tabbable">
    <div class="portlet-title">
        <div class="caption">
            <i class="fa fa-database"></i>{$_table['name']}
        </div>
    </div>
    <div class="portlet-body form">
        <form class="form-horizontal" role="form" action="?" method="post">
            <input type="hidden" name="action" value="{if $_REQUEST['ids']}update{else}insert{/if}">
            <input type="hidden" name="url_to" value="{$_REQUEST['url_to']}">
            <input type="hidden" name="ids[0]" value="{$_REQUEST['ids'][0]}">

            <div class="form-body">
                <div class="form-group">
                    <label class="col-md-3 control-label">上级分类</label>

                    <div class="col-md-6 col-sm-12">
                        <select class="form-control select2me" data-placeholder="Select..." name="data[parent_id]">
                            <option value="0">顶级
                            </option>
                            {function show_category level=0}
                                {foreach $_categories[$id] as $k=>$v}
                                    <option value="{$k}" {if $k==$_data['parent_id']}selected="selected" {/if} {if $k==$_REQUEST['ids'][0]}disabled="disabled" {/if}>{str_repeat(' . . ', $lv)}
                                        {$v}
                                    </option>
                                    {if $_categories[$k]&&$k!=$_REQUEST['ids'][0]}
                                        {*{show_category data=$_categories id=$k lv=$lv+1}*}
                                    {/if}
                                {/foreach}
                            {/function}
                            {show_category data=$_categories id=0 lv=1}
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-3 control-label">分类名</label>

                    <div class="col-md-6 col-sm-12">
                        <input type="text" class="form-control" placeholder="Category Name" name="data[category_name]" value="{$_data['category_name']}">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-3 control-label">排序优先级</label>

                    <div class="col-md-3 col-sm-12">
                        <input type="text" class="form-control" placeholder="Sort" name="data[sort_weight]" value="{$_data['sort_weight']}">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-3 control-label">标签</label>
                    <div class="col-md-9 col-sm-12">
                        {foreach $_tags_tree[0] as $tk=>$tv}
                            {if $tv eq ''}
                                {assign var="v" value="`$_tags_info[$tk]['tags_name']`"}
                            {/if}
                            <div class="row portlet col-md-9">
                                <div class="portlet-title" style="margin-bottom: 10px;">
                                    <div class="caption">
                                        <i class="fa fa-database"></i><strong>{$tv}</strong>
                                    </div>
                                </div>
                                {foreach $_tags_info as $ik=>$iv}
                                {if $iv['parent_id'] eq $tk}
                                <div class="col-md-9">
                                    <label class="col-md-3 control-label">{$iv['tags_name']}</label>
                                    <input type="checkbox" name="data[tags_info][{$iv['id']}][select]" value="1" {if $_data['tags_info'][{$iv['id']}]['select']==1}checked {/if}>选择
                                    <input type="checkbox" value="1" name="data[tags_info][{$iv['id']}][search]" {if $_data['tags_info'][{$iv['id']}]['search']==1}checked {/if}>可搜索
                                    <input type="checkbox" value="1" name="data[tags_info][{$iv['id']}][hide]" {if $_data['tags_info'][{$iv['id']}]['hide']==1}checked {/if}>隐藏
                                    {*<div class="col-md-9 radio-list" style="border: 1px solid #EEEEEE;margin-bottom: 10px;">*}
                                        {*{if $iv['tags_value']}*}
                                            {*{foreach $iv['tags_value'] as $vk=>$vv}*}
                                                {*{if $iv['tags_type']==0}*}
                                                    {*<label class="col-md-5 control-label">*}
                                                        {*<input class="form-control"  type="radio" name="data[tags_info][{$iv['tags_name']}][tags_value][]" value="{$vv}">{$vv}*}
                                                    {*</label>*}
                                                {*{elseif $iv['tags_type']==1}*}
                                                    {*<label class="col-md-5 control-label">{$vv}*}
                                                        {*<input class="form-control" type="checkbox" name="data[tags_info][{$iv['tags_name']}][tags_value][]" value="{$vv}">*}
                                                    {*</label>*}
                                                {*{/if}*}
                                            {*{/foreach}*}
                                        {*{/if}*}
                                    {*</div>*}
                                </div>
                                {/if}
                                {/foreach}
                            </div>
                        {/foreach}
                    </div>

                        {*<table class="table table-hover">*}
                            {*<thead>*}
                            {*<tr>*}
                                {*<th width="30%">属性集>名</th>*}
                                {*<th>预设值</th>*}
                                {*<th width="42">多选</th>*}
                                {*<th width="42">操作</th>*}
                            {*</tr>*}
                            {*<tr class="hidden">*}
                                {*<td>*}
                                    {*<input class="form-control" type="text" name="data[attr_info][$$][name]">*}
                                {*</td>*}
                                {*<td>*}
                                    {*<input type="text" class="form-control" name="data[attr_info][$$][values]"/>*}
                                {*</td>*}
                                {*<td class="btns">*}
                                    {*<input type="checkbox" value="1" name="data[attr_info][$$][option]">*}
                                {*</td>*}
                                {*<td class="btns">*}
                                    {*<i class="fa fa-long-arrow-up" onclick="FormAttr.up(this)"></i>*}
                                    {*<i class="fa fa-long-arrow-down" onclick="FormAttr.down(this)"></i>*}
                                    {*<i class="fa fa-trash-o" onclick="FormAttr.remove(this)"></i>*}
                                {*</td>*}
                            {*</tr>*}
                            {*</thead>*}
                            {*<tbody id="form_attr">*}
                            {*{foreach $_data['attr_info'] as $k=>$v}*}
                                {*<tr>*}
                                    {*<td>*}
                                        {*<input class="form-control" type="text" name="data[attr_info][{$k}][name]" value="{$v['name']}">*}
                                    {*</td>*}
                                    {*<td>*}
                                        {*<input type="text" class="form-control tags" name="data[attr_info][{$k}][values]" value="{$v['values']}">*}
                                    {*</td>*}
                                    {*<td class="btns">*}
                                        {*<input type="checkbox" value="1" name="data[attr_info][{$k}][multi]" {if $v['multi']}checked="checked" {/if}>*}
                                    {*</td>*}
                                    {*<td class="btns">*}
                                        {*<i class="fa fa-long-arrow-up" onclick="FormAttr.up(this)"></i>*}
                                        {*<i class="fa fa-long-arrow-down" onclick="FormAttr.down(this)"></i>*}
                                        {*<i class="fa fa-trash-o" onclick="FormAttr.remove(this)"></i>*}
                                    {*</td>*}
                                {*</tr>*}
                            {*{/foreach}*}
                            {*</tbody>*}
                            {*<tr>*}
                                {*<td colspan="4">*}
                                    {*<a style="width: 100%; text-align: center; display: block; cursor: pointer" onclick="FormAttr.add(this)">*}
                                        {*<i class="fa fa-plus"></i>*}
                                        {*添加*}
                                    {*</a>*}
                                {*</td>*}
                            {*</tr>*}
                        {*</table>*}
                </div>

            </div>
            <div class="form-actions text-center">
                <button type=" reset" class="btn btn-default">
                    重置
                </button>
                <button type="submit" class="btn btn-success">
                    提交
                </button>
            </div>
        </form>
    </div>

    <!-- BEGIN JAVASCRIPTS(Load javascripts at bottom, this will reduce page load time) -->
    <!-- BEGIN CORE PLUGINS -->
    <script src="{$_assets}plugins/jquery-1.11.0.min.js" type="text/javascript"></script>
    <script src="{$_assets}plugins/jquery-migrate-1.2.1.min.js" type="text/javascript"></script>
    <!-- IMPORTANT! Load jquery-ui-1.10.3.custom.min.js before bootstrap.min.js to fix bootstrap tooltip conflict with jquery ui tooltip -->
    <script src="{$_assets}plugins/jquery-ui/jquery-ui-1.10.3.custom.min.js" type="text/javascript"></script>
    <script src="{$_assets}plugins/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
    <script src="{$_assets}plugins/bootstrap-hover-dropdown/bootstrap-hover-dropdown.min.js"
            type="text/javascript"></script>
    <script src="{$_assets}plugins/jquery-slimscroll/jquery.slimscroll.min.js" type="text/javascript"></script>
    <script src="{$_assets}plugins/jquery.blockui.min.js" type="text/javascript"></script>
    <script src="{$_assets}plugins/uniform/jquery.uniform.min.js" type="text/javascript"></script>
    <!-- END CORE PLUGINS -->
    <!-- BEGIN PAGE LEVEL PLUGINS -->
    <script type="text/javascript" src="{$_assets}plugins/select2/select2.min.js"></script>
    <script type="text/javascript" src="{$_assets}plugins/jquery-tags-input/jquery.tagsinput.min.js"></script>
    <script type="text/javascript" src="{$_assets}plugins/datatables/media/js/jquery.dataTables.min.js"></script>
    <script type="text/javascript" src="{$_assets}plugins/datatables/plugins/bootstrap/dataTables.bootstrap.js"></script>
    <!-- END PAGE LEVEL PLUGINS -->
    <!-- BEGIN PAGE LEVEL SCRIPTS -->
    <script src="{$_assets}scripts/app.js"></script>
    <script src="{$_assets}scripts/_page.js"></script>
    <script>
        jQuery(document).ready(function () {
            App.init();
            $('.tags').tagsInput({
                width: 'auto'
            });
        });
        var FormAttr = {
            attr_id: 0,
            add: function (o) {
                if (FormAttr.attr_id < 1) {
                    FormAttr.attr_id = $('#form_attr tr').size() + 10;
                }
                FormAttr.attr_id++;
                var newAttr = $(o).parents('table').find('.hidden').clone().removeClass('hidden');
                newAttr.appendTo('#form_attr');
                newAttr.find('input').each(function () {
                    $(this).attr('name', $(this).attr('name').replace('$$', FormAttr.attr_id));
                });
                newAttr.find('input:eq(1)').tagsInput({
                    width: 'auto'
                });
            },
            remove: function (o) {
                $(o).parents('tr').remove();
            },
            up: function (o) {
                var tr = $(o).parents('tr');
                tr.after(tr.prev());
            },
            down: function (o) {
                var tr = $(o).parents('tr');
                tr.before(tr.next());
            }
        };
    </script>
</body>

<!-- END BODY -->
</html>