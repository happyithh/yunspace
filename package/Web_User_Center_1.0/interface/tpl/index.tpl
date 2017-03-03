<!DOCTYPE html>
<!--[if IE 8]>
<html lang="en" class="ie8 no-js"> <![endif]-->
<!--[if IE 9]>
<html lang="en" class="ie9 no-js"> <![endif]-->
<!--[if !IE]><!-->
<html lang="en" class="no-js">
<!--<![endif]-->
<head>
    {if Core::$package['name']=='Web_Vendor_Center'}
        {include 'Web_User_Center::inc/html_head.tpl' theme='blue'}
    {else}
        {include 'Web_User_Center::inc/html_head.tpl'}
    {/if}
</head>

<body>
{include 'Web_User_Center::inc/chat_bar.tpl'}
{if Core::$package['name']=='Web_Vendor_Center'}
    {include 'Web_User_Center::inc/header_top.tpl' color='#0b679e'}
{else}
    {include 'Web_User_Center::inc/header_top.tpl'}
{/if}
<div class="clearfix"></div>
<div class="page-container">
    {if Core::$package['name']=='Web_Vendor_Center'}
        {include 'Web_Vendor_Center::inc/header_nav.tpl'}
    {else}
        {include 'inc/header_nav.tpl'}
    {/if}

    <div class="page-content-wrapper">
        <div class="page-content">
            <h3 class="page-title">
                我的云SPACE中心
            </h3>

            <div class="portlet">
                <div class="portlet-body">
                    <div class="profile">
                        <div class="row">

                            <div class="col-md-12">
                                <div class="alert alert-success">
                                    <strong>温馨提示!</strong>
                                    采购相关的功能已经合并到『采购管理』中，如需采购订单请点击<a href="{$_home}{$___urls['route']}order">这里前往</a>。
                                </div>
                                <table class="table table-bordered table-striped table-1">
                                    <tr>
                                        <th rowspan="5" class="individual">
                                            <a class="thumbnail" style="height: 180px; width: 180px;" href="account?action=bind_headImg#form">
                                                <img src="{Page_Site_Global::displayLogo($__user['avatar'],180,180)}">
                                            </a>
                                        </th>
                                        <th width="45%">{$__user['username']}
                                            ({$__user['fullname']}
                                            )
                                        </th>
                                        <th>订单量</th>
                                    </tr>
                                    <tr>
                                        <td>
                                            <div class="float_l">
                                                用户等级
                                            </div>
                                            <div class="float_r">
                                                <span>普通用户</span>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="float_l">
                                                待审核
                                            </div>
                                            <div class="float_r">
                                                <span>{$i}</span>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <div class="float_l">
                                                身份认证
                                            </div>
                                            {if empty($__user['attr']['identity'])}
                                                <div class="float_r">
                                                    <span>未认证</span>
                                                </div>
                                            {else}
                                                <div class="float_r">
                                                    {if !empty($__user['attr']['identity']['data']['公司名称'])}
                                                        <span>企业账号（已认证）</span>
                                                    {else}
                                                        <span>个人账号（已认证）</span>
                                                    {/if}
                                                </div>
                                            {/if}
                                        </td>
                                        <td>
                                            <div class="float_l">
                                                待签约
                                            </div>
                                            <div class="float_r">
                                                <span>{$j}</span>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <div class="float_l">
                                                安全等级
                                            </div>
                                            <div class="float_r">
                                                {if !empty($__user['email'])&&!empty($__user['password2'])}
                                                    <span> 高</span>
                                                {elseif !empty($__user['password2'])}
                                                    <span> 中</span>
                                                {else}
                                                    <span>低</span>
                                                {/if}
                                            </div>
                                        </td>
                                        <td>
                                            <div class="float_l">
                                                待支付
                                            </div>
                                            <div class="float_r">
                                                <span>{$k}</span>
                                            </div>
                                        </td>

                                    </tr>
                                    <tr>
                                        <td>
                                            <div class="float_l">
                                                余&nbsp;&nbsp;额
                                            </div>
                                            <div class="float_r">
                                                <b style="color:#f54545; font-size: 16px; ">{$balance}
                                                    元</div>
                                        </td>
                                        <td>
                                            <div class="float_l">
                                                待结算
                                            </div>
                                            <div class="float_r">
                                                <span>{$m}</span>
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>


                        <!--end col-md-8-->
                        <!--end col-md-4-->
                    </div>
                </div>
                <div class="portlet-body">
                    <h3 class="page-title">最新订单</h3>

                    <div class="table-responsive" style="border: 0px;">
                        <table class="table table-striped table-bordered table-advance table-hover">
                            <thead>
                            <tr>
                                <th>订单号</th>
                                <th>服务内容</th>
                                <th>实付款</th>
                                <th>下单时间</th>
                                <th>交易状态</th>
                                <th>交易操作</th>
                            </tr>
                            </thead>
                            <tbody>
                            {foreach $orders as $v}
                                <tr>
                                    <td>{$v['order_no']}</td>
                                    <td title="{$v['remark']}">
                                        {$v['order_title']}
                                        {if $v['start_time']}
                                            <br/>
                                            {date('Y-m-d', $v['start_time'])} ~ {date('Y-m-d', $v['end_time'])}
                                        {/if}
                                    </td>
                                    <td>
                                        {$v['order_price_pay']}
                                        元
                                        / {$v['order_price']}
                                        元
                                    </td>
                                    <td>{date('Y-m-d H:i',$v['create_time'])}</td>
                                    <td>
                                        {$v['order_status_text']}
                                    </td>
                                    <td>
                                        {if $v['product_set_id']}
                                            <a href="{$_root}product_set_order_info/{$v['order_no']}" target="_blank" class="btn btn-xs btn-info">
                                                查看
                                            </a>
                                        {else}
                                            <a href="{$_root}order_info/{$v['order_no']}" target="_blank" class="btn btn-xs btn-info">
                                                查看
                                            </a>
                                        {/if}
                                    </td>
                                </tr>
                            {/foreach}
                            </tbody>
                        </table>
                    </div>
                </div>
                <!-- BEGIN PAGE CONTENT-->
            </div>
            <!-- END PAGE CONTENT-->
        </div>
    </div>


</div>
</div>

{include 'inc/footer_inbox.tpl'}
{include 'inc/footer_script.tpl'}
{static "core/yunspace.js"}

</body>
</html>