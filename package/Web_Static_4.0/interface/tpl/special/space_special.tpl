<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    {include file="Web_Static::inc/head_meta.tpl"}
    {static "v4.0/common.css"}
    {static "special/space_special.css"}
    <link href="http://vjs.zencdn.net/5.10.4/video-js.css" rel="stylesheet">
    <!-- If you'd like to support IE8 -->
    <script src="http://vjs.zencdn.net/ie8/1.1.2/videojs-ie8.min.js"></script>
</head>
<body>
{include file="Web_Static::inc/header_1.tpl"}
<div class="about-location">
    <div class="wrapper">
        <div class="crumb">
            <a href="{$_home}">首页</a>&gt;<a href="{$_root}about" class="active">专题</a>
        </div>
    </div>
</div>

<div class="baike-banner">
    <span class="carousel-control left"></span>

    <div class="baike-banner-img yun-slider" id="bannerBaike">
        <div class="wrap clearfix">
            {*<div class="item"><img src="img/home/banner.jpg"></div>*}
            <div class="item">
                <a href="javascript:;">
                    <img src="img/special/img_banner.jpg">
                    <div class="text">
                        <h3>云SPACE精选场地</h3>
                        <p>特色场地，云SPACE精选，给您不一样的活动体验</p>
                    </div>
                </a>
            </div>
            <div class="item">
                <a href="javascript:;">
                    <img _src="img/special/img_banner.jpg">
                    <div class="text">
                        <h3>云SPACE精选场地</h3>
                        <p>特色场地，云SPACE精选，给您不一样的活动体验</p>
                    </div>
                </a>
            </div>
        </div>

    </div>
    <span class="carousel-control right"></span>
    <ul class="banner-btn" id="bannerNav">
    </ul>
</div>
<!--baike-banner-end-->


