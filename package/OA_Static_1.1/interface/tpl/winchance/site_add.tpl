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
        <i class="fa fa-reorder"></i>文创场地编辑
    </div>
</div>
<div class="portlet-body">
    <form action="?action=siteSubmit" method="post" class="clearfix form-horizontal form-horiz-new">
        <input type="hidden" name="id" value="{$_REQUEST['id']}">
        <div class="form-body">
            <div class="clearfix">
                <div class="clearfix">
                    <div class="form-group col-md-9">
                        <label class="col-md-3 control-label">场地名称</label>

                        <div class="col-md-6">
                            <input type="text" class="form-control input-sm" placeholder="场地名称" name="site_name"
                                   value="{$data['site_name']}" id="company">
                        </div>
                    </div>
                    <div class="form-group col-md-9">
                        <label class="col-md-3 control-label">城市<span class="required"
                                                                        aria-required="true">*</span></label>

                        <div class="col-md-6">
                            <select class="form-control" name="city">
                                <option value=0>请选择</option>
                                {foreach $citys as $value}
                                    <option {if $value==$data['city']}selected {/if}
                                            value="{$value}">{$value}</option>
                                {/foreach}
                            </select>
                        </div>
                    </div>
                    <div class="form-group col-md-9">
                        <label class="col-md-3 control-label">工作状态<span class="required"
                                                                        aria-required="true">*</span></label>

                        <div class="col-md-6">

                            <select class="form-control" name="step">
                                <option value="" >请选择</option>
                                {foreach $step as $k=>$v}
                                    <option {if $data['step']==$k}selected{/if} value="{$k}">{$v}</option>
                                {/foreach}
                            </select>
                        </div>
                    </div>
                    <div class="form-group col-md-9">
                        <label class="col-md-3 control-label">场地类型<span class="required"
                                                                      aria-required="true">*</span></label>

                        <div class="col-md-6">
                            <select class="form-control" name="site_type">
                                <option value="" >请选择</option>
                                {foreach $site_type as $k=>$v}
                                    <option {if $data['site_type']==$v}selected{/if} value="{$v}">{$v}</option>
                                {/foreach}
                            </select>
                        </div>
                    </div>
                    <div class="form-group col-md-9">
                        <label class="col-md-3 control-label">录入类型<span class="required"
                                                                        aria-required="true">*</span></label>

                        <div class="col-md-6">
                            <select class="form-control" name="entry_type">
                                <option value="2" {if $data['entry_type']==2 || !isset($data['entry_type'])}selected{/if}>线下</option>
                                <option value="1" {if $data['entry_type']==1}selected{/if} >线上</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-group col-md-9">
                        <label class="col-md-3 control-label">负责人<span class="required"
                                                                        aria-required="true">*</span></label>

                        <div class="col-md-6">
                            <select class="form-control" name="operator">
                                <option value=0>请选择</option>
                                <option {if $data['operator']=='Applecheng'}selected{/if} value="Applecheng">Applecheng</option>
                                <option {if $data['operator']=='angee'}selected{/if} value="angee">angee</option>
                                <option {if $data['operator']=='yvon'}selected{/if} value="yvon">yvon</option>
                                <option {if $data['operator']=='kingsley'}selected{/if} value="kingsley">kingsley</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-group col-md-9">
                        <label class="col-md-3 control-label">录入时间</label>

                        <div class="col-md-6">
                            <input type="text" class="form-control input-sm" placeholder="时间格式：2016-04-08 15:30:00" name="create_time"
                                   value="{if !empty($data['create_time'])}{date('Y-m-d H:i:s',$data['create_time'])}{else}{date('Y-m-d H:i:s')}{/if}">
                        </div>
                    </div>

                    <div class="form-group col-md-9">
                        <label class="col-md-3 control-label">{if !empty($data['des'][0])}基本信息{/if}</label>
                        <div class="col-md-6 {if empty($data['des'][0])}hidden{/if}">
                            <textarea disabled class="recentByPhone form-control input-sm " rows="3" cols="20"  >历史操作：&#13;&#10;{foreach $data['des'] as $k=>$v}{intval($k+1)}:{$v}&#13;&#10;{/foreach}
                            </textarea>
                        </div>
                        <input type="hidden" name="history_des" value='{if !empty($data['des'][0])}{json_encode($data['des'])}{/if}'>
                    </div>
                    <div class="form-group col-md-9">
                        <label class="col-md-3 control-label">{if empty($data['des'][0])}基本信息{/if}</label>

                        <div class="col-md-6">
                            <textarea class="recentByPhone form-control input-sm " rows="3" cols="20" name="des" placeholder="场地基本资料以及需求" ></textarea>
                        </div>

                    </div>
                    <div class="form-group col-md-9 phone">
                        <label class="col-md-3 control-label">{if !empty($data['plan']['本周进展'][0])}本周进展{/if}</label>
                        <div class="col-md-6 {if empty($data['plan']['本周进展'][0])}hidden{/if}">
                            <textarea disabled class="recentByPhone form-control input-sm " rows="3" cols="20" >历史操作：&#13;&#10;{foreach $data['plan']['本周进展'] as $k=>$v}{intval($k+1)}:{$v}&#13;&#10;{/foreach}
                            </textarea>
                        </div>
                        <input type="hidden" name="history_plan_1" value='{if !empty($data['plan']['本周进展'][0])}{json_encode($data['plan']['本周进展'])}{/if}'>

                    </div>
                    <div class="form-group col-md-9 phone">
                        <label class="col-md-3 control-label">{if empty($data['plan']['本周进展'][0])}本周进展{/if}</label>

                            <div class="col-md-6">
                                <textarea class="recentByPhone form-control input-sm " rows="3" cols="20" name="plan[本周进展]" placeholder="本周进展" ></textarea>
                            </div>

                    </div>
                    <div class="form-group col-md-9">
                        <label class="col-md-3 control-label">{if !empty($data['plan']['下周计划'][0])}下周计划{/if}</label>
                        <div class="col-md-6 {if empty($data['plan']['下周计划'][0])}hidden{/if}">
                            <textarea disabled class="recentByPhone form-control input-sm " rows="3" cols="20"  >历史操作：&#13;&#10;{foreach $data['plan']['下周计划'] as $k=>$v}{intval($k+1)}:{$v}&#13;&#10;{/foreach}
                            </textarea>
                        </div>
                        <input type="hidden" name="history_plan_2" value='{if !empty($data['plan']['下周计划'][0])}{json_encode($data['plan']['下周计划'])}{/if}'>

                    </div>
                    <div class="form-group col-md-9">
                        <label class="col-md-3 control-label">{if empty($data['plan']['下周计划'][0])}下周计划{/if}</label>

                            <div class="col-md-6">
                                <textarea class="recentByPhone form-control input-sm " rows="3" cols="20" name="plan[下周计划]" placeholder="下周计划" ></textarea>
                            </div>
                    </div>
                    <div class="form-group col-md-9">
                        <label class="col-md-3 control-label">{if !empty($data['note'][0])}备注{/if}</label>
                        <div class="col-md-6 {if empty($data['note'][0])}hidden{/if}">
                            <textarea disabled class="recentByPhone form-control input-sm " rows="3" cols="20" >历史操作：&#13;&#10;{foreach $data['note'] as $k=>$v}{intval($k+1)}:{$v}&#13;&#10;{/foreach}
                            </textarea>
                        </div>
                        <input type="hidden" name="history_note" value='{if !empty($data['note'][0])}{json_encode($data['note'])}{/if}'>

                    </div>
                    <div class="form-group col-md-9">
                        <label class="col-md-3 control-label">{if empty($data['note'][0])}备注{/if}</label>

                            <div class="col-md-6">
                                <textarea class="recentByPhone form-control input-sm " rows="3" cols="20" name="note" placeholder="备注" ></textarea>
                            </div>
                    </div>
                </div>

            <div class="text-center clearfix col-md-8">
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