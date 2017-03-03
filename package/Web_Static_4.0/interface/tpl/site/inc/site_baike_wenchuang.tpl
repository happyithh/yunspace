<div class="container">
<div class="baike-content">
    {include file="Web_Static::site/inc/collection_title.tpl"}
    <div class="baike-dtl">
        <div class="title">
            <h2>{$page->info['space_name']}</h2>

            <p>{$page->info['seo_title']}</p>
        </div>
        <div class="cont clearfix">
            <div class="cont-tsadd fl">
                <h5><span>故</span>事起源</h5>

                <p>{$page->info['wenchuang_attr']['故事起源']}</p>
            </div>
            <div class="cont-tsadd fl">
                <h5><span>故</span>事类型</h5>

                <p>{$page->info['special_tags']} </p>
            </div>
        </div>
    </div>
    <!--space-dtl-end-->

    <!--故事概述-开始-->
    <div class="comn" id="nv-story-intro">
        <div class="comn-title clearfix">
            <i class="icon-story-intro"></i><span>故事概述</span>
        </div>
        <div class="comn-baike-story-intro clearfix">
            {$page->info['wenchuang_attr']['故事概述']}
        </div>
        <!--comn-baike-story-intro-end-->
    </div>
    <!--baike-story-intro-end-->

    <!--精彩图集-开始-->
    {*<div class="comn" id="nv-atlas">*}
        {*<div class="comn-title clearfix">*}
            {*<i class="icon-atlas"></i><span>精彩图集</span>*}
        {*</div>*}
        {*<div class="comn-baike-pic clearfix">*}
            {*<a rel="example_group" href="javascript:;" class="load-img none fancybox-a">*}
                {*<img data-src="" title="" data-number="" src="">*}
            {*</a>*}
            {*<a href="javascript:;" class="loading-img none" onclick="return false;">*}
                {*<div class="loading"></div>*}
            {*</a>*}
            {*{foreach $page->spaceMedia as $k=>$v}*}
                {*{if $k<12}*}
                    {*<a rel="example_group" class="fancybox-a"*}
                       {*href="{Page_Site_Global::displayMedia($v['path'],750,500,1)}">*}
                        {*<img title="{$page->info['space_name']}&nbsp;&nbsp;({$v['tags']})"*}
                             {*src="{if isset($page->spaceItem[0]) && $page->spaceItem[0]['is_thc']}{Page_Site_Global::displayMedia($v['path'],262,225,1,'thc')}{else}{Page_Site_Global::displayMedia($v['path'],294,252,1)}{/if}">*}
                    {*</a>*}
                {*{/if}*}
            {*{/foreach}*}
            {*{if !$is_more && count($page->spaceMedia)%4 ==1}*}
                {*<a href="javascript:;">*}
                    {*<div class="loading"></div>*}
                {*</a>*}
                {*<a href="javascript:;">*}
                    {*<div class="loading"></div>*}
                {*</a>*}
                {*<a href="javascript:;">*}
                    {*<div class="loading"></div>*}
                {*</a>*}
            {*{elseif !$is_more && count($page->spaceMedia)%4 ==2}*}
                {*<a href="javascript:;">*}
                    {*<div class="loading"></div>*}
                {*</a>*}
                {*<a href="javascript:;">*}
                    {*<div class="loading"></div>*}
                {*</a>*}
            {*{elseif !$is_more && count($page->spaceMedia)%4 ==3}*}
                {*<a href="javascript:;">*}
                    {*<div class="loading"></div>*}
                {*</a>*}
            {*{/if}*}
        {*</div>*}
        {*<!--comn-baike-pic-end-->*}
    {*</div>*}
    <!--精彩图集-结束-->

    <!--剧情简介-开始-->
    {*{var_dump($page->info['des'])}*}
    <div class="comn" id="nv-plot-intro">
        <div class="comn-title clearfix">
            <i class="icon-plot-intro"></i><span>剧情简介</span>
        </div>
        <div class="comn-baike-plot-intro clearfix">
            <p>{$page->info['des']}</p>
        </div>
        <!--comn-baike-plot-intro-end-->
    </div>
    <!--baike-plot-intro-end-->

    <!--角色介绍-->
    <div class="comn" id="nv-role-intro">
        <div class="comn-title clearfix">
            <i class="icon-role-intro"></i><span>角色介绍</span>
        </div>
        {*{var_dump($article_list['rows'])}*}
        <ul class="comn-baike-role-intro clearfix">
            {if !empty($article_list['rows'])}
                {foreach $article_list['rows'] as $k=>$v}
                    {if $v['category_id']==28}
                        <li>
                            <a href="{$_home}article/{Func_NumEncode::e($v['id'])}.html">
                                <div class="fl img"><img src="{Page_Site_Global::displayMedia($v['logo'],"140","143")}">
                                </div>
                                <div class="fl cont">
                                    <h3>{$v['title']}</h3>
                                    <h5>演员/<a href="javascript:;">{$v['actor']}</a></h5>

                                    <p>{if strlen($v['cont']) >300}{mb_substr($v['cont'],0,300,"utf8")}...{else}{$v['cont']}{/if}</p>
                                </div>
                            </a>
                        </li>
                    {/if}
                {/foreach}
            {/if}
        </ul>
        <!--comn-baike-role-intro-end-->
    </div>
    <!--baike-role-intro-end-->

    <!--获奖记录-->
    <div class="comn" id="nv-winning-record">
        <div class="comn-title clearfix">
            <i class="icon-winning-record"></i><span>获奖记录</span>
        </div>
        <ul class="comn-baike-winning-record">
            {if count($page->info['wenchuang_attr']['获奖记录'])>0}
                {foreach $page->info['wenchuang_attr']['获奖记录'] as $k=>$v}
                    <li>
                        <i>·</i>
                        <strong>{$v['win_time']}</strong>
                        <span>{$v['active_name']}</span>
                        <span>{$v['win_name']}</span>
                        <span>{$v['win_actor']}</span>
                    </li>
                {/foreach}
            {/if}
        </ul>
    </div>
    <!--nv-winning-record-end-->

    <!--故事评价-->
    <div class="comn" id="nv-story-evaluate">
        <div class="comn-title clearfix">
            <i class="icon-story-evaluate"></i><span>故事评价</span>
        </div>
        <ul class="comn-baike-story-evaluate">
            {foreach $article_list['rows'] as $k=>$v}
                {if $v['category_id']==29}
                    <li>
                        <a class="title" href="{$_home}article/{Func_NumEncode::e($v['id'])}.html">{$v['title']}</a>

                        <p>{if strlen($v['cont']) >300}{mb_substr($v['cont'],0,300,"utf8")}...{else}{$v['cont']}{/if} </p>

                        <div class="other-info">{$v['author']|default:'云SPACE'}
                            | {date('Y-m-d H:i',$v['create_time'])}</div>
                    </li>
                {/if}
            {/foreach}

        </ul>
    </div>
    <!--nv-story-evaluate-end-->

    <!--参考资料-->
    <div class="comn" id="nv-resources">
        <div class="comn-title clearfix">
            <i class="icon-resources"></i><span>参考资料</span>
        </div>
        <ol class="comn-baike-resources">
            {foreach $article_list['rows'] as $k=>$v}
                {if $v['category_id']!=28 && $v['category_id']!=29 }
                    <li><a href="{$_home}article/{Func_NumEncode::e($v['id'])}.html">{$v['title']}</a></li>
                {/if}
            {/foreach}
        </ol>
    </div>
    <!--nv-resources-end-->

