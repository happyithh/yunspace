<h3>联系人信息</h3>
<div class="row">
    <div class="col-md-6">
        <div class="form-group">
            <label class="control-label col-md-2">联系人名称</label>

            <div class="col-md-10">
                <input type="text" class="form-control" placeholder="请输入联系人名称" name="data_i[contacts]" value="">
            </div>
        </div>
    </div>
    <div class="col-md-6">
        <div class="form-group">
            <label class="control-label col-md-2">联系人手机号</label>

            <div class="col-md-10">
                <input type="text" class="form-control" placeholder="请输入联系人手机号" name="data_i[phone]" value="">
            </div>
        </div>
    </div>
    <div class="col-md-6">
        <div class="form-group">
            <label class="control-label col-md-2">联系人邮箱</label>

            <div class="col-md-10">
                <input type="text" class="form-control" placeholder="请输入联系人邮箱" name="data_i[email]" value="">
            </div>
        </div>
    </div>
</div>
<hr/>
<h3>子空间信息</h3>
<div class="row">
<div class="col-md-6">
    <div class="form-group">
        <label class="control-label col-md-2">百科名称</label>

        <div class="col-md-10">
            <input value="{$_data['space_name']}" class="form-control" type="text" disabled>
        </div>
    </div>
</div>
<div class="col-md-6">
    <div class="form-group">
        <label class="control-label col-md-2">子空间名称<span class="required" aria-required="true">*</span></label>

        <div class="col-md-10">
            <input type="text" class="form-control" placeholder="请输入子空间名称" name="data_i[item_name]" value="{$_product['product_name']}">
        </div>
    </div>
</div>
{*<div class="col-md-6">*}
    {*<div class="form-group">*}
        {*<label class="control-label col-md-2">子空间地址</label>*}

        {*<div class="col-md-10">*}
            {*<input type="text" class="form-control" name="data_i[addr]" value="{$_product['addr']}">*}
        {*</div>*}
    {*</div>*}
{*</div>*}
<div class="col-md-6">
    <div class="form-group">
        <label class="control-label col-md-2">面积</label>

        <div class="col-md-10">
            <div class="input-group input-range">
                <input type="text" class="form-control" name="data_i[size]" value="{$_product['product_size']}">
                <span class="input-group-addon">m²</span>
            </div>
        </div>
    </div>
</div>
<div class="col-md-6">
    <div class="form-group">
        <label class="control-label col-md-2">价格区间</label>

        <div class="col-md-10">
            <div class="input-group input-range">
                <input  type="text" class="form-control" name="data_i[min_price]" placeholder="最低价"
                        value="{$_product['price']}">
                                <span class="input-group-addon">
                                ~</span>
                <input type="text" class="form-control" name="data_i[max_price]" placeholder="最高价"
                       value="{$_product['price']}">
                 <span class="input-group-addon">
                                单位</span>
                <input type="text" class="form-control" name="data_i[price_unit]"
                       value="{$_product['attr_new']['计价单位']}">

            </div>
        </div>
    </div>
</div>
<div class="col-md-6">
    <div class="form-group">
        <label class="control-label col-md-2">人数范围</label>

        <div class="col-md-10">
            <div class="input-group input-range">
                <input  type="text" class="form-control" name="data_i[min_people]" placeholder="最小人数"
                        >
                                <span class="input-group-addon">
                                ~</span>
                <input type="text" class="form-control" name="data_i[max_people]" placeholder="最大人数"
                        >
            </div>
        </div>
    </div>
</div>
<div class="col-md-6">
    <div class="form-group">
        <label class="control-label col-md-2">子空间标签</label>

        <div class="col-md-10">
            <input type="hidden" class="form-control select2 select2_item_tags" name="data_i[tags]" data-values="{implode(',',$tag_value)}">
            {*<input type="hidden" class="form-control select2 select2_item_tags" name="data_i[tags]" data-values="{implode(',',$space_item['tags'])}">*}
        </div>
    </div>
</div>
<div class="col-md-12">
    <div class="form-group">
        <label class="control-label col-md-1">子空间描述</label>
        <div class="col-md-11">
            {include "Admin::inc/html_umeditor.tpl" name="data_i[des]" value="{$_product['des']}" height=200}
        </div>
    </div>
</div>

<div class="col-md-12">
    <div class="tabbable tabbable-custom boxless" style="padding: 20px ;">
        <ul class="nav nav-tabs">
            <li class="active">
                <a href="form_image_crop.html#tab_2" data-toggle="tab">图片/视频</a>
            </li>
        </ul>
        <div class="tab-content">
            <!--      ---------------------------图片/视频  start-------------------------------      -->
            <div class="tab-pane active">
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

                    .table1 td {
                        padding: 5px;
                    }

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
                            <input type="hidden" name="data_i[media][$$][path]">
                            <input class="form-control" type="text" name="data_i[media][$$][name]">
                        </td>
                        <td>
                            <input class="form-control select2" type="text" name="data_i[media][$$][tags]">
                            <input class="form-control" type="text" name="data_i[media][$$][video]">
                        </td>
                        <td class="btns">
                            <i class="fa fa-long-arrow-up" onclick="UploadFiles.up(this)"></i>
                            <i class="fa fa-long-arrow-down" onclick="UploadFiles.down(this)"></i>
                            <i class="fa fa-trash-o" onclick="UploadFiles.remove(this)"></i>
                        </td>
                    </tr>
                    </thead>
                    <tbody id="upload_files">
                    {foreach $_product['media'] as $k=>$v}
                        <tr>
                            <td>
                                <img src="{$v['path']}" style="height: 80px; width: 80px; ">
                            </td>
                            <td>
                                <input type="hidden" name="data_i[media][{$k}][path]" value="{$v['path']}">
                                <input class="form-control" type="text" name="data_i[media][{$k}][name]"
                                       value="{$v['name']}">
                            </td>
                            <td>
                                <input class="form-control select2 tags_select3_product" type="text"
                                       name="data_i[media][{$k}][tags]" value="{$v['tags']}">
                                <input class="form-control select2 tags_select3_product" type="text"
                                       name="data_i[media][{$k}][video]" value="{$v['video']}">
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
</div>
</div>
<script>
    $(".select2_item_tags").each(function () {
        $(this).select2({
            tags: $(this).data('values').split(',')
        })
    });
</script>
