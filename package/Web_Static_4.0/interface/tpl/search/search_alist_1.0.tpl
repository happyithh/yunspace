<!DOCTYPE html>
<html lang="en">
<head>
    {include file="Web_Static::inc/head_meta.tpl"}
    {static "search.v4.0/search.css"}
    {static "search.v4.0/box.css"}

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
        {if $page->getRaidersList['rows']}
            <p class="search_word_top">云·SPACE&nbsp;为您找到相关结果约{$page->getRaidersList['page']['dt']}条</p>
        {/if}
        <div class="search_content_left mt25">
            {if $page->getRaidersList['rows']}
          {foreach $page->getRaidersList['rows'] as $k=>$v}
              <div class="search_list">
                  <div class="search_list_title_outside">
                      <div class="search_list_title">
                          <a href="{$_home}article/{Func_NumEncode::e($v['id'])}.html" target="_blank"> {$v['title']}</a>
                      </div>
                      <div class="search_site_icon mt35">
                          {*<a href="javascript:;" class="j_search_date" data-id="{$v['id']}" data-name="{$v['title']}">*}
                              <div class="search_wt" style="background: none;">

                              </div>
                          {*</a>*}
                      </div>
                      <div class="clear"></div>
                  </div>
                  <div class="search_list_content">
                      {if $v['logo']}
                      <div class="search_list_img">
                          <a href="{$root}/article/{Func_NumEncode::e($v['id'])}.html" target="_blank">
                              <img src="{Page_Site_Global::displayMedia($v['logo'],275,195)}" />
                          </a>
                      </div>
                      {/if}
                      <div class="search_list_des">
                          <div class="{if $v['logo']}search_list_word{else}search_list_word1 no_logo_con{/if}">
                              {mb_substr($v['des'],0,100,'utf-8')}...
                          </div>
                          <div class="search_list_web  {if !$v['logo']}no_logo{/if}">
                              <span class="browse">浏览量：{$v['counter_view']} </span>
                              <span class="indexs">点赞量：{$v['counter_praise']}</span>
                          </div>
                      </div>
                      <div class="clear"></div>
                  </div>
              </div>
              {/foreach}
            {else}
                <div class="search-no">
                    <div class="search-no-fig">找到相关资讯0个</div>
                    <div class="search-no-title">抱歉，没有找到与“<span>{$_REQUEST['keyword']}</span>”相关的资讯内容！</div>
                    <p class="search-no-suggest">建议您：</p>
                    <ul class="search-no-suggest-content">
                        <li>“<a href="{$_home}" class="search-no-back-home">返回首页</a>” 或“<a href="" class="search-no-refresh" onclick="window.location.reload();">刷新</a>”。</li>
                        <li>任何咨询、建议、意见请找<a href="mailto:service@yunspace.com.cn" class="search-no-mail"> service@yunspace.com.cn</a>。</li>
                        <li>检查输入的文字是否有无。</li>
                    </ul>
                </div>
            {/if}
            <div class="related_search">
                <div class="related_title">相关搜索</div>
                <ul class="related_content">
                    {foreach $page->getSearchList  as $k=>$v}
                        <li><a href="{$_home}article-keyword/{urlencode($v['search_title'])}"> {$v['search_title']}</a></li>
                    {/foreach}
                    <div class="clear"></div>
                </ul>
            </div>
          {include file="Web_Static::inc/paging_raider.tpl"}
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
                    <p class="search-no-right-img"><a href="{$_home}article/3124147.html"><img src="css/search.v4.0/img/search-no-icon2.png"> </a></p>
                    <p class="search-no-right-title"><a href="{$_root}site_join">我有场地要出租</a></p>
                    <p class="search-no-right-word">
                        <a href="{$_home}article/3124147.html">
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
        <span>合作咨询</span>
    </div>
    <input type="hidden" name="from_type" class="from_type" value="2" >
    <input type="hidden" name="space_id" class="space_id">
    <input type="hidden" name="space_name" class="space_name">
    <ul class="search-box-item">
        <li>
            <div class="search-box-label">你的称呼</div>
            <input class="search-box-input" name="username" >
            <div class="search-box-placeholder">请输入你的真实姓名</div>
        </li>
        <li>
            <div class="search-box-label">你的手机号码</div>
            <input class="search-box-input"  name="phone"  >
            <div class="search-box-placeholder">查询结果将以短信方式发送给你</div>
        </li>
        <li class="search_co_input">
            <div class="search-box-label">咨询内容</div>
            <input class="search-box-input" name="other_demand">
            <div class="search-box-placeholder">填写你想要咨询的问题</div>
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
            <span>举起手机，扫一扫关注</span><br>
            云·space微信公众号<br>
            随时随地获取方案
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