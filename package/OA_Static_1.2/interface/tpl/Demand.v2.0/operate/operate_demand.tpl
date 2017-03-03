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
    <link href="style/media.css" rel="stylesheet"/>
    <link href="{$_assets}/css/bootstrap-datetimepicker.min.css" rel="stylesheet"/>
</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->

<body style="background:#FaFaFa !important">
<div class="portlet tabbable">
    <div class="portlet-title">
        <div class="caption">
            <i class="fa fa-database"></i>需求管理 (当前共<a href="#"> {$_alltotal} </a>个需求)
        </div>
    </div>
</div>
<div class="portlet tabbable">
    <div class="portlet-title">
        <div class="caption">
            <i class="fa fa-search"></i>搜索条件
        </div>
    </div>
    <div class="portlet-body">
        <div class="portlet-tabs">
            <div class="clearfix"></div>
            <div>
                <form action="?" method="get" class="clearfix">
                    <input type="hidden" name="action" value="list">
                    <input type="hidden" name="type" value="{$type}">


                    <div class="form-body clearfix">
                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">姓名</label>

                            <div class="col-md-9">
                                <input type="text" class="form-control input-sm" placeholder="姓名"
                                       name="search[username]" value="{$_REQUEST['search']['username']}">
                            </div>
                        </div>

                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">电话</label>

                            <div class="col-md-9">
                                <input type="text" class="form-control input-sm" placeholder="电话"
                                       name="search[phone]" value="{$_REQUEST['search']['phone']}">
                            </div>
                        </div>

                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">城市</label>

                            <div class="col-md-9">
                                <select class="form-control input-sm" name="search[city]">
                                    <option value=0>全部</option>
                                    {foreach $_REQUEST['cities'] as $key=>$value}
                                        <option {if {$_REQUEST['search']['city']==$value}}selected
                                                {/if}value="{$value}">{$value}</option>
                                    {/foreach}
                                </select>
                            </div>
                        </div>

                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">需求类型</label>

                            <div class="col-md-9">
                                <select class="form-control input-sm" name="search[demandType]">
                                    <option value=0>全部</option>
                                    {foreach $_demandType as $val}
                                        <option value="{$val}"
                                                {if $_REQUEST['search']['demandType'] == $val}selected{/if}>{$val}</option>
                                    {/foreach}
                                </select>
                            </div>

                        </div>
                    {*</div>*}
                    {*<div class="form-body clearfix">*}
                        <div class="form-group col-md-5 form-creat-time">
                            <label class="col-md-3 control-label">创建时间</label>

                            <div class="col-md-4">
                                <input type='text' class="form-control date datetime-star" placeholder="请选择开始时间"
                                       name="search[start_time]" value="{$_REQUEST['search']['start_time']}"/>
                            </div>
                            <div class="col-md-4">
                                <input type='text' class="form-control date" placeholder="请选择结束时间"
                                       name="search[end_time]" value="{$_REQUEST['search']['end_time']}"/>
                            </div>
                        </div>
                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">需求ID或者编号</label>

                            <div class="col-md-9">
                                <input type='text' class="form-control " placeholder="请输入需求ID或者编号"
                                       name="search[no]" value="{$_REQUEST['search']['no']}"/>
                            </div>
                        </div>
                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">需求级别</label>
                            <div class="col-md-9">
                                <select class="form-control input-sm" name="search[demand_level]">
                                    <option {if !isset($_REQUEST['search']['demand_level']) || $_REQUEST['search']['demand_level']=="全部"}selected {/if} value="全部">全部</option>
                                    <option {if $_REQUEST['search']['demand_level']==2}selected {/if} value='2'>高级</option>
                                    <option {if $_REQUEST['search']['demand_level']==1}selected {/if}value='1'>中级</option>
                                    <option {if isset($_REQUEST['search']['demand_level']) && $_REQUEST['search']['demand_level']==0 && $_REQUEST['search']['demand_level']!="全部"}selected {/if} value='0'>普通</option>
                                </select>
                            </div>
                        </div>
                    </div>

                    <div class="form-actions">
                        <div class="" style="text-align: center">
                            <button type="submit" class="btn btn-primary" style="width: 150px">
                                <i class="fa fa-search"></i>
                                搜索
                            </button>
                        </div>
                    </div>
                </form>
            </div>

        </div>
    </div>
</div>
<div class="portlet">
    <div class="portlet-body">
        <ul class="nav nav-tabs">
            <li class="{if $type=='all'}active{/if}">
                <a href="?action=list&type=all{if !empty($_REQUEST['search'])}&{$urls}{/if}">全部（{($total[2])}）</a>
            </li>
            <li class="{if $type=='waiting'}active{/if}">
                <a href="?action=list&type=waiting{if !empty($_REQUEST['search'])}&{$urls}{/if}">待处理（{($total[0])}
                    ）</a>
            </li>
            <li class="{if $type=='done'}active{/if}">
                <a href="?action=list&type=done{if !empty($_REQUEST['search'])}&{$urls}{/if}">已处理（{($total[1])}）</a>
            </li>
            <li class="{if $type=='abandon'}active{/if}">
                <a href="?action=list&type=abandon{if !empty($_REQUEST['search'])}&{$urls}{/if}">已放弃（{($total[-1])}
                    ）</a>
            </li>
            <li class="{if $type=='abandon_repeat'}active{/if}">
                <a href="?action=list&type=abandon_repeat{if !empty($_REQUEST['search'])}&{$urls}{/if}">重复（{($total[-2])}
                    ）</a>
            </li>
            <li class="{if $type=='abandon_system_repeat'}active{/if}">
                <a href="?action=list&type=abandon_system_repeat{if !empty($_REQUEST['search'])}&{$urls}{/if}">自动放弃（{($total[-3])}
                    ）</a>
            </li>
            <li class="{if $type=='offer'}active{/if}">
                <a href="?action=list&type=offer{if !empty($_REQUEST['search'])}&{$urls}{/if}">测试（{($total[5])}
                    ）</a>
            </li>
        </ul>
        <div class="tab-content clearfix">
            {include 'OA_Static::Demand.v2.0/operate/operate_demand_pending.tpl'}
        </div>
    </div>
</div>
<script src="{$_assets}plugins/jquery-1.11.0.min.js" type="text/javascript"></script>
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

    });
</script>
</body>
<!-- END BODY -->
</html>