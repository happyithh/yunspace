<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=Edge">
    <title>百科</title>
    {*{include file="Web_Static::v2.0/html_head.tpl"}*}
    {static "v4.0/common.css"}
    {static "baike.v1.0/baike_common.css"}
    {static "baike.v1.0/baike.css"}
    {static "baike.v1.0/back_search_in.css"}
    {static "baike.v1.0/baike.js"}
    {static "baike.v1.0/banner.js"}
    {static "baike.v1.0/jquery.nav.js"}
    {static "js/jquery-1.9.1.min.js"}
</head>
<body>
{include file="Web_Static::inc/header.tpl"}
<div class="search_head_back">
    <div class="search_head">
        <div class="search_head_content">
            <div class="search_label">
                场地库
                <div class="search_input_value">收搜场地资料/文创</div>
            </div>

            <input class="search_input">
            <button class="search_button clearfix">
                <span class="search_icon"></span>
                搜索一下
            </button>
        </div>
    </div>
</div>
<div class="container">
    <div class="baike-content-sub">
        <div class="baike-title clearfix">
            <h1 class="fl">奢居会空间派对会所</h1>
            <div class="fl txt">
                <p class="fl p1">心有千千万，爱有万万家心有千千万爱有万万... </p>
                <i class="fl">|</i>
                <p class="fl p2"><span class=""></span>杨浦区军工路1436号五维空间创意产业园61幢</p>
            </div>
        </div>
        {include file="Web_Static::baike.v1.0/inc/collection_title.tpl"}

        <div class="subspace-content subbox clearfix">
            <div class="fl subspace-sidebar">
                <ul class="subspace-menu clearfix">
                    <li class="current">
                        <p class="size">145㎡</p>
                        <p class="text">奢居会空间派对会所奢居会空间派对会所-#A</p>
                    </li>
                    <li>
                        <p class="size">145㎡</p>
                        <p class="text">奢居会空间派对会所-#A</p></li>
                    <li>
                        <p class="size">145㎡</p>
                        <p class="text">奢居会空间派对会所-#A</p>
                    </li>
                    <li>
                        <p class="size">145㎡</p>
                        <p class="text">奢居会空间派对会所-#A</p>
                    </li>
                    <li>
                        <p class="size">145㎡</p>
                        <p class="text">奢居会空间派对会所-#A</p>
                    </li>
                </ul>

                <!--类型-->
                <div class="comn subspace-type">
                    <div class="sub-title blue">类型</div>
                    <p>场地<span class="line">-</span>秀场展馆</p>
                    <p>行业<span class="line">-</span>金融、汽车、消费品、奢侈品</p>
                    <p>活动<span class="line">-</span>商业发布、新品发布会、体验品鉴会</p>
                </div>

                <!--容量-->
                <div class="comn subspace-capacity">
                    <div class="sub-title green">容量</div>
                    <p>面积<span class="line">-</span>850㎡</p>
                    <p>层高<span class="line">-</span>5米</p>
                    <p>承重<span class="line">-</span>1吨</p>
                    <p>人数<span class="line">-</span>10~400人</p>
                </div>

                <!--标签-->
                <div class="comn subspace-marks">
                    <div class="sub-title purple">标签</div>
                    <span class="mark">千米无柱秀场</span>
                    <span class="mark">潮流风向标</span>
                    <span class="mark">无敌江景</span>
                </div>

                <!--配套设施-开始-->
                <div class="comn" id="nv-facilities">
                    <div class="comn-title clearfix">
                        <i class="icon-facilities"></i><span>配套设施</span>
                    </div>
                    <div class="comn-baike-facilities clearfix">
                        <ul class="clearfix">
                            <li class="li1 active">
                                <div class="gray-bg">
                                    <div class="icon"></div>
                                </div>
                                <p>洗手间</p>
                            </li>
                            <li class="li2">
                                <div class="gray-bg">
                                    <div class="icon"></div>
                                </div>
                                <p>化妆间</p>
                            </li>
                            <li class="li3 active">
                                <div class="gray-bg">
                                    <div class="icon"></div>
                                </div>
                                <p>休息室</p>
                            </li>
                            <li class="li4 active">
                                <div class="gray-bg">
                                    <div class="icon"></div>
                                </div>
                                <p>空间吊点</p>
                            </li>
                            <li class="li5">
                                <div class="gray-bg">
                                    <div class="icon"></div>
                                </div>
                                <p>空调暖气</p>
                            </li>
                            <li class="li6 active">
                                <div class="gray-bg">
                                    <div class="icon"></div>
                                </div>
                                <p>网络WIFI</p>
                            </li>
                            <li class="li7">
                                <div class="gray-bg">
                                    <div class="icon"></div>
                                </div>
                                <p>停车泊位</p>
                            </li>
                            <li class="li8">
                                <div class="gray-bg">
                                    <div class="icon"></div>
                                </div>
                                <p>货运电梯</p>
                            </li>
                            <li class="li9 active">
                                <div class="gray-bg">
                                    <div class="icon"></div>
                                </div>
                                <p>投影LED</p>
                            </li>
                            <li class="li10 active">
                                <div class="gray-bg">
                                    <div class="icon"></div>
                                </div>
                                <p>灯光音响</p>
                            </li>
                            <li class="li11">
                                <div class="gray-bg">
                                    <div class="icon"></div>
                                </div>
                                <p>西餐</p>
                            </li>
                        </ul>
                    </div>
                </div><!--baike-facilities-end-->

                <!--场地简介-开始-->
                <div class="comn" id="nv-areaBrief">
                    <div class="comn-title clearfix">
                        <i class="icon-intro"></i><span>场地简介</span>
                    </div>
                    <div class="comn-baike-intro clearfix">
                        <p>墨西哥艺术中心原是上海世博园的墨西哥馆，占地约800平方米，艺术中心外观是由色彩斑斓的风筝和碧绿的草地组成的“风筝森林”会喷出清凉的水汽。</p>
                        <p>艺术中心内部场地宽阔，可容纳400人，装修时尚又富有设计感，菜肴可口美味，适合举办年会等活动。</p>
                    </div>
                </div><!--baike-intro-end-->

            </div>
            <div class="fl subspace-cont subspace-box">
                <div class="cont current">
                    <!--基本信息-开始-->
                    <div class="comn come-info">
                        <div class="comn-title clearfix">
                            <i></i><span>基本信息</span>
                            <div class="price">参考价：￥<span>1,000</span>/天</div>
                        </div>
                        <div class="comn-baike-info clearfix">
                            <dl class="clearfix">
                                <dt>适合活动类型</dt>
                                <dd>商业发布、新品发布会、体验品鉴会、主题派对、时尚走秀</dd>
                            </dl>
                            <dl class="clearfix dl-space-scale">
                                <dt>空间标准</dt>
                                <dd>
                                    <p><i class="icon-size"></i><span>850㎡</span></p>
                                    <p><i class="icon-hight"></i><span>5米</span></p>
                                    <p><i class="icon-weight"></i><span>1吨</span></p>
                                    <p><i class="icon-people"></i><span>10~400人</span></p>
                                </dd>
                            </dl>
                            <dl class="clearfix dl-space-intro">
                                <dt>空间介绍</dt>
                                <dd>云SPACE秀场位于中成智谷产业园，宝山区长江路258号逸仙路长江路出口处,项目以商务办公，创意创业，现代产业园为主体，区域内商业的时尚汇聚地和潮流风向标业态满足目标客户需求的，更丰富贴切的中形成集聚效应。</dd>
                            </dl>
                        </div>
                    </div><!--baike-intro-end-->

                    <!--图片展示-开始-->
                    <div class="comn come-picture">
                        <div class="comn-title clearfix">
                            <i></i><span>图片展示</span>
                        </div>
                        {*<ul class="comn-baike-picture">*}
                            {*<li><a href=""><img src="img/baike.v1.0/img_sub1.jpg"></a></li>*}
                        {*</ul>*}

                        <div class="comn-space-img clearfix">
                            <a class="linkimg" href="javascript:;"><img data-src="img/baike.v1.0/img_sub1.jpg" title="图片描述" src="img/baike.v1.0/img_sub1.jpg"></a>
                            <a class="linkimg" href="javascript:;"><img data-src="img/baike.v1.0/img_sub2.jpg" title="图片描述" src="img/baike.v1.0/img_sub2.jpg"></a>
                            <a class="linkimg" href="javascript:;"><img data-src="img/baike.v1.0/img_sub3.jpg" title="图片描述" src="img/baike.v1.0/img_sub3.jpg"></a>
                            <a class="linkimg" href="javascript:;"><img data-src="img/baike.v1.0/img_sub2.jpg" title="图片描述" src="img/baike.v1.0/img_sub2.jpg"></a>
                            <a class="linkimg" href="javascript:;"><img data-src="img/baike.v1.0/img_sub1.jpg" title="图片描述" src="img/baike.v1.0/img_sub1.jpg"></a>
                            <a href="javascript:;"><div class="loading"></div></a>
                        </div>
                        <!--加载更多按钮-->
                        <a href="javascript:;" class="load-more-btn">加载更多</a>
                    </div>
                </div>
                <div class="cont">
                    <!--基本信息-开始-->
                    <div class="comn come-info">
                        <div class="comn-title clearfix">
                            <i></i><span>基本信息</span>
                            <div class="price">参考价：￥<span>5,000</span>/天</div>
                        </div>
                        <div class="comn-baike-info clearfix">
                            <dl class="clearfix">
                                <dt>适合活动类型</dt>
                                <dd>fgjhgfhjfghjgf</dd>
                            </dl>
                            <dl class="clearfix dl-space-scale">
                                <dt>空间标准</dt>
                                <dd>
                                    <p><i class="icon-size"></i><span>850㎡</span></p>
                                    <p><i class="icon-hight"></i><span>5米</span></p>
                                    <p><i class="icon-weight"></i><span>1吨</span></p>
                                    <p><i class="icon-people"></i><span>10~400人</span></p>
                                </dd>
                            </dl>
                            <dl class="clearfix dl-space-intro">
                                <dt>空间介绍</dt>
                                <dd>的飞机公司的健康法国进口的时间非公开的风格的方式及</dd>
                            </dl>
                        </div>
                    </div><!--baike-intro-end-->

                    <!--图片展示-开始-->
                    <div class="comn come-picture">
                        <div class="comn-title clearfix">
                            <i></i><span>图片展示</span>
                        </div>
                        {*<ul class="comn-baike-picture">*}
                        {*<li><a href=""><img src="img/baike.v1.0/img_sub1.jpg"></a></li>*}
                        {*</ul>*}

                        <div class="comn-space-img clearfix">
                            <a class="linkimg" href="javascript:;"><img data-src="img/baike.v1.0/img_sub1.jpg" title="图片描述" src="img/baike.v1.0/img_sub1.jpg"></a>
                            <a class="linkimg" href="javascript:;"><img data-src="img/baike.v1.0/img_sub2.jpg" title="图片描述" src="img/baike.v1.0/img_sub2.jpg"></a>
                            <a class="linkimg" href="javascript:;"><img data-src="img/baike.v1.0/img_sub3.jpg" title="图片描述" src="img/baike.v1.0/img_sub3.jpg"></a>
                            <a class="linkimg" href="javascript:;"><img data-src="img/baike.v1.0/img_sub2.jpg" title="图片描述" src="img/baike.v1.0/img_sub2.jpg"></a>
                            <a class="linkimg" href="javascript:;"><img data-src="img/baike.v1.0/img_sub1.jpg" title="图片描述" src="img/baike.v1.0/img_sub1.jpg"></a>
                            <a href="javascript:;"><div class="loading"></div></a>
                        </div>
                        <!--加载更多按钮-->
                        <a href="javascript:;" class="load-more-btn">加载更多</a>
                    </div>
                </div>
                <div class="cont">内容三</div>
                <div class="cont">内容四</div>
                <div class="cont">内容五</div>
            </div>
        </div>
        </div>
    </div>
</div>

<!--图片展示弹窗-->
<div class="pop-img">
    <div class="close js-close"></div>
    <div class="title clearfix">
        <h3 class="img_title"></h3>
        <p><span class="img_number">1</span>/{count($page->spaceMedia)}</p>
    </div>
    <div class="img">
        <img src="img/space_info/space_img1.jpg">
    </div>
</div>

{include file="Web_Static::inc/public_space.tpl"}
{include file="Web_Static::inc/html_footer.tpl"}
{static "core/yunspace.js"}
</body>
</html>