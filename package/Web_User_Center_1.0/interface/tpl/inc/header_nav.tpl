<!-- BEGIN SIDEBAR -->
<div class="page-sidebar-wrapper">
    <div class="page-sidebar navbar-collapse collapse">
        <ul class="page-sidebar-menu" id="menuTab">
            <li class="hidden"></li>
            <li class="tab_">
                <a href="{$_home}{$___urls['route']}account">
                    <i class="icon-home"></i>我的云Space中心
                </a></li>
            {*<li class="tab_message">*}
            {*<a href="{$_home}{$___urls['route']}message">*}
            {*<i class="icon-volume-2"></i>云消息*}
            {*</a></li>*}
            {*<li class="tab_money">*}
            {*<a href="{$_home}{$___urls['route']}money">*}
            {*<i class="icon-credit-card"></i>我的钱包*}
            {*</a></li>*}

            <li class="tab_account">
                <a href="{$_home}{$___urls['route']}account">
                    <i class="icon-user-following"></i>账户管理
                </a>
            </li>
            <ul class="page-sidebar-menu" style="margin-left: 35px;">
                <li class="{if Core::$urls['action']=='money'}active{/if}">
                    <a href="{$_home}{$___urls['route']}money">
                        我的钱包
                    </a>
                </li>
                <li class="{if Core::$urls['action']=='account'}active{/if}">
                    <a href="{$_home}{$___urls['route']}account">
                        用户信息
                    </a>
                </li>
                <li class="{if Core::$urls['action']=='account_identity'}active{/if}">
                    <a href="{$_home}{$___urls['route']}account_identity">
                        实名认证
                    </a>
                </li>
                {if !$__user['sub_account']}
                    <li class="{if Core::$urls['action']=='account_sub_account'}active{/if}">
                        <a href="{$_home}{$___urls['route']}account_sub_account">
                            子账户管理
                        </a>
                    </li>
                {/if}
            </ul>

            <li class="tab_order">
                <a href="javascript:void(0)">
                    <i class="icon-calendar"></i>采购管理
                </a>
            </li>
            <ul class="page-sidebar-menu" style="margin-left: 35px;">
                <li {if isset($_REQUEST['status']) && $_REQUEST['status']==0}class='active'{/if}>
                    <a href="{$_home}{$___urls['route']}order?status=0">
                        全部订单
                    </a>
                </li>
                <li {if $_REQUEST['status']==1}class='active'{/if}>
                    <a href="{$_home}{$___urls['route']}order?status=1">
                        待审核订单
                    </a>
                </li>
                <li {if $_REQUEST['status']==2}class='active'{/if}>
                    <a href="{$_home}{$___urls['route']}order?status=2">
                        待签约订单
                    </a>
                </li>
                <li {if $_REQUEST['status']==3}class='active'{/if}>
                    <a href="{$_home}{$___urls['route']}order?status=3">
                        待支付订单
                    </a>
                </li>
                {*<li {if $_REQUEST['status']==4}class='active'{/if}>*}
                    {*<a href="{$_home}{$___urls['route']}order?status=4">*}
                        {*待评价订单*}
                    {*</a>*}
                {*</li>*}
                <li {if $_REQUEST['status']==5}class='active'{/if}>
                    <a href="{$_home}{$___urls['route']}order?status=5">
                        已完成订单
                    </a>
                </li>
                <li {if $_REQUEST['status']==-10}class='active'{/if}>
                    <a href="{$_home}{$___urls['route']}order?status=-10">
                        已取消订单
                    </a>
                </li>
                <li {if $_REQUEST['status']==-9}class='active'{/if}>
                    <a href="{$_home}{$___urls['route']}order?status=-9">
                        已关闭订单
                    </a>
                </li>
            </ul>
            {if $__user['vendor_id'] && Web_Account::subAccountHasAuth('产品管理', 21)}
                <li>
                    <a href="{$_root}vendor_center/vendor_admin/order">
                        <i class="icon-screen-desktop"></i>商户管理
                    </a>
                </li>
            {/if}
            <li><a href="{$_home}{$___urls['route']}logout">
                    <i class="icon-logout"></i>退出
                </a>
            </li>
        </ul>
    </div>
</div>
<!-- END SIDEBAR -->
<script>
    $("#menuTab li").click(function () {
//        $(this).next('ul').removeClass('hidden').toggle(300);

    });
    $(document).ready(function () {
        $('.tab_{$tab_index|default:$___urls['action']}').addClass('active');
    });
</script>