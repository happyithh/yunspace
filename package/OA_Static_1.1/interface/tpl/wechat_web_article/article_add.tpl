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
    <script src="{$_assets}plugins/jquery-1.11.0.min.js" type="text/javascript"></script>
    <script src="{$_assets}plugins/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="{$_assets}plugins/select2/select2.min.js"></script>

    <link rel="stylesheet" href="{$_assets}/plugins/bootstrap-fileinput/bootstrap-fileinput.css"/>
    <script type="text/javascript" src="{$_assets}/plugins/bootstrap-fileinput/bootstrap-fileinput.js"></script>
    <link href="css/bootstrap-datetimepicker.min.css" rel="stylesheet"/>
    <title>{$title}</title>
    <meta content="" name="description"/>
    {include "Admin::inc/html_head.tpl"}
    <style>
        table tr th{
            text-align: center;
        }
        table tr td input{
            width: 150px;
            height: 30px;
        }
        img{
            width: 180px;
            height:180px;
        }
        #link{
            display: none;
        }
    </style>
</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->

<body style="background:#FaFaFa !important">
<div class="portlet">
    <div class="portlet-title">
        <div class="caption">
            <i class="fa fa-reorder"></i>添加新的文章
        </div>
    </div>
    <div class="portlet-body">
        <form action="?action=submit_edit" method="post" class="clearfix form-horizontal">
            <div class="form-body">
                <input  type="hidden" name="aid"  value="{$info['id']}"/>
                <input type="hidden" name="url_referer" value="{Core::$urls['referer']}">
                <div class="clearfix">
                    <div class="form-group col-md-9">
                        <label class="col-md-3 control-label">文章名称</label>

                        <div class="col-md-9">
                            <input type="text" class="form-control input-sm" placeholder="文章名称" name="title" value="{$info['title']}">
                        </div>
                    </div>
                    <div class="form-group col-md-9">
                        <label class="col-md-3 control-label">分类名称</label>
                        <div class="col-md-9">
                            <select name="category_id" class="form-control input-sm">
                                {foreach $category as $k=>$v}
                                <option value="{$v['id']}" {if $info['category_id']==$v['id']}selected {/if}>
                                    {$v['category']}
                                    {if $v['status'] == 0}
                                        <span>(已下线)</span>
                                    {/if}
                                    {if $v['status'] == -1}
                                        <span>(已删除)</span>
                                    {/if}
                                    {if $v['status'] == -2}
                                        <span>(已删除)</span>
                                    {/if}
                                </option>
                                {/foreach}
                            </select>
                        </div>
                    </div>
                    <div class="form-group col-md-9">
                        <label class="col-md-3 control-label">是否推荐</label>
                        <div class="col-md-9">
                            <label class="radio-inline " >
                                <input type="radio" name="is_recommend" value="1" {if $info['is_recommend']==1}checked{/if}>
                                推荐
                            </label>
                            <label class="radio-inline " >
                                <input type="radio" name="is_recommend" value="-1" {if $info['is_recommend']==-1 || empty($info['is_recommend'])}checked{/if}>
                                不推荐
                            </label>
                        </div>
                    </div>
                    <div class="form-group col-md-9">
                        <label class="col-md-3 control-label">图片</label>

                        <div class="col-md-9">
                            <input type="hidden" class="upload-action" data-action="http://{Core::$urls['host']}/static/api/upload/controller.json?action=uploadimage&filename=">
                            <div class="fileinput fileinput-new" data-provides="fileinput">
                                <input type="hidden" class="logo" name="image" value="{$info['image']}">
                                <div class="fileinput-new thumbnail" style="width: 120px; height: 80px;">
                                    {if $info['image']}
                                        <img src="{$info['image']}" alt="" class="event_logo_img"/>
                                    {else}
                                        <img src="img/no_image.png"
                                             alt="" class="event_logo_img" />
                                    {/if}
                                </div>
                                <div>
                                    <span class="btn btn-default btn-file">
                                        <span class="fileinput-new">选择图片</span>
                                         <input type="file" class="js-upload-file" name="logo" >
                                    </span>
                                    <span class="btn btn-danger js-remove-file" style="display: none">移除</span>
                                    <span style="color: #ff0000">宽高比例约：3：2</span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="form-group col-md-9">
                        <label class="col-md-3 control-label">简介</label>

                        <div class="col-md-9">
                            <input type="text" class="form-control input-sm" placeholder="文章一句话简介" name="introduction" value="{$info['introduction']}">
                            <span style="color: #ff0000">不超过50字</span>
                        </div>
                    </div>
                    <div class="form-group col-md-9">
                        <label class="col-md-3 control-label">上线/下线</label>

                        <div class="col-md-9">
                            <label class="radio-inline">
                                <input type="radio" name="status" value="1" {if $info['status']==1}checked{/if}>
                                上线
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="status" value="0" {if $info['status']==0}checked{/if}>
                                下线
                            </label>
                        </div>
                    </div>
                    {*{if empty($info['link']) && empty($info['content'])}*}
                        <div class="form-group col-md-9">
                            <label class="col-md-3 control-label">是否有外链接</label>
                            <div class="col-md-9">
                                <label class="radio-inline links" >
                                    <input type="radio" name="is_lnk" value="1" {if $info['is_lnk']==1}checked{/if}>
                                    有
                                </label>
                                <label class="radio-inline links" >
                                    <input type="radio" name="is_lnk" value="-1" {if $info['is_lnk']==-1}checked{/if}>
                                    没有
                                </label>
                            </div>
                        </div>
                        <div class="form-group col-md-9" id="content" {if $info['is_lnk']==1} style="display: none" {/if}>
                            <label class="col-md-3 control-label">文章内容</label>

                            <div class="col-md-9">
                                {include "Admin::inc/html_umeditor.tpl" name="content" height=300 value={$info['content']}}
                            </div>
                        </div>
                        <div class="form-group col-md-9" id="link" {if $info['is_lnk']==1} style="display: block" {/if}>
                            <label class="col-md-3 control-label">链接</label>
                            <div class="col-md-9">
                                <input type="text" class="form-control input-sm" placeholder="链接" value="{$info['link']}" name="link">
                            </div>
                        </div>
                    {*{/if}*}
                    {*{if empty($info['link']) && !empty($info['content'])}*}
                        {*<div class="form-group col-md-9">*}
                            {*<label class="col-md-3 control-label">文章内容</label>*}
                            {*<div class="col-md-9">*}
                                {*{include "Admin::inc/html_umeditor.tpl" name="content" value=$info['content'] height=300}*}
                            {*</div>*}
                        {*</div>*}
                    {*{/if}*}
                    {*{if empty($info['content']) && !empty($info['link'])}*}
                        {*<div class="form-group col-md-9">*}
                            {*<label class="col-md-3 control-label">链接</label>*}
                            {*<div class="col-md-9">*}
                                {*<input type="text" class="form-control input-sm" placeholder="链接" value="{$info['link']}" name="link">*}
                            {*</div>*}
                        {*</div>*}
                    {*{/if}*}
                </div>
                <div class="clearfix"></div>
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
<script type="text/javascript" src="js/moment.min.js"></script>
<script type="text/javascript" src="js/zh-cn.js"></script>
<script type="text/javascript" src="js/bootstrap-datetimepicker.min.js"></script>
<script type="text/javascript" src="js/qrcode.js"></script>
<script type="text/javascript" src="js/jquery.form.js"></script>
<script>
    $(document).ready(function () {
        $('.date').datetimepicker({
            format: 'YYYY-MM-DD',
            locale: 'zh-cn'
        });

        $(".js-upload-file").bind("change",function(){
            uploadImg(this);
        });
        $(".js-remove-file").bind("click",function(){
            removeFile(this);
        });
        function uploadImg(obj) {
            var filename = $(obj).attr("name");
            var forms = "<form class='myUpload' action='" + $(".upload-action").attr("data-action")+
                    filename +
                    "&maxsize=2097152' method='post' enctype='multipart/form-data'></form>";
            $(obj).parent().wrap(forms);
            $(".myUpload").ajaxSubmit({
                dataType: 'json',
                success: function (data) {
                    if (data.state == "SUCCESS") {
                        $(".event_logo_img").attr("src", data.url);
                        $(".logo").val(data.url);
                        $(obj).siblings("span.fileinput-new").show();
                        $(".js-remove-file").show();
                        $(".thumbnail").show();
                        $(obj).parent().unwrap(forms);
                        $(obj).val("");
                    } else {
                        alert(data.state);
                        $(obj).parent().unwrap(forms);
                    }
                },
                clearForm: true
            });
        }

        function removeFile(obj) {
            $(".event_logo_img").attr("src", '/package/OA_1.0a/interface/assets/img/no_image.png');
            $(obj).siblings("span.fileinput-new").show();
            $(".logo").val("");
            $(obj).hide();
        }
    });

    var LvEdit = function() {
        return {
            init: function() {
            },
            add: function(obj) {
                var obj1 = $(obj).parent().parent().parent().children('tr').eq(1).clone();
                obj = $(obj).parent().parent().parent().parent().find('tbody');
                obj1.appendTo(obj);
                obj1.removeClass("hide");
                var i = obj.children('tr').size()-1;
                var obj2 = obj1.find('input');
                obj2.eq(0).attr('name', 'event_name['+i+']');
                obj2.eq(1).attr('name', 'event_price['+i+']');
                obj2.eq(2).attr('name', 'event_time['+i+']');
                obj2.eq(2).datetimepicker({
                    format: 'YYYY-MM-DD',
                    locale: 'zh-cn'
                });
                obj2.eq(3).attr('name', 'event_stock['+i+']');
            },
            delete: function(obj) {
                $(obj).parent().parent().remove();
            }
        };
    }();
</script>
<script>
    $(".links").click(function(){
        var  link_v = $(this).find("input[type=radio]").val();
        if(link_v==-1){
            $("#link").hide();
            $("#content").show();
        }else{
            $("#link").show();
            $("#content").hide();
        }
    });
</script>
</body>
</html>