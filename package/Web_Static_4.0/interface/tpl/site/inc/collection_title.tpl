{if !$page->info['logo']}
    <div class="baike-title clearfix">
        <h1 class="fl">{$page->spaceName}</h1>
        <div class="fl txt">
            <p class="fl p1">{$page->info['seo_title']} </p>
            {*<i class="fl">|</i>*}
            {if $page->info['city']}
                <p class="fl p2"><span class=""></span>{$page->info['city']}市&nbsp;&nbsp;{$page->info['addr']}</p>
            {/if}
        </div>
    </div>
{/if}
<div class="collection-title clearfix">
    <div class="fl title-list">
        {*非场地只显示最新和讨论组*}
        {if $page->isSpace || ($page->info['category_id']==200 && !empty($page->info['wenchuang_attr']))}
            {if $page->info['level']==4 || $page->info['category_id']==200}
                <a {if $page->baikeAction=="最新"}class="current"{/if} href="http://{Core::$urls['host']}/site/{Func_Url::str_urlencode($page->spaceName,2)}#collection">最新</a>
                <a {if $page->baikeAction=="精华"}class="current"{/if} href="http://{Core::$urls['host']}/site/{Func_Url::str_urlencode($page->spaceName,3)}#collection">精华</a>
            {/if}
            {if $page->isSpace} {*文创类暂时不显示场地百科tab  add by yl*}
                <a {if $page->baikeAction=="百科" && !$page->item_id}class="current"{/if} href="http://{Core::$urls['host']}/site/{Func_Url::str_urlencode($page->spaceName,1)}#collection">场地百科</a>
            {/if}
            {if $page->isSpace && $page->spaceItem[0]['id']}
                <a {if $page->baikeAction=="百科" && $page->item_id}class="current"{/if} href="http://{Core::$urls['host']}/site/{Func_Url::str_urlencode($page->spaceName,1)}-{Func_NumEncode::e($page->spaceItem[0]['id'])}#collection">子空间</a>
            {/if}
            <a {if $page->baikeAction=="讨论组"}class="current"{/if} href="http://{Core::$urls['host']}/site/{Func_Url::str_urlencode($page->spaceName,4)}#collection">讨论组</a>
            {if $page->info['level']!=4 && $page->info['category_id']!=200}
                <a {if $page->baikeAction=="最新"}class="current"{/if} href="http://{Core::$urls['host']}/site/{Func_Url::str_urlencode($page->spaceName,2)}#collection">活动案例</a>
            {/if}
        {else}
            <a {if $page->baikeAction=="最新"}class="current"{/if} href="http://{Core::$urls['host']}/site/{Func_Url::str_urlencode($page->spaceName,2)}#collection">最新</a>
            <a {if $page->baikeAction=="讨论组"}class="current"{/if} href="http://{Core::$urls['host']}/site/{Func_Url::str_urlencode($page->spaceName,4)}#collection">讨论组</a>
        {/if}
    </div>
    {if $page->isSpace}
        {if $page->baikeAction=="百科"}
            <a class="fr pop-show zu-check-btn" href="javascript:;"><i class="icon"></i>查询档期和价格</a>
        {/if}
        <a class="fr btn-zu" href="{Web_Global::createRentSpaceUrl()}&space_id={Func_NumEncode::e($page->info['id'])}"><i class="icon"></i>一键租场地</a>
        {include file="Web_Static::site/inc/schedule_price_pop.tpl"}
        {*为百科内页的查询档期和价格用*}
    {elseif $page->info['category_id']==200}
        <a class="fr btn-consult pop-show" href="javascript:;"><i class="icon"></i>文创项目合作</a>
        {include file="Web_Static::site/inc/consult_pop.tpl"}
        {*文创项目合作*}
    {else}
        <a class="fr btn-consult pop-show" href="javascript:;"><i class="icon"></i>合作咨询</a>
        {include file="Web_Static::site/inc/consult_pop.tpl"}
        {*文创项目合作*}
    {/if}
</div>

