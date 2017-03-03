<div class="table-responsive">
    <table class="table table-striped table-bordered">
        <thead>
        <tr>
            <th width="40%">公司/品牌</th>
            <th width="40%">备注</th>
            <th width="20%">操作</th>
        </tr>
        </thead>
        <tbody>
        {foreach $_data['rows'] as $k=>$v}
        <tr>
            <td>{$v['company']}</td>
            <td>{$v['note']}</td>
            <td>
                <a class="btn btn-info btn-xs company_edit" data-company-id="{$v['id']}" data-toggle="modal"
                   href="#modal-two" data-company-note="{$v['note']}" data-type="0" data-company="{$v['company']}">编辑</a>
                <a href="javascript:;" data-id="{$v['id']}"  data-name="{$v['company']}" class="btn btn-danger btn-xs company_delete">删除</a>
            </td>
        </tr>
        {/foreach}
        </tbody>
    </table>
</div>