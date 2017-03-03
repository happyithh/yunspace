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
    <script src="{$_assets}plugins/jquery-1.11.0.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="{$_assets}plugins/select2/select2.min.js"></script>
</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->

<body style="background:#FaFaFa !important">

<div class="portlet tabbable">
<div class="portlet-title">
    <div class="caption">
        <i class="fa fa-database"></i>需求详情&nbsp;&nbsp;需求ID：{$_REQUEST['demand_id']}
        {if  $_demand['mark_tags']}
            {foreach  $_demand['mark_tags'] as $key =>$val}
                {*{if $key <11}*}
                {*<span class="badge badge-important"> {$val}</span>*}
                {*{/if} *}
                {if $key >19}
                    <span class="badge adge-success"> {$val}</span>
                {/if}

            {/foreach}
        {/if}
    </div>
    <div>

        <a style="float: right;margin-right:50px;" class="btn btn-danger"
           href="?act=demand_offer&action=remove&offer_id={$_offer_id}&demand_id={$_REQUEST['demand_id']}" onclick="
        {literal} if(confirm('确定移除吗？')){
                return true;
             }else{
              return false;
             }{/literal}
                ">移除需求报价</a>

        &nbsp;&nbsp;
        <a href="{$_home}sales/my_demand_list?action=demand_edit_tpl&demand_id={$_REQUEST['demand_id']}&offer_id={$_offer_id}&is_num=1"
           class="btn btn-primary" style="float: right;margin-right:10px;height: 25px;line-height: 12px;">编辑需求</a>

    </div>
</div>
<div class="portlet-body">
    <div class="container-fluid">
        <div class="row">
            <table class="table table-hover" style="border:0px;">
                <tbody>
                <tr>
                    <td>需求相关信息</td>
                    <td>
                        {foreach $_demand['demand'] as $key=>$val}
                            {if is_array($val)}
                                <p>{$key}:</p>
                                {foreach $val as $k=>$v}
                                    <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {$k}:&nbsp;&nbsp;&nbsp;{$v}</p>
                                {/foreach}
                            {else}
                                <p>{$key}：&nbsp;&nbsp;&nbsp;{$val}</p>
                            {/if}
                        {/foreach}
                        <p>订单质量:&nbsp;&nbsp;&nbsp;{$_offer_info['order_quality']}分
                            <button type="button" class="btn btn-success" href="#order_quality" data-toggle="modal"
                                    style="margin-left:10px;height: 25px;line-height: 12px;">查看详情
                            </button>
                        </p>

                    </td>
                </tr>
                </tbody>
            </table>
        </div>
    </div>
</div>


<div class="modal fade" id="order_quality" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h3 class="modal-title" style="margin-left: 30px">
                    订单质量详情{$_offer_info['order_quality']}分</h3>
            </div>
            <div class="modal-body" style="margin-left: 30px;font-size: 14px; line-height: 25px;">
                {if $quantity}
                    {foreach $quantity as $k => $v}
                        <table>
                            {if $v['c_num']}
                                <tr>
                                    <td>客户浏览：</td>
                                    <td> {$v['c_num']*5}分</td>
                                </tr>
                            {/if}
                            {if $v['v_num']}
                                <tr>
                                    <td>商家浏览：</td>
                                    <td> {$v['v_num']*10}分</td>
                                </tr>
                            {/if}
                            {if $v['offer_num']}
                                <tr>
                                    <td>商家报价：</td>
                                    <td>{$v['offer_num']*20}分</td>
                                </tr>
                            {/if}
                            {if $v['v_num_five']}
                                <tr>
                                    <td>商家浏览次数大于5次：</td>
                                    <td>{$v['v_num_five']*10} 分</td>
                                </tr>
                            {/if}
                            {if $v['offer_num_three']}
                                <tr>
                                    <td>商家报价次数大于3次：</td>
                                    <td>{$v['offer_num_three']*15}分</td>
                                </tr>
                            {/if}
                            {if $v['c_num_three']}
                                <tr>
                                    <td>客户打开次数大于3次：</td>
                                    <td>{$v['c_num_three']*15}分</td>
                                </tr>
                            {/if}
                            {if $v['change_num_one']}
                                <tr>
                                    <td>交换电话次数大于1次：</td>
                                    <td> {$v['change_num_one']*25}分</td>
                                </tr>
                            {/if}
                        </table>
                    {/foreach}
                {else}
                    没有质量分
                {/if}

                <button type="button" class="btn btn-success" data-dismiss="modal" style="margin-top:20px;">
                    关&nbsp;闭
                </button>
            </div>
        </div>
    </div>

