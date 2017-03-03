<!DOCTYPE html>
<!--[if IE 8]>
<html lang="en" class="ie8 no-js"> <![endif]-->
<!--[if IE 9]>
<html lang="en" class="ie9 no-js"> <![endif]-->
<!--[if !IE]><!-->
<html lang="en" class="no-js">
<!--<![endif]-->
<head>
    {include 'Web_User_Center::inc/html_head.tpl' theme='blue'}
</head>
<body>
{include 'Web_User_Center::inc/header_top.tpl' color='#0b679e'}


<div class="clearfix"></div>
<div class="page-container">
{include 'inc/header_nav.tpl' index=0}

<div class="page-content-wrapper">
<div class="page-content">
<!-- BEGIN PAGE HEADER-->
<h3 class="page-title" style="float: left;">
    {if $_REQUEST['product_id']}
        空间场地/配套服务编辑
        {if $_data['status']==2}
            <small class="label label-warning">
                您在({date('Y-m-d H:i',$_data['update_time'])}
                )提交的修改正在审核中
            </small>
        {/if}
    {else}
        新增空间场地/配套服务
    {/if}
</h3>
<a href="javascript:history.go(-1)" class="back"><
    <返回
</a>

<div class="clear"></div>
<div class="portlet">
<div class="portlet-body">
<div class="service_content">
<form class="form-horizontal" role="form" action="{$_route}product_edit/submit" method="post">
<input type="hidden" name="url_to" value="{$_REQUEST['url_to']}">
<input type="hidden" name="product_id" value="{$_REQUEST['product_id']}">

<div class="container-fluid">
<div class="row">
<div class="form-group">
    <label class="col-md-2 control-label"><b>所属供应商：</b></label>

    <div class="col-md-10">
        <select name="data[vendor_id]" class="form-control input-sm vendor_id"
                onchange="getCategory()">
            {foreach $vendorInfo as $k=>$v}
                <option data-category="{$v['categories_id']}" value="{$v['id']}"
                        {if $_data['vendor_id']==$v['id']}selected{/if}>{$v['vendor_name']}</option>
            {/foreach}
        </select>
    </div>
</div>
<div class="form-group">
    <label class="col-md-2 control-label"><b>名称：</b><span class="required"
                                                          aria-required="true">*</span></label>

    <div class="col-md-10">
        <input name="data[product_name]" value="{$_data['product_name']}"
               class="form-control input-lg" placeholder="请输入服务名称" type="text">
    </div>
</div>
<div class="form-group">
    <label class="col-md-2 control-label"><b>分类：</b></label>

    <div class="col-md-10">
        <select name="data[category_id]" class="form-control input-sm categoryType"
                onchange="Form_Attr.update(this)">
        </select>
    </div>

</div>
<div class="form-group">
    <label class="col-md-2 control-label"><b>价格：</b></label>

    <div class="col-md-3">
        <div class="input-group">
            <input id="price" name="data[price]" value="{abs($_data['price'])}"
                   class="form-control" placeholder="请填写价格" type="text">
            {*<span class="input-group-addon">元/天</span>*}
            <span class="input-group-addon">
                <input type="checkbox" name="data[attr_new][起价]" value="1" {if $_data['attr_new']['起价']}checked{/if}>起价
            </span>
            <span class="input-group-addon">
                <input type="checkbox" name="hide_price" value="1" {if $_data['price']<0}checked{/if}> 面议
            </span>
        </div>
    </div>
</div>
<div class="form-group">
    <label class="control-label col-md-2"><b>计价单位</b></label>

    <div class="col-md-3">
        {*<div class="input-group col-md-12">*}
        <input type="text" class="form-control" name="data[attr_new][计价单位]"
               placeholder='例：天、桌、人、3小时，不填写表示无单位'
               value="{$_data['attr_new']['计价单位']}">
        {*</div>*}
    </div>
</div>
<div class="form-group">
    <label class="control-label col-md-2"><b>订购数量上限/下限</b></label>

    <div class="col-md-3">
        <div class="input-group input-range">
            <input type="text" class="form-control" name="data[attr_new][计价下限]"
                   placeholder="订购数量下限"
                   value="{$_data['attr_new']['计价下限']}">
                            <span class="input-group-addon">
                            ~</span>
            <input type="text" class="form-control" name="data[attr_new][计价上限]"
                   placeholder="订购数量上限"
                   value="{$_data['attr_new']['计价上限']}">

        </div>
    </div>
</div>
<div class="form-group">
    <label class="col-md-2 control-label"><b>面积：</b></label>

    <div class="col-md-10">
        <div class="input-group">
            <input type="text" class="form-control" name="data[product_size]"
                   value="{$_data['product_size']}">
            <span class="input-group-addon">平方米</span>
        </div>
    </div>
</div>
<div class="form-group">
    <label class="col-md-2 control-label"><b>地址：</b></label>

    <div class="col-md-10">
        <input name="data[addr]" value="{$_data['addr']}" class="form-control "
               placeholder="地址" type="text">
    </div>
</div>
<div class="form-group">
    <label class="col-md-2 control-label"><b>文字介绍：</b><span class="required"
                                                            aria-required="true">*</span></label>

    <div class="col-md-10">
        {include "Admin::inc/html_umeditor.tpl" name="data[des]" value=$_data['des'] height=200}
        {*<textarea class="form-control wysihtml5" rows='5' name="data[des]">{$_data['des']}</textarea>*}
    </div>
</div>
<div id="product_attr">

