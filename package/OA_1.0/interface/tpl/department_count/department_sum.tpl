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
    <link href="css/bootstrap-datetimepicker.min.css" rel="stylesheet"/>

</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->

<body style="background:#FaFaFa !important">
<div class="portlet-body">
    <ul class="nav nav-tabs" style=" margin-bottom: 0px;">
        <li class="{if $_REQUEST['tab']=='contact_data'}active{/if}">
            <a href="?tab=contact_data">联系人数据</a>
        </li>
        {if $_REQUEST['type']==21}
        <li class="{if  $_REQUEST['tab']=='vendor_data'}active{/if}">
            <a href="?tab=vendor_data">供应商</a>
        </li>
        {elseif $_REQUEST['type']==1}
        <li class="{if  $_REQUEST['tab']=='account_data'}active{/if}">
            <a href="?tab=account_data">客户数据</a>
        </li>
        {/if}
        <li class="{if  $_REQUEST['tab']=='order_data'}active{/if}">
            <a href="?tab=order_data">成交数据</a>
        </li>
    </ul>
    <form action="?" method="get" class="clearfix">
        <input type="hidden" name="tab" value="{$_REQUEST['tab']}">
        <input type="hidden" name="type" value="{$_REQUEST['type']}">
    <div class="tab-content clearfix dgc">
        <div class="container-fluid">
            <div class="row mb10">
                <div class="col-md-6">
                    <div class="form-group">
                        <label class="col-md-3 control-label">业务类型</label>
                        <div class="col-md-9">
                            <select class="form-control input-sm" name="search[business]" id="business">
                                {if $_REQUEST['search']['business']}
                                    <option value="{$_REQUEST['search']['business']}">
                                        {$_REQUEST['search']['business']}
                                    </option>
                                {else}
                                    <option value="">
                                        请选择
                                    </option>
                                {/if}
                            </select>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <label class="col-md-3 control-label">业务子类</label>
                        <div class="col-md-9">
                            <select class="form-control input-sm" disabled name="search[sub_business]" id="subBusiness">
                                {if $_REQUEST['search']['sub_business']}
                                    <option value="{$_REQUEST['search']['sub_business']}">
                                        {$_REQUEST['search']['sub_business']}
                                    </option>
                                {else}
                                    <option value="">
                                        请选择
                                    </option>
                                {/if}
                            </select>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row mb10">
                <div class="col-md-6">
                    <div class="form-group">
                        <label class="col-md-3 control-label">管理员</label>
                        <div class="col-md-9">
                            <select class="form-control input-sm" name="search[admin_id]">
                                <option value="0">全部</option>
                                {foreach $_adminInfo as $key=>$value}
                                    <option {if {$_REQUEST['search']['admin_id']==$key}}selected {/if} value="{$key}">{$value}</option>
                                {/foreach}
                            </select>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <label class="col-md-3 control-label">开始日期</label>
                        <div class="col-md-4">
                            <input type='text' class="form-control date jstarttime" placeholder="请选择开始时间" name="search[start_time]" value="{$_REQUEST['search']['start_time']}"/>
                        </div>
                        <div class="col-md-4 col-md-offset-1">
                            <input type='text' class="form-control date jendtime" placeholder="请选择结束时间" name="search[end_time]" value="{$_REQUEST['search']['end_time']}"/>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row mb10">
                <div class="col-md-12 mb10">
                    <div class="form-group">
                        <div class="col-md-6 radio-list">
                            <label class="radio-inline">
                                <input name="search[time]" value="" type="radio">全部
                            </label>
                            <label class="radio-inline">
                                <input name="search[time]" value="tweek" type="radio">本周
                            </label>
                            <label class="radio-inline">
                                <input name="search[time]" value="tmonth" type="radio">本月
                            </label>
                            <label class="radio-inline">
                                <input name="search[time]" value="tseason" type="radio">本季度
                            </label>
                            <label class="radio-inline">
                                <input name="search[time]" value="tyear" type="radio">本年度
                            </label>
                            <label class="radio-inline">
                                <input name="search[time]" value="week" type="radio">上周
                            </label>
                            <label class="radio-inline">
                                <input name="search[time]" value="month" type="radio">上月
                            </label>
                            <label class="radio-inline">
                                <input name="search[time]" value="season" type="radio">上季度
                            </label>
                            <label class="radio-inline">
                                <input name="search[time]" value="year" type="radio">上年度
                            </label>
                        </div>
                    </div>
                </div>
                <div class="col-md-12"> <button type="submit" class="btn btn-primary">搜索</button></div>
            </div>
        </div>
    </form>
        {if $_REQUEST['tab']=='contact_data'}
            {include '/department_count/inc/linkman.tpl'}
        {/if}
        {if $_REQUEST['tab']=='vendor_data'}
            {include '/department_count/inc/supplier.tpl'}
        {/if}
        {if $_REQUEST['tab']=='account_data'}
            {include '/department_count/inc/account.tpl'}
        {/if}
        {if $_REQUEST['tab']=='order_data'}
            {include '/department_count/inc/deal.tpl'}
        {/if}
    </div>

