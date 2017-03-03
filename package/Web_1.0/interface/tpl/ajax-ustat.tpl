{if $__user}
    <ul class="fr lar clearfix" id="user_stat" data-username="{$__user['username']}" data-fullname="{$__user['fullname']}" data-phone="{$__user['phone']}">
        <li><a href="{$_root}user_center/">{$__user['username']}</a>|
        </li>
        <li>
            <a href="{$_root}user_center/user_admin/message">消息({$message_num})
                <i class="fa fa-caret-down"></i></a>
        </li>
        <ul class="log_li" id="log_li">
            <li>
                <a href="{$_root}user_center/user_admin/order">采购管理</a>
            </li>
            {if $__user['vendor_id'] && Web_Account::subAccountHasAuth('产品管理', 21)}
            <li>
                <a href="{$_root}vendor_center/vendor_admin/order">商户管理</a>
            </li>
            {/if}
            {if !$__user['sub_account']}
            <li>
                <a href="{$_root}user_center/user_admin/account">账户管理</a>
            </li>
            {/if}
            <li>
                <a href="{$_root}user_center/user_admin/message">消息</a>
            </li>
            <li>
                <a href="{$_root}user_center/user_admin/logout">退出</a>
            </li>
        </ul>
    </ul>
    <script>
        $('#user_stat').hover(function () {
            $('#log_li').slideDown('fast');
        }, function () {
            $('#log_li').hide();
        });
    </script>
{else}
    <ul class="fr lar clearfix">
        <li>
            <a href="{$_root}user_center/login">登录</a>|
        </li>
        <li><a href="{$_root}user_center/register">注册</a>
        </li>
    </ul>
{/if}