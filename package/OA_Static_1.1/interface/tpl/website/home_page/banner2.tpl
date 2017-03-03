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
        .captions{
            background-color: #eee;
            border-radius: 4px 4px 0 0;
            padding: 10px 10px 2px 10px;
            height: 38px;
            font-size: 16px;
        }
        .topTitle{
            font-size: 15px;
        }
    </style>
    <script src="{$_assets}plugins/jquery-1.11.0.min.js" type="text/javascript"></script>
</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->
<body style="background:#FaFaFa !important">
<div class="portlet tabbable">
<div class="portlet-title">
    <div class="caption">
        <i class="fa fa-database"></i>首页Banner管理
    </div>
</div>
<div class="portlet-body form">
<form class="form-horizontal" role="form" action="?action=banner" method="post" enctype="multipart/form-data">
{*<input type="hidden" name="city" value="{$_REQUEST['city']}">*}

<div class="tabbable tabbable-custom boxless" style="padding: 20px ;">
   {* <div class="cols-md-3">
        对应城市首页:
        <select class="form-control" name="city" onchange="changeCity(this)">
            {foreach $_REQUEST['cities'] as $v}
                <option value="{$v}" {if $v==$_REQUEST['city']}selected="selected" {/if}>
                    {$v}
                </option>
            {/foreach}
        </select>
    </div>*}
    <div class="cols-md-3 " style="text-align: center;margin: 15px 0px">
        <div class="btn btn-default  btn-primary active go_switch_window">网站首页</div>
        <div class="btn btn-default go_switch_window">移动首页</div>
    </div>
    {include file="Admin::inc/plupload.tpl"}
    <script>
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
       /* function changeCity(o) {
            var href = window.location.href + '?';
            window.location = href.substr(0, href.indexOf('?')) + '?city=' + $(o).val() + '&t=' + (new Date()).valueOf();
        }*/
    </script>

    <table class="table table-hover switch_window" style="border: 1px solid #ccc;">
        <thead>
        <tr>
            <td style="width:100%;text-align: left !important;font-size: 12px;color: red" colspan="4">
                注意：网站首页banner,宽度：1920px ,高度:560px
            </td>
        </tr>
        <tr>
            <th width="80">缩略图</th>
            <th>标题</th>
            {*<th width="50%">指向链接</th>*}
            <th width="60">操作</th>
        </tr>
        <tr class="hidden">
            <td>
                <img src="" style="height: 80px; width: 80px; display: block;">
            </td>
            <td>
                <input type="hidden" name="data[media][$$][path]">
                <input class="form-control" type="text" name="data[media][$$][title]">
            </td>
            {*<td>*}
                {*<input class="form-control" type="text" name="data[media][$$][url]">*}
            {*</td>*}
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
                {*<td>*}
                    {*<input class="form-control" type="text" name="data[media][{$k}][url]" value="{$v['url']}">*}
                {*</td>*}
                <td class="btns">
                    <i class="fa fa-long-arrow-up" onclick="UploadFiles.up(this)"></i>
                    <i class="fa fa-long-arrow-down" onclick="UploadFiles.down(this)"></i>
                    <i class="fa fa-trash-o" onclick="UploadFiles.remove(this)"></i>
                </td>
            </tr>
        {/foreach}
        </tbody>
    </table>
    {********这个table 是 上传移动版的首页********}
    <table class="table table-hover switch_window" style="border: 1px solid #ccc;display: none">
        <thead>
        <tr>
            <td style="width:100%;text-align: left !important;font-size: 12px;color: red" colspan="4">
                注意：移动首页banner,宽度：320px ,高度:490px
            </td>
        </tr>
        <tr>
            <th width="80">缩略图</th>
            <th>标题</th>
            {*<th width="50%">指向链接</th>*}
            <th width="60">操作</th>
        </tr>
        <tr class="hidden">
            <td>
                <img src="" style="height: 80px; width: 80px; display: block;">
            </td>
            <td>
                <input type="hidden" name="data[media_mobile][$$][path]">
                <input class="form-control" type="text" name="data[media_mobile][$$][title]">
            </td>
            {*<td>*}
                {*<input class="form-control" type="text" name="data[media_mobile][$$][url]">*}
            {*</td>*}
            <td class="btns">
                <i class="fa fa-long-arrow-up" onclick="UploadFiles_Mobile.up(this)"></i>
                <i class="fa fa-long-arrow-down" onclick="UploadFiles_Mobile.down(this)"></i>
                <i class="fa fa-trash-o" onclick="UploadFiles_Mobile.remove(this)"></i>
            </td>
        </tr>
        </thead>
        <tbody id="upload_files_mobile">
        {foreach $_data['media_mobile'] as $k=>$v}
            <tr>
                <td>
                    <img src="{$v['path']}" style="height: 80px; width: 80px; ">
                </td>
                <td>
                    <input type="hidden" name="data[media_mobile][{$k}][path]" value="{$v['path']}">
                    <input class="form-control" type="text" name="data[media_mobile][{$k}][title]"
                           value="{$v['title']}">
                </td>
                {*<td>*}
                    {*<input class="form-control" type="text" name="data[media_mobile][{$k}][url]" value="{$v['url']}">*}
                {*</td>*}
                <td class="btns">
                    <i class="fa fa-long-arrow-up" onclick="UploadFiles_Mobile.up(this)"></i>
                    <i class="fa fa-long-arrow-down" onclick="UploadFiles_Mobile.down(this)"></i>
                    <i class="fa fa-trash-o" onclick="UploadFiles_Mobile.remove(this)"></i>
                </td>
            </tr>
        {/foreach}
        </tbody>
    </table>
