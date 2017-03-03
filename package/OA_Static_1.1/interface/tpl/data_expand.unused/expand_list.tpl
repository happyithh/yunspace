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
                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">账户名称</label>

                            <div class="col-md-9">
                                <input type="text" class="form-control input-sm" placeholder="账户名称" name="username" value="{$_REQUEST['username']}">
                            </div>
                        </div>
                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">手机号</label>

                            <div class="col-md-9">
                                <input type="text" class="form-control input-sm" placeholder="手机号" name="phone" value="{$_REQUEST['phone']}">
                            </div>
                        </div>
                        {if $type==0}
                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">管理员</label>

                            <div class="col-md-9">
                                <select class="form-control input-sm"  name="admin_id">
                                    <option value="">全部</option>
                                    {foreach $admin as $k=>$v}
                                        <option {if $_REQUEST['admin_id']==$v['id']}selected {/if} value="{$v['id']}">{$v['username']}</option>
                                    {/foreach}
                                </select>
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
            {if $type}
                我的拓展列表
            {else}
                拓展列表
            {/if}
        </div>
    </div>
    <div class="portlet-tabs">
        <ul class="nav nav-tabs">
            <li class="{if $_REQUEST['handle_type']=='no_activate'}active{/if}">
                <a href="?handle_type=no_activate">待激活</a>
            </li>
            <li class="{if $_REQUEST['handle_type']=='activate'}active{/if}">
                <a href="?handle_type=activate">已激活</a>
            </li>
            <li class="{if $_REQUEST['handle_type']=='not_send_msg'}active{/if}">
                <a href="?handle_type=not_send_msg">未发送短信</a>
            </li>
            <li class="{if $_REQUEST['handle_type']=='all'}active{/if}">
                <a href="?handle_type=all">全部</a>
            </li>
        </ul>
    </div>
    <div class="portlet-body">
        {if $is_admin && $_REQUEST['handle_type']=="not_send_msg" && $_data['rows']}
            <a href="javascript:;" class="btn btn-success send_message">发送短信</a>
        {/if}
        <div class="tab-content clearfix">
            <div class="table-responsive">
                <table class="table table-striped table-bordered table-advance table-hover">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>供应商名称</th>
                    <th>账户名称</th>
                    <th>联系方式</th>
                    <th>邮箱</th>
                    <th>城市</th>
                    {if $type==0}
                        <th>拓展人</th>
                    {/if}
                    <th>拓展时间</th>
                    {if $_REQUEST['handle_type']=="all"}
                        <th>拓展状态</th>
                    {/if}
                    {*{if $_REQUEST['handle_type']=="no_activate" || $_REQUEST['handle_type']=="not_send_msg"}*}
                        <th>操作</th>
                    {*{/if}*}
                </tr>
                </thead>
                <tbody>
                {foreach $_data['rows'] as $k=>$v}
                    <tr>
                        <td>{$v['id']}</td>
                        <td>{$v['vendor_name']}</td>
                        <td>{$v['username']}</td>
                        <td class="phone" data-id="{$v['account_id']}" date-email="{{$v['email']}}" data-vid="{$v['vendor_id']}" data-username="{$v['username']}">{$v['phone']}</td>
                        <td>{$v['email']}</td>
                        <td>{$v['city']}</td>
                        {if $type==0}
                            <td>{$v['admin_name']}</td>
                        {/if}
                        <td>{date("Y-m-d H:i:s",$v['create_time'])}</td>
                        {if $_REQUEST['handle_type']=="all"}
                            <td>
                                {if $v['status']==null}
                                    未发送短信
                                {elseif $v['status']==0}
                                    待激活{if $v['msg_time'] < time()-(1*24*3600)}(过期){/if}
                                    {*待激活{if $v['msg_time'] < time()-(3*60)}(过期){/if}*}
                                    {*<a class="btn btn-xs btn-primary" href="{$_route}data_list?action=add_expand&vendor_id={$v['vendor_id']}">修改拓展信息</a>*}
                                {elseif $v['status']==1}
                                    已激活
                                {/if}
                            </td>
                        {/if}
                        {*{if $_REQUEST['handle_type']=="no_activate" || $_REQUEST['handle_type']=="not_send_msg"}*}
                            <td>
                                {if $_REQUEST['handle_type']=="not_send_msg"}
                                    <a class="btn btn-xs btn-danger abandon_vendor"  data-vid="{$v['id']}" href="javascript:;">丢弃</a>
                                {else}
                                    <a class="btn btn-xs btn-danger no_expect"  data-vid="{$v['id']}" href="javascript:;">无意向</a>
                                {/if}
                                <a class="btn btn-xs btn-primary" href="{$_route}data_list?action=add_expand&vendor_id={$v['id']}">修改拓展信息</a>
                                {if $_REQUEST['handle_type']=="no_activate" && $v['msg_time'] < time()-(1*24*3600)}(过期){/if}
                                {*{if $v['msg_time'] < time()-(3*60)}(过期){/if}*}
                            </td>
                        {*{/if}*}
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
    //无意向
    $('.no_expect').click(function(){
        var vendor_id=$(this).attr("data-vid");
        var handle_type="{$_REQUEST['handle_type']}";
        $.post('data_list',{ action:"no_expect",vendor_id:vendor_id },function(data){
            if(data.status!=0){
                window.location.href="http://{Core::$urls['host']}{Core::$urls['path']}?handle_type="+handle_type;
            }
        })
    });

    //丢弃
    $('.abandon_vendor').click(function(){
        if(!confirm("确定要丢弃该供应商吗？")){
            return false;
        }
        $.post('data_list',{
            action:'abandon_vendor',
            vendor_id:$(this).attr("data-vid")
        },function(data){
            if(data.status==1){
                top.alert(' '+data.msg);
                window.location.href="?handle_type={$_REQUEST['handle_type']}";
            }else{
                top.alert(data.msg);
            }
        },'json')
    });

    $('.send_message').click(function(){
        var obj=[];
        var phone_arr=$('table tr').find('.phone');
        var handle_type="{$_REQUEST['handle_type']}";
        for(var i = 0; i<phone_arr.length;i++){
            obj.push({
                phone:$('table tr').find('.phone').eq(i).text(),
                account_id:$('table tr').find('.phone').eq(i).attr("data-id"),
                vendor_id:$('table tr').find('.phone').eq(i).attr("data-vid"),
                username:$('table tr').find('.phone').eq(i).attr("data-username"),
                email:$('table tr').find('.phone').eq(i).attr("data-email")
            });
        }
        if(obj){
            $.post('send_msg?action=send_msg',{ data_arr:obj },function(data){
                if(data.status != 0){
                    window.location.href="http://{Core::$urls['host']}{Core::$urls['path']}?handle_type="+handle_type;
                }
            });
        }
    });
</script>
</body>

<!-- END BODY -->
</html>