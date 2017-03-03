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
    <style>
        .readdata p {
            padding: 0
        }

        .text_right {
            margin-bottom: 30px;
            text-align: right;
        }
    </style>

    <!-- BEGIN JAVASCRIPTS(Load javascripts at bottom, this will reduce page load time) -->
    <!-- BEGIN CORE PLUGINS -->
    <script src="{$_assets}plugins/jquery-1.11.0.min.js"
            tab="text/javascript"></script>
    <script src="{$_assets}plugins/jquery-migrate-1.2.1.min.js"
            tab="text/javascript"></script>
    <!-- IMPORTANT! Load jquery-ui-1.10.3.custom.min.js before bootstrap.min.js to fix bootstrap tooltip conflict with jquery ui tooltip -->
    <script src="{$_assets}plugins/jquery-ui/jquery-ui-1.10.3.custom.min.js"
            tab="text/javascript"></script>
    <script src="{$_assets}plugins/bootstrap/js/bootstrap.min.js"
            tab="text/javascript"></script>
    <script src="{$_assets}plugins/bootstrap-hover-dropdown/bootstrap-hover-dropdown.min.js"
            tab="text/javascript"></script>
    <script src="{$_assets}plugins/jquery-slimscroll/jquery.slimscroll.min.js"
            tab="text/javascript"></script>
    <script src="{$_assets}plugins/jquery.blockui.min.js"
            tab="text/javascript"></script>
    <script src="{$_assets}plugins/uniform/jquery.uniform.min.js"
            tab="text/javascript"></script>
    <!-- END CORE PLUGINS -->
    <!-- BEGIN PAGE LEVEL PLUGINS -->
    <script tab="text/javascript"
            src="{$_assets}plugins/select2/select2.min.js"></script>
    <script tab="text/javascript"
            src="{$_assets}plugins/datatables/media/js/jquery.dataTables.min.js"></script>
    <script tab="text/javascript"
            src="{$_assets}plugins/datatables/plugins/bootstrap/dataTables.bootstrap.js"></script>
    <!-- END PAGE LEVEL PLUGINS -->
    <!-- BEGIN PAGE LEVEL SCRIPTS -->
    <script src="{$_assets}scripts/_page.js"></script>
