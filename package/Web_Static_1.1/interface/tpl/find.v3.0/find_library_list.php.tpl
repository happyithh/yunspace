<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=Edge">
    {include file="Web_Static::v2.0/html_head.tpl"}
    {static "find.v3.0/find_list.css"}
    <link rel="stylesheet" href="plugins/ionicons-master/css/ionicons.min.css">
    <title>云发现</title>
</head>
<body>
{include file="Web_Static::v2.0/html_header3.1.tpl"}
<div class="content">
    <div class="find-header">
        <div class="find-header-p1 fl">
            云·发现
        </div>
        <div class="find-header-p2 fl">
            发现不一样的精彩
        </div>
        <div class="find-header-line fl"></div>
    </div>

    <div>
        {include file="Web_Static::find.v3.0/find_right_wen.php.tpl"}
        {*筛选*}
        <div class="side-left">

            <div class="pick">
                <ul class="pick-list">

                    <li>
                        <a href="/raiders" {if $page->category_id == 0}style="color:#fff"{/if}>
                        <div {if $page->category_id == 0}class="pick-li pick-li-active"{else}class="pick-li"{/if}>
                                推荐
                        </div>
                        </a>
                    </li>

                    {foreach $page->allCategory as $key => $val}
                        {if $val['parent'] == 0}
                            <li>
                                <a href="/raiders/{$val['id']}" {if $page->topCategory_id['top_id'] == $val['id']}style="color:#fff"{/if}>
                                <div {if $page->topCategory_id['top_id'] == $val['id']}class="pick-li pick-li-active"{else}class="pick-li"{/if}>
                                        {$val['name']} <span class="ion-ios-arrow-down"></span>
                                </div>
                                </a>
                                <div class="pick-li-body">
                                    <div style="position:relative">
                                        <span class="triangle-part1">&#9670;</span>
                                        <span class="triangle-part2">&#9670;</span>
                                        <ul class="pick-select">
                                            {foreach $page->getChildren($val['id']) as $kk => $vv}
                                                {foreach $page->allCategory as $kkk => $vvv}
                                                    {if $vv == $vvv['id']}
                                                        <li><a href="/raiders/{$vvv['id']}" {if $page->topCategory_id['sub_id'] == $vvv['id']}class="pick-li-active-a"{/if}>
                                                                {$vvv['name']}
                                                            </a>
                                                        </li>
                                                    {/if}
                                                {/foreach}
                                            {/foreach}
                                        </ul>
                                    </div>
                                </div>
                            </li>
                        {/if}
                    {/foreach}
                    {*<li>*}
                        {*<div class="pick-li">活动百科 <span class="ion-ios-arrow-down"></span></div>*}
                    {*</li>*}

                    <li style="width:76px;margin-right: 0px;">
                        <div class="pick-li">搜索</div>
                        <div class="pick-li-body" style="right:0px;width:260px;">
                            <div style="position:relative;height:61px;">
                                <form action="?" method="get">
                                    <span class="triangle-part1" style="margin-left: 224px;">&#9670;</span>
                                    <span class="triangle-part2" style="margin-left: 224px;">&#9670;</span>
                                    <div class="pick-search">
                                        {*<input type="text" name="keyword">*}
                                        <input type="text" name="keyword" placeholder="搜索{foreach $page->allCategory as $key => $val}{if $page->category_id==$val['id']}{$val['name']}{/if}{/foreach}" />
                                        <button type="submit" style="cursor:pointer;"><span class="ion-ios-search-strong"></span></button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </li>
                </ul>
                <div class="clear"></div>
            </div>
            {include file="Web_Static::find.v3.0/find_library_list.tpl"}
            {*列表*}
        </div>

        {*<div class="duang">*}
            <div yun="pa/pa.js::add" yun-name="Find PageC">
            {*<a href="http://www.yunspace.com.cn/raiders-info/4275.html" target="_blank"><img src="img/find.v3.0/zahuopu.jpg" alt="杂货铺"></a>*}
            </div>
        {*</div>*}

        <div class="page">
        {if $page->getaccessory['page']['dt'] !=0}
            <div class="pagers">
                {if $page->getaccessory['page']['dpll']}
                    <a href="{$page->getaccessory['page']['dup']}1" title="First">第一页</a>
                    <a href="{$page->getaccessory['page']['dup']}{$page->getaccessory['page']['dp']-1}"
                       title="Prev">上一页</a>
                {else}
                    <a href="" class="prev first gray"><span>&laquo;&nbsp;</span>第一页</a>
                    <a href="" class="prev gray">&lt;&nbsp;上一页</a>
                {/if}
                {for $i=$page->getaccessory['page']['dpl'] to $page->getaccessory['page']['dpr']}
                    <a href="{$page->getaccessory['page']['dup']}{$i}"{if $i==$page->getaccessory['page']['dp']} class="active"{/if}>{$i}</a>
                {/for}

                {if $page->getaccessory['page']['dprr']}
                    <a href="{$page->getaccessory['page']['dup']}{$page->getaccessory['page']['dp']+1}"
                       title="Next">下一页&nbsp;&gt;</a>
                    <a href="{$page->getaccessory['page']['dup']}{$page->getaccessory['page']['dtp']}"
                       title="Last">最后页&nbsp;&raquo;</a>
                {else}
                    <a href="" class="next gray">下一页&nbsp;&gt;</a>
                    <a href="" class="next last gray">最后页<span>&nbsp;&raquo;</span></a>
                {/if}
            </div>
        {else}
            <div class=" fl clearfix no-r-raider">
                {include file="Web::inc/service_list_fl_no_result.tpl"}
            </div>
        {/if}
            </div>

        {*<div class="page">*}
        {*</div>*}

    </div>

</div>

{include file="Web_Static::v2.0/form.tpl"}
{include file="Web_Static::v2.0/html_footer.tpl"}
{*{static "core/yunspace.js"}*}
{include "Web_Static::v2.0/html_tj.tpl"}
</body>
</html>