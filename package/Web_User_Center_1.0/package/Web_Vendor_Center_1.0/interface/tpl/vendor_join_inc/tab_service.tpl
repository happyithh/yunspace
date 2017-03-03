<div class="service_content">
    <div class="table_service_top container-fluid">
        <div class="row" style="padding: 10px 0;">
            <div class="col-sm-4" style="padding: 0;">
                <form action="?">
                    <div class="input-group">
                        <input type="text" class="form-control" placeholder="ID / 名称" name="search[title]"
                               value="{$_REQUEST['search']['title']}">
                                                <span class="input-group-btn">
                                                <button class="btn btn-info" type="submit">
                                                    <i class="fa fa-search"></i>
                                                </button>
                                                </span>
                    </div>
                    {foreach $_REQUEST as $k=>$v}
                        {if $k!=='search'}
                            <input type="hidden" name="{$k}" value="{$v}">
                        {/if}
                    {/foreach}
                </form>
            </div>
            <div class="pull-right">
                <a href="#" class="btn btn-default add" onclick="alert('您的供应商加盟申请还未通过，暂不能进行此操作哦！')">
                    <i class="fa fa-plus-square" style="margin-right: 5px;"></i>新增
                </a>
            </div>
        </div>
    </div>
    <div class="clear"></div>
    <div class="table-responsive" style="border: 0px;">
        <table class="table table-striped table-bordered table-advance table-hover table-service">
            <thead>
            <tr>
                <th>#ID</th>
                <th>服务名称</th>
                <th>服务类型</th>
                <th>当前状态</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody>
            {foreach $data['rows'] as $pk=>$pv}
                <tr data-pid="{$pv['id']}">
                    <td>{$pv['id']}</td>
                    <td>
                        {*{if $pv['update_status']==2}*}
                        {*{$pv['product_name']}*}
                        {*<span class="label label-warning" style="background: #fff;color:#ecbc29;border:1px solid #ecbc29">审核中</span>*}
                        {*{elseif $pv['status']==1}*}
                        <a href="{$_root}service_info/{md5($pv['id'])}/{$pv['id']}.html"
                           target="_blank">{$pv['product_name']}</a>
                        {*{else}*}
                        {*{$pv['product_name']}*}
                        {*{/if}*}
                    </td>
                    <td>{$pv['category_name']}</td>
                    <td style="position: relative!important;">

                        {if $pv['update_status']==3}
                            <span class="label label-danger"
                                  style="background: #fff;color:#f3565d;border:1px solid #f3565d">审核拒绝</span>
                        {elseif $pv['update_status']==2}
                            <span class="label label-warning"
                                  style="background: #fff;color:#ecbc29;border:1px solid #ecbc29">审核中</span>
                        {else}
                            <span class="label"
                                  style="background: #fff;color:#666;border:1px solid #000">下线</span>
                        {/if}


                        {if $pv['update_status']== 3}
                            <div class="show-reason"></div>
                            {*<div  class="reason-text" style="display: inline">拒绝理由：</div>*}
                            <a class="btn btn-danger btn-xs alertreason" style="width:60px;margin-left: 30px"
                               onclick="ListOperator.alertReason(this)" reason="{$pv['refuse_reason']}"
                               style="margin-left: 0px;"><span class="look-reason">查看理由</span>
                            </a>
                        {/if}
                    </td>
                    <td>
                        {*{if $pv['update_status']==2}*}
                        {*<a href="{$_root}service_info/{md5($pv['id'])}/{$pv['id']}.html"*}
                        {*class="btn btn-xs btn-success" target="_blank" >预览</a>*}
                        {*{else}*}
                        {*<a href="{$_root}service_info/{$pv['id']}.html" target="_blank" class="btn btn-xs btn-success">预览</a>*}
                        {*{/if}*}
                        {if $pv['status']==1}
                            {if $pv['update_time']>$time_4hour}
                                <button class="btn btn-xs btn-success disabled">
                                    已刷新
                                </button>
                            {else}
                                <button class="btn btn-xs btn-success" onclick="ListOperator.refresh(this)">
                                    刷新
                                </button>
                            {/if}
                        {/if}
                        <a href="{$_route}product_edit?product_id={$pv['id']}" class="btn btn-xs btn-primary">修改</a>
                        {if $pv['update_status']==1 || $pv['update_status']==2}
                            {*<a href="{$_route}product_edit/case?product_id={$pv['id']}"*}
                               {*class="btn btn-xs btn-info">案例</a>*}
                            <a href="javascript:;" onclick="alert('请等待审核通过后，您可以添加档期，能更快成单哦！')"
                               class="btn btn-xs btn-info">档期</a>
                        {/if}
                        <a href="{$_route}deliver?action=edit&product_id={$pv['id']}"
                           class="btn btn-xs btn-success">投稿</a>
                    </td>
                </tr>
            {/foreach}
            </tbody>
        </table>
    </div>
</div>