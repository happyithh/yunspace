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
                {if $vendor_status['status']==1 || $vendor_status['status']==4}
                    <a href="{$_route}set_edit" class="btn btn-default add">
                        <i class="fa fa-plus-square" style="margin-right: 5px;"></i>新增
                    </a>
                {else}
                    <a href="javascript:void (0)" class="btn btn-default add" onclick="alert('您的供应商信息还未通过审核~还不能新增产品')">
                        <i class="fa fa-plus-square" style="margin-right: 5px;"></i>新增
                    </a>
                {/if}
            </div>
        </div>
    </div>
    <div class="clear"></div>
    <div class="table-responsive" style="border: 0px;">
        <table class="table table-striped table-bordered table-advance table-hover table-service">
            <thead>
            <tr>
                <th>#ID</th>
                <th>套餐名称</th>
                <th>套餐类型</th>
                <th>当前状态</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody>
            {foreach $data['rows'] as $sk=>$sv}
                <tr data-sid="{$sv['id']}">
                    <td>{$sv['id']}</td>
                    <td>
                        {*{if $sv['update_status']==2}*}
                        {*{$sv['set_name']}*}
                        {*<span class="label label-warning">审核中</span>*}
                        {*{elseif $sv['status']==1}*}
                        <a href="{$_root}set_info/{md5($sv['id'])}/{$sv['id']}.html"
                           target="_blank">{$sv['set_name']}</a>
                        {*{else}*}
                        {*{$sv['set_name']}*}
                        {*{/if}*}
                    </td>
                    <td>{$category_name[$sv['category_id']]}</td>
                    <td style="position: relative!important;">
                        {if $sv['update_status']==3}
                            <span class="label label-danger"
                                  style="background: #fff;color:#f3565d;border:1px solid #f3565d">审核拒绝</span>
                        {elseif $sv['update_status']==2}
                            <span class="label label-warning"
                                  style="background: #fff;color:#ecbc29;border:1px solid #ecbc29">审核中</span>
                        {else}
                            <select class="form-control input-sm" onchange="ListOperator.setOnline(this)">
                                <option value="1" {if $sv['status']== '1'} selected {/if}>
                                    上线
                                </option>
                                <option value="0" {if $sv['status']== '0'} selected {/if}>
                                    下线
                                </option>
                            </select>
                        {/if}
                        {if $sv['update_status']== 3}
                            <div class="show-reason"></div>
                            {*<div  class="reason-text" style="display: inline">拒绝理由：</div>*}
                            <a class="btn btn-danger btn-xs alertreason" style="width:60px;margin-left: 30px"
                               onclick="ListOperator.alertReason(this)" reason="{$sv['refuse_reason']}"
                               style="margin-left: 0px;"><span class="look-reason">查看理由</span>
                            </a>
                        {/if}
                    </td>
                    <td>
                        {*{if $sv['update_status']==2}*}
                        {*<a href="{$_root}set_info/{md5($sv['id'])}/{$sv['id']}.html"*}
                        {*class="btn btn-xs btn-success" target="_blank">预览</a>*}
                        {*{else}*}
                        {*<a href="{$_root}set_info/{$sv['id']}.html" target="_blank" class="btn btn-xs btn-success">预览</a>*}
                        {*{/if}*}
                        {*{if $sv['status']==1}*}
                        {*{if $sv['update_time']>$time_4hour}*}
                        {*<button class="btn btn-xs btn-success disabled">*}
                        {*已刷新*}
                        {*</button>*}
                        {*{else}*}
                        {*<button class="btn btn-xs btn-success" onclick="ListOperator.refresh(this)">*}
                        {*刷新*}
                        {*</button>*}
                        {*{/if}*}
                        {*{/if}*}
                        <a href="{$_route}set_edit?set_id={$sv['id']}" class="btn btn-xs btn-primary">修改</a>
                        {if $sv['update_status'] == 1 || $sv['update_status'] == 2}
                            {*<a href="{$_route}set_edit/case?set_id={$sv['id']}" class="btn btn-xs btn-info">案例</a>*}
                            <a href="{$_route}product_edit/schedule?product_id={$sv['schedule_product_id']}&vendor_id={$sv['vendor_id']}&set_id={$sv['id']}"
                               class="btn btn-xs btn-info">档期</a>
                            {if $sv['update_status'] == 1}
                                <a href="javascript:;" data-status="-1" onclick="ListOperator.setEdit(this)"
                                   class="btn btn-xs btn-danger delset">删除</a>
                            {/if}
                        {/if}
                        <a href="{$_route}deliver?action=edit&set_id={$sv['id']}" class="btn btn-xs btn-primary">投稿</a>
                    </td>
                </tr>
            {/foreach}
            </tbody>
        </table>
    </div>
</div>