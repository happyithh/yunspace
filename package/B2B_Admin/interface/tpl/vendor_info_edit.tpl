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
    <script src="{$_assets}plugins/jquery-1.11.0.min.js" type="text/javascript"></script>
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
        <input type="hidden" name="edit_type" value="vendor">
        <input type="hidden" name="data[vendor_account_id]" value="{$_data['vendor_account_id']|default:$_REQUEST['account_id']}">
        <input type="hidden" name="url_to" value="{$_REQUEST['url_to']}">
        <input type="hidden" name="ids[0]" value="{$_REQUEST['ids'][0]}">
        <input type="hidden" name="data[admin_id]" value="{$_REQUEST['admin_id']}">

        <div class="tabbable tabbable-custom boxless" style="padding: 20px ;">
            <ul class="nav nav-tabs">
                <li class="active">
                    <a href="#tab_1" data-toggle="tab">供应商信息</a>
                </li>
                <li>
                    <a href="#tab_2" data-toggle="tab">相关图片/文档</a>
                </li>
                <li>
                    <a href="#tab_3" data-toggle="tab">联系人</a>
                </li>
                <li>
                    <a href="#tab_4" data-toggle="tab">实名认证</a>
                </li>
            </ul>
            <div class="tab-content">
                <div class="tab-pane active" id="tab_1">
                    <div class="form-body">
                        <div class="form-group">
                            <label class="col-md-3 control-label">供应商名称</label>

                            <div class="col-md-6 col-sm-12">
                                <input type="text" class="form-control" placeholder="Vendor name" name="data[vendor_name]" value="{$_data['vendor_name']}">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-3 control-label">服务范围</label>

                            <div class="col-md-6 col-sm-12">
                                <select multiple="multiple" class="multi-select" name="data[categories_id][]" id="my_multi_select2" data-placeholder="Select...">
                                    {function show_category level=0}
                                        {foreach $_categories[$id] as $k=>$v}
                                            <option value="{$k}" {if in_array($k,$_data['categories_id'])}selected="selected" {/if}>{str_repeat(' . . ', $lv)}
                                                {$k}. {$v}
                                            </option>
                                            {if $_categories[$k]}
                                                {show_category data=$_categories id=$k lv=$lv+1}
                                            {/if}
                                        {/foreach}
                                    {/function}
                                    {show_category data=$_categories id=0 lv=1}
                                </select>
                            </div>
                        </div>
                        {foreach $_vendor_attr as $kname=>$attrs}
                            {foreach $attrs as $k=>$v}
                                <div class="form-group">
                                    <label class="col-md-3 control-label">{$k}</label>

                                    <div class="col-md-6 col-sm-12">
                                        {if $v}
                                            <input type="text" class="form-control tags_select2" name="data[{$kname}][{$k}]" value="{$_data[$kname][$k]}" data-values="{implode(',',$v)}">
                                        {else}
                                            <input type="text" class="form-control" name="data[{$kname}][{$k}]" value="{$_data[$kname][$k]}">
                                        {/if}
                                    </div>
                                </div>
                            {/foreach}
                        {/foreach}
                        <div class="form-group">
                            <label class="control-label col-md-3">详细介绍</label>
                            <div class="col-md-9">
                                {*<textarea class="wysihtml5 form-control" name="data[des]" rows="6">{$_data['des']}</textarea>*}
                                {include "Admin::inc/html_umeditor.tpl" name="data[des]" value=$_data['des'] height=200}
                            </div>
                        </div>
                        {*<div class="form-group" style="display:none">*}
                            {*<label class="control-label col-md-3">后台绑定的用户ID</label>*}
                            {*<div class="col-md-9">*}
                                {*<input type="text" value="{$_REQUEST['vendorId']}" name="data[vendor_account_id]"/>*}
                            {*</div>*}
                        {*</div>*}
                    </div>
                </div>
                <div class="tab-pane" id="tab_2">
                    {include file="Admin::inc/plupload.tpl"}
                    <script>
                        uploader.onFileUploaded = function (file, path) {
                            UploadFiles.add(file, path);
                        }
                        var UploadFiles = {
                            media_id: 0,
                            add: function (file, path) {
                                if (UploadFiles.media_id < 1) {
                                    UploadFiles.media_id = $('#upload_files tr').size() + 10;
                                }
                                UploadFiles.media_id++;
                                var newFile = $('#upload_files').parents('table').find('.hidden').clone().removeClass('hidden');
                                newFile.find('img').attr('src', path);
                                newFile.appendTo('#upload_files');
                                newFile.find('input').each(function () {
                                    $(this).attr('name', $(this).attr('name').replace('$$', UploadFiles.media_id));
                                });
                                newFile.find('input:eq(0)').val(path);
                                newFile.find('input:eq(1)').val(file.name);
                                newFile.find('input:eq(2)').select2({
                                    tags: UploadFiles.tags.split(',')
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
                            },
                            tags: '@LOGO,实景图片,宣传图片'
                        };
                    </script>
                    <style>
                        .table td {
                            text-align: center !important;
                            vertical-align: middle !important;
                        }

                        .table .thumbnail {
                            margin-bottom: 0;
                        }

                        .table td img {
                            border-radius: 4px;
                        }

                        .table .btns i {
                            cursor: pointer;
                        }
                    </style>
                    <table class="table table-hover">
                        <thead>
                        <tr>
                            <th width="80">缩略图</th>
                            <th>名称</th>
                            <th width="50%">标签</th>
                            <th width="60">操作</th>
                        </tr>
                        <tr class="hidden">
                            <td>
                                <img src="" style="height: 80px; width: 80px; display: block;">
                            </td>
                            <td>
                                <input type="hidden" name="data[media][$$][path]">
                                <input class="form-control" type="text" name="data[media][$$][name]">
                            </td>
                            <td>
                                <input class="form-control select2" type="text" name="data[media][$$][tags]">
                            </td>
                            <td class="btns">
                                <i class="fa fa-long-arrow-up" onclick="UploadFiles.up(this)"></i>
                                <i class="fa fa-long-arrow-down" onclick="UploadFiles.down(this)"></i>
                                <i class="fa fa-trash-o" onclick="UploadFiles.remove(this)"></i>
                            </td>
                        </tr>
                        </thead>
                        <tbody id="upload_files">
                        {foreach $_data['media'] as $k=>$v}
                            <tr>
                                <td>
                                    <img src="{$v['path']}" style="height: 80px; width: 80px; ">
                                </td>
                                <td>
                                    <input type="hidden" name="data[media][{$k}][path]" value="{$v['path']}">
                                    <input class="form-control" type="text" name="data[media][{$k}][name]" value="{$v['name']}">
                                </td>
                                <td>
                                    <input class="form-control select2 tags_select3" type="text" name="data[media][{$k}][tags]" value="{$v['tags']}">
                                </td>
                                <td class="btns">
                                    <i class="fa fa-long-arrow-up" onclick="UploadFiles.up(this)"></i>
                                    <i class="fa fa-long-arrow-down" onclick="UploadFiles.down(this)"></i>
                                    <i class="fa fa-trash-o" onclick="UploadFiles.remove(this)"></i>
                                </td>
                            </tr>
                        {/foreach}
                        </tbody>
                    </table>
                </div>
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
<link rel="stylesheet" type="text/css" href="{$_assets}plugins/jquery-tags-input/jquery.tagsinput.css"/>
<link rel="stylesheet" type="text/css" href="{$_assets}plugins/typeahead/typeahead.css">
<link rel="stylesheet" type="text/css" href="{$_assets}plugins/bootstrap-wysihtml5/bootstrap-wysihtml5.css"/>
<script type="text/javascript" src="{$_assets}plugins/select2/select2.min.js"></script>
<script type="text/javascript" src="{$_assets}plugins/jquery-tags-input/jquery.tagsinput.min.js"></script>
<script src="{$_assets}plugins/typeahead/handlebars.min.js" type="text/javascript"></script>
<script src="{$_assets}plugins/typeahead/typeahead.bundle.min.js" type="text/javascript"></script>
<script type="text/javascript" src="{$_assets}plugins/datatables/media/js/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="{$_assets}plugins/datatables/plugins/bootstrap/dataTables.bootstrap.js"></script>
<script type="text/javascript" src="{$_assets}plugins/bootstrap-wysihtml5/wysihtml5-0.3.0.js"></script>
<script type="text/javascript" src="{$_assets}plugins/bootstrap-wysihtml5/bootstrap-wysihtml5.js"></script>
<link rel="stylesheet" type="text/css" href="{$_assets}plugins/jquery-multi-select/css/multi-select.css"/>
<script type="text/javascript" src="{$_assets}plugins/jquery-multi-select/js/jquery.multi-select.js"></script>
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
        $(".tags_select2").each(function () {
            $(this).select2({
                tags: $(this).data('values').split(',')
            })
        });

        $('#my_multi_select2').multiSelect({
            selectableOptgroup: true
        });

        $('.wysihtml5').wysihtml5();
        var typeahead_vendor = new Bloodhound({
            datumTokenizer: function (d) {
                return Bloodhound.tokenizers.whitespace(d.name);
            },
            queryTokenizer: Bloodhound.tokenizers.whitespace,
            limit: 10,
            remote: '../vendor/typeahead?query=%QUERY'
        });
        typeahead_vendor.initialize();
        $('#typeahead_vendor').typeahead(null, {
            name: 'vendor_name',
            displayKey: 'name',
            source: typeahead_vendor.ttAdapter()
        });
    });
</script>
</body>

<!-- END BODY -->
</html>