<div class="wrapper special-wrapper clearfix">
    <div class="special-title clearfix">
        <a class="active" href="javascript:;">全部专题</a>
        <a href="javascript:;">推荐专题</a>
    </div>
    <div class="special-cont">

        <ul class="home-recommend-list clearfix">
            <li>
                <a href="{$_home}topic/market" target="_blank">
                    <div class="coverr"></div>
                    <div class="home-recommend-img">
                        <img src="img/home/img01.jpg" alt="商场专题"/>
                    </div>
                    <div class="home-recommend-text">
                        <div class="body">
                            <p class="home_tab_text1">商场空间场地那些事儿！</p>

                            <p class="home_tab_text2">——极佳的商场空间场地，给你前所未有的空前体验</p>
                        </div>
                        <div class="body_mask"></div>
                    </div>
                </a>
            </li>
            <li>
                <a href="{$_home}topic/music" target="_blank">
                    <div class="coverr"></div>
                    <div class="home-recommend-img">
                        <img src="img/home/img02.jpg" alt="音乐节专题"/>
                    </div>
                    <div class="home-recommend-text">
                        <div class="body">
                            <p class="home_tab_text1">这个夏天跟着音乐一起摇摆！</p>

                            <p class="home_tab_text2">——优质的场地才能承载优质的音乐，云SPACE推荐，让音乐升温</p>
                        </div>
                        <div class="body_mask"></div>
                    </div>
                </a>
            </li>
            <li>
                <a href="{$_home}topic/movies" target="_blank">
                    <div class="coverr"></div>
                    <div class="home-recommend-img">
                        <img src="img/home/img03.jpg" alt="影视专题"/>
                    </div>
                    <div class="home-recommend-text">
                        <div class="body">
                            <p class="home_tab_text1">影视拍摄场地集结号</p>

                            <p class="home_tab_text2">——选好场地、让您的活动加分</p>
                        </div>
                        <div class="body_mask"></div>
                    </div>
                </a>
            </li>
            <li>
                <a href="{$_home}topic/self" target="_blank">
                    <div class="coverr"></div>
                    <div class="home-recommend-img">
                        <img src="img/home/img04.jpg" alt="自营专题"/>
                    </div>
                    <div class="home-recommend-text">
                        <div class="body">
                            <p class="home_tab_text1">云SPACE精选场地</p>

                            <p class="home_tab_text2">——特色场地、云SPACE精选，给您不一样的活动体验！</p>
                        </div>
                        <div class="body_mask"></div>
                    </div>
                </a>
            </li>
            <li>
                <a href="{$_home}topic/market" target="_blank">
                    <div class="coverr"></div>
                    <div class="home-recommend-img">
                        <img src="img/home/img01.jpg" alt="商场专题"/>
                    </div>
                    <div class="home-recommend-text">
                        <div class="body">
                            <p class="home_tab_text1">商场空间场地那些事儿！</p>

                            <p class="home_tab_text2">——极佳的商场空间场地，给你前所未有的空前体验</p>
                        </div>
                        <div class="body_mask"></div>
                    </div>
                </a>
            </li>
            <li>
                <a href="{$_home}topic/music" target="_blank">
                    <div class="coverr"></div>
                    <div class="home-recommend-img">
                        <img src="img/home/img02.jpg" alt="音乐节专题"/>
                    </div>
                    <div class="home-recommend-text">
                        <div class="body">
                            <p class="home_tab_text1">这个夏天跟着音乐一起摇摆！</p>

                            <p class="home_tab_text2">——优质的场地才能承载优质的音乐，云SPACE推荐，让音乐升温</p>
                        </div>
                        <div class="body_mask"></div>
                    </div>
                </a>
            </li>
            <li>
                <a href="{$_home}topic/movies" target="_blank">
                    <div class="coverr"></div>
                    <div class="home-recommend-img">
                        <img src="img/home/img03.jpg" alt="影视专题"/>
                    </div>
                    <div class="home-recommend-text">
                        <div class="body">
                            <p class="home_tab_text1">影视拍摄场地集结号</p>

                            <p class="home_tab_text2">——选好场地、让您的活动加分</p>
                        </div>
                        <div class="body_mask"></div>
                    </div>
                </a>
            </li>
            <li>
                <a href="{$_home}topic/self" target="_blank">
                    <div class="coverr"></div>
                    <div class="home-recommend-img">
                        <img src="img/home/img04.jpg" alt="自营专题"/>
                    </div>
                    <div class="home-recommend-text">
                        <div class="body">
                            <p class="home_tab_text1">云SPACE精选场地</p>

                            <p class="home_tab_text2">——特色场地、云SPACE精选，给您不一样的活动体验！</p>
                        </div>
                        <div class="body_mask"></div>
                    </div>
                </a>
            </li>
            <li>
                <a href="{$_home}topic/market" target="_blank">
                    <div class="coverr"></div>
                    <div class="home-recommend-img">
                        <img src="img/home/img01.jpg" alt="商场专题"/>
                    </div>
                    <div class="home-recommend-text">
                        <div class="body">
                            <p class="home_tab_text1">商场空间场地那些事儿！</p>

                            <p class="home_tab_text2">——极佳的商场空间场地，给你前所未有的空前体验</p>
                        </div>
                        <div class="body_mask"></div>
                    </div>
                </a>
            </li>
            <li>
                <a href="{$_home}topic/music" target="_blank">
                    <div class="coverr"></div>
                    <div class="home-recommend-img">
                        <img src="img/home/img02.jpg" alt="音乐节专题"/>
                    </div>
                    <div class="home-recommend-text">
                        <div class="body">
                            <p class="home_tab_text1">这个夏天跟着音乐一起摇摆！</p>

                            <p class="home_tab_text2">——优质的场地才能承载优质的音乐，云SPACE推荐，让音乐升温</p>
                        </div>
                        <div class="body_mask"></div>
                    </div>
                </a>
            </li>
            <li>
                <a href="{$_home}topic/movies" target="_blank">
                    <div class="coverr"></div>
                    <div class="home-recommend-img">
                        <img src="img/home/img03.jpg" alt="影视专题"/>
                    </div>
                    <div class="home-recommend-text">
                        <div class="body">
                            <p class="home_tab_text1">影视拍摄场地集结号</p>

                            <p class="home_tab_text2">——选好场地、让您的活动加分</p>
                        </div>
                        <div class="body_mask"></div>
                    </div>
                </a>
            </li>
            <li>
                <a href="{$_home}topic/self" target="_blank">
                    <div class="coverr"></div>
                    <div class="home-recommend-img">
                        <img src="img/home/img04.jpg" alt="自营专题"/>
                    </div>
                    <div class="home-recommend-text">
                        <div class="body">
                            <p class="home_tab_text1">云SPACE精选场地</p>

                            <p class="home_tab_text2">——特色场地、云SPACE精选，给您不一样的活动体验！</p>
                        </div>
                        <div class="body_mask"></div>
                    </div>
                </a>
            </li>
        </ul>

        <!--页码部分-->
        {include file="Web_Static::inc/paging.tpl"}
    </div><!--special-cont-end-->
</div><!--wrapper-end-->
{include file="Web_Static::inc/html_footer.tpl"}
{include file="Web_Static::inc/public_space.tpl"}

<script>
    $('#bannerBaike').YunSlide({
        delay: 5000,
        nav: '#bannerNav',
        next: '.carousel-control.right',
        prev: '.carousel-control.left'
    });
    document.onreadystatechange = function () {
        if (document.readyState == 'complete') { //当页面加载状态
            $(".wrap").find('.item').each(function (k, d) {
                var $d = $(d);
                if ($d.find('img').attr('_src')) {
                    $d.find('img').attr('src', $d.find('img').attr('_src'));
                }
            })
        }
    }
</script>
</body>
</html>