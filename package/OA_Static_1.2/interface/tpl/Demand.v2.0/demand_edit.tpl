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
    <link rel="stylesheet" href="{$_assets}plugins/select2/select2.css"/>
    <link rel="stylesheet" href="{$_assets}/plugins/bootstrap-fileinput/bootstrap-fileinput.css"/>
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
    {*{include "OA_Static::demands/inc/countdown.tpl"  value="{$_demand['end_time']}" }*}
    {*{include "OA_Static::Demand.v2.0/inc/handle_delay.tpl"  value="{$_demand['end_time']}" demand_id="{$_demand['id']}" }*}

</div>
<div class="portlet-body">
    <form action="?" method="post" class="clearfix form-horizontal form-horiz-new">
        <input type="hidden" name="demand_id" value="{$_REQUEST['demand_id']}">
        {*handleDemandReceiveFromSubmit*}
        {if $demand_receive==1}
            <input name="action" value="receive_from_submit" type="hidden"/>
        {else}
            <input name="action" value="demand_edit_submit" type="hidden"/>
        {/if}
        {*{if !$department}*}

        {*{else}*}
            {*<input name="action" value="submit_edit" type="hidden"/>*}
            {*<input name="department" value="{$department}" type="hidden"/>*}
        {*{/if}*}
        <div class="form-body">
            <div class="clearfix">

                <div class="clearfix">


                    <div class="form-group col-md-9">
                        <label class="col-md-3 control-label">活动城市<span class="required"
                                                                        aria-required="true">*</span></label>

                        <div class="col-md-4 form-inline">
                            <input type="text" class="form-control select2 " id="city-select" style="width: 100%;"
                                   value="{if $_demand['city']}{$_demand['city']}{else}{$_COOKIE['city']}{/if}"
                                   data-values="{implode(',',$_REQUEST['cities'])}" name="data[活动城市]">
                            {*<select class="form-control " id="#city-selec" name="data[活动城市]">*}
                            {*{foreach $_REQUEST['cities'] as $v}*}
                            {*<option value="{$v}"*}
                            {*{if $v==$_COOKIE['city']}selected{/if}>{$v}</option>*}
                            {*{/foreach}*}
                            {*</select>*}
                        </div>
                        <div class="col-md-4 form-inline">
                            <label class="">通知到</label>
                            <select class="form-control" name="notice_city">
                                <option value="不通知" selected> 不通知</option>
                                {foreach $_REQUEST['cities'] as $v}
                                    <option value="{$v}">{$v}</option>
                                {/foreach}
                            </select>
                            <label>销售部</label>
                        </div>

                    </div>
                    <div class="form-group col-md-9">
                        <label class="col-md-3 control-label">需求类型<span class="required"
                                                                        aria-required="true">*</span></label>

                        <div class="col-md-3">

                            <select class="form-control" name="data[需求类型]">
                                {if $_demand['demand_type']}
                                    <option value="{$_demand['demand_type']}" selected>{$_demand['demand_type']}</option>
                                {else}
                                    {foreach $_demandType as $k=>$v}
                                            <option value="{$v}">{$v}</option>
                                    {/foreach}
                                {/if}
                            </select>
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
                        <label class="col-md-3 control-label">是否公开手机号<span class="required"
                                                                       aria-required="true">*</span></label>

                        <div class="col-md-6">

                            是<input type="radio" name="is_phone" value="1">&nbsp;
                            否<input type="radio" name="is_phone" value="2" checked="checked">
                        </div>

                    </div>
                    <div class="form-group col-md-9 phone">
                        <label class="col-md-3 control-label">手机号<span class="required"
                                                                       aria-required="true">*</span></label>

                        <div class="col-md-6">

                            <input type="text" class="recentByPhone form-control input-sm "
                                   placeholder="手机或电话-例：13888888888/0218888888" name="data[联系电话]"
                                   value="{$_demand['phone']}">
                        </div>

                        <div class="col-md-3">

                            <div class="btn btn-sm btn-primary" style="float: right">
                                查询该联系人是否有重复的需求存在
                            </div>
                        </div>

                    </div>
                    <div id='recent_demand' style="display: none"></div>
                    <div class="form-group col-md-9">
                        <label class="col-md-3 control-label">公司名称</label>

                        <div class="col-md-9">
                            <input type="text" class="form-control input-sm" placeholder="公司名称" name="data[公司名称]"
                                   value="{$_demand['demand']['公司名称']}" id="company">
                        </div>
                    </div>
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
                            <input type='text' class="form-control " placeholder="预算上限"
                                   name="price_up" value="{$_demand['price_up']}"/>
                            <input type='text' class="form-control " placeholder="预算下限"
                                   name="price_down" value="{$_demand['price_down']}"/>
                        </div>
                    </div>
                </div>
                <div class="form-group col-md-9">
                    <label class="col-md-3 control-label">活动类型</label>

                    <div class="col-md-9">
                        <select class="form-control" name="data[活动类型]">
                            <option value="{$_demand['demand']['活动类型']}">{$_demand['demand']['活动类型']}</option>
                            {foreach $tags as $key=>$val}
                                <option value="{$val}"
                                        {if $_demand['demand']['活动类型']==$val}selected{/if}>{$val}</option>
                            {/foreach}
                            <option>其他</option>
                        </select>
                    </div>
                </div>

                <div class="form-group col-md-9">
                    <label class="col-md-3 control-label">活动人数<span class="required"
                                                                    aria-required="true">*</span></label>

                    <div class="col-md-9 form-inline">
                        <select class="form-control activity-people" name="data[活动人数]">
                            <option value="">请选择活动人数</option>
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
                    <label class="col-md-3 control-label">活动时间<span class="required"
                                                                    aria-required="true">*</span></label>

                    <div class="col-md-9 form-inline">
                        <input type='text' class="form-control datetimepicker datetime-star" placeholder="开始时间"
                               name="data[开始时间]" value="{$_demand['demand']['开始时间']}"/>
                        <input type='text' class="form-control datetimepicker datetime-end" placeholder="结束时间"
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

                <button id="needSubmit" class="btn btn-success">
                    提交
                </button>
            </div>
    </form>