</div>
{*领取信息*}
{*{if !empty($offer_info[0]['receive_time'])}*}
{*<div class="portlet" style="border: none">*}
{*<div class="portlet-title" >*}
{*<div class="caption"><i class="fa fa-database"></i>领取记录*}
{*</div>*}
{*</div>*}
{*<div class="portlet-body">*}
{*<div class="container-fluid">*}
{*<div class="row">*}
{*<table class="table  table table-striped table-bordered table-advance table-hover">*}
{*<thead>*}
{*<tr>*}
{*<td>用户ID</td>*}
{*<td>用户名称</td>*}
{*<td>领取时间</td>*}
{*</tr>*}
{*</thead>*}
{*<tbody>*}
{*{if $adminname}*}
{*<tr>*}
{*<td>{$offer_info[0]['admin_id']}</td>*}
{*<td>{$adminname[0]['username']}</td>*}
{*<td>{if !empty($offer_info[0]['receive_time'])}{date('Y-m-d H:i:s',$offer_info[0]['receive_time'])}{/if}</td>*}
{*</tr>*}
{*{else}*}
{*<tr>*}
{*<td colspan=7 style="text-align: center;">*}
{*没有领取记录*}
{*</td>*}
{*</tr>*}
{*{/if}*}
{*</tbody>*}
{*</table>*}
{*</div>*}
{*</div>*}
{*</div>*}
{*</div>*}
{*{/if}*}
{*联系记录*}

<div class="portlet" style="border: none">
    <div class="portlet-title">
        <div class="caption">
            <i class="fa fa-database"></i>订单联系记录 {if $contactRecord && isset($contactRecord['rows'])}({count($contactRecord['rows'])}){/if}
        </div>
    </div>
    <div class="portlet-body">
        <div class="container-fluid">
            <div class="row">
                <table class="table  table table-striped table-bordered table-advance table-hover">
                    <thead>
                    <tr>
                        <td>需求ID</td>
                        <td>记录内容</td>
                        <td>记录时间</td>
                    </tr>
                    </thead>
                    <tbody>
                    {if $contactRecord}
                        {foreach $contactRecord as $key=>$value}
                            <tr>
                                <td>{$value['demand_id']}</td>
                                <td>{$value['content']}</td>
                                <td>{$value['time']}</td>
                            </tr>
                        {/foreach}
                    {else}
                        <tr>
                            <td colspan=7 style="text-align: center;">
                                没有联系记录
                            </td>
                        </tr>
                    {/if}
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>


<div class="portlet-title">
    <div class="caption">
        <i class="fa fa-search"></i>匹配条件
    </div>
