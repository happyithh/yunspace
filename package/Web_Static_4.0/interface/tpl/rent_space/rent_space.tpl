<!DOCTYPE html>
<html lang="en">
<head>
    {include file="Web_Static::v4.0/html_goto_mobile.tpl" url="m/"}
    {include file="Web_Static::inc/head_meta.tpl"}
    {static "v4.0/common.css"}
    {static "v4.0/jquery-slide-fade.min.css"}
    {static "get_space/get_space.css"}
</head>
<body yun="get_space/get_space.js::init"  data-sid="{$_REQUEST['space_id']}">
    {include file="Web_Static::inc/header_rent_space.tpl"}
    <div yun="inc.v4.0/localData.js::pageController"></div>
    <div class="cate-nav" id="cate-nav">
        <ul class="cate-nav-list clearfix" id="cate-nav-list">
            <li><a href="http://www.yunspace.com.cn/spaces-category-tags/{urlencode('秀场展馆')}" class="cate-one" target="_blank"><p>秀场展馆</p></a></li>
            <li><a href="http://www.yunspace.com.cn/spaces-category-tags/{urlencode('商业广场')}" class="cate-two" target="_blank"><p>商业广场</p></a></li>
            <li><a href="http://www.yunspace.com.cn/spaces-category-tags/{urlencode('艺术馆画廊')}" class="cate-three" target="_blank"><p>艺术馆画廊</p></a></li>
            <li><a href="http://www.yunspace.com.cn/spaces-category-tags/{urlencode('星级酒店')}" class="cate-four" target="_blank"><p>星级酒店</p></a></li>
            <li><a href="http://www.yunspace.com.cn/spaces-category-tags/{urlencode('影院剧院')}" class="cate-five" target="_blank"><p>影院剧院</p></a></li>
            <li><a href="javascript:void(0)" class="cate-six" id="more-cate"><p>更多分类</p></a></li>
            <li><a href="javascript:void(0)" class="cate-seven"><p>咖啡馆书店</p></a></li>
            <li><a href="http://www.yunspace.com.cn/spaces-category-tags/{urlencode('体育场馆')}" class="cate-eight" target="_blank"><p>体育场馆</p></a></li>
            <li><a href="http://www.yunspace.com.cn/spaces-category-tags/{urlencode('餐厅酒吧')}" class="cate-nine" target="_blank"><p>餐厅酒吧</p></a></li>
            <li><a href="http://www.yunspace.com.cn/spaces-category-tags/{urlencode('高端会所')}" class="cate-ten" target="_blank"><p>高端会所</p></a></li>
            <li><a href="http://www.yunspace.com.cn/spaces-category-tags/{urlencode('会务中心')}" class="cate-eleven" target="_blank"><p>会务中心</p></a></li>
            <li><a href="http://www.yunspace.com.cn/spaces-category-tags/{urlencode('公共空间')}" class="cate-twelve" target="_blank"><p>公共空间</p></a></li>
            <li><a href="http://www.yunspace.com.cn/spaces-category-tags/{urlencode('社区学校')}" class="cate-thirteen" target="_blank"><p>社区学校</p></a></li>
            <li><a href="http://www.yunspace.com.cn/spaces-category-tags/{urlencode('特色场地')}" class="cate-fourteen" target="_blank"><p>特色场地</p></a></li>
            <li><a href="javascript:void(0)" class="cate-fifteen"><p>游船码头</p></a></li>
            <li><a href="javascript:void(0)" class="cate-sixteen"><p>文化街区</p></a></li>
        </ul>
    </div>
    <div class="space-img" id="space-img">
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
        <div class="space-submit" id="space-submit">
            <div class="submit-space-relative clearfix">
                <!--<div class="cov"></div>-->
                <div class="submit-bg"></div>
                <div class="space-submit-body">
                    <div class="space-submit-body-border">
                        <div class="space-submit-form clearfix">
                            <div class="space-submit-p fl">
                                我需要一个可以容纳
                            </div>
                            <div class="space-cate-select fl drop-icon">
                                <div class="space-cate-input">
                                    <p class="space-cate-input-p people" data-num="">50-99人</p>
                                    <span class="space-cate-input-span"></span>
                                </div>
                                <div class="dopDown none">
                                    <ul class="drop-list">
                                        <li data-p="1-49人">1-49人</li>
                                        <li data-p="50-99人">50-99人</li>
                                        <li data-p="100-299人">100-299人</li>
                                        <li data-p="300-499人">300-499人</li>
                                        <li data-p="500人以上">500人以上</li>
                                    </ul>
                                </div>
                            </div>
                            <div class="space-submit-p fl">的场地用于</div>
                            <div class="space-cate-select fl drop-icon">
                                <div class="space-cate-input">
                                    <p class="space-cate-input-p activity">路演/展览/发布会</p>
                                    <span class="space-cate-input-span"></span>
                                </div>
                                <div class="dopDown none">
                                    <ul class="drop-list">
                                        <li data-p="路演/展览/发布会">路演/展览/<span style="color:#f00">发布会</span></li>
                                        <li data-p="派对/典礼/沙龙">派对/典礼/沙龙</li>
                                        <li data-p="晚会/年会/演出">晚会/<span style="color:#f00">年会</span>/演出</li>
                                        <li data-p="会议/讲座">会议/讲座</li>
                                        <li data-p="团建/拓展">团建/拓展</li>
                                        <li data-p="短租/快闪店/移动店铺" style="color:#f00">短租/快闪店/移动店铺</li>
                                        <li data-p="商业地推">商业地推</li>
                                    </ul>
                                </div>
                            </div>
                            <div class="space-submit-btn fl">
                                <a href="javascript:;" class='rent_space'><p></p><span>一键提交</span></a>
                            </div>
                        </div>
                    </div>

                    <div class="space-submit-bottom">
                        一键提交场地需求，30分钟内为你匹配可用场地并获取报价。
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="normal">
        <ul class="normal-list">
            <li>
                <div class="normal-p normal-p-o">
                    <p class="normal-p-first">场地速配</p>
                    <p class="normal-p-two">极速匹配场地，直联场地方获取最新报价。</p>
                </div>
            </li>
            <li>
                <div class="normal-p normal-p-tw">
                    <p class="normal-p-first">实地看场</p>
                    <p class="normal-p-two">专业顾问带看场地，了解场地细节，协调档期冲突，协助进行活动报批。</p>
                </div>
            </li>
            <li>
                <div class="normal-p normal-p-th">
                    <p class="normal-p-first">优惠价格</p>
                    <p class="normal-p-two">享受5-8折的平台签约价，甚至还有免费场地哦！</p>
                </div>
            </li>
            <li class="margin-none-right">
                <div class="normal-p normal-p-f">
                    <p class="normal-p-first">现场协调</p>
                    <p class="normal-p-two">活动现场多方协调，确保活动现场安全有序。</p>
                </div>
            </li>
        </ul>
    </div>
    <div class="code-int clearfix">
        <div class="code-left fl">
            <div class="code-left-des ">
                <p class="code-left-des-one  code-left-des-one-bg">一键租场地</p>
                <p class="code-left-des-two">随时随地，快速提交需求，收取报价 !</p>
            </div>
            <div class="code-left-des margin-top-one">
                <p class="code-left-des-one code-left-des-two-bg">直接报价</p>
                <p class="code-left-des-two">场地方直接报价，议价随心 !</p>
            </div>
        </div>
        <div class="code-center fl">
            {*<div class="code-img">*}
                {*<img src="img/get_space/code_03.jpg" alt="">*}
            {*</div>*}
            <div class="code-img-b">
                <img src="img/weixin2.jpg" alt="云SPACE服务号">
                <p>关注云SPACE服务号<br/>掌握一手场地资源<br>还有更多的免费和折扣活动哦</p>
            </div>
            <div class="code-img-p">

            </div>
        </div>
        <div class="code-right fl">
            <div class="code-right-des">
                <p class="code-right-des-one code-right-des-one-bg">快速匹配</p>
                <p class="code-right-des-two">30分钟内匹配30-100个场地，实时对接场地方！</p>
            </div>
            <div class="code-right-des margin-top-one">
                <p class="code-right-des-one code-right-des-two-bg">优惠折扣</p>
                <p class="code-right-des-two">不定期推送免费场地、折扣券、优质合作资源！</p>
            </div>
        </div>
    </div>
    <div class="cate-exp">
        <ul class="cate-exp-nav" id="cate-exp-nav">
            <li><a href="javascript:;">发布会/路演/展览</a></li>
            <li><a href="javascript:;">典礼/晚会/年会</a></li>
            <li><a href="javascript:;">派对/酒会</a></li>
            <li><a href="javascript:;">会议/讲座</a></li>
        </ul>
        <ul class="cate-exp-list clearfix">
            {foreach $page->getPublicCaseList as $k=>$v}
            <li>
                <a href="http://{Core::$urls['host']}/article/{Func_NumEncode::e($v['id'])}.html" target="_blank">
                    <div class="cate-exp-img">
                        <img src="{Page_Site_Global::displayMedia($v['logo'],"238","240",1)}" alt="">
                    </div>
                    <div class="cate-exp-p">
                        {if mb_strlen($v['title'])>15}
                            {mb_substr($v['title'],0,15,"utf8")}...
                        {else}
                            {$v['title']}
                        {/if}
                    </div>
                </a>
            </li>
            {/foreach}
        </ul>
        <ul class="cate-exp-list clearfix none">
            {foreach $page->getPartyCaseList as $k=>$v}
                <li>
                    <a href="http://{Core::$urls['host']}/article/{Func_NumEncode::e($v['id'])}.html" target="_blank">
                        <div class="cate-exp-img">
                            <img src="{Page_Site_Global::displayMedia($v['logo'],"238","240",1)}" alt="">
                        </div>
                        <div class="cate-exp-p">
                            {if mb_strlen($v['title'])>15}
                                {mb_substr($v['title'],0,15,"utf8")}...
                            {else}
                                {$v['title']}
                            {/if}
                        </div>
                    </a>
                </li>
            {/foreach}
        </ul>
        <ul class="cate-exp-list clearfix none">
            {foreach $page->getWineCaseList as $k=>$v}
                <li>
                    <a href="http://{Core::$urls['host']}/article/{Func_NumEncode::e($v['id'])}.html" target="_blank">
                        <div class="cate-exp-img">
                            <img src="{Page_Site_Global::displayMedia($v['logo'],"238","240",1)}" alt="">
                        </div>
                        <div class="cate-exp-p">
                            {if mb_strlen($v['title'])>15}
                                {mb_substr($v['title'],0,15,"utf8")}...
                            {else}
                                {$v['title']}
                            {/if}
                        </div>
                    </a>
                </li>
            {/foreach}
        </ul>
        <ul class="cate-exp-list clearfix none">
            {foreach $page->getMeetingCaseList as $k=>$v}
                <li>
                    <a href="http://{Core::$urls['host']}/article/{Func_NumEncode::e($v['id'])}.html" target="_blank">
                        <div class="cate-exp-img">
                            <img src="{Page_Site_Global::displayMedia($v['logo'],"238","240",1)}" alt="">
                        </div>
                        <div class="cate-exp-p">
                            {if mb_strlen($v['title'])>15}
                                {mb_substr($v['title'],0,15,"utf8")}...
                            {else}
                                {$v['title']}
                            {/if}
                        </div>
                    </a>
                </li>
            {/foreach}
        </ul>
    </div>

    <div class="join">
        <div class="join-body clearfix">
            <div class="join-left fl">
                <div class="join-title">云SPACE场地大招募</div>
                <div class="join-des">
                    <p>场地闲置？没有人气？管理麻烦？</p>
                    <p>云·SPACE为您解决场地烦恼！</p>
                    <p>快来秀出您的场地吧~</p>
                </div>
                <div class="join-button">
                    <a href="{$_root}site_join">立即参与</a>
                </div>
            </div>
            <div class="join-map"></div>
        </div>
    </div>

    <div class="cate-space-footer">
        <div class="clearfix cate-space-footer-title">
            <div class="footer-li fl">
                <div class="footer-li-header footer-li-header-active">上海活动场地</div>
            </div>
            <div class="footer-li fl">
                <div class="footer-li-header">北京活动场地</div>
            </div>
            <div class="footer-li fl">
                <div class="footer-li-header">广州活动场地</div>
            </div>
            <div class="footer-li fl">
                <div class="footer-li-header">深圳活动场地</div>
            </div>
            <div class="footer-li fl">
                <div class="footer-li-header">成都活动场地</div>
            </div>
            <div class="footer-li fl">
                <div class="footer-li-header">杭州活动场地</div>
            </div>
        </div>
        <div class="footer-act-list">
            <ul class="footer-li-list clearfix">
                <li><a href="http://www.yunspace.com.cn/spaces-sh-49-tags/{Func_Url::str_urlencode('晚会年会')}">上海年会场地</a></li>
                <li><a href="http://www.yunspace.com.cn/spaces-sh-49-tags/{Func_Url::str_urlencode('新品发布会')}">上海发布会场地</a></li>
                <li><a href="http://www.yunspace.com.cn/spaces-sh-49-tags/{Func_Url::str_urlencode('推广路演')}">上海路演场地</a></li>
                <li><a href="http://www.yunspace.com.cn/spaces-sh-49-tags/{Func_Url::str_urlencode('时尚走秀')}">上海走秀场地</a></li>
                <li><a href="http://www.yunspace.com.cn/spaces-sh-size-tags/1">上海沙龙场地</a></li>
                <li><a href="http://www.yunspace.com.cn/spaces-sh-49-tags/{Func_Url::str_urlencode('主题派对')}">上海派对场地</a></li>
                <li><a href="http://www.yunspace.com.cn/spaces-sh-49-tags/{Func_Url::str_urlencode('餐厅酒吧')}">上海聚会场地</a></li>
                <li><a href="http://www.yunspace.com.cn/spaces-sh-category-tags/{Func_Url::str_urlencode('体育场馆')}">上海运动场馆</a></li>
                <li><a href="http://www.yunspace.com.cn/spaces-sh-category-tags/{Func_Url::str_urlencode('特色场地')}">上海特色场地</a></li>
                <li><a href="http://www.yunspace.com.cn/spaces-sh-size-tags/2000">上海大型场地</a></li>
                <li><a href="http://www.yunspace.com.cn/spaces-sh-49-tags/{Func_Url::str_urlencode('户外拓展')}">上海团建场地</a></li>
                <li><a href="http://www.yunspace.com.cn/site/{Func_Url::str_urlencode('云SPACE宝山秀场-百科')}">上海宝山秀场</a></li>
            </ul>
        </div>
        <div class="footer-act-list none">
            <ul class="footer-li-list clearfix">
                <li><a href="http://www.yunspace.com.cn/spaces-bj-49-tags/{Func_Url::str_urlencode('晚会年会')}">北京年会场地</a></li>
                <li><a href="http://www.yunspace.com.cn/spaces-bj-49-tags/{Func_Url::str_urlencode('新品发布会')}">北京发布会场地</a></li>
                <li><a href="http://www.yunspace.com.cn/spaces-bj-49-tags/{Func_Url::str_urlencode('推广路演')}">北京路演场地</a></li>
                <li><a href="http://www.yunspace.com.cn/spaces-bj-49-tags/{Func_Url::str_urlencode('时尚走秀')}">北京走秀场地</a></li>
                <li><a href="http://www.yunspace.com.cn/spaces-bj-size-tags/1">北京沙龙场地</a></li>
                <li><a href="http://www.yunspace.com.cn/spaces-bj-49-tags/{Func_Url::str_urlencode('主题派对')}">北京派对场地</a></li>
                <li><a href="http://www.yunspace.com.cn/spaces-bj-49-tags/{Func_Url::str_urlencode('餐厅酒吧')}">北京聚会场地</a></li>
                <li><a href="http://www.yunspace.com.cn/spaces-bj-category-tags/{Func_Url::str_urlencode('体育场馆')}">北京运动场馆</a></li>
                <li><a href="http://www.yunspace.com.cn/spaces-bj-category-tags/{Func_Url::str_urlencode('特色场地')}">北京特色场地</a></li>
                <li><a href="http://www.yunspace.com.cn/spaces-bj-size-tags/2000">北京大型场地</a></li>
                <li><a href="http://www.yunspace.com.cn/spaces-bj-49-tags/{Func_Url::str_urlencode('户外拓展')}">北京团建场地</a></li>
                <li><a href="http://www.yunspace.com.cn/spaces-bj-category-tags/{Func_Url::str_urlencode('商业广场')}">北京商场场地</a></li>
            </ul>
        </div>
        <div class="footer-act-list none">
            <ul class="footer-li-list clearfix">
                <li><a href="http://www.yunspace.com.cn/spaces-gz-49-tags/{Func_Url::str_urlencode('晚会年会')}">广州年会场地</a></li>
                <li><a href="http://www.yunspace.com.cn/spaces-gz-49-tags/{Func_Url::str_urlencode('新品发布会')}">广州发布会场地</a></li>
                <li><a href="http://www.yunspace.com.cn/spaces-gz-49-tags/{Func_Url::str_urlencode('推广路演')}">广州路演场地</a></li>
                <li><a href="http://www.yunspace.com.cn/spaces-gz-49-tags/{Func_Url::str_urlencode('时尚走秀')}">广州走秀场地</a></li>
                <li><a href="http://www.yunspace.com.cn/spaces-gz-size-tags/1">广州沙龙场地</a></li>
                <li><a href="http://www.yunspace.com.cn/spaces-gz-49-tags/{Func_Url::str_urlencode('主题派对')}">广州派对场地</a></li>
                <li><a href="http://www.yunspace.com.cn/spaces-gz-49-tags/{Func_Url::str_urlencode('餐厅酒吧')}">广州聚会场地</a></li>
                <li><a href="http://www.yunspace.com.cn/spaces-gz-category-tags/{Func_Url::str_urlencode('体育场馆')}">广州运动场馆</a></li>
                <li><a href="http://www.yunspace.com.cn/spaces-gz-category-tags/{Func_Url::str_urlencode('特色场地')}">广州特色场地</a></li>
                <li><a href="http://www.yunspace.com.cn/spaces-gz-size-tags/2000">广州大型场地</a></li>
                <li><a href="http://www.yunspace.com.cn/spaces-gz-49-tags/{Func_Url::str_urlencode('户外拓展')}">广州团建场地</a></li>
                <li><a href="http://www.yunspace.com.cn/spaces-gz-category-tags/{Func_Url::str_urlencode('商业广场')}">广州商场场地</a></li>
            </ul>
        </div>
        <div class="footer-act-list none">
            <ul class="footer-li-list clearfix">
                <li><a href="http://www.yunspace.com.cn/spaces-sz-49-tags/{Func_Url::str_urlencode('晚会年会')}">深圳年会场地</a></li>
                <li><a href="http://www.yunspace.com.cn/spaces-sz-49-tags/{Func_Url::str_urlencode('新品发布会')}">深圳发布会场地</a></li>
                <li><a href="http://www.yunspace.com.cn/spaces-sz-49-tags/{Func_Url::str_urlencode('推广路演')}">深圳路演场地</a></li>
                <li><a href="http://www.yunspace.com.cn/spaces-sz-49-tags/{Func_Url::str_urlencode('时尚走秀')}">深圳走秀场地</a></li>
                <li><a href="http://www.yunspace.com.cn/spaces-sz-size-tags/1">深圳沙龙场地</a></li>
                <li><a href="http://www.yunspace.com.cn/spaces-sz-49-tags/{Func_Url::str_urlencode('主题派对')}">深圳派对场地</a></li>
                <li><a href="http://www.yunspace.com.cn/spaces-sz-49-tags/{Func_Url::str_urlencode('餐厅酒吧')}">深圳聚会场地</a></li>
                <li><a href="http://www.yunspace.com.cn/spaces-sz-category-tags/{Func_Url::str_urlencode('体育场馆')}">深圳运动场馆</a></li>
                <li><a href="http://www.yunspace.com.cn/spaces-sz-category-tags/{Func_Url::str_urlencode('特色场地')}">深圳特色场地</a></li>
                <li><a href="http://www.yunspace.com.cn/spaces-sz-size-tags/2000">深圳大型场地</a></li>
                <li><a href="http://www.yunspace.com.cn/spaces-sz-49-tags/{Func_Url::str_urlencode('户外拓展')}">深圳团建场地</a></li>
                <li><a href="http://www.yunspace.com.cn/spaces-sz-category-tags/{Func_Url::str_urlencode('商业广场')}">深圳商场场地</a></li>
            </ul>
        </div>
        <div class="footer-act-list none">
            <ul class="footer-li-list clearfix">
                <li><a href="http://www.yunspace.com.cn/spaces-cd-49-tags/{Func_Url::str_urlencode('晚会年会')}">成都年会场地</a></li>
                <li><a href="http://www.yunspace.com.cn/spaces-cd-49-tags/{Func_Url::str_urlencode('新品发布会')}">成都发布会场地</a></li>
                <li><a href="http://www.yunspace.com.cn/spaces-cd-49-tags/{Func_Url::str_urlencode('推广路演')}">成都路演场地</a></li>
                <li><a href="http://www.yunspace.com.cn/spaces-cd-49-tags/{Func_Url::str_urlencode('时尚走秀')}">成都走秀场地</a></li>
                <li><a href="http://www.yunspace.com.cn/spaces-cd-size-tags/1">成都沙龙场地</a></li>
                <li><a href="http://www.yunspace.com.cn/spaces-cd-49-tags/{Func_Url::str_urlencode('主题派对')}">成都派对场地</a></li>
                <li><a href="http://www.yunspace.com.cn/spaces-cd-49-tags/{Func_Url::str_urlencode('餐厅酒吧')}">成都聚会场地</a></li>
                <li><a href="http://www.yunspace.com.cn/spaces-cd-category-tags/{Func_Url::str_urlencode('体育场馆')}">成都运动场馆</a></li>
                <li><a href="http://www.yunspace.com.cn/spaces-cd-category-tags/{Func_Url::str_urlencode('特色场地')}">成都特色场地</a></li>
                <li><a href="http://www.yunspace.com.cn/spaces-cd-size-tags/2000">成都大型场地</a></li>
                <li><a href="http://www.yunspace.com.cn/spaces-cd-49-tags/{Func_Url::str_urlencode('户外拓展')}">成都团建场地</a></li>
                <li><a href="http://www.yunspace.com.cn/spaces-cd-category-tags/{Func_Url::str_urlencode('商业广场')}">成都商场场地</a></li>
            </ul>
        </div>
        <div class="footer-act-list none">
            <ul class="footer-li-list clearfix">
                <li><a href="http://www.yunspace.com.cn/spaces-hz-49-tags/{Func_Url::str_urlencode('晚会年会')}">杭州年会场地</a></li>
                <li><a href="http://www.yunspace.com.cn/spaces-hz-49-tags/{Func_Url::str_urlencode('新品发布会')}">杭州发布会场地</a></li>
                <li><a href="http://www.yunspace.com.cn/spaces-hz-49-tags/{Func_Url::str_urlencode('推广路演')}">杭州路演场地</a></li>
                <li><a href="http://www.yunspace.com.cn/spaces-hz-49-tags/{Func_Url::str_urlencode('时尚走秀')}">杭州走秀场地</a></li>
                <li><a href="http://www.yunspace.com.cn/spaces-hz-size-tags/1">杭州沙龙场地</a></li>
                <li><a href="http://www.yunspace.com.cn/spaces-hz-49-tags/{Func_Url::str_urlencode('主题派对')}">杭州派对场地</a></li>
                <li><a href="http://www.yunspace.com.cn/spaces-hz-49-tags/{Func_Url::str_urlencode('餐厅酒吧')}">杭州聚会场地</a></li>
                <li><a href="http://www.yunspace.com.cn/spaces-hz-category-tags/{Func_Url::str_urlencode('体育场馆')}">杭州运动场馆</a></li>
                <li><a href="http://www.yunspace.com.cn/spaces-hz-category-tags/{Func_Url::str_urlencode('特色场地')}">杭州特色场地</a></li>
                <li><a href="http://www.yunspace.com.cn/spaces-hz-size-tags/2000">杭州大型场地</a></li>
                <li><a href="http://www.yunspace.com.cn/spaces-hz-49-tags/{Func_Url::str_urlencode('户外拓展')}">杭州团建场地</a></li>
                <li><a href="http://www.yunspace.com.cn/spaces-hz-category-tags/{Func_Url::str_urlencode('商业广场')}">杭州商场场地</a></li>
            </ul>
        </div>
    </div>
    {include file="Web_Static::inc/html_footer.tpl"}
    {static "v4.0/jquery.easing.1.3.min.js"}
    {static "v4.0/jquery-slide-fade.min.js"}
    {static "core/yunspace.js"}
    {*{static "get_space/get_space.js"}*}
    <script>
        $("#space-img").FadeSlide({
            speed:500,
            delay:5000
        });
    </script>

</body>
</html>