</div>
</div>
{static "css/fullcalendar.css"}
{static "css/fullcalendar.print.css"}
{static "js/moment.min.js"}
{static "js/jquery.lazyload.js"}
{static "js/zh-cn.js"}
{static "css/bootstrap-datetimepicker.min.css"}
{static "js/bootstrap-datetimepicker.min.js"}
{static "js/fullcalendar.js"}
{static "demands/demands_getRecent.js"}
{static "core/yunspace.js"}
{literal}
    <script>
        $(document).ready(function () {
            var moment1 = moment('2015-02-02');
            var moment2 = moment('2015-09-09');
            $.fullCalendar.formatRange(moment1, moment2, 'MMMM D YYYY');
            $('#city-select').select2({
                tags: $('#city-select').attr('data-values').split(','),
                placeholder: "请输入",
//                minimumInputLength: 1,
//                multiple: true,
                separator: ",",                             // 分隔符
//                maximumSelectionSize: 5,                               // 限制数量
                initSelection: function (element, callback) {   // 初始化时设置默认值
                    var data = [];
                    $(element.val().split(",")).each(function () {
                        if (this != '') {
                            data.push({
                                id: this, text: this
                            });
                        }
                    });
                    callback(data);
                },
                createSearchChoice: function (term, data) {           // 创建搜索结果（使用户可以输入匹配值以外的其它值）
                    return {
                        id: term, text: term
                    };
                },
                formatSelection: function (item) {
                    return item.id;
                },  // 选择结果中的显示
                formatResult: function (item) {
                    return item.id;
                }
            });


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
            //验证
            $("#needSubmit").on('click', function () {

                var phone = $('.recentByPhone').val();
                if (!/((1[3|4|5|7|8]{1})+\d{9})/i.test(phone)) {
                    $('.recentByPhone').focus();
                    top.alert('手机不正确~');
                    return false;
                }

                var _up = $("input[name=price_up]").val();
                var _down = $("input[name=price_down]").val();
                if (!_up || !_down || _down == 0) {
                    top.alert('预算必填~~');
                    return false;
                }

                var _people = $(".activity-people").find("option:selected").val();

                if (!_people) {
                    top.alert('请选择活动人数~~');
                    $(".activity-people").focus();
                    return false;
                }
                var _start = $(".datetime-star").val();
                var _end = $(".datetime-end").val();

                if (!_start || !_end) {
                    top.alert('请填写活动日期~');
                    return false;
                }
                $(this).attr('disabled','disabled');
               var submitButton=  $(this);
                setTimeout(function(){
                    submitButton.removeAttr('disabled');
                },1000);
                $('form').submit();
            });
        });


        $("#company").focus(function () {
            $("#recent_demand").fadeOut(1000);
        });
        $('.btn-primary').click(function () {
            demand_recent.getRecent('.recentByPhone', '#recent_demand');
            $("#recent_demand").fadeIn(1000);
        })

    </script>
{/literal}

</body>
</html>