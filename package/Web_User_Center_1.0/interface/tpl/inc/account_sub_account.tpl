<link rel="stylesheet" type="text/css" href="plugins/select2/select2.css"/>
<link rel="stylesheet" type="text/css" href="plugins/jquery-multi-select/css/multi-select.css"/>
<script type="text/javascript" src="plugins/select2/select2.min.js"></script>
<form action="?" class="form-horizontal" method="post" enctype="multipart/form-data">
    <input type="hidden" name="security_submit" value="1">
    <input type="hidden" name="url_back" value="{$_REQUEST['url_back']}">

    <div class="form-body">
        <h3 class="form-section">设置子账号</h3>
        <div class="table-responsive" style="border: 0px;">
        <table class="table table-bordered" id="form_pay">
            <thead>
            <tr class="active">
                <th width="20%">登录名</th>
                <th width="20%">子账号</th>
                <th width="10%">密码</th>
                <th width="20%">邮箱</th>
                <th width="15%">手机号</th>
                <th width="25%">权限</th>
                <th width="10%">操作</th>
            </tr>
            <tr class="hidden">
                <td>
                    <input class="form-control" style="border: 0" value="--@{$__user['username']}"/>
                </td>
                <td>
                    <input type="text" class="form-control js_plus2" name="data[$$][用户名]" autocomplete="off"/>
                </td>
                <td>
                    <input type='password' class="form-control" name="data[$$][密码]" autocomplete="off"/>
                </td>
                <td>
                    <input type="text" class="form-control" name="data[$$][email]" autocomplete="off"/>
                </td>
                <td>
                    <input type="text" class="form-control" name="data[$$][phone]" autocomplete="off"/>
                </td>
                <td>
                    <select class="form-control select2" name="data[$$][权限][]" multiple>
                        {foreach Web_Account::$subAccountAuthIndex[$__user['account_type']] as $k=>$v}
                            <option value="{$v}">{$k}</option>
                        {/foreach}
                    </select>
                </td>
                <td class="btns">
                    <button class="btn btn-danger" onclick="FormAttr.remove(this)">
                        <i class="fa fa-trash-o"></i> 删除
                    </button>
                </td>
            </tr>
            </thead>
            <tbody>
            </tbody>
            <tr>
                <td colspan="7">
                    <a style="width: 100%; text-align: center; display: block; cursor: pointer" onclick="FormAttr.add(this)">
                        <i class="fa fa-plus"></i>
                        添加
                    </a>
                </td>
            </tr>
        </table>
        </div>
        <script>
            FormAttr = {
                index: 0,
                add: function (o, values) {
                    var table = '';
                    if (o) {
                        table = $(o).parents('table');
                    } else {
                        table = $('#form_pay');
                    }
                    if (!FormAttr.index) {
                        FormAttr.index = table.find('tr').size() + 10;
                    }
                    FormAttr.index++;
                    var newTr = table.find('thead>tr.hidden').eq(0).clone().removeClass('hidden');
                    newTr.appendTo(table.find('tbody').eq(0));
                    newTr.find('input,select').each(function () {
                        if ($(this).attr('name')) {
                            $(this).attr('name', $(this).attr('name').replace('$$', FormAttr.index));
                        }
                    });
                    newTr.find('.js_plus2').change(function () {
                        $(this).parent().parent().find('input:eq(0)').val($(this).val() + '@' + '{$__user['username']}');
                    });
                    if (values) {
                        newTr.find('input:eq(4)').val(values[3]);
                        newTr.find('input:eq(3)').val(values[2]);
                        newTr.find('input:eq(1)').val(values[0]);
                        newTr.find('input:eq(2)').attr('placeholder','********');
                        newTr.find('select:eq(0)').val(values[1].split(','));
                        newTr.find('.js_plus2').trigger('change');
                    }
                    newTr.find('.select2').select2({
                        placeholder: "选择权限",
                        allowClear: true
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
                }
            };
            {foreach $sub_account as $k=>$v}
                FormAttr.add('', ['{$k}', '{implode(',',array_keys($v[1]))}','{$v[2]}','{$v[3]}']);
            {/foreach}
        </script>
    </div>
    <div class="form-actions">
        <div class="row">
            <div class="col-md-offset-6 col-md-9">
                <button type="submit" class="btn btn-info">
                    提交
                </button>
                <button type="reset" class="btn btn-default">
                    重置
                </button>
            </div>
        </div>
    </div>
</form>