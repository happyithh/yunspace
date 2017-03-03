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
    {if $_REQUEST['set_id']}
        套餐编辑
        {if $_data['status']==2}
            <small class="label label-warning">
                您在({date('Y-m-d H:i',$_data['update_time'])}
                )提交的修改正在审核中
            </small>
        {/if}
    {else}
        新增套餐
    {/if}
</h3>
<a href="javascript:history.go(-1)" class="back"><
    <返回
</a>

<div class="clear"></div>
<div class="portlet">
<div class="portlet-body">
<div class="service_content">
<form class="form-horizontal" role="form" action="{$_route}set_edit/submit" method="post">
<input type="hidden" name="url_to" value="{$_REQUEST['url_to']}">
<input type="hidden" name="set_id" value="{$_REQUEST['set_id']}">
<style>
    .control-label.col-md-2 {
        font-size: 12px;
        padding: 0;
    }
</style>
<div class="container-fluid">
<div class="row">
    <div class="col-md-6">
        <div class="form-group">
            <label class="control-label col-md-2">套餐名称<span class="required"
                                                            aria-required="true">*</span></label>

            <div class="col-md-10">
                <input type="text" class="form-control" placeholder="请填写套餐名称"
                       name="data[set_name]"
                       value="{$_data['set_name']}">
            </div>
        </div>
    </div>
    <div class="col-md-6" style="height:49px;">
        <div class="form-group">
            <label class="control-label col-md-2">场地ID</label>
            <div class="col-md-10">
                <input name="schedule_product_id" placeholder="请输入产品档期的ID或名称"
                       class="form-control select2"
                       id="schedule_product_id" type=""
                       value="{$_data['schedule_product_id']}">
            </div>
        </div>
    </div>
    <div class="col-md-6">
        <div class="form-group">
            <label class="control-label col-md-2">营销标题<span class="required"
                                                            aria-required="true">*</span></label>

            <div class="col-md-10">
                <input type="text" class="form-control" placeholder="请填写营销标题，来吸引更多客户"
                       name="data[marketing_title]"
                       value="{$_data['marketing_title']}">
            </div>
        </div>
    </div>
    <div class="col-md-6">
        <div class="form-group">
            <label class="control-label col-md-2">地址</label>

            <div class="col-md-10">
                <input type="text" class="form-control" name="data[addr]"
                       placeholder="地址"
                       value="{$_data['addr']}">
            </div>
        </div>
    </div>
    <div class="col-md-6">
        <div class="form-group">
            <label class="control-label col-md-2">类别<span class="required" aria-required="true">*</span></label>
            <div class="col-md-10">
                <select name="data[category_id]" class="form-control">
                    {foreach $category_name as $key=>$val}
                        <option {if {$_data['category_id']}==$key}selected{/if}
                                value="{$key}">{$val}</option>
                    {/foreach}
                </select>
            </div>
        </div>
    </div>
    <div class="col-md-6">
        <div class="form-group">
            <label class="control-label col-md-2">版本</label>

            <div class="col-md-10">
                <input type="text" class="form-control" name="data[version]"
                       placeholder="请填写套餐版本信息" value="{$_data['version']}">
            </div>
        </div>
    </div>
    <div class="col-md-6">
        <div class="form-group">
            <label class="control-label col-md-2">城市<span class="required"
                                                          aria-required="true">*</span></label>

            <div class="col-md-10">
                <input type="text" class="form-control select2 tags_select2"
                       placeholder="请填写城市"
                       name="data[attr_index][城市]"
                       value="{$_data['attr_index']['城市']|default:$accountInfo['vendors'][0]['attr']['城市']}"
                       data-values="{implode(',' ,$_attrs['城市'])}">
            </div>
        </div>
    </div>
    <div class="col-md-6">
        <div class="form-group">
            <label class="control-label col-md-2">适合人数<br>（筛选）</label>

            <div class="col-md-10">
                <input type="text" class="form-control" name="data[people]"
                       placeholder="用于搜索时的筛选，请填写整数"
                       value="{$_data['people']}">
            </div>
        </div>
    </div>
    <div class="col-md-6">
        <div class="form-group">
            <label class="control-label col-md-2">套餐特色<span class="required"
                                                            aria-required="true">*</span></label>

            <div class="col-md-10">
                <input type="text" class="form-control select2 tags_select2"
                       placeholder="请填写您的套餐特色，单个填写完后回车键确定"
                       name="data[attr_index][套餐特色]" value="{$_data['attr_index']['套餐特色']}"
                       data-values="{implode(',' ,$_attrs['服务行业'])}">
            </div>
        </div>
    </div>
    <div class="col-md-6">
        <div class="form-group">
            <label class="control-label col-md-2">适合人数<br>（展示）</label>

            <div class="col-md-10">
                <input type="text" class="form-control" name="data[attr_index][人数]"
                       placeholder="例: 100人（250㎡）" value="{$_data['attr_index']['人数']}">
            </div>

        </div>
    </div>
    <div class="col-md-6">
        <div class="form-group">
            <label class="control-label col-md-2">服务时长<span class="required"
                                                            aria-required="true">*</span></label>

            <div class="col-md-10">
                <div class="input-group input-large input-range"
                     style="float: left">
                    <input type="text" class="form-control" name="data[hours]"
                           placeholder="用于搜索时的筛选，请填写整数" value="{$_data['hours']}">
                    <span class="input-group-addon">小时</span>

                </div>
            </div>

        </div>
    </div>
    <div class="col-md-6">
        <div class="form-group">
            <label class="control-label col-md-2">服务时长<br>（展示）</label>

            <div class="col-md-10">
                <input type="text" class="form-control" name="data[attr_index][天数]"
                       placeholder="例: 1天(4小时搭建，12小时使用)" value="{$_data['attr_index']['天数']}">
            </div>

        </div>
    </div>
    <div class="col-md-6">
        <div class="form-group">
            <label class="control-label col-md-2">
                工作日<br>（复选）</label>

            <div class="col-md-10">
                <label class="checkbox-inline">
                    <input type="checkbox" name="data[attr_index][工作日可选]"
                           {if !$_data['attr_index']||$_data['attr_index']['工作日可选']}checked{/if}/>工作日可选
                </label>
                <label class="checkbox-inline">
                    <input type="checkbox" name="data[attr_index][节假日可选]"
                           {if $_data['attr_index']['节假日可选']}checked{/if}/>节假日可选
                </label>
            </div>
        </div>
    </div>
    <div class="col-md-6">
        <div class="form-group">
            <label class="control-label col-md-2">有效期</label>

            <div class="col-md-10">
                <div class="input-group input-large date-picker input-daterange"
                     data-date="10/11/2012"
                     data-date-format="mm/dd/yyyy" style="float: left">
                    <input type="text" class="form-control date"
                           name="data[attr_index][开始时间]" placeholder="开始时间"
                           value="{$_data['attr_index']['开始时间']}"> <span class="input-group-addon"> 至</span>
                    <input type="text" class="form-control date"
                           name="data[attr_index][结束时间]" placeholder="结束时间"
                           value="{$_data['attr_index']['结束时间']}">
                </div>
            </div>
        </div>
    </div>
