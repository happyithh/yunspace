<!DOCTYPE html>
<html lang="en">
<head>
    {include file="Web_Static::inc/head_meta.tpl"}
    {static "search.v4.0/search2.css"}
    {static "search.v4.0/box.css"}
    {static "v4.0/data-picker.css"}
    <style>
        .hide{
            display:none!important;
        }
    </style>
</head>
<body yun="search.v4.0/search.js::init">
{include file="Web_Static::inc/header_1.tpl"}

<div class="search_head_back">
    <div class="search_head">
        <div class="search_head_content">
            {include file="Web_Static::search/inc.search_result2.tpl"}
        </div>
    </div>
</div>
<div class="search_content clearfix">
<div class="search_content_left" id="searchleft">

<div class="search_select_outside clearfix" id="search_content">
    <div class="search_select clearfix">
        <div class="search_select_content">
            <div class="search_select_section">
                <div class="search_select_section_left">
                    城市
                </div>
                <ul id="search_industry_type" class="search_select_section_right" style="{if !empty($page->getKeyword['city']) && $page->getKeyword['city']!='chzg'}height: auto;{/if}">
                    {foreach Web_Global::$city_name as $k=>$v}
                        <li class="{if $page->getKeyword['city']==$k}search_select_active{/if}">
                            <a href="{$_home}space/{Web_Search_Item_List::getUrls('city',$k)}"> {$v} </a>
                        </li>
                    {/foreach}
                    <div class="clear"></div>
                </ul>
                <p class="js-a-downup a-downup-wrapper {if !empty($page->getKeyword['city'])  && $page->getKeyword['city']!='chzg'}a-up{/if}">
                    <i class="icon-c a-downup"></i>
                </p>

                <div class="clear"></div>
            </div>
            {if !empty($page->getKeyword['city']) && $page->getKeyword['city']!='chzg' && !empty($page->getArea['行政区域'])}
                <div class="search_select_section">
                    <div class="search_select_section_left">
                        行政区域
                    </div>
                    <ul class="search_select_section_right clearfix" style="{if !empty($page->getKeyword['admin_area'])}height: auto;{/if}">
                        {foreach $page->getArea['行政区域'] as $k=>$v}
                            <li class="{if $page->getKeyword['admin_area']==$v}search_select_active{/if}">
                                <a href="{$_home}space/{Web_Search_Item_List::getUrls('admin_area',$v)}">{$v}</a>
                            </li>
                        {/foreach}
                    </ul>
                    <p class="js-a-downup a-downup-wrapper {if !empty($page->getKeyword['admin_area'])}a-up{/if}">
                        <i class="icon-c a-downup"></i>
                    </p>

                    <div class="clear"></div>
                </div>
            {/if}
            {if !empty($page->getKeyword['city']) && $page->getKeyword['city']!='chzg' && !empty($page->getKeyword['admin_area']) && count($page->getBusinessArea['所属商圈'])>0}
                <div class="search_select_section ">
                    <div class="search_select_section_left">
                        所属商圈
                    </div>
                    <ul id="search_area_type" class="search_select_section_right" style="{if !empty($page->getKeyword['business_area'])}height: auto;{/if}">
                        {foreach $page->getBusinessArea['所属商圈'] as $k=>$v}
                            <li class="{if $page->getKeyword['business_area']==$v}search_select_active{/if}">
                                <a href="{$_home}space/{Web_Search_Item_List::getUrls('business_area',$v)}">{$v}</a>
                            </li>
                        {/foreach}
                        <div class="clear"></div>
                    </ul>
                    <p class="js-a-downup a-downup-wrapper {if !empty($page->getKeyword['business_area'])}a-up{/if}">
                        <i class="icon-c a-downup"></i>
                    </p>

                    <div class="clear"></div>
                </div>
            {/if}

            <div class="search_select_section">
                <div class="search_select_section_left">
                    场地类型
                </div>
                <ul id="search_activity_type" class="search_select_section_right" style="{if !empty($page->getKeyword['category']) && $page->getKeyword['category']!=112}height: auto;{/if}">
                    {foreach $page->getCategory as $k=>$v}
                        {if $k!=112}
                            <li class="{if $page->getKeyword['category']==$k}search_select_active{/if}">
                                <a href="{$_home}space/{Web_Search_Item_List::getUrls('category',$k)}">{$v}</a>
                            </li>
                        {/if}
                    {/foreach}
                    <div class="clear"></div>
                </ul>
                <p class="js-a-downup a-downup-wrapper {if !empty($page->getKeyword['category']) && $page->getKeyword['category']!=112}a-up{/if}">
                    <i class="icon-c a-downup"></i>
                </p>

                <div class="clear"></div>
            </div>
            <div class="search_select_section">
                <div class="search_select_section_left">
                    适合活动类型
                </div>
                <ul id="search_activity_type" class="search_select_section_right" style="{if !empty($page->getKeyword['active_type'])}height: auto;{/if}">
                    {foreach $page->getActiveType as $k=>$v}
                        <li class="{if $page->getKeyword['active_type']==$v}search_select_active{/if}">
                            <a href="{$_home}space/{Web_Search_Item_List::getUrls('active_type',$v)}">{$v}</a>
                        </li>
                    {/foreach}
                    <div class="clear"></div>
                </ul>
                <p class="js-a-downup a-downup-wrapper {if !empty($page->getKeyword['active_type'])}a-up{/if}">
                    <i class="icon-c a-downup"></i>
                </p>

                <div class="clear"></div>
            </div>
            <div class="search_select_section">
                <div class="search_select_section_left">
                    空间容纳人数
                </div>
                <ul class="search_select_section_right clearfix">
                    {foreach $page->getPeople as $k=>$v}
                        <li class="{if $page->getKeyword['people_range']==$k}search_select_active{/if}">
                            <a href="{$_home}space/{Web_Search_Item_List::getUrls('people_range',$k)}">{$v}</a>
                        </li>
                    {/foreach}
                </ul>
                <div class="clear"></div>
            </div>
            <div class="search_select_section section_more_less {if empty($page->getKeyword['industry_type'])}hide{/if}">
                <div class="search_select_section_left">
                    行业类型
                </div>
                <ul id="search_area_type" class="search_select_section_right" style="{if !empty($page->getKeyword['industry_type'])}height:auto;{/if}">
                    {foreach $page->getIndustryType as $k=>$v}
                        <li class="{if $page->getKeyword['industry_type']==$v}search_select_active{/if}">
                            <a href="{$_home}space/{Web_Search_Item_List::getUrls('industry_type',$v)}">{$v}</a>
                        </li>
                    {/foreach}
                    <div class="clear"></div>
                </ul>
                <p class="js-a-downup a-downup-wrapper {if !empty($page->getKeyword['industry_type'])}a-up{/if}">
                    <i class="icon-c a-downup"></i>
                </p>

                <div class="clear"></div>
            </div>
            <div class="search_select_section section_more_less">
                <div class="search_select_section_left">
                    空间面积
                </div>
                <ul id="search_area_type" class="search_select_section_right">
                    {foreach $page->getSize as $k=>$v}
                        <li class="{if $page->getKeyword['size_range']==$k}search_select_active{/if}">
                            <a href="{$_home}space/{Web_Search_Item_List::getUrls('size_range',$k)}">{$v}</a>
                        </li>
                    {/foreach}
                    <div class="clear"></div>
                </ul>
                <div class="clear"></div>
            </div>
            <div class="search_select_section section_more_less">
                <div class="search_select_section_left">
                    户外/室内
                </div>
                <ul class="search_select_section_right clearfix">
                    <li class="{if $page->getKeyword['is_outside']==5}search_select_active{/if}">
                        <a href="{$_home}space/{Web_Search_Item_List::getUrls('is_outside',5)}">开放</a>
                    </li>
                    <li class="{if $page->getKeyword['is_outside']==3}search_select_active{/if}">
                        <a href="{$_home}space/{Web_Search_Item_List::getUrls('is_outside',3)}">半开放</a>
                    </li>
                    <li class="{if $page->getKeyword['is_outside']==1}search_select_active{/if}">
                        <a href="{$_home}space/{Web_Search_Item_List::getUrls('is_outside',1)}">室内</a>
                    </li>
                </ul>

                <div class="clear"></div>
            </div>
        </div>
    </div>