</div>
<div class="portlet-body">
    <div class="portlet-tabs">
        <div class="clearfix"></div>
        <div>
            <form action="?" method="post" class="clearfix">
                <input type="hidden" name="act" value="demand_offer"/>
                <input type="hidden" name="action" value="search_result"/>
                <input type="hidden" name="demand_id" value="{$_demand['id']}">

                <div class="form-body clearfix">
                    {*<div class="form-group col-md-5">*}
                    {*<label class="col-md-3 control-label">负责人</label>*}

                    {*<div class="col-md-9">*}
                    {*<select class="form-control input-sm" name="search[admin_id]">*}
                    {*<option value=0>全部</option>*}
                    {*{foreach $admin as $key=>$value}*}
                    {*<option {if {$_REQUEST['search']['admin_id']==$value['admin_id']}}selected {/if}*}
                    {*value="{$value['admin_id']}">{$value['fullname']}</option>*}
                    {*{/foreach}*}
                    {*</select>*}
                    {*</div>*}
                    {*</div>*}
                    <div class="form-group col-md-3">
                        <label class="col-md-3 control-label">价格区间</label>

                        <div class="col-md-4">
                            <input type='text' class="form-control" placeholder=""
                                   name="search[start_price]" value="{$_offer_info['demand_filter']['start_price']}"/>
                        </div>
                        <div class="col-md-1" style="height: 30px;line-height: 30px;text-align: center;">——</div>
                        <div class="col-md-4 ">
                            <input type='text' class="form-control" placeholder=""
                                   name="search[end_price]" value="{$_offer_info['demand_filter']['end_price']}"/>
                        </div>
                    </div>
                    <div class="form-group col-md-3">
                        <label class="col-md-3 control-label">人数区间</label>

                        <div class="col-md-4">
                            <input type='text' class="form-control" placeholder=""
                                   name="search[start_people]" value="{$_offer_info['demand_filter']['start_people']}"/>
                        </div>
                        <div class="col-md-1" style="height: 30px;line-height: 30px;text-align: center;">——</div>
                        <div class="col-md-4 ">
                            <input type='text' class="form-control" placeholder=""
                                   name="search[end_people]" value="{$_offer_info['demand_filter']['end_people']}"/>
                        </div>
                    </div>
                    <div class="form-group col-md-3">
                        <label class="col-md-3 control-label">场地类型：</label>

                        <div class="col-md-6 ">
                            <select class="form-control" name="search[category_id]">
                                <option value="">选择场地类型</option>
                                {foreach $_categories[112] as $ck=>$cv}
                                    <option {if $_offer_info['demand_filter']['category_id'] == $ck}selected {/if}
                                            value="{$ck}">{$cv}</option>
                                {/foreach}
                            </select>
                        </div>
                    </div>
                </div>
                <div class="form-body clearfix">
                    <div class="form-group col-md-3">
                        <label class="col-md-3 control-label">城市</label>

                        <div class="col-md-5">
                            <select class="form-control input-sm" name="search[city]">
                                <option value=0>全部</option>
                                {foreach $_REQUEST['cities'] as $value}
                                    <option {if $value==$_offer_info['demand_filter']['city']}selected {/if}
                                            value="{$value}">{$value}</option>
                                {/foreach}
                            </select>
                        </div>
                    </div>
                    <div class="form-group col-md-3">
                        <label class="col-md-4 control-label">行政区域</label>

                        <div class="col-md-8">
                            <input type='text' class="form-control" placeholder="例如徐汇区"
                                   name="search[admin_area]" value="{$_offer_info['demand_filter']['admin_area']}"/>
                        </div>
                    </div>
                    <div class="form-group col-md-5">
                        <label class="col-md-3 control-label">需求标签</label>

                        <div class="col-md-7">
                            <input name="data_i[space_id]" placeholder="输入标签名称或id"
                                   class="form-control select2"
                                   id="space_id" type="hidden">
                            <input type="text" class="form-control select2 tags_select2" name="tags_list"
                                   data-values="{implode(',',$_tag_list)}">
                        </div>
                        <div class="col-md-2">
                            <button type="button" class="btn btn-success add_tag">添加标签</button>
                        </div>
                    </div>
                </div>
                <div class="form-body clearfix tag_table">
                    <div class="form-group col-md-12">
                        <label class="col-md-2 control-label">已选需求标签</label>

                        <div class="col-md-8">
                            <div class="table-responsive">
                                <table class="table table-hover tag_margin">
                                    <thead>
                                    <tr>
                                        <th>
                                            标签名称
                                        </th>
                                        <th>
                                            标签选项
                                        </th>
                                        <th>
                                            操作
                                        </th>
                                    </tr>
                                    <tr class="hide h_clone">
                                        <td class="col-md-4">
                                            <input type="hidden" name="" value="" class="tags_id">
                                            <span class="tag_name"></span>
                                        </td>
                                        <td class="col-md-6">
                                            <div class="radio-list">
                                                <label class="radio-inline" style="margin-left: 15px;">
                                                    <input name="" value="1" type="radio">有
                                                </label>
                                                <label class="radio-inline" style="margin-left: 15px;">
                                                    <input name="" value="2" type="radio">无
                                                </label>
                                                <label class="radio-inline " style="margin-left: 15px;">
                                                    <input name="" value="3" type="radio">可有可无
                                                </label>
                                            </div>
                                        </td>
                                        <td class="col-md-2">
                                            <span type="button" class="btn btn-danger" onclick="LvEdit.delete(this)">删除标签</span>
                                        </td>
                                    </tr>
                                    </thead>
                                    <tbody class="n_tbody">
                                    {$j=0}
                                    {foreach $_search['new_tags'] as $k=>$v}
                                        <tr>
                                            <td class="col-md-4">
                                                <input type="hidden" name="search[tags][{$j}][id]" value="{$v['id']}"
                                                       class="tags_id">
                                                <span class="tag_name">{$v['tag_name']}</span>
                                            </td>
                                            <td class="col-md-6">
                                                <div class="radio-list">
                                                    <label class="radio-inline" style="margin-left: 15px;">
                                                        <input name="search[tags][{$j}][value]" value="1" type="radio"
                                                               {if $v['tag_check_value']==1}checked="true"{/if}>有
                                                    </label>
                                                    <label class="radio-inline" style="margin-left: 15px;">
                                                        <input name="search[tags][{$j}][value]" value="2" type="radio"
                                                               {if $v['tag_check_value']==2}checked="true"{/if}>无
                                                    </label>
                                                    <label class="radio-inline " style="margin-left: 15px;">
                                                        <input name="search[tags][{$j}][value]" value="3" type="radio"
                                                               {if $v['tag_check_value']==3}checked="true"{/if}>可有可无
                                                    </label>
                                                </div>
                                            </td>
                                            <td class="col-md-2">
                                                <span type="button" class="btn btn-danger"
                                                      onclick="LvEdit.delete(this)">删除标签</span>
                                            </td>
                                        </tr>
                                        {$j=$j+1}
                                    {/foreach}
                                    </tbody>
                                </table>
                            </div>

                        </div>
                    </div>
                </div>
                <div class="form-actions">
                    <div class="" style="text-align: center">
                        <button type="submit" class="btn btn-primary" style="width: 150px">
                            保存需求匹配信息
                        </button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
