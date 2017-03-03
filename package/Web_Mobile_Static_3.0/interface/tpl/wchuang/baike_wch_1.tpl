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
{*<img src="{Page_Site_Global::displayMedia($page->info['cover_logo'],'1024','')}" style="display: none">*}

{include "Web_Mobile_Static::v1.0/inc.nav.tpl"}
<div class="content">
    {*头部*}
    <header class="con-header">
        <div class="con-img">
            <div class="img">
                {if !empty($page->info['cover_logo'])}
                    <img src="{Page_Site_Global::displayMedia($page->info['cover_logo'],'1024','')}" alt="{$page->info['active_name']}">
                {/if}

            </div>
        </div>

        <div class="con-header-body">
            {include file="Web_Mobile_Static::site/inc/nav.tpl"}

            <div class="con-title">
                <span>{$page->info['active_name']}</span>
            </div>
            <div class="con-des">
                <span>{$page->info['ip_des']}</span>
            </div>
            <div class="con-data">
                <p class="con-date-look fl">
                    <span class="fa fa-eye"></span>
                    <span>{$page->info['click']}</span>
                </p>
                <p class="con-date-person fl">
                    <span class="fa fa-user"></span>
                    <span>{$page->info['is_love']+$page->info['is_go']}</span>
                </p>
                <div class="clear"></div>
            </div>
            <div class="con-addr">{$page->info['city']}</div>
            <a href="{$_home}site/{$page->info['active_name']}-百科-图片" class="con-pic">
                <span>{count($page->spaceMedia)}张</span>
            </a>
        </div>
    </header>
    <div class="baike_m_content">
        {*{if $page->info['special_tags']}*}
            <div class="baike_m_title">IP特色 </div>
            <div class="baike_m_t">{$page->info['feature_tag']}</div>
        {*{/if}*}

            <div class="baike_m_title">活动类型 </div>
            <div class="baike_m_t">{$page->info['category']}</div>

        {*{if $page->caseList|@count neq 0 }*}
            {*<div class="baike_m_line"></div>*}
            {*<div class="baike_m_c_title">品牌故事</div>*}
            {*{foreach $page->caseList as $k=>$v}*}
                {*<div class="baike_m_brand_pic"><img src="{$v['logo']}"> </div>*}
                {*<div class="baike_m_brand_introduce" id="baike_m_brand_content">*}
                    {*<h5>{$v['subhead']}</h5>*}
                    {*<p>{$v['des']}</p>*}
                {*</div>*}
            {*{/foreach}*}
            {*<div class="baike_m_icon_down" id="baike_m_brand_down">*}
                {*<img src="img/encyclopedias/baike_m_icon_down.png">*}
            {*</div>*}
            {*<div class="baike_m_icon_up" id="baike_m_brand_up">*}
                {*<img src="img/encyclopedias/baike_m_icon_up.png">*}
            {*</div>*}
        {*{/if}*}



        <div class="baike_m_line"></div>
        <div class="baike_m_c_title mb15">IP简介</div>
        <div class="baike_m_brand_introduce" id="baike_m_brief_content">
            <p> {$page->info['ip_brief_introduction']}</p>
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
                <td class="baike_m_basics_c">{$page->info['grant_country']}</td>
                <td class="baike_m_basics_title">展期</td>
                <td class="baike_m_basics_c">{$page->info['schedule']}</td>
            </tr>
            <tr>
                <td class="baike_m_basics_title">预算</td>
                <td class="baike_m_basics_c1" colspan="3">{$page->info['budget']}</td>
            </tr>
            <tr>
                <td class="baike_m_basics_title">适用人群</td>
                <td class="baike_m_basics_c1" colspan="3">{$page->info['conform_crowd']}</td>
            </tr>
        </table>
        <div class="baike_m_line"></div>

        <div class="baike_m_c_title">空间条件</div>
        <table class="baike_m_basics_info">
            <tr>
                <td class="baike_m_basics_title">面积</td>
                <td class="baike_m_basics_c">{$page->info['min_area']}{-$page->info['max_area']}m<SUP>2</SUP></td>
                <td class="baike_m_basics_title">层高</td>
                <td class="baike_m_basics_c">{$page->info['storey']}</td>
            </tr>
            <tr>
                <td class="baike_m_basics_title">配套</td>
                <td class="baike_m_basics_c1" colspan="3">{$page->info['supporting']}</td>
            </tr>
            <tr>
                <td class="baike_m_basics_title">室内/户外</td>
                <td class="baike_m_basics_c1" colspan="3">{$page->info['indoor_outdoor']}</td>
            </tr>
        </table>
        <div class="baike_m_line"></div>
        {if $page->getArticleList}
        <div class="baike_m_c_title">IP案例</div>
        <ul class="baike_m_case">
            {foreach $page->getArticleList as $k=>$v}
            <li>
                <a href="{$_home}article/{$v['id']}.html">
                    <img src="{$v['logo']}">
                    <p class="text">{$v['title']}</p>
                    <div class="mask"></div>
                </a>
            </li>
            {/foreach}
            {*<li>*}
                {*<a href="javascript:;">*}
                    {*<img src="img/wchuang/img_bk_wch.jpg">*}
                    {*<p class="text">“奥特曼正义之旅”舞台剧作为“奥特曼系列”</p>*}
                    {*<div class="mask"></div>*}
                {*</a>*}
            {*</li>*}
            {*<li>*}
                {*<a href="javascript:;">*}
                    {*<img src="img/wchuang/img_bk_wch.jpg">*}
                    {*<p class="text">“奥特曼正义之旅”舞台剧作为“奥特曼系列”</p>*}
                    {*<div class="mask"></div>*}
                {*</a>*}
            {*</li>*}
        </ul>
        {/if}
    </div>

</div>

<div class="bottom-nav-area wch_bk_tool">
    <a href="tel:4000560599">
        <div class="normal-block block-right-border">
            <span class="icon ion-ios-telephone" style="font-size: 20px;line-height: 22px;"></span>
            <p>咨询</p>
        </div>
    </a>
    <a class="collect" data-space_id="{$page->itemInfo['space_id']}" data-item_name="{$page->info['active_name']}" data-space_logo="{$page->info['cover_logo']}" href="javascript:;">
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
        <p><a href="{$_home}winchance/demand?space_id={Func_NumEncode::e($page->info['space_id'])}" style="display: block">提交IP需求</a></p>
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
