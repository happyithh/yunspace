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
    <style>
        .readdata p {
            padding: 0
        }

        .text_right {
            margin-bottom: 30px;
            text-align: right;
        }
    </style>

    <!-- BEGIN JAVASCRIPTS(Load javascripts at bottom, this will reduce page load time) -->
    <!-- BEGIN CORE PLUGINS -->
    <script src="{$_assets}plugins/jquery-1.11.0.min.js"
            tab="text/javascript"></script>
    <script src="{$_assets}plugins/jquery-migrate-1.2.1.min.js"
            tab="text/javascript"></script>
    <!-- IMPORTANT! Load jquery-ui-1.10.3.custom.min.js before bootstrap.min.js to fix bootstrap tooltip conflict with jquery ui tooltip -->
    <script src="{$_assets}plugins/jquery-ui/jquery-ui-1.10.3.custom.min.js"
            tab="text/javascript"></script>
    <script src="{$_assets}plugins/bootstrap/js/bootstrap.min.js"
            tab="text/javascript"></script>
    <script src="{$_assets}plugins/bootstrap-hover-dropdown/bootstrap-hover-dropdown.min.js"
            tab="text/javascript"></script>
    <script src="{$_assets}plugins/jquery-slimscroll/jquery.slimscroll.min.js"
            tab="text/javascript"></script>
    <script src="{$_assets}plugins/jquery.blockui.min.js"
            tab="text/javascript"></script>
    <script src="{$_assets}plugins/uniform/jquery.uniform.min.js"
            tab="text/javascript"></script>
    <!-- END CORE PLUGINS -->
    <!-- BEGIN PAGE LEVEL PLUGINS -->
    <script tab="text/javascript"
            src="{$_assets}plugins/select2/select2.min.js"></script>
    <script tab="text/javascript"
            src="{$_assets}plugins/datatables/media/js/jquery.dataTables.min.js"></script>
    <script tab="text/javascript"
            src="{$_assets}plugins/datatables/plugins/bootstrap/dataTables.bootstrap.js"></script>
    <!-- END PAGE LEVEL PLUGINS -->
    <!-- BEGIN PAGE LEVEL SCRIPTS -->
    <script src="{$_assets}scripts/_page.js"></script>
</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->

