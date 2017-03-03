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
</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->
<body style="background:#FaFaFa !important">

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
                    <input type="hidden" name="handle_type" value="{$_REQUEST['handle_type']}">
                    <div class="form-body clearfix">
                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">供应商名称/ID</label>

                            <div class="col-md-9">
                                <input type="text" class="form-control input-sm" placeholder="供应商名称/ID" name="vendor_name" value="{$_REQUEST['vendor_name']}">
                            </div>
                        </div>
                        {if $_REQUEST['handle_type']=="right_phone" || $_REQUEST['handle_type']=="overdue"}
                            <div class="form-group col-md-5">
                                <label class="col-md-3 control-label">手机号</label>

                                <div class="col-md-9">
                                    <input type="text" class="form-control input-sm" placeholder="手机号" name="phone" value="{$_REQUEST['phone']}">
                                </div>
                            </div>
                        {/if}
                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">城市</label>

                            <div class="col-md-9">
                                {*<select class="form-control" name="city">*}
                                    {*<option {if !$_REQUEST['city']}selected {/if} value="">全部</option>*}
                                    {*{foreach $_vendor_attr['attr']['城市'] as $k=>$v}*}
                                        {*<option {if $_REQUEST['city']==$v}selected {/if}>{$v}</option>*}
                                    {*{/foreach}*}
                                {*</select>*}
                                <input type="text" class="form-control input-sm" placeholder="请输入要搜索的城市" name="city" value="{$_REQUEST['city']}">
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
    <div class="portlet-title">
        <div class="caption">
            <i class="fa fa-comments"></i>
            待拓展供应商列表
        </div>

    </div>
    <div class="portlet-tabs" style="position:relative">
        <ul class="nav nav-tabs">
            <li class="{if $_REQUEST['handle_type']=='abandon'}active{/if}">
                <a href="?handle_type=abandon">已丢弃</a>
            </li>
            <li class="{if $_REQUEST['handle_type']=='no_expect'}active{/if}">
                <a href="?handle_type=no_expect">无意向</a>
            </li>
            <li class="{if $_REQUEST['handle_type']=='overdue'}active{/if}">
                <a href="?handle_type=overdue">过期未激活</a>
            </li>
            <li class="{if $_REQUEST['handle_type']=='error_phone'}active{/if}">
                <a href="?handle_type=error_phone">联系方式非手机号</a>
            </li>
            <li class="{if $_REQUEST['handle_type']=='no_phone'}active{/if}">
                <a href="?handle_type=no_phone">无联系方式</a>
            </li>
        </ul>
    </div>
    <div class="portlet-body">
        <div style="margin-bottom: 20px;">
            {if $is_admin}
                 <a style="margin-bottom: 10px;" href="javascript:;" class="btn btn-success get_data">更新数据</a>
            {/if}
            {foreach $group as $k=>$v}
                <a style="margin-bottom: 10px;" href="?handle_type={$_REQUEST['handle_type']}&modulo_value={$k}&city={$_REQUEST['city']}" class="btn {if isset($_REQUEST['modulo_value']) && $_REQUEST['modulo_value']==$k}btn-info{else}btn-default{/if}">{$v}</a>
            {/foreach}
        </div>
        <div class="tab-content clearfix">
            <div class="table-responsive">
                <table class="table table-striped table-bordered table-advance table-hover">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>供应商名称</th>
                    {if $_REQUEST['handle_type']!='no_phone'}
                        <th>账户名</th>
                        <th>联系方式</th>
                    {/if}
                    <th>邮箱</th>
                    <th>城市</th>
                    {if $_REQUEST['handle_type']=='overdue' || $_REQUEST['handle_type']=='no_expect'}
                        <th>创建时间</th>
                    {/if}
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                {foreach $_data['rows'] as $k=>$v}
                    <tr>
                        <td>{$v['id']}</td>
                        <td>{$v['vendor_name']}</td>
                        {if $_REQUEST['handle_type']!='no_phone'}
                            <td>{$v['username']}</td>
                            <td class="phone" data-id="{$v['account_id']}" data-vid="{$v['id']}" data-username="{$v['username']}">
                                {$v['phone']}
                                {if $v['admin_id']}
                                    <span style="color: #ecbc29;">(拓展)</span>
                                {/if}
                            </td>
                        {/if}
                        <td>{$v['email']}</td>
                        <td>{$v['city']}</td>
                        {if $_REQUEST['handle_type']=='overdue'  || $_REQUEST['handle_type']=='no_expect'}
                            <td>{date("Y-m-d H:i:s",$v['create_time'])}</td>
                        {/if}
                        <td>
                            <a class="btn btn-xs btn-primary" href="?action=add_expand&vendor_id={$v['id']}&handle_type={$_REQUEST['handle_type']}">
                                {if $_REQUEST['handle_type']=="no_phone"}
                                    添加拓展信息
                                {elseif $_REQUEST['handle_type']=="no_expect"}
                                    再次激活
                                {elseif $_REQUEST['handle_type']=="abandon"}
                                    重新拓展
                                {else}
                                    修改拓展信息
                                {/if}
                            </a>
                            <a class="btn btn-xs btn-success pull_down" data-vid="{$v['id']}" href="javascript:;">下移</a>
                            {if $_REQUEST['handle_type']=="overdue"}
                                <a class="btn btn-xs btn-default no_expect" data-vid="{$v['id']}" href="javascript:;">无意向</a>
                            {/if}
                            {if $_REQUEST['handle_type']=='overdue' && $is_admin}
                                <a class="btn btn-xs btn-info send_msg_again" data-vid="{$v['id']}" href="javascript:;">重新发送短信</a>
                            {/if}
                        </td>
                    </tr>
                {/foreach}
                </tbody>
            </table>
            <div class="text-center">
                <ul class="pagination pull-right">
                    {if $_data['page']['dpll']}
                        <li class="prev">
                            <a href="{$_data['page']['dup']}1" title="First"><i class="fa fa-angle-double-left"></i></a>
                        </li>
                        <li class="prev">
                            <a href="{$_data['page']['dup']}{$_data['page']['dp']-1}" title="Prev"><i class="fa fa-angle-left"></i></a>
                        </li>
                    {else}
                        <li class="prev disabled">
                            <a href="#" title="First"><i class="fa fa-angle-double-left"></i></a>
                        </li>
                        <li class="prev disabled">
                            <a href="#" title="Prev"><i class="fa fa-angle-left"></i></a>
                        </li>
                    {/if}
                    {for $i=$_data['page']['dpl'] to $_data['page']['dpr']}
                        <li{if $i==$_data['page']['dp']} class="active"{/if}>
                            <a href="{$_data['page']['dup']}{$i}">{$i}</a>
                        </li>
                    {/for}
                    <li class="disabled">
                        <a> {$_data['page']['dtp']}
                            ( {$_data['page']['dp']*$_data['page']['dn']}
                            /{$_data['page']['dt']}
                            )</a></li>

                    {if $_data['page']['dprr']}
                        <li class="next">
                            <a href="{$_data['page']['dup']}{$_data['page']['dp']+1}" title="Next"><i class="fa fa-angle-right"></i></a>
                        </li>
                        <li class="next">
                            <a href="{$_data['page']['dup']}{$_data['page']['dtp']}" title="Last"><i class="fa fa-angle-double-right"></i></a>
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

