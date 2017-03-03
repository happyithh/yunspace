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
            {*<div class="pull-right">*}
                {*<a href="{$_route}product_edit" class="btn btn-default add">*}
                    {*<i class="fa fa-plus-square" style="margin-right: 5px;"></i>新增*}
                {*</a>*}
            {*</div>*}
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
                    <td>{$pv['product_name']}</td>
                    <td>{$pv['category_name']}</td>
                    <td>已删除</td>
                    <td>
                        <a href="javascript:;" onclick="ListOperator.handle_product(this)" data-status="1" class="btn btn-xs btn-info">恢复</a>
                        <a href="javascript:;" onclick="ListOperator.handle_product(this)" data-status="-2" class="btn btn-xs btn-danger">彻底删除</a>
                    </td>
                </tr>
            {/foreach}
            </tbody>
        </table>
    </div>
</div>