</div>
<div class="row">
<div class="col-md-6">
    <div class="form-group">
        <label class="control-label col-md-2">套餐价<span class="required"
                                                       aria-required="true">*</span>
        </label>

        <div class="col-md-10">
            <div class="input-group input-large input-range"
                 style="float: left">
                <input type="text" class="form-control" name="data[detail][套餐价]"
                       placeholder="请填写套餐价"
                       value="{$_data['detail']['套餐价']}">
                <span class="input-group-addon">元/</span>
                <input type="text" class="form-control" name="data[detail][计价单位]"
                       placeholder='例：天、桌、人、3小时，不填写表示无单位'
                       value="{$_data['detail']['计价单位']}">

            </div>
        </div>
    </div>
</div>
<div class="col-md-6">
    <div class="form-group">
        <label class="control-label col-md-2">市场价 </label>

        <div class="col-md-10">
            <div class="input-group input-large input-range"
                 style="float: left">
                <input type="text" class="form-control" name="data[detail][市场价]"
                       placeholder="市场价"
                       value="{$_data['detail']['市场价']}">
                <span class="input-group-addon">元</span>

            </div>
        </div>
    </div>
</div>
<div class="col-md-6">
    <div class="form-group">
        <label class="control-label col-md-2">订购数量<br>下限</label>

        <div class="col-md-10">
            <input type="text" class="form-control" name="data[detail][计价下限]"
                   placeholder="每笔订单的订购数量下限,默认为:1"
                   value="{$_data['detail']['计价下限']}">
        </div>

    </div>
</div>
<div class="col-md-6">
    <div class="form-group">
        <label class="control-label col-md-2">订购数量<br>上限</label>

        <div class="col-md-10">
            <input type="text" class="form-control" name="data[detail][计价上限]"
                   placeholder="每笔订单的订购数量上限,默认为:1"
                   value="{$_data['detail']['计价上限']}">
        </div>
    </div>
