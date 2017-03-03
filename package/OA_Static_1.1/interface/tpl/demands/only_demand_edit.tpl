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
            <input type="hidden" name="demand_id" value="{$_demand['id']}">
            <input name="action" value="demand_edit_submit" type="hidden"/>
            <input value="{$_REQUEST['offer_id']}" name="offer_id" type="hidden"/>
            <input value="{$_REQUEST['is_num']}" name="is_num" type="hidden"/>

            <div class="form-body">
                <div class="clearfix">

                    <div class="clearfix">

                        <div class="form-group col-md-9">
                            <label class="col-md-3 control-label">需求类型<span class="required"
                                                                            aria-required="true">*</span></label>

                            <div class="col-md-9">
                                <select class="form-control" name="demand_type" style="width: 200px;float: left">
                                    {foreach $_demandType as $k=>$v}
                                        <option value="{$v}" {if $v==$_demand['demand_type']}selected{/if}>{$v}</option>
                                    {/foreach}
                                </select>
                            </div>
                        </div>
                        <div class="form-group col-md-9">
                            <label class="col-md-3 control-label">活动名称<span class="required"
                                                                            aria-required="true">*</span></label>

                            <div class="col-md-9">
                                <input type="text" class="form-control input-sm"
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
                        <div class="form-group col-md-9">
                            <label class="col-md-3 control-label">联系电话<span class="required"
                                                                            aria-required="true">*</span></label>

                            <div class="col-md-9">
                                <input type="text" class="form-control input-sm"
                                       placeholder="手机-例：13888888888/" name="data[联系电话]"
                                       value="{$_demand['phone']}">
                            </div>
                        </div>
                        <div class="form-group col-md-9">
                            <label class="col-md-3 control-label">公司名称<span class="required"
                                                                            aria-required="true"></span></label>

                            <div class="col-md-9">
                                <input type="text" class="form-control input-sm"
                                       placeholder="请输入公司名称" name="data[公司名称]"
                                       value="{$_demand['demand']['公司名称']}">
                            </div>
                        </div>
                        <div class="form-group col-md-9">
                            <label class="col-md-3 control-label">姓名<span class="required" aria-required="true">*</span></label>

                            <div class="col-md-9">
                                <input type="text" class="form-control input-sm" placeholder="姓名" name="data[联系人]"
                                       value="{$_demand['demand']['联系人']}">
                            </div>
                        </div>
                    </div>
                    <div class="form-group col-md-9">
                        <label class="col-md-3 control-label">城市<span class="required"
                                                                      aria-required="true">*</span></label>

                        <div class="col-md-9">
                            <select class="form-control" name="data[城市]">
                                {foreach $_REQUEST['cities'] as $v}
                                    <option value="{$v}" {if $_demand['city']==$v}selected{/if}>{$v}</option>
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

                        <div class="col-md-9 form-inline">
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
    });


</script>
</body>
</html>