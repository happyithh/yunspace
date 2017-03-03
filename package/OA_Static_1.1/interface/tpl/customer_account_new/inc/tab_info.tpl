<div class="portlet tabbable">
    {if !$vendorInfo['vendor_account_id']}
        <div class="portlet-title">
            <div class="caption">
                添加联系人信息
            </div>
        </div>
        <div class="portlet-body" style="padding:10px 10px">
            <div class="clearfix"></div>
            <div class="form-body">
                <div class="form-group change_account">
                    <label class="col-md-2 control-label">请输入手机号</label>

                    <div class="col-md-6">
                        <input type="text" class="form-control input-sm" placeholder="手机号码" name="phone">
                    </div>

                </div>
            </div>
            <div class="form-actions text-center">
                <button type="reset" class="btn btn-default">
                    重置
                </button>
                <button type="button" class="btn btn-success change_account_submit">
                    提交
                </button>
            </div>

        </div>
    {else}
        <div class="portlet-title">
            <div class="caption">
                基本信息
            </div>
        </div>
        <div class="portlet-body" style="padding:10px 10px">
            <div class="clearfix col-md-12" style="font-size: 12px">
                <div class="table-responsive" style="border:0px;">
                    <table class="table table-hover" style="border:0px;">
                        <thead>
                        <tr>
                            <td colspan="2">
                                <a class="btn  btn-info" data-toggle="modal" href="#account">更换联系人账户</a>
                                <a class="btn  btn-success" data-toggle="modal" href="#basic">修改联系人信息</a>
                                <a class="btn  btn-danger" data-toggle="modal" href="#unbind">解除绑定联系人</a>

                            </td>
                        </tr>
                        <tr>
                            <td>账户名称：</td>
                            <td>
                                {$accountInfo['username']}
                                {if !empty($accountInfo['attr']['identity'])}
                                    ({$accountInfo['fullname']})
                                {/if}
                            </td>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td width="100">
                                用户等级：
                            </td>
                            <td>
                                普通用户
                            </td>
                        </tr>
                        <tr>
                            <td>
                                身份认证：
                            </td>
                            <td>
                                {if $accountInfo['identity_time']>0}
                                    {if !empty($accountInfo['attr']['identity']['data']['公司名称'])}
                                        企业账号&nbsp;&nbsp;<span class="btn btn-success btn-xs">已认证</span>&nbsp;&nbsp;<a href="?action=detail&tab=info&vendor_id={$vendorInfo['id']}&identity_type=2" class="btn btn-primary btn-xs">修改企业认证信息</a>
                                    {else}
                                        个人账号&nbsp;&nbsp;<span class="btn btn-success btn-xs">已认证</span>&nbsp;&nbsp;<a href="?action=detail&tab=info&vendor_id={$vendorInfo['id']}&identity_type=1" class="btn btn-primary btn-xs">修改个人认证信息</a>
                                    {/if}
                                {elseif $accountInfo['identity_time']<-1}
                                    <span class="btn btn-warning btn-xs">待认证</span>&nbsp;&nbsp;
                                    <a class="btn btn-primary btn-xs" href="?action=detail&tab=info&vendor_id={$vendorInfo['id']}&identity_type={$accountInfo['attr']['new_identity']['identity_type']}">查看认证信息</a>
                                {elseif $accountInfo['identity_time']==-1}
                                    <span class="btn btn-danger btn-xs">未通过</span>&nbsp;&nbsp;<span>&nbsp;&nbsp;拒绝原因：{$accountInfo['attr']['new_identity']['rejectReason']}</span>
                                    &nbsp;&nbsp;<a class="btn btn-primary btn-xs" href="?action=detail&tab=info&vendor_id={$vendorInfo['id']}&identity_type={$accountInfo['attr']['new_identity']['identity_type']}">修改认证信息</a>
                                {else}
                                    <span class="btn btn-default btn-xs">未认证</span>&nbsp;&nbsp;
                                    <a href="?action=detail&tab=info&vendor_id={$vendorInfo['id']}&identity_type=2" class="btn btn-primary btn-xs">添加企业认证信息</a>&nbsp;&nbsp;
                                    <a href="?action=detail&tab=info&vendor_id={$vendorInfo['id']}&identity_type=1" class="btn btn-primary btn-xs">添加个人认证信息</a>
                                {/if}

                            </td>
                        </tr>
                        <tr>
                            <td>
                                安全等级：
                            </td>
                            {if !empty($accountInfo['email'])&&!empty($accountInfo['password2'])}
                                <td>
                                    高
                                </td>
                            {elseif !empty($accountInfo['password2'])}
                                <td>
                                    中
                                </td>
                            {else}
                                <td>
                                    低
                                </td>
                            {/if}
                        </tr>
                        <tr>
                            <td width="40%">
                                用户名:
                            </td>
                            <td>
                                {$accountInfo['username']}
                            </td>
                        </tr>
                        <tr>
                            <td>
                                绑定手机：
                            </td>
                            <td>
                                {$accountInfo['phone']|default:'未绑定'}

                            </td>
                        </tr>
                        <tr>
                            <td>
                                绑定邮箱：
                            </td>
                            <td>
                                {$accountInfo['email']|default:'未绑定'}
                            </td>
                        </tr>
                        {foreach $accountInfo['attr']['identity']['data'] as $k=>$v}
                            <tr>
                                <td>
                                    {$k}
                                </td>
                                <td>
                                    {$v}
                                </td>
                            </tr>
                        {/foreach}
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    {/if}
</div>


