<!DOCTYPE html>
<html lang="en">
<head>
    {include file="Web_Static::v4.0/html_goto_mobile.tpl" url="m/"}
    {include file="Web_Static::inc/head_meta_home.tpl"}
    {static "home.v4.0/home.css"}
    {static "v4.0/recommend.css"}
    {static "baike.v1.0/baike_common.css"}
    {*{static "v4.0/DOMAssistantCompressed-2.7.4.js"}*}
    {*{static "v4.0/ie-css3.js"}*}
    {static "v4.0/consult_list.css"}
</head>
<body  yun="home.v4.0/home.js::init">
    <div class="home-nav-relative">
      <div class="cov none"></div>
      {include file="Web_Static::inc/header_home.tpl"}
    </div>
<div class="home-container">
    <div class="home-container-img">

        <div class="baike-banner">
            <span class="carousel-control left"></span>
            <div class="baike-banner-img yun-slider" id="bannerBaike">
                <div class="wrap clearfix">
                    {*<div class="item"><img src="img/home/banner.jpg"></div>*}
                    <div class="item"><a href="{$_home}retail"> <img src="img/home/banner05.jpg">  </a></div>
                    <div class="item"><a href="{$_home}space_library"> <img _src="img/home/banner_2.jpg">  </a></div>
                    <div class="item"><a href="{$_home}map2"><img _src="img/home/banner_1.jpg"></a></div>
                    <div class="item"><a href="{$_home}site_join" target="_blank"><img _src="img/home/banner_03.jpg"></a></div>
                    <div class="item"><a href="{$_home}join/index" target="_blank"><img _src="img/home/banner_04.jpg"></a></div>
                </div>

            </div>
            <span class="carousel-control right"></span>
            <ul class="banner-btn" id="bannerNav">
            </ul>
        </div><!--baike-banner-end-->
    </div>
    <div class="header-body">
      <div class="header-body-bg"></div>
        <div class="header-body-container">
            <div class="header-body-title">
              <!-- <span>云&nbsp;·&nbsp;SPACE</span><span>&nbsp;·&nbsp;商业空间短租平台</span> -->
              <img src="img/home/logo_home_0520.png" alt="">
            </div>
            <div class="header-body-content clearfix">
                <ul class="header-body-content-list" id="searchTab">
                    <li><a href="javascript:;" data-type="site_library" data-hold="搜索场地，你可以输入场地名或者地标进行查找" class="search-active">找场地</a></li>
                    <li><a href="javascript:;" data-type="project_library" data-hold="搜索资讯，关注行业内最新最热的活动资讯">找资讯</a></li>
                    {*<li><a href="javascript:;" data-type=""  data-hold="请搜索你想要的文创,我们会快速与您匹配">找文创</a></li>*}
                    <li><a href="javascript:;" data-type="company_library"  data-hold="搜索行业内公司">找公司</a></li>
                    <li><a href="javascript:;" data-type="paper_library"  data-hold="找PPT,策划方案、演讲稿、合同范例">找文档</a></li>
                </ul>
                <div class="header-body-content-side fr">
                  <a href="{Web_Global::createRentSpaceUrl()}" class="yun-icon icon-1">
                    <span class="span-last">一键租场地</span>
                  </a>
                </div>
            </div>
            <div class="triangle">
                <div class="triangle-up active-one" id="triangle-up"></div>
            </div>
            <div class="header-body-form clearfix">
                <div class="header-body-input fl">
                    <input type="hidden" class="search_type" name="search_type" value="site_library">
                    <input type="text" class="keyword1 none" name="keyword" autocomplete="off" placeholder="搜索场地，你可以输入场地名或者地标进行查找">
                    <input type="text" class="keyword2 none" name="keyword" autocomplete="off" placeholder="搜索场地，你可以输入场地名或者地标进行查找" id="suggestId2">
                </div>
                <div class="header-body-button fl">
                    <a href="javascript:;" id="search-space-two" data-root="{$_root}">
                      <div class="search-icon"></div>
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="cate-flud">
  <div class="cate-container clearfix">
    <div class="cate-container-list fl">
      <div class="cate-container-li first">
        <span>空间</span>
      </div>
      <div class="cate-container-li-info cate-container-li-info_first">
          <a href="{$_home}site/{Func_Url::str_urlencode('场地推荐')}" class="top-rec">场地推荐<span class="week-four"></span></a>
          <a href="{Web_Global::createRentSpaceUrl()}">租赁</a>
          <a href="{$_home}article/3135554.html">短租</a>
          <a href="{$_root}site_join">出租</a>
          <a href="{$_root}insurance">安全</a>
      </div>
    </div>
    <div class="border"></div>
    <div class="cate-container-list fl">
      <div class="cate-container-li">
        <span>文创</span>
      </div>
      <div class="cate-container-li-info">
          <a href="{$_home}sites/200" class="hot-top">热门项目</a><span class="hot-bg"></span>
          <a href="{$_home}winchance">项目合作</a>
          <a href="{$_home}article/3142345.html">我有项目</a>
      </div>
    </div>
    <div class="border"></div>
    <div class="cate-container-list fl">
      <div class="cate-container-li">
        <span>零售</span>
      </div>
      <div class="cate-container-li-info">
          {*<a href="{$_home}site/{Func_Url::str_urlencode('创意租售')}">创意租售</a>*}
          <a href="{$_home}site/{Func_Url::str_urlencode('快闪店')}">快闪店</a>
          <a href="{$_home}site/{Func_Url::str_urlencode('店中店')}">店中店</a>
          <a href="{$_home}site/{Func_Url::str_urlencode('DP点')}">DP点</a>
          <a href="{$_home}site/{Func_Url::str_urlencode('showroom')}">showroom</a>
          {*<a href="{$_home}site/{Func_Url::str_urlencode('快闪店')}"></a>*}
          {*<a href="http://d15.yunspace.com.cn/feature/2015.9/join/index.html" target="_blank">招代理商</a>*}
      </div>
    </div>
    <div class="border"></div>
    <div class="cate-container-list fl">
      <div class="cate-container-li">
        <span>发现</span>
      </div>
      <div class="cate-container-li-info">
          <a href="{$_home}article/3140721.html" class="day-news">
            我要投稿
            <span class="day-news-all">
            </span>
          </a>
          <a href="{$_home}site/{Func_Url::str_urlencode('全国')}">全国</a>
          <a href="{$_home}site/{Func_Url::str_urlencode('海外')}">海外</a>
          <a href="{$_home}site/{Func_Url::str_urlencode('榜单')}">榜单</a>
      </div>
    </div>
    <div class="border"></div>
    <div class="cate-container-list fl">
      <div class="cate-container-li">
        <span>数据库</span>
      </div>
      <div class="cate-container-li-info last">
          <a href="{$_home}spaces-tags/">场地库</a>
          <a href="{$_home}article-keyword/">资讯库</a>
          {*<a href="{$_home}company-keyword/">公司库</a>*}
          <a href="{$_home}winchance">项目库</a>
          <a href="{$_home}doc-keyword/">文库</a>
      </div>
    </div>
  </div>
