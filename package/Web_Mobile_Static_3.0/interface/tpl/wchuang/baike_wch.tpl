<!DOCTYPE>
<html>
<head>
    {include file="Web_Mobile_Static::inc/header_meta.tpl"}
    <meta name="full-screen" content="yes" />
    <meta name="x5-fullscreen" content="true" />
    <meta name="x5-page-mode" content="app" />
    {*<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=aaNCRRcGGai6klHMOGZ8yBbP"></script>*}
    {* <script type="text/javascript" src="http://api.map.baidu.com/getscript?v=2.0&ak=aaNCRRcGGai6klHMOGZ8yBbP"></script> *}

    {static "encyclopedia/subspace_tool.css"}
    {static "encyclopedia/encyclopedia.css"}
    {static "v4.0/font-awesome.min.css"}
    {static "map/map_common.css"}
    {static "encyclopedias/encyclopedias.js"}


</head>
<body>
<img src="{Page_Site_Global::displayMedia($page->info['media'][0]['path'],'1024','')}" style="display: none">

{include "Web_Mobile_Static::v1.0/inc.nav.tpl"}
<div class="content">
    {*头部*}
    <header class="con-header">
        <div class="con-img">
            <div class="img">

                {if !empty($page->info['mobile_logo'])}
                    <img src="{Page_Site_Global::displayMedia($page->info['mobile_logo'],'1024','')}" alt="{$page->info['space_name']}">
                {elseif !empty($page->info['logo'])}
                    <img src="{Page_Site_Global::displayMedia($page->info['logo'],'1024','')}" alt="{$page->info['space_name']}">
                {else}
                    <img src="{Page_Site_Global::displayMedia($page->info['media'][0]['path'],'1024','')}" alt="{$page->info['space_name']}">
                {/if}

            </div>
        </div>

        <div class="con-header-body">
            {include file="Web_Mobile_Static::site/inc/nav.tpl"}

            <div class="con-title">
                <span>{$page->info['space_name']}ULTRAMAN 奥特曼50周年展</span>
            </div>
            <div class="con-des">
                <span>{$page->info['special_tags']}一个拥有近70部、超过1200集影视作品的经典巨作！</span>
            </div>
            <div class="con-data">
                <p class="con-date-look fl">
                    <span class="fa fa-eye"></span>
                    <span>{$count_num['sum']}</span>
                </p>
                <p class="con-date-person fl">
                    <span class="fa fa-user"></span>
                    <span>{$count_num['is_love']+$count_num['is_go']}</span>
                </p>
                <div class="clear"></div>
            </div>
            <div class="con-addr">{$page->info['addr']}上海新世界大丸百货 (南京东路228号)</div>
            <a href="{$_home}site/{$page->info['space_name']}-百科-图片" class="con-pic">
                <span>{count($page->spaceMedia)}张</span>
            </a>
        </div>
    </header>
    <div class="baike_m_content">
        {*{if $page->info['special_tags']}*}
            <div class="baike_m_title">IP特色 </div>
            <div class="baike_m_t">{$page->info['special_tags']}卡通  /  英雄  /  奥特曼</div>
        {*{/if}*}

            <div class="baike_m_title">活动类型 </div>
            <div class="baike_m_t">{$page->info['special_tags']}动漫</div>

        {if $page->caseList|@count neq 0 }
            <div class="baike_m_line"></div>
            <div class="baike_m_c_title">品牌故事</div>
            {foreach $page->caseList as $k=>$v}
                <div class="baike_m_brand_pic"><img src="{$v['logo']}"> </div>
                <div class="baike_m_brand_introduce" id="baike_m_brand_content">
                    {*<h5>{$v['subhead']}</h5>*}
                    <p>{$v['des']}</p>
                </div>
            {/foreach}
            <div class="baike_m_icon_down" id="baike_m_brand_down">
                <img src="img/encyclopedias/baike_m_icon_down.png">
            </div>
            <div class="baike_m_icon_up" id="baike_m_brand_up">
                <img src="img/encyclopedias/baike_m_icon_up.png">
            </div>
        {/if}



        <div class="baike_m_line"></div>
        <div class="baike_m_c_title mb15">IP简介</div>
        <div class="baike_m_brand_introduce" id="baike_m_brief_content">
            {strip_tags($page->info['des'])}
            <p>“奥特曼系列”是由日本圆谷制作株式会社自1966年开始制作的特摄电视作品。从《奥特Q》、《奥特曼》开始，其后近五十年所制作的奥特曼系列当中诞生了许多奥特英雄，从奥特曼、赛文·奥特曼、杰克·奥特曼等等，到现在的艾克斯·奥特曼，共有41位奥特英雄。</p>
            <p>“奥特曼”系列形象作为巨大的变身英雄，在亚洲乃至全世界享有极高人气，是广大少年儿童心目中的偶像！</p>
            <p>奥特曼系列”同时也被吉尼斯世界纪录认证为“衍生系列剧最多的电视节目”</p>
        </div>
        <div class="baike_m_icon_down" id="baike_m_brief_down">
            <img src="img/encyclopedias/baike_m_icon_down.png">
        </div>
        <div class="baike_m_icon_up" id="baike_m_brief_up">
            <img src="img/encyclopedias/baike_m_icon_up.png">
        </div>
        <div class="baike_m_line"></div>

        <div class="baike_m_c_title">IP详情</div>
        <table class="baike_m_basics_info">
            <tr>
                <td class="baike_m_basics_title">国家</td>
                <td class="baike_m_basics_c">日本</td>
                <td class="baike_m_basics_title">展期</td>
                <td class="baike_m_basics_c">07/8-12/8</td>
            </tr>
            <tr>
                <td class="baike_m_basics_title">预算</td>
                <td class="baike_m_basics_c1" colspan="3">暂无</td>
            </tr>
            <tr>
                <td class="baike_m_basics_title">适用人群</td>
                <td class="baike_m_basics_c1" colspan="3">所有喜欢奥特曼的人</td>
            </tr>
        </table>
        <div class="baike_m_line"></div>

        <div class="baike_m_c_title">空间条件</div>
        <table class="baike_m_basics_info">
            <tr>
                <td class="baike_m_basics_title">面积</td>
                <td class="baike_m_basics_c">{$page->tags[78]['使用面积']}800-1000㎡</td>
                <td class="baike_m_basics_title">层高</td>
                <td class="baike_m_basics_c">{$page->tags[78]['空间层高']}4.5米或4.5+</td>
            </tr>
            <tr>
                <td class="baike_m_basics_title">配套</td>
                <td class="baike_m_basics_c1" colspan="3">由高庭文艺/映松传媒技术人员督导</td>
            </tr>
            <tr>
                <td class="baike_m_basics_title">室内/户外</td>
                <td class="baike_m_basics_c1" colspan="3">全部活动在户外进行</td>
            </tr>
        </table>
        <div class="baike_m_line"></div>

        <div class="baike_m_c_title">IP案例</div>
        <ul class="baike_m_case">
            <li>
                <a href="javascript:;">
                    <img src="img/wchuang/img_bk_wch.jpg">
                    <p class="text">“奥特曼正义之旅”舞台剧作为“奥特曼系列”</p>
                    <div class="mask"></div>
                </a>
            </li>
            <li>
                <a href="javascript:;">
                    <img src="img/wchuang/img_bk_wch.jpg">
                    <p class="text">“奥特曼正义之旅”舞台剧作为“奥特曼系列”</p>
                    <div class="mask"></div>
                </a>
            </li>
            <li>
                <a href="javascript:;">
                    <img src="img/wchuang/img_bk_wch.jpg">
                    <p class="text">“奥特曼正义之旅”舞台剧作为“奥特曼系列”</p>
                    <div class="mask"></div>
                </a>
            </li>
        </ul>
    </div>

</div>

<div class="bottom-nav-area wch_bk_tool">
    <a href="tel:4000560599">
        <div class="normal-block block-right-border">
            <span class="icon ion-ios-telephone" style="font-size: 20px;line-height: 22px;"></span>
            <p>咨询</p>
        </div>
    </a>
    <a class="collect" data-space_id="{$page->itemInfo['id']}" data-item_name="{$page->info['space_name']}-{$page->itemInfo['item_name']}" data-space_logo="{$page->info['logo']}" href="javascript:;">
        <div class="normal-block  js-favorite">
            <!--只做效果用-star-->
            <i class="js-star-move icon-star" style="font-size: 20px;line-height: 22px;"></i>
            <!--只做效果用-end-->

            <span class="icon ion-android-star-outline" style="font-size: 20px;line-height: 22px;"></span>
            <p>收藏</p>
        </div>
    </a>
    <a class="js-share" href="javascript:;">
        <div class="normal-block block-right-border">
            <span class="icon ion-android-share-alt" style="font-size: 20px;line-height: 22px;"></span>
            <p>分享</p>
        </div>
    </a>
    <div class="larger-block">
        <p><a href="{$_home}inquiry?space_id={Func_NumEncode::e($page->info['id'])}" style="display: block">提交IP需求</a></p>
    </div>
</div>

<div class="share-bg hidden"></div>
<div class="share">
    <h5>分享到：</h5>
    <div class="share-list clearfix">
        <ul class="bdsharebuttonbox">
            <li>
                <a href="#" class="bds_weixin" data-cmd="weixin" title="分享到微信"></a>
                <span>朋友圈</span>
            </li>
            <li>
                <a href="#" class="bds_tsina" data-cmd="tsina" title="分享到新浪微博"></a>
                <span>新浪微博</span>
            </li>
            <li>
                <a href="#" class="bds_sqq" data-cmd="sqq" title="分享到QQ好友"></a>
                <span>QQ好友</span>
            </li>
            <li>
                <a href="#" class="bds_qzone" data-cmd="qzone" title="分享到QQ空间"></a>
                <span>QQ空间</span>
            </li>
        </ul>
        <script>
            window._bd_share_config={ "common":{ "bdSnsKey":{ },"bdText":"","bdMini":"2","bdMiniList":["qzone","bdysc","renren","bdxc","tqf","douban","sqq","ibaidu","mogujie","huaban","hx","youdao","qingbiji","xinhua","isohu","wealink","iguba","twi","h163","copy"],"bdPic":"","bdStyle":"1","bdSize":"32"},"share":{ },"image":{ "viewList":["weixin","tsina","sqq","qzone"],"viewText":"分享到：","viewSize":"32"},"selectShare":{ "bdContainerClass":null,"bdSelectMiniList":["weixin","tsina","sqq","qzone"]}};with(document)0[(getElementsByTagName('head')[0]||body).appendChild(createElement('script')).src='http://bdimg.share.baidu.com/static/api/js/share.js?v=89860593.js?cdnversion='+~(-new Date()/36e5)];
        </script>
    </div>
</div>

{static "core/yunspace.js"}
<!--收藏功能-->
{static "sites/collect_space.js"}
</body>
</html>
