<!DOCTYPE html>
<html lang="en">
<head>
    {*<title>一键找文创</title>*}
    {include file="Web_Mobile_Static::inc/header_meta.tpl"}
    <meta name="full-screen" content="yes" />
    <meta name="x5-fullscreen" content="true" />
    <meta name="x5-page-mode" content="app" />

    {static "wchuang/wchuang.css"}
</head>
<body yun="wchuang/wchuang.js::init">
{include "Web_Mobile_Static::v1.0/inc.nav.tpl"}
<div class="content">
    <div class="wch-banner">
       <div class="wch-banner-img"></div>
       <div class="wch-banner-body">
           <div class="wch-logo"><img src="img/comment/logo_m_0520.png"></div>
           <div class="wch-text">
               <p>打破传统格局</p>
               <p>将文创项目与商业体态结合</p>
           </div>
           <a class="wch-submit" href="{$_home}winchance/demand">一键提交文创需求</a>
       </div>
    </div>
    <div class="wch-adg1">
        <h2>云SPACE平台优势</h2>
        <ul class="wch-adg1-list clearfix">
            <li class="fl">
                <div class="img"><img src="img/wchuang/icon-adg1.png"></div>
                <p>
                    全面整合文创资源<br>（已有合作版权近50家）
                </p>
            </li>
            <li class="fr">
                <div class="img"><img src="img/wchuang/icon-adg2.png"></div>
                <p>
                    一站式采购<br>省心又省力
                </p>
            </li>
            <li class="fl li3">
                <div class="img"><img src="img/wchuang/icon-adg3.png"></div>
                <p>
                    全方位合作模式，高人气 & 高收益
                </p>
            </li>
            <li class="fl">
                <div class="img"><img src="img/wchuang/icon-adg4.png"></div>
                <p>
                    极大减少版权费<br>有效降低运营成本
                </p>
            </li>
            <li class="fr">
                <div class="img"><img src="img/wchuang/icon-adg5.png"></div>
                <p>
                    全国性平台<br>多城市全面推广
                </p>
            </li>
        </ul>
    </div>
    <div class="wch-adg2">
        <h2>云SPACE团队优势</h2>
        <div class="wch-adg2-list clearfix">
            <div class="adg-l wch-adg2-l1">
                <div class="year">
                    <span>10</span>年
                </div>
                <p>商业地产运营经验</p>
                <div class="adg2-line"></div>
            </div>
            <div class="adg-l wch-adg2-l2">
                <div class="year">
                    <span>7</span>年
                </div>
                <p>创意领域实际操作经验</p>
                <div class="adg2-line"></div>
            </div>
            <div class="adg-l wch-adg2-l3">
                <div class="year">
                    <span>6</span>年
                </div>
                <p>丰富的广告创意<br>&活动执行经验</p>
            </div>
        </div>
    </div>

    <div class="find">
        合作活动
    </div>
    <div class="banner4">
        <ul class="banner4-list">
            {*{foreach $everydayRecommend as $k=>$v}*}
                {*<li>*}
                    {*<a href="{$_home}site/{Func_Url::str_urlencode($v['space_name'])}">*}
                        {*<div class="banner4-img">*}
                            {*{if !empty($v['mobile_logo'])}*}
                                {*<img src="{Page_Site_Global::displayMedia($v['mobile_logo'],640,424)}" alt="">*}
                            {*{else}*}
                                {*<img src="{Page_Site_Global::displayMedia($v['logo'],640,424)}" alt="">*}
                            {*{/if}*}
                        {*</div>*}
                        {*<div class="bg-cover">*}
                            {*<p class="banner4-title">{$v['space_name']}</p>*}
                            {*<p class="banner4-des">*}
                                {*{if !empty($v['attr']['营销标题'])}{$v['attr']['营销标题']}*}
                                {*{elseif !empty($v['addr'])}*}
                                    {*{$v['addr']}*}
                                {*{else}*}
                                    {*......*}
                                {*{/if}*}
                            {*</p>*}
                            {*<div class="bn-data">*}
                                {*<p><span>{$v['click']}</span></p>*}
                                {*<p><span>{$v['sum']}</span></p>*}
                            {*</div>*}
                        {*</div>*}
                    {*</a>*}
                {*</li>*}
            {*{/foreach}*}
            {foreach $page->getHotList(5) as $k=>$v}
                <li>
                    <a href="{$_home}site/{$v['active_name']}-百科">
                        <div class="banner4-img">
                                <img src="{$v['cover_logo']}" alt="{$v['active_name']}">
                        </div>
                        <div class="bg-cover">
                            <p class="banner4-title">{$v['active_name']}</p>
                            <p class="banner4-des">
                                {$v['ip_des']}
                            </p>
                            <div class="bn-data">
                                <p><span>{$v['click']}</span></p>
                                <p><span>{$v['is_love']}</span></p>
                            </div>
                        </div>
                    </a>
                </li>
            {/foreach}
            {*<li>*}
                {*<a href="javascript:;">*}
                    {*<div class="banner4-img">*}
                        {*<img src="img/wchuang/img-act.jpg" alt="">*}
                    {*</div>*}
                    {*<div class="bg-cover">*}
                        {*<p class="banner4-title">国际工业大秀场</p>*}
                        {*<p class="banner4-des">*}
                            {*多元化设计园区*}
                        {*</p>*}
                        {*<div class="bn-data">*}
                            {*<p><span>29836</span></p>*}
                            {*<p><span>74</span></p>*}
                        {*</div>*}
                    {*</div>*}
                {*</a>*}
            {*</li>*}
            {*<li>*}
                {*<a href="javascript:;">*}
                    {*<div class="banner4-img">*}
                        {*<img src="img/wchuang/img-act.jpg" alt="">*}
                    {*</div>*}
                    {*<div class="bg-cover">*}
                        {*<p class="banner4-title">国际工业大秀场</p>*}
                        {*<p class="banner4-des">*}
                            {*多元化设计园区*}
                        {*</p>*}
                        {*<div class="bn-data">*}
                            {*<p><span>29836</span></p>*}
                            {*<p><span>74</span></p>*}
                        {*</div>*}
                    {*</div>*}
                {*</a>*}
            {*</li>*}
        </ul>
    </div>
    <a href="{$_home}winchance/list" class="link-more">查看更多合作活动</a>
</div>

<!--一键找文创按钮-->
<a class="wch-btn ani-wchbtn" href="{$_home}winchance/demand">一键找文创</a>

{static "v1.0/jquery-1.11.1.min.js"}
{static "core/yunspace.js"}
</body>
</html>