</div>

<div class="home-container-content">
    <div class="home-tab clearfix">
      <div class="fl home-tab-list home-tab-list-active"><span>特别专题</span></div>
      <div class="fl home-tab-list"><span>每日推荐</span></div>
      <div class="fl home-tab-list home-tab-list-last"><span>精选场地</span></div>
    </div>
    <div class="home-recommend">
        <ul class="home-recommend-list clearfix">
            <li>
            <a href="{$_home}topic/market" target="_blank">
                <div class="home_tab_tag">
                    <img src="img/home/home_icon10.jpg">
                </div>
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
                <div class="home_tab_tag">
                    <img src="img/home/home_icon10.jpg">
                </div>
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
                <div class="home_tab_tag">
                    <img src="img/home/home_icon10.jpg">
                </div>
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
                <div class="home_tab_tag">
                    <img src="img/home/home_icon10.jpg">
                </div>
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
        <ul class="home-recommend-list clearfix none">
            {foreach $everydayRecommend as $k=>$v}
            <li>
                <a href="{if $v['category_id']!=200 && $v['category_id']!=300 && $v['category_id']!=400}{$_home}site/{Func_Url::str_urlencode($v['space_name'] ,1)}{else}{$_home}site/{Func_Url::str_urlencode($v['space_name'])}{/if}">
                    <div class="home_tab_tag">
                        {if $v['category_id']==200}
                            <img src="img/home/home_icon6.png">
                        {elseif $v['category_id']==300}
                            <img src="img/home/home_icon7.png">
                        {elseif $v['category_id']==400}
                            <img src="img/home/home_icon9.jpg">
                        {else}
                            <img src="img/home/home_icon5.png">
                        {/if}
                    </div>
                    <div class="coverr"></div>
                    <div class="home-recommend-img">
                        <img src="{Page_Site_Global::displayMedia($v['logo'],280,280)}" alt="{$v['space_name']}"/>
                    </div>
                    <div class="home-recommend-text">
                        <div class="body">
                            <p class="home_tab_text1">{$v['space_name']}</p>
                            {if !empty($v['attr']['营销标题'])}
                                <p class="home_tab_text2">——{$v['attr']['营销标题']}</p>
                            {elseif !empty($v['addr'])}
                                <p class="home_tab_text2">——{$v['addr']}</p>
                            {else}
                                <p class="home_tab_text2">......</p>
                            {/if}
                        </div>
                        <div class="body_mask"></div>
                    </div>
                </a>
            </li>
            {/foreach}
        </ul>
        <ul class="home-recommend-list clearfix none">
            {foreach $spaceRecommend as $k=>$v}
            <li>
                <a href="{$_home}site/{Func_Url::str_urlencode($v['space_name'],1)}">
                    <div class="home_tab_tag">
                        <img src="img/home/home_icon5.png">
                    </div>
                  <div class="coverr"></div>
                  <div class="home-recommend-img">
                      <img src="{Page_Site_Global::displayMedia($v['logo'],280,280)}" alt="{$v['space_name']}"/>
                  </div>
                  <div class="home-recommend-text">
                      <div class="body">
                          <p class="home_tab_text1">{$v['space_name']}</p>
                          {if !empty($v['attr']['营销标题'])}
                              <p class="home_tab_text2">——{$v['attr']['营销标题']}</p>
                          {elseif !empty($v['addr'])}
                              <p class="home_tab_text2">——{$v['addr']}</p>
                          {else}
                              <p class="home_tab_text2">......</p>
                          {/if}
                      </div>
                      <div class="body_mask"></div>
                  </div>
                </a>
            </li>
            {/foreach}
        </ul>
        {*<ul class="home-recommend-list clearfix none">*}
            {*{foreach $wenChuangRecommend as $k=>$v}*}
            {*<li>*}
                {*<a href="{$_home}site/{Func_Url::str_urlencode($v['space_name'])}">*}
                    {*<div class="home_tab_tag">*}
                        {*<img src="img/home/home_icon6.png">*}
                    {*</div>*}
                    {*<div class="coverr"></div>*}
                    {*<div class="home-recommend-img">*}
                        {*<img src="{Page_Site_Global::displayMedia($v['logo'],280,280)}" alt="{$v['space_name']}"/>*}

                    {*</div>*}
                    {*<div class="home-recommend-text">*}
                        {*<div class="body">*}
                            {*<p class="home_tab_text1">{$v['space_name']}</p>*}
                            {*{if !empty($v['attr']['营销标题'])}*}
                                {*<p class="home_tab_text2">{$v['attr']['营销标题']}</p>*}
                            {*{elseif !empty($v['addr'])}*}
                                {*<p class="home_tab_text2">{$v['addr']}</p>*}
                            {*{else}*}
                                {*<p class="home_tab_text2">......</p>*}
                            {*{/if}*}
                        {*</div>*}
                        {*<div class="body_mask"></div>*}
                    {*</div>*}
                {*</a>*}
            {*</li>*}
            {*{/foreach}*}
        {*</ul>*}
    </div>
    <div class="compain">
        <div yun="pa/pa.js::add" yun-name="HomeA"></div>
    </div>
    <div class="content">
      <div class="content-list">
        <div class="content-header clearfix">
          <div class="content-header-title fl">
              <div class="img bg1">
              </div>
              <div class="txt">
                <span class="color1">
                  空间
                </span>
              </div>
          </div>

            <ul class="content-header-list clearfix fl">
                <li><a href="{$_home}sites/112-113-tags/{Func_Url::str_urlencode('秀场展馆')}">秀场展馆</a></li>
                <li><a href="{$_home}sites/112-114-tags/{Func_Url::str_urlencode('商业广场')}">商业广场</a></li>
                <li><a href="{$_home}sites/112-115-tags/{Func_Url::str_urlencode('艺术馆画廊')}">艺术馆画廊</a></li>
                <li><a href="{$_home}sites/112-116-tags/{Func_Url::str_urlencode('体育场馆')}">体育场馆</a></li>
                <li><a href="{$_home}sites/112-117-tags/{Func_Url::str_urlencode('影院剧院')}">影院剧院</a></li>
                <li><a href="{$_home}sites/112-118-tags/{Func_Url::str_urlencode('餐厅酒吧')}">餐厅酒吧</a></li>
                <li><a href="{$_home}sites/112-119-tags/{Func_Url::str_urlencode('高端会所')}">高端会所</a></li>
                <li><a href="{$_home}sites/112-120-tags/{Func_Url::str_urlencode('星级酒店')}">星级酒店</a></li>
                <li><a href="{$_home}sites/112-121-tags/{Func_Url::str_urlencode('会务中心')}">会务中心</a></li>
                <li><a href="{$_home}sites/112-122-tags/{Func_Url::str_urlencode('公共空间')}">公共空间</a></li>
            </ul>

          <div class="more clearfix fr">
            <a href="{$_home}sites/112">
              <span class="more-icon"></span>
              <span>更多</span>
            </a>
          </div>
        </div>
        <div class="body-block">
             <div class="body-block-left fl">
                <div class="body_space_img fl">
                  <div class="block-top">
                     <div class="block-top-big fl">
                         <a href="{$_home}site/{Func_Url::str_urlencode($spaceData['pic_space'][0]['space_name'],1)}">
                          <div class="cov"></div>
                          <div class="block-top-big-img">
                              <img src="{Page_Site_Global::displayMedia($spaceData['pic_space'][0]['logo'],465,337)}" alt="{$spaceData['pic_space'][0]['space_name']}">
                          </div>
                          <div class="img-big-title">
                              <span>{$spaceData['pic_space'][0]['space_name']}</span>
                          </div>
                          <div class="img-big-line"></div>
                          <div class='img-big-des'>
                              {if $spaceData['pic_space'][0]['attr']['营销标题']}
                                  <span>{$spaceData['pic_space'][0]['attr']['营销标题']}</span>
                              {elseif $spaceData['pic_space'][0]['addr']}
                                  <span>{$spaceData['pic_space'][0]['addr']}</span>
                              {else}
                                  <span>...</span>
                              {/if}
                          </div>
                       </a>
                     </div>
                     <div class="block-top-right fl clearfix">
                          <div class="block-top-right-li">
                              <a href="{$_home}site/{Func_Url::str_urlencode($spaceData['pic_space'][1]['space_name'],1)}">
                              <div class="cov"></div>
                                  <div class="block-top-right-li-img">
                                      <img src="{Page_Site_Global::displayMedia($spaceData['pic_space'][1]['logo'],232,168)}" alt="{$spaceData['pic_space'][1]['space_name']}">
                                  </div>
                                  <div class="com-small-title">
                                      <span>{$spaceData['pic_space'][1]['space_name']}</span>
                                  </div>
                                  <div class="com-small-line"></div>
                                  <div class='com-small-des'>
                                      {if $spaceData['pic_space'][1]['attr']['营销标题']}
                                          <span>{$spaceData['pic_space'][1]['attr']['营销标题']}</span>
                                      {elseif $spaceData['pic_space'][1]['addr']}
                                          <span>{$spaceData['pic_space'][1]['addr']}</span>
                                      {else}
                                          <span>...</span>
                                      {/if}
                                  </div>
                              </a>
                          </div>
                          <div class="block-top-right-li">
                              <a href="{$_home}site/{Func_Url::str_urlencode($spaceData['pic_space'][2]['space_name'],1)}">
                              <div class="cov"></div>
                                  <div class="block-top-right-li-img">
                                      <img src="{Page_Site_Global::displayMedia($spaceData['pic_space'][2]['logo'],232,168)}" alt="{$spaceData['pic_space'][2]['space_name']}">
                                  </div>
                                  <div class="com-small-title">
                                      <span>{$spaceData['pic_space'][2]['space_name']}</span>
                                  </div>
                                  <div class="com-small-line"></div>
                                  <div class='com-small-des'>
                                      {if $spaceData['pic_space'][2]['attr']['营销标题']}
                                          <span>{$spaceData['pic_space'][2]['attr']['营销标题']}</span>
                                      {elseif $spaceData['pic_space'][2]['addr']}
                                          <span>{$spaceData['pic_space'][2]['addr']}</span>
                                      {else}
                                          <span>...</span>
                                      {/if}
                                  </div>
                              </a>
                          </div>
                     </div>
                  </div>
                  <div class="block-bottom">
                      <div class="block-bottom-li fl">
                          <a href="{$_home}site/{Func_Url::str_urlencode($spaceData['pic_space'][3]['space_name'],1)}">

                          <div class="cov"></div>
                              <div class="block-bottom-li-img">
                                  <img src="{Page_Site_Global::displayMedia($spaceData['pic_space'][3]['logo'],232,168)}" alt="{$spaceData['pic_space'][3]['space_name']}">

                              </div>
                              <div class="com-small-title">
                                  <span>{$spaceData['pic_space'][3]['space_name']}</span>

                              </div>
                              <div class="com-small-line"></div>
                              <div class='com-small-des'>
                                  {if $spaceData['pic_space'][3]['attr']['营销标题']}
                                      <span>{$spaceData['pic_space'][3]['attr']['营销标题']}</span>
                                  {elseif $spaceData['pic_space'][3]['addr']}
                                      <span>{$spaceData['pic_space'][3]['addr']}</span>
                                  {else}
                                      <span>...</span>
                                  {/if}
                              </div>
                          </a>
                      </div>
                      <div class="block-bottom-li fl">
                          <a href="{$_home}site/{Func_Url::str_urlencode($spaceData['pic_space'][4]['space_name'],1)}">

                          <div class="cov"></div>
                              <div class="block-bottom-li-img">
                                  <img src="{Page_Site_Global::displayMedia($spaceData['pic_space'][4]['logo'],232,168)}" alt="{$spaceData['pic_space'][4]['space_name']}">
                              </div>
                              <div class="com-small-title">
                                  <span>{$spaceData['pic_space'][4]['space_name']}</span>

                              </div>
                              <div class="com-small-line"></div>
                              <div class='com-small-des'>
                                  {if $spaceData['pic_space'][4]['attr']['营销标题']}
                                      <span>{$spaceData['pic_space'][4]['attr']['营销标题']}</span>
                                  {elseif $spaceData['pic_space'][4]['addr']}
                                      <span>{$spaceData['pic_space'][4]['addr']}</span>
                                  {else}
                                      <span>...</span>
                                  {/if}
                              </div>
                          </a>
                      </div>
                      <div class="block-bottom-li fl clearfix">
                          <a href="{$_home}site/{Func_Url::str_urlencode($spaceData['pic_space'][5]['space_name'],1)}">

                          <div class="cov"></div>
                              <div class="block-bottom-li-img">
                                  <img src="{Page_Site_Global::displayMedia($spaceData['pic_space'][5]['logo'],232,168)}" alt="{$spaceData['pic_space'][5]['space_name']}">
                              </div>
                              <div class="com-small-title">
                                  <span>{$spaceData['pic_space'][5]['space_name']}</span>

                              </div>
                              <div class="com-small-line"></div>
                              <div class='com-small-des'>
                                  {if $spaceData['pic_space'][5]['attr']['营销标题']}
                                      <span>{$spaceData['pic_space'][5]['attr']['营销标题']}</span>
                                  {elseif $spaceData['pic_space'][5]['addr']}
                                      <span>{$spaceData['pic_space'][5]['addr']}</span>
                                  {else}
                                      <span>...</span>
                                  {/if}
                              </div>
                          </a>
                      </div>
                  </div>
                </div>
                <div class="body_space_right fl clearfix">
                    <div class="special-li">
                      <a href="{$_home}space_library?action=form">
                          <div class="special-li-cover"></div>
                          <div class="special-li-icon">
                             <img src="img/home/home_icon1.png">
                          </div>
                          <div class="special-li-BigTittle">一键租场地</div>
                          <div class="special-li-SmallTittle">省时、省心，找你所想</div>
                          <img src="img/home/home_01.jpg">
                      </a>
                    </div>
                    <div class="special-li">
                        <a href="{$_home}map2">
                            <div class="special-li-cover"></div>
                            <div class="special-li-icon">
                                <img src="img/home/home_icon2.png">
                            </div>
                            <div class="special-li-BigTittle">场地地图</div>
                            <div class="special-li-SmallTittle">发现场地，快速定位</div>
                            <img src="img/home/home_02.jpg">
                        </a>
                    </div>
                    <div class="special-li">
                        <a href="{$_home}site_join">
                            <div class="special-li-cover"></div>
                            <div class="special-li-icon">
                                <img src="img/home/home_icon3.png">
                            </div>
                            <div class="special-li-BigTittle">场地出租</div>
                            <div class="special-li-SmallTittle">让你的场地轻松变现</div>
                            <img src="img/home/home_03.jpg">
                        </a>
                    </div>
                    <ul class="tag_space">
                        {foreach $spaceData['space_name'] as $k=>$v}
                         <li><a href="{$_home}site/{Func_Url::str_urlencode($v,1)}">{$v}</a> </li>
                        {/foreach}
                        <div class="clear"></div>
                    </ul>
                </div>
             </div>


             <div class="body-block-right fr clearfix">
                 <p class="reading">推荐阅读</p>
                 <ul class="reading-list">
                     {foreach $spaceData['recommend'] as $k=>$v}
                    {if $v['logo']}
                     <li>
                         {if $k==0}
                             <div class="reading-list-gai"></div>
                         {/if}
                         <div class="reading-list-circle"></div>
                         <div class="reading-list-word fl">
                             <p class="reading-list-title">
                                 <a href="{$_home}article/{$v['id']}.html">{$v['space_name']}</a>
                             </p>
                             <p class="reading-list-time">{if $v['create_time']}{date('Y-m-d',$v['create_time'])}{/if}</p>
                         </div>
                         <div class="reading-list-img fl clearfix">
                             <a href="{$_home}article/{$v['id']}.html">
                                 <img src="{Page_Site_Global::displayMedia($v['logo'],69,51)}" alt="{$v['space_name']}">
                             </a>
                         </div>
                     </li>
                         {else}
                     <li>
                         {if $k==0}
                             <div class="reading-list-gai"></div>
                         {/if}
                         <div class="reading-list-circle"></div>
                         {*没有图片调得类*}
                         <div class="reading-list-word1">
                             <p class="reading-list-title">
                                 <a href="{$_home}article/{$v['id']}.html">{$v['space_name']}</a>
                             </p>
                             <p class="reading-list-time">{if $v['create_time']}{date('Y-m-d',$v['create_time'])}{/if}</p>
                         </div>
                     </li>
                         {/if}
                     {/foreach}

                 </ul>
                 <div class="reading-more">
                     <a href="{$_home}article_list/112.html">
                         <div class="reading-more-word">更多资讯</div>
                        <img src="img/home/home_05.jpg">
                     </a>
                 </div>
             </div>
        </div>
      </div>

      <div class="compain">
          <div yun="pa/pa.js::add" yun-name="HomeB"></div>
      </div>

      <div class="content-list">
        <div class="content-header clearfix">
          <div class="content-header-title fl">
              <div class="img bg2">
              </div>
              <div class="txt">
                <span class="color2">
                  文创
                </span>
              </div>
          </div>

            <ul class="content-header-list clearfix fl">
              <li><a href="{$_home}site/{Func_Url::str_urlencode('Yoohoo和他的朋友')}">Yoohoo和他的朋友</a></li>
              <li><a href="{$_home}site/{Func_Url::str_urlencode('十万个冷笑话主题巡展')}">十万个冷笑话主题巡展</a></li>
              <li><a href="{$_home}site/{Func_Url::str_urlencode('大嘴猴巡展')}">大嘴猴巡展</a></li>
              <li><a href="{$_home}site/{Func_Url::str_urlencode('移动迷宫')}">移动迷宫</a></li>
              <li><a href="{$_home}site/{Func_Url::str_urlencode('大头儿子嘉年华')}">大头儿子嘉年华</a></li>
              <li><a href="{$_home}site/{Func_Url::str_urlencode('列奥纳多·达芬奇作品展')}">列奥纳多·达芬奇作品展</a></li>
              {*<li><a href="{$_home}site/超能陆战队-超能英雄体验营">超能陆战队-超能英雄体验营</a></li>*}
              <li><a href="{$_home}site/{Func_Url::str_urlencode('Marvel主题体验站')}">Marvel主题体验展</a></li>
            </ul>

          <div class="more clearfix fr">
            <a href="{$_home}sites/200">
              <span class="more-icon"></span>
              <span>更多</span>
            </a>
          </div>
        </div>
          <div class="body-block">
              <div class="body-block-left fl">
                  <div class="fl block-bottom-big">
                      <div class="block-bottom-li fl">
                          <a href="{$_home}site/{Func_Url::str_urlencode($wenChuangData['pic_space'][0]['space_name'])}">
                          <div class="cov"></div>
                              <div class="block-bottom-li-img">
                                  <img src="{Page_Site_Global::displayMedia($wenChuangData['pic_space'][0]['logo'],232,505)}" alt="{$wenChuangData['pic_space'][0]['space_name']}">
                              </div>
                              <div class="img-shu-title">
                                  <span>{$wenChuangData['pic_space'][0]['space_name']}</span>
                              </div>
                              <div class="img-shu-line"></div>
                              <div class='img-shu-des'>
                                  {if $wenChuangData['pic_space'][0]['attr']['营销标题']}
                                      <span>{$wenChuangData['pic_space'][0]['attr']['营销标题']}</span>
                                  {elseif $wenChuangData['pic_space'][0]['addr']}
                                      <span>{$wenChuangData['pic_space'][0]['addr']}</span>
                                  {else}
                                      <span>...</span>
                                  {/if}
                              </div>
                          </a>
                      </div>
                      <div class="block-bottom-li fl mb1">
                          <a href="{$_home}site/{Func_Url::str_urlencode($wenChuangData['pic_space'][1]['space_name'])}">
                          <div class="cov"></div>
                              <div class="block-bottom-li-img">
                                  <img src="{Page_Site_Global::displayMedia($wenChuangData['pic_space'][1]['logo'],232,168)}" alt="{$wenChuangData['pic_space'][1]['space_name']}">

                              </div>
                              <div class="com-small-title">
                                  <span>{$wenChuangData['pic_space'][1]['space_name']}</span>

                              </div>
                              <div class="com-small-line"></div>
                              <div class='com-small-des'>
                                  {if $wenChuangData['pic_space'][1]['attr']['营销标题']}
                                      <span>{$wenChuangData['pic_space'][1]['attr']['营销标题']}</span>
                                  {elseif $wenChuangData['pic_space'][1]['addr']}
                                      <span>{$wenChuangData['pic_space'][1]['addr']}</span>
                                  {else}
                                      <span>...</span>
                                  {/if}
                              </div>
                          </a>
                      </div>
                      <div class="block-bottom-li fl mb1">
                          <a href="{$_home}site/{Func_Url::str_urlencode($wenChuangData['pic_space'][2]['space_name'])}">
                          <div class="cov"></div>
                              <div class="block-bottom-li-img">
                                  <img src="{Page_Site_Global::displayMedia($wenChuangData['pic_space'][2]['logo'],232,168)}" alt="{$wenChuangData['pic_space'][2]['space_name']}">
                              </div>
                              <div class="com-small-title">
                                  <span>{$wenChuangData['pic_space'][2]['space_name']}</span>
                              </div>
                              <div class="com-small-line"></div>
                              <div class='com-small-des'>
                                  {if $wenChuangData['pic_space'][2]['attr']['营销标题']}
                                      <span>{$wenChuangData['pic_space'][2]['attr']['营销标题']}</span>
                                  {elseif $wenChuangData['pic_space'][2]['addr']}
                                      <span>{$wenChuangData['pic_space'][2]['addr']}</span>
                                  {else}
                                      <span>...</span>
                                  {/if}
                              </div>
                          </a>
                      </div>
                      <div class="block-bottom-li fl mb1">
                          <a href="{$_home}site/{Func_Url::str_urlencode($wenChuangData['pic_space'][3]['space_name'])}">

                          <div class="cov"></div>
                              <div class="block-bottom-li-img">
                                  <img src="{Page_Site_Global::displayMedia($wenChuangData['pic_space'][3]['logo'],465,168)}" alt="{$wenChuangData['pic_space'][3]['space_name']}">

                              </div>
                              <div class="com-small-title">
                                  <span>{$wenChuangData['pic_space'][3]['space_name']}</span>

                              </div>
                              <div class="com-small-line"></div>
                              <div class='com-small-des'>

                              {if $wenChuangData['pic_space'][3]['attr']['营销标题']}
                                  <span>{$wenChuangData['pic_space'][3]['attr']['营销标题']}</span>
                              {elseif $wenChuangData['pic_space'][3]['addr']}
                                  <span>{$wenChuangData['pic_space'][3]['addr']}</span>
                              {else}
                                  <span>...</span>
                              {/if}
                              </div>
                          </a>
                      </div>
                      <div class="block-bottom-li fl">
                          <a href="{$_home}site/{Func_Url::str_urlencode($wenChuangData['pic_space'][4]['space_name'])}">
                          <div class="cov"></div>
                              <div class="block-bottom-li-img">
                                  <img src="{Page_Site_Global::displayMedia($wenChuangData['pic_space'][4]['logo'],232,168)}" alt="{$wenChuangData['pic_space'][4]['space_name']}"/>

                              </div>
                              <div class="com-small-title">
                                  <span>{$wenChuangData['pic_space'][4]['space_name']}</span>
                              </div>
                              <div class="com-small-line"></div>
                              <div class='com-small-des'>
                                  {if $wenChuangData['pic_space'][4]['attr']['营销标题']}
                                      <span>{$wenChuangData['pic_space'][4]['attr']['营销标题']}</span>
                                  {elseif $wenChuangData['pic_space'][4]['addr']}
                                      <span>{$wenChuangData['pic_space'][4]['addr']}</span>
                                  {else}
                                      <span>...</span>
                                  {/if}
                              </div>
                          </a>
                      </div>
                      <div class="block-bottom-li fl clearfix">
                          <a href="{$_home}site/{Func_Url::str_urlencode($wenChuangData['pic_space'][5]['space_name'])}">
                          <div class="cov"></div>
                              <div class="block-bottom-li-img">
                                  <img src="{Page_Site_Global::displayMedia($wenChuangData['pic_space'][5]['logo'],232,168)}" alt="{$wenChuangData['pic_space'][5]['space_name']}">

                              </div>
                              <div class="com-small-title">
                                  <span>{$wenChuangData['pic_space'][5]['space_name']}</span>
                              </div>
                              <div class="com-small-line"></div>
                              <div class='com-small-des'>
                                  {if $wenChuangData['pic_space'][5]['attr']['营销标题']}
                                      <span>{$wenChuangData['pic_space'][5]['attr']['营销标题']}</span>
                                  {elseif $wenChuangData['pic_space'][5]['addr']}
                                      <span>{$wenChuangData['pic_space'][5]['addr']}</span>
                                  {else}
                                      <span>...</span>
                                  {/if}
                              </div>
                          </a>
                      </div>
                  </div>
                  <div class="body_space_right fl clearfix">
                      <div class="special-li">
                          <a href="{$_home}winchance">
                              <div class="special-li-cover"></div>
                              <div class="special-li-icon">
                                  <img src="img/home/home_icon4.png">
                              </div>
                              <div class="special-li-BigTittle">文创项目库</div>
                              <div class="special-li-SmallTittle">IP项目落地一站式服务</div>
                              <img src="img/home/home_04.jpg">
                          </a>
                      </div>
                      <ul class="tag_wenchuang">
                          {foreach $wenChuangData['space_name'] as $k=>$v}
                            <li>  <a href="{$_home}site/{$v}">{$v}</a></li>
                          {/foreach}
                          <div class="clear"></div>
                      </ul>

              </div>
              </div>
              <div class="body-block-right fr clearfix">
                  <p class="reading">推荐阅读</p>
                  <ul class="reading-list">
                      {foreach $wenChuangData['recommend'] as $k=>$v}
                        {if $v['logo']}
                      <li>
                           {if $k==0}
                              <div class="reading-list-gai"></div>
                           {/if}
                          <div class="reading-list-circle"></div>
                          <div class="reading-list-word fl">
                              <p class="reading-list-title">
                                  <a href="{$_home}article/{$v['id']}.html">{$v['space_name']}</a>
                              </p>
                              <p class="reading-list-time">{if $v['create_time']}{date('Y-m-d',$v['create_time'])}{/if}</p>
                          </div>
                          <div class="reading-list-img fl clearfix">
                              <a href="{$_home}article/{$v['id']}.html">
                                  <img src="{Page_Site_Global::displayMedia($v['logo'],69,51)}"">
                              </a>
                          </div>
                      </li>
                          {else}
                      <li>
                          {if $k==0}
                              <div class="reading-list-gai"></div>
                          {/if}
                          <div class="reading-list-circle"></div>
                          {*没有图片调得类*}
                          <div class="reading-list-word1">
                              <p class="reading-list-title">
                                  <a href="{$_home}article/{$v['id']}.html">{$v['space_name']}</a>
                              </p>
                              <p class="reading-list-time">{if $v['create_time']}{date('Y-m-d',$v['create_time'])}{/if}</p>
                          </div>
                      </li>
                          {/if}
                      {/foreach}
                  </ul>
                  <div class="reading-more">
                      <a href="{$_home}article_list/200.html">
                          <div class="reading-more-word">更多资讯</div>
                          <img src="img/home/home_05.jpg">
                      </a>
                  </div>
              </div>
          </div>
      </div>

      <div class="compain">
          <div yun="pa/pa.js::add" yun-name="HomeC"></div>
      </div>

      <div class="content-list">
          <div class="content-header clearfix">
              <div class="content-header-title fl">
                  <div class="img bg5">
                  </div>
                  <div class="txt">
                <span class="color5">
                  零售
                </span>
                  </div>
              </div>

              <ul class="content-header-list clearfix fl">
                  <li><a href="{$_home}retail">零售短租</a></li>
                  <li><a href="{$_home}article_list/400.html" target="_blank">零售资讯</a></li>
              </ul>

              <div class="more clearfix fr">
                  <a href="{$_home}retail">
                      <span class="more-icon"></span>
                      <span>更多</span>
                  </a>
              </div>
          </div>
          <div class="body-block">
              <div class="body-left fl">
                  <div class="body-link body-link-first">
                      <div class="body-link-title">
                          <span>热门形式</span>
                      </div>
                      <div class='body-link-list body-link-list-first'>
                          {foreach $consultData['space_name'] as $k=>$v}
                              <a href="{$_home}site/{$v}">{$v}</a>
                          {/foreach}
                          {*{var_dump($consultData['new_space'] )}*}
                      </div>
                  </div>
                  {*{include file="Web_Static::inc/consult_list.tpl"}*}
                  <div class="body-link-title">
                      <span>最新动态</span>
                  </div>
                  <ul class='body-link-list'>
                      {foreach $consultData['new_space'] as $k=>$v}
                          <li><a href="{$_home}article/{$v['id']}.html">{$v['title']}</a></li>
                      {/foreach}


                  </ul>
              </div>
              <div class="body-center fl">
                  <!-- 主题图片4 -->
                  <div class="body-center-four clearfix">
                      {foreach $consultData['pic_space'] as $k=>$v}
                          <div class="four-img fl">
                              <a href="{$_home}site/{Func_Url::str_urlencode($v['space_name'])}">
                                  <div class="four-img-cov"></div>
                                  <div class="img">
                                      <img src="{Page_Site_Global::displayMedia($v['logo'],210,251)}" alt="">
                                  </div>
                                  <div class="four-img-title">
                                      <span>{$v['space_name']}</span>
                                  </div>
                                  <div class="four-top-line"></div>
                                  <div class="four-img-des">
                                      {if $v['attr']['营销标题']}
                                          <span>{$v['attr']['营销标题']}</span>
                                      {elseif $v['addr']}
                                          <span>{$v['addr']}</span>
                                      {else}
                                          <span>...</span>
                                      {/if}
                                  </div>
                              </a>
                          </div>
                      {/foreach}


                  </div>
              </div>
              <div class="body-right fl">
                  <div class="recomend">
                      <div class="recomend-title"><span>精选推荐</span></div>
                      <div class="recomend-list">
                          {foreach $consultData['recommend'] as $k=>$v}
                              <a href="{$_home}article/{$v['id']}.html">
                                  <div class="recomend-list-li clearfix">
                                      <div class="recomend-li-left fl">
                                          <div class="recomend-p"><span>{$v['space_name']}</span></div>
                                          <div class="news_bad clearfix">{$v['counter_view']}</div>
                                          <div class="news_good">{$v['counter_praise']}</div>                              </div>
                                      <div class="recomend-li-right fr">
                                          <img src="{Page_Site_Global::displayMedia($v['logo'],81,59)}" alt="">
                                      </div>
                                  </div>
                              </a>
                          {/foreach}
                      </div>
                  </div>
                  <a href="">
                      <div class="right-compain">
                          <div yun="pa/pa.js::add" yun-name="Home-零售"></div>
                      </div>
                  </a>
              </div>
          </div>
      </div>
      <div class="compain">
          <div yun="pa/pa.js::add" yun-name="HomeD"></div>
      </div>

      <div class="content-list">
        <div class="content-header clearfix">
          <div class="content-header-title fl">
              <div class="img bg3">
              </div>
              <div class="txt">
                <span class="color3">
                  发现
                </span>
              </div>
          </div>

            <ul class="content-header-list clearfix fl">
              <li><a href="{$_home}site/{Func_Url::str_urlencode('老建筑改造')}">老建筑改造</a></li>
              <li><a href="{$_home}site/{Func_Url::str_urlencode('美食节')}">美食节</a></li>
              <li><a href="{$_home}site/{Func_Url::str_urlencode('淘宝集市')}">淘宝集市</a></li>
              <li><a href="{$_home}site/{Func_Url::str_urlencode('快闪店')}">快闪店</a></li>
              <li><a href="{$_home}site/{Func_Url::str_urlencode('众创空间')}">众创空间</a></li>
            </ul>

          <div class="more clearfix fr">
            <a href="{$_home}article_list/300.html">
              <span class="more-icon"></span>
              <span>更多</span>
            </a>
          </div>
        </div>
        <div class="body-block">
          <div class="body-left fl">
            <div class="body-link">
              <ul class=' consult-list'>
                  {foreach $findData['new_space'] as $k=>$v}
                  <li>
                      <a href="{$_home}article/{$v['id']}.html" class="consult-li">
                          <div class="circle"></div>
                          <div class="title"><span>{$v['space_name']}</span></div>
                          <div class="time"><span>{Func_Time::format($v['create_time'])}</span></div>
                      </a>
                  </li>
                  {/foreach}
                  {*<li><a href="{$_home}article/{$v['id']}.html">{$v['space_name']}</a></li>*}
              </ul>
            </div>
          </div>
          <div class="body-center fl">
            <!-- 主题图片2 -->
              <div class="body-center-two-left fl">
                <div class="two-img">
                  <a href="{$_home}site/{Func_Url::str_urlencode({$findData['pic_space'][0]['space_name']})}">
                    <div class="cov"></div>
                    <div class="img">
                      <img src="{Page_Site_Global::displayMedia($findData['pic_space'][0]['logo'],390,502)}" alt="">
                    </div>
                    <div class="two-left-title">
                      <span>{$findData['pic_space'][0]['space_name']}</span>
                    </div>
                    <div class="two-left-title">
                      <span></span>
                    </div>
                    <div class="two-left-line"></div>
                    <div class="two-left-des">
                        {if $findData['pic_space'][0]['attr']['营销标题']}
                            <span>{$findData['pic_space'][0]['attr']['营销标题']}</span>
                        {elseif $findData['pic_space'][0]['addr']}
                            <span>{$findData['pic_space'][0]['addr']}</span>
                        {else}
                            <span>...</span>
                        {/if}
                    </div>
                  </a>
                </div>
              </div>
              <div class="body-center-two-right fr">
                <div class="com-small">
                  <a href="{$_home}site/{Func_Url::str_urlencode({$findData['pic_space'][1]['space_name']})}">
                    <div class="cov"></div>
                    <div class="com-small-img">
                      <img src="{Page_Site_Global::displayMedia($findData['pic_space'][1]['logo'],210,167)}" alt="">
                    </div>
                    <div class="com-small-title">
                      <span>{$findData['pic_space'][1]['space_name']}</span>
                    </div>
                    <div class="com-small-line"></div>
                    <div class='com-small-des'>
                        {if $findData['pic_space'][1]['attr']['营销标题']}
                            <span>{$findData['pic_space'][1]['attr']['营销标题']}</span>
                        {elseif $findData['pic_space'][1]['addr']}
                            <span>{$findData['pic_space'][1]['addr']}</span>
                        {else}
                            <span>...</span>
                        {/if}
                    </div>
                  </a>
                </div>
                <div class="com-small">
                  <a href="{$_home}site/{Func_Url::str_urlencode({$findData['pic_space'][2]['space_name']})}">
                    <div class="cov"></div>
                    <div class="com-small-img">
                      <img src="{Page_Site_Global::displayMedia($findData['pic_space'][2]['logo'],210,167)}" alt="">
                    </div>
                    <div class="com-small-title">
                      <span>{$findData['pic_space'][2]['space_name']}</span>
                    </div>
                    <div class="com-small-line"></div>
                    <div class='com-small-des'>
                        {if $findData['pic_space'][2]['attr']['营销标题']}
                            <span>{$findData['pic_space'][2]['attr']['营销标题']}</span>
                        {elseif $findData['pic_space'][2]['addr']}
                            <span>{$findData['pic_space'][2]['addr']}</span>
                        {else}
                            <span>...</span>
                        {/if}
                    </div>
                  </a>
                </div>
                <div class="com-small">
                  <a href="{$_home}site/{Func_Url::str_urlencode({$findData['pic_space'][3]['space_name']})}">
                    <div class="cov"></div>
                    <div class="com-small-img">
                      <img src="{Page_Site_Global::displayMedia($findData['pic_space'][3]['logo'],210,167)}" alt="">
                    </div>
                    <div class="com-small-title">
                      <span>{$findData['pic_space'][3]['space_name']}</span>
                    </div>
                    <div class="com-small-line"></div>
                    <div class='com-small-des'>
                        {if $findData['pic_space'][3]['attr']['营销标题']}
                            <span>{$findData['pic_space'][3]['attr']['营销标题']}</span>
                        {elseif $findData['pic_space'][3]['addr']}
                            <span>{$findData['pic_space'][3]['addr']}</span>
                        {else}
                            <span>...</span>
                        {/if}
                    </div>
                  </a>
                </div>
              </div>
          </div>
          <div class="body-right fl">
            <div class="recomend">
              <div class="recomend-title"><span>精选推荐</span></div>
              <div class="recomend-list">
                  {foreach $findData['recommend'] as $k=>$v}
                      <a href="{$_home}article/{$v['id']}.html">
                          <div class="recomend-list-li clearfix">
                              <div class="recomend-li-left fl">
                                  <div class="recomend-p"><span>{$v['space_name']}</span></div>
                                  <div class="news_bad clearfix">{$v['counter_view']}</div>
                                  <div class="news_good">{$v['counter_praise']}</div>                              </div>
                              <div class="recomend-li-right fr">
                                  <img src="{Page_Site_Global::displayMedia($v['logo'],81,59)}" alt="">
                              </div>
                          </div>
                      </a>
                  {/foreach}

              </div>
            </div>
            <a href="">
              <div class="right-compain">
                  <div yun="pa/pa.js::add" yun-name="Home-发现"></div>
              </div>
            </a>

          </div>

        </div>
      </div>

      <div class="compain">
          <div yun="pa/pa.js::add" yun-name="HomeE"></div>
      </div>

      <div class="content-list">
        <div class="content-header clearfix">
          <div class="content-header-title fl">
              <div class="img bg6">
              </div>
              <div class="txt">
                <span  class="color6">
                  近期阅读榜
                </span>
              </div>
          </div>
        </div>
        <div class="body-block clearfix" style="height:auto!important">
          <div class="body-left ranking fl">
            <div class="rank-title"><span>空间</span></div>
            <ul class="rank-list">
              {foreach $spaceList as $k=>$v}
                <li>
                  <a href="{$_home}article/{$v['id']}.html">
                    <div class="rank-num fl">{intval($k)+1}</div>
                    <div class="rank-link fl">{$v['title']}</div>
                    <div class="rank-zan fr icon-5 yun-icon">{$v['counter_view']}</div>
                  </a>
                </li>
              {/foreach}
            </ul>
          </div>
          <div class="body-center ranking fl">
            <div class="rank-title"><span>文创</span></div>
            <ul class="rank-list">
              {foreach $wenChuangList as $k=>$v}
                <li>
                  <a href="{$_home}article/{$v['id']}.html">
                    <div class="rank-num fl">{intval($k)+1}</div>
                    <div class="rank-link fl">{$v['title']}</div>
                    <div class="rank-zan fr icon-5 yun-icon">{$v['counter_view']}</div>
                  </a>
                </li>
              {/foreach}
            </ul>
          </div>
          <div class="body-right ranking fl ranking-last">
            <div class="rank-title"><span>零售</span></div>
            <ul class="rank-list">
              {foreach $consultList as $k=>$v}
                <li>
                  <a href="{$_home}article/{$v['id']}.html">
                    <div class="rank-num fl">{intval($k)+1}</div>
                    <div class="rank-link fl">{$v['title']}</div>
                    <div class="rank-zan fr icon-5 yun-icon">{$v['counter_view']}</div>
                  </a>
                </li>
              {/foreach}
              {*<li class="rank-li-last">*}
                {*<a href="">*}
                  {*<div class="rank-num fl">1</div>*}
                  {*<div class="rank-link fl">独行雾凇岛，有关黑帮女人竟雾凇岛</div>*}
                  {*<div class="rank-zan fr">43435票</div>*}
                {*</a>*}
              {*</li>*}
            </ul>
          </div>
        </div>
      </div>


      <div class="content-list">
        <div class="content-header clearfix">
          <div class="content-header-title fl">
              <div class="img bg7">
              </div>
              <div class="txt">
                <span class="color7">
                  合作品牌
                </span>
              </div>
          </div>
        </div>
        <div class="body-block" style="height:auto!important">
            <img src="img/logo_a_new.jpg">
          {*<ul class="painter clearfix" id="painter">*}
            {*<li class="li-first">*}
              {*<a href="#">*}
                {*<img src="img/home/hez1.jpg" alt="" class="bg-img">*}
                {*<img src="img/home/hez2.jpg" alt="" class="active-img">*}
              {*</a>*}
            {*</li>*}
            {*<li>*}
              {*<a href="#">*}
                {*<img src="img/home/hez1.jpg" alt="" class="bg-img">*}
                {*<img src="img/home/hez2.jpg" alt="" class="active-img">*}
              {*</a>*}
            {*</li>*}
            {*<li>*}
              {*<a href="#">*}
                {*<img src="img/home/hez1.jpg" alt="" class="bg-img">*}
                {*<img src="img/home/hez2.jpg" alt="" class="active-img">*}
              {*</a>*}
            {*</li>*}
            {*<li>*}
              {*<a href="#">*}
                {*<img src="img/home/hez1.jpg" alt="" class="bg-img">*}
                {*<img src="img/home/hez2.jpg" alt="" class="active-img">*}
              {*</a>*}
            {*</li>*}
            {*<li>*}
              {*<a href="#">*}
                {*<img src="img/home/hez1.jpg" alt="" class="bg-img">*}
                {*<img src="img/home/hez2.jpg" alt="" class="active-img">*}
              {*</a>*}
            {*</li>*}
            {*<li>*}
              {*<a href="#">*}
                {*<img src="img/home/hez1.jpg" alt="" class="bg-img">*}
                {*<img src="img/home/hez2.jpg" alt="" class="active-img">*}
              {*</a>*}
            {*</li>*}
            {*<li>*}
              {*<a href="#">*}
                {*<img src="img/home/hez1.jpg" alt="" class="bg-img">*}
                {*<img src="img/home/hez2.jpg" alt="" class="active-img">*}
              {*</a>*}
            {*</li>*}
          {*</ul>*}
        </div>
      </div>

    </div>