</div>
<div class="more_less_wrap">
    <a href="javascript:;" class="others_search_more list_more_less clearfix">
        <div class="others_search_word"> 展开</div>
        <div class="others_search_icon clearfix"></div>
    </a>
</div>


<div class="search_select_outside none" id="search_selected">
    <div class="search_select">
        <div class="search_selected_title">你已选择</div>
        <ul class="search_selected">
        </ul>
        <div class="clear"></div>
    </div>
    <div class="clear"></div>
</div>

<div class="search-sort clearfix">
    <div class="fl search-sort-list-new">
        <a href="{$_home}space" class="{if empty($page->getKeyword['rank'])}active{/if}" style="font-size: 1em;">推荐</a>
        <span class="line" style="padding-right: 5px;padding-left: 5px;">|</span>
        <a class="sort sort-jg {if $page->getKeyword['rank']=='pup' || $page->getKeyword['rank']=='pdown'}active{/if}" href="javascript:;">价格<i class="icon-sort"></i></a>
        <span class="line" style="padding-right: 5px;padding-left: 5px;">|</span>
        <a class="sort sort-zs {if $page->getKeyword['rank']=='iup' || $page->getKeyword['rank']=='idown'}active{/if}" href="javascript:;">指数<i class="icon-sort"></i></a>
    </div>
    <a href="{$_home}map2" class="fr sicon icon-map" target="_blank" title="场地地图"></a>
