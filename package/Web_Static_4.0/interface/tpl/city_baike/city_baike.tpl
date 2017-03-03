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
        <p>上海&nbsp;</p>
        <div class="show-city">
            <p>城市选择</p>
            <span class="line-no"></span>
            <div class="city-select">
                <div class="body clearfix">
                    <ul class="list clearfix">
                        <li><a href="" class="city-active">上海</a></li>
                        <li><a href="">广州</a></li>
                        <li><a href="">深圳</a></li>
                        <li><a href="">成都</a></li>
                        <li><a href="">杭州</a></li>
                        <li><a href="">上海</a></li>
                        <li><a href="">广州</a></li>
                        <li><a href="">深圳</a></li>
                        <li><a href="">成都</a></li>
                        <li><a href="">杭州</a></li>
                        <li><a href="" class="city-active">上海</a></li>
                        <li><a href="">广州</a></li>
                        <li><a href="">深圳</a></li>
                        <li><a href="">成都</a></li>
                        <li><a href="">杭州</a></li>
                        <li><a href="">上海</a></li>
                        <li><a href="">广州</a></li>
                        <li><a href="">深圳</a></li>
                        <li><a href="">成都</a></li>
                        <li><a href="">杭州</a></li>
                        <li><a href="" class="city-active">上海</a></li>
                        <li><a href="">广州</a></li>
                        <li><a href="">深圳</a></li>
                        <li><a href="">成都</a></li>
                        <li><a href="">杭州</a></li>
                        <li><a href="">上海</a></li>
                        <li><a href="">广州</a></li>
                        <li><a href="">深圳</a></li>
                        <li><a href="">成都</a></li>
                        <li><a href="">杭州</a></li>
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
            </ul>
            <ul class="slide-item-index">
                <li></li>
                <li></li>
            </ul>
        </div>
    </div>
