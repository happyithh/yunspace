<!DOCTYPE html>
<html>
<head>
    {include file="Web_Static::v2.0/html_goto_mobile.tpl" url="m/raiders"}
    {include file="Web_Static::v2.0/html_head.tpl"}
    <link rel="stylesheet" type="text/css" href="css/v2.0/common.css">
    <link rel="stylesheet" type="text/css" href="css/raiders/raiders-list.css">
</head>
<body>
{include file="Web_Static::v2.0/html_header3.1.tpl"}
<div class="container">
    <div class="site_location">
        <a href="/">首页</a><span>&gt;</span>
        {*<a href="{$_root}raiders/{$page->category_id}">活动攻略</a>*}
        <a href="{$_root}raiders">活动攻略</a>
    </div>
    <p class="back111"><a href="javascript:history.go(-1)"><<返回</a> </p>
    <div class="raiders-title">
        <div class="raiders-title-menu fl">
            <a href="{$_root}raiders/" {if $page->category_id==0} class='active'{/if}>全部</a>
            {foreach $page->allCategory as $key=>$val}
                {if $val['parent']==0}
                    <a href="{$_root}raiders/{$val['id']}" {if $page->topCategory_id['top_id'] == $val['id']} class='active'{/if}>{$val['name']}</a>
                {/if}
            {/foreach}
        </div>
        <div class="raiders-search fr">
            <form action="?" method="get">
                <input type="text" class="search-txt" name="keyword" placeholder="搜索关键词"
                       value="{htmlspecialchars($_REQUEST['keyword'])}">
                <input type="submit" class="search-btn">
            </form>
        </div>
    </div>
    <!--raiders-title-end-->
    <div class="raiders-wrap clearfix">
        <div class="raiders-main fl">
            {if $page->category_id}
                <div class="raiders-menu">
                    <a href="{$_root}raiders/{$page->topCategory_id['top_id']}"
                       {if $page->topCategory_id['sub_id']==0}class='active' {/if}>不限</a>
                    {foreach $page->allCategory as $key=>$val}
                        {if $val['parent']==$page->topCategory_id['top_id']}
                            <a href="{$_root}raiders/{$val['id']}" {if $page->topCategory_id['sub_id'] == $val['id']} class='active'{/if}>{$val['name']}</a>
                        {/if}
                    {/foreach}
                </div>
            {/if}
            <ul class="raiders-list clearfix">
                {foreach $page->getRaidersList['rows'] as $v}
                    <li>
                        <a href="{$_root}raiders-info/{$v['id']}.html" class="raiders-list-img">
                            {if $v['logo']}
                                <img src="{Page_Site_Global::displayMedia($v['logo'],275,195)}">
                            {else}
                                <img src="{Core::$urls['assets']}img/logo_a.png" style="width: 265px;height: 175px">
                            {/if}
                        </a>

                        <div class="raiders-list-txt">
                            {if mb_strlen($v['title'],'UTF-8')>27}
                            <h1><a href="{$_root}raiders-info/{$v['id']}.html">{mb_substr($v['title'],0,26,'utf-8')}...</a></h1>
                                {else}
                                <h1><a href="{$_root}raiders-info/{$v['id']}.html">{$v['title']}</a></h1>
                            {/if}
                            <small>{$v['create_time']}</small>
                            {if mb_strlen($v['des'],'UTF-8')>126}
                            <p>{mb_substr($v['des'],0,125,'utf-8')}...</p>
                                {else}
                                <p>{$v['des']}</p>
                            {/if}
                        </div>
                    </li>
                {/foreach}
            </ul>
            <!--页码部分-->
            {if $page->getRaidersList['page']['dt'] !=0}
                <div class="pagers">
                    {if $page->getRaidersList['page']['dpll']}
                        <a href="{$page->getRaidersList['page']['dup']}1" title="First">第一页</a>
                        <a href="{$page->getRaidersList['page']['dup']}{$page->getRaidersList['page']['dp']-1}"
                           title="Prev">上一页</a>
                    {else}
                        <a href="" class="prev first gray"><span>&laquo;&nbsp;</span>第一页</a>
                        <a href="" class="prev gray">&lt;&nbsp;上一页</a>
                    {/if}
                    {for $i=$page->getRaidersList['page']['dpl'] to $page->getRaidersList['page']['dpr']}
                        <a href="{$page->getRaidersList['page']['dup']}{$i}"{if $i==$page->getRaidersList['page']['dp']} class="active"{/if}>{$i}</a>
                    {/for}

                    {if $page->getRaidersList['page']['dprr']}
                        <a href="{$page->getRaidersList['page']['dup']}{$page->getRaidersList['page']['dp']+1}"
                           title="Next">下一页&nbsp;&gt;</a>
                        <a href="{$page->getRaidersList['page']['dup']}{$page->getRaidersList['page']['dtp']}"
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
        <!--raiders-main-end-->

        <div class="raiders-sidebar fr">
            <div class="raiders-sidebar-title">
                <h3>猜你喜欢</h3>

                <p>推广</p>
            </div>

            <ul class="raiders-sidebar-cont">
                {foreach $page->guessYouLike as $val}
                    <li>
                        <a href="/service_info/{$val['id']}.html" class="raiders-sidebar-img">
                            {if $val['logo']}
                                <img src="{Page_Site_Global::displayMedia($val['logo'],275,195)}">
                            {else}
                                <img src="{Core::$urls['assets']}img/logo_a.png" style="width: 215px;height: 155px"
                                     title="{$val['product_name']}">
                            {/if}
                        </a>
                        <a href="/service_info/{$val['id']}.html" class="raiders-sidebar-tit">{$val['product_name']}</a>
                    </li>
                {/foreach}
            </ul>
        </div>
        <!--raiders-sidebar-end-->
    </div>
    <!--raiders-wrap-end-->
</div>
<!--container-end-->
{include file="Web_Static::v2.0/form.tpl"}
{include file="Web_Static::v2.0/html_footer.tpl"}
</body>
</html>