</div>
<!--baike-content-end-->

<div class="side-nav">
    {*<a href="javascript:;" class="inquiry-order" id="inquiryOrder">*}
    {*<span class="circle1">15</span>*}
    {*</a>*}
    <div class="title">
        <h6>百科词条目录</h6>
        {*<p></p>*}
    </div>
    <ul class="side-list clearfix" id="nav">
        <li class="list1 lione current">
            <a href="#nv-story-intro">
                <span></span>

                <p>故事概述</p>
            </a>
            <span class="line"></span>
        </li>
        {*<li class="list-atlas lione">*}
            {*<a href="#nv-atlas">*}
                {*<span></span>*}

                {*<p>精彩图集</p>*}
            {*</a>*}
            {*<span class="line"></span>*}
        {*</li>*}
        <li class="list-plot-intro lione">
            <a href="#nv-plot-intro">
                <span></span>

                <p>剧情介绍</p>
            </a>
            <span class="line"></span>
        </li>
        <li class="list-role-intro lione">
            <a href="#nv-role-intro">
                <span></span>

                <p>角色介绍</p>
            </a>
            <span class="line"></span>
        </li>
        <li class="list-winning-record lione">
            <a href="#nv-winning-record">
                <span></span>

                <p>获奖记录</p>
            </a>
            <span class="line"></span>
        </li>
        <li class="list-story-evaluate lione">
            <a href="#nv-story-evaluate">
                <span></span>

                <p>故事评价</p>
            </a>
        </li>
        <li class="list-resources lione">
            <a href="#nv-resources">
                <span></span>

                <p>参考资料</p>
            </a>
        </li>
    </ul>
    <!--nav-end-->
</div>

</div>
{static "core/yunspace.js"}
