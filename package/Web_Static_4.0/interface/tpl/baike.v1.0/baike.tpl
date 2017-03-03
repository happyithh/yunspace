<!DOCTYPE html>
<html>
<head>
    {include file="Web_Static::v4.0/html_goto_mobile.tpl" url="m/site/{Func_Url::str_urlencode($page->info['space_name'])}-{Func_Url::str_urlencode($page->baikeAction)}"}
    {include file="Web_Static::inc/head_meta.tpl"}
    {static "v4.0/jquery-migrate-1.2.1.js"}
    {static "v4.0/common.css"}
    {static "baike.v1.0/baike_common.css"}
    {static "fancyboxV2/jquery.fancybox.css"}
    {static "baike.v1.0/baike.css"}
    {static "baike.v1.0/banner.js"}

    {static "fancyboxV2/jquery.fancybox.js"}
    {static "baike.v1.0/jquery.nav.js"}
    {static "baike.v1.0/baike.js"}

    {static "baike.v1.0/news.css"}
    {static "js/jquery-1.9.1.min.js"}
    {static "baike.v1.0/news.js"}
</head>
<body>啊实打实大师
{include file="Web_Static::inc/header2.tpl"}
{include file="Web_Static::baike.v1.0/inc/baike_banner.tpl"}
<div class="container">
    <div class="baike-content">
        {include file="Web_Static::baike.v1.0/inc/collection_title.tpl"}
        <div class="baike-dtl">
            <div class="title">
                <h2>奢居会空间派对会所</h2>
                <p>无敌江景，国庆期间内 八折 优惠，预购从速！</p>
                <div class="price">参考价<br/><span>￥1,000</span></div>
            </div>
            <div class="cont clearfix">
                <dl class="clearfix">
                    <dt class="fl blue">类型</dt>
                    <dd class="fl">场地类型 | 秀场展馆 &nbsp;&nbsp;/&nbsp;&nbsp; 活动类型 | 商业发布、新品发布会、体验品鉴会</dd>
                    <dd class="fr marks">
                        <span>千米无柱秀场</span>
                        <span>潮流风向标</span>
                        <span>无敌江景</span>
                        <span>无敌江景</span>
                    </dd>
                </dl>
                <dl class="clearfix">
                    <dt class="fl yellow">地址</dt>
                    <dd class="fl">杨浦区 &nbsp;&nbsp;/&nbsp;&nbsp; 杨浦区军工路1436号五维空间创意产业园61幢
                        <a class="link-map" href="#nv-position">查看地理位置</a>
                    </dd>
                </dl>
                <dl class="clearfix dl-last">
                    <dt class="fl green">容量</dt>
                    <dd class="fl">面积 | 1300㎡  &nbsp;&nbsp;/&nbsp;&nbsp;  人数 | 0~1400人</dd>
                </dl>
            </div>
        </div><!--space-dtl-end-->

        <!--品牌故事-开始-->
        {*<div class="comn" id="nv-story">*}
            {*<div class="comn-title clearfix">*}
                {*<i class="icon-story"></i><span>品牌故事</span>*}
            {*</div>*}
            {*<div class="comn-baike-story clearfix">*}
                {*<div class="cont">*}
                    {*<div class="cont-text">*}
                        {*<h5>起源</h5>*}
                        {*<p>配套服务展示、管理、预订为一体，为活动方与场地、配套服务商之间搭建桥梁，让客户在海量资源中迅速找到满足需求的优质供应商</p>*}
                    {*</div>*}
                    {*<div class="cont-img"><img src="img/baike.v1.0/img_story1.jpg"></div>*}
                {*</div>*}
                {*<div class="cont">*}
                    {*<div class="cont-text">*}
                        {*<h5>初始</h5>*}
                        {*<p>无论是私人派对，还是企业活动，主办方只需在线上输入简单活动需求，系统立即从海量资源库中抓取匹配的场地和配套服务。</p>*}
                    {*</div>*}
                    {*<div class="cont-img"><img src="img/baike.v1.0/img_story2.jpg"></div>*}
                {*</div>*}
                {*<div class="cont" style="margin: 0">*}
                    {*<div class="cont-text">*}
                        {*<h5>发展</h5>*}
                        {*<p>团队为活动主办方提供空间及配套服务建议，协调各方工作，为客户省去了一大笔活动公司咨询费用；另一方面。</p>*}
                    {*</div>*}
                    {*<div class="cont-img"><img src="img/baike.v1.0/img_story3.jpg"></div>*}
                {*</div>*}
            {*</div><!--comn-baike-story-end-->*}
        {*</div><!--baike-story-end-->*}

        <!--基础信息-开始-->
        <div class="comn" id="nv-baseInfo">
            <div class="comn-title clearfix">
                <i class="icon-msg"></i><span>基础信息</span>
            </div>
            <div class="comn-baike-info clearfix">
                <div class="cont cont-location">
                    <h5>地理位置</h5>
                    <ul>
                        <li>所在城市<span>-</span>上海</li>
                        <li>行政区域<span>-</span>徐汇区</li>
                        <li>所属商圈<span>-</span>徐汇滨江</li>
                        <li>轨道交通<span>-</span>7号线、11号线</li>
                    </ul>
                </div>

                <div class="cont cont-standards">
                    <h5>空间标准</h5>
                    <ul>
                        <li>使用面积<span>-</span>850</li>
                        <li>空间层高<span>-</span>5米</li>
                        <li>空间承重<span>-</span>1吨</li>
                        <li>容纳人数<span>-</span>400</li>
                    </ul>
                </div>

                <div class="cont cont-apply">
                    <h5>活动适用</h5>
                    <ul>
                        <li>行业类型<span>-</span>金融、汽车、消费品、奢侈品</li>
                        <li>活动类型<span>-</span>商业发布、新品发布会、体验品鉴会、主题派对、时尚走秀</li>
                    </ul>
                </div>
            </div>
        </div><!--baike-info-end-->

        <!--配套设施-开始-->
        <div class="comn" id="nv-facilities">
            <div class="comn-title clearfix">
                <i class="icon-facilities"></i><span>配套设施</span>
            </div>
            <div class="comn-baike-facilities clearfix">
                <ul class="clearfix">
                    <li class="li1">
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
                    <li class="li3">
                        <div class="gray-bg">
                            <div class="icon"></div>
                        </div>
                        <p>休息室</p>
                    </li>
                    <li class="li4">
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
                    <li class="li6">
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
                    <li class="li9">
                        <div class="gray-bg">
                            <div class="icon"></div>
                        </div>
                        <p>投影LED</p>
                    </li>
                    <li class="li10">
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

        <!--场地位置-开始-->
        <div class="comn" id="nv-position">
            <div class="comn-title clearfix">
                <i class="icon-position"></i><span>场地位置</span>
            </div>
            <div class="comn-baike-position clearfix">
                <div class="fl map"></div>
                <div class="fl position-describe">
                    <h2>附近场地</h2>
                    <ul class="clearfix position-describe-ul">
                        <li class="clearfix">
                            <div class="text">
                                <h6><a href="">上海奢居会休闲会所</a></h6>
                                <p>距离·300m</p>
                            </div>
                            <div class="pic">
                                <a href=""><img src="img/baike.v1.0/img_map1.jpg"></a>
                            </div>
                        </li>
                        <li class="clearfix">
                            <div class="text">
                                <h6><a href="">上海奢居会休闲会所</a></h6>
                                <p>距离·300m</p>
                            </div>
                            <div class="pic">
                                <a href=""><img src="img/baike.v1.0/img_map1.jpg"></a>
                            </div>
                        </li>
                        <li class="clearfix">
                            <div class="text">
                                <h6><a href="">上海奢居会休闲会所</a></h6>
                                <p>距离·300m</p>
                            </div>
                            <div class="pic">
                                <a href=""><img src="img/baike.v1.0/img_map1.jpg"></a>
                            </div>
                        </li>
                        <li class="clearfix">
                            <div class="text">
                                <h6><a href="">上海奢居会休闲会所</a></h6>
                                <p>距离·300m</p>
                            </div>
                            <div class="pic">
                                <a href=""><img src="img/baike.v1.0/img_map1.jpg"></a>
                            </div>
                        </li>
                    </ul>
                    <a class="position-more-btn" href="">查看更多周边场地</a>
                </div><!--position-describe-end-->
            </div><!--comn-baike-position-end-->
        </div><!--baike-facilities-end-->

        <!--场地简介-开始-->
        <div class="comn" id="nv-areaBrief">
            <div class="comn-title clearfix">
                <i class="icon-intro"></i><span>场地简介</span>
            </div>
            <div class="comn-baike-intro clearfix">
                <p>墨西哥艺术中心原是上海世博园的墨西哥馆，占地约800平方米，艺术中心外观是由色彩斑斓的风筝和碧绿的草地组成的“风筝森林”，“风筝”的支撑柱上布满小孔，会喷出清凉的水汽。艺术中心内部场地宽阔，可容纳400人，装修时尚又富有设计感，菜肴可口美味，适合举办年会等活动。</p>
                <p>色彩斑斓的“风筝森林”<br>
                   云Space为您提供墨西哥活动场地及活动所需的一切配套服务，为您带来一站式的活动定制体验。灯光、音响设备一应俱全，更搭配精美的菜肴，满足您的各种定制需求。更能体验两国的古老文化风情，年会也会变的更与众不同，仿佛身处奇境。这样的年会还不心动行动？</p>
                <p>墨西哥馆是一座由“风筝”组成的奇幻世界。在墨西哥官方语言西班牙语中，“风筝”一词来自纳瓦特尔语中的“papalotl”，原意为“蝴蝶”。在墨西哥，风筝代表人们对未来美好生活的期盼。而风筝又起源于中国，它将作为中国和墨西哥两种古老文化中的共同因素，意喻未来的无限腾飞与发展，也作为两国友好进程的象征和见证。</p>
            </div>
        </div><!--baike-intro-end-->

        <!--租场地-开始-->
        <div class="comn" id="nv-hireArea">
            <div class="comn-title clearfix">
                <i class="icon-lease"></i><span>租场地</span>
            </div>
            <table class="comn-baike-lease-table clearfix" cellpadding="0" cellspacing="0">
                <tr>
                    <th>名称</th>
                    <th>面积（㎡）</th>
                    <th>人数</th>
                    <th>参考价（/天）</th>
                    <th>其他</th>
                </tr>
                <tr>
                    <td><a href="">奢居会空间派对会所-#1</a></td>
                    <td>632</td>
                    <td>150~299</td>
                    <td>￥7,857</td>
                    <td><a class="btn" href="">查看详情</a></td>
                </tr>
                <tr>
                    <td><a href="">奢居会空间派对会所会所-#1</a></td>
                    <td>632</td>
                    <td>150~299</td>
                    <td>￥7,857</td>
                    <td><a class="btn" href="">查看详情</a></td>
                </tr>
                <tr>
                    <td><a href="">奢居会空间派对会所-#1</a></td>
                    <td>632</td>
                    <td>150~299</td>
                    <td>￥7,857</td>
                    <td><a class="btn" href="">查看详情</a></td>
                </tr>
                <tr>
                    <td><a href="">奢居会空间派对会所-#1</a></td>
                    <td>632</td>
                    <td>150~299</td>
                    <td>￥7,857</td>
                    <td><a class="btn" href="">查看详情</a></td>
                </tr>
                <tr>
                    <td><a href="">奢居会空间派对会所-#1</a></td>
                    <td>632</td>
                    <td>150~299</td>
                    <td>￥7,857</td>
                    <td><a class="btn" href="">查看详情</a></td>
                </tr>
                <tr>
                    <td><a href="">奢居会空间派对会所-#1</a></td>
                    <td>632</td>
                    <td>150~299</td>
                    <td>￥7,857</td>
                    <td><a class="btn" href="">查看详情</a></td>
                </tr>
                <tr>
                    <td><a href="">奢居会空间派对会所-#1</a></td>
                    <td>632</td>
                    <td>150~299</td>
                    <td>￥7,857</td>
                    <td><a class="btn" href="">查看详情</a></td>
                </tr>
            </table>
        </div><!--baike-lease-end-->
    </div>

    <div class="side-nav" >
        {*<a href="javascript:;" class="inquiry-order" id="inquiryOrder">*}
        {*<span class="circle1">15</span>*}
        {*</a>*}
        <div class="title">
            <h6>百科词条目录</h6>
            {*<p></p>*}
        </div>
        <ul class="side-list clearfix" id="nav">
            {*<li class="list1 lione current" >*}
                {*<a href="#nv-story">*}
                    {*<span></span>*}
                    {*<p>品牌故事</p>*}
                {*</a>*}
                {*<span class="line"></span>*}
            {*</li>*}
            <li class="list2 lione current">
                <a href="#nv-baseInfo">
                    <span></span>
                    <p>基本信息</p>
                </a>
                <span class="line"></span>
            </li>
            <li class="list3 lione">
                <a href="#nv-facilities">
                    <span></span>
                    <p>配套设施</p>
                </a>
                <span class="line"></span>
            </li>
            <li class="list4 lione">
                <a href="#nv-position">
                    <span></span>
                    <p>场地位置</p>
                </a>
                <span class="line"></span>
            </li>
            <li class="list5 lione">
                <a href="#nv-areaBrief">
                    <span></span>
                    <p>场地简介</p>
                </a>
                <span class="line"></span>
            </li>
            <li class="list6 lione">
                <a href="#nv-hireArea">
                    <span></span>
                    <p>租场地</p>
                </a>
            </li>
        </ul><!--nav-end-->
    </div>
</div>
{include file="Web_Static::inc/public_space.tpl"}
{include file="Web_Static::inc/html_footer.tpl"}
{static "core/yunspace.js"}
</body>
</html>