<!-- BEGIN JAVASCRIPTS(Load javascripts at bottom, this will reduce page load time) -->
<!-- BEGIN CORE PLUGINS -->
<script src="{$_assets}plugins/jquery-1.11.0.min.js"
        type="text/javascript"></script>
<script src="{$_assets}scripts/_page.js"></script>
<script>

    $('.send_message').click(function(){
        var obj=[];
        var phone_arr=$('table tr').find('.phone');
        var handle_type="{$_REQUEST['handle_type']}";
        for(var i = 0; i<phone_arr.length;i++){
            obj.push({
                phone:$('table tr').find('.phone').eq(i).text(),
                account_id:$('table tr').find('.phone').eq(i).attr("data-id"),
                vendor_id:$('table tr').find('.phone').eq(i).attr("data-vid"),
                username:$('table tr').find('.phone').eq(i).attr("data-username")
            });
        }
        if(obj){
            $.post('?action=send_msg',{ data_arr:obj },function(data){
                if(data.status != 0){
                    window.location.href="http://{Core::$urls['host']}{Core::$urls['path']}?handle_type="+handle_type;
                }
            });
        }
    });
    $('.pull_down').click(function(){
        var vendor_id=$(this).attr("data-vid");
        var handle_type="{$_REQUEST['handle_type']}";
        var modulo_value="{$_REQUEST['modulo_value']}";
        $.post('?',{ action:"pull_down",vendor_id:vendor_id },function(data){
            if(data.status!=0){
                window.location.href="http://{Core::$urls['host']}{Core::$urls['path']}?handle_type="+handle_type+"&modulo_value="+modulo_value;
            }
        })
    });
    $('.no_expect').click(function(){
        var vendor_id=$(this).attr("data-vid");
        var handle_type="{$_REQUEST['handle_type']}";
        $.post('?',{ action:"no_expect",vendor_id:vendor_id },function(data){
            if(data.status!=0){
                window.location.href="http://{Core::$urls['host']}{Core::$urls['path']}?handle_type="+handle_type;
            }
        })
    });
    $('.get_data').click(function(){
        $.post('?action=get_data',function(data){
            top.alert(data.msg);
            window.location.reload();
        });
    });
    $('.send_msg_again').click(function(){
        $.post('?',{ vendor_id:$(this).attr("data-vid"),action:"send_msg_again" },function(data){
            if(data.status){
                window.location.reload();
            }else{
                alert(data.msg);
            }
        });
    })

</script>
</body>

<!-- END BODY -->
</html>