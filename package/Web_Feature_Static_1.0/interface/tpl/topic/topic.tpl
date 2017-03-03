<!DOCTYPE html>
<html>
<head lang="en">
   {*  <meta charset="UTF-8">
    <title>中庭_商场场地资源_商场活动策划_找商场办活动-云SPACE</title>
    <meta name="keywords" content="商场,中庭,商场中庭,商场活动,上海大悦城,正大广场,龙之梦"/>
    <meta name="description" content="商场中庭是商场内部能见度最好的场所，能让顾客一目了然。往往每季商场的主题都在中庭做布置，所以商场中庭也是一个最吸引顾客眼球的场所。适合各类小型的路演活动、明星见面会，及折扣促销活动的举办。中庭通常是指建筑内部的庭院空间，其最大的特点是形成具有位于建筑内部的“室外空间”，是建筑设计中营造一种与外部空间既隔离又融合的特有形式，或者说是建筑内部环境分享外部自然环境的一种方式"/> *}
    {include file="Web_Static::inc/head_meta.tpl"}
    {static "v4.0/common.css"}
    {static "topic/topic.css"}
    {static "topic/topic.js"}
</head>
<body>
{include file="Web_Static::inc/header_1.tpl"}
<div class="wrapper">
    <div class="crumb">
        <a href="{$_home}">首页</a>&gt;<a href="javascript:;" class="active">专题</a>
    </div>
</div>
<div class="head">
    <div class="head_img">
        <img src="{Page_Site_Global::displayMedia($page->info['big_logo'],"1920","")}">       {*  <span class="big-title">『超』人气地段&nbsp;&nbsp;『强』品牌露出&nbsp;&nbsp;『低』租赁价格</span>
        <span class="small-title">极佳的商场空间场地，给你前所未有的空前体验。</span> *}
    </div>
</div>
<div class="brief">
     <div class="title_word">{$page->info['topic_title']}</div>
     <div class="title_line">
         <img src="img/topic/line.jpg">
     </div>
    <div class="brief_content">
        {$page->info['topic_des']}
    </div>
</div>
<div class="back_one"></div>
<div class="container">
      {foreach $page->spaceList as $k=>$v}
          {if $k%2==0}
              <div class="site">
                 <div class="site_two_word">
                    <div class="title_word">{$v['space_name']}</div>
                     <div class="title_line"><img src="img/topic/line.jpg"></div>
                     <div class="site_word_brief_one">
                        {$v['des']}
                     </div>
                     <div class="label_icon">
                            {if $v['activity_type']}
                              <div class="fit none">{str_replace(",","/",$v['activity_type'])}</div>
                            {/if}
                            {if $v['framework']}
                              <div class="area">{$v['framework']}</div>
                            {/if}
                            {if $v['max_people']}
                              <div class="flow none">可容纳人数：{$v['max_people']}人</div>
                            {/if}
                            {if $v['price']}
                              <div class="price none">{$v['price']}</div>
                            {/if}
                            {if $v['discount']}
                              <div class="discount">市场价<span>{$v['discount']}</span>（不含税）</div>
                            {/if}
                            {if $v['visit_people']}
                             <div class="flow none">人流量：{$v['visit_people']}</div>
                            {/if}
                            {if $v['addr']}
                             <div class="addr">{$v['addr']}</div>
                            {/if}
                         <div class="clear"></div>
                     </div>
                     <a href="http://www.yunspace.com.cn/site/{Func_Url::str_urlencode($v['real_space_name'],1)}" class="detail_btn" target="_blank" data-tsid="{$v['id']}" onclick="get_click(this)">查看详情</a>
                 </div>
                 <div class="site_two_img">
                      <img src="{Page_Site_Global::displayMedia($v['logo'],590,460,1)}">
                 </div>
                 <div class="clear"></div>
             </div>
             <div class="click-sum">{Data_Config::get('market_article1')}</div>
          {else}
              <div class="site">
                  <div class="site_two_img">
                      <img src="{Page_Site_Global::displayMedia($v['logo'],590,460,1)}">
                  </div>
                  <div class="site_two_word">
                      <div class="title_word">{$v['space_name']}</div>
                      <div class="title_line"><img src="img/topic/line.jpg"></div>
                      <div class="site_word_brief_one">
                          {$v['des']}
                      </div>
                      <div class="label_icon">
                          {if $v['activity_type']}
                            <div class="fit none">{str_replace(",","/",$v['activity_type'])}</div>
                          {/if}
                          {if $v['framework']}
                            <div class="area">{$v['framework']}</div>
                          {/if}
                          {if $v['max_people']} 
                            <div class="flow none">可容纳人数：{$v['max_people']}人</div>
                          {/if}
                          {if $v['price']}
                            <div class="price none">{$v['price']}</div>
                          {/if}
                          {if $v['discount']}
                            <div class="discount">市场价<span>{$v['discount']}</span>（不含税）</div>
                          {/if}
                          {if $v['visit_people']}
                            <div class="flow none">人流量：{$v['visit_people']}</div>
                          {/if}
                          {if $v['addr']}
                            <div class="addr">{$v['addr']}</div>
                          {/if}
                          <div class="clear"></div>
                      </div>
                      <a href="http://www.yunspace.com.cn/site/{Func_Url::str_urlencode($v['real_space_name'],1)}" class="detail_btn" target="_blank" data-tsid="{$v['id']}" onclick="get_click(this)">查看详情</a>
                  </div>
                  <div class="clear"></div>
              </div>
              <div class="click-sum">{Data_Config::get('market_article2')}</div>
          {/if}
      {/foreach}
      

</div>

<div class="bottom_outside">
    <div class="bottom_inside">
        <img src="img/topic/bottom.jpg">
    </div>
</div>

<div class="tel_word">若有场地需求，请及时与我们联系...</div>
<div class="tel_sum">400-056-0599</div>

{* <div class="browse">{Data_Config::get('topic_market')}</div> *}


{include file="Web_Static::inc/html_footer.tpl"}
{include file="Web_Static::inc/public_space.tpl"}
{static "core/yunspace.js"}
</body>

</html>