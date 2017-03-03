<!DOCTYPE html>
<html lang="en">
<head>
    {include file="Web_Static::inc/head_meta.tpl"}
    {static "v4.0/common.css"}
    {static "v4.0/jquery-slide-fade.min.css"}
    {static "city_baike/city_baike.css"}
    <!--引用百度地图API-->
    <script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=aaNCRRcGGai6klHMOGZ8yBbP"></script>
</head>
<body>
{include file="Web_Static::inc/header_1.tpl"}
<div class="baike-city-header">
    <div class="city-current clearfix">
        <p id="city_name_choice">{$action_city_name}</p>
        <div class="show-city">
            <p>城市选择</p>
            <span class="line-no"></span>
            <div class="city-select">
                <div class="body clearfix">
                    <ul class="list clearfix">
                        {foreach Web_Global::$city_name as $k=>$v}
                            <li><a href="{$_home}city_baike/{Func_Url::str_urlencode($v)}" {if $action_city_name==$v}class="city-active"{/if}>{$v}</a></li>
                        {/foreach}
                    </ul>
                </div>
            </div>
        </div>
    </div>

    <div class="main-img" id="main-img">
        <div class="slide">
            <div class="slide-prev">
                <div class="slide-prev-body"></div>
            </div>
            <div class="slide-next">
                <div class="slide-next-body">
                </div>
            </div>
            <ul class="slide-item-list rent-bn-list">
                {if $spaceInfo['media']}
                    {foreach $spaceInfo['media'] as $k=>$v}
                    <li>
                        <div class="bn-img">
                            <div class="img">
                                <img src="{$v['path']}" alt="{$v['tags']}">
                            </div>
                        </div>
                    </li>
                    {/foreach}
                {else}
                    <li>
                        <div class="bn-img">
                            <div class="img">
                                <img src="img/get_space/bn3.jpg" alt="">
                            </div>
                        </div>
                    </li>
                    <li>
                        <div class="bn-img">
                            <div class="img">
                                <img src="img/get_space/bn4.jpg" alt="">
                            </div>
                        </div>
                    </li>
                {/if}
            </ul>
            <ul class="slide-item-index">
                {if $spaceInfo['media']}
                {foreach $spaceInfo['media'] as $k=>$v}
                    <li></li>
                {/foreach}
                {else}
                <li></li>
                <li></li>
                {/if}
            </ul>
        </div>
    </div>
</div>
<div class="baike-city-content">
    <div class="city-des-bg">
        <div class="city-des">
            <p>{$action_city_name}</p>
            <div class="body">
                {$spaceInfo['des']}
            </div>
        </div>
    </div>
    {if $article_list}
    <div class="hot-city clearfix">
        <p>热门活动</p>
        <ul class="body clearfix">
            {foreach $article_list as $k=>$v}
                <li>
                    <a href="{$_home}article/{Func_NumEncode::e($v['id'])}.html"   class="color-one">
                        <div class="img-cover"></div>
                        <img src="{Page_Site_Global::displayMedia($v['logo'],279,424)}" alt="{$v['title']}">
                        <div class="text">
                            <p>
                                <span class="title">{$v['title']}</span>
                                <span>{$v['des']}</span>
                            </p>
                        </div>
                    </a>
                </li>
            {/foreach}
        </ul>
    </div>
    {/if}
    <div class="city-map">
        <a href="">
            <div class="body" id="allmap" data-src="{$___urls['assets']}">
                <!--<img  src="http://api.map.baidu.com/staticimage?width=1024&height=300&center=116.413554,39.911013&zoom=11" alt="">-->
            </div>
            <div class="map-cover"></div>
            <div class="des">
                <div class="des-relative">
                    <div class="des-cover"></div>
                    <div class="des-text">
                        <p class="title">地理位置</p>
                        <p class="article"> {$spaceInfo['des']}</p>
                    </div>
                    <div class="line"></div>
                </div>
            </div>
        </a>
    </div>
    <div class="perfect-space">
        <p>优质场地</p>
        <div class="cate-select clearfix">
            <input type="hidden" value="" id="category_choice_value">
            <ul class="list">
                <li class="select-active category_choice" data-city="{$action_city_name}">精心推荐</li>
                <li class="category_choice"  data-value="113" data-city="{$action_city_name}">秀场展馆</li>
                <li class="category_choice"  data-value="114" data-city="{$action_city_name}">商业广场</li>
                <li class="category_choice"  data-value="119" data-city="{$action_city_name}">高端会所</li>
                <li class="category_choice"  data-value="116" data-city="{$action_city_name}">体育场馆</li>
                <li class="category_choice"  data-value="124" data-city="{$action_city_name}">特色场地</li>
                <li class="category_choice"  data-value="200" data-city="{$action_city_name}">文创合作</li>
            </ul>
        </div>
        {if $space_list}
        <div class="show-img">
            <ul class="list"  id="show-img" data-src="{$___urls['assets']}">
                {foreach $space_list as $k=>$v}
                    <li class="item">
                        <a href="{$_home}site/{Func_Url::str_urlencode($v['title'])}" target="_blank">
                            <img src="{$v['img']}" alt="{$v['title']}">
                            <p>
                                <span class="title">{$v['title']}</span>
                                <span>{$v['des']}</span>
                            </p>
                        </a>
                    </li>
                {/foreach}
            </ul>
        </div>
        <div class="control-load">
            {if $total_num > count($space_list)}
                <div class="load-more" data-city="{$spaceInfo['space_name']}" data-dp="2">
                    加载更多
                </div>
            {/if}
            <div class="no-data none">
                没有符合条件的数据
            </div>
            <div class="load-all none">
                已加载全部
            </div>
            <div class="city-load none">
                {include file="Web_Mobile_Static::inc/loading.tpl"}
            </div>
        </div>
        {/if}
    </div>
</div>

{include file="Web_Static::inc/html_footer.tpl"}
{static "v4.0/jquery-slide-fade.min.js"}
{static "v4.0/masonry.pkgd.min.js"}

{static "city_baike.v4.0/city_baike.js"}
{static "core/yunspace.js"}

<script>
    $("#main-img").FadeSlide({
        speed:500,
        delay:5000
    });
</script>
</body>
</html>