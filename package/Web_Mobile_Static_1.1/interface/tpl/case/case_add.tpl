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

<div class="clearfix"></div>
<div class="page-container">


<div class="page-content-wrapper">
<div class="page-content">
<!-- BEGIN PAGE HEADER-->
<h3 class="page-title" style="float: left;">
        添加活动案例
</h3>

<div class="clear"></div>
<div class="portlet">
<div class="portlet-body">
    <div>
        <div class="service_content">
            <form class="form-horizontal" action="?action=submit" method="post">
            <div class="form-horizontal" >

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
                                <input name="data[attr][活动类型]" id="activity_type" value="{$_data['attr']['活动类型']}" data-values="{implode(',',$_attrs['活动类型'])}" class="form-control select2 tags_select2" type="text">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-2 control-label"><b>行业：</b></label>

                            <div class="col-md-10">
                                <input name="data[attr][服务行业]" id="serve" value="{$_data['attr']['服务行业']}" data-values="{implode(',',$_attrs['服务行业'])}" class="form-control select2 tags_select2" type="text">
                            </div>
                        </div>
                        <div class="form-group" style="height: auto; overflow: hidden;">
                            <label class="col-md-2 control-label"><b>相关服务/套餐：</b></label>

                            <div class="col-md-10" >
                                <input name="data[product_id] " placeholder="请输入场地ID/套餐ID或名称" class="form-control select2 "
                                       id="product_id" type="hidden" >
                                <input name="data[name]" class="product_name" type="hidden" />
                            </div>
                        </div>
                        <div class="form-group" style="height: auto; overflow: hidden;">
                            <label class="col-md-2 control-label"><b>案例名称：</b></label>

                            <div class="col-md-10">
                                <input class="form-control input" value="{$_data['case_name']}" name="data[case_name]" type="text">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-2 control-label"><b>案例介绍：</b></label>

                            <div class="col-md-10">
                                <textarea class="form-control case" rows="5" name="data[des]">{$_data['des']}</textarea>
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
                                                <input type="hidden" name="data[media][$$][path]"   />
                                                <input class="form-control " type="text"  name="data[media][$$][name]"/>
                                            </td>
                                            <td>
                                                <input class="form-control select2 "  type="text" name="data[media][$$][tags]">
                                                <input class="form-control select2 " type="text" name="data[media][$$][video]" placeholder="请输入第三方视频地址">
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
                                                    <input type="hidden" name="data[media][{$k}][path]" value="{$v['path']}" >
                                                    <input class="form-control" type="text" name="data[media][{$k}][name]"  value="{$v['name']}">
                                                </td>
                                                <td>
                                                    <input class="form-control select2 tags_select3"  type="text" name="data[media][{$k}][tags]" value="{$v['tags']}">
                                                    <input class="form-control select2 tags_select3 " type="text"  name="data[media][{$k}][video]" value="{$v['video']}">
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
                    <button type="submit" class="btn btn-success" id="caseadd_submit">
                        提交
                    </button>
                </div>
            </form>
            </div>
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
    });





    $("#product_id").select2({
        placeholder: "选择产品",
        minimumInputLength: 1,
        ajax: {
            {*url: "{$_route}list?action=auto_complete_product",*}
            url: "http://{Core::$urls['host']}/static/api/product/search/all.json?action=all",
            dataType: 'json',
            data: function (term, page) {
                return {
                    q: term // search term
//                    query_product: 1
                };
            },
            results: function (data, page) { // parse the results into the format expected by Select2.
                // since we are using custom formatting functions we do not need to alter remote JSON data
                return {
                    results: data.data
                };
            }
        },
        initSelection: function (element, callback) {
            var id = $(element).val();

            if (id !== "") {
                $.ajax("http://{Core::$urls['host']}/static/api/product/search/all.json?action=all", {
                    data: {
                        product_id: id

                    },
                    dataType: "json"
                }).done(function (data) {
                    callback(data.data);
                });
            }
        },
        formatResult: formatRepo, // omitted for brevity, see the source of this page
        formatSelection: formatRepoSelection, // omitted for brevity, see the source of this page
        escapeMarkup: function (m) {
            return m;
        } // we do not want to escape markup since we are displaying html in results
    });
    function formatRepo(repo) {
        if (repo.loading) return repo.text;
        return repo.name;
    }

    function formatRepoSelection(repo) {
$('.product_name').val(repo.name);
        return repo.name || repo.text;
    }




</script>
</body>
</html>