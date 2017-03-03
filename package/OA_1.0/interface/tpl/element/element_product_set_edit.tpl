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
    <link href="style/css.css" rel="stylesheet"/>
    <!-- IMPORTANT! Load jquery-ui-1.10.3.custom.min.js before bootstrap.min.js to fix bootstrap tooltip conflict with jquery ui tooltip -->
    <script src="{$_assets}plugins/jquery-1.11.0.min.js" type="text/javascript"></script>
    <script src="{$_assets}plugins/jquery-ui/jquery-ui-1.10.3.custom.min.js" type="text/javascript"></script>
    <script src="{$_assets}plugins/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
    <script src="{$_assets}plugins/bootstrap-hover-dropdown/bootstrap-hover-dropdown.min.js" type="text/javascript"></script>
    <script src="{$_assets}plugins/jquery-slimscroll/jquery.slimscroll.min.js" type="text/javascript"></script>
    <script src="{$_assets}plugins/jquery.blockui.min.js" type="text/javascript"></script>
    <script src="{$_assets}plugins/uniform/jquery.uniform.min.js" type="text/javascript"></script>
    <!-- END CORE PLUGINS -->
    <!-- BEGIN PAGE LEVEL PLUGINS -->
    <script type="text/javascript"
            src="{$_assets}plugins/select2/select2.min.js"></script>
    <script type="text/javascript"
            src="{$_assets}plugins/datatables/media/js/jquery.dataTables.min.js"></script>
    <script type="text/javascript"
            src="{$_assets}plugins/datatables/plugins/bootstrap/dataTables.bootstrap.js"></script>
    <!-- END PAGE LEVEL PLUGINS -->
    <!-- BEGIN PAGE LEVEL SCRIPTS -->
    <script src="{$_assets}scripts/_page.js"></script>
    <link rel="stylesheet" type="text/css" href="{$_assets}plugins/bootstrap-wysihtml5/bootstrap-wysihtml5.css"/>
    <script type="text/javascript" src="{$_assets}plugins/bootstrap-wysihtml5/wysihtml5-0.3.0.js"></script>
    <script type="text/javascript" src="{$_assets}plugins/bootstrap-wysihtml5/bootstrap-wysihtml5.js"></script>
    <link rel="stylesheet" type="text/css" href="{$_assets}plugins/typeahead/typeahead.css">
    <script src="{$_assets}plugins/typeahead/typeahead.bundle.min.js" type="text/javascript"></script>
    <link rel="stylesheet" type="text/css" href="{$_assets}plugins/jquery-tags-input/jquery.tagsinput.css"/>
    <script type="text/javascript" src="{$_assets}plugins/jquery-tags-input/jquery.tagsinput.min.js"></script>
    <script type="text/javascript" src="js/moment.min.js"></script>
    <script type="text/javascript" src="js/zh-cn.js"></script>
    <script type="text/javascript" src="js/bootstrap-datetimepicker.min.js"></script>
</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->

<body style="background:#FaFaFa !important">
<div class="portlet tabbable">
<div class="portlet-title">
    <div class="caption">
        <i class="fa fa-database"></i>套餐详情
    </div>
</div>

