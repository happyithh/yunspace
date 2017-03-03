<!-- BEGIN SIDEBAR -->
<div class="page-sidebar-wrapper">
    <div class="page-sidebar navbar-collapse collapse">
        <ul class="page-sidebar-menu">
            <li class="hidden"></li>
            <li {if Core::$urls['action']=='vendor_edit'}class='active'{/if}>
                <a href="{$_route}vendor_edit?vendor_id={$__user['vendor_id']}" style="z-index: 5555">
                    <i class="icon-home"></i>供应商信息
                </a></li>
            <li>
                <a href="{$_home}{$___urls['route']}order">
                    <i class="icon-calendar"></i>交易管理
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
            <li>
                <a href="{$_home}{$___urls['route']}product/space" style="z-index: 5555">
                    <i class="icon-list"></i>服务管理
                </a></li>
            <ul class="page-sidebar-menu" style="margin-left: 35px;">
                <li {if Core::$urls['action']=='product/space'}class='active'{/if}>
                    <a href="{$_home}{$___urls['route']}product/space">
                        空间场地
                    </a>
                </li>
                <li {if Core::$urls['action']=='product/service'}class='active'{/if}>
                    <a href="{$_home}{$___urls['route']}product/service">
                        配套服务
                    </a>
                </li>

                <li {if Core::$urls['action']=='product/set'}class='active'{/if}>
                    <a href="{$_home}{$___urls['route']}product/set">
                        套餐
                    </a>
                </li>

                <li {if Core::$urls['action']=='deliver'}class='active'{/if}>
                    <a href="{$_home}{$___urls['route']}deliver">
                        我的投稿
                    </a>
                </li>

            </ul>
            <li class="tab_product_marketing">
                <a href="{$_home}{$___urls['route']}product_marketing">
                    <i class="icon-grid"></i>营销管理
                </a></li>
            <li><a href="{$_home}../user_center/">
                    <i class="icon-logout"></i>返回
                </a></li>
        </ul>
    </div>
</div>
<!-- END SIDEBAR -->
<script>
    jQuery(document).ready(function () {
        $('.tab_{$tab_index|default:$___urls['action']}').addClass('active');
    });
</script>