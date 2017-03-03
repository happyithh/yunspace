<!DOCTYPE html>
<html>
<head>
    {include file="Web_Static::v2.0/html_head.tpl"}
    {static "home.v3.0/data-picker.css"}
    {*{static "home.v2.0/homepage.css"}*}
    {static "home.v2.0/homepage.js"}
    {static "home.v3.0/homepage.js"}
    {static "home.v3.0/home.css"}

    <link rel="stylesheet" href="plugins/ionicons-master/css/ionicons.min.css">
    {*<link rel="stylesheet" href="plugins/jquery-ui/jquery-ui.css">*}
</head>
<body yun-src="/yun/plugins/">
{include file="Web_Static::v2.0/html_header1.tpl"}
{include file="Web_Static::home.v3.0/carousel1.tpl"}

<div class="cover-body hide"></div>



<div class="demand-body demand-one">
    <div class="demand-close"><span class="ion-close"></span></div>
    <div style="position: relative;height:100%">

        <div class="demand-submit">
            {*<form action=""  data-validate="true"  yun="form-validate/form-validate.js::formSubmit" yun-error=".d-s-error">*}
            <div class="ajax-form"  data-validate="true" style="height:450px">
                <div class="d-s-body">
                    <div class="d-s-form" style="position: absolute;top:0px;width:50%;left:25%">
                        <div class="d-s-title">
                            我要办活动
                        </div>
                        <div class="clear"></div>
                    </div>
                    <div class="show-demand" style="margin-bottom: 70px;margin-top:50px;">

                        {*<div class="demand-full demand-first">*}
                            <div class="d-s-form" style="color:#999999;font-size:12px;margin:10px 0px;">
                                留下你的联系方式
                            </div>
                            <div class="d-s-form">
                                <div class="d-s-name"><i style="color:#ff0000">*</i>&nbsp;&nbsp;&nbsp;联系人</div>
                                <div class="d-s-input">
                                    <input type="text" data-validate="true" data-error="请填写联系人"  yun="form-validate/form-validate.js::typeValidate@keyup" name="username" placeholder="请填写联系人"/>
                                </div>
                                <div class="clear"></div>
                            </div>
                            <div class="d-s-form">
                                <div class="d-s-name"><i style="color:#ff0000">*</i>&nbsp;&nbsp;&nbsp;手机号码</div>
                                <div class="d-s-input">
                                    <input type="text" yun="form-validate/form-validate.js::typeValidate@keyup" data-error="请填写11位的手机号码" data-length="11" placeholder="请填写11位的手机号码"
                                           name="phone"     yun-type="phone"  yun-error="" yun-style="fontSize:25px,position:absolute,right:5px,line-height:30px,color:#ff0000" data-validate="true"/>
                                </div>
                                <div class="clear"></div>
                            </div>

                            <div class="d-s-form">
                                <div class="d-s-name"><i style="color:#ff0000"></i>人数</div>
                                <div class="d-s-input">
                                    <input type="text" class="per-in hide select-input person-input" name="person_num" value="50人"/>
                                    {*<input type="text" class="hide select-input place-input" data-validate="true" data-error="请将预算范围填写完整" name="pre_range"/>*}
                                    <div class="d-s-input-val select-click select4"><div style="font-size:14px;"  class="par1">50人</div><span class="ion-arrow-down-b p-r-icon" style="color:#c5c5c5"></span></div>
                                    <span class="down"></span>
                                    <div class="drop-down-home dropDown pre-range hide" style="background:rgba(255,255,255,1);z-index:12000!important;border-color: #c4c4c4 ;border-top:none;margin-left:-1px;"  data-drop="1">
                                        <ul>
                                            <li>50人</li>
                                            <li>100人</li>
                                            <li>300人</li>
                                            <li>500人</li>
                                            <li>1000人</li>
                                            <li>2000+人</li>
                                        </ul>
                                    </div>
                                </div>
                                <div class="clear"></div>
                            </div>
                            <div class="d-s-form">
                                <div class="d-s-name"><i style="color:#ff0000"></i>活动类型</div>
                                <div class="d-s-input">
                                    {*<input type="text" data-validate="true" data-error="请填写活动类型" class="act-out" name="activity_name"/>*}
                                    <input type="text" class="act-in hide select-input  cate-input" name="activity_name" value="路演/展览/发布会"/>
                                    <div class="d-s-input-val select-click select4" style="z-index:1"><div style="font-size:14px"  class="par2">路演/展览/发布会</div><span class="ion-arrow-down-b p-r-icon"  style="color:#c5c5c5"></span></div>
                                    <span class="down"></span>
                                    <div class="drop-down-home dropDown pre-range hide" style="background:rgba(255,255,255,1);z-index:12000;border-color: #c4c4c4 ;border-top:none;margin-left:-1px;height:204px;"  data-drop="1">
                                        <ul>
                                            <li>派对/典礼/沙龙</li>
                                            <li>晚会/年会/演出</li>
                                            <li>路演/展览/发布会</li>
                                            <li>会议/讲座</li>
                                            <li>团建/拓展</li>
                                        </ul>
                                    </div>
                                </div>
                                <div class="clear"></div>
                            </div>

                            <div class="d-s-form">
                                <div class="form-coder">
                                    <img src="img/home.v3.0/space_fwh.jpg" alt="">
                                </div>
                                <div class="form-coder">
                                    <p>举起手机，扫一扫关注<b>云·SPACE</b>微信公众号随时随地获取方案。</p>
                                </div>
                            </div>

                            <div class="d-s-form" style="margin-bottom: 10px;">
                                <div class="d-s-error">
                                </div>
                                <div class="clear"></div>
                            </div>
                        {*</div>*}
                    </div>

                    <div class="d-s-form bottom-submit" style="margin-top: 20px;position: absolute;bottom:0px;width:70%;left:50%;margin-left:-35%;">
                        <div class="d-s-button" style="width:100%">
                            <button yun="form-validate/form-validate.js::ajaxSubmit@click" yun-url="" yun-ajax="demand"
                                    yun-error=".d-s-error" yun-form=".ajax-form" data-id="0">提交</button>
                        </div>
                        <div class="clear"></div>
                    </div>
                </div>
            {*</form>*}
            </div>
        </div>
    </div>
