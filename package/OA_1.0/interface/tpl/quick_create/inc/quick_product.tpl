<div class="row">
    <div class="col-md-6">
        <div class="form-group">
            <label class="control-label col-md-2">服务名称<span class="required" aria-required="true">*</span></label>

            <div class="col-md-10">
                <input type="text" class="form-control" placeholder="请输入产品名称" name="data_p[product_name]" value="{$_data['product_name']}">
            </div>
        </div>
    </div>
    <div class="col-md-6">
        <div class="form-group">
            <label class="control-label col-md-2">价格</label>

            <div class="col-md-10">
                <div class="input-group">
                    <input id="price" type="text" class="form-control" placeholder="请输入价格" name="data_p[price]" {if empty($_data['price'])}value=""{else}value="{abs($_data['price'])}{/if}">
                    <span class="input-group-addon">元/单位</span>
                    <span class="input-group-addon">
                       <input type="checkbox" name="data_p[hide_price]" value="1" {if $_data['price']<0}checked{/if}> 隐藏
                    </span>
                </div>
            </div>
        </div>
    </div>
    <div class="col-md-6">
        <div class="form-group">
            <label class="control-label col-md-2">地址</label>

            <div class="col-md-10">
                <input type="text" class="form-control" name="data_p[addr]" value="{$_data['addr']}">
            </div>
        </div>
    </div>
    <div class="col-md-6">
        <div class="form-group">
            <label class="control-label col-md-2">面积</label>

            <div class="col-md-10">
                <div class="input-group">
                    <input type="text" class="form-control" name="data_p[product_size]" value="{$_data['product_size']}">
                    <span class="input-group-addon">平方米</span>
                </div>
            </div>
        </div>
    </div>
    <div class="col-md-6">
        <div class="form-group">
            <label class="control-label col-md-2">产品类型</label>

            <div class="col-md-10">
                <input class="form-control" disabled type="text" value="{$categoryInfo[$_REQUEST['category_id']][0]}">
                <input class="form-control" type="hidden" name="data_p[category_id]" value="{$_REQUEST['category_id']}">
            </div>
        </div>
    </div>
    <div class="col-md-12">
        <div class="form-group">
            <label class="control-label col-md-1">服务描述<span class="required" aria-required="true">*</span></label>

            <div class="col-md-11">
                {include "Admin::inc/html_umeditor.tpl" name="data_p[des]" value=$_data['des'] height=200}
                {*<textarea class="form-control wysihtml5" rows="8" name="data_p[des]">{$_data['des']}</textarea>*}
            </div>
        </div>
    </div>
    <div class="col-md-12">
        {foreach $_tags_info as $key=>$value}
            <div class="form-group">
                <label class="control-label col-md-1">{$key}</label>

                <div class="col-md-11">
                    {foreach $value as $ik=>$iv}
                        <div class="input-group">
                            {*{if $iv['tags_name'] == '城市'}*}
                                {*<span style="color:#C63300">*</span>*}
                            {*{/if}*}
                                    <span class="input-group-addon">
                                        {if $iv['tags_name'] == '城市'}
                                        <span style="color:#C63300">*</span>
                                        {/if}
                                        {$iv['tags_name']}:
                                    </span>
                            <input type="text" class="form-control select2 tags_select2" name="data_p[attr_new][{$ik}]"  data-values="{implode(',',$iv['tags_value'])}">
                        </div>
                    {/foreach}
                </div>
            </div>
        {/foreach}
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
                                <input type="hidden" name="data_p[media][$$][path]">
                                <input class="form-control" type="text" name="data_p[media][$$][name]">
                            </td>
                            <td>
                                <input class="form-control select2" type="text" name="data_p[media][$$][tags]">
                                <input class="form-control" type="text" name="data_p[media][$$][video]">
                            </td>
                            <td class="btns">
                                <i class="fa fa-long-arrow-up" onclick="UploadFiles.up(this)"></i>
                                <i class="fa fa-long-arrow-down" onclick="UploadFiles.down(this)"></i>
                                <i class="fa fa-trash-o" onclick="UploadFiles.remove(this)"></i>
                            </td>
                        </tr>
                        </thead>
                        <tbody id="upload_files">
                        
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>