</div>
{include 'OA_Static::demand_offer/inc/demand_offer_search.inc.tpl' index=1}
<!--报价结果-->
<div class="portlet" style="border: none">
    <div class="portlet-title">
        <div class="caption">
            <i class="fa fa-database"></i>商家报价列表 {if $_offer_list}({count($_offer_list)}){/if}
        </div>
    </div>
    <div class="portlet-body">
        <div class="container-fluid">
            <div class="row">
                <table class="table  table table-striped table-bordered table-advance table-hover">
                    <thead>
                    <tr>
                        <td>报价方案：</td>
                        <td>子空间名称：</td>
                        {*<td>产品地址：</td>*}
                        <td>联系人：</td>
                        <td>联系电话：</td>
                        <td>报价：</td>
                        <td>报价时间：</td>
                        <td>状态：</td>
                        <td>回访</td>
                    </tr>
                    </thead>
                    <tbody>
                    {if $_offer_list}
                        {foreach $_offer_list as $k => $v}
                            <tr space="{$v['space_id']}" offer="{$v['offer_id']}" items="{$v['item_id']}" class="merchant-tr">
                                <td>报价方案{$k+1}</td>
                                <td><a href="{$_root}baike/{$v['space_name']}"
                                       style="text-decoration: none" target="_blank">{$v['item_name']}</a>
                                </td>
                                {*<td>{$v['addr']}</td>*}
                                <td>{$v['contacts']}</td>
                                <td>{$v['phone']}</td>
                                <td>{$v['offer_price']}/{$v['offer_unit']}</td>
                                <td>{(date('Y-m-d H:i:s',$v['offer_time']))}</td>
                                <td>
                                    {if $v['change_phone_time']}
                                        <span style="color: red"> 已交换电话</span>
                                    {else}
                                        商家已报价
                                    {/if}
                                </td>
                                <td>
                                    {if $v['change_phone_time']}
                                        <button type="button" class="btn btn-success user_revisit"
                                                href="#demand_revisit" data-space="{$v['space_id']}" data-toggle="modal" style="margin-left:10px;height: 25px;line-height: 12px;">商户回访</button>
                                    {/if}
                                </td>
                            </tr>
                        {/foreach}
                    {else}
                        <tr>
                            <td colspan=7 style="text-align: center;">
                                没有匹配的方案
                            </td>
                        </tr>
                    {/if}
                    </tbody>
                </table>
            </div>
            <div style="float: right">
                {if $_as[0]['step'] ==1}
                    <button type="button" class="btn  "
                            href="#demand_list"  data-toggle="modal" style="margin-left:10px;height: 25px;line-height: 12px;background-color: #999">已成交</button>
                {else}
                    <button type="button" class="btn btn-success"
                            href="#demand_merchant"  data-toggle="modal" style="margin-left:10px;height: 25px;line-height: 12px;">需求方回访</button>
                {/if}
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="demand_revisit" tabindex="-1" role="demand_revisit" aria-hidden="true" style="display: none;">
    <div class="modal-dialog">
        <div class="modal-content" >
            <div class="modal-header" style="margin-left: 20px;">
                <h4 class="modal-title">
                    添加商户回访</h4>
            </div>
            {* <form action="" method="post" class="clearfix">*}
            <div class="modal-body" style="margin-left: 20px;">
                <input type="hidden" name="demand_id" id="demand_id" value="{$_REQUEST['demand_id']}">
                <table width="80%">

                    <tr>
                        <td colspan="4">
                            <textarea class="form-control merchant_reason"
                                      rows="5" placeholder="请输入回访信息"></textarea>
                        </td>
                    </tr>
                </table>
                <div style="margin:20px 180px;">
                    <button type="button" class="btn btn-default" data-dismiss="modal" style="margin-right: 10px">
                        取消
                    </button>
                    <button type="button" class="btn btn-success merchant_interview">
                        确定
                    </button>
                </div>
            </div>
            {*    </form>*}
            <div class="modal-footer">
                <div class="modal-header none shanghu" >
                    <h3 class="modal-title" style="text-align: center;margin-bottom: 5px">
                        回访历史记录</h3>
                    <div id="huifang">
                    </div>
                </div>
            </div>
        </div>

    </div>

</div>


{*需求方回访*}

