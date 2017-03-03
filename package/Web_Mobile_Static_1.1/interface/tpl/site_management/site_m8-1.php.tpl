<!DOCTYPE html>
<html lang="en">
<head>
    {include "Web_Mobile_Static::site_management/inc.meta.tpl"}
    {static "v1.0/global.css"}
    {static "site_management/footer.css"}
    {static "site_management/site_m.css"}
</head>
<body>
{*头部*}
<header class="site_header">
    <div class="clear_float">
        <div class="header_left">
            <a href="/m/test_site/site_list"> <span class="icon-angle-left"></span></a>
        </div>
        <div class="header_middle">
            场地管理
        </div>
    </div>
</header>
<div class="clear"></div>

{*tab切换*}
<div class="site_tab_outside mt50">
    <ul class="site_tab">
        <a href="/m/test_site/basic_info?space_pedia_id={$_REQUEST['space_pedia_id']}"> <li>基本信息</li></a>
        <a href="/m/test_site/space_std?space_pedia_id={$_REQUEST['space_pedia_id']}"><li>空间标准</li></a>
        <a href="/m/test_site/mating_service?space_pedia_id={$_REQUEST['space_pedia_id']}"><li>配套设施</li></a>
        <a href="/m/test_site/act_apply?space_pedia_id={$_REQUEST['space_pedia_id']}"><li>活动适用</li></a>
        <a href="/m/test_site/image_show?space_pedia_id={$_REQUEST['space_pedia_id']}">{if $data['status']==0}<li class="site_tab_active" style="padding-left: 15px;">图片管理<img style="width: 16px;height: 16px;float: right;" src="img/site_management/check.png" /></li>{elseif $data['status']==2}<li class="site_tab_active" style="padding-left: 15px;">图片管理<img style="width: 16px;height: 16px;float: right;" src="img/site_management/refuse.png" /></li>{else}<li class="site_tab_active">图片管理</li>{/if}</a>
        {*<a href="/m/test_site/space_item_list?space_pedia_id={$data['id']}"><li>子空间管理</li></a>*}
    </ul>
</div>


{*8图片管理*}
<div class="content_m mt10">
    {if $data['status']==0}<div class="site_tab_notice" style="border-bottom: 1px solid #e1e1e1;border-top:none;padding-top: 0px;"><span style="color: #0dac7d;font-size: 14px;">待审核：</span>您的修改已经提交，预计会在2个工作日完成审核，请耐心等待，谢谢配合。</div>{elseif $data['status']==2}<div class="site_tab_notice" style="border-bottom: 1px solid #e1e1e1;border-top:none;padding-top: 0px;"><span style="color: #e72418;font-size: 14px;">审核未通过：</span>{$data['refuse_reason']}</div>{/if}
    <form action=""  enctype="multipart/form-data">
    <div class="site_pic_b_t">场地封面图</div>
    <div class="site_pic_b" id="main-img">
        {if !empty($data['data_backup']['logo'])}
        <img src="{$data['data_backup']['logo']}">
        {else}
            <div class="change_no_logo">该场地暂无封面图片，请上传<br/>
            </div>
        {/if}
    </div>
        {if $can_edit}
            <div  class="change_pic" >
                <button type='button' id="change_pic">更改图片</button>
            </div>
            {else}
    {*<div  class="change_pic" >*}
        {*<button type='button' id="change_pic">更改图片</button>*}
    {*</div>*}
        {/if}

    <div class="change_pic_des">请上传尺寸为1920*520的图片，<br/>
        由于图片较大，建议在电脑端操作
    </div>

    <div class="site_pic_t">
        <a name="quxiao"></a>
        <div class="site_pic_word">场地图片</div>
        {if $can_edit}
        <a href="/m/test_site/image_edit?space_pedia_id={$_REQUEST['space_pedia_id']}" class="site_pic_btn">编辑</a>
        {else}{/if}
        <div class="clear"></div>
    </div>
    <div class="site_list_outside">
    {foreach $data['data_backup']['media'] as $k=>$v}
    <div class="site_list">
        <div class="site_pic">
            <div class="site_pic_s">
                <img src="{$v['path']}">
            </div>
            <div class="site_pic_c">
                <div class="site_pic_name">名称</div>
                <div class="site_pic_name_c0">{$v['name']}</div>
                <div class="clear"></div>
            </div>
            <div class="site_pic_c" style="margin-top: 10px;">
                <div class="site_pic_name">标签</div>
                <div class="site_pic_name_c">{$v['tags']}</div>
                <select class="site_pic_name_c1 none">
                    <option>露天广场</option>
                    <option>露天露天</option>
                </select>
                <div class="clear"></div>
            </div>
            <div class="clear"></div>
        </div>
    </div>
    {/foreach}
    </div>
        {if $can_edit}
    <div  class="site_add_pic">
        <button type="button" id="j-file-two" data-url="{$_root}order_info/upload">
            <span class="icon-plus"></span>添加更多图片
        </button>
    </div>
        {else}
        {/if}
        <!--<div class="start_upload">-->
            <!--开始上传-->
        <!--</div>-->

    </form>
</div>

<div id="img-clone" class="none">
    <div class="site_list">
        <div class="site_pic">
            <div class="site_pic_s">
                <img src="e405c77d4a97d24d724c0208f7b261bb.jpg">
            </div>
            <div class="site_pic_c">
                <div class="site_pic_name">名称</div>
                <div class="site_pic_name_c0"></div>
                <div class="clear"></div>
            </div>
            {*<div class="site_pic_c">*}
            {*<div class="site_pic_name">所属空间</div>*}
            {*<div class="site_pic_name_c">露天广场</div>*}
            {*<select class="site_pic_name_c1 none">*}
                {*<option>露天广场</option>*}
                {*<option>露天露天</option>*}
                {*</select>*}
            {*<div class="clear"></div>*}
            {*</div>*}
            <div class="clear"></div>
        </div>
        {*<a href="javascript:" class="son_modify">修改</a>*}
    </div>
</div>
<input type="hidden" id="space_pedia_id" value="{$_REQUEST['space_pedia_id']}">


{include "Web_Mobile_Static::site_management/inc.footer.tpl"}
{static "v1.0/jquery-1.11.1.min.js"}
{static "site_management/plupload.full.min.js"}
{static "core/yunspace.js"}
{static "site_management/site_m.js"}
</body>
</html>