{*更换联系人弹出层*}
<div class="modal fade" id="account" tabindex="-1" role="basic" aria-hidden="true" style="display: none;">
    <div class="modal-dialog">
        <div class="modal-content">
            <form action="?" method="post">
                <input type="hidden" name="action" value="{$_REQUEST['action']}"/>
                <input type="hidden" name="tab" value="change_bind_account"/>
                <input type="hidden" name="id" value="{$accountInfo['id']}">
                <input type="hidden" name="vendor_id" value="{$vendorInfo['id']}">
                <div class="modal-body">
                    <table class="table" id="list_info">
                        <thead>
                        <th width="200px;">更改供应商绑定的联系人账户</th>
                        </thead>
                        <tr>
                            <td>
                                <label>原联系人账户</label>
                            </td>
                            <td>
                                <input type="text" class="form-control" name="username" value="{$accountInfo['username']}">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label>选择新账户</label>
                            </td>
                            <td>
                                <input type="hidden" id="select2_account" class="form-control" name="new_account_id">
                            </td>
                        </tr>
                    </table>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="submit" class="btn btn-info">提交</button>
                </div>
            </form>
        </div>
    </div>
</div>


{*修改联系人信息弹出层*}
<div class="modal fade" id="basic" tabindex="-1" role="basic" aria-hidden="true" style="display: none;">
    <div class="modal-dialog">
        <div class="modal-content">
            <form action="?" method="post">
                <input type="hidden" name="action" value="{$_REQUEST['action']}"/>
                <input type="hidden" name="tab" value="update_account_info"/>
                <input type="hidden" id="reset_account_id" name="id" value="{$accountInfo['id']}">
                <input type="hidden" name="vendor_id" value="{$vendorInfo['id']}">
                <div class="modal-body">
                    <table class="table" id="list_info">
                        <thead>
                        <th width="150px;">账户管理</th>
                        <th></th>
                        </thead>
                        <tr>
                            <td>
                                {*<label><input type="checkbox" name="account[username]" value="1"/>账户名称</label>*}
                                <label>账户名称</label>
                            </td>
                            <td>
                                <input type="text" class="col-md-12 form-control" name="username"
                                       value="{$accountInfo['username']}" placeholder="请输入账户名">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label>密码</label>
                            </td>
                            <td>
                                <input type="password" class="col-md-12 form-control" name="password"
                                       placeholder="不填写时，密码为原密码">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label>再次输入新密码</label>
                            </td>
                            <td>
                                <input type="password" class="col-md-12 form-control" name="passwordr"
                                       placeholder="再次输入新密码(密码不做更改时，无需填写此项)">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label>交易密码</label>
                            </td>
                            <td>
                                <input type="password" class="col-md-12 form-control" name="password2"
                                       placeholder="不填写时，交易密码为原交易密码">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label>再次输入交易密码</label>
                            </td>
                            <td>
                                <input type="password" class="col-md-12 form-control" name="password2r"
                                       placeholder="再次输入交易密码(交易密码不做更改时，无需填写此项)">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label>手机号</label>
                            </td>
                            <td>
                                <input type="text" class="col-md-12 form-control" name="phone"
                                       value="{$accountInfo['phone']}">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label>邮箱</label>
                            </td>
                            <td>
                                <input type="text" class="col-md-12 form-control" name="email"
                                       value="{$accountInfo['email']}">
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="submit" id="update_account_submit" class="btn btn-info">提交</button>
                </div>
            </form>
        </div>
    </div>