</div>

<!--------------------数据显示开始------------------------------->
{if count($page->getItemSearchList['rows'])>0}
    {foreach $page->getItemSearchList['rows'] as $k=>$v}
        <div class="search_list clearfix">
            <div class="search_list_title_outside clearfix">
                <div class="search_list_title">
                    <a href="{$_home}site/{Func_Url::str_urlencode($v['baike_item_name'])}-百科"
                       target="_blank">{$v['baike_item_name']}
                        <span>{$page->getCategory[$v['category_id']]}</span></a>

                    <p class="fr price">
                        {if !empty($v['min_price']) && $v['min_price']>100}￥{$v['min_price']}{if !empty($v['price_unit'])}{$v['price_unit']}{else}元/天{/if}&nbsp;{if $v['item_count']>1 || $v['item_max_price']>$v['min_price']}起{/if}{else}面议{/if}</p>
                </div>
            </div>
            <div class="search_list_content clearfix">

                <div class="search_list_img">
                    <a href="{$_home}site/{Func_Url::str_urlencode($v['baike_item_name'])}-百科" target="_blank">
                        {if !empty($v['baike_logo'])}
                            <img src="{Page_Site_Global::displayMedia($v['baike_logo'],242,154)}"/>
                        {else}
                            <img src="img/img_zu.jpg"/>
                        {/if}
                    </a>

                    <div class="marks">
                        {foreach $v['tags_news'] as $kk=>$vv}
                            <p><span>{$v}</span><i class="bg"></i></p>
                        {/foreach}
                    </div>

                </div>
                <div class="search_list_des clearfix">
                    <div class="search_list_word">
                        {if !empty($v['baike_des'])}
                            {mb_substr(str_replace('&nbsp;','',strip_tags($v['baike_des'])),0,76,'utf-8')}...
                        {/if}
                    </div>
                    <div class="number-space clearfix">
                        {if !empty($v['baike_min_people']) || !empty($v['baike_max_people'])}
                            <i class="sicon icon-people"></i>
                        {/if}
                        {if !empty($v['baike_min_people']) && !empty($v['baike_max_people']) && ($v['baike_min_people'] != $v['baike_max_people'])}
                            <p>{$v['baike_min_people']}人~{$v['baike_max_people']}人</p>
                        {elseif !empty($v['baike_min_people']) && !empty($v['baike_max_people']) && $v['baike_min_people']==$v['baike_max_people']}
                            <p>{$v['baike_min_people']}人</p>
                        {elseif !empty($v['baike_min_people']) && empty($v['baike_max_people'])}
                            <p>{$v['baike_min_people']}人以上</p>
                        {elseif empty($v['baike_min_people']) && !empty($v['baike_max_people'])}
                            <p>{$v['baike_max_people']}人以下</p>
                        {/if}
                        {if !empty($v['baike_min_size']) || !empty($v['baike_max_size'])}
                            <i class="sicon icon-area"></i>
                        {/if}
                        {if !empty($v['baike_min_size']) && !empty($v['baike_max_size'])}
                            {if  $v['baike_min_size']!=$v['baike_max_size']}
                                <p>{$v['baike_min_size']}㎡~{$v['baike_max_size']}㎡</p>
                            {else}
                                <p>{$v['baike_min_size']}㎡</p>
                            {/if}
                        {elseif !empty($v['baike_min_size']) && empty($v['baike_max_size'])}
                            <p>{$v['baike_min_size']}㎡</p>
                        {elseif empty($v['baike_min_size']) && !empty($v['baike_max_size'])}
                            <p>{$v['baike_max_size']}㎡</p>
                        {/if}
                    </div>
                    <div class="adress clearfix">
                        <i class="sicon icon-adress"></i>

                        <p>{$v['addr']}</p>
                        <a href="{$_home}map2?lat={$v['geo_lat']}&lng={$v['geo_lng']}" target="_blank">查看地图</a>
                    </div>
                    <ul class="infrastructure clearfix">
                        {if !empty($v['facility'])}
                            {foreach $v['facility'] as $kk=>$vv}
                                {if array_key_exists($vv,$page->icon_arr)}
                                    <li class="{$page->icon_arr[$vv]}">
                                    <span>
                                        {$vv}
                                    </span>
                                    </li>
                                {/if}
                            {/foreach}
                        {/if}
                        <!--显示更多按钮-->
                        <li class="btn-config-more"></li>

                        <!--用来盖住多于5个的其它元素-->
                        <li class="config-mask"></li>
                    </ul>
                    <div class="search_list_web">
                        <span class="browse">浏览量：{$v['click']}</span>
                        <span class="indexs">指数：{floor($v['order_index']/10)}</span>
                        <span class="space-fit-numb"><span id="fit-item-{$v['baike_id']}">{$v['item_count']}个适合空间/</span><span id="count-item-{$v['baike_id']}"  >共{$v['item_count']}个空间</span></span>
                    </div>
                    <!--浏览量、指数-结束-->
                </div>
                <!--右侧内容-结束-->
            </div>
            <!--search_list_content-end-->
            <div class="fl space-fit-details">
                <table cellpadding="0" cellspacing="0" id="item_{$v['baike_id']}">
                    <tr class="trfirst">
                        <th width="14%">名称</th>
                        <th width="11%">面积（㎡）</th>
                        <th width="13%">人数</th>
                        <th width="13%">规格</th>
                        <th width="16%">参考价</th>
                        <th width="16%">售价</th>
                        <th width="20%"></th>
                    </tr>
                        <tr id="more-item-{$v['baike_id']}" class="hide">
                            <td colspan="7">
                                <a class="lookmore"
                                   href="{$_home}site/{Func_Url::str_urlencode($v['baike_item_name'])}-百科-{Func_NumEncode::e($v['item_id'])}"
                                   target="_blank">查看更多空间</a>
                            </td>
                        </tr>
                </table>
            </div>
        </div>
    {/foreach}
{else}
    <div class="search-no">
        <div class="search-no-fig">找到相关场地0个</div>
        <div class="search-no-title">
            抱歉，没有找到{if !empty($_REQUEST['keyword2'])}与“<span>{$_REQUEST['keyword2']}</span>”{/if}相关的场地内容！
        </div>
        <p class="search-no-suggest">建议您：</p>
        <ul class="search-no-suggest-content">
            <li>“<a href="{$_home}" class="search-no-back-home">返回首页</a>” 或“<a href="{$_home}space"
                                                                               class="search-no-refresh">刷新</a>”。
            </li>
            <li>任何咨询、建议、意见请找<a href="mailto:service@yunspace.com.cn" class="search-no-mail"> service@yunspace.com.cn</a>。
            </li>
            <li>检查输入的文字是否有无。</li>
        </ul>
    </div>
{/if}
<!--------------------数据显示结束------------------------------->
{if !empty($page->getSearchKeywordList)}
<div class="related_search">
    <div class="related_title">相关搜索</div>
    <ul class="related_content">
        {foreach $page->getSearchKeywordList  as $k=>$v}
            <li><a href="{$_home}site/{Func_Url::str_urlencode($v['baike_item_name'])}-百科"> {$v['search_title']}</a>
            </li>
        {/foreach}
        <div class="clear"></div>
    </ul>
