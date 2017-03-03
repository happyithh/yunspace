<div class="clear">
    <h3 class="form-section">
        场地百科信息
    </h3>
</div>
<div class="row">
    <div class="col-md-6">
        <div class="form-group">
            <label class="control-label col-md-2">场地百科名称<span class="required" aria-required="true">*</span></label>

            <div class="col-md-10">
                <input type="text" class="form-control" placeholder="请输入场地百科名称" name="data[space_name]" value="{$_data['space_name']}">
            </div>
        </div>
        <div class="form-group">
            <label class="control-label col-md-2">百科别名</label>

            <div class="col-md-10">
                <input type="text" class="form-control" placeholder="请输入百科别名" name="data[nickname]">
            </div>
        </div>
    </div>
    {* <div class="col-md-6">
        <div class="form-group">
            <label class="control-label col-md-2">所属公司<span class="required" aria-required="true">*</span></label>

            <div class="col-md-10">
                <input id="select2_sample6" type="hidden" class="form-control select2" name="data[company]">
            </div>
        </div>
    </div> *}
    <div class="col-md-6">
        <div class="form-group">
            <label class="control-label col-md-2">营销标题</label>

            <div class="col-md-10">
                <input type="text" class="form-control" name="data[attr][营销标题]" value="{$_data['attr']['营销标题']}">
            </div>
        </div>
    </div>
    <div class="col-md-6">
        <div class="form-group">
            <label class="control-label col-md-2">特色标签</label>

            <div class="col-md-10">
                <input type="hidden" class="form-control select2 select2_special_tags" name="data[attr][特色标签]" data-values="{$_data['attr_new']['特色标签']}" value="{$_data['attr']['特色标签']|default:$_product['attr_new']['特色标签']}">
            </div>
        </div>
    </div>
    <div class="col-md-6">
        <div class="form-group">
            <label class="control-label col-md-2">场地类型</label>

            <div class="col-md-10">
                <select class="form-control" name="data[category_id]">
                    {foreach $_categories[112] as $ck=>$cv}
                        <option {if $_data['category_id'] == $ck}selected {/if} value="{$ck}">{$cv}</option>
                    {/foreach}
                </select>
            </div>
        </div>
    </div>
    <div class="col-md-6">
        <div class="form-group">
            <label class="control-label col-md-2">场地地址</label>

            <div class="col-md-10">
                <input type="text" class="form-control" name="data[addr]" value="{$_data['addr']}">
            </div>
        </div>
    </div>
    <div class="col-md-6">
        <div class="form-group">
            <label class="control-label col-md-2">场地等级</label>

            <div class="col-md-10">
                {foreach $level as $k=>$v}
                    <label class="radio-inline">
                        <input type="radio" name="data[level]" value="{$v}" {if $v==0}checked="checked" {/if}>
                        {$k}
                    </label>
                {/foreach}
                <label class="radio-inline">
                    <span style="color:#bd362f">(*A最高，E最低，默认为C)</span>
                </label>
            </div>
        </div>
    </div>
    <div class="col-md-12">
        <div class="form-group">
            <label class="control-label col-md-1">场地描述<span class="required" aria-required="true">*</span></label>
            <div class="col-md-11">
                {include "Admin::inc/html_umeditor.tpl" name="data[des]" value=$_data['des'] height=200}
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
                        <span class="input-group-addon">
                            {$iv['tags_name']}{if $iv['tags_name'] == '城市'}
                            <span style="color:#C63300">*</span>
                            {/if}:
                        </span>
                            <input type="text" class="form-control select2 tags_attr" name="data[attr][{$ik}]"   value="{$_data['attr'][{$ik}]}" data-values="{implode(',',$iv['tags_value'])}">
                        </div>
                    {/foreach}
                </div>
            </div>
        {/foreach}
    </div>
    <div class="col-md-12">
        <div class="form-group">
            <label class="control-label col-md-1">百科banner</label>
            <div class="col-md-11">
                <div class="fileinput fileinput-new" data-provides="fileinput">
                    <div class="fileinput-new thumbnail" style="width: 200px; height: 150px;">
                        <img src="http://www.placehold.it/200x150/EFEFEF/AAAAAA&amp;text=no+image"
                             alt=""/>
                    </div>
                    <div class="fileinput-preview fileinput-exists thumbnail"
                         style="max-width: 200px; max-height: 150px;"></div>
                    <div>
                                    <span class="btn btn-default btn-file">
                                        <span class="fileinput-new">选择图片</span>
                                        <span class="fileinput-exists">重新选择</span>
                                        <input type="file" name="百科banner" accept="image/jpeg,image/png,image/gif">
                                    </span>
                        <a href="form_component.html#" class="btn btn-danger fileinput-exists"
                           data-dismiss="fileinput">移除</a>
                    </div>
                </div>
                                <span class="required" aria-required="true" style="color: #e02222">（*请上传尺寸为1920*520的图片）
                                                                </span>
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
                    {include file="Admin::inc/plupload-2.tpl"}
                    <script>
                        uploader1.onFileUploaded = function (file, path) {
                            UploadFiles2.add(file, path);
                        }
                        var UploadFiles2 = {
                            media_id: 0,
                            add: function (file, path) {
                                if (UploadFiles2.media_id < 1) {
                                    UploadFiles2.media_id = $('#upload_files2 tr').size() + 10;
                                }
                                UploadFiles2.media_id++;
                                var newFile = $('#upload_files2').parents('table').find('.hidden').clone().removeClass('hidden');
                                newFile.find('img').attr('src', path);
                                newFile.appendTo('#upload_files2');
                                newFile.find('input').each(function () {
                                    $(this).attr('name', $(this).attr('name').replace('$$', UploadFiles2.media_id));
                                });
                                newFile.find('input:eq(0)').val(path);
                                newFile.find('input:eq(1)').val(file.name);
                                newFile.find('input:eq(2)').select2({
                                    tags: UploadFiles2.tags.split(',')
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
                        <tbody id="upload_files2">
                        {foreach $_data['media'] as $k=>$v}
                            <tr>
                                <td>
                                    <img src="{$v['path']}" style="height: 80px; width: 80px; ">
                                </td>
                                <td>
                                    <input type="hidden" name="data[media][{$k}][path]" value="{$v['path']}">
                                    <input class="form-control" type="text" name="data[media][{$k}][name]"
                                           value="{$v['name']}">
                                </td>
                                <td>
                                    <input class="form-control select2 tags_select3_product" type="text"
                                           name="data[media][{$k}][tags]" value="{$v['tags']}">
                                    <input class="form-control select2 tags_select3_product" type="text"
                                           name="data[media][{$k}][video]" value="{$v['video']}">
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
    $('.select2_special_tags').each(function () {
        $(this).select2({
            tags: $(this).data('values').split(',')
        })
    }); 
</script>
