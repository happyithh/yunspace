<!DOCTYPE html>
<head>
    <title>{$title}</title>
    <meta content="" name="description"/>
    {include "Admin::inc/html_head.tpl"}
    <style>
        .type > a {
            margin: 5px;
            font-size: 14px;
            float: left;
        }

        .tabbable-custom {
            overflow: visible !important
        }
    </style>
</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->
<link href="css/bootstrap-datetimepicker.min.css" rel="stylesheet"/>
<script src="js/jquery-1.9.1.min.js"></script>
<body style="background:#FaFaFa !important">
<div class="portlet tabbable">
<div class="portlet-title">
    <div class="caption">
        <i class="fa fa-database"></i>广告位设置
    </div>
</div>
<div class="portlet-body form">
<form class="form-horizontal" role="form" action="?action=paAddSubmit" method="post">
<input type="hidden" name="submit" value="1">
<input type="hidden" name="id" value="{$_data[0]['id']}">
<input class="site_id" type="hidden" name="site_id" value="{$_data[0]['site_id']}">

<div class=" tabbable tabbable-custom boxless" style="padding: 10px;">
    <label class="col-md-3 control-label"><span style="color: red;">*</span>广告位置</label>

    <div class="col-md-4">
        <select class="form-control input-sm site" name="site_id" onclick=" getAdverSize(this)">

            <option value="0">请选择</option>
            {foreach $site as $k=>$v}
                <option {if $_data[0]['site']==$v['site']} selected {/if} value='{$v['id']}'>{$v['site']}</option>
            {/foreach}
        </select>
    </div>
</div>

<div class=" tabbable tabbable-custom boxless adver_title " style="padding: 10px;">
    <label class="col-md-3 control-label">广告名称</label>

    <div class="col-md-4">
        <input class="form-control" rows="1" type="text" placeholder="例如：XXXXXX"
               name="advertising_title" value="{$_data[0]['advertising_title']}">
    </div>
</div>
<div class=" tabbable tabbable-custom boxless" style="padding: 10px;">
    <label class="col-md-3 control-label"><span style="color: red;">*</span>排列顺序</label>

    <div class="col-md-2">
        <input class="form-control" rows="1" type="text" placeholder="例如：5 "
               name="rank" value="{$_data[0]['rank']}">
    </div>
    <div class="col-md-2" style="font-size: 14px;margin: 8px;color: red;">
        注：数值越小越靠前

    </div>
</div>
<div class=" tabbable tabbable-custom boxless" style="padding: 10px;">
    <label class="col-md-3 control-label">版位尺寸</label>

    <div class="col-md-4 size" style="margin: 10px;color: #696969;">
        {if isset($_data)}{$_data[0]['size']['width']}*{$_data[0]['size']['height']}(宽*高){/if}
    </div>
</div>
<div class=" tabbable tabbable-custom adver_city" style="padding: 10px;">
    <label class="col-md-3 control-label"><span style="color: red;">*</span>投放城市</label>

    <div class="col-md-4">
        <select class="form-control input-sm" name="city">
            <option value="0">请选择</option>
            <option {if $_data[0]['city']=='全国'}selected {/if} value="全国">全国</option>
            {foreach $_REQUEST['cities'] as $value}
                <option {if $value==$_data[0]['city']}selected {/if}
                        value="{$value}">{$value}</option>
            {/foreach}
        </select>
    </div>
</div>
{*{var_dump($_data)}*}
<div class=" tabbable tabbable-custom boxless" style="padding: 10px;">
    <label class="col-md-3 control-label"><span style="color: red;">*</span>广告有效期</label>

    <div class="col-md-2">
        <input type='text' class="form-control date" placeholder="请选择开始时间" name="start_time"
               value="{if $_data[0]['start_time']!=0}{date('Y-m-d',$_data[0]['start_time'])}{/if}"/>
    </div>
    <div style="margin: 6px;float: left">
        -
    </div>
    <div class="col-md-2">
        <input type='text' class="form-control date" placeholder="请选择结束时间" name="end_time"
               value="{if $_data[0]['end_time']!=0}{date('Y-m-d',$_data[0]['end_time'])}{/if}"/>
    </div>

</div>

<div class=" tabbable tabbable-custom boxless adver_link " style="padding: 10px;">
    <label class="col-md-3 control-label">指向链接</label>
    <div class="col-md-4">
        <input class="form-control" rows="1" type="text" placeholder="例如：http://xxx.xxxxxxx.xx"
               name="advertising_link" value="{$_data[0]['advertising_link']}">
    </div>
</div>
<div class=" tabbable tabbable-custom boxless" style="padding: 10px;">
    <label class="col-md-3 control-label">投放价格</label>

    <div class="col-md-1">
        <input class="form-control" rows="1" type="text" placeholder="例如：20000"
               name="price" value="{$_data[0]['price'][0]}">
    </div>
    <div class="col-md-1">
        <select class="form-control input-sm" name="price_unit">
            <option {if $_data[0]['price'][1]=='周'}selected {/if} value='周'>周</option>
            <option {if $_data[0]['price'][1]=='月'}selected {/if} value='月'>月</option>
            <option {if $_data[0]['price'][1]=='年'}selected {/if} value='年'>年</option>
        </select>
    </div>
</div>
<div class=" tabbable tabbable-custom boxless" style="padding: 10px;">
    <label class="col-md-3 control-label">投放公司</label>

    <div class="col-md-4">
        <input class="form-control" rows="1" type="text" placeholder="例如：上海星期网络科技有限公司"
               name="company" value="{$_data[0]['company']}">
    </div>
