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
    <link href="plugins/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css"/>
    <link href="style/media.css" rel="stylesheet"/>
</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->

<body style="background:#FaFaFa !important">
<style>
    .radio-list > label.radio-inline:first-child {
        padding-left: 20px;
    }
</style>
<div class="portlet tabbable">
    <div class="portlet-title">
        <div class="caption">
            <i class="fa fa-search"></i>搜索条件
        </div>
    </div>
    <div class=" portlet-tabs">
            <ul class="nav nav-tabs">

            </ul>
            <div class="portlet-body">
                <form class="form-horizontal" action="?action=list" method="get" role="form">
                    <div class="form-body">
                        <div class="form-group">
                            <label class="col-md-1 control-label col-xs-2" style="min-width: 100px;">订单状态</label>
                            <div class="col-md-10  col-xs-10">
                                <div class="radio-list">
                                    <label class="radio-inline">
                                        <input type="radio" name="status" id="optionsRadios5" value="all" {if $_REQUEST['status']=='all'||!isset($_REQUEST['status'])}checked{/if}>
                                        全部 </label>
                                    <label class="radio-inline">
                                        <input type="radio" name="status" id="optionsRadios5" value="0" {if isset($_REQUEST['status'])&&$_REQUEST['status']!='all'&&intval($_REQUEST['status'])==0}checked{/if}> 跟进中
                                    </label>
                                    <label class="radio-inline">
                                        <input type="radio" name="status" id="optionsRadios5" value="-1" {if intval($_REQUEST['status'])==-1}checked{/if}>已取消
                                    </label>
                                    <label class="radio-inline">
                                        <input type="radio" name="status" id="optionsRadios5" value="1" {if intval($_REQUEST['status'])==1}checked{/if}> 已完成
                                    </label>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-1 control-label col-xs-2" style="min-width: 100px;">订单阶段</label>
                            <div class="col-md-10  col-xs-10">
                                <div class="radio-list">
                                    <label class="radio-inline">
                                        <input type="radio" name="step" id="optionsRadios5" value="all" {if $_REQUEST['step']=='all'||!isset($_REQUEST['step'])}checked{/if}> 全部
                                    </label>
                                    <label class="radio-inline">
                                        <input type="radio" name="step" id="optionsRadios5" value="0" {if isset($_REQUEST['step'])&&$_REQUEST['step']!='all'&&intval($_REQUEST['step'])==0}checked{/if}>了解需求
                                    </label>
                                    <label class="radio-inline">
                                        <input type="radio" name="step" id="optionsRadios5" value="1" {if intval($_REQUEST['step'])==1}checked{/if}>明确需求
                                    </label>
                                    <label class="radio-inline">
                                        <input type="radio" name="step" id="optionsRadios5" value="2" {if intval($_REQUEST['step'])==2}checked{/if}>合同流程
                                    </label>
                                    <label class="radio-inline">
                                        <input type="radio" name="step" id="optionsRadios5" value="3" {if intval($_REQUEST['step'])==3}checked{/if}>已签约待进行
                                    </label>
                                    {*<label class="radio-inline">*}
                                        {*<input type="radio" name="step" id="optionsRadios5" value="4" {if intval($_REQUEST['step'])==4}checked{/if}>完成*}
                                    {*</label>*}
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-1 control-label col-xs-2" style="min-width: 100px;">城市</label>
                            <div class="col-md-10  col-xs-10">
                                <div class="radio-list">
                                    <label class="radio-inline">
                                        <input type="radio" name="city" id="optionsRadios5" value="all" {if $_REQUEST['city']=='all'||empty($_REQUEST['city'])}checked{/if}> 全部
                                    </label>
                                    {$i=1}
                                    {foreach $city_array as $k=>$v}
                                    <label class="radio-inline">
                                        <input type="radio" name="city" id="optionsRadios5" value="{$v}" {if $_REQUEST['city']==$v}checked{/if}>{$v}
                                    </label>
                                        {if $i==12}
                                            <br />
                                            {/if}
                                        {$i=$i+1}
                                    {/foreach}
                                    {*<label class="radio-inline">*}
                                        {*<input type="radio" name="city" id="optionsRadios5" value="option2">上海*}
                                    {*</label>*}
                                    {*<label class="radio-inline">*}
                                        {*<input type="radio" name="city" id="optionsRadios5" value="option2">深圳*}
                                    {*</label>*}
                                </div>
                            </div>
                        </div>
                        {if $is_manager}
                        <div class="form-group">
                            <label class="col-md-1 control-label col-xs-2" style="min-width: 100px;">云负责人</label>
                            <div class="col-md-10  col-xs-10">
                                <div class="radio-list">
                                    <label class="radio-inline">
                                        <input type="radio" name="admin_id" id="optionsRadios4" value="" {if $_REQUEST['admin_id']=='all'||empty($_REQUEST['admin_id'])}checked{/if}>全部
                                    </label>
                                    {foreach $yun_principal as $k=>$v}
                                        <label class="radio-inline">
                                            <input type="radio" name="admin_id" id="optionsRadios4" value="{$k}" {if $_REQUEST['admin_id']==$k}checked{/if}>{$v['name']}
                                        </label>
                                    {/foreach}
                                </div>
                            </div>
                        </div>
                        {/if}
                    </div>

                <div class="row clearfix" style="margin:10px 0;">
                    <!-- /.col-md-6 -->
                    <div class="col-md-3 col-xs-4" style="min-width: 450px;">
                        <div class="input-group">
                            <input type="text" name="keyword" value="{$_REQUEST['keyword']}" class="form-control" placeholder="输入活动名称、ID、IP名称、场地名称进行查找">
											<span class="input-group-btn">
											<button class="btn btn-info" type="submit"><i class="fa fa-search" aria-hidden="true"></i>查找</button>
											</span>
                        </div>
                        <!-- /input-group -->
                    </div>
                    <div class="col-md-2 pull-right col-xs-4" style="text-align: right">
                        <a type="button" class="btn btn-primary" href="?action=add">创建订单</a>
                        {*<button type="button" class="btn btn-success">导出</button>*}
                    </div>
                </div>
                </form>
                <div class="tab-content">
                    <div class="tab-pane active" id="portlet_tab1">
                        <div style="margin:10px;">
                            <div class="">
                                <div class="portlet-body">
                                    <div class="tab-content clearfix">
                                        <div class="table-responsive">
                                            <table class="table table-striped table-bordered">
                                                <thead>
                                                <tr>
                                                    <th class="id">#ID</th>
                                                    <th width="14%">活动主题</th>
                                                    <th width="10%">城市</th>
                                                    <th width="10%">场地</th>
                                                    <th width="10%">IP</th>
                                                    <th width="10%">云负责人</th>
                                                    <th width="10%">订单阶段</th>
                                                    <th width="10%">跟踪天数</th>
                                                    <th width="10%">订单日志</th>
                                                    <th width="10%">来源</th>
                                                    <th>操作</th>
                                                </tr>
                                                </thead>
                                                <tbody>
                                                {if !empty($data['rows'])}
                                                {foreach $data['rows'] as $k=>$v}
                                                    <tr>
                                                        <td>{$v['id']}</td>
                                                        <td>{$v['active_name']}</td>
                                                        <td>{$v['city']}</td>
                                                        <td>{$v['space_name']}</td>
                                                        <td>{if $v['final_ip']}{$v['final_ip']}{else}待确认{/if}</td>
                                                        <td>
                                                            {if $is_manager}
                                                            <select class="form-control input-sm" data-check-id="" data-type="winchance" data-id="{$v['id']}" onchange="changeAdmin(this)">
                                                                <option {if empty($v['admin_name'])}selected{/if}>请选择负责人</option>
                                                                {foreach $yun_principal as $kk=>$vv}
                                                                    <option {if $v['admin_name']==$vv['name']}selected {/if} value="{$kk}-{$vv['name']}">{$vv['name']}</option>
                                                                {/foreach}
                                                            </select>
                                                            {else}
                                                            {$v['admin_name']}
                                                            {/if}
                                                        </td>
                                                        <td>
                                                            {if $v['status']==1}
                                                                订单已完成
                                                            {elseif $v['status']==-1}
                                                                订单已取消
                                                            {else}
                                                                {$step[$v['step']]}
                                                            {/if}
                                                        </td>
                                                        <td>{$v['trace_time']}</td>
                                                        <td><a href="?action=log&order_id={$v['id']}" class="btn btn-default btn-xs">查看</a></td>
                                                        <td>{if $v['source']==1}
                                                                <span class="label label-primary">网站提交</span>
                                                            {elseif $v['source']==2}
                                                                <span class="label label-danger">项目加盟</span>
                                                            {else}
                                                                <span class="label label-success">后台创建</span>
                                                            {/if}
                                                        </td>
                                                        <td>
                                                            {if ($v['status']!=-1 &&$v['admin_id']==$user_id)||$is_manager}
                                                            <a href="?action=edit&order_id={$v['id']}&step={if $v['step']<4}{$v['step']+1}{else}4{/if}" class="btn btn-info btn-xs">编辑</a>
                                                            {/if}
                                                            {if $v['status']==-1 }
                                                                <span class="label label-warning">订单已取消</span>
                                                            {/if}
                                                        </td>
                                                    </tr>
                                                {/foreach}
                                                {/if}
                                                </tbody>
                                            </table>
                                        </div>
                                        <div class="container-fluid">
                                            <div class="row">
                                                <div class="col-md-12" style="padding: 0px;">
                                                    <ul class="pagination">
                                                        {if $data['page']['dpll']}
                                                            <li class="prev">
                                                                <a href="{$data['page']['dup']}1" title="First"><i
                                                                            class="fa fa-angle-double-left"></i></a>
                                                            </li>
                                                            <li class="prev">
                                                                <a href="{$data['page']['dup']}{$_waiting['page']['dp']-1}" title="Prev"><i
                                                                            class="fa fa-angle-left"></i></a>
                                                            </li>
                                                        {else}
                                                            <li class="prev disabled">
                                                                <a href="#" title="First"><i class="fa fa-angle-double-left"></i></a>
                                                            </li>
                                                            <li class="prev disabled">
                                                                <a href="#" title="Prev"><i class="fa fa-angle-left"></i></a>
                                                            </li>
                                                        {/if}
                                                        {for $i=$data['page']['dpl'] to $data['page']['dpr']}
                                                            <li{if $i==$data['page']['dp']} class="active"{/if}>
                                                                <a href="{$data['page']['dup']}{$i}">{$i}</a>
                                                            </li>
                                                        {/for}
                                                        <li class="disabled">
                                                            <a> {$data['page']['dtp']}
                                                                ( {$data['page']['dp']*$data['page']['dn']}
                                                                /{$data['page']['dt']}
                                                                )</a></li>

                                                        {if $data['page']['dprr']}
                                                            <li class="next">
                                                                <a href="{$data['page']['dup']}{$data['page']['dp']+1}" title="Next"><i
                                                                            class="fa fa-angle-right"></i></a>
                                                            </li>
                                                            <li class="next">
                                                                <a href="{$data['page']['dup']}{$data['page']['dtp']}" title="Last"><i
                                                                            class="fa fa-angle-double-right"></i></a>
                                                            </li>
                                                        {else}
                                                            <li class="next disabled">
                                                                <a href="#" title="Next"><i class="fa fa-angle-right"></i></a>
                                                            </li>
                                                            <li class="next disabled">
                                                                <a href="#" title="Last"><i class="fa fa-angle-double-right"></i></a>
                                                            </li>
                                                        {/if}
                                                    </ul>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>



    </div>