</div>
<!-------------------------------精心推荐------------------------------>
<div class="captions">
    <i class="fa fa-reorder"></i>精心推荐
</div>
<div style="padding: 20px ;">
    <div class="form-group">
        <table class="table table-hover">
            <thead>
            <tr>
                <th width="10%">名称</th>
                <th width="10%">缩略图</th>
                <th>需要替换的图片</th>
                <th width="10%">标题</th>
                <th width="20%">指向链接</th>
                <th width="20%">内容</th>
                <th width="10%">分类</th>
                <th width="20%">分类指向链接</th>
            </tr>
            </thead>
            <tbody>
            {foreach $_data3['specialRecommend'] as $k=>$v}
                <tr style="border-bottom: 1px solid #ccc">
                    <td>
                        <input class="form-control" type="text" readonly
                               name="data[specialRecommend][精心推荐][{$k}][name]"
                               value="{$v['name']}">
                    </td>
                    <td>
                        <img src="{$v['path']}" style="height: 80px; width: 80px; ">
                    </td>
                    <td>
                        <input type="file" name="upload{$k}" value=""/>
                        <input type="hidden" name="data[specialRecommend][精心推荐][{$k}][path]" value="{$v['path']}"/>
                    </td>
                    <td>
                        <input class="form-control" type="text" name="data[specialRecommend][精心推荐][{$k}][title]"
                               value="{$v['title']}" placeholder="图片标题">
                    </td>
                    <td>
                        <input class="form-control" type="text" name="data[specialRecommend][精心推荐][{$k}][url]"
                               value="{$v['url']}">
                    </td>
                    <td>
                        <textarea class="form-control" rows="2"
                                  name="data[specialRecommend][精心推荐][{$k}][content]">{$v['content']}</textarea>
                    </td>
                    <td>
                        <input class="form-control"  type="text" name="data[specialRecommend][精心推荐][{$k}][category]"
                               value="{$v['category']}" placeholder="分类">
                    </td>
                    <td>
                        <input class="form-control" type="text" name="data[specialRecommend][精心推荐][{$k}][categoryUrl]"
                               value="{$v['categoryUrl']}">
                    </td>
                </tr>
            {/foreach}
            </tbody>
        </table>
    </div>

</div>

<div class="form-actions text-center">
    <button type=" reset" class="btn btn-default">
        重置
    </button>
    <button type="submit" class="btn btn-success submit_button">
        提交
    </button>
</div>
</form>
</div>
<script>
    $(".go_switch_window").on('click', function (e) {
        $(".switch_window").hide().eq($(this).index()).show();
        $(this).addClass('active btn-primary').siblings().removeClass('active btn-primary');
    });
</script>
</body>

<!-- END BODY -->
</html>