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
            <i class="fa fa-reorder"></i>添加新活动及门票信息
        </div>
    </div>
    <div class="portlet-body">
        <form action="?action=submit_edit" method="post" class="clearfix form-horizontal">
            <div class="form-body">
                <input  type="hidden" name="eid"  value="{$info['id']}"/>
                <div class="clearfix">
                    <div class="form-group col-md-9">
                        <label class="col-md-3 control-label">活动名称</label>

                        <div class="col-md-9">
                            <input type="text" class="form-control input-sm" placeholder="活动名称" name="title" value="{$info['title']}">
                        </div>
                    </div>
                    <div class="form-group col-md-9">
                        <label class="col-md-3 control-label">活动详情</label>

                        <div class="col-md-9">
                            <textarea class="form-control" rows="5" name="content">{$info['content']}</textarea>
                        </div>
                    </div>
                    <div class="form-group col-md-9">
                        <label class="col-md-3 control-label">门票类型</label>

                        <div class="col-md-9">
                            <label class="radio-inline">
                                <input type="radio" name="ticket_type" value="0" {if $info['ticket_type']==0}checked{/if}>
                                电子票
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="ticket_type" value="1" {if $info['ticket_type']==1}checked{/if}>
                                纸质实体票
                            </label>
                        </div>
                    </div>
                    <div class="form-group col-md-9">
                        <label class="col-md-3 control-label">是否需要邮寄</label>

                        <div class="col-md-9">
                            <label class="radio-inline">
                                <input type="radio" name="is_mail" value="0" {if $info['is_mail']==0}checked{/if}>
                                不需要
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="is_mail" value="1" {if $info['is_mail']==1}checked{/if}>
                                需要
                            </label>
                        </div>
                    </div>
                    <div class="form-group col-md-9">
                        <label class="col-md-3 control-label">活动图片</label>

                        <div class="col-md-9">
                            <input type="hidden" class="upload-action" data-action="http://{Core::$urls['host']}/static/api/upload/controller.json?action=uploadimage&filename=">
                            <div class="fileinput fileinput-new" data-provides="fileinput">
                                <input type="hidden" class="logo" name="event_logo" value="{$info['event_logo']}">
                                <div class="fileinput-new thumbnail" style="width: 200px; height: 150px;">
                                    {if $info['event_logo']}
                                        <img src="{$info['event_logo']}" alt="" class="event_logo_img"/>
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
                                </div>
                            </div>
                        </div>
                    </div>
                    {if !empty($info['id'])}
                    <div class="form-group col-md-9">
                        <label class="col-md-3 control-label">访问链接二维码</label>
                        <div class="col-md-9" id="qrcode" style="font-size: 16px;">
                        </div>
                    </div>
                    {/if}

                    <div class="form-group col-md-9">
                        <label class="col-md-3 control-label">活动地址</label>
                        <div class="col-md-9">
                            <input type="text" class="form-control input-sm" placeholder="请输入有效的活动地址" name="addr" value="{$info['addr']}">
                        </div>
                    </div>
                    <div class="form-group col-md-9">
                        <label class="col-md-3 control-label">检票人手机号</label>
                        <div class="col-md-9">
                            <input type="text" class="form-control input-sm" placeholder="检票人手机号 如果多人检票手机号用英文逗号,分割" name="checkticketphone" value="{$info['checkticketphone']}">
                        </div>
                    </div>
                    <div class="form-group col-md-9">
                        <label class="col-md-3 control-label">活动开始时间</label>
                        <div class="col-md-2" >
                            <input type='text' class="form-control date" placeholder="活动开始时间" name="activity_time"
                                   value="{if !empty($info['activity_time'])}{date('Y-m-d',$info['activity_time'])}{/if}"/>
                        </div>
                    </div>
                    <div class="form-group col-md-9">
                        <label class="col-md-3 control-label">活动有效期</label>
                            <div class="col-md-2" >
                                <input type='text' class="form-control date" placeholder="请选择开始时间" name="start_time"
                                       value="{if !empty($info['start_time'])}{date('Y-m-d',$info['start_time'])}{/if}"/>
                            </div>
                            <div style="display: block;float: left;line-height: 30px;height: 30px;text-align: center;margin-left: 2px;">
                                ----
                            </div>
                            <div class="col-md-2" >
                                <input type='text' class="form-control date" placeholder="请选择结束时间" name="end_time"
                                       value="{if !empty($info['end_time'])}{date('Y-m-d',$info['end_time'])}{/if}"/>
                            </div>
                    </div>


                    <div class="form-group col-md-9">
                        <label class="col-md-3 control-label">添加门票</label>
                        <div class="col-md-9">
                        <table class="table table-striped table-bordered table-hover">
                            <thead>
                            <tr >
                                <th width="30%" >票名</th>
                                <th  width="15%">价格</th>
                                <th  width="30%">时间</th>
                                <th  width="15%">库存</th>
                                <th  width="10%">
                                    <span class="btn btn-mini btn-success span12" onclick="LvEdit.add(this)">
                                        添加 <i class="icon-plus"></i>
                                    </span>
                                </th>
                            </tr>
                            <tr class="hide">
                                <td><input type="text" placeholder="票名" class="form-control"/></td>
                                <td><input type="text" placeholder="价格" class="form-control"/></td>
                                <td>
                                    <input type='text' placeholder="时间格式：2015-08-04" class="form-control"  value=""/>
                                </td>
                                <td><input type="text" placeholder="库存" class="form-control"/></td>
                                <td><span class='cp' onclick="LvEdit.delete(this)"><i class="fa fa-bitbucket"></i></span></td>
                            </tr>
                            </thead>
                            <tbody class="sortable">
                            {foreach $ticketlist as $k=>$v}
                                <tr>
                                    <input type="hidden" name="event_id[{$k}]" value="{$v['id']}" />
                                    <td><input type="text" placeholder="票名"  class="form-control" name="event_name[{$k}]" value="{$v['name']}" /></td>
                                    <td><input type="text" placeholder="价格" class="form-control" name="event_price[{$k}]" value="{$v['price']}" /></td>
                                    <td>
                                        <input type='text'  placeholder="时间格式：2015-08-04" class="form-control date" name="event_time[{$k}]" value="{if !empty($v['event_time'])}{$v['event_time']}{/if}" />
                                    </td>
                                    <td><input type="text" placeholder="库存" class="form-control" name="event_stock[{$k}]" value="{$v['stock']}" /></td>
                                    <td><span href="#" class='cp' onclick="LvEdit.delete(this)"><i class="fa fa-bitbucket"></i></span></td>
                                </tr>
                            {/foreach}
                            </tbody>
                        </table>
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

        {if $info['id']}
            //访问连接二维码生成
            var url = 'http://{Core::$urls['host']}/m/ticket/?event_id={$info['id']}';
//            //参数1表示图像大小，取值范围1-10；参数2表示质量，取值范围'L','M','Q','H'
            var qr = qrcode(10, 'M');
            qr.addData(url);
            qr.make();
            var wording=document.createElement('p');
            wording.innerHTML = "点击二维码，右键保存";
            var code=document.createElement('DIV');
            code.innerHTML = qr.createImgTag();
            var element=document.getElementById("qrcode");
            element.appendChild(wording);
            element.appendChild(code);
        {/if}
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