</div>
{*<style>*}
    {*.step_content {*}
        {*height: auto;*}
        {*overflow: hidden;*}
        {*background-color: #eee;*}
        {*padding: 2%;*}
        {*width: 96%;*}
        {*margin-top: 5px;*}
        {*display: none;*}
        {*word-break: break-all;*}
    {*}*}
{*</style>*}

<script src="{$_assets}plugins/jquery-1.11.0.min.js" type="text/javascript"></script>
<script src="{$_assets}plugins/bootstrap/js/bootstrap.min.js"
        type="text/javascript"></script>
{static "core/yunspace.js"}
{*<script src="js/demands/demands_change_select.js" type="text/javascript"></script>*}

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
    function changeAdmin(e){
            var admin_info = $(e).val();
            var adminInfo = new Array();
            adminInfo = admin_info.split('-');
            console.log(adminInfo);
            var admin_id = adminInfo[0];
            var admin_name = adminInfo[1];
            var order_id = $(e).data('id');
        var r=confirm('确定要把订单所有者更换为'+admin_name+'吗');
        if(r) {
            YunSpace.api('winchance/order/change/admin.jsonp', {
                order_id: order_id,
                admin_id: admin_id,
                admin_name: admin_name
            }, function (data) {
                if (data.status == 1) {
                    alert(data.msg);
//                    window.location.reload();
                } else {
                    top.alert(data.msg);
                }
            });
        }else{
            window.location.reload();
            return false;
        }

    }
</script>

</body>
<!-- END BODY -->
</html>