</div>
<div class="footer-friends">
  <div class="footer-friends-content clearfix">
    <div class="footer-title"><span>友情链接</span></div>
    <ul class="friends-link clearfix fl">
        <li><a href="http://www.31huiyi.com/" target="_blank">31会议 </a></li>
        {*<li><a href="http://www.tuanyanwang.com" target="_blank">成都婚宴酒楼</a></li>*}
        <li><a href="http://www.91dyzx.com/" target="_blank">第一资讯</a></li>
        <li><a href="http://www.bianzhihui.com/" target="_blank">编织汇</a></li>
        <li><a href="http://www.5988.com" target="_blank">创业商机网</a></li>
        {*<li><a href="http://www.enjoun.com" target="_blank">3d影院</a></li>*}
        <li><a href="http://www.10000show.com/" target="_blank">国际展会</a></li>
        {*<li><a href="http://www.shuomy.com/" target="_blank">生活网</a></li>*}
        <li><a href="http://www.bolaihui.com/" target="_blank">舶来汇</a></li>
        {*<li><a href="http://www.kimberlite.com.cn/" target="_blank">钻石首饰</a></li>*}
        <li><a href="http://www.xitieba.com/" target="_blank">电子喜帖</a></li>
        <li><a href="http://www.hicha.com/" target="_blank">嗨茶网</a></li>
        {*<li><a href="http://www.nam360.com/" target="_blank">录音棚设备</a></li>*}
    </ul>
    {*<div class="footer-right">*}
      {*<div class="footer-other">*}
        {*<a href="">*}
          {*<span class="footer-other-icon">*}
            {*<img src="img/home/weibo_03.jpg" alt="">*}
          {*</span>*}
          {*<span>微博关注</span>*}
        {*</a>*}
      {*</div>*}
      {*<div class="footer-other">*}
        {*<a href="">*}
          {*<span class="footer-other-icon">*}
            {*<img src="img/home/email_11.jpg" alt="">*}
          {*</span>*}
          {*<span>联系我们</span>*}
        {*</a>*}
      {*</div>*}
    {*</div>*}
  </div>
</div>

{include file="Web_Static::inc/public_space.tpl"}
{include file="Web_Static::inc/html_footer.tpl"}

    <script>
        $('#bannerBaike').YunSlide({
            delay : 5000,
            nav : '#bannerNav',
            next : '.carousel-control.right',
            prev : '.carousel-control.left'
        });
        document.onreadystatechange=function(){
            if(document.readyState == 'complete'){ //当页面加载状态
                $(".wrap").find('.item').each(function(k,d) {
                    var $d=$(d);
                    if($d.find('img').attr('_src')){
                        $d.find('img').attr('src',$d.find('img').attr('_src'));
                    }
                })
            }
        }
    </script>
</body>
</html>