<div class="modal fade" id="demand_merchant" tabindex="-1" role="demand_merchant" aria-hidden="true" style="display: none;">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header" style="margin-left: 20px;">
                <h3 class="modal-title">
                    添加需求方回访</h3>
            </div>
            {* <form action="" method="post" class="clearfix">*}
            <div class="modal-body" style="margin-left: 20px;">
                <input type="hidden" name="demand_id" id="demand_id" value="{$_REQUEST['demand_id']}">
                <table width="80%" >
                    <tr>
                        <td>是否成交：</td>
                        <td colspan="4">
                            <input type="radio" name="radioss" value="1" checked="checked">是
                            <input type="radio" name="radioss" value="2" style="margin-left: 20px;">否
                        </td>
                    </tr>
                    <tr class="laiyuan" >
                        <td>成交来源：</td>
                        <td colspan="4">
                            <input type="text" name="addr" class="addr" style="margin-top:5px;margin-bottom:10px;display:block;">
                        </td>
                    </tr>
                    <tr >
                        <td>备注：</td>
                        <td colspan="4">
                            <textarea class="form-control demand_reason"
                                      rows="5" placeholder="请输入回访信息"></textarea>
                        </td>
                    </tr>
                </table>
                <div style="margin:20px 180px;">
                    <button type="button" class="btn btn-default" data-dismiss="modal">
                        取消
                    </button>
                    <button type="button" class="btn btn-success demand_interview">
                        确定
                    </button>
                </div>
            </div>
            {*    </form>*}
            <div class="modal-footer">
                <div class="modal-header" >
                    {if $_as}
                        <h3 class="modal-title" style="text-align: center;margin-bottom: 5px">
                            回访历史记录</h3>
                    {/if}
                    {foreach $_rs as $k => $v}
                        {if $v['step']}
                            <div style="background: #ccc;padding: 10px 0;margin-bottom: 10px;">
                                {if $v['step']==1}
                                    <dl style="margin-bottom: 10px;">
                                        <dd style="text-align: left;margin-left: 40px;font-size: 20px;color: #eb8f00">已成交&nbsp;成交来源：{$v['addr']}</dd>
                                    </dl>
                                {/if}
                                <dl style="margin-bottom: 8px;">
                                    <dd style="text-align: left;margin-left: 40px">创建时间:{date('Y-m-d H:i:s',$v['create_time'])}</dd>
                                </dl>
                                <dl>
                                    <dd style="text-align: left;margin-left: 40px">{$v['reason']}</dd>
                                </dl>

                            </div>
                        {/if}
                    {/foreach}

                </div>
            </div>
        </div>

    </div>

</div>
{*历史记录*}
<div class="modal fade" id="demand_list" tabindex="-1" role="demand_list" aria-hidden="true" style="display: none;">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header" >
                <h3 class="modal-title" style="text-align: center;margin-bottom: 5px">
                    回访历史记录</h3>
                {foreach $_rs as $k => $v}
                    {if $v['step']}
                        <div style="background: #ccc;padding: 10px 0;margin-bottom: 10px;">
                            {if $v['step']==1}
                                <dl style="margin-bottom: 10px">
                                    <dd style="text-align: left;margin-left: 40px;font-size: 20px;color: #eb8f00">已成交&nbsp;成交来源：{$v['addr']}</dd>
                                </dl>
                            {/if}
                            <dl style="margin-bottom: 8px">
                                <dd style="text-align: left;margin-left: 40px">创建时间：{date('Y-m-d H:i:s',$v['create_time'])}</dd>
                            </dl>
                            <dl style="margin-bottom: 8px">
                                <dd style="text-align: left;margin-left: 40px">{$v['reason']}</dd>
                            </dl>

                        </div>
                    {/if}
                {/foreach}
                <button type="button" class="btn btn-default" data-dismiss="modal" style="width:55px;margin:0 auto;display: block;">
                    关闭
                </button>
            </div>
        </div>


    </div>

</div>

<style>
    table.tag_margin tr td, th {
        text-align: center;
        line-height: 25px;;
    }

    .none {
        display: none;
    }

    .save_space_style {
        color: #ecbc29;
    }
</style>
<script type="text/javascript" src="js/moment.min.js"></script>
<script type="text/javascript" src="js/zh-cn.js"></script>
<script src="{$_assets}/plugins/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
<script src="{$_assets}scripts/_page.js"></script>
<script id="tpl">
    <dl style="margin-bottom:8px;">
    <dd style="text-align: left;margin-left: 40px"></dd>
    </dl>
    <dl style="margin-bottom:8px;">
    <dd style="text-align: left;margin-left: 40px"></dd>
    </dl>


