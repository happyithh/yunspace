<div class="cont current">
    <!--活动报价-->
    {if $page->itemInfo['item_price']}
        <div class="comn comn-price">
            <table cellpadding="0" cellspacing="0" id="price_table">
                <tr>
                    <th width="22%">规格</th>
                    <th width="30%">市场价</th>
                    <th width="30%">优惠价</th>
                    <th width="18%">预定</th>
                </tr>
                {foreach $page->itemInfo['item_price'] as $k=>$v}
                    <tr>
                        <td class="td-date">{$v['standard']}</td>
                        <td class="td-price">
                            {if $v['is_public']}
                                ￥<span>{$v['market_price']}</span>{$v['price_unit']}</span>
                            {else}
                                面议
                            {/if}
                        </td>
                        <td class="td-disprice">
                            {if $v['is_public'] && $v['market_price']!=$v['discount_price']}
                                ￥<span>{$v['discount_price']}</span>{$v['price_unit']}
                            {/if}
                        </td>
                        <td class="td-reserve"><a class="btn-reserve" href="http://{Core::$urls['host']}/space_library?action=form&price_id={Func_NumEncode::e($v['id'])}">立即预定</a></td>
                    </tr>
                {/foreach}
                {* <tr>
                    <td class="td-date">平日</td>
                    <td class="td-price">￥<span>25,000</span>/天</td>
                    <td class="td-disprice">￥<span>30,000</span>/天</td>
                    <td class="td-reserve"><a class="btn-reserve" href="">立即预定</a></td>
                </tr>
                <tr>
                    <td class="td-date">周末</td>
                    <td class="td-price">￥<span>25,000</span>/天</td>
                    <td class="td-disprice">￥<span>25,000</span>/天</td>
                    <td class="td-reserve"><a class="btn-reserve" href="javascript:;">立即预定</a></td>
                </tr> *}
            </table>
        </div>
    {/if}
    <!--基本信息-开始-->
    <div class="comn come-info">
        <div class="comn-title clearfix">
            <i></i><span>基本信息</span>
            {if !$page->itemInfo['item_price']}
                <div class="price">参考价：
                    {if $page->itemInfo['min_price']==$page->itemInfo['max_price']}
                        {if $page->itemInfo['min_price'] < 100}
                            <span>面议</span>
                        {else}
                            ¥<span>{$page->itemInfo['min_price']}</span>元 / {if $page->itemInfo['price_unit']}{$page->itemInfo['price_unit']}{else}天{/if}
                        {/if}
                    {else}
                        ¥<span>{$page->itemInfo['min_price']} ~ {$page->itemInfo['max_price']}</span>元 / {if $page->itemInfo['price_unit']}{$page->itemInfo['price_unit']}{else}天{/if}
                    {/if}
                    <a class="alone-reserve" href="http://{Core::$urls['host']}/space_library?action=form&item_id={Func_NumEncode::e($page->itemInfo['id'])}">立即预定</a>
                </div>

            {/if}

        </div>
        <div class="comn-baike-info clearfix">
            {* {if $page->itemInfo['item_price']}
                <dl class="clearfix dl-space-scale">
                    <dt>空间报价</dt>
                    <dd>
                       <table id="price_table" class="comn-baike-lease-table clearfix" cellpadding="0" cellspacing="0">
                    <tr>
                        <th width="30%">规格</th>
                        <th>市场价</th>
                        <th>优惠价</th>
                    </tr>
                    {foreach $page->itemInfo['item_price'] as $k=>$v}
                        <tr>
                            <td>{$v['standard']}</td>
                            <td>
                                {if $v['is_public']}
                                    <span>￥{$v['market_price']}{$v['price_unit']}</span>
                                {else}
                                    面议
                                {/if}
                            </td>
                            <td class="discount_price">
                                {if $v['is_public'] && $v['market_price']!=$v['discount_price']}
                                    ￥{$v['discount_price']}{$v['price_unit']}
                                {/if}
                            </td>
                        </tr>
                    {/foreach}
                </table>
                </dd>
            </dl>
            {/if} *}

            {* <dl class="clearfix">
                <dt>适合活动类型</dt>
                <dd>{str_replace(",","、",$page->tags["93"]['活动类型'])}</dd>
            </dl> *}
            <dl class="clearfix dl-space-scale">
                <dt>空间标准</dt>
                <dd>
                    <p><i class="icon-size"></i>
                        <span>
                            {if $page->itemInfo['size']}{$page->itemInfo['size']}{else}{$page->info['attr'][10]}{/if}
                           m²
                        </span>
                    </p>
                    {*<p><i class="icon-hight"></i><span>{$page->info["attr"]['6']}</span></p>*}
                    {*<p><i class="icon-weight"></i><span>{$page->info["attr"]['11']}</span></p>*}
                    <p>
                        <i class="icon-people"></i>
                        <span>
                            {if $page->itemInfo['min_people']==$page->itemInfo['max_people']}
                                {if $page->itemInfo['min_people'] < 50}
                                    50人以下
                                {else}
                                    {$page->itemInfo['min_people']}人
                                {/if}
                            {else}
                                {$page->itemInfo['min_people']} ~ {$page->itemInfo['max_people']}人
                            {/if}
                        </span>
                    </p>
                    {if $page->itemInfo['location_area']}
                        <p><i class="icon-hight"></i><span>{$page->itemInfo["location_area"]}</span></p>
                    {/if}
                    {if $page->itemInfo['lifetime']}
                        <p><i class="icon-weight"></i><span>{$page->itemInfo["lifetime"]}</span></p>
                    {/if}
                </dd>
            </dl>
            <dl class="clearfix dl-space-intro">
                <dt>空间介绍</dt>
                <dd>{strip_tags($page->itemInfo['des'],"<a>")}</dd>
            </dl>
        </div>
    </div><!--baike-intro-end-->

    <!--图片展示-开始-->
    <div class="comn come-picture">
        <div class="comn-title clearfix">
            <i></i><span>图片展示</span>
        </div>

        <div class="comn-space-img clearfix" id="linkimgCarousel">
            {foreach $page->itemInfo['media'] as $k=>$v}
                <a title="{$page->itemInfo['item_name']}&nbsp;&nbsp;{if $v['tags']}({$v['tags']}){/if}" rel="group" class="linkimg" href="{if !$_REQUEST['is_local_env']}http://s2.yunspace.com.cn{/if}{Page_Site_Global::displayMedia($v['path'],750,500,1)}">
                    <img title="{$page->itemInfo['item_name']}&nbsp;&nbsp;{if $v['tags']}({$v['tags']}){/if}" src="{Page_Site_Global::displayMedia($v['path'],294,252,1)}">
                    {*<img title="{$page->itemInfo['item_name']}&nbsp;&nbsp;({$v['tags']})" data-src="{if !$_REQUEST['is_local_env']}http://s2.yunspace.com.cn{/if}{Page_Site_Global::displayMedia($v['path'],750,500,1)}" src="{if $page->itemInfo['is_thc']}{Page_Site_Global::displayMedia($v['path'],262,225,1,'thc')}{else}{Page_Site_Global::displayMedia($v['path'],294,252,1)}{/if}">*}
                </a>
            {/foreach}
            {if count($page->itemInfo['media'])%3 ==1}
                <a href="javascript:;"><div class="loading"></div></a>
                <a href="javascript:;"><div class="loading"></div></a>
            {elseif count($page->itemInfo['media'])%3 ==2}
                <a href="javascript:;"><div class="loading"></div></a>
            {/if}
        </div>
        <!--加载更多按钮-->
        {*<a href="javascript:;" class="load-more-btn">加载更多</a>*}
    </div>