</div>

</body>
<!-- BEGIN JAVASCRIPTS(Load javascripts at bottom, this will reduce page load time) -->
<script src="{$_assets}plugins/jquery-1.11.0.min.js" type="text/javascript"></script>
<script src="{$_assets}scripts/_page.js"></script>
<script type="text/javascript" src="js/moment.min.js"></script>
<script type="text/javascript" src="js/bootstrap-datetimepicker.min.js"></script>
<script type="text/javascript" src="js/zh-cn.js"></script>
<script type="text/javascript" src="js/date.js"></script>
<script type="text/javascript">
    $(document).ready(function () {
        $('.date').datetimepicker({
            format: 'YYYY-MM-DD',
            locale: 'zh-cn'
        });
        $(".radio-list :radio").change(function() {
            MrYangUtils = new MrYangUtil();
            var  valss=$('input:radio[name="search[time]"]:checked').val();
            switch (valss){
                case "tweek":
                    dataranges =  MrYangUtils.getCurrentWeek();
                    break;
                case "tmonth":
                    dataranges =  MrYangUtils.getCurrentMonth();
                    break;
                case "tseason":
                    dataranges =  MrYangUtils.getCurrentSeason();
                    break;
                case "tyear":
                    dataranges =  MrYangUtils.getCurrentYear();
                    break;
                case "week":
                    dataranges =  MrYangUtils.getPreviousWeek();
                    break;
                case "month":
                    dataranges =  MrYangUtils.getPreviousMonth();
                    break;
                case "season":
                    dataranges =  MrYangUtils.getPreviousSeason();
                    break;
                case "year":
                    dataranges =  MrYangUtils.getPreviousYear();
                    break;
                case  "":
                    dataranges = "";
                    break;
            }
            $(".jstarttime").val(dataranges[0]);
            $(".jendtime").val(dataranges[1]);
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

        var bHtml = '<option value="{$_REQUEST['search']['business']|default:''}">{$_REQUEST['search']['business']|default:'请选择'}</option>';
        $('#business').change(function () {
            var index = $('#business').get(0).selectedIndex - 1;
            if (index >= 0) {
                oSubBusiness(index);
            } else {
                {if !$_REQUEST['search']['sub_business']}
                $('#subBusiness').attr("disabled", true);
                {/if}
                $('#subBusiness').html('<option>{$_REQUEST['search']['sub_business']|default:'请先选择业务类型'}</option>');
            }

        })
        for (var i = 0; i < category.length; i++) {
            bHtml += "<option value='" + category[i]['b'] + "'>" + category[i]['b'] + "</option>";
        }

        var oSubBusiness = function (i) {
            var oSubBusinessList = category[i]['s'], sHtml;
            sHtml = "";
            for (var j = 0; j < category[i]['s'].length; j++) {
                sHtml += "<option value='" + category[i]['s'][j] + "'>" + category[i]['s'][j] + "</option>";
            }
            $('#subBusiness').html(sHtml);
            $('#subBusiness').removeAttr('disabled')
        }
        $('#business').html(bHtml);

    });
</script>
</body>
<!-- END BODY -->
</html>