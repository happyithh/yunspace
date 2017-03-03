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
    <style>
        h5{ background-color: #f8f8f8; padding: 10px;}
         .form-actions{ margin-top: -15px;}

    </style>
</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->
<body style="background:#FaFaFa !important">


<div class="portlet tabbable">
<div class="portlet-title">
    <div class="caption">
        <i class="fa fa-database"></i>服务详情
    </div>

</div>
<div>
    <div class="portlet-body form">

        <form action="form_layouts.html#" class="form-horizontal">
            <div class="form-body">
                <div class="row">
                    <div class="col-md-6">
                        <div class="form-group">
                            <label class="control-label col-md-3">服务名称</label>

                            <div class="col-md-9">
                                <input type="text" class="form-control">
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label class="control-label col-md-3">服务ID</label>

                            <div class="col-md-9">
                                <p class="form-control-static">
                                    3628137801
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6">
                        <div class="form-group">
                            <label class="control-label col-md-3">供应商名称</label>

                            <div class="col-md-9">
                                <p class="form-control-static">
                                    上海ROSEROSE公司
                                </p>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-6">
                        <div class="form-group">
                            <label class="control-label col-md-3">当前状态</label>

                            <div class="col-md-9">
                                <p class="form-control-static">
                                    上线
                                </p>
                            </div>
                        </div>
                    </div>

                </div>

                <div class="row">
                    <div class="col-md-6">
                        <div class="form-group">
                            <label class="control-label col-md-3">负责人</label>

                            <div class="col-md-9">
                                <p class="form-control-static">
                                    Gary
                                </p>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-6">
                        <div class="form-group">
                            <label class="control-label col-md-3">更新时间</label>

                            <div class="col-md-9">
                                <p class="form-control-static">
                                    2015-03-20 12:30:20
                                </p>
                            </div>
                        </div>
                    </div>

                </div>
                <div class="row">
                    <div class="col-md-6">
                        <div class="form-group">
                            <label class="control-label col-md-3">服务类型</label>

                            <div class="col-md-9">
                                <select class="form-control">
                                    <option>空间场地</option>
                                    <option>配套服务</option>
                                </select>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-6">
                        <div class="form-group">
                            <label class="control-label col-md-3">价格</label>

                            <div class="col-md-9">
                                <div class="input-group">
                                    <input type="text" class="form-control">
															<span class="input-group-addon">
															元/天
															</span>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
                <div class="row">
                    <div class="col-md-6">
                        <div class="form-group">
                            <label class="control-label col-md-3">服务子类</label>

                            <div class="col-md-9">
                                <select class="form-control">
                                    <option>酒吧</option>
                                    <option>酒吧</option>
                                    <option>酒吧</option>
                                    <option>酒吧</option>
                                </select>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-6">
                        <div class="form-group">
                            <label class="control-label col-md-3">优惠折扣</label>

                            <div class="col-md-9">
                                <div class="input-group">
                                    <input type="text" class="form-control">
															<span class="input-group-addon">
															%
															</span>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
                <div class="row">
                    <div class="col-md-6">
                        <div class="form-group">
                            <label class="control-label col-md-3">服务描述</label>

                            <div class="col-md-9">
                                <textarea class="form-control" rows="4"></textarea>
                            </div>
                        </div>
                    </div>



                </div>

            </div>
            <div class="form-actions">
                <div class="" style="text-align: right">
                    <button type="submit" class="btn btn-primary" style="width: 150px">
                        上线
                    </button>
                    <button type="submit" class="btn btn-danger" style="width: 150px">
                        删除
                    </button>
                </div>
            </div>
        </form>

    </div>

</div>
<div class="portlet-body form">
<form class="form-horizontal" role="form" action="?" method="post">
<input type="hidden" name="action" value="{if $_REQUEST['ids']}update{else}insert{/if}">
<input type="hidden" name="url_to" value="{$_REQUEST['url_to']}">
<input type="hidden" name="ids[0]" value="{$_REQUEST['ids'][0]}">

<div class="tabbable tabbable-custom boxless" style="padding: 20px ;">
<ul class="nav nav-tabs">
    <li class="active">
        <a href="form_image_crop.html#tab_1" data-toggle="tab">产品信息</a>
    </li>
    <li>
        <a href="form_image_crop.html#tab_2" data-toggle="tab">图片/视频</a>
    </li>
    <li>
        <a href="form_image_crop.html#tab_3" data-toggle="tab">活动案例</a>
    </li>
    <li>
        <a href="form_image_crop.html#tab_4" data-toggle="tab">服务备注</a>
    </li>
</ul>
<div class="tab-content">
<div class="tab-pane active" id="tab_1">
    <div class="container-fluid">
        <div class="row">
            <h5><strong>地理位置</strong></h5><br/>
            <div class="col-md-6">
                <div class="form-group">
                    <label class=" col-md-4 control-label">所属城市</label>
                    <div class="col-md-8">
                        <input class="form-control" type="text">
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="form-group">
                    <label class=" col-md-4 control-label">具体地址</label>
                    <div class="col-md-8">
                        <input class="form-control" type="text">
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="form-group">
                    <label class=" col-md-4 control-label">行政区域</label>
                    <div class="col-md-8">
                        <input class="form-control" type="text">
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="form-group">
                    <label class=" col-md-4 control-label">所属商圈</label>
                    <div class="col-md-8">
                        <input class="form-control" type="text">
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <h5><strong>空间标准</strong></h5><br/>
            <div class="col-md-6">
                <div class="form-group">
                    <label class=" col-md-4 control-label">使用面积</label>
                    <div class="col-md-8">
                        <input class="form-control" type="text">
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="form-group">
                    <label class=" col-md-4 control-label">空间层高</label>
                    <div class="col-md-8">
                        <input class="form-control" type="text">
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="form-group">
                    <label class=" col-md-4 control-label">空间承重</label>
                    <div class="col-md-8">
                        <input class="form-control" type="text">
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="form-group">
                    <label class=" col-md-4 control-label">容纳人数</label>
                    <div class="col-md-8">
                        <input class="form-control" type="text">
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <h5><strong>附属空间</strong></h5><br/>
            <div class="col-md-6">
                <div class="form-group">
                    <label class=" col-md-4 control-label">休息室</label>
                    <div class="col-md-8">
                        <input class="form-control" type="text">
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="form-group">
                    <label class=" col-md-4 control-label">化妆间</label>
                    <div class="col-md-8">
                        <input class="form-control" type="text">
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="form-group">
                    <label class=" col-md-4 control-label">卫生间</label>
                    <div class="col-md-8">
                        <input class="form-control" type="text">
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <h5><strong>使用规格</strong></h5><br/>
            <div class="col-md-6">
                <div class="form-group">
                    <label class=" col-md-4 control-label">用电量</label>
                    <div class="col-md-8">
                        <input class="form-control" type="text">
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="form-group">
                    <label class=" col-md-4 control-label">空间吊点</label>
                    <div class="col-md-8">
                        <input class="form-control" type="text">
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="form-group">
                    <label class=" col-md-4 control-label">灯具高度</label>
                    <div class="col-md-8">
                        <input class="form-control" type="text">
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <h5><strong>配套设施</strong></h5><br/>
            <div class="col-md-6">
                <div class="form-group">
                    <label class=" col-md-4 control-label">空调暖气</label>
                    <div class="col-md-8">
                        <input class="form-control" type="text">
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="form-group">
                    <label class=" col-md-4 control-label">网络WIFI</label>
                    <div class="col-md-8">
                        <input class="form-control" type="text">
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="form-group">
                    <label class=" col-md-4 control-label">停车泊位</label>
                    <div class="col-md-8">
                        <input class="form-control" type="text">
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="form-group">
                    <label class=" col-md-4 control-label">货运电梯</label>
                    <div class="col-md-8">
                        <input class="form-control" type="text">
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="form-group">
                    <label class=" col-md-4 control-label">投影LED</label>
                    <div class="col-md-8">
                        <input class="form-control" type="text">
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="form-group">
                    <label class=" col-md-4 control-label">灯光音响</label>
                    <div class="col-md-8">
                        <input class="form-control" type="text">
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <h5><strong>配套餐饮</strong></h5><br/>
            <div class="col-md-6">
                <div class="form-group">
                    <label class=" col-md-4 control-label">餐饮种类</label>
                    <div class="col-md-8">
                        <input class="form-control" type="text">
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="form-group">
                    <label class=" col-md-4 control-label">人均价格</label>
                    <div class="col-md-8">
                        <input class="form-control" type="text">
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="form-group">
                    <label class=" col-md-4 control-label">配餐清单</label>
                    <div class="col-md-8">
                        <input class="form-control" type="text">
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <h5><strong>服务描述</strong></h5><br/>
            <div class="col-md-6">
                <div class="form-group">
                    <label class=" col-md-4 control-label">描述内容</label>
                    <div class="col-md-8">
                        <textarea class="form-control" rows="4"></textarea>
                    </div>
                </div>
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
        .table1 td{
            padding: 5px;}
        }
    </style>
    <table class="table table-hover">

        <tbody id="upload_files">
        {foreach $_data['media'] as $k=>$v}
            <tr>
                <td width="110">
                    <img src="{$v['path']}" style="height: 100px; width: 100px; ">
                </td>
                <td>
                    <table class="table1" width="100%">
                        <tr>
                            <td width="50">名称</td>
                            <td colspan="2"><input class="form-control" type="text"></td>
                        </tr>
                        <tr>
                            <td>标签</td>
                            <td><input class="form-control" type="text" name="data[media][{$k}][video]" value="{$v['video']}"></td>
                            <td><input class="form-control select2 tags_select3" type="text" name="data[media][{$k}][tags]" value="{$v['tags']}"></td>
                        </tr>
                        <tr>
                            <td>操作</td>
                            <td colspan="2">
                                <a href="#" class="btn btn-info btn-xs">排序上</a>
                                <a href="#" class="btn btn-info btn-xs">排序下</a>
                                <a href="#" class="btn btn-danger btn-xs">删除</a>
                            </td>
                        </tr>
                    </table>
                </td>



            </tr>
        {/foreach}
        </tbody>
    </table>
