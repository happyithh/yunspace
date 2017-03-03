<!DOCTYPE html>
<html>
<head>
    {include file="Web_Static::v2.0/html_head.tpl"}
    {static "id_validate/validate.css"}
</head>
<body>
{include file="Web_Static::id_validate/inc/validate_head.tpl"}
<div class="wrapper">
    <div class="container">
        <div class="title-usage"><p>是否完成实名认证涉及到您在云Space平台上商品的签约能够顺利进行,请尽早填写信息</p></div>
        <div class="tab-menu">
            <a href="?type=personal" class="fl">个人认证</a>
            <a href="?type=company" class="active fr">企业认证</a>
        </div>
        {if $identity_status}
            <p class="refusereason">{$identity_status}</p>
        {/if}
        <form action="?type=companysubmit" method="post">
            {*<input type="hidden" name="type" value="companysubmit" />*}
            {*<input type="hidden" name="action" value="{$_REQUEST['action']}" />*}
            <input type="hidden" name="identity_id" value="{$identity_info['id']}">

            <div class="validate-cont clearfix">
                <div class="drop-validate">
                    <a href="{$url_back}" class="skip-atc gray">跳过认证>></a>
                </div>
                <div class="usage-row">
                    <p>企业证件信息</p>
                </div>
                <table class="compy-val-table" cellpadding="0" cellspacing="0" data-action="http://{Core::$urls['host']}/static/api/upload/controller.json?action=uploadimage&filename=">
                    <tr>
                        <td class="td-tit">企业名称：</td>
                        <td class="td-cont"><input type="text" name="company_name"
                                                   value="{$identity_info['company_name']}"></td>
                    </tr>
                    <tr>
                        <td class="td-tit">营业执照注册号：</td>
                        <td class="td-cont"><input type="text" name="company_license_number"
                                                   value="{$identity_info['company_license_number']}"></td>
                    </tr>
                    <tr>
                        <td class="td-tit">营业执照副本：</td>
                        <td class="td-cont">
                            <input type="hidden" class="business_licence" name="business_licence_img"
                                   value="{$identity_info['business_licence_img']}">

                            <div class="paper-img">
                                <img src="{$identity_info['business_licence_img']|default:'/package/Web_Static_1.1/interface/assets/img/id_validate/val_idimg.png'}">
                            </div>
                            <div class="choice">
                                <span>点击上传</span>
                                <input class="js-upload-file" type="file" name="business_licence">

                                <p>*单个文件的大小不超过1M</p>
                            </div>
                            <span class="moveimgs js-remove-file">移除</span>
                        </td>
                    </tr>
                    <tr>
                        <td class="td-tit">组织机构代码：</td>
                        <td class="td-cont"><input type="text" name="organization_code"
                                                   value="{$identity_info['organization_code']}"></td>
                    </tr>
                    <tr>
                        <td class="td-tit">组织机构代码证：</td>
                        <td class="td-cont">
                            <input type="hidden" class="organization_code_imga" name="organization_code_img"
                                   value="{$identity_info['organization_code_img']}">

                            <div class="paper-img">
                                <img src="{$identity_info['organization_code_img']|default:'/package/Web_Static_1.1/interface/assets/img/id_validate/val_idimg.png'}">
                            </div>
                            <div class="choice">
                                <span>点击上传</span>
                                <input class="js-upload-file" type="file" name="organization_code_imga">

                                <p>*单个文件的大小不超过1M</p>
                            </div>
                            <span class="moveimgs js-remove-file">移除</span>
                        </td>
                    </tr>
                    <tr>
                        <td class="td-tit">税务登记证：</td>
                        <td class="td-cont">
                            <input type="hidden" class="tax_registration" name="tax_registration_img"
                                   value="{$identity_info['tax_registration_img']}">

                            <div class="paper-img">
                                <img src="{$identity_info['tax_registration_img']|default:'/package/Web_Static_1.1/interface/assets/img/id_validate/val_idimg.png'}">
                            </div>
                            <div class="choice">
                                <span>点击上传</span>
                                <input class="js-upload-file" type="file" name="tax_registration">

                                <p>*单个文件的大小不超过1M</p>
                            </div>
                            <span class="moveimgs js-remove-file">移除</span>
                        </td>
                    </tr>
                </table>
                <div class="usage-row">
                    <p>法定代表人信息</p>
                </div>
                <table class="compy-val-table" cellpadding="0" cellspacing="0">
                    <tr>
                        <td class="td-tit">法定代表人姓名：</td>
                        <td class="td-cont"><input type="text" name="fullname" value="{$identity_info['fullname']}">
                        </td>
                    </tr>
                    <tr>
                        <td class="td-tit">法定代表人身份证：</td>
                        <td class="td-cont"><input type="text" name="id_card_number"
                                                   value="{$identity_info['id_card_number']}"></td>
                    </tr>
                </table>
                {if $identity_info['status']<1}
                <div class="submit-button">
                    <input class="btn-submit" type="submit" value="提交">
                </div>
                {/if}
            </div>
        </form>
    </div>
    <!--container-end-->
</div>
{include file="Web_Static::id_validate/inc/validate_foot.tpl"}
</body>
</html>