<body style="background:#FaFaFa !important">
<div class="portlet tabbable">

    <div class="portlet-body" style="padding:10px 10px">
        <div class="portlet-tabs">
            <div class="tabbable">
                <div class="tab-content clearfix">


                    <div class="portlet tabbable">
                        <div class="portlet-title">
                            <div class="caption">
                                <i class="fa fa-database"></i>文创信息
                            </div>
                        </div>
                        <form class="form-horizontal" role="form" action="?" method="post" enctype="multipart/form-data">
                            <div class="portlet-body form">
                                <input type="hidden" name="action" value="is_submit">
                                <input type="hidden" name="id" value="{$_REQUEST['id']}">
                                <input type="hidden" name="url_referer" value="{Core::$urls['referer']}">
                                <div class="form-body">
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label class="control-label col-md-2">资源的名称<span class="required" aria-required="true">*</span></label>

                                                <div class="col-md-10">
                                                    <input type="text" class="form-control" placeholder="资源的名称"
                                                           name="resource_name"
                                                           value="{$_data['resource_name']}">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6" >
                                            <div class="form-group">
                                                <label class="control-label col-md-2">云负责人<span class="required" aria-required="true">*</span></label>

                                                <div class="col-md-10">
                                                    <select name="yun_principal" class="form-control input-sm">
                                                        {foreach $yun_principal as $key=>$val}
                                                            <option {if $_data['yun_principal']==$key}selected{/if}
                                                                    value="{$key}">{$val}</option>
                                                        {/foreach}
                                                    </select>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label class="control-label col-md-2">资源来自国家</label>

                                                <div class="col-md-10">
                                                    <select  name="attr[资源来自国家]" class="form-control input-sm">
                                                        {foreach $resource_form as $key=>$val}
                                                            <option {if $_data['attr']['资源来自国家']==$val}selected{/if}
                                                                    value="{$val}">{$val}</option>
                                                        {/foreach}
                                                    </select>
                                                </div>
                                            </div>
                                        </div>


                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label class="control-label col-md-2">IP所属单位</label>

                                                <div class="col-md-10">
                                                    {*<div class="col-md-6" style="padding-left: 0px;">*}
                                                    <input type="text" class="form-control" name="attr[IP所属单位]" placeholder="IP所属单位" value="{$_data['attr']['IP所属单位']}">
                                                    {*</div>*}
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label class="control-label col-md-2">分类<span class="required" aria-required="true">*</span></label>
                                                <div class="col-md-10">
                                                    <select name="category" class="form-control input-sm">
                                                        {foreach $category as $key=>$val}
                                                            <option {if $_data['category']==$key}selected{/if}
                                                                    value="{$key}">{$val}</option>
                                                        {/foreach}
                                                    </select>

                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label class="control-label col-md-2">表现形式<span class="required" aria-required="true">*</span></label>
                                                <div class="col-md-10">
                                                    <select name="manifestation" class="form-control input-sm">
                                                        {foreach $manifestation as $key=>$val}
                                                            <option {if $_data['manifestation']==$val}selected{/if}
                                                                    value="{$val}">{$val}</option>
                                                        {/foreach}
                                                    </select>

                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label class="control-label col-md-2">运营范围<span class="required" aria-required="true">*</span></label>
                                                <div class="col-md-10">
                                                    <select name="operation_range" class="form-control input-sm">
                                                        {foreach $city_array as $key=>$val}
                                                            <option {if $_data['operation_range']==$val}selected{/if}
                                                                    value="{$val}">{$val}</option>
                                                        {/foreach}
                                                    </select>

                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label class="control-label col-md-2">授权金</label>
                                                <div class="col-md-10">
                                                    <select name="attr[授权金]" class="form-control input-sm">
                                                        {foreach $authorization_money as $key=>$val}
                                                            <option {if $_data['attr']['授权金']==$val}selected{/if}
                                                                    value="{$val}">{$val}</option>
                                                        {/foreach}
                                                    </select>

                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label class="control-label col-md-2">年限</label>
                                                <div class="col-md-10">
                                                    <select name="attr[年限]" class="form-control input-sm">
                                                        {foreach $life_array as $key=>$val}
                                                            <option {if $_data['attr']['年限']==$key}selected{/if}
                                                                    value="{$key}">{$val}</option>
                                                        {/foreach}
                                                    </select>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label class="control-label col-md-2">物料</label>
                                                <div class="col-md-10">
                                                    <select name="attr[物料]" class="form-control input-sm">
                                                        {foreach $materiel as $key=>$val}
                                                            <option {if $_data['attr']['物料']==$val}selected{/if}
                                                                    value="{$val}">{$val}</option>
                                                        {/foreach}
                                                    </select>

                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label class="control-label col-md-2">合作状态<span class="required" aria-required="true">*</span></label>
                                                <div class="col-md-10">
                                                    <select name="cooperating_state" class="form-control input-sm">
                                                        {foreach $cooperating_state_array as $key=>$val}
                                                            <option {if $_data['cooperating_state']==$val}selected{/if}
                                                                    value="{$val}">{$val}</option>
                                                        {/foreach}
                                                    </select>

                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label class="control-label col-md-2">价格分类</label>
                                                <div class="col-md-10">
                                                    <select name="attr[价格分类]" class="form-control input-sm">
                                                        {foreach $price_category_array as $key=>$val}
                                                            <option {if $_data['attr']['价格分类']==$val}selected{/if}
                                                                    value="{$val}">{$val}</option>
                                                        {/foreach}
                                                    </select>

                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label class="control-label col-md-2">合作模式<span class="required" aria-required="true">*</span></label>
                                                <div class="col-md-10">
                                                    <select name="cooperating_mode" class="form-control input-sm">
                                                        {foreach $cooperating_mode_array as $key=>$val}
                                                            <option {if {$_data['cooperating_mode']}==$val}selected{/if}
                                                                    value="{$val}">{$val}</option>
                                                        {/foreach}
                                                    </select>

                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label class="control-label col-md-2">符合人群<span class="required" aria-required="true">*</span></label>
                                                <div class="col-md-10">
                                                    {*<select name="conform_crowd" class="form-control input-sm">*}
                                                        {*{foreach $category as $key=>$val}*}
                                                            {*<option {if {$_data['conform_crowd']}==$key}selected{/if}*}
                                                                    {*value="{$key}">{$val}</option>*}
                                                        {*{/foreach}*}
                                                    {*</select>*}
                                                    <input type="text" class="form-control" placeholder="符合人群"
                                                           name="conform_crowd"
                                                           value="{$_data['conform_crowd']}">

                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label class="control-label col-md-2">关键词<span class="required" aria-required="true">*</span></label>
                                                <div class="col-md-10">
                                                    <input type="text" class="form-control input-sm select2 tags_select2" value="{implode(',',$_data['tags_info'])}" name="tags_info[]"   data-values="{implode(',',$attr)}">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label class="control-label col-md-2">面积</label>
                                                <div class="col-md-6">
                                                    <select name="area" class="form-control input-sm">
                                                        {foreach $area_array as $key=>$val}
                                                            <option {if {$_data['area']}==$key}selected{/if}
                                                                    value="{$key}">{$val}</option>
                                                        {/foreach}
                                                    </select>
                                                </div>单位（平方米）
                                            </div>
                                        </div>
                                        <div class="col-md-6" >
                                            <div class="form-group">
                                                <label class="control-label col-md-2">授权费</label>
                                                <div class="col-md-10">
                                                    <input type="text" class="form-control" placeholder="授权费"
                                                           name="attr[授权费]"
                                                           value="{$_data['attr']['授权费']}">

                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label class="control-label col-md-2">搭建费</label>
                                                <div class="col-md-10">
                                                    <input type="text" class="form-control" placeholder="搭建费"
                                                           name="attr[搭建费]"
                                                           value="{$_data['attr']['搭建费']}">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6" >
                                            <div class="form-group">
                                                <label class="control-label col-md-2">道具费</label>
                                                <div class="col-md-10">
                                                    <input type="text" class="form-control" placeholder="道具费"
                                                           name="attr[道具费]"
                                                           value="{$_data['attr']['道具费']}">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6" >
                                            <div class="form-group">
                                                <label class="control-label col-md-2">运营费</label>
                                                <div class="col-md-10">
                                                    <input type="text" class="form-control" placeholder="运营费"
                                                           name="attr[运营费]"
                                                           value="{$_data['attr']['运营费']}">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6" >
                                            <div class="form-group">
                                                <label class="control-label col-md-2">运营团队所属国家</label>
                                                <div class="col-md-10">
                                                    <select name="attr[运营团队所属国家]" class="form-control input-sm">
                                                        {foreach $yunying_team_array as $key=>$val}
                                                            <option {if $_data['attr']['运营团队所属国家']==$val}selected{/if}
                                                                    value="{$val}">{$val}</option>
                                                        {/foreach}
                                                    </select>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label class="control-label col-md-2">档期</label>
                                                <div class="col-md-10">
                                                    <input type="text" class="form-control" placeholder="档期"
                                                           name="attr[档期]"
                                                           value="{$_data['attr']['档期']}">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label class="control-label col-md-2">上线网站标题<span class="required" aria-required="true">*</span></label>

                                                <div class="col-md-10">
                                                    <input type="text" class="form-control" placeholder="文创标题"
                                                           name="title"
                                                           value="{$_data['title']}">
                                                </div>
                                            </div>
                                        </div>


                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label class="control-label col-md-2">概括活动的一句话<span class="required" aria-required="true">*</span></label>

                                                <div class="col-md-10">
                                                    {*<div class="col-md-6" style="padding-left: 0px;">*}
                                                        <input type="text" class="form-control" name="marketing_title" placeholder="请填写营销副标题" value="{$_data['marketing_title']}">
                                                    {*</div>*}
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label class="control-label col-md-2">联系人</label>

                                                <div class="col-md-10">
                                                    <input type="text" class="form-control" placeholder="联系人"
                                                           name="attr[联系人]"
                                                           value="{$_data['attr']['联系人']}">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label class="control-label col-md-2">职位</label>

                                                <div class="col-md-10">
                                                    <input type="text" class="form-control" placeholder="职位"
                                                           name="attr[职位]"
                                                           value="{$_data['attr']['职位']}">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label class="control-label col-md-2">邮箱</label>

                                                <div class="col-md-10">
                                                    <input type="text" class="form-control" placeholder="邮箱"
                                                           name="attr[邮箱]"
                                                           value="{$_data['attr']['邮箱']}">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label class="control-label col-md-2">联系电话</label>

                                                <div class="col-md-10">
                                                    <input type="text" class="form-control" placeholder="联系电话"
                                                           name="attr[联系电话]"
                                                           value="{$_data['attr']['联系电话']}">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label class="control-label col-md-2">被授权公司</label>

                                                <div class="col-md-10">
                                                    <input type="text" class="form-control" placeholder="被授权公司"
                                                           name="attr[被授权公司]"
                                                           value="{$_data['attr']['被授权公司']}">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label class="control-label col-md-2">策展人</label>

                                                <div class="col-md-10">
                                                    <input type="text" class="form-control" placeholder="策展人"
                                                           name="attr[策展人]"
                                                           value="{$_data['attr']['策展人']}">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label class="control-label col-md-2">作者</label>

                                                <div class="col-md-10">
                                                    {*<div class="col-md-6" style="padding-left: 0px;">*}
                                                        <input type="text" class="form-control" name="author" placeholder="请输入作者" value="{$_data['author']}">
                                                    {*</div>*}
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label class="control-label col-md-2">状态</label>

                                                <div class="col-md-10">
                                                    <select name="status" class="form-control input-sm">
                                                        {foreach $status as $key=>$val}
                                                            <option {if {$_data['status']}==$key}selected{/if}
                                                                    value="{$key}">{$val}</option>
                                                        {/foreach}
                                                    </select>
                                                </div>
                                            </div>
                                        </div>


                                        {*<div class="col-md-6" style="float: right">*}
                                            {*<div class="form-group">*}
                                                {*<label class="control-label col-md-2">标签</label>*}
                                                {*<div class="col-md-10">*}


                                                    {*<input type="text" class="form-control input-sm select2 tags_select2" value="{implode(',',$_data['tags_info'])}" name="tags_info[]"   data-values="{implode(',',$attr)}">*}

                                                {*</div>*}
                                            {*</div>*}
                                        {*</div>*}

                                        {*<div class="col-md-6">*}
                                            {*<div class="form-group">*}
                                                {*<label class="control-label col-md-2">类别</label>*}
                                                {*<div class="col-md-10">*}
                                                    {*<select name="category" class="form-control input-sm">*}
                                                        {*{foreach $category as $key=>$val}*}
                                                            {*<option {if {$_data['category']}==$key}selected{/if}*}
                                                                    {*value="{$key}">{$val}</option>*}
                                                        {*{/foreach}*}
                                                    {*</select>*}

                                                {*</div>*}
                                            {*</div>*}
                                        {*</div>*}



                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label class="control-label col-md-2">排序优先级</label>

                                                <div class="col-md-10">
                                                    {*<label class="radio-inline">*}
                                                    {*<input type="radio" name="data[order_lv]" value="4"*}
                                                    {*{if $_data['order_lv']==4}checked="checked" {/if}>*}
                                                    {*高++*}
                                                    {*</label>*}
                                                    <label class="radio-inline">
                                                        <input type="radio" name="order_lv" value="3"
                                                               {if $_data['order_lv']==3}checked="checked" {/if}>
                                                        A
                                                    </label>
                                                    <label class="radio-inline">
                                                        <input type="radio" name="order_lv" value="2"
                                                               {if $_data['order_lv']==2}checked="checked" {/if}>
                                                        B
                                                    </label>
                                                    <label class="radio-inline">
                                                        <input type="radio" name="order_lv" value="1"
                                                               {if $_data['order_lv']==1}checked="checked" {/if}>
                                                        C
                                                    </label>
                                                    <label class="radio-inline">
                                                        <input type="radio" name="order_lv" value="0"
                                                               {if $_data['order_lv']==0}checked="checked" {/if}>
                                                        D
                                                    </label>
                                                    <label class="radio-inline">
                                                        <input type="radio" name="order_lv" value="-1"
                                                               {if $_data['order_lv']==-1}checked="checked" {/if}>
                                                        E
                                                    </label>
                                                    <label class="radio-inline">
                                                        <input type="radio" name="order_lv" value="-2"
                                                               {if $_data['order_lv']==-2}checked="checked" {/if}>
                                                        F
                                                    </label>
                                                    <label class="radio-inline">
                                                        <input type="radio" name="order_lv" value="-3"
                                                               {if $_data['order_lv']==-3}checked="checked" {/if}>
                                                        G
                                                    </label>
                                                    <label class="radio-inline">
                                                        <span style="color:#bd362f">(*默认为D)</span>
                                                    </label>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label class="control-label col-md-2">预算范围</label>

                                                <div class="col-md-10">
                                                    {*<div class="col-md-6" style="padding-left: 0px;">*}
                                                    <input type="text" class="form-control" style="width:200px;display: inline-block" name="attr[预算上限]" value="{$_data['attr']['预算上限']}" placeholder="请填写数字">&nbsp;&nbsp;-&nbsp;&nbsp;
                                                    <input type="text" class="form-control" style="width:200px;display: inline-block" name="attr[预算下限]" value="{$_data['attr']['预算下限']}" placeholder="请填写数字"> 单位（元）
                                                    {*</div>*}
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label class="control-label col-md-2">备注</label>

                                                <div class="col-md-10">
                                                    <textarea class="form-control" rows="3" name="remarks">{$_data['remarks']}</textarea>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row">



                                        {*属性数组，如城市，国家，时间，地点等*}
                                        {*<div class="col-md-12">*}
                                            {*{foreach $_tags_info as $key=>$value}*}
                                                {*<div class="form-group">*}
                                                    {*<label class="control-label col-md-1">文创属性</label>*}

                                                    {*<div class="col-md-11">*}
                                                        {*{foreach $value as $ik=>$iv}*}
                                                            {*<div class="input-group">*}
                                        {*<span class="input-group-addon">*}
                                            {*{if $iv['tags_name'] == '城市'}*}
                                                {*<span class="required" aria-required="true"*}
                                                      {*style="color:#C63300">*</span>*}
                                            {*{/if}*}
                                            {*{$iv['tags_name']}*}
                                            {*来源:*}
                                        {*</span>*}
                                                                {*<input type="text" class="form-control select2 tags_select2"*}
                                                                       {*name="attr[来源]" value="{$_data['attr']['来源']}"*}
                                                                       {*data-values="{implode(',',$_data['attr']['来源'])}">*}
                                                            {*</div>*}



                                                        {*<div class="input-group">*}
                                        {*<span class="input-group-addon">*}
                                            {*面积:*}
                                        {*</span>*}
                                                            {*<input type="text" class="form-control select2 tags_select2"*}
                                                                   {*name="attr[面积]" value="{$_data['attr']['面积']}"*}
                                                                   {*data-values="{implode(',',$_data['attr']['面积'])}" placeholder="请填写数字，单位（平方米）">*}
                                                        {*</div>*}

                                                        {*<div class="input-group">*}
                                        {*<span class="input-group-addon">*}
                                            {*适用人群:*}
                                        {*</span>*}
                                                            {*<input type="text" class="form-control select2 tags_select2"*}
                                                                   {*name="attr[适用人群]" value="{$_data['attr']['适用人群']}"*}
                                                                   {*data-values="{implode(',',$_data['attr']['适用人群'])}">*}
                                                        {*</div>*}

                                                        {*{/foreach}*}
                                                    {*</div>*}

                                                {*</div>*}
                                            {*{/foreach}*}
                                        {*</div>*}
                                        {*属性数组，如城市，国家，时间，地点等*}




                                        {*{var_dump($_data['accessory'])}*}
                                        <div class="col-md-12" id="accessory" style="">
                                            <div class="form-group">
                                                <label class="control-label col-md-1">上传附件</label>
                                                <div class="col-md-10">
                                                    <div class="fileinput fileinput-new" data-provides="fileinput">
                                                        <span class="btn btn-default btn-file">
                                                            <span class="fileinput-new">选择文件</span>
                                                            <span class="fileinput-exists">重新选择 </span>
                                                            <input type="file" accept="application/zip,application/pdf" name="accessory">
                                                        </span>
                                                        <span class="fileinput-filename">{$_data['accessory']['filename']}</span>&nbsp;
                                                        <a href="javascript:void(0)" class="close fileinput-exists"
                                                           data-dismiss="fileinput"></a>
                                                        {if $_data['accessory']}
                                                            <span class="fa fa-file"></span>

                                                            <input type="hidden" name="accessory[name]" value="{$_data['accessory']['name']}">
                                                            <input type="hidden" name="accessory[size]" value="{$_data['accessory']['size']}">
                                                            <input type="hidden" name="accessory[filename]" value="{$_data['accessory']['filename']}">
                                                        {/if}
                                                        <br/><span style="font-size:12px; ">(请上传格式为.pdf的文件，大小不能超过8M)</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>


                                        {*<div class="col-md-6">*}
                                            {*<div class="form-group">*}
                                                {*<label class="control-label col-md-2">详情描述1</label>*}

                                                {*<div class="col-md-10">*}
                                                    {*<input type="text" class="form-control" name="detail_des[]"*}
                                                           {*placeholder="如 活动地点：上海长宁区淮海西路570号F211"*}
                                                           {*value="{$_data['detail_des'][0]}">*}
                                                {*</div>*}

                                            {*</div>*}
                                        {*</div>*}
                                    </div>
                                </div>
                            </div>


                            <label class="control-label col-md-1">图片/视频<br />（至少三张）</label>

                            <div class="portlet-body">
                                <div class="tabbable tabbable-custom boxless" style="padding: 20px ;">

                                    <div class="tab-content">
                                        <!--      ---------------------------图片/视频  start-------------------------------      -->
                                        <div class="tab-pane active" id="tab_2">
                                            {include file="Admin::inc/plupload.tpl"}
                                            <script>
                                                uploader.onFileUploaded = function (file, path) {
                                                    UploadFiles.add(file, path);
                                                }
                                                var UploadFiles = {
                                                    media_id: 0,
                                                    add: function (file, path) {
                                                        if (UploadFiles.media_id < 1) {
                                                            UploadFiles.media_id = $('#upload_files tr').size() + 10;
                                                        }
                                                        UploadFiles.media_id++;
                                                        var newFile = $('#upload_files').parents('table').find('.hidden').clone().removeClass('hidden');
                                                        newFile.find('img').attr('src', path);
                                                        newFile.appendTo('#upload_files');
                                                        newFile.find('input').each(function () {
                                                            $(this).attr('name', $(this).attr('name').replace('$$', UploadFiles.media_id));
                                                        });
                                                        newFile.find('input:eq(0)').val(path);
                                                        newFile.find('input:eq(1)').val(file.name);
                                                        newFile.find('input:eq(2)').select2({
                                                            tags: UploadFiles.tags.split(',')
                                                        });
                                                    },
                                                    remove: function (o) {
                                                        $(o).parents('tr').remove();
                                                    },
                                                    up: function (o) {
                                                        var tr = $(o).parents('tr');
                                                        tr.after(tr.prev());
                                                    },
                                                    down: function (o) {
                                                        var tr = $(o).parents('tr');
                                                        tr.before(tr.next());
                                                    },
                                                    tags: '@主图,外景图片,内景图片,平面图,视频'
                                                };
                                            </script>
                                            <style>
                                                .table td {
                                                    vertical-align: middle !important;
                                                }

                                                .table .thumbnail {
                                                    margin-bottom: 0;
                                                }

                                                .table td img {
                                                    border-radius: 4px;
                                                }

                                                .table .btns i {
                                                    cursor: pointer;
                                                }

                                                .table1 td {
                                                    padding: 5px;
                                                }

                                                }
                                            </style>
                                            <table class="table table-hover">
                                                <thead>
                                                <tr>
                                                    <th width="80">缩略图</th>
                                                    <th>名称</th>
                                                    <th width="50%">标签</th>
                                                    <th width="60">操作</th>
                                                </tr>
                                                <tr class="hidden">
                                                    <td>
                                                        <img src="" style="height: 80px; width: 80px; display: block;">
                                                    </td>
                                                    <td>
                                                        <input type="hidden" name="media[$$][path]">
                                                        <input class="form-control" type="text" name="media[$$][name]">
                                                    </td>
                                                    <td>
                                                        <input class="form-control select2" type="text" name="media[$$][tags]">
                                                        <input class="form-control" type="text" name="media[$$][video]">
                                                    </td>
                                                    <td class="btns">
                                                        <i class="fa fa-long-arrow-up" onclick="UploadFiles.up(this)"></i>
                                                        <i class="fa fa-long-arrow-down" onclick="UploadFiles.down(this)"></i>
                                                        <i class="fa fa-trash-o" onclick="UploadFiles.remove(this)"></i>
                                                    </td>
                                                </tr>
                                                </thead>
                                                <tbody id="upload_files">
                                                {foreach $_data['media'] as $k=>$v}
                                                    <tr>
                                                        <td>
                                                            <img src="{$v['path']}" style="height: 80px; width: 80px; ">
                                                        </td>
                                                        <td>
                                                            <input type="hidden" name="media[{$k}][path]" value="{$v['path']}">
                                                            <input class="form-control" type="text" name="media[{$k}][name]"
                                                                   value="{$v['name']}">
                                                        </td>
                                                        <td>
                                                            <input class="form-control select2 tags_select3_product" type="text"
                                                                   name="media[{$k}][tags]" value="{$v['tags']}">
                                                            <input class="form-control select2 tags_select3_product" type="text"
                                                                   name="media[{$k}][video]" value="{$v['video']}">
                                                        </td>
                                                        <td class="btns">
                                                            <i class="fa fa-long-arrow-up" onclick="UploadFiles.up(this)"></i>
                                                            <i class="fa fa-long-arrow-down" onclick="UploadFiles.down(this)"></i>
                                                            <i class="fa fa-trash-o" onclick="UploadFiles.remove(this)"></i>
                                                        </td>
                                                    </tr>
                                                {/foreach}
                                                </tbody>
                                            </table>
                                        </div>
                                        <!--      ---------------------------图片视频  end-------------------------------      -->
                                        -->
                                    </div>
                                </div>
                            </div>

                    </div>

                    <div class="form-actions text-center">
                        <button type="reset" class="btn btn-default">
                            重置
                        </button>
                        <button type="submit" class="btn btn-success" >
                            提交
                        </button>
                    </div>
                    </form>
                </div>
                </div>
            </div>
        </div>
    </div>
                <link rel="stylesheet" type="text/css" href="{$_assets}plugins/bootstrap-fileinput/bootstrap-fileinput.css"/>
                <script type="text/javascript" src="{$_assets}plugins/bootstrap-fileinput/bootstrap-fileinput.js"></script>
                <script>

                    $(document).ready(function(){
                        $(".tags_select2").each(function () {
                            $(this).select2({
                                tags: $(this).data('values').split(',')
                            })
                        });
                        function formatRepo(repo) {
                            if (repo.loading) return repo.text;
                            return repo.full_name;
                        }

                        function formatRepoSelection(repo) {
                            return repo.full_name || repo.text;
                        }


                    });
//                    $(document).ready(function () {
//                        var sel =  $("#library").children('option:selected').val()
//                        var par = $("#library").children('option:selected').data("parent")
//                        if(sel == 12 || par ==12){
//                            $('#accessory').css('display','block');
//                        }
//                        $("#library").change(function(){
//                            var category_id = $(this).children('option:selected').val();
//                            var parent = $(this).children('option:selected').data("parent");
//                            if(category_id == 12 || parent == 12){
//                                $('#accessory').css('display','block');}else{
//                                $('#accessory').css('display','none');
//                            }
//                        });
//                    });
                </script>