</div>
<div class="tab-pane" id="tab_3">
    <div class="form-group">


        <div class="col-md-12">
            <a class="btn btn-default btn-block" href="case_add"><i class=" fa fa-plus pr5"></i>添加案例</a>
            <table class="table table-striped table-bordered table-advance table-hover table-service">
                <thead>
                <tr>
                    <th>活动名称</th>
                    <th>活动类型</th>
                    <th>行业标签</th>
                    <th>当前状态</th>
                    <th>操作</th>

                </tr>
                </thead>
                <tbody>
                {foreach $_event as $ek=>$ev}
                    {if $ev['id']}
                        <tr>
                            <td>{$ev['case_name']}</td>
                            <td>{$ev['attr']['活动类型']}</td>
                            <td>
                                {$ev['attr']['服务行业']}
                            </td>
                            <td>
                                {if !$pv['online']}
                                    <span class="label label-warning">审核中</span>
                                {else}
                                    <span class="label label-success">上线</span>
                                {/if}
                            </td>
                            <td>
                                <a href="{$_route}case_edit?product_id={$_data['id']}&case_id={$ev['id']}" class="btn btn-xs btn-info">编辑</a>
                                <a href="javascript:;" target="_blank" class="btn btn-xs btn-danger delEvent" data-eid="{$ev['id']}">删除</a>
                            </td>
                        </tr>
                    {/if}
                {/foreach}
                </tbody>
            </table>
        </div>
    </div>

