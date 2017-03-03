<div class="article-title clearfix"  id="art_{Func_NumEncode::e($page->id)}">
    {*{var_dump($page->info['paperType'])}*}
    <h2 class="clearfix" style="margin-bottom:20px;" id="art_{Func_NumEncode::e($page->info['id'])}"><i class="fl icon-a {if $page->info['paperType']=='doc'}icon-word{elseif $page->info['paperType']=='xls'}icon-excel{elseif $page->info['paperType']=='ppt'}icon-ppt{elseif $page->info['paperType']=='pdf'}icon-pdf{/if}"></i><span class="fl">{$page->info['title']}</span></h2>
    <div class=" clearfix des">
        <span>{$page->info['author']|default:"云SPACE"}</span>
        <span>{date('Y-m-d',$page->info['create_time'])}</span>
        <span>浏览量 {$page->info['counter_view']}</span>
        {*<span>评论</span>*}
    </div>
</div><!--article-title-end-->

<div class="article-cont">
    {$page->info['cont']}
    {if $page->info['accessory']['name']}
        <div class="download-btn-wrap">
            <p>当前<span> {$page->info['download']} 人下载</span></p>
            <a href="JavaScript:;" data-id="{$page->info['id']}" data-title="{$page->info['accessory']['name']}" class="download-btn accessory">
                <i class="icon-a icon-dload"></i>
                下载/预览
            </a>
        </div>
    {/if}
</div><!--article-cont-end-->

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