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

{*1基本信息--设置轨道交通*}
<div class="site_add_tag_outside1">
    <div class="site_add_tag_word1">最多可设置3条轨道交通</div>
    <ul class="site_tag_list">
        <li><span>1号线</span>{if in_array('1号线',$data['data_backup']['attr'][3])}<div class="tagactive">&#8730;</div>{else}<div>&#8730;</div>{/if}</li>
        <li><span>2号线</span>{if in_array('2号线',$data['data_backup']['attr'][3])}<div class="tagactive">&#8730;</div>{else}<div>&#8730;</div>{/if}</li>
        <li><span>3号线</span>{if in_array('3号线',$data['data_backup']['attr'][3])}<div class="tagactive">&#8730;</div>{else}<div>&#8730;</div>{/if}</li>
        <li><span>4号线</span>{if in_array('4号线',$data['data_backup']['attr'][3])}<div class="tagactive">&#8730;</div>{else}<div>&#8730;</div>{/if}</li>
        <li><span>5号线</span>{if in_array('5号线',$data['data_backup']['attr'][3])}<div class="tagactive">&#8730;</div>{else}<div>&#8730;</div>{/if}</li>
        <li><span>6号线</span>{if in_array('6号线',$data['data_backup']['attr'][3])}<div class="tagactive">&#8730;</div>{else}<div>&#8730;</div>{/if}</li>
        <li><span>7号线</span>{if in_array('7号线',$data['data_backup']['attr'][3])}<div class="tagactive">&#8730;</div>{else}<div>&#8730;</div>{/if}</li>
        <li><span>8号线</span>{if in_array('8号线',$data['data_backup']['attr'][3])}<div class="tagactive">&#8730;</div>{else}<div>&#8730;</div>{/if}</li>
        <li><span>9号线</span>{if in_array('9号线',$data['data_backup']['attr'][3])}<div class="tagactive">&#8730;</div>{else}<div>&#8730;</div>{/if}</li>
        <li><span>10号线</span>{if in_array('10号线',$data['data_backup']['attr'][3])}<div class="tagactive">&#8730;</div>{else}<div>&#8730;</div>{/if}</li>
        <li><span>11号线</span>{if in_array('11号线',$data['data_backup']['attr'][3])}<div class="tagactive">&#8730;</div>{else}<div>&#8730;</div>{/if}</li>
        <li><span>12号线</span>{if in_array('12号线',$data['data_backup']['attr'][3])}<div class="tagactive">&#8730;</div>{else}<div>&#8730;</div>{/if}</li>
        <li><span>13号线</span>{if in_array('13号线',$data['data_backup']['attr'][3])}<div class="tagactive">&#8730;</div>{else}<div>&#8730;</div>{/if}</li>
    </ul>
    <div class="clear"></div>
</div>
<input name="data[space_pedia_id]" value="{$space_pedia_id}" type="hidden">
<input name="data[attr_new]" value='{$data_attr}' type="hidden">
<input name="is_submit" value="1" type="hidden">
<button class="site_confirm_btn traffic_submit">保存</button>

<div class="site_pop">
    <div class="site_pop_title1">最多只能选择3个标签</div>
    <a class="site_pag_confirm1">确定</a>
</div>
<div class="site_mark"></div>
{static "v1.0/jquery-1.11.1.min.js"}
{static "site_management/site_m.js"}
{static "core/yunspace.js"}

</body>
</html>