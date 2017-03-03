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
    {if $_data['event_id']}
    活动案例编辑
    {if $_data['status']==2}
        <small class="label label-warning">
            您在({date('Y-m-d H:i',$_data['update_time'])}
            )提交的修改正在审核中
        </small>
    {/if}
    {else}
        添加活动案例
    {/if}
</h3>
<a href="javascript:history.go(-1)" class="back"><
    <返回
</a>

<div class="clear"></div>
<div class="portlet">
<div class="portlet-body">
    <div>
        <div class="service_content">
            <form class="form-horizontal" action="{$_route}case_edit/submit" method="post">
                <input type="hidden" name="product_id" value="{$_REQUEST['product_id']}">
                <input type="hidden" name="set_id" value="{$_REQUEST['set_id']}">
                <input type="hidden" name="case_id" value="{$_REQUEST['case_id']}">
                <input type="hidden" name="vendor_id" value="{$_REQUEST['vendor_id']}">

                <div class="container-fluid">
                    <div class="row">
                        <div class="form-group" style="height: auto; padding: 10px 0px;">
                            <label class="col-md-2 control-label"><b>活动名称：</b></label>

                            <div class="col-md-10">
                                <input name="data[event_name]" data-provide="typeahead" class="form-control input-lg" id="caseName" type="text" value="{$_data['event_name']}">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-2 control-label"><b>活动类型：</b></label>

                            <div class="col-md-10">
                                <input name="data[attr][活动类型]" value="{$_data['attr']['活动类型']}" data-values="{implode(',',$_attrs['活动类型'])}" class="form-control select2 tags_select2" type="text">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-2 control-label"><b>行业：</b></label>

                            <div class="col-md-10">
                                <input name="data[attr][服务行业]" value="{$_data['attr']['服务行业']}" data-values="{implode(',',$_attrs['服务行业'])}" class="form-control select2 tags_select2" type="text">
                            </div>
                        </div>
                        <div class="form-group" style="height: auto; overflow: hidden;">
                            <label class="col-md-2 control-label"><b>相关服务/套餐：</b></label>

                            <div class="col-md-10">
                                <input class="form-control" value="{$_product['name']}" type="text" readonly>
                            </div>
                        </div>
                        <div class="form-group" style="height: auto; overflow: hidden;">
                            <label class="col-md-2 control-label"><b>案例名称：</b></label>

                            <div class="col-md-10">
                                <input class="form-control" value="{$_data['case_name']}" name="data[case_name]" type="text">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-2 control-label"><b>案例介绍：</b></label>

                            <div class="col-md-10">
                                <textarea class="form-control" rows="5" name="data[des]">{$_data['des']}</textarea>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-2 control-label"><b>相关图片/视频：</b></label>

                            <div class="col-md-10">
                                <div class="tab-pane" id="tab_2">
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
                                            tags: '@主图,外景图片,内景图片,平面图'
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
                                            <th width="80">
                                                缩略图
                                            </th>
                                            <th>名称</th>
                                            <th width="50%">
                                                标签
                                            </th>
                                            <th width="60">
                                                操作
                                            </th>
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
                                                <input class="form-control select2" type="text" name="data[media][$$][video]" placeholder="请输入第三方视频地址">
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
                                                    <input class="form-control select2 tags_select3" type="text" name="data[media][{$k}][video]" value="{$v['video']}">
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

<!-- END BUTTONS PORTLET-->
</div>
</div>


</div>
</div>
</div>
{include 'Web_User_Center::inc/html_form.tpl'}


{include 'Web_User_Center::inc/footer_inbox.tpl'}
{include 'Web_User_Center::inc/footer_script.tpl'}

<script>
    $(document).ready(function () {
        var typeahead_event = new Bloodhound({
            datumTokenizer: function (d) {
                return Bloodhound.tokenizers.whitespace(d.name);
            },
            queryTokenizer: Bloodhound.tokenizers.whitespace,
            limit: 10,
            remote: '{$_route}case_edit/event_name?query=%QUERY&product_id={$_REQUEST['product_id']}&set_id={$_REQUEST['set_id']}'
        });
        typeahead_event.initialize();
        $('#caseName').typeahead(null, {
            name: 'event_name',
            displayKey: 'name',
            source: typeahead_event.ttAdapter()
        });
        $(".tags_select2").each(function () {
            $(this).select2({
                tags: $(this).data('values').split(',')
            })
        });
    })
</script>
</body>
</html>