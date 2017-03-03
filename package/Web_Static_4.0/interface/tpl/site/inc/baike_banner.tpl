<div class="baike-banner">
    {*<span class="carousel-control left"></span>*}
    <div class="baike-banner-img yun-slider" id="bannerBaike">
        <div class="wrap clearfix">
            <div class="item">
                {if $page->info['logo']}
                    <img src="{Page_Site_Global::displayMedia($page->info['logo'],"1920","")}">
                {else}

                {/if}
            </div>
            {*<div class="item"><img src="img/baike.v1.0/banner.jpg"></div>*}
            {*<div class="item"><img src="img/baike.v1.0/banner.jpg"></div>*}
            {*<div class="item"><img src="img/baike.v1.0/banner.jpg"></div>*}
        </div>

    </div>
    {*<span class="carousel-control right"></span>*}
    <div class="banner-bg"></div>
    {*<ul class="banner-btn" id="bannerNav">*}
    {*</ul>*}
    <div class="banner-info">
        <div class="title">
            <h1 class="baike_name">{$page->info['space_name']}</h1>
            <p>{$page->info['special_tags']}</p>
        </div>

        <div class="numb clearfix">
            <p class="fl numb-left click_total">{$count_num['click']}</p>
            <p class="fr numb-right like_go_total">{$count_num['sum']}</p>
        </div>

        <div class="bottom">
            {if $page->info['city']}
            <p class="local_addr">{$page->info['city']}市&nbsp;&nbsp;{$page->info['addr']}</p>
            {/if}
        </div>
    </div>
</div><!--baike-banner-end-->

<a name="collection"></a>
{if $page->spaceMedia&&count($page->spaceMedia)>0}
<div class="baike-imglist-bg">
    <div class="left_right-btn">
        <a class="btn left-btn" href="javascript:;" id="prevCarousel"></a>
        <a class="btn right-btn" href="javascript:;" id="nextCarousel"></a>
    </div>
    <div class="baike-imglist" id="bannerCarousel">
        <ul class="baike-imglist-ul clearfix" >
            {foreach $page->spaceMedia as $k=>$v}
                <li data-src="{Page_Site_Global::displayMedia($v['path'],750,500,1)}" data-number="{$k+1}" title="{$page->info['space_name']}&nbsp;&nbsp;{if $v['tags']}({$v['tags']}){/if}">
                    <a rel="example_group" class="fancybox-a" href="{Page_Site_Global::displayMedia($v['path'],750,500,1)}">
                        <img src="{Page_Site_Global::displayMedia($v["path"],"167","148")}">
                        <span class="borderstyle" href="javascript:;"></span>
                        <span class="mask"></span>
                    </a>
                </li>
            {/foreach}
        </ul>
    </div><!--baike-imglist-end-->
</div><!--baike-imglist-bg-end-->
{/if}
<script>
    $('#bannerBaike').YunSlide({
        delay : 5000,
        nav : '#bannerNav',
        next : '.carousel-control.right',
        prev : '.carousel-control.left'
    });

    $('#bannerCarousel').YunCarousel({
        delay : 5000,
        next : '#nextCarousel',
        prev : '#prevCarousel'
    });
</script>
<!--弹窗-->
<div class="pop-img">
    <div class="close js-close"></div>
    <div class="title clearfix">
        <h3 class="img_title">奢居会空间派对会所</h3>
        <p><span class="img_number">1</span>/{count($page->spaceMedia)}</p>
    </div>
    <div class="img">
        <img src="img/baike.v1.0/img_info.jpg">
    </div>
</div>