</div>
<div class="form-group">
    <label class="col-md-2 control-label"><b>相关图片/视频：</b></label>

    <div class="col-md-10">
        {include file="Admin::inc/plupload.tpl" upload_url="{$_root}order_info_new/upload"}
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
            .media-table td {
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
        <table class="table table-hover media-table">
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
                    <input class="form-control" type="text"
                           name="data[media][$$][name]">
                </td>
                <td>
                    <input class="form-control select2" type="text"
                           name="data[media][$$][tags]">
                    <input class="form-control select2" type="text"
                           name="data[media][$$][video]" placeholder="请输入第三方视频地址">
                </td>
                <td class="btns">
                    <i class="fa fa-long-arrow-up"
                       onclick="UploadFiles.up(this)"></i>
                    <i class="fa fa-long-arrow-down"
                       onclick="UploadFiles.down(this)"></i>
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
                        <input type="hidden" name="data[media][{$k}][path]"
                               value="{$v['path']}">
                        <input class="form-control" type="text"
                               name="data[media][{$k}][name]" value="{$v['name']}">
                    </td>
                    <td>
                        <input class="form-control select2 tags_select3" type="text"
                               name="data[media][{$k}][tags]" value="{$v['tags']}">
                        <input class="form-control select2 tags_select3" type="text"
                               name="data[media][{$k}][video]"
                               value="{$v['video']}">
                    </td>
                    <td class="btns">
                        <i class="fa fa-long-arrow-up"
                           onclick="UploadFiles.up(this)"></i>
                        <i class="fa fa-long-arrow-down"
                           onclick="UploadFiles.down(this)"></i>
                        <i class="fa fa-trash-o"
                           onclick="UploadFiles.remove(this)"></i>
                    </td>
                </tr>
            {/foreach}
            </tbody>
        </table>
    </div>

</div>

</div>
<div class="form-actions text-center hidden">
    <button type="reset" class="btn btn-default">
        重置
    </button>
    <button type="submit" class="btn btn-success">
        提交
    </button>

        <a href="{$_root}service_info/{md5($_data['id'])}/{$_data['id']}.html"
           target="_blank">
            <button type="button" class="btn btn-success">
                预览
            </button>
        </a>

    {*{else}*}
    {*<a href="{$_root}service_info/{$_data['id']}.html" target="_blank"><button type="button" class="btn btn-success">*}
    {*预览*}
    {*</button></a>*}
    {*{/if}*}
</div>
</form>
</div>
</div>

<!-- END BUTTONS PORTLET-->
</div>
</div>


</div>
</div>
</div>
{include 'Web_User_Center::inc/footer_script.tpl'}
{include 'Web_User_Center::inc/html_form.tpl'}
{include 'Web_User_Center::inc/footer_inbox.tpl'}
<script>
    jQuery(document).ready(function () {
        {foreach $_data['attr_new'] as $k=>$v}
        $('#product_attr').data('{$k}', '{$v}');
        {/foreach}
        getCategory();
        Form_Attr.update('.categoryType');
        $(".tags_select3").each(function () {
            $(this).select2({
                tags: UploadFiles.tags.split(',')
            })
        });
    });
    function getCategory() {
        $('.categoryType').html('');
        var init_category_id = "{$_data['category_id']}";
        if (!init_category_id) {
            init_category_id = '';
        }
        $.post("{$_route}product_edit/get_vendor_categories", {
            vendor_id: $('.vendor_id').val()
        }, function (data) {
            if (data != 'error') {
                for (var a in data) {
                    var $opt = $('<optgroup label="' + a + '"></optgroup>');
                    $opt.appendTo('.categoryType');
                    for (var b in data[a]) {
                        if (b == init_category_id) {
                            var $op = $('<option value="' + b + '"  selected>' + data[a][b] + '</option>');
                        } else {
                            var $op = $('<option value="' + b + '">' + data[a][b] + '</option>');
                        }
                        $op.appendTo($opt);
                    }
                }
                $('.form-actions').removeClass('hidden');
                Form_Attr.update('.categoryType');
            }
        }, 'json')
    }
    var Form_Attr = {
        update: function (o) {
            var category_id = $(o).find('option:selected').val();
            if (!category_id) {
                category_id = $(o).find('option:first').val();
            }
            $(o).val(category_id);
            $.getJSON("{$_route}product_edit/get_category_attr?category_attr=1&category_id=" + category_id + "&format=json&jsoncallback=?", function (data) {
                $('#product_attr').empty();
                $.each(data, function (i, item) {
                    var div1 = $('<div class="form-group col-md-12">');
                    var label = $('<label class="col-md-2 control-label"><b>' + i + ':</b></label>');
                    var div2 = $('<div class="col-md-6">');
                    $.each(item, function (a, b) {
                        var val = $('#product_attr').data(a);
                        if (!val) {
                            val = '';
                        }
                        if ($.trim(b.tags_name)) {
                            if (b.tags_name == '城市') {
                                b.tags_name = "<span style='color:#C63300'>*</span>" + b.tags_name;
                            }
                            $('<div class="input-group">' +
                            '<span class="input-group-addon">' + b.tags_name + '</span>' +
                            '<input type="text" class="form-control select2 tags_select2" name="data[attr_new][' + a + ']" value="' + val + '" data-name="' + b.tags_name + '"  data-values="' + b.tags_value + '">' +
                            '</div>').appendTo(div2);
                        }

                    })
                    label.appendTo(div1);
                    div2.appendTo(div1);
                    div1.appendTo('#product_attr');
                });

                $(".tags_select2").each(function () {
                    $('#product_attr').data($(this).data('parent_name'), $(this).val());
//                    if (!$(this).data('values')) {
//                        return;
//                    }
                    var temp = '' + $(this).data('values');
                    $(this).select2({
                        tags: temp.split(',')
                    })
                });
            });
        }
    }

    $('.wysihtml5').wysihtml5();
</script>
</body>
</html>