</div>
{/if}
<!--------------------分页--开始----------------------------->
<div class="pagers">
    {if $page->getItemSearchList['page']['dpll']}
        <a href="{$page->getItemSearchList['page']['dup']}1" title="First">第一页</a>
        <a href="{$page->getItemSearchList['page']['dup']}{$page->getItemSearchList['page']['dp']-1}"
           title="Prev">上一页</a>
    {else}
        <a href="" class="prev first gray"><span>&laquo;&nbsp;</span>第一页</a>
        <a href="" class="prev gray">&lt;&nbsp;上一页</a>
    {/if}
    {for $i=$page->getItemSearchList['page']['dpl'] to $page->getItemSearchList['page']['dpr']}
        <a href="{$page->getItemSearchList['page']['dup']}{$i}"{if $i==$page->getItemSearchList['page']['dp']} class="active"{/if}>{$i}</a>
    {/for}

    {if $page->getItemSearchList['page']['dprr']}
        <a href="{$page->getItemSearchList['page']['dup']}{$page->getItemSearchList['page']['dp']+1}"
           title="Next">下一页&nbsp;&gt;</a>
        <a href="{$page->getItemSearchList['page']['dup']}{$page->getItemSearchList['page']['dtp']}"
           title="Last">最后页&nbsp;&raquo;</a>
    {else}
        <a href="" class="next gray">下一页&nbsp;&gt;</a>
        <a href="" class="next last gray">最后页<span>&nbsp;&raquo;</span></a>
    {/if}