</script>
<script>
    $('input[name="radioss"]').change(function(){
        var rad=$(this).val();
        if(rad ==1){
            $('.laiyuan').removeClass('none');
        }else{
            $('.laiyuan').addClass('none');
        }
    });

    window.space_id = null;
$(document).ready(function () {
    //商户需求回访
    $('.user_revisit').click(function(){
        window.space_id = $(this).data('space');
        var demand_id=$('#demand_id').val();
        $.ajax({
            type: "post",
            url: "?act=demand_offer&action=userrevisit",
            data:{
                demand_id:demand_id ,
                space_id: window.space_id
            },
            dataType: "json",
            success: function(data) {
                console.log(data);
                var length = data.data.length;
                var d = data.data;

                $('#huifang').html("");
                if(length >= 1){
                    for(var i=0;i<length;i++){
                        $tpl =  $('<div style="background: #ccc;padding: 5px 0;margin-bottom: 10px;"></div>').append($('#tpl').html());
                        $tpl.find('dd').eq(0).text('创建时间:'+d[i].create_time);
                        $tpl.find('dd').eq(1).text(d[i].reason);
                        $('#huifang').append($tpl);
                        $('.shanghu').removeClass('none');
                    }
                }else{
                    $('.shanghu').addClass('none');
                }

            }
        })
    });
    $('.merchant_interview').click(function(){
        // var space_id = $('.user_revisit').data('space');
        var reason = $('.merchant_reason').val();
        var demand_id=$('#demand_id').val();
        var item_id = $('.merchant-tr').attr('items');
        if(!reason){
            alert('回访信息不能为空！');
            return false;
        }
        if(reason.length <10){
            alert('回访信息至少十个字');
            return false;
        }
        $.ajax({
            type: "post",
            url: "http://{Core::$urls['host']}/static/api/demand/offer/merchant.json?action=create_merchant",
            data:{
                demand_id:demand_id,
                reason:reason,
                space_id: window.space_id ,
                item_id:item_id
            },
            dataType: "json",
            success: function(data) {
                if(data.status==1){
                    top.alert(data.msg);
                    window.location.reload();
                }else{
                    top.alert(data.msg);
                }

            }
        });
    });
    //客户需求回访
    $('.demand_interview').click(function(){
        var reason = $('.demand_reason').val();
        var demand_id=$('#demand_id').val();
        var chang =  $('input[name="radioss"]:checked').val();
        var addr=$('.addr').val();
        if(chang==1){
            if(!addr){
                alert('需求来源不能为空！');
                return false;
            }
        }
        if(!reason){
            alert('回访信息不能为空！');
            return false;
        }
        if(reason.length <10){
            alert('回访信息至少十个字');
            return false;
        }
        $.ajax({
            type: "post",
            url: "http://{Core::$urls['host']}/static/api/demand/offer/merchant.json?action=create_clientele",
            data:{
                demand_id:demand_id,
                reason:reason,
                step:chang,
                addr:addr
            },
            dataType: "json",
            success: function(data) {
                if(data.status==1){
                    top.alert(data.msg);
                    window.location.reload();
                }else{
                    top.alert(data.msg);
                }

            }
        });
    });

    $(".tags_select2").each(function () {
        $(this).select2({
            tags: $(this).attr('data-values').split(',')
        })
    });
    $(".add_tag").click(function () {
        //  alert('111');
        var tags = $(".tags_select2").select2('val');
        if (tags == '') {
            top.alert('请填写或选择标签！');
            return false;
        }
        $.ajax({
            type: "GET",
            url: "http://{Core::$urls['host']}/static/api/demand/offer/check/demand/tag.json",
            data: 'tags=' + tags,
            dataType: "json",
            success: function (data) {
                if (data.status == 1) {
                    $('.tag_table').removeClass("hide");
                    var n_obj = $('.n_tbody');
                    $.each(data.data, function (i, val) {
                        var obj1 = $('.h_clone').clone();
                        obj1.removeClass("hide h_clone");
                        obj1.appendTo(n_obj);
                        var obj2 = obj1.find('input');
                        var j = n_obj.children('tr').size() - 1;
                        obj2.eq(0).attr('name', 'search[tags][' + j + '][id]');
                        obj2.eq(0).attr('value', val.id);
                        obj1.find('.tag_name').html(val.tag_value);
                        var obj3 = obj1.find(':radio');
                        obj3.eq(0).attr('name', 'search[tags][' + j + '][value]');
                        obj3.eq(1).attr('name', 'search[tags][' + j + '][value]');
                        obj3.eq(2).attr('name', 'search[tags][' + j + '][value]');
                    });
                } else {
                    top.alert(data.msg);
                }
            }
        });
    });
    $(".send_message").click(function () {
        //添加到
        var o = $(this);
        var result_id = o.attr('result-id');
        var demand_id = o.attr('demand_id');
        $.ajax({
            type: "GET",
            url: "http://{Core::$urls['host']}/static/api/demand/offer/match/result/change/status.json",
            data: 'id=' + result_id + '&demand_id=' + demand_id,
            dataType: "json",
            success: function (data) {
                if (data.status == 1) {
                    o.addClass('hide');
                    o.siblings().addClass('hide');
                    top.alert('  已进入发送列表');
                } else {
                    top.alert(data.msg);
                }
            }
        });
    });
    $(".send_message_all").click(function () {
        //添加到
        var o = $(this);
        var type = o.attr('data-type');
        var demand_id = o.attr('demand_id');
//            console.log(type,demand_id);
        $.ajax({
            type: "GET",
            url: "http://{Core::$urls['host']}/static/api/demand/offer/match/result/change/status.json",
            data: 'type=' + type + '&demand_id=' + demand_id,
            dataType: "json",
            success: function (data) {
                if (data.status == 1) {
                    $('.send_message').addClass('hide');
                    $('.delete_result').addClass('hide');
                    top.alert('  已进入发送列表');
                } else {
                    top.alert(data.msg);
                }
            }
        });
        location.reload();
    });
    $(".send_message_new").click(function () {
        //添加到
        var o = $(this);
        var item_id = o.attr('item-id');
        var demand_id = o.attr('demand-id');
        var offer_id = o.attr('offer-id');
        $.ajax({
            type: "GET",
            url: "http://{Core::$urls['host']}/static/api/demand/offer/match/result/send/message.json",
            data: 'item_id=' + item_id + '&demand_id=' + demand_id + '&offer_id=' + offer_id,
            dataType: "json",
            success: function (data) {
                if (data.status == 1) {
                    o.addClass('hide');
//                        o.siblings().addClass('hide');
                    top.alert('  已进入发送列表');
                } else {
                    top.alert(data.msg);
                }
            }
        });
    });
    $(".delete_result").click(function () {
        //添加到
        var o = $(this);
        var r = confirm("确认要删除匹配结果吗？")
        if (r == true) {
            var result_id = o.attr('result-id');
            var demand_id = o.attr('demand_id');
            $.ajax({
                type: "GET",
                url: "http://{Core::$urls['host']}/static/api/demand/offer/match/result/delete.json",
                data: 'id=' + result_id + '&demand_id=' + demand_id,
                dataType: "json",
                success: function (data) {
                    if (data.status == 1) {
                        o.parent().parent().remove();
                        top.alert('  删除成功');
                    } else {
                        top.alert(data.msg);
                    }
                }
            });
        }
        else {
            return false;
        }
    });
    $(".expend").click(function () {
        var item_id = $(this).attr('data-value');
        var space_id = $(this).attr('space-id');
        if (item_id == '' || space_id == '') {
            top.alert('参数错误');
            return false;
        }
        $(".modal-content").css("margin-top", $(this).offset().top - 500);
        $.ajax({
            type: "GET",
            url: "http://{Core::$urls['host']}/static/api/space/item/get/info.json",
            data: 'item_id=' + item_id,
            dataType: "json",
            success: function (data) {
                if (data.status == 1) {
                    $(".space_name").val(data.data.space_name);
                    $("input[name=item_name]").val(data.data.item_name);
                    $("input[name=min_price]").val(data.data.min_price);
                    $("input[name=max_price]").val(data.data.max_price);
                    $("input[name=min_people]").val(data.data.min_people);
                    $("input[name=max_people]").val(data.data.max_people);
                    $("input[name=size]").val(data.data.size);
                    var baidu_s = 'http://www.baidu.com/s?wd=';
                    $(".baidu_search").attr('href', baidu_s + data.data.city + ' ' + data.data.space_name)
                    var baidu_s = 'http://map.baidu.com/?newmap=1&ie=utf-8&s=s%26wd%3D';
                    $(".baidu_map_search").attr('href', baidu_s + data.data.city + ' ' + data.data.space_name)
                    var gaode_map = 'http://ditu.amap.com/search?query=';
                    $(".gaode_map").attr('href', gaode_map + data.data.city + ' ' + data.data.space_name)

                    var addr_baidu_s = 'http://map.baidu.com/?newmap=1&ie=utf-8&s=s%26wd%3D';
                    $(".addr_baidu_map_search").attr('href', addr_baidu_s + data.data.city + ' ' + data.data.addr)
                    var addr_gaode_map = 'http://ditu.amap.com/search?query=';
                    $(".addr_gaode_map").attr('href', addr_gaode_map + data.data.city + ' ' + data.data.addr)

                    $("input[name=space_id]").val(data.data.space_id);
                    $("input[name=item_id]").val(item_id);
                    if (data.data.phone != '') {
                        $("input[name=phone]").val(data.data.phone);
                    }
                    if (data.data.email != '') {
                        $("input[name=email]").val(data.data.email);
                    }
                    if (data.data.contacts != '') {
                        $("input[name=contacts]").val(data.data.contacts);
                    }
                } else {
                    top.alert(data.msg);
                    return false;
                }
            }
        });
        $.ajax({
            type: "GET",
            url: "http://{Core::$urls['host']}/static/api/spacepedia/handle/repeat.json",
            data: 'space_id=' + space_id,
            dataType: "json",
            success: function (data) {
                if (data.status == 1) {
                    if (data.data.length > 0) {
                        var n_obj = $('.save_space_tbody');
                        n_obj.find('tr').remove();
                        $.each(data.data, function (i, val) {
                            console.log(i);
                            var obj1 = $('.h_clone_a').clone();
                            obj1.removeClass("hide h_clone_a");
                            obj1.appendTo(n_obj);
                            obj1.find('.save_space_td').html(val.space_name);
                            if (val.id == space_id) {
                                obj1.find(".save_space_checkbox").addClass("none");
                                obj1.find(".save_item_checkbox").addClass("none");
                                obj1.find(".save_space_text").text("要保留的百科");
                                obj1.find(".save_item_text").text("");
                                obj1.find(".save_space_text").addClass("save_space_style");
                                $("#save_id").val(val.id);
                                $("#old_space_name").val(val.space_name);
                                $("#space_name_new").val(val.space_name);
                            } else {
                                obj1.find(".save_space_checkbox").removeClass("none");
                                obj1.find(".save_item_checkbox").removeClass("none");
                                obj1.find(".save_space_text").text("标记为重复");
                                obj1.find(".save_item_text").text("标记为子空间");
                                obj1.find(".save_space_text").removeClass("save_space_style");
                                var obj3 = obj1.find('label');
                                obj3.eq(0).attr('for', 'repeat' + val.id);
                                obj3.eq(1).attr('for', 'repeat_item' + val.id);
                                var obj4 = obj1.find('input');
                                obj4.eq(0).attr('id', 'repeat' + val.id);
                                obj4.eq(0).val(val.id);
                                obj4.eq(1).attr('id', 'repeat_item' + val.id);
                                obj4.eq(1).val(val.id);
                            }
                        });
                        var obj2 = $('.h_clone_b').clone();
                        obj2.removeClass("hide h_clone");
                        obj2.appendTo(n_obj);
                    } else {
                        $('.save_more').remove();
                    }

                } else {
                    $('.save_more').remove();
                    return false;
                }
            }
        });
    });
    $('.change_down').click(function () {
        var item_id = $(this).attr('data-value');
        if (item_id == '') {
            top.alert('参数错误');
            return false;
        }
        var o = $(this);
        $.ajax({
            type: "GET",
            url: "http://{Core::$urls['host']}/static/api/demand/offer/item/result/change/status.json",
            data: 'item_id=' + item_id + '&expand_status=-1',
            dataType: "json",
            success: function (data) {
                if (data.status == 1) {
                    o.parent().parent().remove();
                    top.alert('  下移成功');
                } else {
                    top.alert(data.msg);
                }
            }
        });

    });
    $('.refuse_reason_show').click(function () {
        $(this).hide();
        $('.refuse_reason_text').removeClass('hidden');
        $('.refuse_reason_button').removeClass('hidden');
    });
    $('.submit_form').click(function () {
        $('.submit_type').val($(this).attr('type_value'));
        if ($(this).attr('type_value') != -3) {
            if ($('input[name=phone]').val() == '') {
                top.alert('手机号不能为空');
                return false;
            }
            var min_people = $('input[name=min_people]').val();
            var max_people = $('input[name=max_people]').val();
            if (min_people > max_people) {
                top.alert('请正确填写最大人数和最小人数');
                return false;
            }
            if (max_people > 50 && min_people < max_people * 0.5) {
                top.alert('最小人数不得低于最大人数的50%');
                return false;
            }

//                if($('input[name=email]').val()==''){
//                    top.alert('邮箱不能为空');
//                    return false;
//                }
//            if($('input[name=contacts]').val()==''){
//                top.alert(data.msg);
//                return false;
//            }
        }

        $('.form_c').submit();
    });
    function formatRepo(repo) {
        if (repo.loading) return repo.text;
        return repo.full_name;
    }

    function formatRepoSelection(repo) {
        return repo.full_name || repo.text;
    }
});
var LvEdit = function () {
    return {
        init: function () {
        },
        delete: function (obj) {
            $(obj).parent().parent().remove();
        }
    };
}();
</script>
</body>
<!-- END BODY -->
</html>