</div>
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
        <label class="control-label col-md-1">套餐简介<span class="required" aria-required="true">*</span></label>

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
                <button type="button" onclick="changeTemplete.templete1(this)"
                        class="btn btn-info templete1">基本模板
                </button>
                <button type="button" onclick="changeTemplete.templete2(this)"
                        class="btn btn-info templete2">发布会模板
                </button>
                <button type="button" onclick="changeTemplete.templete3(this)"
                        class="btn btn-info templete3">年会模板
                </button>
            </div>
        </div>
    </div>
</div>
<div class="row hide">
    <div id="templete1">
        {include file="OA::customer_account/inc/templete/templete1.tpl"}
    </div>
    <div id="templete2">
        {include file="OA::customer_account/inc/templete/templete2.tpl"}
    </div>
    <div id="templete3">
        {include file="OA::customer_account/inc/templete/templete3.tpl"}
    </div>
</div>
<div class="col-md-12">
    <div class="form-group">
        <label class="col-md-1 control-label"><b>相关图片/视频：</b></label>

        <div class="col-md-11">
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
                    <th width="30%">标签</th>
                    <th width="20%">视频地址(可选)</th>
                    <th width="60">操作</th>
                </tr>
                <tr class="hidden">
                    <td>
                        <img src=""
                             style="height: 80px; width: 80px; display: block;">
                    </td>
                    <td>
                        <input type="hidden" name="data[media][$$][path]">
                        <input class="form-control" type="text"
                               name="data[media][$$][name]">
                    </td>
                    <td>
                        <input class="form-control select2" type="text"
                               name="data[media][$$][tags]">
                    </td>
                    <td>
                        <input class="form-control" type="text"
                               name="data[media][$$][video]"
                               placeholder="请输入第三方视频地址">
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
                </thead>
                <tbody id="upload_files">
                {foreach $_data['media'] as $k=>$v}
                    <tr>
                        <td>
                            <img src="{$v['path']}"
                                 style="height: 80px; width: 80px; ">
                        </td>
                        <td>
                            <input type="hidden" name="data[media][{$k}][path]"
                                   value="{$v['path']}">
                            <input class="form-control" type="text"
                                   name="data[media][{$k}][name]"
                                   value="{$v['name']}">
                        </td>
                        <td>
                            <input class="form-control select2 tags_select3"
                                   type="text" name="data[media][{$k}][tags]"
                                   value="{$v['tags']}">
                        </td>
                        <td>
                            <input class="form-control"
                                   type="text" name="data[media][{$k}][video]"
                                   value="{$v['video']}" placeholder="请输入第三方视频地址">
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
</div>
</div>
<div class="form-actions text-center">
    <button type="reset" class="btn btn-default">
        重置
    </button>
    <button type="submit" class="btn btn-success">
        提交
    </button>
    {*{if $_data['status'] == 2}*}
    <a href="{$_root}set_info/{md5($_data['id'])}/{$_data['id']}.html"
       target="_blank">
        <button type="button" class="btn btn-success">
            预览
        </button>
    </a>
    {*{else}*}
    {*<a href="{$_root}set_info/{$_data['id']}.html" target="_blank"><button type="button" class="btn btn-success">*}
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
{include 'Web_User_Center::inc/footer_script.tpl'}
{include 'Web_User_Center::inc/html_form.tpl'}
{include 'Web_User_Center::inc/footer_inbox.tpl'}

<script>
    jQuery(document).ready(function () {
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
        $(".tags_select3").each(function () {
            $(this).select2({
                tags: UploadFiles.tags.split(',')
            })
        });
        $("#schedule_product_id").select2({
            placeholder: "选择产品",
            minimumInputLength: 1,
            ajax: {
                url: "{$_route}set_edit/product_auto_complete?vendor_id={$vendor['id']}",
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
                    $.ajax("{$_route}set_edit/product_auto_complete?vendor_id={$vendor['id']}&query_product=%QUERY", {
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
        function formatRepo(repo) {
            if (repo.loading) return repo.text;
            return repo.full_name;
        }

        function formatRepoSelection(repo) {
            return repo.full_name || repo.text;
        }

//服务详情编辑器模板
        changeTemplete = {
            templete1: function (o) {
                var uname = ue{md5('data[detail_des]')};
                //清空编辑器内容
                uname.setContent('');
                //获取模板1的内容
                var templete1 = $('#templete1').html();
                uname.setContent(templete1);
            },
            templete2: function (o) {
                var uname = ue{md5('data[detail_des]')};
                //清空编辑器内容
                uname.setContent('');
                //获取模板2的内容
                var templete2 = $('#templete2').html();
                uname.setContent(templete2);
            },
            templete3: function (o) {
                var uname = ue{md5('data[detail_des]')};
                //清空编辑器内容
                uname.setContent('');
                //获取模板1的内容
                var templete3 = $('#templete3').html();
                uname.setContent(templete3);
            }

        }
    });
</script>
</body>
</html>