</div>
<!--------------------分页--结束----------------------------->

<!--一键租场地按钮框-->
<div class="btn-onekeyrental-wrap">
    <p>没有找到场地？</p>

    <p> 提交您的活动需求，快速匹配适合的场地</p>

    <p> 一键租场地，省时、省心，找你所想</p>
    <a class="btn-onekeyrental" href="/space_library?action=form">一键租场地</a>
</div>

</div>
<div class="search_content_right_no clearfix">
    <ul class="search-no-right classify_rt_img">
        <li><a href="{$_home}space_library?action=form" class="space-rent"></a></li>
        <li><a href="{$_home}site_join" class="space-join"></a></li>
        <li><a href="{$_home}map2" class="space-map"></a></li>
        <li>
            <div class="search-no-right-weixin">
                <img src="img/qrcode_space.png" >
            </div>
            <div class="search-no-right-content">
                <div class="search-no-weixin-title">举起手机，扫一扫关注</div>
                <div class="search-no-weixin-word">云·space微信公众号<br>随时随地获取方案</div>
            </div>
            <div class="clear"></div>
        </li>
    </ul>

</div>
</div>

<!--查询档期和价格弹窗-开始-->
<div class="cover none" id="cover"></div>
<div class="search-box none" id="search-code">
    <div class="search-box-close">
        <a href="javascript:;" id="search-box-close"><img src="img/v4.0/close.png" alt=""></a>
    </div>
    <div class="search-box-title">
        <span>查询档期和价格</span>
    </div>
    <input type="hidden" name="from_type" class="from_type" value="1">
    <input type="hidden" name="space_id" class="space_id">
    <input type="hidden" name="space_name" class="space_name">
    <input type="hidden" name="demand_city" class="demand_city">
    <input type="hidden" name="item_name" class="item_name">
    <input type="hidden" name="item_id" class="item_id">

    <ul class="search-box-item">
        <li>
            <div class="search-box-label">你的称呼</div>
            <input class="search-box-input" name="username" placeholder="请输入你的称呼">

            {*<div class="search-box-placeholder">请输入你的称呼</div>*}
        </li>
        <li>
            <div class="search-box-label">你的手机号码</div>
            <input class="search-box-input" name="phone" placeholder="查询结果将以短信方式发送给你">

            {*<div class="search-box-placeholder">查询结果将以短信方式发送给你</div>*}
        </li>
        <li>
            <div class="search-box-label">活动档期</div>
            <div class="enquiry-con-input-con">
                <input name="date_start" type="text" placeholder="开始日期" readonly style="width:33%;float: left"
                       yun="product.v2.0/enquiry.js::dateSelect@click" class="datePicker search-date-start"
                       data-validate="true" data-error="请选择开始的活动日期">
                <span style="float: left;width:4%;line-height: 30px;text-align: center">——</span>
                <input name="date_end" type="text" placeholder="结束日期" readonly style="width:33%;float: left"
                       yun="product.v2.0/enquiry.js::dateSelect@click" class="datePicker search-date-end"
                       data-validate="true" data-error="请选择结束的活动日期">

                <div class="clear"></div>
                <div class="search-date-outside">
                    <div yun="data-picker/js/date-picker.js::initPlugin" class="date-picker" yun-input=".datePicker"
                         yun-autohide="true" yun-autohidenode=".search-date-outside"
                         yun-with-input="false"></div>
                </div>
            </div>
        </li>
        <li>
            <div class="search-box-label">更多咨询</div>
            <input class="search-box-input" name="other_demand" placeholder="填写你想要咨询的其他问题">

            {*<div class="search-box-placeholder">填写你想要咨询的其他问题</div>*}
        </li>
        <div class="clear"></div>
    </ul>
    <p class="none error_msg"></p>

    <div class="clear"></div>
    <button class="search-box-btn">提交</button>
    <div class="search-box-code-outside">
        <div class="search-box-code">
            <img src="img/qrcode_space.png" >
        </div>
        <div class="search-box-code-word">
            <span>打开微信，扫一扫关注</span><br>
            云·space 微信公众号<br>随时随地获取报价方案
        </div>
        <div class="clear"></div>
    </div>
