<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    {include file="Web_Static::inc/head_meta.tpl"}
    {static "v4.0/common.css"}
    {static "classify.v2.0/classify.css"}
</head>
<body>
{include file="Web_Static::inc/header_1.tpl"}
<div class="container">
    {*左侧悬浮导航*}
    <ul class="classify_left_guide">
        <a href="#">
           <li class="classify_icon_home_active">
               首页
           </li>
        </a>
        <a href="#">
            <li class="classify_icon_space">
                空间
            </li>
        </a>
        <a href="#">
            <li class="classify_icon_cultural">
                文创
            </li>
        </a>
        <a href="#">
            <li class="classify_icon_retail">
                零售
            </li>
        </a>
        <a href="#">
            <li class="classify_icon_find">
                发现
            </li>
        </a>
    </ul>
    {*左侧*}
    <div class="classify_fl">
        {*左侧顶部tab区域*}
        <ul class="tags_tab">
            <li><a href="javascript:;" class="tags_tab_active">全部分类</a></li>
            <li><a href="javascript:;">秀场展馆</a></li>
            <li><a href="javascript:;">商业广场</a></li>
            <li><a href="javascript:;">艺术馆画廊</a></li>
            <li><a href="javascript:;">体育场馆</a></li>
            <li><a href="javascript:;">影院剧院</a></li>
            <li><a href="javascript:;">餐厅酒吧</a></li>
        </ul>
        <a class="classify_more clearfix">更多>></a>
        <div class="clear"></div>
        {*左侧list列表*}
        <div class="classify_content_outside">
          <div class="classify_content">
            {include "Web_Static::classify.v2.0/inc/all.tpl"}
          </div>
          <div class="classify_content none">
            {include "Web_Static::classify.v2.0/inc/bar.tpl"}
          </div>
          <div class="classify_content none">
            {include "Web_Static::classify.v2.0/inc/cinema.tpl"}
          </div>
          <div class="classify_content none">
            {include "Web_Static::classify.v2.0/inc/gallery.tpl"}
          </div>
          <div class="classify_content none">
            {include "Web_Static::classify.v2.0/inc/show.tpl"}
          </div>
          <div class="classify_content none">
            {include "Web_Static::classify.v2.0/inc/sports.tpl"}
          </div>
          <div class="classify_content none">
            {include "Web_Static::classify.v2.0/inc/square.tpl"}
          </div>
        </div>
    </div>
    {*右侧*}
    <div class="classify_rt clearfix">
       <ul class="classify_rt_img">
           <li>
               <a href="#">
                   <img src="img/classify.v2.0/classify01.jpg">
                   <div class="right_icon">
                       <div class="right_icon_img">
                           <img src="img/classify.v2.0/right_icon01.png">
                       </div>
                       <div class="right_icon_content">
                           <div class="right_icon_title">一键租场地</div>
                           <div class="right_icon_word">省时、省心，找你所想</div>
                       </div>
                       <div class="clear"></div>
                   </div>
               </a>
           </li>
           <li>
               <a href="#">
                   <img src="img/classify.v2.0/classify02.jpg">
                   <div class="right_icon">
                       <div class="right_icon_img">
                           <img src="img/classify.v2.0/right_icon02.png">
                       </div>
                       <div class="right_icon_content">
                           <div class="right_icon_title">场地地图</div>
                           <div class="right_icon_word">发现场地，快速定位</div>
                       </div>
                       <div class="clear"></div>
                   </div>
               </a>
           </li>
           <li>
               <a href="#">
                   <img src="img/classify.v2.0/classify03.jpg">
                   <div class="right_icon">
                       <div class="right_icon_img">
                           <img src="img/classify.v2.0/right_icon03.png">
                       </div>
                       <div class="right_icon_content">
                           <div class="right_icon_title">场地出租</div>
                           <div class="right_icon_word">让你的场地轻松变现</div>
                       </div>
                       <div class="clear"></div>
                   </div>
               </a>
           </li>
           <li>
               <a href="#">
                   <img src="img/classify.v2.0/classify04.jpg">
                   <div class="right_icon">
                       <div class="right_icon_img">
                           <img src="img/classify.v2.0/right_icon04.png">
                       </div>
                       <div class="right_icon_content">
                           <div class="right_icon_title">资料文库</div>
                           <div class="right_icon_word">找文档，来云SPACE文库</div>
                       </div>
                       <div class="clear"></div>
                   </div>
               </a>
           </li>
           <li>
               <a href="#">
                   <img src="img/classify.v2.0/classify05.jpg">
                   <div class="right_icon">
                       <div class="right_icon_img">
                           <img src="img/classify.v2.0/right_icon05.png">
                       </div>
                       <div class="right_icon_content">
                           <div class="right_icon_title">文创项目库</div>
                           <div class="right_icon_word">打破传统格局</div>
                       </div>
                       <div class="clear"></div>
                   </div>
               </a>
           </li>
           <li>
               <a href="#">
                   <img src="img/classify.v2.0/classify06.jpg">
                   <div class="right_icon">
                       <div class="right_icon_img">
                           <img src="img/classify.v2.0/right_icon06.png">
                       </div>
                       <div class="right_icon_content">
                           <div class="right_icon_title">零售</div>
                           <div class="right_icon_word">适合你的商业短租场地</div>
                       </div>
                       <div class="clear"></div>
                   </div>
               </a>
           </li>
       </ul>
        <div class="classify_rt_title">
            热门文章
        </div>
        <ul class="hot_article_list">
            <li>
                <div class="circle"></div>
                <a href="#">这个店由设计师 Pierre-Henri Mattout</a>
            </li>
            <li>
                <div class="circle"></div>
                <a href="#">在巴黎经营，偏好日本先锋文化和街头文化。</a>
            </li>
            <li>
                <div class="circle"></div>
                <a href="#">店内有 Pierre Hardy, Lanvin, Common Project 和 Y3 </a>
            </li>
            <li>
                <div class="circle"></div>
                <a href="#">有Comme des Garçons, Junya,Watanabe, </a>
            </li>
            <li>
                <div class="circle"></div>
                <a href="#">这次快闪店我也看了看在商场的环境里运营是什么情况?</a>
            </li>
            <li>
                <div class="circle"></div>
                <a href="#">陈艾妮【环游世界一辈子】系列：北京餐厅巡礼-伦敦桥咖啡</a>
            </li>
            <li>
                <div class="circle"></div>
                <a href="#">小资咖啡馆大集结，谁才是大学路上最大“咖”？</a>
            </li>
            <li>
                <div class="circle"></div>
                <a href="#">我不在伦敦，但我在伦敦桥等你</a>
            </li>
            <li>
                <div class="circle"></div>
                <a href="#">售卖的不仅是咖啡品鉴伦敦桥咖啡馆的英式浪漫</a>
            </li>
        </ul>
    </div>
    <div class="clear"></div>
</div>

{include file="Web_Static::inc/html_footer.tpl"}
{include file="Web_Static::inc/public_space.tpl"}
{static "classify.v2.0/classify.js"}
</body>

</html>