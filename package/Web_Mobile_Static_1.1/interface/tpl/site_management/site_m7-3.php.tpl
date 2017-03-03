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
<div class="apply_add_tag_outside1">
    <div class="site_add_tag_word1">最多可设置10个活动类型</div>
    <ul class="apply_tag_list">
        <li><span>商业发布</span>{if in_array('商业发布',$data['data_backup']['attr'][49]) || in_array(' 商业发布',$data['data_backup']['attr'][49])}<div class="applyactive">&#8730;</div>{else}<div>&#8730;</div>{/if}</li>
        <li><span>展览展示</span>{if in_array('展览展示',$data['data_backup']['attr'][49]) || in_array(' 展览展示',$data['data_backup']['attr'][49])}<div class="applyactive">&#8730;</div>{else}<div>&#8730;</div>{/if}</li>
        <li><span>文体娱乐</span>{if in_array('文体娱乐',$data['data_backup']['attr'][49]) || in_array(' 文体娱乐',$data['data_backup']['attr'][49])}<div class="applyactive">&#8730;</div>{else}<div>&#8730;</div>{/if}</li>
        <li><span>会议会务</span>{if in_array('会议会务',$data['data_backup']['attr'][49]) || in_array(' 会议会务',$data['data_backup']['attr'][49])}<div class="applyactive">&#8730;</div>{else}<div>&#8730;</div>{/if}</li>
        <li><span>新品发布会</span>{if in_array('新品发布会',$data['data_backup']['attr'][49]) || in_array(' 新品发布会',$data['data_backup']['attr'][49])}<div class="applyactive">&#8730;</div>{else}<div>&#8730;</div>{/if}</li>
        <li><span>行业博览会</span>{if in_array('行业博览会',$data['data_backup']['attr'][49]) || in_array(' 行业博览会',$data['data_backup']['attr'][49])}<div class="applyactive">&#8730;</div>{else}<div>&#8730;</div>{/if}</li>
        <li><span>演场演出</span>{if in_array('演场演出',$data['data_backup']['attr'][49]) || in_array(' 演场演出',$data['data_backup']['attr'][49])}<div class="applyactive">&#8730;</div>{else}<div>&#8730;</div>{/if}</li>
        <li><span>宴会会议</span>{if in_array('宴会会议',$data['data_backup']['attr'][49]) || in_array(' 宴会会议',$data['data_backup']['attr'][49])}<div class="applyactive">&#8730;</div>{else}<div>&#8730;</div>{/if}</li>
        <li><span>体验品鉴会</span>{if in_array('体验品鉴会',$data['data_backup']['attr'][49]) || in_array(' 体验品鉴会',$data['data_backup']['attr'][49])}<div class="applyactive">&#8730;</div>{else}<div>&#8730;</div>{/if}</li>
        <li><span>艺术品展出</span>{if in_array('艺术品展出',$data['data_backup']['attr'][49]) || in_array(' 艺术品展出',$data['data_backup']['attr'][49])}<div class="applyactive">&#8730;</div>{else}<div>&#8730;</div>{/if}</li>
        <li><span>颁奖晚会/盛典</span>{if in_array('颁奖晚会/盛典',$data['data_backup']['attr'][49]) || in_array(' 颁奖晚会/盛典',$data['data_backup']['attr'][49])}<div class="applyactive">&#8730;</div>{else}<div>&#8730;</div>{/if}</li>
        <li><span>培训演讲</span>{if in_array('培训演讲',$data['data_backup']['attr'][49]) || in_array(' 培训演讲',$data['data_backup']['attr'][49])}<div class="applyactive">&#8730;</div>{else}<div>&#8730;</div>{/if}</li>
        <li><span>推广路演</span>{if in_array('推广路演',$data['data_backup']['attr'][49]) || in_array(' 推广路演',$data['data_backup']['attr'][49])}<div class="applyactive">&#8730;</div>{else}<div>&#8730;</div>{/if}</li>
        <li><span>主题展览</span>{if in_array('主题展览',$data['data_backup']['attr'][49]) || in_array(' 主题展览',$data['data_backup']['attr'][49])}<div class="applyactive">&#8730;</div>{else}<div>&#8730;</div>{/if}</li>
        <li><span>主题派对</span>{if in_array('主题派对',$data['data_backup']['attr'][49]) || in_array(' 主题派对',$data['data_backup']['attr'][49])}<div class="applyactive">&#8730;</div>{else}<div>&#8730;</div>{/if}</li>
        <li><span>晚会年会</span>{if in_array('晚会年会',$data['data_backup']['attr'][49]) || in_array(' 晚会年会',$data['data_backup']['attr'][49])}<div class="applyactive">&#8730;</div>{else}<div>&#8730;</div>{/if}</li>
        <li><span>时尚走秀</span>{if in_array('时尚走秀',$data['data_backup']['attr'][49]) || in_array(' 时尚走秀',$data['data_backup']['attr'][49])}<div class="applyactive">&#8730;</div>{else}<div>&#8730;</div>{/if}</li>
        <li><span>动漫游戏</span>{if in_array('动漫游戏',$data['data_backup']['attr'][49]) || in_array(' 动漫游戏',$data['data_backup']['attr'][49])}<div class="applyactive">&#8730;</div>{else}<div>&#8730;</div>{/if}</li>
        <li><span>亲子活动</span>{if in_array('亲子活动',$data['data_backup']['attr'][49]) || in_array(' 亲子活动',$data['data_backup']['attr'][49])}<div class="applyactive">&#8730;</div>{else}<div>&#8730;</div>{/if}</li>
        <li><span>户外拓展</span>{if in_array('户外拓展',$data['data_backup']['attr'][49]) || in_array(' 户外拓展',$data['data_backup']['attr'][49])}<div class="applyactive">&#8730;</div>{else}<div>&#8730;</div>{/if}</li>
    </ul>
    <div class="clear"></div>
</div>
<input name="data[space_pedia_id]" value="{$space_pedia_id}" type="hidden">
{*<input name="data[attr_new]" value='{$data_attr}' type="hidden">*}
<input name="is_submit" value="1" type="hidden">
<button class="site_confirm_btn act_submit">保存</button>


{static "v1.0/jquery-1.11.1.min.js"}
{static "core/yunspace.js"}
{static "site_management/site_m.js"}
</body>
</html>