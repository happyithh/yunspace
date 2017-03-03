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
            <a href="/m/test_site/site_list"><span class="icon-angle-left"></span></a>
        </div>
        <div class="header_middle">
            场地管理
        </div>
        {if $can_edit}
        <a href="/m/test_site/space_std_edit?space_pedia_id={$_REQUEST['space_pedia_id']}">
        <div class="header_right">
            修改
        </div>
            </a>
        {else}{/if}
    </div>
</header>
<div class="clear"></div>

{*tab切换*}
<div class="site_tab_outside mt50">
    <ul class="site_tab">
        <a href="/m/test_site/basic_info?space_pedia_id={$_REQUEST['space_pedia_id']}"> <li>基本信息</li></a>
        <a href="/m/test_site/space_std?space_pedia_id={$_REQUEST['space_pedia_id']}">{if $data['status']==0}<li class="site_tab_active" style="padding-left: 15px;">空间标准<img style="width: 16px;height: 16px;float: right;" src="img/site_management/check.png" /></li>{elseif $data['status']==2}<li class="site_tab_active" style="padding-left: 15px;">空间标准<img style="width: 16px;height: 16px;float: right;" src="img/site_management/refuse.png" /></li>{else}<li class="site_tab_active">空间标准</li>{/if}</a>
        <a href="/m/test_site/mating_service?space_pedia_id={$_REQUEST['space_pedia_id']}"><li>配套设施</li></a>
        <a href="/m/test_site/act_apply?space_pedia_id={$_REQUEST['space_pedia_id']}"><li>活动适用</li></a>
        <a href="/m/test_site/image_show?space_pedia_id={$_REQUEST['space_pedia_id']}"><li>图片管理</li></a>
    </ul>
</div>

{*2空间标准*}
<div class="content_m mt10">
    <div class="site_tab_title">空间标准</div>
    {if $data['status']==0}<div class="site_tab_notice"><span style="color: #0dac7d;font-size: 14px;">待审核：</span>您的修改已经提交，预计会在2个工作日完成审核，请耐心等待，谢谢配合。</div>{elseif $data['status']==2}<div class="site_tab_notice"><span style="color: #e72418;">审核未通过：</span>{$data['refuse_reason']}</div>{/if}
    <table class="site_attr">
        <tr>
            <td class="site_attr_title">使用面积</td>
            <td class="site_attr_content">{if !empty($data['data_backup']['attr'][10])}{$data['data_backup']['attr'][10]}&nbsp;㎡{else}{/if}</td>
        </tr>
        <tr>
            <td class="site_attr_title">空间层高</td>
            <td class="site_attr_content">{if !empty($data['data_backup']['attr'][6])}{$data['data_backup']['attr'][6]}&nbsp;米{else}{/if}</td>
        </tr>
        <tr>
            <td class="site_attr_title">空间承重</td>
            <td class="site_attr_content">{$data['data_backup']['attr'][11]}</td>
        </tr>
        <tr>
            <td class="site_attr_title">容纳人数</td>
            <td class="site_attr_content">{if !empty($data['data_backup']['attr'][8])}{$data['data_backup']['attr'][8]}&nbsp;人{else}{/if}</td>
        </tr>
    </table>
</div>


{include "Web_Mobile_Static::site_management/inc.footer.tpl"}
{static "v1.0/jquery-1.11.1.min.js"}
{static "core/yunspace.js"}
{static "site_management/site_m.js"}
</body>
</html>