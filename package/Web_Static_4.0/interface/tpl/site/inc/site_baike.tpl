{static "map.v1.0/map_common.css"}
<div class="baike-content">
    {include file="Web_Static::site/inc/collection_title.tpl"}
    <div class="baike-dtl">
        <div class="title">
            <h2>{$page->info['space_name']}</h2>
            <p>{$page->info['seo_title']}</p>
            <div class="price">{$page->baikePrice['text_show']}<br/>
                <span>
                    {if $page->baikePrice['baike_price']>100}
                        ￥{$page->baikePrice['baike_price']}元/{$page->baikePrice['price_unit']}
                        <span style="font-size: 13px;color:#666 ">{$page->baikePrice['is_low']}</span>
                    {else}
                        面议
                    {/if}
                </span>
            </div>
        </div>
        <div class="cont clearfix">
            <dl class="clearfix">
                <dt class="fl blue">类型</dt>
                <dd class="fl">场地类型 | {$page->info['category_name']} &nbsp;&nbsp;/&nbsp;&nbsp; 活动类型 | {str_replace(",","、",$page->tags["93"]['活动类型'])}</dd>
                <dd class="fr marks">
                    {foreach $page->info['special_tags_arr'] as $k=>$v}
                        <span>{$v}</span>
                    {/foreach}
                </dd>
            </dl>
            <dl class="clearfix none">
                <dt class="fl yellow">地址</dt>
                <dd class="fl">{$page->info['city']} &nbsp;&nbsp;/&nbsp;&nbsp; {$page->info['addr']}
                    <a class="link-map" href="#nv-position">查看地理位置</a>
                </dd>
            </dl>
            <dl class="clearfix dl-last">
                <dt class="fl green">容量</dt>
                <dd class="fl">面积 | {$page->tags[78]['使用面积']}  &nbsp;&nbsp;/&nbsp;&nbsp;  人数 | {$page->tags[78]['容纳人数']}</dd>
            </dl>
            <input type="hidden"
                   value="{$page->tags[78]['使用面积']},,
                   {$page->info['city']},,{$page->info['category_name']},,
                   {if $page->baikePrice['baike_price']>100}
                        {$page->baikePrice['baike_price']}/{$page->baikePrice['price_unit']}
                    {else}
                        0
                    {/if}"
                   id="looked-space"
            />
        </div>
    </div><!--space-dtl-end-->
        {*{/if}*}
    <!--品牌故事-开始-->
    {if $page->caseList&&count($page->caseList)>0}
    <div class="comn" id="nv-story">
        <div class="comn-title clearfix">
            <i class="icon-story"></i><span>品牌故事</span>
        </div>
        <div class="comn-baike-story clearfix">
            {foreach $page->caseList as $k=>$v}
                <a href="http://{Core::$urls['host']}/article/{Func_NumEncode::e($v['id'])}.html" target="_blank">
                    <div class="cont" {if ($k+1)%3==0}style="margin: 0" {/if}>
                        <div class="cont-text">
                            <h5>{$v['subhead']}</h5>
                            <p>{mb_substr($v['des'],0,70,"utf8")}...</p>
                        </div>
                        <div class="cont-img"><img width="290" height="70" src="{Page_Site_Global::displayMedia($v['logo'],290,70,1)}"></div>
                    </div>
                </a>
            {/foreach}
        </div><!--comn-baike-story-end-->
    </div><!--baike-story-end-->
    {/if}
    {if !$page->info['logo']}
        <div class="comn" id="nv-pic">
            <div class="comn-title clearfix">
                <i class="icon-pic"></i><span>场地图片</span>
            </div>
            <div class="comn-baike-pic clearfix">
                <a rel="example_group" href="javascript:;" class="load-img none fancybox-a">
                    <img data-src="" title="" data-number="" src="">
                </a>
                <a href="javascript:;" class="loading-img none" onclick="return false;"><div class="loading"></div></a>
                {foreach $page->spaceMedia as $k=>$v}
                    {if $k<12}
                        <a rel="example_group" class="fancybox-a" href="{Page_Site_Global::displayMedia($v['path'],750,500,1)}">
                            <img title="{$page->info['space_name']}&nbsp;&nbsp;({$v['tags']})" src="{if isset($page->spaceItem[0]) && $page->spaceItem[0]['is_thc']}{Page_Site_Global::displayMedia($v['path'],262,225,1,'thc')}{else}{Page_Site_Global::displayMedia($v['path'],294,252,1)}{/if}">
                        </a>
                    {/if}
                {/foreach}
                {if !$is_more && count($page->spaceMedia)%4 ==1}
                    <a href="javascript:;"><div class="loading"></div></a>
                    <a href="javascript:;"><div class="loading"></div></a>
                    <a href="javascript:;"><div class="loading"></div></a>
                {elseif !$is_more && count($page->spaceMedia)%4 ==2}
                    <a href="javascript:;"><div class="loading"></div></a>
                    <a href="javascript:;"><div class="loading"></div></a>
                {elseif !$is_more && count($page->spaceMedia)%4 ==3}
                    <a href="javascript:;"><div class="loading"></div></a>
                {/if}
            </div><!--comn-baike-pic-end-->
            <!--加载更多按钮-->
            {if count($page->spaceMedia)>12}
                <a href="javascript:;" class="load-more-btn" data-count-media="{count($page->spaceMedia)}" data-start-num="12">
                    <span>加载更多</span>
                    <img src="img/baike.v1.0/icon-pull.png" width="13" height="13">
                </a>
            {/if}
        </div><!--comn-end-->
    {/if}
    <!--基础信息-开始-->
    {if $page->isSpace}
    <div class="comn" id="nv-baseInfo">
        <div class="comn-title clearfix">
            <i class="icon-msg"></i><span>基础信息</span>
        </div>
        <div class="comn-baike-info clearfix">
            {*地理位置*}
            <div class="cont cont-location">
                <h5>{$page->tags[77]["parent_name"]}</h5>
                <ul>
                    {foreach $page->tags[77] as $k=>$v}
                        {if $k!= "parent_name"}
                            <li>{$k}<span>-</span>{str_replace(",","、",$v)}</li>
                        {/if}
                    {/foreach}
                </ul>
            </div>
            {*空间标准*}
            <div class="cont cont-standards">
                <h5>{$page->tags[78]["parent_name"]}</h5>
                <ul>
                    {foreach $page->tags[78] as $k=>$v}
                        {if $k!= "parent_name"}
                            <li>{$k}<span>-</span>{str_replace(",","、",$v)}</li>
                        {/if}
                    {/foreach}
                </ul>
            </div>
            {*活动适用*}
            <div class="cont cont-apply">
                <h5>{$page->tags[93]['parent_name']}</h5>
                <ul>
                    {foreach $page->tags[93] as $k=>$v}
                        {if $k!= "parent_name"}
                            <li>{$k}<span>-</span>{str_replace(",","、",$v)}</li>
                        {/if}
                    {/foreach}
                </ul>
            </div>
        </div>
    </div><!--baike-info-end-->

    <!--配套设施-开始-->
    <div class="comn" id="nv-facilities">
        <div class="comn-title clearfix">
            <i class="icon-facilities"></i><span>配套设施</span>
        </div>
        <div class="comn-baike-facilities">
            <ul>
                <li class="li1 {if $page->info['attr'][14] && $page->info['attr'][14]!="无"}active{/if}">
                    <div class="gray-bg">
                        <div class="icon"></div>
                    </div>
                    <p>洗手间</p>
                </li>
                <li class="li2 {if $page->info['attr'][13] &&  $page->info['attr'][13]!="无"}active{/if}">
                    <div class="gray-bg">
                        <div class="icon"></div>
                    </div>
                    <p>化妆间</p>
                </li>
                <li class="li3 {if $page->info['attr'][12] && $page->info['attr'][12]!="无"}active{/if}">
                    <div class="gray-bg">
                        <div class="icon"></div>
                    </div>
                    <p>休息室</p>
                </li>
                <li class="li4 {if $page->info['attr'][15] && $page->info['attr'][15]!="无"}active{/if}">
                    <div class="gray-bg">
                        <div class="icon"></div>
                    </div>
                    <p>空间吊点</p>
                </li>
                <li class="li5 {if $page->info['attr'][17] && $page->info['attr'][17]!="无"}active{/if}">
                    <div class="gray-bg">
                        <div class="icon"></div>
                    </div>
                    <p>空调暖气</p>
                </li>
                <li class="li6 {if $page->info['attr'][18] && $page->info['attr'][18]!="无"}active{/if}">
                    <div class="gray-bg">
                        <div class="icon"></div>
                    </div>
                    <p>网络WIFI</p>
                </li>
                <li class="li7 {if $page->info['attr'][5] && $page->info['attr'][5]!="无"}active{/if}">
                    <div class="gray-bg">
                        <div class="icon"></div>
                    </div>
                    <p>停车泊位</p>
                </li>
                <li class="li8 {if $page->info['attr'][19] && $page->info['attr'][19]!="无"}active{/if}">
                    <div class="gray-bg">
                        <div class="icon"></div>
                    </div>
                    <p>货运电梯</p>
                </li>
                <li class="li9 {if $page->info['attr'][20] && $page->info['attr'][20]!="无"}active{/if}">
                    <div class="gray-bg">
                        <div class="icon"></div>
                    </div>
                    <p>投影LED</p>
                </li>
                <li class="li10 {if $page->info['attr'][21] && $page->info['attr'][21]!="无"}active{/if}">
                    <div class="gray-bg">
                        <div class="icon"></div>
                    </div>
                    <p>灯光音响</p>
                </li>
                <li class="li11 {if $page->info['attr'][22] && $page->info['attr'][22]!="无"}active{/if}">
                    <div class="gray-bg">
                        <div class="icon"></div>
                    </div>
                    <p>餐饮</p>
                </li>
            </ul>
        </div>
    </div><!--baike-facilities-end-->
    {/if}
    <!--场地位置-开始-->

    {if $page->info['addr']}
    <div class="comn" id="nv-position">
        <div class="comn-title clearfix">
            <i class="icon-position"></i><span>场地位置</span>
        </div>
        <div class="comn-baike-position">
            <div class="fl map" id="map">
            </div>
            <div class="fl position-describe">
                {if count($page->getNearSpace)}
                <h2>附近场地</h2>
                {/if}
                <ul class="clearfix position-describe-ul" id="js-rela-space">
                    {foreach $page->getNearSpace as $k=>$v}
                        <li class="clearfix" data-lng="{$v['geo_lng']}" data-lat="{$v['geo_lat']}">
                            <a target="_blank" href="{$_home}site/{Func_Url::str_urlencode($v['space_name'],1)}">
                                <div class="text">
                                    <h6>
                                        {if mb_strlen($v['space_name']) >10}
                                            {mb_substr($v['space_name'],0,10,"utf8")}...
                                        {else}
                                            {$v['space_name']}
                                        {/if}
                                    </h6>
                                    <p>距离·{$v['distance_note']}</p>
                                </div>
                                <div class="pic">
                                    {if $v['logo']}
                                        <img src="{Page_Site_Global::displayMedia($v['logo'],72,55)}">
                                    {else}
                                        <img src="img/no_img.jpg">
                                    {/if}
                                </div>
                            </a>
                        </li>
                    {/foreach}
                </ul>
                <a class="position-more-btn" target="_blank" href="http://{Core::$urls['host']}/map2?lat={$page->info['geo_lat']}&lng={$page->info['geo_lng']}">查看更多周边场地</a>
            </div><!--position-describe-end-->
        </div><!--comn-baike-position-end-->
    </div><!--baike-facilities-end-->
    {/if}
    <!--场地简介-开始-->
    <div class="comn" id="nv-areaBrief">
        <div class="comn-title clearfix">
            <i class="icon-intro"></i><span>场地简介</span>
        </div>
        <div class="comn-baike-intro">
            <p>{strip_tags($page->info['des'],"<a>")}</p>
        </div>
    </div><!--baike-intro-end-->

    <!--租场地-开始-->
    {if $itemList}

    <div class="comn" id="nv-hireArea">
        <div class="comn-title clearfix">
            <i class="icon-lease"></i><span>租场地</span>
        </div>
            <table class="comn-baike-lease-table clearfix" cellpadding="0" cellspacing="0">
                <tr>
                    <th width="30%">名称</th>
                    <th>面积（㎡）</th>
                    <th>人数</th>
                    {if $page->itemPrice}
                        {* <th>市场价</th> *}
                        <th>优惠价</th>
                    {else}
                        <th>参考价</th>
                    {/if}
                    <th>其他</th>
                </tr>
                {foreach $itemList as $k=>$v}
                    <tr>
                        <td><a href="{$_home}site/{Func_Url::str_urlencode($page->info['space_name'],2)}-百科-{Func_NumEncode::e($v['id'])}#collection">{$v['item_name']}</a></td>
                        <td>{if $v['size']}{$v['size']}{else}{$page->info['attr'][10]}{/if}</td>
                        <td>
                            {if $v['min_people']==$v['max_people']}
                                {if $v['min_people'] < 50}
                                    50人以下
                                {else}
                                    {$v['min_people']}人
                                {/if}
                            {else}
                                {$v['min_people']} ~ {$v['max_people']}人
                            {/if}
                        </td>
                        {if $page->itemPrice}
                            {* <td>
                                {if $v['item_price']}
                                    {foreach $v['item_price'] as $k1=>$v1}
                                        {if $v1['is_public']}
                                            <p>
                                                <span class="f1 green standard">{$v1['standard']}</span>
                                                <span class="price_js">￥{$v1['market_price']}{$v1['price_unit']}</span>
                                            </p>
                                        {/if}
                                    {/foreach}
                                {else}
                                    面议
                                {/if}
                            </td> *}
                            {* <td class="discount_price"> *}
                            <td class="td-price" data-min_price="{$v['min_price']}" data-max_price="{$v['max_price']}" data-price_unit="{$v['price_unit']}">
                                {foreach $v['item_price'] as $k1=>$v1}
                                    {if $v1['is_public']}
                                        <p>
                                            <span class="f1 green standard">{$v1['standard']}</span>
                                            <span>￥{$v1['discount_price']}{$v1['price_unit']}</span>
                                        </p>
                                    {/if}
                                {/foreach}
                            </td>
                        {else}
                            <td>
                                {if $v['min_price']>100}
                                    {if $v['min_price']==$v['max_price']}
                                            ￥{$v['min_price']}元/{if $v['price_unit']}{$v['price_unit']}{else}天{/if}
                                    {else}
                                        ￥{$v['min_price']} ~ ￥{$v['max_price']}元/{if $v['price_unit']}{$v['price_unit']}{else}天{/if}
                                    {/if}
                                {else}
                                    面议
                                {/if}
                            </td>
                        {/if}
                        
                        <td>
                            <a class="btn" href="{$_home}site/{Func_Url::str_urlencode($page->info['space_name'],2)}-百科-{Func_NumEncode::e($v['id'])}#collection">查看详情</a>
                        </td>
                    </tr>
                {/foreach}
            </table>
    </div><!--baike-lease-end-->
    {/if}
