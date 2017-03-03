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
    {static "encyclopedias/encyclopedias.js"}
</head>
<body>
{include "Web_Mobile_Static::v1.0/inc.nav.tpl"}
<div class="content">
    {*头部*}
    <header class="con-header">
        <div class="con-img">
            <div class="img">
                    <img src="img/comment/sub_img.jpg" alt="">
            </div>
        </div>

        <div class="con-header-body">
            {include file="Web_Mobile_Static::site/inc/nav.tpl"}

            <div class="con-title">
                <span>{$page->info['space_name']}奢居会派对会所</span>
            </div>
            <div class="con-kinds">
                <div class="con-kinds-li">
                    <span class="text">红厅</span>
                    <span class="ion-arrow-down-b icon-arrow"></span></div>

                <div class="cover1 hidden"></div>
                <div class="show-select-list hidden">
                    <div class="show-select-li">
                        奢居会派对会所-<span>黄厅</span>
                    </div>
                    <div class="show-select-li">
                        奢居会派对会所-<span>蓝厅</span>
                    </div>
                    <div class="show-select-li">
                        奢居会派对会所-<span>红厅</span>
                    </div>
                </div>
            </div>
            <div class="con-des">
                <span>{$page->info['special_tags']}露台 / 交通便利 / 餐饮</span>
            </div>
            <div class="con-addr">{$page->info['addr']}长江路258号</div>
            <a href="/m/site/baike_pic" class="con-pic">
                <span>22张</span>
            </a>
        </div>
    </header>
    <div class="baike_m_content">
        <div class="baike_m_title">参考价</div>
        <div class="baike_m_t price">￥<span>1000</span>/天</div>

        <div class="baike_m_title">详细地址 </div>
        <div class="baike_m_t adress">{$page->info['city']}市&nbsp;{$page->info['addr']}杨浦区 · 五角场商业区<br>杨浦区军工路1436号五维空间创意产业园61幢</div>

        <div class="baike_m_line"></div>
        <div class="baike_m_c_title">子空间基础信息</div>
        <table class="baike_m_basics_info">
            <tr>
                <td class="baike_m_basics_title">面积</td>
                <td class="baike_m_basics_c">80㎡</td>
                <td class="baike_m_basics_title">人数</td>
                <td class="baike_m_basics_c">90人</td>
            </tr>
            <tr>
                <td class="baike_m_basics_title">高度</td>
                <td class="baike_m_basics_c">6m</td>
                <td class="baike_m_basics_title">承重</td>
                <td class="baike_m_basics_c">1T</td>
            </tr>
            <tr>
                <td class="baike_m_basics_title">桌数</td>
                <td class="baike_m_basics_c">50</td>
                <td class="baike_m_basics_title">座位数</td>
                <td class="baike_m_basics_c">1000</td>
            </tr>
            <tr>
                <td class="baike_m_basics_title">舞台面积</td>
                <td class="baike_m_basics_c">150㎡</td>
                <td class="baike_m_basics_title"> </td>
                <td class="baike_m_basics_c"> </td>
            </tr>
            <tr>
                <td class="baike_m_basics_title">过往案例</td>
                <td class="baike_m_basics_c1" colspan="3">展览展示、文体娱乐、会议会务、新品发布会</td>
            </tr>
        </table>

        <div class="baike_m_line"></div>
        <div class="baike_m_c_title mb15">空间简介</div>
        <div class="baike_m_brand_introduce" id="baike_m_brief_content">
            {strip_tags($page->info['des'])}据了解，此次品牌快闪店的活动主题叫“设计中的生活”， 云SPACE联手原来集市、在上海虹口区最大的文化音乐谷所在地的半岛湾创意园，搭建户外市集平台，为创意设计商和时尚零售商提供展示及交易平台，配之以沪上知名音乐人和DJ艺人的音乐秀、街头艺术表演，提升了集市场地的人气和知名度。
        </div>
        <div class="baike_m_icon_down" id="baike_m_brief_down">
            <img src="img/encyclopedias/baike_m_icon_down.png">
        </div>
        <div class="baike_m_icon_up" id="baike_m_brief_up">
            <img src="img/encyclopedias/baike_m_icon_up.png">
        </div>

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

        <div class="baike_m_line"></div>
        <div class="baike_m_c_title">空间位置</div>
        <div class="baike_m_map">
            <div id="l-map"></div>
        </div>

        <div class="baike_m_line"></div>
        <div class="baike_m_c_title">该场地其他空间</div>
        <ul class="baike_m_rent">
            <li>
                <div class="title clearfix">
                    <h5 class="fl">罗斯柴尔德厅</h5>
                    <div class="fr price">￥<span>1000</span>/天</div>
                </div>
                <div class="cont">
                面积  -  200m²<br>
                人数  -  {if $v['min_people']==$v['max_people']}
                    {if $v['min_people'] < 50}
                        50人以下
                    {else}
                        {$v['min_people']}人
                    {/if}
                {else}
                    {$v['min_people']} ~ {$v['max_people']}人
                {/if}
                    <a class="fr btn-detail" href="">查看详情</a>
                </div>
            </li>
            <li>
                <div class="title clearfix">
                    <h5 class="fl">罗斯柴尔德厅</h5>
                    <div class="fr price">￥<span>1000</span>/天</div>
                </div>
                <div class="cont">
                    面积  -  200m²<br>
                    人数  -  {if $v['min_people']==$v['max_people']}
                        {if $v['min_people'] < 50}
                            50人以下
                        {else}
                            {$v['min_people']}人
                        {/if}
                    {else}
                        {$v['min_people']} ~ {$v['max_people']}人
                    {/if}
                    <a class="fr btn-detail" href="">查看详情</a>
                </div>
            </li>
            <li>
                <div class="title clearfix">
                    <h5 class="fl">罗斯柴尔德厅</h5>
                    <div class="fr price">￥<span>1000</span>/天</div>
                </div>
                <div class="cont">
                    面积  -  200m²<br>
                    人数  -  {if $v['min_people']==$v['max_people']}
                        {if $v['min_people'] < 50}
                            50人以下
                        {else}
                            {$v['min_people']}人
                        {/if}
                    {else}
                        {$v['min_people']} ~ {$v['max_people']}人
                    {/if}
                    <a class="fr btn-detail" href="">查看详情</a>
                </div>
            </li>
    </div>
