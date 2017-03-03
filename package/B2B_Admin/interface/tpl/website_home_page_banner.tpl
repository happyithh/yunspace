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
        <i class="fa fa-database"></i>Banner管理
    </div>
</div>
<div class="portlet-body form">
    <form class="form-horizontal" role="form" action="?" method="post">
        <input type="hidden" name="city" value="{$_REQUEST['city']}">

        <div class="tabbable tabbable-custom boxless" style="padding: 20px ;">
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
                function changeCity(o) {
                    var href = window.location.href + '?';
                    window.location = href.substr(0, href.indexOf('?')) + '?city=' + $(o).val() + '&t=' + (new Date()).valueOf();
                }
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
            <div class="cols-md-3">
                对应城市首页:
                <select class="form-control" name="city" onchange="changeCity(this)">
                    {foreach $_REQUEST['cities'] as $v}
                        <option value="{$v}" {if $v==$_REQUEST['city']}selected="selected" {/if}>
                            {$v}
                        </option>
                    {/foreach}
                </select>
            </div>
            <table class="table table-hover">
                <thead>
                <tr>
                    <th width="80">缩略图</th>
                    <th>标题</th>
                    <th width="50%">指向链接</th>
                    <th width="60">操作</th>
                </tr>
                <tr class="hidden">
                    <td>
                        <img src="" style="height: 80px; width: 80px; display: block;">
                    </td>
                    <td>
                        <input type="hidden" name="data[media][$$][path]">
                        <input class="form-control" type="text" name="data[media][$$][title]">
                    </td>
                    <td>
                        <input class="form-control" type="text" name="data[media][$$][url]">
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
                            <input class="form-control" type="text" name="data[media][{$k}][title]" value="{$v['title']}">
                        </td>
                        <td>
                            <input class="form-control" type="text" name="data[media][{$k}][url]" value="{$v['url']}">
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
        <div class="portlet ">

            <div class="portlet-title">
                <div class="caption">
                    <i class="fa fa-reorder"></i>其他内容管理(以下内容都放链接，每条链接一行)
                </div>
            </div>
            <div class="class="tabbable tabbable-custom boxless" style="padding: 20px ;"">
                <div class="form-group">

                    <label class="col-md-3 control-label">热门空间</label>
                    <div class="col-md-6">
                        <textarea class="form-control" rows="4"  name="data[hotContent][热门空间]">{$_data2['hotContent']['热门空间']}</textarea>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-3 control-label">最新空间</label>
                    <div class="col-md-6">
                        <textarea class="form-control" rows="4"  name="data[hotContent][最新空间]">{$_data2['hotContent']['最新空间']}</textarea>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-3 control-label">热门空间预定</label>
                    <div class="col-md-6">
                        <textarea class="form-control" rows="4"  name="data[hotContent][热门空间预定]">{$_data2['hotContent']['热门空间预定']}</textarea>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-3 control-label">热门场地搭建</label>
                    <div class="col-md-6">
                        <textarea class="form-control" rows="4"  name="data[hotContent][热门场地搭建]">{$_data2['hotContent']['热门场地搭建']}</textarea>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-3 control-label">热门商场</label>
                    <div class="col-md-6">
                         <textarea class="form-control" rows="4"  name="data[hotContent][热门商场]">{$_data2['hotContent']['热门商场']}</textarea>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-3 control-label">热门秀场</label>
                    <div class="col-md-6">
                        <textarea class="form-control" rows="4"  name="data[hotContent][热门秀场]">{$_data2['hotContent']['热门秀场']}</textarea>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-3 control-label">热门新奇场地</label>
                    <div class="col-md-6">
                        <textarea class="form-control" rows="4"  name="data[hotContent][热门新奇场地]">{$_data2['hotContent']['热门新奇场地']}</textarea>
                    </div>
                </div>
                {*<div class="form-group">*}
                    {*<label class="col-md-3 control-label">热门活动案例</label>*}
                    {*<div class="col-md-6">*}
                        {*<textarea class="form-control" rows="4"  name="data[hotContent][热门活动案例]">{$_data2['hotContent']['热门活动案例']}</textarea>*}
                    {*</div>*}
                {*</div>*}
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