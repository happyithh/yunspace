<style>
    .color-aa li a{
        color: #222;
    }
</style>
<form action="/space" method="get" class="space_form">
    <div class="public-drop">
        <div class="search_label color-aa">
            <span><code>找场地</code></span>
            <ul class="search_label_list public-select-lists none">
                <li>找场地</li>
                <li><a href="{$_home}database?action=is_submit&search_type=project_library">找资讯</a></li>
                <li><a href="{$_home}database?action=is_submit&search_type=company_library">找公司</a></li>
                <li><a href="{$_home}database?action=is_submit&search_type=paper_library">找文库</a></li>
            </ul>
        </div>
       
        <div class="city-more">
            <a href="javascript:;"
               class="result"><span>{if !empty($page->getKeyword['city'])}{$page->getKeyword['city']}{else}上海{/if}</span></a>
            <ul class="select city">
                <li><a class="city_a" href="{$_home}space/{$page->getUrls('city','')}">不限</a></li>
                {foreach Web_Global::$city_name as $k=>$v}
                    <li><a class="city_a" data-pre="{$_home}" data-lat="{$_REQUEST['lat']}" data-lng="{$_REQUEST['lng']}" data-keyword2="{$_REQUEST['keyword2']}" data-citys="{$_REQUEST['citys']}" data-url="{$_home}space/{$page->getUrls('city',$k)}" href="javascript:;">{$v}</a></li>
                {/foreach}
            </ul>
        </div>
        <div class="city-more active-more">
            <a href="javascript:;"
               class="result color1 res2"
               style="color: #222!important;width:80px">{if !empty($page->getKeyword['active_type'])}{$page->getKeyword['active_type']}{else}全部活动{/if}</a>
            <ul class="select active_type"  >
                <li><a href="{$_home}space/{$page->getUrls('active_type','')}">全部</a></li>
                {foreach $page->getActiveType as $k=>$v}
                    <li><a href="{$_home}space/{$page->getUrls('active_type',$v)}">{$v}</a></li>
                {/foreach}
            </ul>
        </div>
        <input type="hidden" name="search_type" id="search_type" value="site_library">
        {if !empty($page->getKeyword['city'])}
            <input type="hidden" name="city" value="{$page->getKeyword['city']}">
        {/if}
        <input type="hidden" name="active_type" value="{$page->getKeyword['active_type']}">
        {if !empty($page->getKeyword['size_range'])}
            <input type="hidden" name="size_range" value="{$page->getKeyword['size_range']}">
        {/if}
        {if !empty($page->getKeyword['people_range'])}
            <input type="hidden" name="people_range" value="{$page->getKeyword['people_range']}">
        {/if}
        {if !empty($page->getKeyword['price_range'])}
            <input type="hidden" name="price_range" value="{$page->getKeyword['price_range']}">
        {/if}
        {if !empty($page->getKeyword['category'])}
            <input type="hidden" name="category" value="{$page->getKeyword['category']}">
        {/if}
        {if !empty($page->getKeyword['is_outside'])}
            <input type="hidden" name="is_outside" value="{$page->getKeyword['is_outside']}">
        {/if}
        {if !empty($page->getKeyword['rank'])}
            <input type="hidden" name="rank" value="{$page->getKeyword['rank']}">
        {/if}
        {if !empty($page->getKeyword['admin_area'])}
            <input type="hidden" name="admin_area" value="{$page->getKeyword['admin_area']}">
        {/if}
        {if !empty($page->getKeyword['business_area'])}
            <input type="hidden" name="business_area" value="{$page->getKeyword['business_area']}">
        {/if}
        {if !empty($page->getKeyword['industry_type'])}
            <input type="hidden" name="industry_type" value="{$page->getKeyword['industry_type']}">
        {/if}
        <input type="hidden" name="lat" class="ajax_lat"/>
        <input type="hidden" name="lng" class="ajax_lng"/>
        <!--已选择的条件-->
        <div class="search_input_body">
            <input type="text" class="search_input" value="{$page->getKeyword['keyword2']}" id="search-input2"
                   name="keyword2" data-href="{$_home}"
                   placeholder="商圈/地标/机场/火车站/场地名" growing-track="true" >
            <input type="text" class="search_input none" id="search-input" name="keyword" placeholder="请输入您想搜索的关键词" growing-track="true">
        </div>
    </div>
    <button type="button"  id="search-space-btn" class="search_button clearfix"data-root="{$_root}" data-aciton="space">
        <span class="search_icon"></span>
        搜索一下
    </button>
    <span style="line-height:40px;color:#666;font-size:13px;margin:0 10px">或</span>
    <a href="{$_home}space_library?action=form" class="rend-space-a">
        <span>一键租场地</span>
    </a>
</form>
<script>
    $('.city_a').click(function () {
      var city = $(this).data('citys');
      var lat = $(this).data('lat');
      var lng = $(this).data('lng');
      var keyword2 = $(this).data('keyword2');
//      var keyword = window.location.search;
        url = 'http://'+window.location.host+$(this).data('url');
      var key1 = url.replace('lng='+lng+'&','');
      var key2 = key1.replace('lat='+lat,'');
      var key3 = key2.replace('?keyword2='+keyword2+'&','');
      var key4 = key3.replace(',?keyword2='+keyword2,'');
      window.location.href=key4;
    });
</script>



