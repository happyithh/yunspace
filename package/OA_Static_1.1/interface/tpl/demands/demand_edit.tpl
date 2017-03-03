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

    {include "Admin::inc/html_head.tpl"}
    <title>{$title}</title>
    <style>
        .widthset {
            width: 80%;
            margin: 0 auto 20px;
        }

        /*@media(max-width: 1024px) {
            .widthset{
                width: 95%;
            }
        }*/
    </style>
</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->

<body style="background:#FaFaFa !important">
<div class="portlet">
<div class="portlet-title">
    <div class="caption">
        <i class="fa fa-reorder"></i>编辑需求
    </div>
</div>
<div class="portlet-body">
<form action="?" method="post" class="clearfix form-horizontal form-horiz-new">
<input type="hidden" name="demand_id" value="{$_REQUEST['demand_id']}">
{if !$department}
    <input name="action" value="receive_from_submit" type="hidden"/>
{else}
    <input name="action" value="submit_edit" type="hidden"/>
    <input name="department" value="{$department}" type="hidden"/>
{/if}
<input name="is_offer" value="0" type="hidden"/>

<div class="form-body">
<div class="clearfix">

    <div class="clearfix">
        {if $department != '销售部'}
            <div class="form-group col-md-9">
                <label class="col-md-3 control-label">通知<span class="required"
                                                              aria-required="true">*</span></label>

                <div class="col-md-9">
                    <select class="form-control" name='notice_city' onchange="getTeamName(this)"
                            style="width: 90px;float: left">
                        {foreach $_REQUEST['cities'] as $v}
                            <option value="{$v}" {if $_demand['city']==$v}selected{/if}>{$v}</option>
                        {/foreach}
                    </select>
                    <select class="form-control" name="notice_department"
                            style="width: 100px;float: left">
                        <option value="销售部">
                            销售部
                        </option>
                    </select>
                    <select class="form-control" name="notice_team" style="width: 200px;float: left">
                        <option value="0">请选择
                        </option>
                    </select>

                </div>
            </div>
        {/if}
        <div class="form-group col-md-9">
            <label class="col-md-3 control-label">需求类型<span class="required"
                                                            aria-required="true">*</span></label>

            <div class="col-md-9">
                {if $department=='销售部'}
                    <select class="form-control" name="data[需求类型]" style="width: 200px;float: left">

                        <option value="{$_demandType[6]}">{$_demandType[6]}</option>

                    </select>
                {else}
                    <select class="form-control" name="data[需求类型]" style="width: 200px;float: left">
                        {foreach $_demandType as $k=>$v}
                            <option value="{$v}"
                                    {if $v==$_demand['demand_type']}selected{/if}>{$v}</option>
                        {/foreach}
                    </select>
                {/if}
            </div>
        </div>
        <div class="form-group col-md-9">
            <label class="col-md-3 control-label">姓名<span class="required"
                                                          aria-required="true">*</span></label>

            <div class="col-md-9">
                <input type="text" class="form-control input-sm" placeholder="姓名" name="data[联系人]"
                       value="{$_demand['demand']['联系人']}">
            </div>
        </div>
        <div class="form-group col-md-9">
            <label class="col-md-3 control-label">手机号<span class="required"
                                                           aria-required="true">*</span></label>

            <div class="col-md-6">

                <input type="text" class="recentByPhone form-control input-sm "
                       placeholder="手机或电话-例：13888888888/0218888888" name="data[联系电话]"
                       value="{$_demand['phone']}">

            </div>

            <div class="col-md-3">

                <div class="btn btn-sm btn-primary" style="float: right"
                        >
                    查询该联系人是否有重复的需求存在
                </div>
            </div>

        </div>
        <div id='recent_demand' style="display: none"></div>
        <div class="form-group col-md-9">
            <label class="col-md-3 control-label">公司名称<span class="required"
                                                            aria-required="true">*</span></label>

            <div class="col-md-9">
                <input type="text" class="form-control input-sm" placeholder="公司名称" name="data[公司名称]"
                       value="{$_demand['demand']['公司名称']}" id="company">
            </div>
        </div>
        {*<div class="form-group col-md-9">*}
        {*<label class="col-md-3 control-label">服务类型</label>*}

        {*<div class="col-md-3">*}
        {*<select class="form-control input-sm business-kind-mbl" name="data[业务类型]" id="business">*}
        {*{foreach $categoryList[0] as $key=>$value}*}
        {*{if $value}*}
        {*<option value="{$key}{$value}">{$key}{$value}</option>*}
        {*{/if}*}
        {*{/foreach}*}
        {*</select>*}
        {*</div>*}

        {*<div class="col-md-3">*}
        {*<select class="form-control input-sm" name="data[业务子类]" id="subBusiness" value="">*}
        {*</select>*}
        {*</div>*}
        {*</div>*}

        <div class="form-group col-md-9">
            <label class="col-md-3 control-label">活动名称<span class="required"
                                                            aria-required="true">*</span></label>

            <div class="col-md-9">
                <input type="text" class="form-control input-lg"
                       placeholder="请输入您需要办XXXXXX活动" name="demand_name"
                       value="{$_demand['demand_name']}">
            </div>
        </div>
        <div class="form-group col-md-9">
            <label class="col-md-3 control-label">预算范围<span class="required"
                                                            aria-required="true">*</span></label>

            <div class="col-md-9 form-inline">
                <input type='text' class="form-control " placeholder="预算下限"
                       name="price_up" value="{$_demand['price_up']}"/>
                <input type='text' class="form-control " placeholder="预算上限"
                       name="price_down" value="{$_demand['price_down']}"/>
            </div>
        </div>
    </div>
    <div class="form-group col-md-9">
        <label class="col-md-3 control-label">活动类型</label>

        <div class="col-md-9">
            <select class="form-control" name="data[活动类型]">
                {foreach $tags as $key=>$val}
                    <option value="{$val}"
                            {if $_demand['demand']['活动类型']==$val}selected{/if}>{$val}</option>
                {/foreach}
                <option>其他</option>
            </select>
        </div>
    </div>

    <div class="form-group col-md-9">
        <label class="col-md-3 control-label">活动人数</label>

        <div class="col-md-9 form-inline">
            <select class="form-control" name="data[活动人数]">
                <option>请选择活动人数</option>
                {foreach $demand_options['people'] as $key=>$val}
                    <option value="{$val}"
                            {if $_demand['demand']['活动人数']==$val}selected{/if}>{$val}</option>
                {/foreach}
            </select>
        </div>
    </div>
    <div class="form-group col-md-9">
        <label class="col-md-3 control-label">场地类型</label>

        <div class="col-md-9 form-inline">
            <select class="form-control" name="data[场地类型]">
                <option>请选择场地类型</option>
                {foreach $categoryTree[112] as $key=>$val}
                    <option value="{$val}"
                            {if $_demand['demand']['场地类型']==$val}selected{/if}>{$val}</option>
                {/foreach}
            </select>
        </div>
    </div>
    <div class="form-group col-md-9">
        <label class="col-md-3 control-label">活动时间</label>

        <div class="col-md-9 form-inline" id="activity-time">
            <input type='text' class="form-control datetimepicker datetime-star" placeholder="开始时间"
                   name="data[开始时间]" value="{$_demand['demand']['开始时间']}"/>
            <input type='text' class="form-control datetimepicker" placeholder="结束时间"
                   name="data[结束时间]" value="{$_demand['demand']['结束时间']}"/>
        </div>
    </div>
    <div class="form-group col-md-9">
        <label class="col-md-3 control-label">需求场地</label>

        <div class="col-md-9">
            <input type="text" class="form-control input-sm" placeholder="场地"
                   name="data[需求场地]">
        </div>
    </div>
    <div class="form-group col-md-9">
        <label class="col-md-3 control-label">具体要求</label>

        <div class="col-md-9">
            <textarea class="form-control" rows="5"
                      name="data[具体要求]">{if $_demand['demand']['咨询内容']}{$_demand['demand']['咨询内容']}{else}{$_demand['demand']['具体要求']}{/if}</textarea>
        </div>
    </div>