<form class="form-horizontal" role="form" action="?" method="post">
<div>
    <div class="portlet-body form">
        {if $_data['update_status']==2}<span class="btn btn-warning btn-xs">套餐信息审核中...</span>{/if}
        <input type="hidden" name="is_submit" value="1">
        <input type="hidden" name="set_id" value="{$_data['id']}">
        <input type="hidden" name="data[counter_view]" value="{$_data['counter_view']}">
        <div class="form-body">
        <div class="row">
            <div class="col-md-6">
                <div class="form-group">
                    <label class="control-label col-md-2">套餐名称<span class="required"
                                                                    aria-required="true">*</span></label>

                    <div class="col-md-10">
                        <input type="text" class="form-control" placeholder="套餐名称" name="data[set_name]"
                               value="{$_data['set_name']}">
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="form-group">
                    <label class="control-label col-md-2" style="font-size: 12px;">所属供应商</label>

                    <div class="col-md-10">
                        <input id="select2_sample6" type="hidden" class="form-control select2" name="data[vendor_id]" value="{$_data['vendor_id']}">
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="form-group">
                    <label class="control-label col-md-2">场地ID</label>

                    <div class="col-md-10">
                        {*<input type="text" class="form-control" name="schedule_product_id" placeholder="请输入产品档期的ID"*}
                               {*value="{$_data['schedule_product_id']}">*}
                        <input name="schedule_product_id" placeholder="请输入产品档期的ID或名称" class="form-control select2"
                               id="schedule_product_id" type="hidden" value="{$_data['schedule_product_id']}">
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="form-group">
                    <label class="control-label col-md-2">类别</label>

                    <div class="col-md-10">
                        <select name="data[category_id]" class="form-control">
                            {foreach $category_name as $key=>$val}
                                <option {if {$_data['category_id']}==$key}selected{/if} value="{$key}">{$val}</option>
                            {/foreach}
                        </select>
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="form-group">
                    <label class="control-label col-md-2">版本</label>

                    <div class="col-md-10">
                        {*<select name="data[version]" class="form-control">*}
                            {*{foreach Data_Mysql_Table_Product_Set::$versions as $val}*}
                                {*<option {if {$_data['version']}==$val}selected{/if}>{$val}</option>*}
                            {*{/foreach}*}
                        {*</select>*}
                        <input type="text" class="form-control" name="data[version]" placeholder="版本信息" value="{$_data['version']}">
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="form-group">
                    <label class="control-label col-md-2">标签</label>

                    <div class="col-md-10">
                        <input type="text" class="form-control select2 tags_select2" placeholder="标签"
                               name="data[attr_index][标签]" value="{$_data['attr_index']['标签']}" data-values="{implode(',' ,$_attrs['服务行业'])}">
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="form-group">
                    <label class="control-label col-md-2" style="font-size: 12px;">人数(展示用)</label>

                    <div class="col-md-10">
                        <input type="text" class="form-control" name="data[attr_index][人数]" placeholder="人数" value="{$_data['attr_index']['人数']}">
                    </div>

                </div>
            </div>
            <div class="col-md-6">
                <div class="form-group">
                    <label class="control-label col-md-2" style="font-size: 12px;">人数(整数)</label>

                    <div class="col-md-10">
                        <input type="text" class="form-control" name="data[people]" placeholder="人数"
                               value="{$_data['people']}">
                    </div>

                </div>
            </div>
            <div class="col-md-6">
                <div class="form-group">
                    <label class="control-label col-md-2">城市</label>

                    <div class="col-md-10">
                        <input type="text" class="form-control select2 tags_select2" placeholder="城市"
                               name="data[attr_index][城市]" value="{$_data['attr_index']['城市']|default:$accountInfo['vendors'][0]['attr']['城市']}" data-values="{implode(',' ,$_attrs['城市'])}">
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="form-group">
                    <label class="control-label col-md-2" style="font-size: 12px;">小时数(整数)<span class="required"
                                                                                                aria-required="true">*</span></label>

                    <div class="col-md-10">
                        <input type="text" class="form-control" name="data[hours]" placeholder="小时数"
                               value="{$_data['hours']}">
                    </div>

                </div>
            </div>
            <div class="col-md-6">
                <div class="form-group">
                    <label class="control-label col-md-2" style="font-size: 12px;">天数（展示用）</label>

                    <div class="col-md-10">
                        <input type="text" class="form-control" name="data[attr_index][天数]" placeholder="天数" value="{$_data['attr_index']['天数']}">
                    </div>

                </div>
            </div>
            <div class="col-md-6">
                <div class="form-group">
                    <label class="control-label col-md-2">地址</label>

                    <div class="col-md-10">
                        <input type="text" class="form-control" name="data[addr]" placeholder="地址"
                               value="{$_data['addr']}">
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="form-group">
                    <label class="control-label col-md-2">有效期</label>

                    <div class="col-md-10">
                        <div class="input-group input-large date-picker input-daterange" data-date="10/11/2012"
                             data-date-format="mm/dd/yyyy" style="float: left">
                            <input type="text" class="form-control date" name="data[attr_index][开始时间]" placeholder="开始时间" value="{$_data['attr_index']['开始时间']}">
												<span class="input-group-addon">
												至</span>
                            <input type="text" class="form-control date" name="data[attr_index][结束时间]" placeholder="结束时间" value="{$_data['attr_index']['结束时间']}">
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="form-group">
                    <label class="control-label col-md-2">
                        工作日</label>

                    <div class="col-md-10">
                        <label class="checkbox-inline">
                            <input type="checkbox" name="data[attr_index][工作日可选]" {if !$_data['attr_index']||$_data['attr_index']['工作日可选']}checked{/if}/>工作日可选
                        </label>
                        <label class="checkbox-inline">
                            <input type="checkbox" name="data[attr_index][节假日可选]" {if $_data['attr_index']['节假日可选']}checked{/if}/>节假日可选
                        </label>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-6">
                <div class="form-group">
                    <label class="control-label col-md-2">市场价 </label>

                    <div class="col-md-10">
                        <input type="text" class="form-control" name="data[detail][市场价]" placeholder="市场价"
                               value="{$_data['detail']['市场价']}">
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="form-group">
                    <label class="control-label col-md-2">套餐价 <span class="required"
                                                                    aria-required="true">*</span></label>

                    <div class="col-md-10">
                        <input type="text" class="form-control" name="data[detail][套餐价]" placeholder="套餐价"
                               value="{$_data['detail']['套餐价']}">
                    </div>
                </div>
            </div>

        </div>
        <div class="row">
            <div class="col-md-6">
                <div class="form-group">
                    <label class="control-label col-md-2">计价单位</label>
                    <div class="col-md-10">
                        <input type="text" class="form-control" name="data[detail][计价单位]" placeholder="不填写默认为一口价"
                               value="{$_data['detail']['计价单位']}">
                    </div>

                </div>
            </div>
            <div class="col-md-6">
                <div class="form-group">
                    <label class="control-label col-md-2" style="font-size: 12px;">计价上限/下限</label>
                    <div class="col-md-10">
                        <div class="input-group input-large input-range"
                             style="float: left">
                            <input type="text" class="form-control" name="data[detail][计价下限]" placeholder="计价下限"
                                   value="{$_data['detail']['计价下限']}">
                    <span class="input-group-addon">
                    ~</span>
                            <input type="text" class="form-control" name="data[detail][计价上限]" placeholder="计价上限"
                                   value="{$_data['detail']['计价上限']}">

                        </div>
                    </div>
                </div>
            </div>

        </div>
        <div class="row">
            {*<div class="col-md-12">*}
                {*<div class="form-group">*}
                    {*<label class="control-label col-md-1">服务清单</label>*}

                    {*<div class="col-md-11">*}
                        {*<textarea class="form-control " rows="3" name="data[detail][清单]">{$_data['detail']['清单']}</textarea>*}
                    {*</div>*}
                {*</div>*}
            {*</div>*}
            <div class="col-md-12">
                <div class="form-group">
                    <label class="control-label col-md-1">套餐简介</label>

                    <div class="col-md-11">
                        {include "Admin::inc/html_umeditor.tpl" name="data[des]" value=$_data['des'] height=200}
                    </div>
                </div>
            </div>
            <div class="col-md-12">
                <div class="form-group">
                    <label class="control-label col-md-1">服务详情</label>

                    <div class="col-md-11">
                        {include "Admin::inc/html_umeditor.tpl" name="data[detail_des]" value=$_data['detail_des'] height=300}
                        <div style="margin-top: 10px;">
                            <button type="button" onclick="changeTemplete.templete1(this)" class="btn btn-info templete1">基本模板</button>
                            <button type="button" onclick="changeTemplete.templete2(this)" class="btn btn-info templete2">发布会模板</button>
                            <button type="button" onclick="changeTemplete.templete3(this)" class="btn btn-info templete3">年会模板</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="row hide">
            <div id="templete1">
                {include file="customer_account/inc/templete/templete1.tpl"}
            </div>
            <div id="templete2">
                {include file="customer_account/inc/templete/templete2.tpl"}
            </div>
            <div id="templete3">
                {include file="customer_account/inc/templete/templete3.tpl"}
            </div>
        </div>
        </div>
    </div>
