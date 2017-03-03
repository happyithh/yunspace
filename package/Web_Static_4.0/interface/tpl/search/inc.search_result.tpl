<form action="/database" method="get">
    <div class="search_label">
        <span>
            {if $nav=='site'}找场地
            {elseif $nav=='company'}
                找公司
            {elseif $nav=='paper'}
                找文库
            {elseif $nav=='article'}
                找资讯
            {/if}
        </span>
        {*<div class="search_input_value">收搜场地资料/文创</div>*}
        <ul class="search_label_list">
            <li><a style="color: #646878;" href="{$_home}space">找场地</a></li>
            <li>找资讯</li>
            <li>找公司</li>
            <li>找文库</li>
        </ul>
    </div>
    <input type="hidden" name="action" value="is_submit" id="action"/>
    <input type="hidden" name="search_type" value="{if $nav=='site'}site_library{elseif $nav=='company'}company_library{elseif $nav=='paper'}paper_library{elseif $nav=='article'}project_library{/if}" id="search_type">
    {if isset($page->request['filter'])&&!empty($page->request['filter'])}
    {foreach $page->request['filter'] as $k=>$v}
    <input type="hidden" name="filter[{$k}]" value="{$v}" id="">
    {/foreach}
    {/if}
    {if isset($page->request['size_range'])&&!empty($page->request['size_range'])}
    <input type="hidden" name="size_range" value="{$page->request['size_range']}">
    {/if}
    {if isset($page->request['category_id'])&&!empty($page->request['category_id'])}
    <input type="hidden" name="category_id" value="{$page->request['category_id']}">
    {/if}
    {if isset($page->request['city_key'])&&!empty($page->request['city_key'])}
    <input type="hidden" name="city_key" value="{$page->request['city_key']}">
    {/if}
    <!--已选择的条件-->
    <div class="search_input_body">
        <input class="search_input" name="keyword" value="{$_REQUEST['keyword']}" autocomplete="off" />
        <li class="clone_search none"><a href=""></a></li>
        <ul class="search_input_pre">
        </ul>
    </div>

    <button class="search_button clearfix">
        <span class="search_icon"></span>
        搜索一下
    </button>
</form>