</div>

<div class="text-center clearfix">
    <button type="reset" class="btn btn-default">
        重置
    </button>
    &nbsp;
    &nbsp;
    &nbsp;

    <button type="submit" class="btn btn-success">
        提交
    </button>
    &nbsp;
    &nbsp;
    &nbsp;
    {if $department != '销售部'}
        <button class="btn btn-info" id='demand_offer'>
            提交至报价系统
        </button>
        {*<span>提交至需求报价,通知的选项不会生效~</span>*}
    {/if}
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
<script src='js/demands/demands_getRecent.js'></script>
{static "core/yunspace.js"}
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
        var business_val = $('#business').attr('value');
        if (!business_val) {
            oSubBusiness(0);
        }
        getTeamName("select[name=notice_city]");

        /**
         *  提交到需求竞标
         */

        $("#demand_offer").on('click', function () {
            var s_time = $("#activity-time input").eq(0).val();
            var e_time = $("#activity-time input").eq(1).val();
            if (!s_time || !e_time) {
                top.alert('请填写活动时间');
                return false;
            }
            $("input[name=is_offer]").val(1);
            $('form').submit();

        });
    });

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
    //通知到相关人员
    //    $("select[name=notice_city]").on('onchange', function (e) {
    //        getTeamName(this);
    //    });
    function getTeamName(e) {
        var city = $(e).val();
        YunSpace.api('administrator/departmentgroup.json',
                {
                    city: city,
                    department: '销售部'
                }, function (data) {

                    if (data.status == 1) {
                        var dataList = data.data;
                        var team_option = '';
                        for (var key in dataList) {
                            team_option += "<option value='" + dataList[key]['team_name'] + "'>" + dataList[key]['team_name'] + "</option>";
                        }
                        $("select[name=notice_team]").html(team_option);
                    } else {
                        $("select[name=notice_team]").find('option').text('暂无数据');
                    }
                });
    }


    $("#company").focus(function () {
        $("#recent_demand").fadeOut(1000);
    });
    $('.btn-primary').click(function () {
        demand_recent.getRecent('.recentByPhone', '#recent_demand');
        $("#recent_demand").fadeIn(1000);
    })

</script>
</body>
</html>