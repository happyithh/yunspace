<!DOCTYPE>
<html>
<head>
    {include file="Web_Mobile_Static::inc/header_meta.tpl"}
    <meta name="full-screen" content="yes" />
    <meta name="x5-fullscreen" content="true" />
    <meta name="x5-page-mode" content="app" />
    {*<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=aaNCRRcGGai6klHMOGZ8yBbP"></script>*}
    {* <script type="text/javascript" src="http://api.map.baidu.com/getscript?v=2.0&ak=aaNCRRcGGai6klHMOGZ8yBbP"></script> *}

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
                <span>{$page->info['space_name']}</span>
            </div>
            <div class="con-des">
                <span>{$page->info['special_tags']}</span>
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
            <div class="con-addr">{$page->info['addr']}</div>
            <a href="{$_home}site/{$page->info['space_name']}-百科-图片" class="con-pic">
                <span>{count($page->spaceMedia)}张</span>
            </a>
        </div>
    </header>
    <div class="baike_m_content">
        {if $page->info['special_tags']}
            <div class="baike_m_title">场地特色 </div>
            <div class="baike_m_t">{$page->info['special_tags']}</div>
        {/if}
        {if $page->info['addr']}
            <div class="baike_m_title">详细地址 </div>
            <div class="baike_m_t">{$page->info['city']}市&nbsp;{$page->info['addr']}</div>
        {/if}
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
        <div class="baike_m_c_title">基础信息</div>
        <table class="baike_m_basics_info">
            <tr>
                <td class="baike_m_basics_title">所在城市</td>
                <td class="baike_m_basics_c">{$page->tags[77]['城市']}</td>
                <td class="baike_m_basics_title">行政区域</td>
                <td class="baike_m_basics_c">{$page->tags[77]['行政区域']}</td>
            </tr>
            <tr>
                <td class="baike_m_basics_title">所属商圈</td>
                <td class="baike_m_basics_c">{$page->tags[77]['所属商圈']}</td>
                <td class="baike_m_basics_title">轨道交通</td>
                <td class="baike_m_basics_c">{$page->tags[77]['轨道交通']}</td>
            </tr>
            <tr>
                <td class="baike_m_basics_title">使用面积</td>
                <td class="baike_m_basics_c">{$page->tags[78]['使用面积']}</td>
                <td class="baike_m_basics_title">空间层高</td>
                <td class="baike_m_basics_c">{$page->tags[78]['空间层高']}</td>
            </tr>
            <tr>
                <td class="baike_m_basics_title">空间承重</td>
                <td class="baike_m_basics_c">{$page->tags[78]['空间承重']}</td>
                <td class="baike_m_basics_title">容纳人数</td>
                <td class="baike_m_basics_c">{$page->tags[78]['容纳人数']}</td>
            </tr>
            <tr>
                <td class="baike_m_basics_title">行业类型</td>
                <td class="baike_m_basics_c1" colspan="3">{$page->tags[93]['行业类型']}</td>
            </tr>
            <tr>
                <td class="baike_m_basics_title">活动类型</td>
                <td class="baike_m_basics_c1" colspan="3">{$page->tags[93]['活动类型']}</td>
            </tr>
        </table>
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
            <div class="baike_m_c_title">场地位置</div>
            <div class="baike_m_map">
                <div id="l-map"></div>
            </div>
        {/if}
        <div class="baike_m_line"></div>
        {if $page->info['des']}
            <div class="baike_m_c_title mb15">场地简介</div>
            <div class="baike_m_brand_introduce" id="baike_m_brief_content">
                {strip_tags($page->info['des'])}
            </div>
            <div class="baike_m_icon_down" id="baike_m_brief_down">
                <img src="img/encyclopedias/baike_m_icon_down.png">
            </div>
            <div class="baike_m_icon_up" id="baike_m_brief_up">
                <img src="img/encyclopedias/baike_m_icon_up.png">
            </div>
            <div class="baike_m_line"></div>
        {/if}
        {if $itemList}
        <div class="baike_m_c_title">租场地</div>
        <ul class="baike_m_rent">
            {foreach $itemList as $k=>$v}
            <a href="{$_root}m/service_info/{$v['product_id']}.html">
            <li>
                <span>0{$k+1} / {$v['item_name']}</span><br>
                面积  -  {$v['size']}m²<br>
                人数  -  {if $v['min_people']==$v['max_people']}
                    {if $v['min_people'] < 50}
                        50人以下
                    {else}
                        {$v['min_people']}人
                    {/if}
                {else}
                    {$v['min_people']} ~ {$v['max_people']}人
                {/if}
            </li>
            </a>
            {/foreach}
        <a href="{$_home}inquiry?space_id={Func_NumEncode::e($page->info['id'])}" class="baike_m_sitedate">
            查看档期和价格
        </a>
        {/if}
            {if count($page->getNearSpace)}
                <div class="baike_m_c_title1">附近场地</div>
            {/if}
            <ul class="baike_m_nearby_area">
                {foreach $page->getNearSpace as $k=>$v}
                    <a href="{$_home}site/{Func_Url::str_urlencode($v['space_name'])}">
                        <li data-lng="{$v['geo_lng']}" data-lat="{$v['geo_lat']}">
                            <div class="baike_m_nearby_pic">
                                {if $v['logo']}
                                    <img src="{Page_Site_Global::displayMedia($v['logo'],126,76)}">
                                {else}
                                    <img src="img/no_img.jpg">
                                {/if}
                            </div>
                            <div class="baike_m_nearby_word">
                                <div class="baike_m_nearby_name">{$v['space_name']}</div>
                                <div class="baike_m_nearby_dis">距离 · {$v['distance_note']}</div>
                            </div>
                            <div class="clear"></div>
                        </li>
                    </a>
                {/foreach}
                <div class="clear"></div>
            </ul>
            <a href="" class="baike_m_sitearea none" >

                查看更多周边场地
            </a>
    </div>

<div class="baike_m_bottom">
    <div class="baike_m_bottom_logo">
        <img src="img/encyclopedias/baike_m_bottom.png">
    </div>
    <p class="baike_m_bottom_word">Copyright©2015 云·SPACE 沪ICP备12039278号-2</p>
</div>

</div>



{* <script type="text/javascript">
    // 百度地图API功能
    var map = new BMap.Map("l-map");
    var point = new BMap.Point({$page->info['geo_lng']/10000},{$page->info['geo_lat']/10000});
    map.centerAndZoom(point, 12);
    var marker = new BMap.Marker(point);// 创建标注
    map.addOverlay(marker);             // 将标注添加到地图中
    // marker.disableDragging();           // 不可拖拽
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
{* {static "map/RichMarker.js"} *}
{static "map/map.js"}
{static "core/yunspace.js"}
</body>
</html>