</div>
<div class=" tabbable tabbable-custom boxless" style="padding: 10px;">
    <label class="col-md-3 control-label">联系人</label>

    <div class="col-md-4">
        <input class="form-control" rows="1" type="text" placeholder="例如：王小王"
               name="contact" value="{$_data[0]['contact']}">
    </div>
</div>
<div class=" tabbable tabbable-custom boxless" style="padding: 10px;">
    <label class="col-md-3 control-label">联系Email</label>

    <div class="col-md-4">
        <input class="form-control" rows="1" type="text" placeholder="例如：wangyouwang@163.com"
               name="email" value="{$_data[0]['email']}">
    </div>
</div>
<div class=" tabbable tabbable-custom boxless" style="padding: 10px;">
    <label class="col-md-3 control-label">联系电话</label>

    <div class="col-md-4">
        <input class="form-control" rows="1" type="text" placeholder="例如：156XXXXXXXX"
               name="phone" value="{$_data[0]['phone']}">
    </div>
</div>

<div class=" tabbable tabbable-custom boxless" style="padding: 10px;">
    <label class="col-md-3 control-label">内容</label>

    <div class="col-md-4">
        <textarea class="form-control" rows="3" placeholder="例如：XXXXXXXXXXX"
                  name="content">{$_data[0]['content']}</textarea>
    </div>
</div>
<div class=" tabbable tabbable-custom boxless" style="padding: 10px;">
    <label class="col-md-3 control-label">状态</label>
    <div class="col-md-4">
        <select class="form-control input-sm" name="status">

            <option {if $_data[0]['status']==1}selected{/if} value=1>上架</option>
            <option {if $_data[0]['status']==-1}selected{/if} value=-1>下架</option>

        </select>
    </div>
</div>
<div class=" tabbable tabbable-custom boxless" style="padding: 10px;">
    <label class="col-md-3 control-label">备注</label>

    <div class="col-md-4">
        <textarea class="form-control" rows="3" placeholder="例如：XXXXXXXXXXX"
                  name="note">{$_data[0]['note']}</textarea>
    </div>
</div>
<div class=" tabbable tabbable-custom boxless title" style="padding: 10px;">
    <label class="col-md-3 control-label">默认广告</label>

    <div class="col-md-2">
        <label class="radio-inline">
            <input type="radio" name="default_adver"
                   value="0" {if $_data[0]['default_adver']==0||!isset($_data)} checked {/if} >
            否
        </label>
        <label class="radio-inline">
            <input type="radio" name="default_adver" {if $_data[0]['default_adver']==1} checked {/if} value="1">
            是
        </label>


    </div>
</div>
<div class=" tabbable tabbable-custom boxless" style="padding: 10px;">
    <label class="col-md-3 control-label"><span style="color: red;">*</span>请选择图片</label>

    <div class="col-md-4">
        {include file="Admin::inc/plupload.tpl"}
        <span class="tishi" style="color: red">*(点击图片，删除上传的图片)</span>

    </div>

</div>
<div class=" tabbable tabbable-custom boxless" style="padding: 10px;">
    <label class="col-md-3 control-label"></label>

    <div class="col-md-2">
        <table class=" switch_window" style="border: 1px solid #ccc;">
            <thead>
            <tr class="hidden" onclick="UploadFiles.remove(this)">
                <td>
                    <img src="" style="height: 400px; width: 400px; display: block;">
                </td>
            </tr>
            <tr class="hidden">
                <td>
                    <input type="hidden" name="media[$$][path]">
                    <input class="form-control" type="text" name="media[$$][title]">
                </td>
            </tr>
            </thead>
            <tbody id="upload_files">
            {if !empty({$_data[0]['path']})}
                    <tr onclick="UploadFiles.remove(this)">
                        <td>
                            <img src="{$_data[0]['path']}" style="height: 400px; width: 400px; ">
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <input type="hidden" name="media[1][path]" value="{$_data[0]['path']}">
                            {*<input class="form-control" type="text" name="media[{$k}][title]"*}
                                   {*value="{$v['title']}">*}
                        </td>
                    </tr>
            {/if}
            </tbody>
        </table>
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
</body>
<script src="{$_assets}plugins/jquery-1.11.0.min.js"
        type="text/javascript"></script>
<script type="text/javascript" src="js/moment.min.js"></script>
<script type="text/javascript" src="js/zh-cn.js"></script>
<script type="text/javascript" src="js/bootstrap-datetimepicker.min.js"></script>
<script>
    $(document).ready(function () {

        $('.date').datetimepicker({
            format: 'YYYY-MM-DD',
            locale: 'zh-cn'
        });
    });
    function getAdverSize(e) {
        var site_id = $('.site').find("option:selected").val();
            $.ajax({
                type: 'POST',
                url: "?action=ajaxGetSize",
                data: {
                    site_id: site_id
                },
                dataType: "json",
                success: function (data) {
                    console.log(data.data);
                    $('.size').text(data.data['size']);
                    $('.site_id').val(data.data['id']);
                }
            });

    }

    uploader.onFileUploaded = function (file, path) {
        var type = $(".active").index();
        if (type == 1) {
            UploadFiles_Mobile.add(file, path);
        } else {
            UploadFiles.add(file, path);
        }
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
        },
        remove: function (o) {

            $(o).next('tr').remove();
            $(o).remove();

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
    var UploadFiles_Mobile = {
        media_id: 0,
        add: function (file, path) {
            if (UploadFiles.media_id < 1) {
                UploadFiles.media_id = $('#upload_files_mobile tr').size() + 10;
            }
            UploadFiles.media_id++;
            var newFile = $('#upload_files_mobile').parents('table').find('.hidden').clone().removeClass('hidden');
            newFile.find('img').attr('src', path);
            newFile.appendTo('#upload_files_mobile');
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
<!-- END BODY -->
</html>