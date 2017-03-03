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
            <a href="javascript:history.go(-1);"> <span class="icon-angle-left"></span></a>
        </div>
        <div class="header_middle">
            场地管理
        </div>
    </div>
</header>
<div class="clear"></div>

{*tab切换*}


{*7活动适用行业类型标签选择*}
{*<form class="form-horizontal" role="form" action="?" method="post" enctype="multipart/form-data">*}
<div class="apply_add_tag_outside1">
    <div class="site_add_tag_word1">最多可设置10个行业标签</div>
    <ul class="apply_tag_list">
        {*{foreach $attr[9] as $k=>$v}*}
        <li><span>金融</span>{if in_array('金融',$data['data_backup']['attr'][9])}<div class="applyactive">&#8730;</div>{else}<div>&#8730;</div>{/if}</li>
        <li><span>房地产</span>{if in_array('房地产',$data['data_backup']['attr'][9])}<div class="applyactive">&#8730;</div>{else}<div>&#8730;</div>{/if}</li>
        <li><span>汽车</span>{if in_array('汽车',$data['data_backup']['attr'][9])}<div class="applyactive">&#8730;</div>{else}<div>&#8730;</div>{/if}</li>
        <li><span>医药</span>{if in_array('医药',$data['data_backup']['attr'][9])}<div class="applyactive">&#8730;</div>{else}<div>&#8730;</div>{/if}</li>
        <li><span>IT类</span>{if in_array('IT类',$data['data_backup']['attr'][9])}<div class="applyactive">&#8730;</div>{else}<div>&#8730;</div>{/if}</li>
        <li><span>消费品</span>{if in_array('消费品',$data['data_backup']['attr'][9])}<div class="applyactive">&#8730;</div>{else}<div>&#8730;</div>{/if}</li>
        <li><span>工业类</span>{if in_array('工业类',$data['data_backup']['attr'][9])}<div class="applyactive">&#8730;</div>{else}<div>&#8730;</div>{/if}</li>
        <li><span>奢侈品</span>{if in_array('奢侈品',$data['data_backup']['attr'][9])}<div class="applyactive">&#8730;</div>{else}<div>&#8730;</div>{/if}</li>
        <li><span>公益事业</span>{if in_array('公益事业',$data['data_backup']['attr'][9])}<div class="applyactive">&#8730;</div>{else}<div>&#8730;</div>{/if}</li>
        <li><span>教育</span>{if in_array('教育',$data['data_backup']['attr'][9])}<div class="applyactive">&#8730;</div>{else}<div>&#8730;</div>{/if}</li>
        <li><span>通讯</span>{if in_array('通讯',$data['data_backup']['attr'][9])}<div class="applyactive">&#8730;</div>{else}<div>&#8730;</div>{/if}</li>
        <li><span>游戏</span>{if in_array('游戏',$data['data_backup']['attr'][9])}<div class="applyactive">&#8730;</div>{else}<div>&#8730;</div>{/if}</li>
        <li><span>动漫</span>{if in_array('动漫',$data['data_backup']['attr'][9])}<div class="applyactive">&#8730;</div>{else}<div>&#8730;</div>{/if}</li>
        {*{/foreach}*}
    </ul>
    <div class="clear"></div>
</div>
    <input name="data[space_pedia_id]" value="{$space_pedia_id}" type="hidden">
    <input name="data[attr_new]" value='{$data_attr}' type="hidden">
    <input name="is_submit" value="1" type="hidden">
<button class="site_confirm_btn trade_submit">保存</button>
{*</form>*}


{static "v1.0/jquery-1.11.1.min.js"}
{static "core/yunspace.js"}
{static "site_management/site_m.js"}
</body>
</html>