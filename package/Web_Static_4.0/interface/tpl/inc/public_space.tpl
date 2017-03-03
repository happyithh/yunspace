{static "v4.0/public_space_new.css"}
<style>
    .color-a li a{
        color: #fff;
    }
</style>
<!--引用百度地图API-->
<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=aaNCRRcGGai6klHMOGZ8yBbP"></script>
<div id="l-map" style="display: none!important;"></div>
<div yun="inc.v4.0/localData.js::pageController"></div>
<div class="public-container none"
     yun='inc.v4.0/public_space1.js::init'
     id="public-container"  data-city="{$_COOKIE['city']}" data-root="{$_root}">
    <div class="public-relative">
        <div class="public-bg"></div>
        <div class="public-content clearfix">
            <div class="public-left fl">
                <a href="{$_home}">
                <img src="img/v4.0/logo_0520.png" alt="云SPACE">
                </a>
            </div>
            <div class="public-center fl">
              <div class="public-form clearfix fl">
                  <form action="/database" method="get" class="public-sea">
                  <div class="public-drop fl">
                      <div class="public-select fl color-a">
                          <span><code>找资讯</code><i class="down-icon down-icon-white"></i></span>
                          <ul class="public-select-list none">
                              <li><a href="{$_home}space">找场地</a></li>
                              <li><a href="{$_home}database?action=is_submit&search_type=project_library">找资讯</a></li>
                              <li><a href="{$_home}database?action=is_submit&search_type=company_library">找公司</a></li>
                              <li><a href="{$_home}database?action=is_submit&search_type=paper_library">找文库</a></li>
                          </ul>
                      </div>

                      <input type="hidden" name="action" value="is_submit"/>
                      <input type="hidden" name="search_type" value="project_library">
                      <input type="hidden" class="city" name="city" value="">
                      <input type="hidden" class="active_type" name="active_type" value="">
                      <div class="public-input fl">
                          <div class="fl select-wrapper none">
                              <div class="public-select-h fl">
                                  <span><input type="text" value="" placeholder="城市" disabled><i class="down-icon"></i></span>
                                  <ul class="public-select-list-h none city">
                                      <li>不限</li>
                                      {foreach Web_Global::$city_name as $k=>$v}
                                          <li>{$v}</li>
                                      {/foreach}
                                  </ul>
                              </div>
                              <div class="public-select-h fl">
                                  <span><input type="" value="" placeholder="全部活动" class="act" disabled><i class="down-icon"></i></span>
                                  <ul class="public-select-list-h none active_type">
                                      <li>全部</li>
                                      {foreach $page->getActiveType as $k=>$v}
                                          <li>{$v}</li>
                                      {/foreach}
                                  </ul>
                              </div>
                          </div>
                          <input type="text"  id="public-input" name="keyword" autocomplete="off" placeholder="请输入您想搜索的关键词" growing-track="true" >
                          <input type="text"  id="public-input2" name="keyword2"  placeholder="商圈/地标/机场/火车站/场地名" class="none" value="{$page->getKeyword['keyword2']}" data-href="{$_home}" style="font-size:12px;color:#545459!important;" growing-track="true">
                          <input type="hidden" name="lat" class="pub-lat"/>
                          <input type="hidden" name="lng" class="pub-lng"/>
                      </div>

                      <div class="public-drop-body none">
                         <ul class="public-drop-list clearfix">
                             <li>
                                 <div class="public-cate-title fl" data-title="找资讯">
                                     <div class="public-cate public-cate-one">
                                         <p>资讯</p>
                                     </div>
                                 </div>
                                 <div class="public-list-body  fl">
                                     <ul class="public-list clearfix">
                                         <li><a href="{$_home}site/{Func_Url::str_urlencode('云SPACE')}">云SPACE</a></li>
                                         <li><a href="{$_home}site/{Func_Url::str_urlencode('行业前沿')}">行业前沿</a></li>
                                         <li><a href="{$_home}site/{Func_Url::str_urlencode('全国')}">全国</a></li>
                                         <li><a href="{$_home}site/{Func_Url::str_urlencode('海外')}">海外</a></li>
                                         <li><a href="{$_home}site/{Func_Url::str_urlencode('场地推荐')}">场地推荐</a></li>
                                         <li><a href="{$_home}site/{Func_Url::str_urlencode('榜单')}">榜单</a></li>
                                         {*<li><a href="">晚会年会</a></li>*}
                                         {*<li><a href="">培训演讲</a></li>*}
                                     </ul>
                                 </div>
                             </li>
                             <li>
                                 <div class="public-cate-title fl"  data-title="找场地">
                                     <div class="public-cate public-cate-two">
                                         <p>场地</p>
                                     </div>
                                 </div>
                                 <div class="public-list-body fl">
                                     <ul class="public-list clearfix">
                                         <li><a href="{$_home}sites/112-113-tags/{Func_Url::str_urlencode('秀场展馆')}">秀场展馆</a></li>
                                         <li><a href="{$_home}sites/112-114-tags/{Func_Url::str_urlencode('秀场展馆')}">商业发布</a></li>
                                         <li><a href="{$_home}sites/112-115-tags/{Func_Url::str_urlencode('艺术馆画廊')}">艺术馆画廊</a></li>
                                         <li><a href="{$_home}sites/112-116-tags/{Func_Url::str_urlencode('体育场馆')}">体育场馆</a></li>
                                         <li><a href="{$_home}sites/112-117-tags/{Func_Url::str_urlencode('影院剧院')}">影院剧院</a></li>
                                         <li><a href="{$_home}sites/112-118-tags/{Func_Url::str_urlencode('餐厅酒吧')}">餐厅酒吧</a></li>
                                         <li><a href="{$_home}sites/112-119-tags/{Func_Url::str_urlencode('高端会所')}">高端会所</a></li>
                                         <li><a href="{$_home}sites/112-121-tags/{Func_Url::str_urlencode('会务中心')}">会务中心</a></li>
                                     </ul>
                                 </div>
                             </li>
                             <li>
                                 <div class="public-cate-title fl" data-title="找文创">
                                     <div class="public-cate public-cate-three">
                                         <p>文创</p>
                                     </div>
                                 </div>
                                 <div class="public-list-body fl">
                                     <ul class="public-list clearfix">
                                         <li><a href="{$_home}site/%E6%BC%AB%E6%B8%B8%E9%9D%A2%E7%B2%89%E6%98%9F%E7%90%83-%E5%A4%9A%E5%AA%92%E4%BD%93%E4%BA%92%E5%8A%A8%E5%B1%95" title="面粉星球">面粉星球</a></li>
                                         <li><a href="{$_home}site/%E8%AE%A9%E4%BC%A0%E7%BB%9F%E6%96%87%E5%8C%96%E6%B4%BB%E8%B5%B7%E6%9D%A5-%E4%B9%BE%E9%9A%86%E4%B8%8B%E4%B8%80%E4%B8%AA%E6%B1%9F%E5%8D%97" title="乾隆下一个江南">乾隆下一个江南</a></li>
                                         <li><a href="{$_home}site/%E7%A7%BB%E5%8A%A8%E8%BF%B7%E5%AE%AB" title="移动迷宫">移动迷宫</a></li>
                                         <li><a href="{$_home}site/Yoohoo%E5%92%8C%E4%BB%96%E7%9A%84%E6%9C%8B%E5%8F%8B" title="yoohoo">yoohoo</a></li>
                                         <li><a href="{$_home}site/Marvel%E4%B8%BB%E9%A2%98%E4%BD%93%E9%AA%8C%E5%B1%95" title="漫威主题体验展">漫威主题体验展</a></li>
                                         <li><a href="{$_home}site/%E5%88%97%E5%A5%A5%E7%BA%B3%E5%A4%9A%C2%B7%E8%BE%BE%E8%8A%AC%E5%A5%87%E4%BD%9C%E5%93%81%E5%B1%95" title="达芬奇作品展">达芬奇作品展</a></li>
                                         <li><a href="{$_home}site/%E8%B6%85%E8%83%BD%E9%99%86%E6%88%98%E9%98%9F-%E8%B6%85%E8%83%BD%E8%8B%B1%E9%9B%84%E4%BD%93%E9%AA%8C%E8%90%A5" title="超能陆战队">超能陆战队</a></li>
                                         <li><a href="{$_home}site/%E5%8D%81%E4%B8%87%E4%B8%AA%E5%86%B7%E7%AC%91%E8%AF%9D%E4%B8%BB%E9%A2%98%E5%B7%A1%E5%B1%95" title="十万个冷笑话">十万个冷笑话</a></li>
                                     </ul>
                                 </div>
                             </li>
                             <li>
                                 <div class=" public-cate-title fl" data-title="找文档">
                                     <div class="public-cate public-cate-four">
                                         <p>文档</p>
                                     </div>
                                 </div>
                                 <div class="public-list-body fl">
                                     <ul class="public-list clearfix">
                                         <li><a href="{$_home}database?action=is_submit&search_type=paper_library&keyword={Func_Url::str_urlencode('策划方案')}">策划方案</a></li>
                                         <li><a href="{$_home}database?action=is_submit&search_type=paper_library&keyword={Func_Url::str_urlencode('营销案例')}">营销案例</a></li>
                                         <li><a href="{$_home}database?action=is_submit&search_type=paper_library&keyword={Func_Url::str_urlencode('仪式致辞')}">仪式致辞</a></li>
                                         <li><a href="{$_home}database?action=is_submit&search_type=paper_library&keyword={Func_Url::str_urlencode('舞台搭建')}">舞台搭建</a></li>
                                         <li><a href="{$_home}database?action=is_submit&search_type=paper_library&keyword={Func_Url::str_urlencode('发布会')}">发布会</a></li>
                                         <li><a href="{$_home}database?action=is_submit&search_type=paper_library&keyword={Func_Url::str_urlencode('派对')}">派对</a></li>
                                         <li><a href="{$_home}database?action=is_submit&search_type=paper_library&keyword={Func_Url::str_urlencode('庆典')}">庆典</a></li>
                                         <li><a href="{$_home}database?action=is_submit&search_type=paper_library&keyword={Func_Url::str_urlencode('会议')}">会议</a></li>
                                     </ul>
                                 </div>
                             </li>
                         </ul>
                      </div>

                      <div class="public-drop-body none">
                          {*<ul class="public-input-list">*}
                              {*<li><a href=""><span class="p1">舍聚会派对会所</span>&nbsp;&nbsp;&nbsp;<span class="p2">年会大咖秀</span></a></li>*}
                              {*<li><a href=""><span class="p1">舍聚会派对会所</span>&nbsp;&nbsp;&nbsp;<span class="p2">年会大咖秀</span></a></li>*}
                              {*<li><a href=""><span class="p1">舍聚会派对会所</span>&nbsp;&nbsp;&nbsp;<span class="p2">年会大咖秀</span></a></li>*}
                              {*<li><a href=""><span class="p1">舍聚会派对会所</span>&nbsp;&nbsp;&nbsp;<span class="p2">年会大咖秀</span></a></li>*}
                              {*<li><a href=""><span class="p1">舍聚会派对会所</span>&nbsp;&nbsp;&nbsp;<span class="p2">年会大咖秀</span></a></li>*}
                              {*<li><a href=""><span class="p1">舍聚会派对会所</span>&nbsp;&nbsp;&nbsp;<span class="p2">年会大咖秀</span></a></li>*}
                          {*</ul>*}
                      </div>

                  </div>
                  <div class="public-search fl">
                      <button type="button" id="search-space-three" data-root="{$_root}">搜索</button>
                  </div>
                  </form>
              </div>
              <div class="public-link fl">
                  <a href="{Web_Global::createRentSpaceUrl()}">
                     一键租场地
                  </a>
              </div>
            </div>
            <div class="public-server fr">
                服务热线：400-056-0599
            </div>
        </div>
    </div>
</div>
{include file="Web_Static::inc/public_subscription.tpl"}
{static "v4.0/jquery.easing.1.3.min.js"}
{static "baike.v1.0/banner.js"}
{static "v4.0/jquery.qrcode.min.js"}
{static "core/yunspace.js"}
<script src="js/v4.0/public_subscription.js"></script>