</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->
<body style="background:#FaFaFa !important">
<div class="portlet tabbable">
    <div class="portlet-body" style="padding:10px 10px">
        <div class="portlet-tabs">
            <div class="tabbable">
                <div class="tab-content clearfix">

                    <div class="portlet tabbable">
                        <div class="portlet-title">
                            <div class="caption">
                                <i class="fa fa-database"></i>产品详情
                            </div>
                        </div>
                        <style>
                            .control-label.col-md-2 {
                                font-size: 12px;
                                padding: 0;
                            }
                        </style>
                        <form class="form-horizontal" role="form" action="#" method="post">
                            <div>
                                <div class="portlet-body form">
                                    <div class="form-body">
                                        <div class="row">
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label class="control-label col-md-2">服务名称<span class="required"
                                                                                                    aria-required="true">*</span></label>

                                                    <div class="col-md-10">
                                                        <input type="text" class="form-control" placeholder="Title"
                                                               name="data[product_name]"
                                                               value="{$_data['product_name']}">
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label class="control-label col-md-2">价格</label>

                                                    <div class="col-md-10">
                                                        <div class="input-group">
                                                            <input id="price" type="text" class="form-control"
                                                                   placeholder="请填写价格"
                                                                   name="data[price]"
                                                                   {if !empty($_data['price'])}value="{abs($_data['price'])}{/if}">
                                                            {*<span class="input-group-addon">元/天</span>*}
                                                            <span class="input-group-addon">
                                    <input type="checkbox" name="data[attr_new][起价]" value="1"
                                           {if $_data['attr_new']['起价']}checked{/if}> 起价
                                </span>
                                <span class="input-group-addon">
                                    <input type="checkbox" name="hide_price" value="1"
                                           {if $_data['price']<0}checked{/if}> 面议
                                </span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label class="control-label col-md-2">计价单位</label>

                                                    <div class="col-md-10">
                                                        <div class="input-group col-md-12">
                                                            <input type="text" class="form-control"
                                                                   name="data[attr_new][计价单位]"
                                                                   placeholder="例：天、桌、人、3小时，不填写表示无单位"
                                                                   value="{$_data['attr_new']['计价单位']}">
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label class="control-label col-md-2">订购数量上限/下限</label>

                                                    <div class="col-md-10">
                                                        <div class="input-group input-range">
                                                            <input type="text" class="form-control"
                                                                   name="data[attr_new][计价下限]"
                                                                   placeholder="订购数量下限"
                                                                   value="{$_data['attr_new']['计价下限']}">
                                                            <span class="input-group-addon">~</span>
                                                            <input type="text" class="form-control"
                                                                   name="data[attr_new][计价上限]"
                                                                   placeholder="订购数量上限"
                                                                   value="{$_data['attr_new']['计价上限']}">
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label class="control-label col-md-2">地址</label>

                                                    <div class="col-md-10" style="height:33px;">
                                                        <input style="width: 300px;float: left;height:33px" type="text"
                                                               class="form-control"
                                                               name="data[addr]" value="{$_data['addr']}"/>
                                                        <span style="color: #bd362f;font-size: 6px;float:left;line-height: 33px; margin-top: -10px;">&nbsp;&nbsp;*若产品为配套服务时，请勿输入地址</span>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label class="control-label col-md-2">面积</label>

                                                    <div class="col-md-10">
                                                        <div class="input-group">
                                                            <input type="text" class="form-control"
                                                                   name="data[product_size]"
                                                                   value="{$_data['product_size']}">
                                                            <span class="input-group-addon">平方米</span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-12">
                                                <div class="form-group">
                                                    <label class="control-label col-md-1">搜索排序优先级</label>

                                                    <div class="col-md-11">
                                                        <label class="radio-inline">
                                                            <input type="radio" name="data[order_lv]" value="3"
                                                                   {if $_data['order_lv']==3}checked="checked" {/if}>
                                                            A
                                                        </label>
                                                        <label class="radio-inline">
                                                            <input type="radio" name="data[order_lv]" value="2"
                                                                   {if $_data['order_lv']==2}checked="checked" {/if}>
                                                            B
                                                        </label>
                                                        <label class="radio-inline">
                                                            <input type="radio" name="data[order_lv]" value="1"
                                                                   {if $_data['order_lv']==1}checked="checked" {/if}>
                                                            C
                                                        </label>
                                                        <label class="radio-inline">
                                                            <input type="radio" name="data[order_lv]" value="0"
                                                                   {if $_data['order_lv']==0}checked="checked" {/if}>
                                                            D
                                                        </label>
                                                        <label class="radio-inline">
                                                            <input type="radio" name="data[order_lv]" value="-1"
                                                                   {if $_data['order_lv']==-1}checked="checked" {/if}>
                                                            E
                                                        </label>
                                                        <label class="radio-inline">
                                                            <input type="radio" name="data[order_lv]" value="-2"
                                                                   {if $_data['order_lv']==-2}checked="checked" {/if}>
                                                            F
                                                        </label>
                                                        <label class="radio-inline">
                                                            <input type="radio" name="data[order_lv]" value="-3"
                                                                   {if $_data['order_lv']==-3}checked="checked" {/if}>
                                                            G
                                                        </label>
                                                        <label class="radio-inline">
                                                            <span style="color:#bd362f">(*默认为D)</span>
                                                        </label>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-12">
                                                <div class="form-group">
                                                    <label class="control-label col-md-1">服务描述<span class="required"
                                                                                                    aria-required="true">*</span></label>

                                                    <div class="col-md-11">
                                                        {include "Admin::inc/html_umeditor.tpl" name="data[des]" value=$_data['des'] height=200}
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-12">
                                                {foreach $_tags_info as $key=>$value}
                                                    <div class="form-group">
                                                        <label class="control-label col-md-1">{$key}</label>

                                                        <div class="col-md-11">
                                                            {foreach $value as $ik=>$iv}
                                                                <div class="input-group">
                                        <span class="input-group-addon">
                                            {if $iv['tags_name'] == '城市'}
                                                <span class="required" aria-required="true"
                                                      style="color:#C63300">*</span>
                                            {/if}
                                            {$iv['tags_name']}:
                                        </span>
                                                                    <input type="text"
                                                                           class="form-control select2 tags_select2"
                                                                           name="data[attr_new][{$ik}]"
                                                                           value="{$_data['attr_new'][{$ik}]}"
                                                                           data-values="{implode(',',$iv['tags_value'])}">
                                                                </div>
                                                            {/foreach}
                                                        </div>
                                                    </div>
                                                {/foreach}
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <label class="control-label col-md-1">图片/视频</label>

                            <div class="portlet-body">
                                <div class="tabbable tabbable-custom boxless" style="padding: 20px ;">

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
                                                        <input class="form-control" type="text"
                                                               name="data[media][$$][name]">
                                                    </td>
                                                    <td>
                                                        <input class="form-control select2" type="text"
                                                               name="data[media][$$][tags]">
                                                        <input class="form-control" type="text"
                                                               name="data[media][$$][video]">
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
                                                                   name="data[media][{$k}][name]"
                                                                   value="{$v['name']}">
                                                        </td>
                                                        <td>
                                                            <input class="form-control select2 tags_select3_product"
                                                                   type="text"
                                                                   name="data[media][{$k}][tags]" value="{$v['tags']}">
                                                            <input class="form-control select2 tags_select3_product"
                                                                   type="text"
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
                                        <!--      ---------------------------图片视频  end-------------------------------      -->
                                        -->
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                    <link rel="stylesheet" type="text/css"
                          href="{$_assets}plugins/bootstrap-wysihtml5/bootstrap-wysihtml5.css"/>
                    <script type="text/javascript"
                            src="{$_assets}plugins/bootstrap-wysihtml5/wysihtml5-0.3.0.js"></script>
                    <script type="text/javascript"
                            src="{$_assets}plugins/bootstrap-wysihtml5/bootstrap-wysihtml5.js"></script>
                    <script>
                        jQuery(document).ready(function () {
                            $('.wysihtml5').wysihtml5();
                            $(".tags_select2").each(function () {
                                $(this).select2({
                                    tags: $(this).data('values').split(',')
                                })
                            });
                            $(".tags_select3_product").each(function () {
                                $(this).select2({
                                    tags: UploadFiles.tags.split(',')
                                })
                            });
                        });
                    </script>
                </div>
            </div>
        </div>
    </div>

</body>
<!-- END BODY -->
</html>