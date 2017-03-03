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
        {*<a href="test1-1"> <li>基本信息</li></a>*}
        {*<a href="test2-1"><li>空间标准</li></a>*}
        {*<a href="test3-1"><li>配套设施</li></a>*}
        {*<a href="test4-1"><li>使用规格</li></a>*}
        {*<a href="test5-1"><li class="site_tab_active">配套饮品</li></a>*}
        {*<a href="test6-1"><li>收费标准</li></a>*}
        {*<a href="test7-1"><li>活动适用</li></a>*}
        {*<a href="test8-1"><li>图片管理</li></a>*}
        {*<a href="test9-1"><li>子空间管理</li></a>*}
        <a href="/m/test_site/basic_info?space_pedia_id={$data['id']}"><li>基本信息</li></a>
        <a href="/m/test_site/space_std?space_pedia_id={$data['id']}"><li>空间标准</li></a>
        <a href="/m/test_site/mating_service?space_pedia_id={$data['id']}"><li>配套设施</li></a>
        {*<a href="/m/test_site/use_std?space_pedia_id={$data['id']}"><li>使用规格</li></a>*}
        {*<a href="/m/test_site/mating_drink?space_pedia_id={$data['id']}"><li class="site_tab_active">配套饮品</li></a>*}
        {*<a href="/m/test_site/money_std?space_pedia_id={$data['id']}"><li>收费标准</li></a>*}
        <a href="/m/test_site/act_apply?space_pedia_id={$data['id']}"><li>活动适用</li></a>
        <a href="/m/test_site/image_show?space_pedia_id={$data['id']}"><li>图片管理</li></a>
        {*<a href="/m/test_site/space_item_list?space_pedia_id={$data['id']}"><li>子空间管理</li></a>*}
    </ul>
</div>

{*5配餐饮品表单*}
<form class="form-horizontal" role="form" action="?" method="post" enctype="multipart/form-data">
<div class="content_m mt10">
    <div class="site_tab_title">配餐饮品</div>
    <table class="site_attr">
        <tr>
            <td class="site_attr_title">餐饮种类</td>
            <td class="site_attr_content">
                <input class="site_input" placeholder="如自助餐、茶点等" name="data[attr][22]" value="{$data['attr'][22]}">
            </td>
        </tr>
        <tr>
            <td class="site_attr_title">人均价格</td>
            <td class="site_attr_content" >
                <table>
                    <tr>
                        <td class="wid90"><input class="site_input" placeholder="" name="data[attr][23]" value="{$data['attr'][23]}"></td>
                        <td>元</td>
                    </tr>
                </table>

            </td>
        </tr>
    </table>
    <input name="data[space_pedia_id]" value="{$space_pedia_id}" type="hidden">
    <input name="data[attr_new]" value='{$data_attr}' type="hidden">
    <input name="is_submit" value="1" type="hidden">
</div>
<button class="site_confirm_btn">保存</button>
</form>

{static "v1.0/jquery-1.11.1.min.js"}
{static "core/yunspace.js"}
{static "site_management/site_m.js"}
</body>
</html>