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
    </style>
</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->

<body style="background:#FaFaFa !important">
<div class="portlet">
    <div class="portlet-title">
        <div class="caption">
            <i class="fa fa-reorder"></i>添加新的分类
        </div>
    </div>
    <div class="portlet-body">
        <form action="?action=submit_edit" method="post" class="clearfix form-horizontal">
            <div class="form-body">
                <input  type="hidden" name="cid"  value="{$info['id']}"/>
                <input type="hidden" name="url_referer" value="{Core::$urls['referer']}">
                <div class="clearfix">
                    <div class="form-group col-md-9">
                        <label class="col-md-3 control-label">分类名称</label>

                        <div class="col-md-9">
                            <input type="text" class="form-control input-sm" placeholder="分类名称" name="category" value="{$info['category']}">
                        </div>
                    </div>
                    <div class="form-group col-md-9">
                        <label class="col-md-3 control-label">图片</label>

                        <div class="col-md-9">
                            <input type="hidden" class="upload-action" data-action="http://{Core::$urls['host']}/static/api/upload/controller.json?action=uploadimage&filename=">
                            <div class="fileinput fileinput-new" data-provides="fileinput">
                                <input type="hidden" class="logo" name="big_picture" value="{$info['big_picture']}">
                                <div class="fileinput-new thumbnail" style="width: 360px; height: 120px;">
                                    {if $info['big_picture']}
                                        <img src="{$info['big_picture']}" alt="" class="event_logo_img"/>
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
                                    <span style="color: #ff0000">宽高比例约：3：1</span>
                                </div>
                            </div>
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
                    <div class="form-group col-md-9">
                        <label class="col-md-3 control-label">是否在首页显示</label>

                        <div class="col-md-9">
                            <label class="radio-inline">
                                <input type="radio" name="is_show" value="1" {if $info['is_show']==1||!isset($info['is_show'])}checked{/if}>
                                显示
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="is_show" value="0" {if isset($info['is_show'])&&$info['is_show']==0}checked{/if}>
                                不显示
                            </label>
                        </div>
                    </div>
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
</body>
</html>