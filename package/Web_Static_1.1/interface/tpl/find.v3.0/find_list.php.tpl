<!DOCTYPE html>
<html lang="en">
<head>
    {include file="Web_Static::v2.0/html_goto_mobile.tpl" url="m/raiders"}
    <meta http-equiv="X-UA-Compatible" content="IE=Edge">
    {include file="Web_Static::v2.0/html_head.tpl"}
    {static "find.v3.0/find_list.css"}
    <link rel="stylesheet" href="plugins/ionicons-master/css/ionicons.min.css">
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

    <div class="side-left-content">
        {include file="Web_Static::find.v3.0/find_right_list.php.tpl"}
        {*筛选*}
        <div class="side-left">

            <div class="pick">
                <ul class="pick-list">

                    <li>
                        <a href="/raiders" {if $page->category_id == 0}style="color:#fff"{/if}>
                             <div {if $page->category_id == 0}class="pick-li pick-li-active"{else}class="pick-li"{/if}>推荐</div>
                        </a>
                    </li>

                    {foreach $page->allCategory as $key => $val}
                        {if $val['parent'] == 0}
                    <li>
                        <a href="/raiders/{$val['id']}" {if $page->topCategory_id['top_id'] == $val['id']}style="color:#fff"{/if}>
                            <div {if $page->topCategory_id['top_id'] == $val['id']}class="pick-li pick-li-active"{else}class="pick-li"{/if}>
                                    {$val['name']}<span class="ion-ios-arrow-down"></span>
                            </div>
                        </a>
                        <div class="pick-li-body">
                            <div style="position:relative">
                                <a href="/raiders/{$val['id']}"><span class="triangle-part1">&#9670;</span></a>
                                <a href="/raiders/{$val['id']}"><span class="triangle-part2">&#9670;</span></a>
                                <ul class="pick-select">
                                    {foreach $page->getChildren($val['id']) as $kk => $vv}
                                        {foreach $page->allCategory as $kkk => $vvv}
                                            {if $vv == $vvv['id']}
                                                <li>
                                                    {*<span style="position:absolute;left:15px;font-size: 40px;line-height: 25px;">·</span>span*}
                                                    <a href="/raiders/{$vvv['id']}"
                                            {if $page->topCategory_id['sub_id'] == $vvv['id']}class="pick-li-active-a"{/if}>
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
            {*{include file="Web_Static::find.v3.0/find_library_list.tpl"}*}
            {*列表*}
            <div class="find-list-content">
                <ul class="find-list-body">
                    {*{if $page->getRaidersList['page']['dp']==1 && $page->category_id==0}*}
                    {if $page->getRaidersList['page']['dp']==1 && $page->category_id==0 && empty($keyword)}
                    {foreach $page->getIsgood as $key=>$val}
                        <li>
                            <a href="/raiders-info/{$val['id']}.html">
                                {if !empty($val['logo'])}
                                    <div class="find-body-img">
                                        <img src="{Page_Site_Global::displayMedia($val['logo'],275,195)}" alt="{$val['title']}">
                                    </div>
                                {/if}
                                <div class="find-body-content" {if empty($val['logo'])}style="width: 96.5%;"{/if}>
                                    <div class="find-li-title">
                                        {$val['title']}
                                    </div>
                                    <div class="find-body-des-sim">
                                        <div class="find-body-des-sim-time">{$val['create_time']}</div>
                                        <div class="find-body-des-sim-look">
                                            <div class="find-body-des-sim-look-num">
                                                <div class="find-body-des-sim-look-num-img">
                                                    {*<img src="img/find.v3.0/yanjing.png" alt="浏览量" style="width:16px;height:auto">*}
                                                    <img src="img/find.v3.0/yanjing.png" alt="浏览量">
                                                </div>
                                                <p class="find-body-des-sim-look-num-p">{$val['counter_view']}</p>
                                            </div>
                                            <div class="find-body-des-sim-look-num">
                                                <div class="find-body-des-sim-look-num-img">
                                                    <img src="img/find.v3.0/zanline.png" alt="点赞">
                                                </div>
                                                <p class="find-body-des-sim-look-num-p">{$val['counter_praise']}</p>
                                            </div>

                                        </div>
                                    </div>
                                    <div class="find-body-des-info">
                                        <p>
                                            {if mb_strwidth($val['des'],'UTF-8')>208}
                                                {mb_strimwidth($val['des'],0,208,'……','UTF-8')}
                                            {else}
                                                {$val['des']}
                                            {/if}
                                        </p>
                                    </div>
                                </div>
                            </a>
                        </li>
                    {/foreach}
                    {/if}
                    {foreach $page->getRaidersList['rows'] as $v}
                    <li>
                        <a href="/raiders-info/{$v['id']}.html">
                            {if !empty($v['logo'])}
                            <div class="find-body-img">
                            <img src="{Page_Site_Global::displayMedia($v['logo'],275,195)}" alt="{$v['title']}">
                            </div>
                            {/if}
                            <div class="find-body-content" {if empty($v['logo'])}style="width: 96.5%;"{/if}>
                                <div class="find-li-title">
                                    {$v['title']}
                                </div>
                                <div class="find-body-des-sim">
                                    <div class="find-body-des-sim-time">{$v['create_time']}</div>
                                    <div class="find-body-des-sim-look">
                                        <div class="find-body-des-sim-look-num">
                                            <div class="find-body-des-sim-look-num-img">
                                                {*<img src="img/find.v3.0/yanjing.png" alt="浏览量" style="width:16px;height:auto">*}
                                                <img src="img/find.v3.0/yanjing.png" alt="浏览量">
                                            </div>
                                            <p class="find-body-des-sim-look-num-p">{$v['counter_view']}</p>
                                        </div>
                                        <div class="find-body-des-sim-look-num">
                                            <div class="find-body-des-sim-look-num-img">
                                                <img src="img/find.v3.0/zanline.png" alt="点赞">
                                            </div>
                                            <p class="find-body-des-sim-look-num-p">{$v['counter_praise']}</p>
                                        </div>

                                    </div>
                                </div>
                                <div class="find-body-des-info">
                                    <p>
                                        {if mb_strwidth($v['des'],'UTF-8')>208}
                                            {mb_strimwidth($v['des'],0,208,'……','UTF-8')}
                                        {else}
                                            {$v['des']}
                                        {/if}
                                    </p>
                                </div>
                            </div>
                        </a>
                    </li>
                    {/foreach}
                    {*<li>*}
                        {*<a href=""> <div class="find-body-content">*}
                                {*<div class="find-li-title">*}
                                    {*入秋以后，骑着自行车去观景*}
                                {*</div>*}
                                {*<div class="find-body-des-sim">*}
                                    {*<div class="find-body-des-sim-time">2015-9-28 18:00:00</div>*}
                                    {*<div class="find-body-des-sim-look">*}


                                        {*<div class="find-body-des-sim-look-num">*}
                                            {*<div class="find-body-des-sim-look-num-img">*}
                                                {*<img src="img/find.v3.0/hand1.png" alt="">*}
                                            {*</div>*}
                                            {*<p class="find-body-des-sim-look-num-p">1312</p>*}
                                        {*</div>*}
                                        {*<div class="find-body-des-sim-look-num">*}
                                            {*<div class="find-body-des-sim-look-num-img">*}
                                                {*<img src="img/find.v3.0/eye.png" alt="">*}
                                            {*</div>*}
                                            {*<p class="find-body-des-sim-look-num-p">2345</p>*}
                                        {*</div>*}
                                    {*</div>*}
                                {*</div>*}
                                {*<div class="find-body-des-info">*}
                                    {*<p>星鹏是一家电视节目制作服务公司，主营协助电视台制作电视节目，品牌广告拍摄及宣传和公关策划推广活动等。摄影棚更适合举办各种发布会及媒体活动。</p>*}
                                {*</div>*}
                            {*</div>*}
                        {*</a>*}
                    {*</li>*}

                </ul>
            </div>
        </div>

        <!--广告位开始-->
        <div yun="pa/pa.js::add" yun-name="Find ListC"></div>
        <!--广告位结束-->

        <div class="page">



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
        {*<div class="page">*}
            {*</div>*}

    </div>

</div>

{include file="Web_Static::v2.0/form.tpl"}
{include file="Web_Static::v2.0/html_footer.tpl"}
{include "Web_Static::v2.0/html_tj.tpl"}
{*{static "core/yunspace.js"}*}
</body>
</html>