</div>


<!--弹窗 如果场地无media时-->
{if $page->spaceMedia && count($page->spaceMedia)>0}
<div class="pop-img">
    <div class="close js-close"></div>
    <div class="title clearfix">
        <h3 class="img_title">奢居会空间派对会所</h3>
        <p><span class="img_number">1</span>/{count($page->spaceMedia)}</p>
    </div>
    <div class="img">
        <img src="img/baike.v1.0/img_info.jpg">
    </div>
</div>
{/if}
<script>
$(document).ready(function () {
//    showLgImg();
//    jsClose();
//百科页面子空间图片展示
    $(".linkimg").fancybox({
        'titlePosition' : 'over',
        'cyclic'        : true,
        helpers : {
            title: {
                type: 'outside'
            }
        },
        'titleFormat'    : function(title, currentArray, currentIndex, currentOpts) {
            return (title.length ? '   ' + ('<p>'+title+'</p>') : '') + '<span id="fancybox-title-over">' + (currentIndex + 1) +
                ' / ' + currentArray.length + '</span>';
        },
        'changeSpeed' : 100
    });
    $('#linkimgCarousel').YunCarousel({
        delay : 5000,
        next : '#nextCarousel',
        prev : '#prevCarousel'
    });
    //子空间列表样式显示
    $("#price_table tr").each(function(index,ele){
        var len=$(ele).find("td").length;
        var text=$(ele).find("td").eq(2).text().trim();
       if(len==4 && text){
            // $(ele).find("td").eq(1).find("span").addClass("market_price");
            $(ele).find("td").eq(1).addClass("market_price");
       }
    });
})
</script>