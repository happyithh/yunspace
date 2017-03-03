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
    {include 'inc/header_nav.tpl' index=4}

    <div class="page-content-wrapper">
        <div class="page-content">
            <!-- BEGIN PAGE HEADER-->
            <h3 class="page-title">
                产品管理
            </h3>

            <div class="portlet">
                <div class="portlet-body">
                    <form class="form-horizontal" role="form" action="?" method="post">
                        <input type="hidden" name="is_submit" value="1">

                        <div class="tabbable tabbable-custom boxless" style="padding: 20px ;">
                            <div class="cols-md-3">
                                批量提交产品说明文档：
                            </div>
                            {include file="Admin::inc/plupload.tpl" upload_url="{$_root}order_info/upload"}
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
                            <table class="table table-hover">
                                <thead>
                                <tr>
                                    <th width="80">#</th>
                                    <th>标题</th>
                                    <th width="50%">备注
                                    </th>
                                    <th width="60">操作</th>
                                </tr>
                                <tr class="hidden">
                                    <td>
                                        <i class="fa fa-file"></i>
                                    </td>
                                    <td>
                                        <input type="hidden" name="data[media][$$][path]">
                                        <input class="form-control" type="text" name="data[media][$$][title]">
                                    </td>
                                    <td>
                                        <input class="form-control" type="text" name="data[media][$$][memo]">
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
                                            <input class="form-control" type="text" name="data[media][{$k}][memo]" value="{$v['memo']}">
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
                        <div class="form-actions text-center">
                            <button type="reset" class="btn btn-default">
                                重置
                            </button>
                            <button type="submit" class="btn btn-success">
                                提交
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>


    </div>
</div>
</div>
{include 'Web_User_Center::inc/footer_inbox.tpl'}
{include 'Web_User_Center::inc/footer_script.tpl'}

</body>
</html>