</div>

<div class="demand-body demand-two" style="top:-130%;">
    <div class="demand-close"><span class="ion-close"></span></div>
    <div style="position: relative;height:100%">
        <div class="demand-submit">
            {*<form action=""  data-validate="true"  yun="form-validate/form-validate.js::formSubmit" yun-error=".d-s-error">*}
            <div class="ajax-form ajax-form1"  data-validate="true" style="height:450px;">
                <div class="d-s-body" style="height:330px;">
                    <div class="d-s-form" style="position: absolute;top:0px;width:50%;left:25%">
                        <div class="d-s-title" style="color:#06e1e1">
                            <span class="ion-ios-lightbulb-outline" style="font-size: 25px;"></span>&nbsp;&nbsp;提交成功
                        </div>

                        <div class="clear"></div>
                    </div>
                    <div class="d-s-form submit-text"  style="color:#999999;font-size:12px;margin:20px 0px;margin-top: 50px;">
                        请完善您的活动信息，云·SPACE场地报价系统将在 <span style="color:#59ebeb;font-size:13px;">30分钟内</span>为您提供多份精准场地报价
                    </div>
                    <div class="show-demand show2" style="margin-bottom: 70px;margin-top:20px;padding-top: 20px;border-top:1px dashed #ddd;height: 400px;">
                    <iframe src="" style="border: 0px; width:100%;height:100%" class="iframe" id="home-frame" name="home-frame">
                        </iframe>
                    </div>
                    <div class="d-s-form bottom-submit  bottom-submit2" style="margin-top: 20px;position: absolute;bottom:0px;width:100%;left:0px;">
                        <div class="d-s-button" style="width:100%;padding-left: 10%">
                            <button yun="form-validate/form-validate.js::ajaxSubmit@click" yun-url="" yun-ajax="demand_next" style="width:50%;float:left;margin-left:15%"
                                    class="demand-ok"
                                    yun-error=".d-s-error" yun-form=".ajax-form" data-id="2">确认</button>
                        </div>
                        <div class="clear"></div>
                    </div>
                </div>
                {*</form>*}
            </div>
        </div>
    </div>
</div>