</div>
<div class="tab-pane" id="tab_4">
    <div class="container-fluid">
        <div class="row">
            <h5><strong>合作信息</strong></h5><br/>

                <div class="col-md-12">
                    <div class="form-group">
                        <label class=" col-md-1" style="padding-top: 5px;">合作底价</label>

                        <div class="col-md-4">
                            <div class="input-group">
                                <input type="text" class="form-control">
															<span class="input-group-addon">
															元/天
															</span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-12">
                    <div class="form-group">
                        <label class=" col-md-1" style="padding-top: 5px;">佣金比例</label>

                        <div class="col-md-4">
                            <div class="input-group">
                                <input type="text" class="form-control">
															<span class="input-group-addon">
															%
															</span>
                            </div>
                        </div>
                    </div>
                </div>


        </div>
        <div class="row">
            <h5><strong>成交信息</strong></h5><br/>

                <div class="col-md-12">
                    <div class="form-group">
                        <label class="col-md-1">成交量</label>

                        <div class="col-md-4">
                            <p class="form-control-static" style="padding: 0px; margin: 0px;">
                                3628137801
                            </p>
                        </div>
                    </div>
                </div>
                <div class="col-md-12">
                    <div class="form-group">
                        <label class="col-md-1">取消量</label>

                        <div class="col-md-4">
                            <p class="form-control-static" style="padding: 0px; margin: 0px;">
                                3628137801
                            </p>
                        </div>
                    </div>
                </div>
            <div class="col-md-12">
                <div class="form-group">
                    <label class="col-md-1">成交率</label>

                    <div class="col-md-4">
                        <p class="form-control-static" style="padding: 0px; margin: 0px;">
                            36%
                        </p>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <h5><strong>交易评价</strong></h5>
            <div class="table-scrollable" style="padding: 0px 15px; border: 0px;">
            <table class="table table-striped table-bordered table-hover" style="border: 1px solid #ddd;">
            <thead>
            <tr>
                <th scope="col" width="150">
                    客户名称
                </th>
                <th scope="col">
                    评价内容
                </th>

            </tr>
            </thead>
            <tbody>
            <tr>
                <td>
                    客户名称
                </td>
                <td>
                    评价内容
                </td>

            </tr>

            </tbody>
            </table>
            </div>

        </div>
        <div class="row">
            <h5><strong>商户评级</strong></h5><br/>

            <div class="col-md-12">
                <div class="form-group">
                    <label class="col-md-1">综合评分</label>

                    <div class="col-md-6">
                        <p class="form-control-static" style="padding: 0px; margin: 0px;">
                            5分
                        </p>
                    </div>
                </div>
            </div>
            <div class="col-md-12">
                <div class="form-group">
                    <label class="col-md-1">客户评分</label>

                    <div class="col-md-6">
                        <p class="form-control-static" style="padding: 0px; margin: 0px;">
                            5分
                        </p>
                    </div>
                </div>
            </div>
            <div class="col-md-12">
                <div class="form-group">
                    <label class="col-md-1">执行评分</label>

                    <div class="col-md-6">
                        <div class="radio-list">
                            <label class="radio-inline" style="padding-top: 0px;">
                                <span><input type="radio" name="optionsRadios" id="optionsRadios25" value="1分" checked=""></span>
                                1分</label>
                            <label class="radio-inline" style="padding-top: 0px;">
                                <span class="checked"><input type="radio" name="optionsRadios" id="optionsRadios26" value="2分" checked=""></span>
                                2分</label>
                            <label class="radio-inline" style="padding-top: 0px;">
                                <span><input type="radio" name="optionsRadios" id="optionsRadios27" value="3分"></span>
                                3分</label>
                            <label class="radio-inline" style="padding-top: 0px;">
                                <span><input type="radio" name="optionsRadios" id="optionsRadios27" value="4分"></span>
                                4分</label>
                            <label class="radio-inline" style="padding-top: 0px;">
                                <span><input type="radio" name="optionsRadios" id="optionsRadios27" value="5分"></span>
                                5分</label>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-12">
                <div class="form-group">
                    <label class="col-md-2">客户备注</label>

                    <div class="col-md-12">
                        <div class="table-scrollable" style="border: 0px; margin-top: 0px!important;">
                            <table class="table table-striped table-bordered table-hover" style="border: 1px solid #ddd;">
                                <thead>
                                <tr>
                                    <th scope="col" width="150">
                                        客户名称
                                    </th>
                                    <th scope="col">
                                        评价内容
                                    </th>

                                </tr>
                                </thead>
                                <tbody>
                                <tr>
                                    <td>
                                        客户名称
                                    </td>
                                    <td>
                                        备注内容
                                    </td>

                                </tr>

                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <h5><strong>内部备注</strong></h5>
            <div class="table-scrollable" style="padding: 0px 15px; border: 0px;">
                <table class="table table-striped table-bordered table-hover" style="border: 1px solid #ddd;">
                    <thead>
                    <tr>
                        <th scope="col" width="150">
                            姓名
                        </th>
                        <th scope="col">
                            备注内容
                        </th>

                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td>
                            姓名
                        </td>
                        <td>
                            备注内容
                        </td>

                    </tr>

                    </tbody>
                </table>
            </div>
            <div class="col-md-12">
                <textarea class="form-control" rows="3" placeholder="请输入备注内容"></textarea>
            </div>
        </div>
    </div>
</div>
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
            $.getJSON("?category_attr=1&category_id=" + category_id + "&format=json&jsoncallback=?", function (data) {
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