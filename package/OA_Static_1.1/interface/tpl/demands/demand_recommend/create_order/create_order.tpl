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
    <script type="text/javascript" src="js/jquery-1.9.1.min.js"></script>
    <link rel="stylesheet"  href="{$_assets}/plugins/bootstrap-fileinput/bootstrap-fileinput.css"/>
    <script type="text/javascript" src="{$_assets}/plugins/bootstrap-fileinput/bootstrap-fileinput.js"></script>
</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->
<body style="background:#FaFaFa !important">
<div class="portlet">
    <div class="portlet-title">
        <div class="caption">
            <i class="fa fa-cogs"></i>
            生成订单
        </div>
    </div>
<div class="portlet-body">
<form action="?action=create_order_submit" method="post" enctype="multipart/form-data" class="clearfix form-horizontal">
    <input type="hidden" name="data[demand_id]" value="{$data['demand_id']}">
    <div class="form-body">
        <div class="form-group">
            <label class="col-md-3 control-label">产品ID</label>
            <div class="col-md-3 col-sm-12">
                <input type="hidden" value="{$reamend_id}" name="data[recommend_id]">
                <input type="text" class="form-control" placeholder="产品ID" name="data[product_id]" readonly="true" value="{$data['product_id']}">
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-3 control-label">供应商名称</label>
            <div class="col-md-3 col-sm-12">
                <input type="text" class="form-control" placeholder="供应商名称" name="data[供应商名称]"value="{$data['vendor_name']}" >
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-3 control-label">供应商签约代表</label>
            <div class="col-md-3 col-sm-12">
                <input type="text" class="form-control" placeholder="供应商签约代表" name="data[供应商签约代表]"  value="{$data['username']}">
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-3 control-label">客户名称</label>
            <div class="col-md-3 col-sm-12">
                <input type="text" class="form-control" placeholder="客户名称" name="data[客户名称]"value="{$account['attr']['identity']['data']['公司名称']}" >
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-3 control-label">客户签约代表</label>
            <div class="col-md-3 col-sm-12">
                <input type="text" class="form-control" placeholder="客户签约代表" name="data[客户签约代表]"  value="{$account['identity']['data']['法人代表']}">
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-3 control-label">开始时间</label>
            <input type="hidden" name="data[is_schedule]" value="1">
            <div class="col-md-3 col-sm-12">
                <div class='input-group date' id='datetimepicker1' style="width: 160px;">
                    <input type='text' class="form-control" id='datetimepicker_input1' placeholder="请选择" name="data[start_date]"/>
                            <span class="input-group-addon">
                                <span class="glyphicon glyphicon-calendar"></span>
                            </span>
                </div>
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-3 control-label">结束时间</label>
            <div class="col-md-3 col-sm-12">
                <div class='input-group date' id='datetimepicker2' style="width: 160px;">
                    <input type='text' class="form-control" id='datetimepicker_input2' placeholder="请选择" name="data[end_date]"/>
                            <span class="input-group-addon">
                                <span class="glyphicon glyphicon-calendar"></span>
                            </span>
                </div>
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-3 control-label">交易总计</label>
            <div class="col-md-3 col-sm-12">
                <div class='input-group date'  style="width: 160px;">
                   <input type='text' class="form-control" placeholder="单位：元/￥ " name="data[交易总计]"/>
                </div>
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-3 control-label">支付方式</label>
            <div class="col-md-3 col-sm-12">
                   <label class=" control-label">
                       <input type='checkbox' name="data[支付方式]"value="线下支付" />
                   线下支付</label>
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-3 control-label">交付时间</label>
            <div class="col-md-3 col-sm-12">
                <div class='input-group date' id='DeliveryTime' style="width: 160px;">
                    <input type='text' class="form-control" id='DeliveryTime_input' placeholder="交付时间" name="data[交付时间]"/>
                            <span class="input-group-addon">
                                <span class="glyphicon glyphicon-calendar"></span>
                            </span>
                </div>
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-3 control-label">活动类型</label>
            <div class="col-md-3 col-sm-12">
                <div class='input-group date' style="width: 160px;">
                    <select name="data[活动类型]">
                        {foreach $_activity as $key =>$val}
                            <option >{$val}</option>
                        {/foreach}
                    </select>
                </div>
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-3 control-label">备注</label>
            <div class="col-md-9">
                   <textarea name="data[备注]"></textarea>
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-3 control-label">上传附件</label>
            <div class="fileinput fileinput-new" data-provides="fileinput">
                <div class="hidden jyyd_files">
                    <div class="fujian" >
                        <i class="fa fa-paperclip"></i><span></span>
                        <input type="hidden" name="data[附件][$$][path]">
                        <input type="hidden" name="data[附件][$$][name]">
                        <em  onclick="annex_del($(this))" style="cursor: pointer;color: red" data-id="">×</em>
                    </div>
                </div>
                <div id="jyyd_files">
                </div>
                <i class="fa fa-bell"></i> 不能上传超过20MB的文件!
                {include file="Admin::inc/plupload.tpl"}
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
<link href='css/fullcalendar.css' rel='stylesheet'/>
<link href='css/fullcalendar.print.css' rel='stylesheet' media='print'/>
<script type="text/javascript" src="js/moment.min.js"></script>
<script type="text/javascript" src="js/zh-cn.js"></script>
<script type="text/javascript" src="js/jquery.lazyload.js"></script>
<script type="text/javascript" src="js/bootstrap-datetimepicker.min.js"></script>
<script src='js/fullcalendar.js'></script>
<script>
    $(document).ready(function () {
        var moment1 = moment('2015-02-02');
        var moment2 = moment('2015-09-09');
        $.fullCalendar.formatRange(moment1, moment2, 'MMMM D YYYY');
        $('#datetimepicker1').datetimepicker({
            format: 'YYYY-MM-DD',
            locale: 'zh-cn'
        });

        $('#datetimepicker2').datetimepicker({
            format: 'YYYY-MM-DD',
            locale: 'zh-cn'
        });
        $('#datetimepicker_input1').datetimepicker({
            format: 'YYYY-MM-DD',
            locale: 'zh-cn'
        });
        $('#datetimepicker_input2').datetimepicker({
            format: 'YYYY-MM-DD',
            locale: 'zh-cn'
        });

        $('#DeliveryTime').datetimepicker({
            format:'YYYY-MM-DD',
            locale:'zh-cn'
        });
        $('#DeliveryTime_input').datetimepicker({
            format:'YYYY-MM-DD',
            locale:'zh-cn'
        });
        $("#datetimepicker6").on("dp.change", function (e) {
            $('#datetimepicker7').data("DateTimePicker").minDate(e.date);
        });
        $("#datetimepicker7").on("dp.change", function (e) {
            $('#datetimepicker6').data("DateTimePicker").maxDate(e.date);
        });
    });

    var fileIndex = $('#jyyd_files>div').size() + 10;
    uploader.onFileUploaded = function (file, path) {
        if (!path) {
            return alert(file.name + ' 上传失败!');
        }
        addFile(file.name, path,file.id);
    }
    function addFile(name, path,id){
        fileIndex++;
        var newFile = $('.jyyd_files .fujian').clone();
        newFile.find('input').each(function () {
            $(this).attr('name', $(this).attr('name').replace('$$', fileIndex));
        });
        newFile.find('input:eq(0)').val(path);
        newFile.find('input:eq(1)').val(name);
        newFile.find('span').text(name);
        newFile.find('em').attr('data-id',id);
        newFile.appendTo('#jyyd_files');
    }
</script>
</body>
</html>