<div class="contain">
    <ul class="mao-all hide">
        <li><a href="#p1" class="mao">1F</a></li>
        <li><a href="#p2" class="mao">2F</a></li>
        <li><a href="#p3" class="mao">3F</a></li>
        <li><a href="#p4" class="mao">4F</a></li>
        <li><a href="#p5" class="mao">5F</a></li>
        <li><a href="#p6" class="mao">6F</a></li>
        <li><a href="#p7" class="mao">7F</a></li>
        <li><a href="" class="mao" style="line-height: 20px;">有奖活动</a></li>
    </ul>
    <div class="tag">
        <ul>
            <li>
                <a href="#p1" class="tag-link">
                    <div class="icon-tip">
                        <div class="t-l-icon">
                            <img src="img/home.v3.0/A1.png" alt="">
                        </div>
                        <div class="t-l-icon">
                            <img src="img/home.v3.0/B1.png" alt="">
                        </div>
                    </div>
                </a>
            </li>
            <li>
                <a href="#p2" class="tag-link">
                    <div class="icon-tip">
                        <div class="t-l-icon">
                            <img src="img/home.v3.0/A2.png" alt="">
                        </div>
                        <div class="t-l-icon">
                            <img src="img/home.v3.0/B2.png" alt="">
                        </div>
                    </div>
                </a>
            </li>
            <li>
                <a href="#p3" class="tag-link">
                    <div class="icon-tip">
                        <div class="t-l-icon">
                            <img src="img/home.v3.0/A3.png" alt="">
                        </div>
                        <div class="t-l-icon">
                            <img src="img/home.v3.0/B3.png" alt="">
                        </div>
                    </div>
                </a>
            </li>
            <li>
                <a href="#p4" class="tag-link">
                    <div class="icon-tip">
                        <div class="t-l-icon">
                            <img src="img/home.v3.0/A4.png" alt="">
                        </div>
                        <div class="t-l-icon">
                            <img src="img/home.v3.0/B4.png" alt="">
                        </div>
                    </div>
                </a>
            </li>
            <li>
                <a href="#p5" class="tag-link">
                    <div class="icon-tip">
                        <div class="t-l-icon">
                            <img src="img/home.v3.0/A5.png" alt="">
                        </div>
                        <div class="t-l-icon">
                            <img src="img/home.v3.0/B5.png" alt="">
                        </div>
                    </div>
                </a>
            </li>
            <li>
                <a href="#p6" class="tag-link">
                    <div class="icon-tip">
                        <div class="t-l-icon">
                            <img src="img/home.v3.0/A6.png" alt="">
                        </div>
                        <div class="t-l-icon">
                            <img src="img/home.v3.0/B6.png" alt="">
                        </div>
                    </div>
                </a>
            </li>
            <li>
                <a href="#p7" class="tag-link">
                    <div class="icon-tip">
                        <div class="t-l-icon">
                            <img src="img/home.v3.0/A7.png" alt="">
                        </div>
                        <div class="t-l-icon">
                            <img src="img/home.v3.0/B7.png" alt="">
                        </div>
                    </div>
                </a>
            </li>
        </ul>
    </div>
    <div class="ad-1">
        <a href=""><img src="img/home.v3.0/ad.png" alt=""></a>
    </div>
    <div class="recommend-product">
        <div id="p1" class="p-mao"></div>
        <div class="rec-header">
            <p class="rec-title">1F&nbsp;精心推荐 <span>&nbsp;一键搞定一场活动</span></p>
            <div class="rec-header-img">
                <img src="img/home.v3.0/line.jpg" alt="">
            </div>
        </div>
        <div class="rec-img-1">
            <a href="">
                <div class="rec-img-1-img relatives cover-t">
                    <div class="cov"></div>
                    <div class="cov-title">活动精选</div>
                    <div class="cov-des">回忆是道永不退色的风景，，默默无闻而遥遥独立在你记忆最深处。</div>
                    <div class="cov-btn">
                        <a href="">进入活动精选</a>
                    </div>
                    <img src="img/home.v3.0/01.jpg" alt="">
                </div>
            </a>
            <ul class="rec-img-1-list relatives">
                <li><a href="">发布会</a><img src="img/home.v3.0/hot.png" alt=""></li>
                <li><a href="">路演</a></li>
                <li><a href="">沙龙</a></li>
                <li><a href="">年会</a></li>
                <li><a href="">派对就会</a></li>
                <li><a href="">会议培训</a></li>
            </ul>
        </div>
        <div class="rec-img-2">
            <a href="">
                <div class="rec-img-2-1 relatives cover-t">
                    <div class="cov"></div>
                    <div class="cov-title">空间精选</div>
                    <div class="cov-des">回忆是道永不退色的风景，它都是那样温情靓丽，它总是静静地贴在你的心里，默默无闻而遥遥独立在你记忆最深处。</div>
                    <div class="cov-btn">
                        <a href="">进入空间精选</a>
                    </div>
                    <img src="img/home.v3.0/02.jpg" alt="">
                </div>
            </a>
            <a href="">
                <div class="rec-img-2-2 relatives cover-t">
                    <div class="cov"></div>
                    <div class="cov-title">经典案例</div>
                    <div class="cov-des">回忆是道永不退色的风景，它都是那样温情靓丽，它总是静静地贴在你的心里，默默无闻而遥遥独立在你记忆最深处。</div>
                    <div class="cov-btn">
                        <a href="">进入经典案例</a>
                    </div>
                    <img src="img/home.v3.0/03.jpg" alt="">
                </div>
            </a>
            <a href="">
                <div class="rec-img-2-3 relatives cover-t">
                    <div class="cov"></div>
                    <div class="cov-title">艺术分享</div>
                    <div class="cov-des">回忆是道永不退色的风景，它都是那样温情靓丽，它总是静静地贴在你的心里，默默无闻而遥遥独立在你记忆最深处。</div>
                    <div class="cov-btn">
                        <a href="">进入艺术分享</a>
                    </div>
                    <img src="img/home.v3.0/04.jpg" alt="">
                </div>
            </a>
        </div>
        <div class="rec-img-3">
            <a href="">
                <div class="rec-img-3-1 relatives cover-t">
                    <div class="cov"></div>
                    <div class="cov-title">城市榜单
                    </div>
                    <div class="cov-des">回忆是道永不退色的风景，它都是那样温情靓丽，它总是静静地贴在你的心里，默默无闻而遥遥独立在你记忆最深处。</div>
                    <div class="cov-btn">
                        <a href="">进入城市榜单</a>
                    </div>
                    <img src="img/home.v3.0/05.jpg" alt="">
                </div>
            </a>
            <a href="">
                <div class="rec-img-3-2 relatives cover-t">
                    <div class="cov"></div>
                    <div class="cov-title">嗨·空间</div>
                    <div class="cov-des">回忆是道永不退色的风景，它都是那样温情靓丽，它总是静静地贴在你的心里，默默无闻而遥遥独立在你记忆最深处。</div>
                    <div class="cov-btn">
                        <a href="">进入嗨·空间</a>
                    </div>
                    <img src="img/home.v3.0/06.jpg" alt="">
                </div>
            </a>
        </div>
    </div>
    <div class="product-con">
        <div class="p-mao" id="p2"></div>
        <div class="product-con-header">
            <div class="p-c-h-title">
                <p style="line-height: 60px;font-size: 25px;margin-left: 0px;color:#f3548e">2F&nbsp;</p>
                <div style="float:left;padding-top: 12px;font-size: 20px;">
                    <img src="img/home.v3.0/t2.png" alt="">
                </div>
                <p>
                    超值套餐
                </p>
            </div>
            <ul class="more-list">
                <li><a href="">发布会</a></li>
                <li><a href="">亲子</a></li>
                <li><a href="">沙龙</a></li>
                <li><a href="">年会</a></li>
                <li><a href="">派对酒会</a></li>
                <li>
                    <a href="">
                        更多 <span class="ion-ios-arrow-right"></span><span class="ion-ios-arrow-right"></span>
                    </a>
                </li>
            </ul>
        </div>
        <ul class="pro-con-body">
            <li>
                <a href="">
                    <img src="img/home.v3.0/list.png" alt="">
                    <div class="product-name-title">
                    </div>
                    <div class="p-name">
                        <p class="p-n-d-1">汽车百年庆典</p>
                        <p class="p-n-d-2">液体震撼&nbsp;&nbsp;看遍风景</p>
                    </div>
                    <div class="p-n-d-3 hide">
                        {*当价格不存在时*}
                        <a href="">查看详情</a>
                    </div>
                </a>
            </li>
            <li>
                <a href="">
                    <img src="img/home.v3.0/list.png" alt="">
                    <div class="product-name-title">
                    </div>
                    <div class="p-name">
                        <p class="p-n-d-1">汽车百年庆典</p>
                        <p class="p-n-d-2">液体震撼&nbsp;&nbsp;看遍风景</p>
                    </div>
                    <div class="p-n-d-3 hide">￥ 1,500</div>
                </a>
            </li>
            <li>
                <a href="">
                    <img src="img/home.v3.0/list.png" alt="">
                    <div class="product-name-title">
                    </div>
                    <div class="p-name">
                        <p class="p-n-d-1">汽车百年庆典</p>
                        <p class="p-n-d-2">液体震撼&nbsp;&nbsp;看遍风景</p>
                    </div>
                    <div class="p-n-d-3 hide">￥ 1,500</div>
                </a>
            </li>
            <li>
                <a href="">
                    <img src="img/home.v3.0/list.png" alt="">
                    <div class="product-name-title">
                    </div>
                    <div class="p-name">
                        <p class="p-n-d-1">汽车百年庆典</p>
                        <p class="p-n-d-2">液体震撼&nbsp;&nbsp;看遍风景</p>
                    </div>
                    <div class="p-n-d-3 hide">￥ 1,500</div>
                </a>
            </li>
        </ul>
    </div>
    <div class="product-con">
        <div id="p3" class="p-mao"></div>
        <div class="product-con-header">
            <div class="p-c-h-title">
                <p style="line-height: 60px;font-size: 25px;margin-left: 0px;color:#7dc346">3F&nbsp;</p>
                <div style="float:left;padding-top: 12px;">
                    <img src="img/home.v3.0/t3.png" alt="">
                </div>
                <p style="color:#7dc346">
                    秀场展馆
                </p>
            </div>
            <ul class="more-list">
                <li><a href="">发布会</a></li>
                <li><a href="">亲子</a></li>
                <li><a href="">沙龙</a></li>
                <li><a href="">年会</a></li>
                <li><a href="">派对酒会</a></li>
                <li>
                    <a href="">
                        更多 <span class="ion-ios-arrow-right"></span><span class="ion-ios-arrow-right"></span>
                    </a>
                </li>
            </ul>
        </div>
        <ul class="pro-con-body">
            <li>
                <a href="">
                    <img src="img/home.v3.0/list.png" alt="">
                    <div class="product-name-title">
                    </div>
                    <div class="p-name">
                        <p class="p-n-d-1">汽车百年庆典</p>
                        <p class="p-n-d-2">液体震撼&nbsp;&nbsp;看遍风景</p>
                    </div>
                    <div class="p-n-d-3 hide">￥ 1,500</div>
                </a>
            </li>
            <li>
                <a href="">
                    <img src="img/home.v3.0/list.png" alt="">
                    <div class="product-name-title">
                    </div>
                    <div class="p-name">
                        <p class="p-n-d-1">汽车百年庆典</p>
                        <p class="p-n-d-2">液体震撼&nbsp;&nbsp;看遍风景</p>
                    </div>
                    <div class="p-n-d-3 hide">￥ 1,500</div>
                </a>
            </li>
            <li>
                <a href="">
                    <img src="img/home.v3.0/list.png" alt="">
                    <div class="product-name-title">
                    </div>
                    <div class="p-name">
                        <p class="p-n-d-1">汽车百年庆典</p>
                        <p class="p-n-d-2">液体震撼&nbsp;&nbsp;看遍风景</p>
                    </div>
                    <div class="p-n-d-3 hide">￥ 1,500</div>
                </a>
            </li>
            <li>
                <a href="">
                    <img src="img/home.v3.0/list.png" alt="">
                    <div class="product-name-title">
                    </div>
                    <div class="p-name">
                        <p class="p-n-d-1">汽车百年庆典</p>
                        <p class="p-n-d-2">液体震撼&nbsp;&nbsp;看遍风景</p>
                    </div>
                    <div class="p-n-d-3 hide">￥ 1,500</div>
                </a>
            </li>
        </ul>
    </div>
    <div class="ad-1">
        <a href=""><img src="img/home.v3.0/ad.png" alt=""></a>
    </div>
    <div class="product-con">
        <div id="p4" class="p-mao"></div>
        <div class="product-con-header">
            <div class="p-c-h-title">
                <p style="line-height: 60px;font-size: 25px;margin-left: 0px;color:#feaf88">4F&nbsp;</p>
                <div style="float:left;padding-top: 12px;">
                    <img src="img/home.v3.0/t4.png" alt="">
                </div>
                <p style="color:#feaf88">
                    商业广场
                </p>
            </div>
            <ul class="more-list">
                <li><a href="">发布会</a></li>
                <li><a href="">亲子</a></li>
                <li><a href="">沙龙</a></li>
                <li><a href="">年会</a></li>
                <li><a href="">派对酒会</a></li>
                <li>
                    <a href="">
                        更多 <span class="ion-ios-arrow-right"></span><span class="ion-ios-arrow-right"></span>
                    </a>
                </li>
            </ul>
        </div>
        <ul class="pro-con-body">
            <li>
                <a href="">
                    <img src="img/home.v3.0/list.png" alt="">
                    <div class="product-name-title">
                    </div>
                    <div class="p-name">
                        <p class="p-n-d-1">汽车百年庆典</p>
                        <p class="p-n-d-2">液体震撼&nbsp;&nbsp;看遍风景</p>
                    </div>
                    <div class="p-n-d-3 hide">￥ 1,500</div>
                </a>
            </li>
            <li>
                <a href="">
                    <img src="img/home.v3.0/list.png" alt="">
                    <div class="product-name-title">
                    </div>
                    <div class="p-name">
                        <p class="p-n-d-1">汽车百年庆典</p>
                        <p class="p-n-d-2">液体震撼&nbsp;&nbsp;看遍风景</p>
                    </div>
                    <div class="p-n-d-3 hide">￥ 1,500</div>
                </a>
            </li>
            <li>
                <a href="">
                    <img src="img/home.v3.0/list.png" alt="">
                    <div class="product-name-title">
                    </div>
                    <div class="p-name">
                        <p class="p-n-d-1">汽车百年庆典</p>
                        <p class="p-n-d-2">液体震撼&nbsp;&nbsp;看遍风景</p>
                    </div>
                    <div class="p-n-d-3 hide">￥ 1,500</div>
                </a>
            </li>
            <li>
                <a href="">
                    <img src="img/home.v3.0/list.png" alt="">
                    <div class="product-name-title">
                    </div>
                    <div class="p-name">
                        <p class="p-n-d-1">汽车百年庆典</p>
                        <p class="p-n-d-2">液体震撼&nbsp;&nbsp;看遍风景</p>
                    </div>
                    <div class="p-n-d-3 hide">￥ 1,500</div>
                </a>
            </li>
        </ul>
    </div>
    <div class="product-con">
        <div id="p5" class="p-mao"></div>
        <div class="product-con-header">
            <div class="p-c-h-title">
                <p style="line-height: 60px;font-size: 25px;margin-left: 0px;color:#4fddaf">5F&nbsp;</p>
                <div style="float:left;padding-top: 12px;">
                    <img src="img/home.v3.0/t5.png" alt="">
                </div>
                <p style="color:#4fddaf">
                    高端会所
                </p>
            </div>
            <ul class="more-list">
                <li><a href="">发布会</a></li>
                <li><a href="">亲子</a></li>
                <li><a href="">沙龙</a></li>
                <li><a href="">年会</a></li>
                <li><a href="">派对酒会</a></li>
                <li>
                    <a href="">
                        更多 <span class="ion-ios-arrow-right"></span><span class="ion-ios-arrow-right"></span>
                    </a>
                </li>
            </ul>
        </div>
        <ul class="pro-con-body">
            <li>
                <a href="">
                    <img src="img/home.v3.0/list.png" alt="">
                    <div class="product-name-title">
                    </div>
                    <div class="p-name">
                        <p class="p-n-d-1">汽车百年庆典</p>
                        <p class="p-n-d-2">液体震撼&nbsp;&nbsp;看遍风景</p>
                    </div>
                    <div class="p-n-d-3 hide">￥ 1,500</div>
                </a>
            </li>
            <li>
                <a href="">
                    <img src="img/home.v3.0/list.png" alt="">
                    <div class="product-name-title">
                    </div>
                    <div class="p-name">
                        <p class="p-n-d-1">汽车百年庆典</p>
                        <p class="p-n-d-2">液体震撼&nbsp;&nbsp;看遍风景</p>
                    </div>
                    <div class="p-n-d-3 hide">￥ 1,500</div>
                </a>
            </li>
            <li>
                <a href="">
                    <img src="img/home.v3.0/list.png" alt="">
                    <div class="product-name-title">
                    </div>
                    <div class="p-name">
                        <p class="p-n-d-1">汽车百年庆典</p>
                        <p class="p-n-d-2">液体震撼&nbsp;&nbsp;看遍风景</p>
                    </div>
                    <div class="p-n-d-3 hide">￥ 1,500</div>
                </a>
            </li>
            <li>
                <a href="">
                    <img src="img/home.v3.0/list.png" alt="">
                    <div class="product-name-title">
                    </div>
                    <div class="p-name">
                        <p class="p-n-d-1">汽车百年庆典</p>
                        <p class="p-n-d-2">液体震撼&nbsp;&nbsp;看遍风景</p>
                    </div>
                    <div class="p-n-d-3 hide">￥ 1,500</div>
                </a>
            </li>
        </ul>
    </div>
    <div class="ad-1">
        <a href=""><img src="img/home.v3.0/ad.png" alt=""></a>
    </div>
    <div class="product-con">
        <div id="p6" class="p-mao"></div>
        <div class="product-con-header">
            <div class="p-c-h-title">
                <p style="line-height: 60px;font-size: 25px;margin-left: 0px;color:#fa3458">6F&nbsp;</p>
                <div style="float:left;padding-top: 12px;">
                    <img src="img/home.v3.0/t6.png" alt="">
                </div>
                <p style="color:#fa3458">
                    配套服务
                </p>
            </div>
            <ul class="more-list">
                <li><a href="">发布会</a></li>
                <li><a href="">亲子</a></li>
                <li><a href="">沙龙</a></li>
                <li><a href="">年会</a></li>
                <li><a href="">派对酒会</a></li>
                <li>
                    <a href="">
                        更多 <span class="ion-ios-arrow-right"></span><span class="ion-ios-arrow-right"></span>
                    </a>
                </li>
            </ul>
        </div>
        <ul class="pro-con-body">
            <li>
                <a href="">
                    <img src="img/home.v3.0/list.png" alt="">
                    <div class="product-name-title">
                    </div>
                    <div class="p-name">
                        <p class="p-n-d-1">汽车百年庆典</p>
                        <p class="p-n-d-2">液体震撼&nbsp;&nbsp;看遍风景</p>
                    </div>
                    <div class="p-n-d-3 hide">￥ 1,500</div>
                </a>
            </li>
            <li>
                <a href="">
                    <img src="img/home.v3.0/list.png" alt="">
                    <div class="product-name-title">
                    </div>
                    <div class="p-name">
                        <p class="p-n-d-1">汽车百年庆典</p>
                        <p class="p-n-d-2">液体震撼&nbsp;&nbsp;看遍风景</p>
                    </div>
                    <div class="p-n-d-3 hide">￥ 1,500</div>
                </a>
            </li>
            <li>
                <a href="">
                    <img src="img/home.v3.0/list.png" alt="">
                    <div class="product-name-title">
                    </div>
                    <div class="p-name">
                        <p class="p-n-d-1">汽车百年庆典</p>
                        <p class="p-n-d-2">液体震撼&nbsp;&nbsp;看遍风景</p>
                    </div>
                    <div class="p-n-d-3 hide">￥ 1,500</div>
                </a>
            </li>
            <li>
                <a href="">
                    <img src="img/home.v3.0/list.png" alt="">
                    <div class="product-name-title">
                    </div>
                    <div class="p-name">
                        <p class="p-n-d-1">汽车百年庆典</p>
                        <p class="p-n-d-2">液体震撼&nbsp;&nbsp;看遍风景</p>
                    </div>
                    <div class="p-n-d-3 hide">￥ 1,500</div>
                </a>
            </li>
        </ul>
    </div>
    <div class="product-con">
        <div id="p7" class="p-mao"></div>
        <div class="product-con-header">
            <div class="p-c-h-title">
                <p style="line-height: 60px;font-size: 25px;margin-left: 0px;color:#78c4dc">7F&nbsp;</p>
                <div style="float:left;padding-top: 14px;">
                    <img src="img/home.v3.0/t7.png" alt="">
                </div>
                <p style="color:#78c4dc">
                    活动攻略
                </p>
            </div>
            <ul class="more-list">
                <li><a href="">发布会</a></li>
                <li><a href="">亲子</a></li>
                <li><a href="">沙龙</a></li>
                <li><a href="">年会</a></li>
                <li><a href="">派对酒会</a></li>
                <li>
                    <a href="">
                        更多 <span class="ion-ios-arrow-right"></span><span class="ion-ios-arrow-right"></span>
                    </a>
                </li>
            </ul>
        </div>
        {*<div class="pro-con-body">*}
            <div class="function" style="margin-top: 20px;">
                <div class="function-content">
                    <div class="function-list">
                        <div class="function-title">活动方案</div>
                        <ul class="function-list-content">
                            <li><a href="#">实我有时候还是挺怀念从前那种候还是挺</a></li>
                            <li><a href="#">每张图的时钟显示那里用了纯黑色</a></li>
                            <li><a href="#">破坏了整个画面的青春活力感</a></li>
                            <li><a href="#">虽然没有现在这么高级，但是真的很可爱</a></li>
                        </ul>
                    </div>
                    <div class="function-list">
                        <div class="function-title">经典案例</div>
                        <ul class="function-list-content">
                            <li><a href="#">实我有时候还是挺怀念从前那种候还是挺</a></li>
                            <li><a href="#">每张图的时钟显示那里用了纯黑色</a></li>
                            <li><a href="#">破坏了整个画面的青春活力感</a></li>
                            <li><a href="#">虽然没有现在这么高级，但是真的很可爱</a></li>
                        </ul>
                    </div>
                    <div class="function-list">
                        <div class="function-title">经验分享</div>
                        <ul class="function-list-content">
                            <li><a href="#">实我有时候还是挺怀念从前那种候还是挺</a></li>
                            <li><a href="#">每张图的时钟显示那里用了纯黑色</a></li>
                            <li><a href="#">破坏了整个画面的青春活力感</a></li>
                            <li><a href="#">虽然没有现在这么高级，但是真的很可爱</a></li>
                        </ul>
                    </div>
                    <div class="function-list">
                        <div class="function-title">精选专题</div>
                        <ul class="function-list-content">
                            <li><a href="#">实我有时候还是挺怀念从前那种候还是挺</a></li>
                            <li><a href="#">每张图的时钟显示那里用了纯黑色</a></li>
                            <li><a href="#">破坏了整个画面的青春活力感</a></li>
                            <li><a href="#">虽然没有现在这么高级，但是真的很可爱</a></li>
                        </ul>
                    </div>
                </div>
            </div>
        {*</div>*}
    </div>

