<!DOCTYPE html>
<html lang="en">
<head>
    {include file="Web_Static::inc/head_meta.tpl"}
    {static "search.v4.0/search.css"}
    {static "search.v4.0/search.js"}
</head>
<body>
{include file="Web_Static::inc/header_1.tpl"}

<div class="search_main">
    <div class="search_page_icon_outside">
        <ul class="search_page_icon">
            <a href="{$_home}database/site" class="search_link"><li class="{$_type_array['class'][0]|default:'search_page_site_active'}">场地库</li></a>
            <a href="" class="search_link" ><li class="{$_type_array['class'][1]|default:'search_page_project'}">项目库</li></a>
            <a href="{$_home}database/company" class="search_link"><li class="{$_type_array['class'][2]|default:'search_page_company'}">公司库</li></a>
            <a href="{$_home}article_list/index.html" class="search_link"><li class="{$_type_array['class'][3]|default:'search_page_paper'}">文库</li></a>
            <div class="clear"></div>
        </ul>
    </div>
    <div class="search_page">
        <form action="?" method="get">
            <div class="search_page_label">
                {$_type_array['search_page_label']|default:'场地库'}
            </div>
            <input type="hidden" name="action" value="is_submit"/>
            <input type="hidden" class="search_type" name="search_type" value="{$_type_array['search_type']|default:'site_library'}">
            <input class="search_page_input" name="keyword" value="" placeholder="{$_type_array['search_page_input_value']|default:'搜索场地资料 \ 文创'}"/>
            <!--<div class="search_page_input_value">{$_type_array['search_page_input_value']|default:'搜索场地资料 \ 文创'}</div>-->
            <button class="search_page_btn clearfix">
                 <div class="search_page_btn_icon">

                 </div>
                <div class="search_page_btn_word clearfix">
                    搜索一下
                </div>
            </button>
            <a href="/map2" class="search_page_map-link">
                场地地图
            </a>
        </form>
    </div>

    <div class="search_page_shao_outside">
    <ul class="search_page_shao">

            <li class="search_page_phone_n">
                <img src="img/search_code_phone.png" />
              <p class="search_page_shao_title1">移动版</p>

            </li>


          <li class="search_page_phone_n">
              <img src="img/qrcode_space.png" />
            <p class="search_page_shao_title1">微信服务号</p>

          </li>

        <a href="{Web_Global::createRentSpaceUrl()}">
          <li class="search_page_rent">
            <p class="search_page_shao_title1">一键租场地</p>

          </li>
        </a>
        <div class="clear"></div>
    </ul>
        <div class="search_page_bottom">Copyright©2015 云·SPACE 沪ICP备12039278号-2</div>
    </div>

</div>
{*{static "/search.v4.0/search.js"}*}
{include file="Web_Static::inc/public_space.tpl"}
{static "core/yunspace.js"}
</body>
</html>