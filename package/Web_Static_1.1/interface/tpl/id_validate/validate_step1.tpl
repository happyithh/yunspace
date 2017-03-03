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
            <a href="?type=personal" class="active fl">个人认证</a>
            <a href="?type=company" class="fr">企业认证</a>
        </div>
        {if $identity_status}
            <p class="refusereason" >{$identity_status}</p>
        {/if}
        <div class="validate-cont clearfix">
            <div class="drop-validate">
                <a href="{$url_back}" class="skip-atc gray">跳过认证>></a>
            </div>
            <form action="?" method="post" >
                <input type="hidden" name="type" value="personalsubmit" />
                <input type="hidden" name="action" value="{$_REQUEST['action']}" />
                <input type="hidden" name="identity_id" value="{$identity_info['id']}">
                <div class="usage-row">
                    <p>个人身份信息<span>&nbsp;*&nbsp;姓名和身份证明一旦提交后将不可修改</span></p>
                </div>
                <table class="compy-val-table" cellpadding="0" cellspacing="0" data-action="http://{Core::$urls['host']}/static/api/upload/controller.json?action=uploadimage&filename=">
                    <tr>
                        <td class="td-tit">姓名：</td>
                        <td class="td-cont"><input type="text" name="fullname" value="{$identity_info['fullname']}"></td>
                    </tr>
                    <tr>
                        <td class="td-tit">身份证号码：</td>
                        <td class="td-cont"><input type="text" name="id_card_number"  value="{$identity_info['id_card_number']}"></td>
                    </tr>
                    <tr>
                        <td class="td-tit">手持身份证件照片：</td>
                        <td class="td-cont">
                            <input type="hidden" class="photo_identity_card" name="hold_identity_card_img" value="{$identity_info['hold_identity_card_img']}">
                            <div class="paper-img">
                                <img src="{$identity_info['hold_identity_card_img']|default:'/package/Web_Static_1.1/interface/assets/img/id_validate/val_idimg.png'}">
                            </div>
                            <div class="choice">
                                <span>点击上传</span>
                                <input class="js-upload-file" type="file" name="photo_identity_card">
                                <p>*单个文件的大小不超过1M</p>
                            </div>
                            <span class="moveimgs js-remove-file">移除</span>
                        </td>
                    </tr>
                </table>
                {if $identity_info['status']<1}
                <div class="submit-button">
                    <input class="btn-submit" type="submit" value="提交">
                </div>
                {/if}
            </form>
        </div><!--validate-cont-end-->
    </div><!--container-end-->
</div>
{include file="Web_Static::id_validate/inc/validate_foot.tpl"}
</body>
</html>