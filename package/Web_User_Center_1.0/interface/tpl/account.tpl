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
    <link rel="stylesheet" href="css/money.css"/>
</head>
<body>
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
        <div class="page-content" style="min-height:973px">
            <h3 class="page-title">
                账户管理
            </h3>

            <div class="row">
                <div class="col-sm-3 col-md-3" style="height: 185px; width: 185px; margin-right:20px;">
                    <a class="thumbnail" style="height: 180px; width: 180px;" href="?action=bind_headImg">
                        <img src="{Data_Config_Site::avatar($__user['id'],180)}" width="180">
                    </a>
                </div>
                <div class="col-md-6">
                    <div class="portlet">
                        <div class="portlet-body">
                            <div class="table-responsive" style="border:0px;">
                                <table class="table table-hover" style="border:0px;">
                                    <thead>
                                    <tr>
                                        <td colspan="2">
                                            {$__user['username']}
                                            {if !empty($__user['attr']['identity'])}
                                                ({$__user['fullname']})
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
                                            {if $__user['account_type']==21}
                                                供应商
                                            {/if}

                                            {if $__user['account_type']==1}
                                                普通用户
                                            {/if}
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            身份认证：
                                        </td>
                                        {if empty($__user['attr']['identity'])}
                                            <td>
                                                未认证
                                            </td>
                                        {else}
                                            <td>
                                                {if !empty($__user['attr']['identity']['data']['公司名称'])}
                                                    企业账号（已认证）
                                                {else}
                                                    个人账号（已认证）
                                                {/if}
                                            </td>
                                        {/if}
                                    </tr>
                                    <tr>
                                        <td>
                                            安全等级：
                                        </td>
                                        {if !empty($__user['email'])&&!empty($__user['password2'])}
                                            <td>
                                                高
                                            </td>
                                        {elseif !empty($__user['password2'])}
                                            <td>
                                                中
                                            </td>
                                        {else}
                                            <td>
                                                低
                                            </td>
                                        {/if}
                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="portlet">
                <div class="portlet-body util-btn-margin-bottom-5">
                    <div class="portlet-body">
                        <ul class="nav nav-tabs">
                            <li{if $account_index==1} class="active"{/if}>
                                <a href="account">用户信息</a>
                            </li>
                            <li{if $account_index==2} class="active"{/if}>
                                <a href="account_security">安全中心</a>
                            </li>
                            <li{if $account_index==3} class="active"{/if}>
                                <a href="account_identity">身份认证</a>
                            </li>
                            <li{if $account_index==4} class="active"{/if}>
                                <a href="account_sub_account">子账号管理</a>
                            </li>

                        </ul>
                        <div class="tab-content">
                            {if $account_index==1}
                                <div class="tab-pane active">
                                    <div class="row">
                                        <div class="col-md-10">
                                            {if !$_REQUEST['action']}
                                                {include file="inc/account_info_base.tpl"}
                                                {include file="inc/account_info_identity.tpl"}
                                            {/if}
                                            {if $_REQUEST['action'] ==  'bind_email'}
                                                {include file="inc/account_bind_email.tpl"}
                                            {/if}
                                            {if $_REQUEST['action'] ==  'bind_phone'}
                                                {include file="inc/account_bind_phone.tpl"}
                                            {/if}
                                            {if $_REQUEST['action'] ==  'nextPhone'}
                                                {include file="inc/account_bind_phone2.tpl"}
                                            {/if}
                                            {if $_REQUEST['action'] ==  'bind_headImg'}
                                                {include file="inc/account_bind_headImg.tpl"}
                                            {/if}
                                            {if $_REQUEST['action'] ==  'change_vendor'}
                                                {include file="inc/account_change_vendor.tpl"}
                                            {/if}
                                        </div>
                                    </div>
                                </div>
                            {/if}
                            {*{q($__user)}*}
                            {if $account_index==2}
                                {include file="inc/account_security.tpl"}
                            {/if}
                            {if $account_index==3}
                                {if $__user['identity_time']==-1}
                                    <div class="alert-danger">
                                        <h4>认证信息未能通过审核</h4>

                                        <p>拒绝原因：{$__user['attr']['new_identity']['rejectReason']}</p>
                                    </div>
                                {/if}
                                {if !$__user['identity_time']&&!$_REQUEST['identity_type']}
                                    <a href="?identity_type=2" class="btn btn-primary btn-block">
                                        企业认证
                                    </a>
                                    <a href="?identity_type=1" class="btn btn-info btn-block">
                                        个人认证
                                    </a>
                                {elseif $_REQUEST['identity_type']==1}
                                    {include file="inc/account_identity_personal.tpl"}
                                {elseif $_REQUEST['identity_type']==2}
                                    {include file="inc/account_identity_company.tpl"}
                                {/if}
                            {/if}
                            {if $account_index==4}
                                {include file="inc/account_sub_account.tpl"}
                            {/if}

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
{include 'Web_User_Center::inc/footer_inbox.tpl'}
{include 'Web_User_Center::inc/footer_script.tpl'}
{include 'Web_User_Center::inc/html_form.tpl'}

</body>
</html>