<!DOCTYPE html>
<html lang="en">
<head>
    {include "Web_Mobile_Static::site_management/inc.meta.tpl"}
    {static "v1.0/global.css"}
    {static "site_management/footer.css"}
    {static "site_management/sweetalert.css"}
    {static "site_management/site_m.css"}

</head>
<body>
{*头部*}
<header class="site_header">
    <div class="clear_float">
        <div class="header_left">
            <a href="javascript:history.go(-1);"> <span class="icon-angle-left"></span></a>
        </div>
        <div class="header_middle">
            场地管理
        </div>
    </div>
</header>




{*1基本信息--设置商圈*}
{*<div class="site_add_tag_outside1">*}
    {*<div class="site_add_tag_word1">最多可设置3个商圈</div>*}
    {*<ul class="site_tag_list">*}
        {*{foreach $data['attr'][2] as $k=>$v}*}
        {*<li><span>{$v}</span><div>&#8730;</div></li>*}
        {*{/foreach}*}
        {*<li>美术馆<div>&#8730;</div></li>*}
        {*<li>老西门<div>&#8730;</div></li>*}
        {*<li>文体娱乐文体娱乐文体<div>&#8730;</div></li>*}
        {*<li>文体娱乐<div>&#8730;</div></li>*}
    {*</ul>*}
    {*<div class="clear"></div>*}
{*</div>*}
{*<button class="site_confirm_btn">保存</button>*}

{*<div class="site_pop">*}
    {*<div class="site_pop_title1">最多只能选择3个标签</div>*}
    {*<a class="site_pag_confirm1">确定</a>*}
{*</div>*}
{*<div class="site_mark"></div>*}




{*1基本信息--添加标签页*}
<div class="site_add_tag_outside" id="special_tag">
    <div {if !empty($data['data_backup']['attr'][2])}class="site_add_tag_word1"{else}class="site_add_tag_word"{/if} id="site_add_tag_word">快为你的场地添加商圈吧。</div>
    <ul>
        {if !empty($data['data_backup']['attr'][2])}
        {foreach $data['data_backup']['attr'][2] as $k=>$v}
            <li><span>{$v}</span><div>&#8730;</div></li>
        {/foreach}
        {/if}
        {*<li>文体娱乐<div>&#8730;</div></li>*}
        {*<li>文体娱乐<div>&#8730;</div></li>*}
        <button class="site_add_tag_btn" id="site_add_tag_btn">
            <span class="icon-plus">&nbsp;&nbsp;</span>添加
        </button>
    </ul>
    {*<button class="site_add_tag_btn" id="site_add_tag_btn">*}
        {*<span class="icon-plus">&nbsp;&nbsp;</span>添加*}
    {*</button>*}
    <div class="clear"></div>
</div>

{*添加标签弹出对话框*}
<div class="site_pop" id="tag_input_pop">
    <div class="site_pop_title">请填写商圈名称，最长4个汉字</div>
    <div class="site_pop_input_outside">
        <input class="site_pop_input">
        <div class="site_pop_cue">
            <span class="icon-remove"></span>
            请输入商圈名称
        </div>
        <div class="site_pop_cue1">
            <span class="icon-remove"></span>
            商圈名称不能超过4个汉字
        </div>
    </div>

    <input name="data[space_pedia_id]" value="{$space_pedia_id}" type="hidden">
    <input name="data[attr_new]" value='{$data_attr}' type="hidden">
    <input name="is_submit" value="1" type="hidden">

    <a class="site_pag_cancel" id="tag_input_cancel">取消</a>
    <a class="site_pag_confirm business_submit" id="tag_input_confirm">确定</a>
    <div class="clear"></div>
</div>

{*确认删除弹出对话框*}

<div class="site_pop" id="tag_delete_pop">
    <div class="site_pop_title1">已选<span></span>个商圈，确认删除</div>
    <a class="site_pag_cancel" id="tag_delete_cancel">取消</a>
    <a class="site_pag_confirm business_remove" id="tag_delete_confirm">确定</a>
</div>

{*删除按钮*}
<button class="site_tag_remove_btn">
    删除（<span></span>）
</button>


<div class="site_mark"></div>





{static "v1.0/jquery-1.11.1.min.js"}
{static "site_management/site_m.js"}
{static "core/yunspace.js"}

</body>
</html>