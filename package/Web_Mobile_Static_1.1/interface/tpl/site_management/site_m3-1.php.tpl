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
        {if $can_edit}
        <a href="/m/test_site/mating_service_edit?space_pedia_id={$_REQUEST['space_pedia_id']}">
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
        <a href="/m/test_site/basic_info?space_pedia_id={$_REQUEST['space_pedia_id']}"> <li >基本信息</li></a>
        <a href="/m/test_site/space_std?space_pedia_id={$_REQUEST['space_pedia_id']}"><li>空间标准</li></a>
        <a href="/m/test_site/mating_service?space_pedia_id={$_REQUEST['space_pedia_id']}">{if $data['status']==0}<li class="site_tab_active" style="padding-left: 15px;">配套设施<img style="width: 16px;height: 16px;float: right;" src="img/site_management/check.png" /></li>{elseif $data['status']==2}<li class="site_tab_active" style="padding-left: 15px;">配套设施<img style="width: 16px;height: 16px;float: right;" src="img/site_management/refuse.png" /></li>{else}<li class="site_tab_active">配套设施</li>{/if}</a>
        {*<a href="/m/test_site/use_std?space_pedia_id={$data['id']}"><li>使用规格</li></a>*}
        {*<a href="/m/test_site/mating_drink?space_pedia_id={$data['id']}"><li>配套饮品</li></a>*}
        {*<a href="/m/test_site/money_std?space_pedia_id={$data['id']}"><li>收费标准</li></a>*}
        <a href="/m/test_site/act_apply?space_pedia_id={$_REQUEST['space_pedia_id']}"><li>活动适用</li></a>
        <a href="/m/test_site/image_show?space_pedia_id={$_REQUEST['space_pedia_id']}"><li>图片管理</li></a>
        {*<a href="/m/test_site/space_item_list?space_pedia_id={$data['id']}"><li>子空间管理</li></a>*}
    </ul>
</div>

{*3配套设施*}
<div class="content_m mt10">
    <div class="site_tab_title">配套设施</div>
    {if $data['status']==0}<div class="site_tab_notice"><span style="color: #0dac7d;font-size: 14px;">待审核：</span>您的修改已经提交，预计会在2个工作日完成审核，请耐心等待，谢谢配合。</div>{elseif $data['status']==2}<div class="site_tab_notice"><span style="color: #e72418;">审核未通过：</span>{$data['refuse_reason']}</div>{/if}
    <table class="site_attr">
        <tr>
            <td class="site_attr_title">洗手间</td>
            <td class="site_attr_content1"></td>
            <td class="site_attr_content2">
                {if !empty($data['data_backup']['attr'][14])}
                    <div class="site_attr_selected">
                        <span class="icon-ok"></span>
                    </div>
                {else}
                    {*<div class="site_attr_unselected">*}
                    {*<span></span>*}
                    {*</div>*}
                {/if}
            </td>
        </tr>
        <tr>
            <td class="site_attr_title">化妆间</td>
            <td class="site_attr_content1"></td>
            <td class="site_attr_content2">
                {if !empty($data['data_backup']['attr'][13])}
                    <div class="site_attr_selected">
                        <span class="icon-ok"></span>
                    </div>
                {else}
                    {*<div class="site_attr_unselected">*}
                    {*<span></span>*}
                    {*</div>*}
                {/if}
            </td>
        </tr>
        <tr>
            <td class="site_attr_title">休息室</td>
            <td class="site_attr_content1"></td>
            <td class="site_attr_content2">
                {if !empty($data['data_backup']['attr'][12])}
                    <div class="site_attr_selected">
                        <span class="icon-ok"></span>
                    </div>
                {else}
                    {*<div class="site_attr_unselected">*}
                    {*<span></span>*}
                    {*</div>*}
                {/if}
            </td>
        </tr>
        <tr>
            <td class="site_attr_title">空间吊点</td>
            <td class="site_attr_content1"></td>
            <td class="site_attr_content2">
                {if !empty($data['data_backup']['attr'][15])}
                    <div class="site_attr_selected">
                        <span class="icon-ok"></span>
                    </div>
                {else}
                    {*<div class="site_attr_unselected">*}
                    {*<span></span>*}
                    {*</div>*}
                {/if}
            </td>
        </tr>
        <tr>
            <td class="site_attr_title">空调暖气</td>
            <td class="site_attr_content1"></td>
            <td class="site_attr_content2">
                {if !empty($data['data_backup']['attr'][17])}
                    <div class="site_attr_selected">
                        <span class="icon-ok"></span>
                    </div>
                {else}
                    {*<div class="site_attr_unselected">*}
                    {*<span></span>*}
                    {*</div>*}
                {/if}
            </td>
        </tr>
        <tr>
            <td class="site_attr_title">网络WIFI</td>
            <td class="site_attr_content1"></td>
            <td class="site_attr_content2">
                {if !empty($data['data_backup']['attr'][18])}
                    <div class="site_attr_selected">
                        <span class="icon-ok"></span>
                    </div>
                {else}
                    {*<div class="site_attr_unselected">*}
                    {*<span></span>*}
                    {*</div>*}
                {/if}
            </td>
        </tr>
        <tr>
            <td class="site_attr_title">停车泊位</td>
            <td class="site_attr_content1"></td>
            <td class="site_attr_content2">
                {if !empty($data['data_backup']['attr'][5])}
                    <div class="site_attr_selected">
                        <span class="icon-ok"></span>
                    </div>
                {else}
                    {*<div class="site_attr_unselected">*}
                    {*<span></span>*}
                    {*</div>*}
                {/if}
            </td>
        </tr>
        <tr>
            <td class="site_attr_title">货运电梯</td>
            <td class="site_attr_content1"></td>
            <td class="site_attr_content2">
                {if !empty($data['data_backup']['attr'][19])}
                    <div class="site_attr_selected">
                        <span class="icon-ok"></span>
                    </div>
                {else}
                    {*<div class="site_attr_unselected">*}
                    {*<span></span>*}
                    {*</div>*}
                {/if}
            </td>
        </tr>
        <tr>
            <td class="site_attr_title">投影LED</td>
            <td class="site_attr_content1"></td>
            <td class="site_attr_content2">
                {if !empty($data['data_backup']['attr'][20])}
                    <div class="site_attr_selected">
                        <span class="icon-ok"></span>
                    </div>
                {else}
                    {*<div class="site_attr_unselected">*}
                    {*<span></span>*}
                    {*</div>*}
                {/if}
            </td>
        </tr>
        <tr>
            <td class="site_attr_title">灯光音响</td>
            <td class="site_attr_content1"></td>
            <td class="site_attr_content2">
                {if !empty($data['data_backup']['attr'][21])}
                    <div class="site_attr_selected">
                        <span class="icon-ok"></span>
                    </div>
                {else}
                    {*<div class="site_attr_unselected">*}
                    {*<span></span>*}
                    {*</div>*}
                {/if}
            </td>
        </tr>
        <tr>
            <td class="site_attr_title">餐饮</td>
            <td class="site_attr_content1"></td>
            <td class="site_attr_content2">
                {if !empty($data['data_backup']['attr'][24])}
                    <div class="site_attr_selected">
                        <span class="icon-ok"></span>
                    </div>
                {else}
                    {*<div class="site_attr_unselected">*}
                    {*<span></span>*}
                    {*</div>*}
                {/if}
            </td>
        </tr>
    </table>
</div>


{include "Web_Mobile_Static::site_management/inc.footer.tpl"}
{static "v1.0/jquery-1.11.1.min.js"}
{static "core/yunspace.js"}
{*{static "site_management/site_m.js"}*}
</body>
</html>