</div>
<div class="portlet-body">
<div class="tabbable tabbable-custom boxless" style="padding: 20px ;">
<ul class="nav nav-tabs">
    <li class="active">
        <a href="form_image_crop.html#tab_2" data-toggle="tab">图片/视频</a>
    </li>
</ul>
<div class="tab-content">
<!--      ---------------------------图片/视频  start-------------------------------      -->
<div class="tab-pane active" id="tab_2">
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
<script>
    jQuery(document).ready(function () {
        $('.wysihtml5').wysihtml5();
        $(".tags_select2").each(function () {
            $(this).select2({
                tags: $(this).data('values').split(',')
            })
        });
        $('.tags').tagsInput({
            width: 'auto'
        });
        $('.date').datetimepicker({
            format: 'YYYY-MM-DD',
            locale: 'zh-cn'
        });
    });
    $("#schedule_product_id").select2({
        placeholder: "选择产品",
        minimumInputLength: 1,
        ajax: {
            url: "?product_set?&product_auto_complete=1",
            dataType: 'json',
            data: function (term, page) {
                return {
                    q: term, // search term
                    query_product: 1
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
                $.ajax("?product_set?&product_auto_complete=1&query_product=%QUERY", {
                    data: {
                        product_id: id
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

    $("#select2_sample6").select2({
        placeholder: "选择供应商",
        minimumInputLength: 1,
        ajax: { // instead of writing the function to execute the request we use Select2's convenient helper
            url: "{$_route}product_set?&vendor_auto_complete=1",
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
                $.ajax("{$_route}product_set?list_type=product&vendor_auto_complete=1", {
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
    function formatRepo(repo) {
        if (repo.loading) return repo.text;
        return repo.full_name;
    }

    function formatRepoSelection(repo) {
        return repo.full_name || repo.text;
    }

    //服务详情编辑器模板
    changeTemplete = {
        templete1:function(o){
            var uname=ue{md5('data[detail_des]')};
            //清空编辑器内容
            uname.setContent('');
            //获取模板1的内容
            var templete1=$('#templete1').html();
            uname.setContent(templete1);
        },
        templete2:function(o){
            var uname=ue{md5('data[detail_des]')};
            //清空编辑器内容
            uname.setContent('');
            //获取模板2的内容
            var templete2=$('#templete2').html();
            uname.setContent(templete2);
        },
        templete3:function(o){
            var uname=ue{md5('data[detail_des]')};
            //清空编辑器内容
            uname.setContent('');
            //获取模板1的内容
            var templete3=$('#templete3').html();
            uname.setContent(templete3);
        }

    }
</script>
</body>
<!-- END BODY -->
</html>