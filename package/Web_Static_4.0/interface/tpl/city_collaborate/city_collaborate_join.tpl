<!DOCTYPE html>
<html lang="en">
<head>
    {include file="Web_Static::v4.0/html_goto_mobile.tpl" url="m/article/{Func_NumEncode::e($page->id)}.html"}
    {include file="Web_Static::inc/head_meta.tpl"}
    {static "articles/article.css"}
    {static "v4.0/pop-list.css"}
    {static "v4.0/recommend.css"}
    {static "baike.v1.0/news.css"}
    {static "city_collaborate_pc/city_collaborate.css"}
</head>
<body yun="city_collabrate/city_join.js::joinSubmit">
{include file="Web_Static::inc/header_1.tpl"}
<div class="wrapper">
    <div class="crumb">
        <a href="{$_home}">首页</a>{if $page->baikeInfo['space_name']}> <a href="{$_home}site/{Func_Url::str_urlencode($page->baikeInfo['space_name'])}">{$page->baikeInfo['space_name']}{/if}</a> &gt;<a href="colbrt">城市合伙人</a>&gt;<a href="" class="active">立即加入</a>
    </div>
</div>

<!--banner部分-->
<div class="colbrt-banner-bg colbrt-banner-join-bg">
    <div class="btn-wrapper">
        <div class="opacity-bg"></div>
        <a class="btn-text" href="">立即报名</a>
    </div>
</div>

<!--基本信息表单部分-->
<div class="form-join-wrapper">
    <h3>请留下您的基本信息，我们会尽快与您联系</h3>
    <div >
        <input type="hidden" name="id" id="id" value="14">
        <table class="form-join-table">
            <tr>
                <td width="27%"><span class="red">*</span>城&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;市</td>
                <td><input id="city" name="data[城市]" type="text" placeholder="请输入您所在的省和城市，如贵州省安顺市"></td>
            </tr>
            <tr>
                <td><span class="red">*</span>公司名称</td>
                <td><input id="company" name="data[公司名称]" type="text" placeholder="请输入您的公司名称"></td>
            </tr>
            <tr>
                <td><span class="red">*</span>联&nbsp;系&nbsp;&nbsp;人</td>
                <td><input id="username" name="data[称呼]" type="text" placeholder="请输入您的称呼"></td>
            </tr>
            <tr>
                <td><span class="red">*</span>联系电话</td>
                <td><input id="tel" name="data[联系电话]" type="text" placeholder="请输入联系电话"></td>
            </tr>
            <tr>
                <td><span class="red"></span>公司地址</td>
                <td><input id="address" name="data[地址]" type="text" placeholder="请输入详细地址，如县区、街道、门牌号等"></td>
            </tr>
            <tr>
                <td></td>
                <td><button class="form-join-btn">确定</button></td>
            </tr>
        </table>
    </div>
</div>

<!--弹窗-->
<div class="pop-status hide">
    <a href="javascript:;" class="icon-close js-close"></a>
    <div class="pop-status-success hide">
        <h1><i class="icon-state icon-state-success"></i><span>您的申请已经成功提交！</span></h1>
        <p>我们会尽快审核信息并与您联系，请耐心等待</p>
    </div>
    <div class="pop-status-error hide">
        <h1><i class="icon-state icon-state-error"></i><span>申请失败！</span></h1>
        <p>必要字段没有填写</p>
    </div>
</div>
<div class="pop-bg hide"></div>

{include file="Web_Static::inc/public_space.tpl"}
{include file="Web_Static::inc/html_footer.tpl"}
{static "core/yunspace.js"}
</body>
</html>