</div>
{*特别推荐*}





{*首页名企合作区*}
<div class="brand">
    <div class="brand-title">
        部分合作品牌
    </div>
    <div class="brand-content">
        <img src="img/home.v2.0/newbrand.jpg">
    </div>
</div>

{*提示弹出框*}
{*<div class="hint" id="hint">*}
    {*<div class="hint-center">*}
        {*<div class="hit-img">*}
            {*<img src="img/home.v2.0/icon3.png">*}
        {*</div>*}
        {*<div class="hint-word">*}
            {*<p class="hint-word1">提交成功</p>*}

            {*<p class="hint-word2">工作人员将会在30分钟内与您电话联系</p>*}
        {*</div>*}
        {*<div class="clear"></div>*}
    {*</div>*}
    {*<div class="hint-close">*}
        {*<a href="#"> 关闭</a>*}
    {*</div>*}
{*</div>*}
<div class="dayer2" id="dayer2"></div>
<div class="link-outside">
    <div class="link">
        <p class="link-left">友情链接：</p>
        <ul class="link-right">
            <li><a href="http://www.jd.com/">京东商城</a></li>
            <li><a href="http://www.qq.com/">腾讯网</a></li>
            <li><a href="#">石油公司</a></li>
            <li><a href="#">中国石油化工国</a></li>
            <li><a href="#">埃克森美孚</a></li>
            <li><a href="#">英国石油</a></li>
            <li><a href="#">国家电网公司</a></li>
            <li><a href="#">英国石油</a></li>
            <li><a href="#">大众公司</a></li>
            <li><a href="#">非田汽车公司</a></li>
        </ul>
        <div class="clear"></div>
    </div>
</div>
{include file="Web_Static::v2.0/html_footer.tpl"}
{static "core/yunspace.js"}
<script src="plugins/jquery-ui/jquery-ui.min.js"></script>
</body>
</html>