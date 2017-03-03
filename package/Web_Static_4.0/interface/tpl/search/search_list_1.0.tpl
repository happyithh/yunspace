<!DOCTYPE html>
<html lang="en">
<head>
    {include file="Web_Static::inc/head_meta.tpl"}
    {static "search.v4.0/search.css"}
    {static "search.v4.0/box.css"}
    {static "v4.0/data-picker.css"}

</head>
<body>
{include file="Web_Static::inc/header_1.tpl"}

    <div class="search_head_back">
        <div class="search_head">
            <div class="search_head_content">
                {include file="Web_Static::search/inc.search_result.tpl"}
            </div>
        </div>
    </div>
    <div class="search_content">
        <div class="search_content_left">

            <div class="search_select_outside" id="search_content" {if !$page->getSpaceList['rows']}style="display: none" {/if}>
                <div class="search_select">

                 <div class="search_select_content">
                     <div class="search_select_section">
                         <div class="search_select_section_left">
                             城市
                         </div>
                         <ul id="search_industry_type" class="search_select_section_right">
                             {foreach $page->getCityArr as $k=>$v}
                                 <li {if $page->request['city_key'] && $page->request['city_key']==$k}class="search_select_active" {/if}>
                                     <a href="{$_home}{Web_Search_Space_New::concatUrlTags('city', $k)}"> {$v} </a>
                                 </li>
                             {/foreach}
                             <div class="clear"></div>
                         </ul>
                         <p class="js-a-downup a-downup-wrapper">
                             <i class="icon-c a-downup"></i>
                         </p>
                         <div class="clear"></div>
                     </div>
                     {if isset($_REQUEST['city_key'])}
                     <div class="search_select_section">
                         <div class="search_select_section_left">
                             行政区域
                         </div>
                         <ul id="search_industry_type" class="search_select_section_right">
                             {foreach $page->getAreas($_REQUEST['city_key']) as $k=>$v}
                                 <li {if $page->request['filter'] && isset($page->request['filter'][4]) &&  $page->request['filter'][4]==$v}class="search_select_active" {/if}>
                                     <a href="{$_home}{Web_Search_Space_New::concatUrlTags(4, $v)}">{$v}</a>
                                 </li>
                             {/foreach}
                             <div class="clear"></div>
                         </ul>
                         <p class="js-a-downup a-downup-wrapper">
                             <i class="icon-c a-downup"></i>
                         </p>
                         <div class="clear"></div>
                     </div>
                     {/if}
                     <div class="search_select_section">
                         <div class="search_select_section_left">
                             场地类型
                         </div>
                         <ul id="search_activity_type" class="search_select_section_right">
                             {foreach $page->getBaiKeCategory as $k=>$v}
                                 <li {if $page->request['category_id'] && $page->request['category_id']==$k}class="search_select_active" {/if}>
                                     <a href="{$_home}{Web_Search_Space_New::concatUrlTags('category', $v)}">{$v}</a>
                                 </li>
                             {/foreach}
                             <div class="clear"></div>
                         </ul>
                         <p class="js-a-downup a-downup-wrapper">
                             <i class="icon-c a-downup"></i>
                         </p>
                         <div class="clear"></div>
                     </div>
                     <div class="search_select_section">
                         <div class="search_select_section_left">
                             适合活动类型
                         </div>
                         <ul id="search_activity_type" class="search_select_section_right">
                             {foreach $page->getActiveType as $k=>$v}
                                 <li {if $page->request['filter'] && isset($page->request['filter'][49]) &&  ($page->request['filter'][49]==trim($v))}class="search_select_active" {/if}>
                                    <a href="{$_home}{Web_Search_Space_New::concatUrlTags(49, $v)}">{$v}</a>
                                 </li>
                             {/foreach}
                             <div class="clear"></div>
                         </ul>
                         <p class="js-a-downup a-downup-wrapper">
                             <i class="icon-c a-downup"></i>
                         </p>
                         <div class="clear"></div>
                     </div>
                     <div class="search_select_section">
                         <div class="search_select_section_left">
                             场地面积
                         </div>
                         <ul id="search_area_type" class="search_select_section_right">
                             {foreach $page->getSizeRange as $k=>$v}
                             <li {if $page->request['size_range'] && $page->request['size_range']==$k}class="search_select_active" {/if}>
                                 <a href="{$_home}{Web_Search_Space_New::concatUrlTags('size', $k)}">{$v}</a>
                             </li>
                             {/foreach}
                             <div class="clear"></div>
                         </ul>
                         <p class="js-a-downup a-downup-wrapper">
                             <i class="icon-c a-downup"></i>
                         </p>
                         <div class="clear"></div>
                     </div>
                 </div>
                </div>
                {*<a href="#" class="search_select_btn" id="search_content_btn">*}
                    {*<i class="search_select_icon"></i>*}
                    {*<div class="search_select_word clearfix">收起</div>*}
                {*</a>*}
                <div class="clear"></div>
            </div>
            <div class="search_select_outside none" id="search_selected">
                <div class="search_select">
                    <div class="search_selected_title">你已选择</div>
                    <ul class="search_selected">
                    </ul>
                    <div class="clear"></div>
                </div>
                <script>
                    function shaixuan() {
                        var selectBut = '';
                        {if isset($page->request['filter'])}
                        {*{if $key=='filter'}*}
                        {foreach $page->request['filter'] as $k=>$v}
                        {if $k}
                        selectBut += ' <li><span>{$v}</span>' +
                        '<a href="{$_home}{Web_Search_Space_New::concatUrlTags($k,'')}"></a></li>';
                        {/if}
                        {/foreach}
                        {*{/if}*}
                        {/if}
                        {foreach $page->request as $key=>$val}
                        {if $key=='size_range' }
                        {if $val}
                        selectBut += ' <li><span>{$page->getSizeRange[$val]}</span>' +
                        '<a href="{$_home}{Web_Search_Space_New::concatUrlTags('size','')}"></a></li>';
                        {/if}
                        {/if}
                        {if $key=='category_id'}
                        {if $val}
                        selectBut += ' <li><span>{$page->getBaiKeCategory[$val]}</span>' +
                        '<a href="{$_home}{Web_Search_Space_New::concatUrlTags('category', '')}"></a></li>';
                        {/if}
                        {/if}
                        {if $key=='city_key'}
                        {if $val}
                        selectBut += ' <li><span>{$page->getCityArr[$val]}</span>' +
                        '<a href="{$_home}{Web_Search_Space_New::concatUrlTags('city','')}"></a></li>';
                        {/if}
                        {/if}
                        {/foreach}
                        if (selectBut) {
                            selectBut +='<li><a href="/spaces-tags/" class="search_selected_deleted"> 全部删除</a></li>';
                            $('#search_selected').removeClass('none');
                            $('#search_selected').css('display','block');
                        }
                        selectBut +='<div class="clear"></div>';
                        $('.search_selected').html(selectBut);
                    }
                    shaixuan();
                </script>
                {*<a href="#" class="search_select_btn" id="search_selected_btn">*}
                    {*<i class="search_select_icon1"></i>*}
                    {*<div class="search_select_word clearfix">筛选</div>*}
                {*</a>*}
                <div class="clear"></div>
            </div>
            {if $page->getSpaceList['rows']}
                {$bk="-百科"}
          {foreach $page->getSpaceList['rows'] as $k=>$v}
              {*{var_dump($v)}*}
              <div class="search_list">
                  <div class="search_list_title_outside">
                      <div class="search_list_title">
                          <a href="{$_home}site/{Func_Url::str_urlencode($v['space_name'],1)}" target="_blank"> {$v['space_name']}</a>
                          <p class="fr price">参考价：{if $v['price']&&($v['price']/100)>100}￥{$v['price']/100}{$v['price_unit']|default:'/天'}{else}面议{/if}</p>
                      </div>
                      <div class="search_site_icon">
                          <a href="{$_home}map2?lat={$v['geo_lat']}&lng={$v['geo_lng']}" target="_blank"><div class="search_site"></div></a>
                          <a href="javascript:;" class="j_search_date" data-city="{$v['city']}" data-id="{$v['id']}" data-name="{$v['space_name']}"> <div class="search_date"></div></a>
                      </div>
                      <div class="clear"></div>
                  </div>
                  <div class="search_list_content">
                      {if $v['logo']}
                      <div class="search_list_img">
                          <a href="{$_home}site/{Func_Url::str_urlencode($v['space_name'],1)}" target="_blank">
                              <img src="{Page_Site_Global::displayMedia($v['logo'],275,195)}" />
                          </a>
                      </div>
                      {/if}
                      <div class="search_list_des">
                          <div class="{if $v['logo']}search_list_word{else}search_list_word1{/if}">
                              {mb_substr(str_replace('&nbsp;','', strip_tags($v['des'])),0,100,'utf-8')}…
                          </div>
                          <div class="search_list_web">
                              <span class="browse">浏览量：{$v['n_click']|default:$v['click']} </span>
                              <span class="indexs">指数：{round($v['order_index']/10)} </span>
                          </div>
                      </div>
                      <div class="clear"></div>
                  </div>
              </div>
              {/foreach}
            {else}
                <div class="search-no">
                    <div class="search-no-fig">找到相关场地0个</div>
                    <div class="search-no-title">抱歉，没有找到与“<span>{$_REQUEST['keyword']}</span>”相关的场地内容！</div>
                    <p class="search-no-suggest">建议您：</p>
                    <ul class="search-no-suggest-content">
                        <li>“<a href="{$_home}" class="search-no-back-home">返回首页</a>” 或“<a href="" class="search-no-refresh" onclick="window.location.reload();">刷新</a>”。</li>
                        <li>使用<a href="{Web_Global::createRentSpaceUrl()}" class="search-no-back-home">一键租场地</a>让场地顾问为你推荐场地</li>
                        <li>任何咨询、建议、意见请找<a href="mailto:service@yunspace.com.cn" class="search-no-mail"> service@yunspace.com.cn</a>。</li>
                        <li>检查输入的文字是否有无。</li>
                    </ul>
                </div>
            {/if}
            <div class="related_search">
                <div class="related_title">相关搜索</div>
                <ul class="related_content">
                    {foreach $page->getSearchList  as $k=>$v}
                    <li><a href="{$_home}spaces-tags/{Func_Url::str_urlencode($v['search_title'])}"> {$v['search_title']}</a></li>
                    {/foreach}
                    <div class="clear"></div>
                </ul>
            </div>
            {include file="Web_Static::inc/paging_space.tpl"}
        </div>
        <div class="search_content_right_no clearfix">
            <ul class="search-no-right">
                <li style="padding-top: 0px;">
                    <p class="search-no-right-img"><a href="{Web_Global::createRentSpaceUrl()}"><img src="css/search.v4.0/img/search-no-icon1.png"></a></p>
                    <p class="search-no-right-title"><a href="{Web_Global::createRentSpaceUrl()}">一键租场地</a></p>
                    <p class="search-no-right-word">
                        <a href="{Web_Global::createRentSpaceUrl()}">
                            办活动？找场地？找服务？快速提交场地需求，专业活动顾问为您服务，30分钟内为您匹配多家合适的场地及报价。还有更多配套服务供您选择，助您轻松办活动！
                        </a>
                    </p>
                </li>
                <li>
                    <p class="search-no-right-img"><a href="{$_home}site_join"><img src="css/search.v4.0/img/search-no-icon2.png"> </a></p>
                    <p class="search-no-right-title"><a href="{$_root}site_join">我有场地要出租</a></p>
                    <p class="search-no-right-word">
                        <a href="{$_home}site_join">
                            场地闲置？没有人气？管理麻烦？云·SPACE为您解决场地烦恼~大量活动需求推荐、快速提供报价、文创项目合作、场地档期管理，快来秀出您的场地吧！
                        </a>
                    </p>
                </li>
                <li style="border-bottom: none;">
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
<div class="cover none" id="cover"></div>
<div class="search-box none" id="search-code">
    <div class="search-box-close">
        <a href="javascript:;" id="search-box-close"><img src="img/v4.0/close.png" alt=""></a>
    </div>
    <div class="search-box-title">
        <span>查询档期和价格</span>
    </div>
    <input type="hidden" name="from_type" class="from_type" value="1" >
    <input type="hidden" name="space_id" class="space_id">
    <input type="hidden" name="space_name" class="space_name">
    <input type="hidden" name="demand_city" class="demand_city">
    <ul class="search-box-item">
        <li>
            <div class="search-box-label">你的称呼</div>
            <input class="search-box-input" name="username" >
            <div class="search-box-placeholder">请输入你的称呼</div>
        </li>
        <li>
            <div class="search-box-label">你的手机号码</div>
            <input class="search-box-input"  name="phone"  >
            <div class="search-box-placeholder">查询结果将以短信方式发送给你</div>
        </li>
        <li>
            <div class="search-box-label">活动档期</div>
            <div class="enquiry-con-input-con">
                <input name="date_start" type="text" placeholder="开始日期" readonly style="width:33%;float: left" yun="product.v2.0/enquiry.js::dateSelect@click" class="datePicker search-date-start"  data-validate="true" data-error="请选择开始的活动日期" >
                <span style="float: left;width:4%;line-height: 30px;text-align: center">——</span>
                <input name="date_end" type="text" placeholder="结束日期" readonly style="width:33%;float: left" yun="product.v2.0/enquiry.js::dateSelect@click" class="datePicker search-date-end"  data-validate="true" data-error="请选择结束的活动日期" >
                <div class="clear"></div>
                <div class="search-date-outside">
                    <div yun="data-picker/js/date-picker.js::initPlugin" class="date-picker" yun-input=".datePicker"  yun-autohide="true" yun-autohidenode=".search-date-outside"
                         yun-with-input="false"></div>
                </div>
            </div>
        </li>
        <li>
            <div class="search-box-label">更多咨询</div>
            <input class="search-box-input" name="other_demand">
            <div class="search-box-placeholder">填写你想要咨询的其他问题</div>
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

{include file="Web_Static::inc/public_space.tpl"}
    {include file="Web_Static::inc/html_footer.tpl"}
{static "core/yunspace.js"}
{static "search.v4.0/search.js"}
{static "search.v4.0/highlight.js"}
</body>
</html>