</div>



{*解除绑定弹出层*}
<div class="modal fade" id="unbind" tabindex="-1" role="basic" aria-hidden="true" style="display: none;">
    <div class="modal-dialog">
        <div class="modal-content">
            <form action="?" method="post">
                <input type="hidden" name="action" value="{$_REQUEST['action']}"/>
                <input type="hidden" name="tab" value="unbind_account"/>
                <input type="hidden" name="id" value="{$accountInfo['id']}">
                <input type="hidden" name="vendor_id" value="{$vendorInfo['id']}">
                <div class="modal-body">
                    确定要和供应商【{$vendorInfo['vendor_name']}】解除绑定吗？
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="submit" class="btn btn-info">确定</button>
                </div>
            </form>
        </div>
    </div>
</div>


<script>
    //联系人信息提交(供应商账户)
    $('.change_account_submit').click(function(){
        $.post("http://{Core::$urls['host']}/static/api/vendor/handle.jsonp", {
            phone: $('.change_account input[name=phone]').val(),
            vendor_id: "{$vendorInfo['id']}",
            action: "change_account"
        }, function (data) {
            console.log(data);
            if (data.status == 1) {
                top.alert(" "+data.msg);
                window.location.href="?action=detail&tab=info&vendor_id={{$vendorInfo['id']}}";
            } else {
                top.alert(data.msg);
            }
        }, 'json')
    });

    $("#select2_account").select2({
        placeholder: "选择已有账号",
        minimumInputLength: 1,
        ajax: { // instead of writing the function to execute the request we use Select2's convenient helper
            url: "http://{Core::$urls['host']}/static/api/account/auto/complete.jsonp",
            dataType: 'json',
            data: function (term, page) {
                return {
                    q: term, // search term
                    page_limit: 10
                };
            },
            results: function (data, page) { // parse the results into the format expected by Select2.
                // since we are using custom formatting functions we do not need to alter remote JSON data
                return {
                    results: data.data.items
                };
            }
        },
        initSelection: function (element, callback) {
            var id = $(element).val();
            if (id !== "") {
                $.ajax("http://{Core::$urls['host']}/static/api/account/auto/complete.jsonp", {
                    data: {
                        id: id
                    },
                    dataType: "json"
                }).done(function (data) {
                            console.log(data);
                            callback(data.data.items[0]);
                        });
            }
        },
        formatResult: formatRepo, // omitted for brevity, see the source of this page
        formatSelection: formatRepoSelection, // omitted for brevity, see the source of this page
        escapeMarkup: function (m) {
            return m;
        } // we do not want to escape markup since we are displaying html in results
    });

    function formatRepo(repo) {
        if (repo.loading) return repo.text;
        return repo.full_name;
    }

    function formatRepoSelection(repo) {
        return repo.full_name || repo.text;
    }
</script>