</div>
<div class="baike-city-content">
    <div class="city-des-bg">
        <div class="city-des">
            <p>城市选择</p>
            <div class="body">
                上海（Shanghai），简称“沪”或“申”，中华人民共和国直辖市，中国国家中心城市，中国的经济、金融、贸易、航运中心。地处长江入海口，隔东中国海与日本九州岛相望，南濒杭州湾，西与江苏、浙江两省相接。
            </div>
            <div class="body">
                上海是一座国家历史文化名城，拥有深厚的近代城市文化底蕴和众多历史古迹。江南传统吴越文化与西方传入的工业文化相融合形成上海特有的海派文化上海人多属江浙民系使用吴语。早在宋代就有了“上海”之名，
                1843年后上海成为对外开放的商埠并迅。
            </div>
        </div>
    </div>
    <div class="hot-city clearfix">
        <p>热门活动</p>
        <ul class="body clearfix">
            <li>
                <a href=""  data-cate="资讯" class="color-one">
                    <div class="img-cover"></div>
                    <img src="img/city_baike/hot_01.jpg" alt="">
                    <div class="text">
                        <p>
                            <span class="title">何时何地掌握身边动态</span>
                            <span>了解城市行业最前沿的信息</span>
                        </p>
                    </div>
                </a>
            </li>
            <li>
                <a href=""  data-cate="场地"  class="color-two">
                    <div class="img-cover"></div>
                    <img src="img/city_baike/hot_02.jpg" alt="">
                    <div class="text">
                        <p>
                            <span class="title">何时何地掌握身边动态</span>
                            <span>了解城市行业最前沿的信息</span>
                        </p>
                    </div>
                </a>
            </li>
            <li>
                <a href=""  data-cate="文创"  class="color-three">
                    <div class="img-cover"></div>
                    <img src="img/city_baike/hot_03.jpg" alt="">
                    <div class="text">
                        <p>
                            <span class="title">何时何地掌握身边动态</span>
                            <span>了解城市行业最前沿的信息</span>
                        </p>
                    </div>
                </a>
            </li>
            <li>
                <a href="" data-cate="文档"  class="color-four">
                    <div class="img-cover"></div>
                    <img src="img/city_baike/hot_04.jpg" alt="">
                    <div class="text">
                        <p>
                            <span class="title">何时何地掌握身边动态</span>
                            <span>了解城市行业最前沿的信息</span>
                        </p>
                    </div>
                </a>
            </li>
        </ul>
    </div>
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
                        <p class="article">上海是长江三角洲冲积平原的一部分，平均高度为海拔4米左右西部有天马山、薛山、凤凰山等残丘，天马山为上海陆上最高点，海拔高度99.8米。</p>
                        <p class="article">立有石碑“佘山之巅”。海域上有大金山、小金山、浮山乌龟山）、佘山岛、小洋山岛等岩岛。在上海北面的长江入海处，有崇明岛、长兴岛、横沙岛3个岛屿。崇明岛为中国第三大岛，由长江挟带下来的泥沙冲积而成...</p>
                    </div>
                    <div class="line"></div>
                </div>
            </div>
        </a>
    </div>
    <div class="perfect-space">
        <p>优质场地</p>
        <div class="cate-select clearfix">
            <ul class="list">
                <li class="select-active">精心推荐</li>
                <li>超值套餐</li>
                <li>秀场展馆</li>
                <li>商业广场</li>
                <li>高端会所</li>
                <li>配套服务</li>
                <li>文创合作</li>
            </ul>
        </div>
        <div class="show-img">
            <ul class="list"  id="show-img" data-src="{$___urls['assets']}">
                <li class="item">
                    <a href="">
                        <img src="img/city_baike/p_01.jpg" alt="">
                        <p>
                            <span class="title">外滩1</span>
                            <span>有万国建筑博览群之称的外滩，它是百年上海的一个影子，也是旧上海资本主义的写照。外滩位于黄浦江和苏州河的交汇处，与浦东陆家嘴金融区隔江相望。它北起北苏州路南至金陵东路...</span>
                        </p>
                    </a>
                </li>
                <li class="item">
                    <a href="">
                        <img src="img/city_baike/p_02.jpg" alt="">
                        <p>
                            <span class="title">外滩2</span>
                            <span>有万国建筑博览群之称的外滩，它是百年上海的一个影子，也是旧上海资本主义的写照。外滩位于黄浦江和苏州河的交汇处，与浦东陆家嘴金融区隔江相望。它北起北苏州路南至金陵东路...</span>
                        </p>
                    </a>
                </li>
                <li class="item">
                    <a href="">
                        <img src="img/city_baike/p_03.jpg" alt="">
                        <p>
                            <span class="title">外滩3</span>
                            <span>有万国建筑博览群之称的外滩，它是百年上海的一个影子，也是旧上海资本主义的写照。外滩位于黄浦江和苏州河的交汇处，与浦东陆家嘴金融区隔江相望。它北起北苏州路南至金陵东路...</span>
                        </p>
                    </a>
                </li>
                <li class="item">
                    <a href="">
                        <img src="img/city_baike/p_02.jpg" alt="">
                        <p>
                            <span class="title">外滩4</span>
                            <span>有万国建筑博览群之称的外滩，它是百年上海的一个影子，也是旧上海资本主义的写照。外滩位于黄浦江和苏州河的交汇处，与浦东陆家嘴金融区隔江相望。它北起北苏州路南至金陵东路...</span>
                        </p>
                    </a>
                </li>
                <li class="item">
                    <a href="">
                        <img src="img/city_baike/p_01.jpg" alt="">
                        <p>
                            <span class="title">外滩1</span>
                            <span>有万国建筑博览群之称的外滩，它是百年上海的一个影子，也是旧上海资本主义的写照。外滩位于黄浦江和苏州河的交汇处，与浦东陆家嘴金融区隔江相望。它北起北苏州路南至金陵东路...</span>
                        </p>
                    </a>
                </li>
            </ul>
        </div>
        <div class="control-load">
            <div class="load-more">
                加载更多
            </div>
            <div class="city-load none">
                {include file="Web_Mobile_Static::inc/loading.tpl"}
            </div>
        </div>

    </div>
</div>
<!--<div id="img-li" class="none">-->
    <!--<li class="item">-->
        <!--<a href="">-->
            <!--<img src="{$_assets}" alt="">-->
            <!--<p>-->
                <!--<span class="title">外滩</span>-->
                <!--<span>有万国建筑博览群之称的外滩，它是百年上海的一个影子，也是旧上海资本主义的写照。外滩位于黄浦江和苏州河的交汇处，与浦东陆家嘴金融区隔江相望。它北起北苏州路南至金陵东路...</span>-->
            <!--</p>-->
        <!--</a>-->
    <!--</li>-->
<!--</div>-->


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