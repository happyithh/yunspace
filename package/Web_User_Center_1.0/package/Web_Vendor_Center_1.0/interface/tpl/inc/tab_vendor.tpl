<div class="service_content">
    <div class="table_service_top container-fluid">
        <div class="row" style="padding: 10px 0;">
            <div class="col-sm-4" style="padding: 0;">
                <form action="?">
                    <div class="input-group">
                        <input type="text" class="form-control" placeholder="ID / 名称" name="search[title]" value="{$_REQUEST['search']['title']}">
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
        </div>
    </div>
    <div class="clear"></div>
    <div class="table-responsive" style="border: 0px;">
        <table class="table table-striped table-bordered table-advance table-hover table-service">
            <thead>
            <tr>
                <th>#ID</th>
                <th>供应商名称</th>
                <th>主营业务</th>
                <th>公司规模</th>
                <th>活动标签</th>
                <th>行业标签</th>
                <th>服务区域</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody>
            {foreach $data['rows'] as $vk=>$vv}
                <tr>

                    <td>{$vv['id']}</td>
                    <td>
                        {$vv['vendor_name']}
                        {if $vv['status']==2}
                            <span class="label label-warning">审核中</span>
                        {elseif $vv['status']==3}
                            <span class="label label-danger">审核未通过</span>
                        {/if}
                    <td>{$vv['attr']['服务范围']}</td>
                    <td>{$vv['attr']['公司规模']}</td>
                    <td>{$vv['attr']['活动类型']}</td>
                    <td>{$vv['attr']['服务行业']}</td>
                    <td>{$vv['attr']['城市']}</td>
                    <td>
                        <a href="{$_route}vendor_edit?vendor_id={$vv['id']}" class="btn btn-xs btn-info">修改</a>
                        <a href="{$_route}product_edit?vendor_id={$vv['id']}" class="btn btn-xs btn-primary">添加空间/服务</a>
                    </td>
                </tr>
            {/foreach}
            </tbody>
        </table>
    </div>
</div>