</div>
<!--查询档期和价格弹窗-结束-->

{include file="Web_Static::inc/public_space.tpl"}
{include file="Web_Static::inc/html_footer.tpl"}
{static "core/yunspace.js"}
{static "search.v4.0/item_price.js"}
{static "search.v4.0/search2.js"}
{static "search.v4.0/highlight_item.js"}
<script>
    function shaixuan() {
        var selectBut = '';
        {if count($page->getScreenValue)>0}
        {foreach $page->getScreenValue as $k=>$v}
        {if !empty($v)}
        selectBut += ' <li><span>{$v}</span>' +
        '<a href="{$_home}space/{Web_Search_Item_List::getUrls($k,'')}"></a></li>';
        {/if}
        {/foreach}
        {/if}
        if (selectBut) {
            selectBut += '<li><a href="{$_home}space" class="search_selected_deleted"> 全部删除</a></li>';
            $('#search_selected').removeClass('none');
            $('#search_selected').css('display', 'block');
        }
        selectBut += '<div class="clear"></div>';
//        $('.screen').html(selectBut);
        $('.search_selected').html(selectBut);
    }
    shaixuan();
    var size_range = "{$page->getScreenValue['size_range']}";
    var is_outside = "{$page->getScreenValue['is_outside']}";
    var business_area = "{$page->getScreenValue['business_area']}";
    var industry_type = "{$page->getScreenValue['industry_type']}";
    if (size_range != '' || is_outside != '' || industry_type != '') {
        $('.section_more_less').css('display', 'block');
        $('.others_search_icon ').addClass('others_search_icon_toggle');
        $('.others_search_word').text('收起');
    }
    var baike_id = [];
    baike_id = [
        {foreach $page->getItemSearchList['rows'] as $k=>$v}
        "{$v['baike_id']}",
        {/foreach}
    ];
    // js请求子空间使用
    var city = "{$page->getKeyword['city']}";
    var category = "{$page->getKeyword['category']}";
    var activeType = "{$page->getKeyword['activeType']}";
    var size_range = "{$page->getKeyword['size_range']}";
    var people_range = "{$page->getKeyword['people_range']}";
    var is_outside = "{$page->getKeyword['is_outside']}";

    // 价格、指数排序

    <!--价格-->
    var rank = "{$page->getKeyword['rank']}";
    if (rank == 'pup') {
        $('.search-sort-list-new .sort-jg .icon-sort').addClass('up');
    } else if (rank == 'pdown') {
        $('.search-sort-list-new .sort-jg .icon-sort').addClass('down');
    } else if (rank == 'iup') {
        $('.search-sort-list-new .sort-zs .icon-sort').addClass('up');
    } else if (rank == 'idown') {
        $('.search-sort-list-new .sort-zs .icon-sort').addClass('down');
    }
    $('.search-sort-list-new .sort-jg').on('click', function () {
        var tsort = $(this).find('.icon-sort');
        if (tsort.hasClass('down')) {
            tsort.removeClass('down');
            $('.sort-jg').attr('href', "{$_home}space/{Web_Search_Item_List::getUrls('rank','pup')}");
            tsort.addClass('up');
        } else {
            $('.sort-jg').attr('href', "{$_home}space/{Web_Search_Item_List::getUrls('rank','pdown')}");
            tsort.addClass('down');
        }
    });
    <!--指数-->
    $('.search-sort-list-new .sort-zs').on('click', function () {
        var tsort_zs = $(this).find('.icon-sort');
        if (tsort_zs.hasClass('up')) {
            tsort_zs.removeClass('up');
            $('.sort-zs').attr('href', "{$_home}space/{Web_Search_Item_List::getUrls('rank','iup')}");
            tsort_zs.addClass('down');
        } else {
            $('.sort-zs').attr('href', "{$_home}space/{Web_Search_Item_List::getUrls('rank','idown')}");
            tsort_zs.addClass('up');
        }
    });
    function getPrice(e) {
        $('.space_id').val($(e).data('space_id'));
        $('.space_name').val($(e).data('space_name'));
        $('.item_name').val($(e).data('item_name'));
        $('.item_id').val($(e).data('item_id'));
        if (city == 'chzg' || city == 'undefined') {
            $('.demand_city').val('');
        } else {
            $('.demand_city').val(city);
        }

    }
</script>
</body>
</html>