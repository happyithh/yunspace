{*左侧文章详情*}
<div class="article_inside_title" id="art_{Func_NumEncode::e($page->id)}">
    {$page->info['title']}
</div>
<div class="article_inside_brief">
    <div class="article_brief_left">
        <div class="article_inside_logo">
            <img src="img/classify.v2.0/article_inside_logo.png">
        </div>
        <div class="article_inside_author">
            {$page->info['author']|default:"云SPACE"}
        </div>
        <div class="article_inside_date">
            {date('Y-m-d',$page->info['create_time'])}
        </div>
        <div class="clear"></div>
    </div>
    <div class="article_brief_right">
        <div class="icon_good"><a href="javascript:;" class="zan"
                                  data-id="{$page->info['id']}"><span>{$page->info['counter_praise']}</span></a></div>
        <div class="icon_eye"><a href="javascript:;"><span>{$page->info['counter_view']}</span></a></div>
        <div class="clear"></div>
    </div>
    <div class="clear"></div>
</div>
<div class="article_inside_content">
    <p>{$page->info['cont']}</p>
    {if $page->info['original_link']}
    <p><a href="{$page->info['original_link']}" target="_blank" style="cursor: pointer">原文链接</a></p>
    {/if}
    <p>本文编译自：<span>云SPACE</span>，如若转载，请注明出处：<a href="http://www.yunspace.com.cn"> www.yunspace.com.cn</a>“看完这篇还不够？如果您希望把您的服务加入到我们的活动亮点中，请Email至<a
                href="mailto:service@yunspace.com.cn"> service@yunspace.com.cn</a>，或拨打电话<span>400-056-0599</span>。
    </p>
</div>
<ul class="article_inside_tags">
    {foreach $page->info['tags_info'] as $k=>$v}
        <li><a style="text-decoration: none;color: #bbb"
               href="{$_home}database?action=is_submit&search_type=project_library&keyword={Func_Url::str_urlencode($v)}&search_tag=1"
               target="_blank">{$v}</a></li>
    {/foreach}
    <div class="clear"></div>
</ul>
<div class="set_title">所属集合分类</div>
<ul class="assembled">
    {if $page->baikeName}
        {foreach $page->baikeName as $val}
            {if in_array($val['space_name'],array('全国','榜单','行业前沿','零售','海外','云SPACE','场地推荐'))}
            <a href="{$_home}site/{Func_Url::str_urlencode($val['space_name'])}" target="_blank">
            {else}
            <a href="{$_home}site/{Func_Url::str_urlencode($val['space_name'],1)}" target="_blank">
            {/if}
                <li style="overflow: hidden">
                    <img src="{Page_Site_Global::displayMedia($val['logo'],"140","85")}">
                    <div class="assembled_mask"></div>
                    <div class="assembled_name">{$val['space_name']}</div>
                </li>
            </a>
        {/foreach}
    {/if}
    <div class="clear"></div>
</ul>
<div class="article_line"></div>
