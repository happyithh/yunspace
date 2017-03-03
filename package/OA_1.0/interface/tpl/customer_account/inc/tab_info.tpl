<div class="portlet tabbable">
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
                    {*{if empty($accountInfo['attr']['identity'])}*}
                        <td>
                            {if $accountInfo['identity_time']>0}
                                {if !empty($accountInfo['attr']['identity']['data']['公司名称'])}
                                    企业账号&nbsp;&nbsp;<span class="btn btn-success btn-xs">已认证</span>&nbsp;&nbsp;<a href="?action=detail&tab=info&id={$accountInfo['id']}&identity_type=2" class="btn btn-primary btn-xs">修改企业认证信息</a>
                                {else}
                                    个人账号&nbsp;&nbsp;<span class="btn btn-success btn-xs">已认证</span>&nbsp;&nbsp;<a href="?action=detail&tab=info&id={$accountInfo['id']}&identity_type=1" class="btn btn-primary btn-xs">修改个人认证信息</a>
                                {/if}
                            {elseif $accountInfo['identity_time']<-1}
                                <span class="btn btn-warning btn-xs">待认证</span>&nbsp;&nbsp;
                                <a class="btn btn-primary btn-xs" href="?action=detail&tab=info&id={$accountInfo['id']}&identity_type={$accountInfo['attr']['new_identity']['identity_type']}">查看认证信息</a>
                            {elseif $accountInfo['identity_time']==-1}
                                <span class="btn btn-danger btn-xs">未通过</span>&nbsp;&nbsp;<span>&nbsp;&nbsp;拒绝原因：{$accountInfo['attr']['new_identity']['rejectReason']}</span>
                                &nbsp;&nbsp;<a class="btn btn-primary btn-xs" href="?action=detail&tab=info&id={$accountInfo['id']}&identity_type={$accountInfo['attr']['new_identity']['identity_type']}">修改认证信息</a>
                            {else}
                                <span class="btn btn-default btn-xs">未认证</span>&nbsp;&nbsp;
                                <a href="?action=detail&tab=info&id={$accountInfo['id']}&identity_type=2" class="btn btn-primary btn-xs">添加企业认证信息</a>&nbsp;&nbsp;
                                <a href="?action=detail&tab=info&id={$accountInfo['id']}&identity_type=1" class="btn btn-primary btn-xs">添加个人认证信息</a>
                            {/if}

                        </td>
                    {*{else}*}
                        <td>

                        </td>
                    {*{/if}*}
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
</div>