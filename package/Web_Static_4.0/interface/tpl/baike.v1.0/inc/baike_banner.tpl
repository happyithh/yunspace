<div class="baike-banner">
    <span class="carousel-control left"></span>
    <div class="baike-banner-img yun-slider" id="bannerBaike">
        <div class="wrap clearfix">
            <div class="item">
                <img src="img/baike.v1.0/banner.jpg">
            </div>
            <div class="item"><img src="img/baike.v1.0/banner.jpg"></div>
            <div class="item"><img src="img/baike.v1.0/banner.jpg"></div>
            <div class="item"><img src="img/baike.v1.0/banner.jpg"></div>
        </div>
        {*<ul class="clearfix">*}
            {*<li><img src="img/baike.v1.0/banner.jpg"></li>*}
            {*<li><img src="img/baike.v1.0/banner.jpg"></li>*}
        {*</ul>*}
    </div>
    <span class="carousel-control right"></span>
    <div class="banner-bg"></div>
    <ul class="banner-btn" id="bannerNav">
        {*<a class="current" href="javascript:;"></a>*}
        {*<a href="javascript:;"></a>*}
        {*<a href="javascript:;"></a>*}
    </ul>
    <div class="banner-info">
        <div class="title">
            <h1 class="baike_name">奢居会空间派对会所</h1>
            <p>法餐厅坐落在繁华优雅的上海古北商区，周边高档住宅区和商务办公楼花法国...</p>
        </div>

        <div class="numb clearfix">
            <p class="fl numb-left">4398</p>
            <p class="fr numb-right">3994</p>
        </div>

        <div class="bottom">
            <p class="local_addr">长江路258号</p>
        </div>
    </div>
</div><!--baike-banner-end-->

<div class="baike-imglist-bg"  id="areaBanner">
    <div class="left_right-btn">
        <a class="btn left-btn" href="javascript:;" id="prevCarousel"></a>
        <a class="btn right-btn" href="javascript:;" id="nextCarousel"></a>
    </div>
    <div class="baike-imglist" id="bannerCarousel">
        <ul class="baike-imglist-ul clearfix" >
            <li data-src="img/baike.v1.0/slide_img1.jpg"  data-number="1">
                <a href="img/baike.v1.0/slide_img1.jpg"rel="example_group" class="fancybox-a" title="111">
                    <img src="img/baike.v1.0/slide_img1.jpg">
                    <span class="mask"></span>
                    <span class="borderstyle" href="javascript:;"></span>
                    <p class="text-bg"></p>
                    <p class="text">全部</p>
                </a>

            </li>
            <li data-src="img/baike.v1.0/slide_img1.jpg"  data-number="2">
                <a href="img/baike.v1.0/slide_img1.jpg" rel="example_group" class="fancybox-a" title="2222">
                    <img src="img/baike.v1.0/slide_img1.jpg">
                </a>
                <span class="mask"></span>
                <a class="borderstyle" href="javascript:;"></a>
                <p class="text-bg"></p>
                <p class="text">视频</p>
            </li>
            <li>
                <a href="javascript:;">
                    <img src="img/baike.v1.0/slide_img1.jpg">
                </a>
                <span class="mask"></span>
                <a class="borderstyle" href="javascript:;"></a>
                <p class="text-bg"></p>
                <p class="text">立体</p>
            </li>
            <li>
                <a href="javascript:;">
                    <img src="img/baike.v1.0/slide_img1.jpg">
                </a>
                <span class="mask"></span>
                <a class="borderstyle" href="javascript:;"></a>
                <p class="text-bg"></p>
                <p class="text">俯视</p>
            </li>
            <li>
                <a href="javascript:;">
                    <img src="img/baike.v1.0/slide_img1.jpg">
                </a>
                <span class="mask"></span>
                <a class="borderstyle" href="javascript:;"></a>
                <p class="text-bg"></p>
                <p class="text">俯视</p>
            </li>
            <li>
                <a href="javascript:;">
                    <img src="img/baike.v1.0/slide_img1.jpg">
                </a>
                <span class="mask"></span>
                <a class="borderstyle" href="javascript:;"></a>
                <p class="text-bg"></p>
                <p class="text">俯视</p>
            </li>
            <li>
                <a href="javascript:;">
                    <img src="img/baike.v1.0/slide_img1.jpg">
                </a>
                <span class="mask"></span>
                <a class="borderstyle" href="javascript:;"></a>
                <p class="text-bg"></p>
                <p class="text">俯视</p>
            </li>
            <li>
                <a href="javascript:;">
                    <img src="img/baike.v1.0/slide_img1.jpg">
                </a>
                <span class="mask"></span>
                <a class="borderstyle" href="javascript:;"></a>
                <p class="text-bg"></p>
                <p class="text">俯视</p>
            </li>

        </ul>
    </div><!--baike-imglist-end-->
</div><!--baike-imglist-bg-end-->
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