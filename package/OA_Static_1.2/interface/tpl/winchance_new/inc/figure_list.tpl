<div class="table-responsive">
    <table class="table table-striped table-bordered">
        <thead>
        <tr>
            <th class="id" width="25%">IP形象</th>
            <th width="25%">所属品牌公司</th>
            <th width="30%">备注</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody>
        {foreach $_data['rows'] as $k=>$v}
            <tr>
                <td>{$v['name']}</td>
                <td>{$v['company']}</td>
                <td>{$v['note']}</td>
                <td>
                    <a class="btn btn-info btn-xs figure_edit" data-figure-id="{$v['id']}" data-toggle="modal"
                       href="#modal-one" data-figure-note="{$v['note']}" data-company="{$v['company']}" data-figure="{$v['name']}" data-type="0">编辑</a>
                    <a href="javascript:;" data-id="{$v['id']}" data-name="{$v['name']}" class="btn btn-danger btn-xs figure_delete">删除</a>
                </td>
            </tr>
        {/foreach}
        </tbody>
    </table>
</div>