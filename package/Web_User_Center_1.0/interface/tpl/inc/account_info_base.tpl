<div class="portlet">
    <div class="portlet-body">
        <div class="table-responsive" style="border:0px;">
            <table class="table table-hover" style="border:0px;">
                <thead>
                <tr>
                    <td width="40%">
                        用户名:
                    </td>
                    <td>
                        {$__user['username']}
                    </td>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td>
                        用户头像：
                    </td>
                    <td>
                       <img src="{Data_Config_Site::avatar($__user['id'],180)}" style="width: 50px;"/>
                    </td>
                    <td>
                        <a href="{$_route}account?action=bind_headImg" class="btn btn-danger btn-sm pull-right">修改用户头像</a>
                    </td>
                </tr>
                <tr>
                    <td>
                        绑定手机：
                    </td>
                    <td>
                        {$__user['phone']|default:'未绑定'}

                    </td>
                    <td>
                        <a href="{$_route}account?action=bind_phone" class="btn btn-danger btn-sm pull-right">修改绑定手机</a>
                    </td>
                </tr>
                <tr>
                    <td>
                        绑定邮箱：
                    </td>
                    <td>
                        {$__user['email']|default:'未绑定'}
                    </td>
                    <td>
                        <a href="{$_route}account?action=bind_email" class="btn btn-danger btn-sm pull-right">修改绑定邮箱</a>
                    </td>
                </tr>
                <tr>
                    <td>
                        认领供应商：
                    </td>
                    <td>
                        {$__user['vendor_name']|default:'未认领供应商'}
                    </td>
                    <td>
                        {if $__user['vendor_id']}
                            {if $change['status'] == -1}
                                <a href="{$_route}account?action=change_vendor&vendor_id={$__user['vendor_id']}" class="btn btn-danger btn-sm pull-right">重新变更供应商</a>
                                <span class="btn btn-danger btn-xs">变更请求已拒绝</span>
                                <span>拒绝原因：{$change['demo']}</span>
                            {else}
                                <a href="{$_route}account?action=change_vendor&vendor_id={$__user['vendor_id']}" class="btn btn-danger btn-sm pull-right">变更供应商</a>
                                {if $change && $change['status']==0}
                                    <span class="btn btn-warning btn-xs">审核中</span>
                                {/if}
                            {/if}
                        {else}
                            <a href="{$_route}account?action=change_vendor" class="btn btn-danger btn-sm pull-right">认领供应商</a>
                        {/if}
                    </td>
                </tr>
                </tbody>
            </table>
        </div>
    </div>
</div>