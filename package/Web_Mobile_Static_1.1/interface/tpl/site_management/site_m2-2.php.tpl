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
            <a href="javascript:history.go(-1);"><span class="icon-angle-left"></span></a>
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
        <a href="/m/test_site/basic_info?space_pedia_id={$_REQUEST['space_pedia_id']}"> <li >基本信息</li></a>
        <a href="/m/test_site/space_std?space_pedia_id={$_REQUEST['space_pedia_id']}">{if $data['status']==0}<li class="site_tab_active" style="padding-left: 15px;">空间标准<img style="width: 16px;height: 16px;float: right;" src="img/site_management/check.png" /></li>{elseif $data['status']==2}<li class="site_tab_active" style="padding-left: 15px;">空间标准<img style="width: 16px;height: 16px;float: right;" src="img/site_management/refuse.png" /></li>{else}<li class="site_tab_active">空间标准</li>{/if}</a>
        <a href="/m/test_site/mating_service?space_pedia_id={$_REQUEST['space_pedia_id']}"><li>配套设施</li></a>
        {*<a href="/m/test_site/use_std?space_pedia_id={$data['id']}"><li>使用规格</li></a>*}
        {*<a href="/m/test_site/mating_drink?space_pedia_id={$data['id']}"><li>配套饮品</li></a>*}
        {*<a href="/m/test_site/money_std?space_pedia_id={$data['id']}"><li>收费标准</li></a>*}
        <a href="/m/test_site/act_apply?space_pedia_id={$_REQUEST['space_pedia_id']}"><li>活动适用</li></a>
        <a href="/m/test_site/image_show?space_pedia_id={$_REQUEST['space_pedia_id']}"><li>图片管理</li></a>
        {*<a href="/m/test_site/space_item_list?space_pedia_id={$data['id']}"><li>子空间管理</li></a>*}
    </ul>
</div>

{*2空间标准表单*}
<form class="form-horizontal" role="form" action="?" method="post" enctype="multipart/form-data">
<div class="content_m mt10">
    <div class="site_tab_title">空间标准</div>
    <table class="site_attr">
        <tr>
            <td class="site_attr_title">使用面积</td>
            <td class="site_attr_content1">
                <input class="site_input" placeholder="" value="{$data['data_backup']['attr'][10]}" name="data[attr][10]">
            </td>
            <td class="site_attr_content2">㎡</td>
        </tr>
        <tr>
            <td class="site_attr_title">空间层高</td>
            <td class="site_attr_content1">
                <input class="site_input" placeholder="" value="{$data['data_backup']['attr'][6]}" name="data[attr][6]">
            </td>
            <td class="site_attr_content2">米</td>
        </tr>
        <tr>
            <td class="site_attr_title">空间承重</td>
            <td class="site_attr_content" colspan="2">
                <input class="site_input" placeholder="请输入空间承重" value="{$data['data_backup']['attr'][11]}" name="data[attr][11]">
            </td>
        </tr>
        <tr>
            <td class="site_attr_title">容纳人数</td>
            <td class="site_attr_content1">
                <input class="site_input" placeholder="" value="{$data['data_backup']['attr'][8]}" name="data[attr][8]">
            </td>
            <td class="site_attr_content2">人</td>
        </tr>
    </table>
    <input name="data[space_pedia_id]" value="{$space_pedia_id}" type="hidden">
    {*<input name="data[attr_new]" value='{$data_attr}' type="hidden">*}
    <input name="is_submit" value="1" type="hidden">
</div>
<button class="site_confirm_btn">保存</button>
</form>

{static "v1.0/jquery-1.11.1.min.js"}
{static "core/yunspace.js"}
{static "site_management/site_m.js"}
</body>
</html>