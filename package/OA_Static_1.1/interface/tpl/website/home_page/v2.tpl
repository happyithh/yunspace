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
        <i class="fa fa-database"></i>其他内容管理
    </div>
</div>
<div style="text-align: center;">
    <button  class="btn btn-danger btn-default clear_all">
        清除页面所有缓存
    </button>
</div>
<div class="portlet-body form">
<form class="form-horizontal" role="form" action="?" method="post" enctype="multipart/form-data">
<input type="hidden" name="city" value="{$_REQUEST['city']}">
    <div class="cols-md-3">
        对应城市首页:
        <select class="form-control" name="city" onchange="changeCity(this)">
            {foreach $_REQUEST['cities'] as $v}
                <option value="{$v}" {if $v==$_REQUEST['city']}selected="selected" {/if}>
                    {$v}
                </option>
            {/foreach}
        </select>
    </div>

<!-------------------------------广告位------------------------------>
{*<div class="captions">
    <i class="fa fa-reorder"></i>广告位
    ( <span style="width:100%;text-align: left !important;font-size: 12px;color: red" colspan="4">
                    注意：广告位banner,宽度：1180px ,高度:90px,上传jpg图片
        *}{*</td>*}{*
            </span>)
</div>
<div style="padding: 20px ;">
    <div class="form-group">
        <table class="table table-hover">
            <thead>
            <tr>
                <th width="120">名称</th>
                <th width="100">缩略图</th>
                <th>需要替换的图片</th>
                <th width="10%">标题</th>
                <th width="30%">指向链接</th>
            </tr>
            </thead>
            <tbody>

            {foreach $_data6['advertising'] as $k=>$v}
                <tr style="border-bottom: 1px solid #ccc">
                    <td>
                        <input class="form-control" type="text" readonly name="data[advertising][广告位][{$k}][name]"
                               value="{$v['name']}">
                    </td>
                    <td>
                        <img src="{$v['path']}" style="height: 80px; width: 80px; ">
                    </td>
                    <td>
                        <input type="file" name="advertise{$k}" value=""/>
                        <input type="hidden" name="data[advertising][广告位][{$k}][path]" value="{$v['path']}"/>
                    </td>
                    <td>
                        <input class="form-control" type="text" name="data[advertising][广告位][{$k}][title]"
                               value="{$v['title']}" placeholder="图片标题">
                    </td>
                    <td>
                        <input class="form-control" type="text" name="data[advertising][广告位][{$k}][url]"
                               value="{$v['url']}">
                    </td>
                </tr>
            {/foreach}
            </tbody>
        </table>
    </div>
</div>*}
<!---------------------其他内容管理------------------------------>
{*<div class="captions">
    <i class="fa fa-reorder"></i>其他内容管理
</div>*}
<div class=" tabbable tabbable-custom boxless" style="padding: 20px ;">
    {*<div class="form-group">*}
    {*<label class="col-md-3 control-label">热门套餐</label>*}

    {*<div class="col-md-6">*}
    {*<textarea class="form-control" rows="3"*}
    {*name="data[hotContent][热门套餐]">{$_data2['hotContent']['热门套餐']}</textarea>*}
    {*<textarea class="form-control" rows="3" name="data[hotContent][热门套餐]"></textarea>*}
    {*</div>*}
    {*</div>*}
    {*<div class="form-group">*}
    {*<label class="col-md-3 control-label">热门空间</label>*}

    {*<div class="col-md-6">*}
    {*<textarea class="form-control" rows="4"*}
    {*name="data[hotContent][热门空间]">{$_data2['hotContent']['热门空间']}</textarea>*}
    {*</div>*}
    {*</div>*}
    {*<div class="form-group">*}
    {*<label class="col-md-3 control-label">热门场地搭建</label>*}

    {*<div class="col-md-6">*}
    {*<textarea class="form-control" rows="4"*}
    {*name="data[hotContent][热门场地搭建]">{$_data2['hotContent']['热门场地搭建']}</textarea>*}
    {*</div>*}
    {*</div>*}
    {*<div class="form-group">*}
    {*<label class="col-md-3 control-label">多媒体制作</label>*}

    {*<div class="col-md-6">*}
    {*<textarea class="form-control" rows="4"*}
    {*name="data[hotContent][多媒体制作]">{$_data2['hotContent']['多媒体制作']}</textarea>*}
    {*</div>*}
    {*</div>*}

    {*<div class="form-group">*}
    {*<label class="col-md-3 control-label">新奇特</label>*}

    {*<div class="col-md-6">*}
    {*<textarea class="form-control" rows="4"*}
    {*name="data[hotContent][新奇特]">{$_data2['hotContent']['新奇特']}</textarea>*}
    {*</div>*}
    {*</div>*}
    <table class="table table-hover">
        <thead>
        <tr>
            <th width="30%" style="text-align: center"> 类型</th>
            <th width="30%">链接（以下内容都放链接,每条用逗号分隔，一条链接放一行)</th>
            {*<th width="30%" style="color: red">标题（以下内容都放链接，每条用逗号分隔)</th>*}
        </tr>
        </thead>
        <tbody>
        <tr>
            <td class="topTitle">
                超值套餐
            </td>
            <td>
                <textarea class="form-control" rows="6"
                          name="data[hotContent][超值套餐]">{$_data2['hotContent']['超值套餐']}</textarea>
            </td>
            {*<td><textarea class="form-control" rows="3"*}
                          {*name="data[hotTitle][超值套餐]">{$_data2['hotTitle']['超值套餐']}</textarea>*}
            {*</td>*}
        </tr>
        <tr>
            <td class="topTitle">
                秀场展馆
            </td>
            <td>
                <textarea class="form-control" rows="6"
                          name="data[hotContent][秀场展馆]">{$_data2['hotContent']['秀场展馆']}</textarea>
            </td>
            {*<td><textarea class="form-control" rows="3"*}
                          {*name="data[hotTitle][秀场展馆]">{$_data2['hotTitle']['秀场展馆']}</textarea>*}
            {*</td>*}
        </tr>
        <tr>
            <td class="topTitle">
                商业广场
            </td>
            <td>
                <textarea class="form-control" rows="6"
                          name="data[hotContent][商业广场]">{$_data2['hotContent']['商业广场']}</textarea>
            </td>
            {*<td><textarea class="form-control" rows="3"*}
                          {*name="data[hotTitle][商业广场]">{$_data2['hotTitle']['商业广场']}</textarea>*}
            {*</td>*}
        </tr>
        <tr>
            <td class="topTitle">
                高端会所
            </td>
            <td>
                <textarea class="form-control" rows="6"
                          name="data[hotContent][高端会所]">{$_data2['hotContent']['高端会所']}</textarea>
            </td>
            {*<td><textarea class="form-control" rows="3"*}
                          {*name="data[hotTitle][高端会所]">{$_data2['hotTitle']['高端会所']}</textarea>*}
            {*</td>*}
        </tr>
        <tr>
            <td class="topTitle">
                配套服务
            </td>
            <td>
                <textarea class="form-control" rows="6"
                          name="data[hotContent][配套服务]">{$_data2['hotContent']['配套服务']}</textarea>
            </td>
            {*<td><textarea class="form-control" rows="3"*}
                          {*name="data[hotTitle][热门套餐]">{$_data2['hotTitle']['配套服务']}</textarea>*}
            {*</td>*}
        </tr>

        </tbody>
    </table>

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
    function changeCity(o) {
        var href = window.location.href + '?';
        window.location = href.substr(0, href.indexOf('?')) + '?city=' + $(o).val() + '&t=' + (new Date()).valueOf();
    }
    $('.clear_all').on('click',function(){
        $.ajax({
            type: "GET",
            url: "http://{Core::$urls['host']}/static/api/common/cache.json",
            data: 'subTable=html_cache&token=e702784057ca97c9b08cc948b8d4e979',
            dataType: "json",
            success: function(data){
                if(data.status==1){
                    top.alert('  已清除所有缓存');
                }else{
                    top.alert(data.msg);
                }
            }
        });
    });
</script>
</body>

<!-- END BODY -->
</html>