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
    <link href="css/bootstrap-datetimepicker.min.css" rel="stylesheet"/>
    <script type="text/javascript" src="{$_assets}/plugins/bootstrap-fileinput/bootstrap-fileinput.js"></script>
    <title>{$title}</title>
    <meta content="" name="description"/>
    {include "Admin::inc/html_head.tpl"}
</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->

<body style="background:#FaFaFa !important">
<div class="portlet">
    <div class="portlet-title">
        <div class="caption">
            <i class="fa fa-reorder"></i>创建需求和联系人
        </div>
    </div>
    <div class="portlet-body">
        <form action="?action=submit_edit" method="post" class="clearfix form-horizontal form-horiz-new">
            {if $department=='销售部'}
                <input type="hidden" name="is_my" value="1"/>
            {/if}
            <div class="form-body">
                <div class="clearfix">
                    <div class="form-group col-md-9">
                        <label class="col-md-3 control-label sub_business">联系人类型</label>

                        <div class="col-md-9" id="type_but">
                            <label class="radio-inline">
                                <input type="radio" name="data[type]" value="1" checked>
                                客户
                            </label>
                            {if $department=='运营部'}
                                <label class="radio-inline">
                                    <input type="radio" name="data[type]" value="21">
                                    供应商
                                </label>
                            {/if}
                        </div>
                    </div>
                    <div class="clearfix" id="customerType">
                        <div class="form-group col-md-9">
                            <label class="col-md-3 control-label sub_business">客户类型：</label>

                            <div class="col-md-9">
                                <label class="radio-inline">
                                    <input type="radio" name="data[customer_type]" value="2" checked>
                                    标准产品客户
                                </label>
                                <label class="radio-inline">
                                    <input type="radio" name="data[customer_type]" value="1">
                                    KA客户
                                </label>

                            </div>
                        </div>
                        <div class="form-group col-md-9">
                            <label class="col-md-3 control-label">手机号<span class="required" aria-required="true">*</span></label>

                            <div class="col-md-9">
                                <input type="text" class="form-control input-sm" placeholder="手机或电话-例：13888888888/0218888888" name="data[手机号]">
                            </div>
                        </div>
                        <div class="form-group col-md-9">
                            <label class="col-md-3 control-label">姓名<span class="required" aria-required="true">*</span></label>

                            <div class="col-md-9">
                                <input type="text" class="form-control input-sm" placeholder="姓名" name="data[姓名]">
                            </div>
                        </div>
                        <div class="form-group col-md-9">
                            <label class="col-md-3 control-label">公司名称<span class="required" aria-required="true">*</span></label>

                            <div class="col-md-9">
                                <input type="text" class="form-control input-sm" placeholder="公司名称" name="data[公司名称]">
                            </div>
                        </div>
                    </div>
                    <div class="form-group col-md-9">
                        <label class="col-md-3 control-label">业务类型<span class="required" aria-required="true">*</span></label>

                        <div class="col-md-3">
                            <select class="form-control input-sm business-kind-mbl" name="data[业务类型]" id="business">
                                {foreach $categoryList[0] as $key=>$value}
                                    {if $value}
                                        <option value="{$key}{$value}">{$key}{$value}</option>
                                    {/if}
                                {/foreach}
                            </select>
                        </div>
                        <label class="col-md-3 control-label sub_business">业务子类</label>

                        <div class="col-md-3">
                            <select class="form-control input-sm" name="data[业务子类]" id="subBusiness" value="">
                            </select>
                        </div>
                    </div>
                    <div class="form-group col-md-9">
                        <label class="col-md-3 control-label">需求类型<span class="required" aria-required="true">*</span></label>

                        <div class="col-md-9">
                            <select class="form-control input-sm" name="data[需求类型]">
                                {foreach $_demandType as $val}
                                   <option value="{$val}">{$val} </option>
                                {/foreach}
                            </select>
                        </div>

                    </div>
                    <div class="form-group col-md-9">
                        <label class="col-md-3 control-label">城市<span class="required" aria-required="true">*</span></label>

                        <div class="col-md-9">
                            <select class="form-control" name="data[城市]">
                                {foreach $_REQUEST['cities'] as $v}
                                    <option value="{$v}">{$v}</option>
                                {/foreach}
                                <option>其他</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-group col-md-9">
                        <label class="col-md-3 control-label">活动类型</label>

                        <div class="col-md-9">

                            <select class="form-control" name="data[活动类型]">
                                {foreach $tags as $key=>$val}
                                    <option value="{$val}">{$val}</option>
                                {/foreach}
                                <option>其他</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-group col-md-9">
                        <label class="col-md-3 control-label">人数</label>

                        <div class="col-md-9">
                            <input type="text" class="form-control input-sm" placeholder="活动人数" name="data[人数]">
                        </div>
                    </div>
                    <div class="form-group col-md-9">
                        <label class="col-md-3 control-label">档期</label>

                        <div class="col-md-9 form-inline">
                            <input type='text' class="form-control datetimepicker datetime-star" placeholder="开始时间" name="data[开始时间]"/>
                            <input type='text' class="form-control datetimepicker" placeholder="结束时间" name="data[结束时间]"/>
                        </div>
                    </div>
                    <div class="form-group col-md-9">
                        <label class="col-md-3 control-label">场地</label>

                        <div class="col-md-9">
                            <input type="text" class="form-control input-sm" placeholder="场地" name="data[场地]">
                        </div>
                    </div>
                    <div class="form-group col-md-9">
                        <label class="col-md-3 control-label">需求内容</label>

                        <div class="col-md-9">
                            <textarea class="form-control" rows="5" name="data[具体要求]"></textarea>
                        </div>
                    </div>
                </div>

                <div class="text-center clearfix">
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

        $('.datetimepicker').datetimepicker({
            format: 'YYYY-MM-DD',
            locale: 'zh-cn'
        });

        $("#datetimepicker6").on("dp.change", function (e) {
            $('#datetimepicker7').data("DateTimePicker").minDate(e.date);
        });
        $("#datetimepicker7").on("dp.change", function (e) {
            $('#datetimepicker6').data("DateTimePicker").maxDate(e.date);
        });
    });

    $("#type_but input").on("click", function (e) {
        var type = $(this).val();
        if (type == 21) {
            $("#customerType").hide();
        }
        if (type == 1) {
            $("#customerType").show();
        }
    })
    var category = [
        {foreach $categoryList[0] as $k=>$v}
        {if $v}
        {
            'b': '{$k}{$v}',
            's': [
                {foreach $categoryList[$k] as $kk=>$vv}{if $vv}
                '{$kk}{$vv}',
                {/if}{/foreach}
            ]
        },
        {/if}
        {/foreach}
    ];
    $(document).ready(function () {
        var business_val = $('#business').attr('value');
        if (!business_val) {
            oSubBusiness(0);
        }
    })
    var bHtml = '<option value="{$data['business']}">{$data['business']}</option>';
    $('#business').change(function () {
        var index = $('#business').get(0).selectedIndex;
        if (index >= 0) {
            oSubBusiness(index);
        } else {
            $('#subBusiness').attr("disabled", true);
            $('#subBusiness').html('<option value="{$data['sub_business']}">{$data['sub_business']}</option>');
        }

    })
    for (var i = 0; i < category.length; i++) {
        bHtml += "<option value='" + category[i]['b'] + "'>" + category[i]['b'] + "</option>";
    }

    var oSubBusiness = function (i) {
        var oSubBusinessList = category[i]['s'], sHtml;
        for (var j = 0; j < category[i]['s'].length; j++) {
            sHtml += "<option value='" + category[i]['s'][j] + "'>" + category[i]['s'][j] + "</option>";
        }
        $('#subBusiness').html(sHtml);
        $('#subBusiness').removeAttr('disabled')
    }

    {*$('#business').html(bHtml);*}
</script>
</body>
</html>