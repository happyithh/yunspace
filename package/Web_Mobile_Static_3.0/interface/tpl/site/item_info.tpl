<!DOCTYPE>
<html>
<head>
    {include file="Web_Mobile_Static::inc/header_meta.tpl"}
    <meta name="full-screen" content="yes" />
    <meta name="x5-fullscreen" content="true" />
    <meta name="x5-page-mode" content="app" />
    {*<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=aaNCRRcGGai6klHMOGZ8yBbP"></script>*}
    <script type="text/javascript" src="http://api.map.baidu.com/getscript?v=2.0&ak=aaNCRRcGGai6klHMOGZ8yBbP"></script>

    {static "encyclopedia/subspace_tool.css"}
    {static "encyclopedia/encyclopedia.css"}
    {static "encyclopedia/subspace.css"}
    {static "v4.0/font-awesome.min.css"}
    {static "map/map_common.css"}
    {static "encyclopedias/encyclopedias.js"}
</head>
<body>
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
                <span>{$page->info['space_name']}</span>
            </div>

            <div class="con-kinds">
                <div class="con-kinds-li">
                    <span class="text">{$page->itemInfo['item_name']}{if $page->info['space_name']== $page->itemInfo["item_name"]}(主场地){/if}</span>
                    {if count($itemList)>1}
                    <span class="ion-arrow-down-b icon-arrow"></span></div>
                {/if}

                <div class="cover1 hidden"></div>
                {* {if count($itemList)>1} *}
                <div class="show-select-list hidden">
                    {foreach $itemList as $k=>$v}
                        <div class="show-select-li">
                            <a class="getSpaceItemUrl" href="{$_home}site/{Func_Url::str_urlencode($page->spaceName)}-百科-{Func_NumEncode::e($v['id'])}#collection">
                                {$page->info['space_name']}-<span>{$v['item_name']}{if $page->info['space_name']== $v["item_name"]}(主场地){/if}</span>
                            </a>
                        </div>
                    {/foreach}
                </div>
                {* {/if} *}
            </div>
            {if count($page->itemInfo['tags'])>0}
            <div class="con-des">
                <span>{foreach $page->itemInfo['tags'] as $k=>$v}{if $k<4}{$v} {if end($page->itemInfo['tags'])!=$v && $k!=3}/{/if}{/if} {/foreach}</span>
            </div>
            {/if}
            <div class="con-addr">{$page->info['addr']}</div>
            {if count($page->spaceMedia)>0}
            <a href="{$_home}site/{Func_Url::str_urlencode($page->spaceName)}-百科-{Func_NumEncode::e($page->itemInfo['id'])}-图片" class="con-pic">
                <span>{count($page->spaceMedia)}张</span>
            </a>
            {/if}
        </div>
    </header>
    <div class="baike_m_content">
        <div class="baike_m_title price_start" data-min_price="{if !empty($page->itemInfo['item_min_price'])}{$page->itemInfo['item_min_price']}{$page->itemInfo['item_price_unit']}{else}{$page->itemInfo['min_price']}{$page->itemInfo['price_unit']}{/if}">参考价</div>
        {if count($page->itemInfo['item_price'])>0}
            <table class="price-look" border="1" cellspacing="0" width="100%" align="center">
                <thead>
                <tr>
                    <td>规格</td>
                    <td>市场价</td>
                    <td>优惠价</td>
                </tr>
                </thead>
                <tbody>
                {foreach $page->itemInfo['item_price'] as $k=>$v}
                    <tr>
                        <td>{$v['standard']}</td>

                        <td> {if $v['market_price']!=$v['discount_price'] && !empty($v['discount_price'])}
                                <del>
                                ￥{intval($v['market_price'])}{if !empty($v['price_unit'])}{$v['price_unit']}{/if}</del>{/if}
                        </td>

                        <td class="price">
                            ￥<span>{if !empty($v['discount_price'])}{intval($v['discount_price'])}{else}{$v['market_price']}{/if}</span>{if !empty($v['price_unit'])}{$v['price_unit']}{/if}
                        </td>
                    </tr>
                {/foreach}
                </tbody>
            </table>
        {else}
            {if $page->itemInfo['min_price']==$page->itemInfo['max_price']}
                {if $page->itemInfo['min_price'] < 100}
                    <div class="baike_m_t price price_myi"><span>面议</span></div>
                {else}
                    <div class="baike_m_t price">￥<span>{$page->itemInfo['min_price']}</span>
                        元 / {if $page->itemInfo['price_unit']}{$page->itemInfo['price_unit']}{else}天{/if}</div>
                {/if}
            {else}
                 {if $page->itemInfo['max_price'] < 100}
                     <div class="baike_m_t price price_myi"><span>面议</span></div>
                     {else}
                     <div class="baike_m_t price">￥<span>{$page->itemInfo['min_price']}~{$page->itemInfo['max_price']}</span>
                         元 / {if $page->itemInfo['price_unit']}{$page->itemInfo['price_unit']}{else}天{/if}</div>
                     {/if}
            {/if}
        {/if}
        <div class="baike_m_title">详细地址 </div>
        <div class="baike_m_t adress">{$page->info['attr'][4]} · {substr($page->info['attr'][2],0,strpos($page->info['attr'][2],','))}<br/>
        {$page->info['city']}市&nbsp;{$page->info['addr']}</div>

        <div class="baike_m_line"></div>
        <div class="baike_m_c_title">子空间基础信息</div>
        <table class="baike_m_basics_info">
            <tr>
                <td class="baike_m_basics_title">面积</td>
                <td class="baike_m_basics_c">{if !empty($page->itemInfo['size'])}{$page->itemInfo['size']}㎡{/if}</td>
                <td class="baike_m_basics_title">人数</td>
                <td class="baike_m_basics_c">
                    {if !empty($page->itemInfo['min_people']) && !empty($page->itemInfo['max_people'])}
                    {if $page->itemInfo['min_people']==$page->itemInfo['max_people']}
                    {$page->itemInfo['min_people']}人
                        {else}
                        {$page->itemInfo['min_people']}-{$page->itemInfo['max_people']}人
                    {/if}
                    {elseif !empty($page->itemInfo['min_people']) && empty($page->itemInfo['max_people'])}
                    {$page->itemInfo['min_people']}人
                    {elseif empty($page->itemInfo['min_people']) && !empty($page->itemInfo['max_people'])}
                    {$page->itemInfo['max_people']}人
                    {/if}
                </td>
            </tr>
            <tr>
                <td class="baike_m_basics_title">高度</td>
                <td class="baike_m_basics_c">
                    {if !empty($page->itemInfo['layer_height'])}
                    {$page->itemInfo['layer_height']}m{/if}
                </td>
                <td class="baike_m_basics_title">承重</td>
                <td class="baike_m_basics_c">
                    {if !empty($page->itemInfo['item_weight'])}
                    {$page->itemInfo['item_weight']}公斤{/if}
                </td>
            </tr>
            <tr>
                <td class="baike_m_basics_title">桌数</td>
                <td class="baike_m_basics_c">
                    {if !empty($page->itemInfo['desk_num'])}
                        {$page->itemInfo['desk_num']}桌{/if}
                </td>
                <td class="baike_m_basics_title">座位数</td>
                <td class="baike_m_basics_c">
                    {if !empty($page->itemInfo['seat_num'])}
                        {$page->itemInfo['seat_num']}个{/if}
                </td>
            </tr>
            <tr>
                <td class="baike_m_basics_title">舞台面积</td>
                <td class="baike_m_basics_c">
                    {if !empty($page->itemInfo['stage_size'])}
                        {$page->itemInfo['stage_size']}㎡{/if}

                </td>
                <td class="baike_m_basics_title"> </td>
                <td class="baike_m_basics_c"> </td>
            </tr>
            <tr>
                <td class="baike_m_basics_title">过往案例</td>
                <td class="baike_m_basics_c1" colspan="3">{$page->itemInfo['past_case']}</td>
            </tr>
        </table>
        {if !empty($page->itemInfo['des'])}
        <div class="baike_m_line"></div>
        <div class="baike_m_c_title mb15">空间简介</div>
        <div class="baike_m_brand_introduce" id="baike_m_brief_content">
            {$page->itemInfo['des']}
        </div>
        {if mb_strlen($page->itemInfo['des'])>210}
        <div class="baike_m_icon_down" id="baike_m_brief_down">
            <img src="img/encyclopedias/baike_m_icon_down.png">
        </div>
        <div class="baike_m_icon_up" id="baike_m_brief_up">
            <img src="img/encyclopedias/baike_m_icon_up.png">
        </div>
        {/if}
        {/if}
        <div class="baike_m_line"></div>
        <div class="baike_m_c_title">配套设施</div>
        <ul class="baike_m_icon">
            <li id="baike_m_icon01{if $page->info['attr'][14]}_active{/if}"></li>
            <li id="baike_m_icon02{if $page->info['attr'][13]}_active{/if}"></li>
            <li id="baike_m_icon03{if $page->info['attr'][12]}_active{/if}"></li>
            <li id="baike_m_icon04{if $page->info['attr'][15]}_active{/if}"></li>
            <li id="baike_m_icon_more"></li>
            <li id="baike_m_icon05{if $page->info['attr'][17]}_active{/if}"></li>
            <li id="baike_m_icon06{if $page->info['attr'][18]}_active{/if}"></li>
            <li id="baike_m_icon07{if $page->info['attr'][5]}_active{/if}"></li>
            <li id="baike_m_icon08{if $page->info['attr'][19]}_active{/if}"></li>
            <li id="baike_m_icon09{if $page->info['attr'][20]}_active{/if}"></li>
            <li id="baike_m_icon10{if $page->info['attr'][21]}_active{/if}"></li>
            <li id="baike_m_icon11{if $page->info['attr'][22]}_active{/if}"></li>
            <div class="clear"></div>
        </ul>
        <div class="baike_m_icon_down" id="baike_m_facility_down">
            <img src="img/encyclopedias/baike_m_icon_down.png">
        </div>
        <div class="baike_m_icon_up" id="baike_m_facility_up">
            <img src="img/encyclopedias/baike_m_icon_up.png">
        </div>
        {if $page->info['addr']}
        <div class="baike_m_line"></div>
        <div class="baike_m_c_title">空间位置</div>
        <div class="baike_m_map">
            <div id="l-map"></div>
        </div>
        {/if}
        <div class="baike_m_line"></div>
        {if count($page->spaceItem)>1}
        <div class="baike_m_c_title">该场地其他空间</div>
        <ul class="baike_m_rent">
                {foreach $page->spaceItem as $k=>$v}
                    {if $v['id']!=$page->itemInfo['id']}
                    <li>
                        <a href="{$_home}site/{Func_Url::str_urlencode($page->spaceName)}-百科-{Func_NumEncode::e($v['id'])}#collection">
                            <div class="title clearfix">
                                <h5 class="fl">{$v['item_name']}</h5>

                                <div class="fr price">
                                    {if !empty($v['item_min_price'])}
                                        ￥
                                        <span>
                                                {$v['item_min_price']}
                                            </span>
                                        {if !empty($v['item_price_unit'])}{$v['item_price_unit']}{/if}
                                    {elseif empty($v['item_min_price']) && !empty($v['min_price'])}
                                        ￥
                                        <span>
                                        {$v['min_price']}
                                        </span>
                                        {if !empty($v['price_unit'])}{$v['price_unit']}{/if}
                                        {else}
                                        <span>
                                        面议
                                        </span>
                                    {/if}
                                </div>
                            </div>
                            <div class="cont">
                                面积 - {if !empty($v['size'])}{$v['size']}m²{/if}<br>
                                人数 -  {if $v['min_people']==$v['max_people']}
                                    {if $v['min_people'] < 50}
                                        50人以下
                                    {else}
                                        {$v['min_people']}人
                                    {/if}
                                {else}
                                    {$v['min_people']} ~ {$v['max_people']}人
                                {/if}
                                <span class="fr btn-detail" href="javascript:;">查看详情</span>
                            </div>
                        </a>
                    </li>
                    {/if}
                {/foreach}
            {/if}
    </div>
</div>

<div class="bottom-nav-area">
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
    <a class="btn-reserve" href="{$_home}inquiry?space_id={Func_NumEncode::e($page->info['id'])}&item_id={Func_NumEncode::e($page->itemInfo['id'])}">
        <p>预定</p>
    </a>
    <div class="larger-block">
        <p><a href="{$_home}inquiry?space_id={Func_NumEncode::e($page->info['id'])}" style="display: block">查询档期价格</a></p>
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

{* <script type="text/javascript">
    // 百度地图API功能
    var map = new BMap.Map("l-map");
    var point = new BMap.Point({$page->info['geo_lng']/10000},{$page->info['geo_lat']/10000});
    map.centerAndZoom(point, 12);
    var marker = new BMap.Marker(point);// 创建标注
    map.addOverlay(marker);             // 将标注添加到地图中
    //marker.disableDragging();           // 不可拖拽
    map.disableDragging();           // 不可拖拽
</script> *}
<script>
    var thisLat = "{$page->info['geo_lat']}",thisLng = "{$page->info['geo_lng']}",thisSpaceName = "{$page->info['space_name']}";
    thisLat = thisLat/10000;
    thisLng = thisLng/10000;
</script>
<script type="text/javascript" src="http://developer.baidu.com/map/custom/stylelist.js"></script>
<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=aaNCRRcGGai6klHMOGZ8yBbP"></script>
<script type="text/javascript" src="js/map/RichMarker.js"></script>
{static "map/map.js"}

{static "core/yunspace.js"}

<!--收藏功能-->
{static "sites/collect_space.js"}
</body>
</html>
