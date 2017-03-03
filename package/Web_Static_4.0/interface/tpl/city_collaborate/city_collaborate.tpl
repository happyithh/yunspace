<!DOCTYPE html>
<html lang="en">
<head>
    {include file="Web_Static::v4.0/html_goto_mobile.tpl" url="m/city_collaborate"}
    {include file="Web_Static::inc/head_meta.tpl"}
    {static "articles/article.css"}
    {static "city_collaborate_pc/city_collaborate.css"}
</head>
<body data-sid="{$page->baikeInfo['id']}"  yun="city_collabrate/city_collabrate.js::init">
{include file="Web_Static::inc/header_1.tpl"}
<div class="wrapper">
    <div class="crumb">
        <a href="{$_home}">首页</a>{if $page->baikeInfo['space_name']}> <a href="{$_home}site/{Func_Url::str_urlencode($page->baikeInfo['space_name'])}">{$page->baikeInfo['space_name']}{/if}</a>&gt;<a href="colbrt" class="active">城市合伙人</a>
    </div>
</div>

<!--banner部分-->
<div class="colbrt-banner-bg">
    <div class="btn-wrapper">
        <div class="opacity-bg"></div>
        <a class="btn-text" href="{$_home}join/join">立即加入</a>
    </div>
</div>

<!--数据统计部分-->
<div class="colbrt-comn colbrt-comn-air">
    <div class="colbrt-comn-title">
        <h2>国内商业地产空间Airbnb</h2>
        <h6>集线上空间展示、管理、预订为一体，配合线下顾问一对一服务，帮助活动方快速找到特色场地举办活动，<br>提升活动品质与品牌形象！</h6>
    </div>
    <ul class="comn-air-cont clearfix" id="data-two">
        <li>
            <div class="blue data-p1" data-num="70">0<span></span></div>
            <p>月均访问量（PV）</p>
        </li>
        <li>
            <div class="blue data-p1" data-num="6000">0<span></span></div>
            <p>月均客户订单</p>
        </li>
        <li>
            <div class="blue data-p1" data-num="5">0<span></span></div>
            <p>加盟场地</p>
        </li>
        <li>
            <div class="blue data-p1" data-num="15">0<span></span></div>
            <p>合作用户</p>
        </li>
    </ul>
    <p class="number">平台交易金额<span>数十亿</span></p>
    <ul class="ul-icon-line">
        <li style="height: 35px;left: 14px"></li>
        <li style="height: 62px;left: 76px"></li>
        <li style="height: 80px;left: 138px"></li>
        <li style="height: 100px;left: 202px"></li>
        <li style="height: 125px;left: 262px"></li>
    </ul>
</div>

<!--4大优势部分-->
<div class="colbrt-comn colbrt-comn-adg blue">
    <div class="colbrt-comn-title white">
        <h2>平台4大优势</h2>
        <h6>全国性资源共享，祝您打造超强市场竞争力！</h6>
    </div>
    <div class="comn-adg-cont-wrap clearfix">
        <ul class="comn-adg-cont clearfix">
            <li>
                <div class="img"><img src="img/city_collaborate/img-adg1.png"></div>
                <div class="text">
                    <h3>大数据资源整合、匹配</h3>
                    <p>全面整合场地及供应商资源，精准匹配需求，海量订单快速直达代理商。</p>
                </div>
            </li>
            <li>
                <div class="img"><img src="img/city_collaborate/img-adg2.png"></div>
                <div class="text">
                    <h3>O2O专业经验</h3>
                    <p>云SPACE突破了传统活动资源不清晰、价格不透明等缺陷，为活动生态系统创造更健康的环境和市场。</p>
                </div>
            </li>
            <li>
                <div class="img"><img src="img/city_collaborate/img-adg3.png"></div>
                <div class="text">
                    <h3>紧密的客户关系</h3>
                    <p>多样化需求快速匹配，全方位服务支持，极大提高用户满意度，有效提升活跃度，客户关系更紧密。</p>
                </div>
            </li>
            <li>
                <div class="img"><img src="img/city_collaborate/img-adg4.png"></div>
                <div class="text">
                    <h3>线下活动执行培训</h3>
                    <p>丰富的线下活动经验和完善的服务是活动质量的保障，不仅提升了活动质量，还有效地节省资源。</p>
                </div>
            </li>
        </ul>
    </div>
</div>

<!--5大合作支持部分-->
<div class="colbrt-comn colbrt-comn-support">
    <div class="colbrt-comn-title">
        <h2>5大合作支持</h2>
        <h6>总部全程扶持，最大降低风险，让您后顾无忧！</h6>
    </div>
    <div class="comn-support-cont">
        <img src="img/city_collaborate/colbrt-support.jpg">
    </div>
</div>

<!--招募条件部分-->
<div class="colbrt-comn colbrt-comn-condition blue">
    <div class="colbrt-comn-title white">
        <h2>招募条件</h2>
        <h6>争做城市的行业先锋，让您的创业更富有激情</h6>
    </div>
    <div class="comn-condition-cont clearfix">
        <div class="left fl clearfix">
            <h5>大力拓展全国二、三、四线城市</h5>
            <h3>招募全国<strong id="data-three" data-num="332">0</strong>个地级市分站的独家代理</h3>
        </div>
        <div class="right fl clearfix">
            <h5>招募条件</h5>
            <ul>
                <li>城市合伙人须为具备独立法人资格的企业</li>
                <li>团队人数超过7人以上</li>
                <li>掌握所在城市一定的商业活动场地及客户资源</li>
                <li>有做非标场地活动的策划及执行能力，并具有优秀活动案例</li>
                <li>对于云SPACE模式高度认可并愿意做资源共享</li>
            </ul>
        </div>
    </div>
</div>

<!--我们的合作品牌部分-->
<div class="colbrt-comn colbrt-comn-brand">
    <div class="colbrt-comn-title">
        <h2>我们的合作品牌</h2>
        <h6>优质的服务，受到众多世界500强企业的青睐</h6>
    </div>
    <div class="comn-brand-cont">
        <img src="img/city_collaborate/colbrt-logo.png">
    </div>
</div>

<!--立即加盟部分-->
<div class="colbrt-comn colbrt-comn-join">
    <div class="colbrt-comn-title">
        <h2>你的城市你做主,快来加盟吧！</h2>
        <h2>......</h2>
    </div>
    <a href="join" class="colbrt-btn-join">立即加入</a>
</div>


{include file="Web_Static::inc/public_space.tpl"}
{include file="Web_Static::inc/html_footer.tpl"}

{static "core/yunspace.js"}
</body>
</html>