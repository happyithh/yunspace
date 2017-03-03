<link rel="stylesheet" href="plugins/Swiper-master/css/swiper.min.css">
<script src="plugins/Swiper-master/js/swiper.min.js"></script>
{static "find.v3.0/find_right.css"}
{*<div style="position:fixed">*}
{*<div>*}

{*</div>*}
{*</div>*}

<div class="side-find" yun="find.v3.0/find-right.js::init">

    {*<div class="roll">*}
        {*<div class="swiper-container" style="width:100%;height:100%;">*}
            {*<div class="swiper-wrapper">*}
                {*{foreach $page->getBannerList as $key => $val}*}
                    {*<div class="swiper-slide">*}
                        {*<a href="/raiders-info/{$val['id']}.html"><img src="{Page_Site_Global::displayMedia($val['logo'],275,195)}" alt="{$val['title']}"></a>*}
                    {*</div>*}
                {*{/foreach}*}
            {*</div>*}
            {*<div class="swiper-button-prev img-prev" style="background: none">*}
                {*<span class="ion-chevron-left img-icon"></span>*}
            {*</div>*}
            {*<div class="swiper-button-next img-next" style="background: none">*}
                {*<span class="ion-chevron-right img-icon"></span>*}
            {*</div>*}
        {*</div>*}
        {*<div class="roll-index">*}
            {*1/{$page->getHotCount}*}
        {*</div>*}
    {*</div>*}
    {*<div class="side-hot">*}
        {*<ul class="side-hot-list">*}
            {*{foreach $page->getHotList as $k => $v}*}
                {*<li>*}
                    {*<a href="/raiders-info/{$v['id']}.html" class="side-hot-title">*}
                        {*<span>■</span>*}
                        {*{if mb_strwidth($v['title'],'UTF-8')>42}*}
                            {*{mb_strimwidth($v['title'],0,42,'','UTF-8')}*}
                        {*{else}*}
                            {*{$v['title']}*}
                        {*{/if}*}
                    {*</a>*}
                {*</li>*}
            {*{/foreach}*}
        {*</ul>*}
    {*</div>*}

    <div class="side-img">
        <div yun="pa/pa.js::add" yun-name="Find PageA">
        {*<a href="http://www.yunspace.com.cn/raiders-info/4640.html" target="_blank"><img src="img/find.v3.0/yigeren.jpg" alt="一个人"></a>*}
        </div>
    </div>





    <div class="side-top">
        <div class="side-top-head">
            <div class="side-top-p fl side-top-p-border1 side-top-p-active">浏览排行</div>
            <div class="side-top-p fl side-top-p-border2">下载排行</div>
        </div>

        <div class="side-top-list">
            <ul class="top-list">
                {foreach $page->getWenkuView as $key=>$val}
                    <li><a href="/raiders-info/{$val['id']}.html"><i>{$key+1}</i>&nbsp;&nbsp;&nbsp;
                            {if mb_strwidth($val['title'],'UTF-8')>32}
                                {mb_strimwidth($val['title'],0,32,'','UTF-8')}
                            {else}
                                {$val['title']}
                            {/if}
                            &nbsp;<span>{$val['counter_view']}</span></a></li>
                {/foreach}
            </ul>
        </div>
        <div class="side-top-list none">
            <ul class="top-list">

                {foreach $page->getWenkuLoad as $key=>$val}
                    <li><a href="/raiders-info/{$val['id']}.html"><i>{$key+1}</i>&nbsp;&nbsp;&nbsp;
                            {if mb_strwidth($val['title'],'UTF-8')>32}
                                {mb_strimwidth($val['title'],0,32,'','UTF-8')}
                            {else}
                                {$val['title']}
                            {/if}
                            &nbsp;<span>{$val['download']}</span></a></li>
                {/foreach}
            </ul>
        </div>
    </div>
    <div class="side-img">
        <div yun="pa/pa.js::add" yun-name="Find PageB">
        {*<a href="http://www.yunspace.com.cn/raiders-info/4672.html" target="_blank"><img src="img/find.v3.0/wansheng.jpg" alt="万圣"></a>*}
    </div>
        </div>
    <div class="side-img" style="height:auto!important;overflow:hidden;background: #fff;border-top:1px solid #ddd;border-bottom:1px solid #ddd;">
        <div class="side-img-code">
            <img src="img/find.v3.0/dingyue.jpg" alt="">
        </div>
        <div class="side-img-code-p">
            <img src="img/find.v3.0/weixin_icon.jpg" alt="">&nbsp;&nbsp;&nbsp;&nbsp;微信扫一扫<br>关注云SPACE订阅号
        </div>
    </div>
</div>