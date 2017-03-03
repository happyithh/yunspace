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
<input type="hidden" name="url_to" value="{$_REQUEST['url_to']}">
<input type="hidden" name="ids[0]" value="{$_REQUEST['ids'][0]}">
<input type="hidden" name="edit_type" value="product">

<div class="tabbable tabbable-custom boxless" style="padding: 20px ;">
    <ul class="nav nav-tabs">
        <li class="active">
            <a href="form_image_crop.html#tab_1" data-toggle="tab">产品信息</a>
        </li>
        <li>
            <a href="form_image_crop.html#tab_2" data-toggle="tab">相关图片/文档</a>
        </li>
    </ul>
    <div class="tab-content">
        <div class="tab-pane active" id="tab_1">
            <div class="form-body">
                <div class="form-group">
                    <label class="col-md-3 control-label">产品标题</label>

                    <div class="col-md-6 col-sm-12">
                        <input type="text" class="form-control" placeholder="Title" name="data[product_name]" value="{$_data['product_name']}">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-3 control-label">供应商</label>

                    <div class="col-md-6 col-sm-12 select">
                        <input type="hidden" id="select2_sample6" class="form-control select2" name="data[vendor_id]" value="{$_data['vendor_id']|default:$_REQUEST['vendor_id']}">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-3 control-label">参考价格</label>

                    <div class="col-md-6 col-sm-12">
                        <input type="text" class="form-control" placeholder="Price" name="data[price]" value="{$_data['price']}">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-3 control-label">地址</label>

                    <div class="col-md-6 col-sm-12">
                        <input type="text" class="form-control" placeholder="Addr" name="data[addr]" value="{$_data['addr']}">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-3 control-label">产品分类</label>

                    <div class="col-md-6 col-sm-12">
                        <select class="form-control select2me" name="data[category_id]" style="width: 100%!important" data-placeholder="Select..." onchange="Form_Attr.update(this)">
                            {function show_category level=0}
                                {foreach $_categories[$id] as $k=>$v}
                                    {if $v||$k==$_data['category_id']}
                                    <option value="{$k}" {if $k==$_data['category_id']}selected="selected" {/if}>{str_repeat(' . . ', $lv)}
                                        {$k}. {$v}
                                    </option>
                                    {if $_categories[$k]}
                                        {show_category data=$_categories id=$k lv=$lv+1}
                                    {/if}
                                    {/if}
                                {/foreach}
                            {/function}
                            {show_category data=$_categories id=0 lv=1}
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-3 control-label">产品属性</label>
                    <style>
                        .input-group {
                            margin-bottom: 2px;
                        }
                    </style>
                    <div class="col-md-6 col-sm-12" id="product_attr">
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-md-3">产品介绍</label>

                    <div class="col-md-9">
                        {*<textarea class="wysihtml5 form-control" rows="8" name="data[des]">{$_data['des']}</textarea>*}
                        {include "Admin::inc/html_umeditor.tpl" name="data[des]" value=$_data['des'] height=200}
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-md-3">补充备注</label>

                    <div class="col-md-9">
                        <textarea class=" form-control" rows="8" name="data[memo]">{$_data['memo']}</textarea>
                    </div>
                </div>
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
                    tags: '@主图,外景图片,内景图片,平面图,视频'
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
                        <input class="form-control" type="text" name="data[media][$$][video]">
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
                            <input class="form-control" type="text" name="data[media][{$k}][video]" value="{$v['video']}">
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
{*<link rel="stylesheet" type="text/css" href="{$_assets}plugins/select2/select2.css"/>*}
<script type="text/javascript" src="{$_assets}plugins/select2/select2.min.js"></script>
<script type="text/javascript" src="{$_assets}plugins/jquery-tags-input/jquery.tagsinput.min.js"></script>
<script src="{$_assets}plugins/typeahead/handlebars.min.js" type="text/javascript"></script>
<script src="{$_assets}plugins/typeahead/typeahead.bundle.min.js" type="text/javascript"></script>
<script type="text/javascript" src="{$_assets}plugins/datatables/media/js/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="{$_assets}plugins/datatables/plugins/bootstrap/dataTables.bootstrap.js"></script>
<script type="text/javascript" src="{$_assets}plugins/bootstrap-wysihtml5/wysihtml5-0.3.0.js"></script>
<script type="text/javascript" src="{$_assets}plugins/bootstrap-wysihtml5/bootstrap-wysihtml5.js"></script>
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
        $("#select2_sample6").select2({
            placeholder: "选择供应商",
            minimumInputLength: 1,
            ajax: { // instead of writing the function to execute the request we use Select2's convenient helper
                url: "{$_route}list?vendor_auto_complete=1",
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
                    $.ajax("{$_route}list?vendor_auto_complete=1", {
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
        $(".tags_select3").each(function () {
            $(this).select2({
                tags: UploadFiles.tags.split(',')
            })
        });
        {foreach $_data['attr'] as $k=>$v}
        $('#product_attr').data('{$k}', '{$v}');
        {/foreach}
        Form_Attr.update('.select2me');
        $('.wysihtml5').wysihtml5();
    });
    var Form_Attr = {
        update: function (o) {
            var category_id = $(o).find('option:selected').val();
            if (!category_id) {
                category_id = $(o).find('option:first').val();
            }
            $.getJSON("{$_route}list?category_attr=1&category_id=" + category_id + "&format=json&jsoncallback=?", function (data) {
                console.log(data);
                $('#product_attr').empty();
                $.each(data, function (i, item) {
                    var val = $('#product_attr').data(item.name);
                    if (!val) {
                        val = '';
                    }
                    if ($.trim(item.name)) {
                        $('<div class="input-group"> <span class="input-group-addon">' + item.name + ':  </span>  <input type="text" class="form-control select2 tags_select2" name="data[attr][' + item.name + ']" value="' + val + '" data-name="' + item.name + '" data-values="' + item.values + '"> </div>')
                                .appendTo('#product_attr');
                    }
                });
                $(".tags_select2").each(function () {
                    $('#product_attr').data($(this).data('name'), $(this).val());
                    $(this).change(function () {
                        $('#product_attr').data($(this).data('name'), $(this).val());
                    }).select2({
                        tags: $(this).data('values').split(',')
                    })
                });
            });
        }
    }


    function formatRepo(repo) {
        if (repo.loading) return repo.text;
        return repo.full_name;
    }

    function formatRepoSelection(repo) {
        return repo.full_name || repo.text;
    }

</script>
</body>

<!-- END BODY -->
</html>