</div>

<div class="bottom-nav-area">
    <a href="tel:4000560599">
        <div class="normal-block block-right-border">
            <span class="icon ion-ios-telephone" style="font-size: 20px;line-height: 22px;"></span>
            <p>咨询</p>
        </div>
    </a>
    <a class="collect" data-space_id="{$page->productInfo['id']}" data-space_logo="{$page->productInfo['logo']}" href="javascript:;">
        <div class="normal-block  js-favorite">
            <!--只做效果用-star-->
            <i class="js-star-move icon-star" style="font-size: 22px;line-height: 22px;"></i>
            <!--只做效果用-end-->

            <span class="icon ion-android-star-outline " style="font-size: 22px;line-height: 22px;"></span>
            <p>收藏</p>
        </div>
    </a>
    <a class="js-share" href="javascript:;">
        <div class="normal-block block-right-border">
            <span class="icon ion-android-share-alt" style="font-size: 18px;line-height: 22px;"></span>
            <p>分享</p>
        </div>
    </a>
    <div class="larger-block">
        <p><a href="schedule" style="display: block">查询档期和价格</a></p>
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

<script type="text/javascript">
    // 百度地图API功能
    var map = new BMap.Map("l-map");
    var point = new BMap.Point({$page->info['geo_lng']/10000},{$page->info['geo_lat']/10000});
    map.centerAndZoom(point, 12);
    var marker = new BMap.Marker(point);// 创建标注
    map.addOverlay(marker);             // 将标注添加到地图中
    marker.disableDragging();           // 不可拖拽
</script>
{static "core/yunspace.js"}

<!--收藏功能-->
{static "encyclopedias/collect.js"}
</body>
</html>