</div>
<div class="side-nav" >
    {*<a href="javascript:;" class="inquiry-order" id="inquiryOrder">*}
        {*<span class="circle1">15</span>*}
    {*</a>*}
    <div class="title">
        <h6>百科词条目录</h6>
    </div>
    <ul class="side-list clearfix" id="nav">
       <!--  <li class="list1 lione current" >
            <a href="#nv-story">
                <span></span>
                <p>品牌故事</p>
            </a>
            <span class="line"></span>
        </li> -->
        {if !$page->info['logo']}
            <li class="list-pic lione" >
                <a href="#nv-pic">
                    <span></span>
                    <p>场地图片</p>
                </a>
                <span class="line"></span>
            </li>
        {/if}
        <li class="list2 lione">
            <a href="#nv-baseInfo">
                <span></span>
                <p>基础信息</p>
            </a>
            <span class="line"></span>
        </li>
        <li class="list3 lione">
            <a href="#nv-facilities">
                <span></span>
                <p>配套设施</p>
            </a>
            <span class="line"></span>
        </li>
        <li class="list4 lione">
            <a href="#nv-position">
                <span></span>
                <p>场地位置</p>
            </a>
            <span class="line"></span>
        </li>
        <li class="list5 lione">
            <a href="#nv-areaBrief">
                <span></span>
                <p>场地简介</p>
            </a>
            <span class="line"></span>
        </li>
        <li class="list6 lione">
            <a href="#nv-hireArea">
                <span></span>
                <p>租场地</p>
            </a>
        </li>
    </ul>
    {*</div><!--nav-end-->*}
</div>
<script>
    var thisLat = "{$page->info['geo_lat']}",thisLng = "{$page->info['geo_lng']}",thisSpaceName = "{$page->info['space_name']}";
    thisLat = thisLat/10000;
    thisLng = thisLng/10000;
</script>
{*{include file="Web_Static::site/inc/schedule_price_pop.tpl"}*}
<script type="text/javascript" src="http://developer.baidu.com/map/custom/stylelist.js"></script>
<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=aaNCRRcGGai6klHMOGZ8yBbP"></script>
<script type="text/javascript" src="js/map.v1.0/RichMarker.js"></script>
<script type="text/javascript" src="js/baike.v1.0/map.js"></script>
