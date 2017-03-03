<link rel="stylesheet" type="text/css" href="css/filter.css">
<div class=" wrap clearfix s_lt">
    <!--tab切换开始 -->
    {************配套服务*******}
    <div id="nav_scr" class="nav_scr">
        {if $nav_index == 2}
            <ul class="service-first">
                {foreach $page->categoryTree[0] as $k=>$v}
                    {if $v}
                        <li>
                            <a {if $page->topCategoryId['topCategoryId']==$k} class="service-first-active"{/if}
                                    href="{$_root}{$___urls['route']}{$_COOKIE['city_key']}-{htmlspecialchars($k)}">{htmlspecialchars($v)}</a>
                        </li>
                    {/if}
                {/foreach}
            </ul>
        {/if}
        <ul id="wapNexNav" class="wapNexNav clearfix">
            {foreach $page->categoryTree[$page->topCategoryId['topCategoryId']] as $k=>$v}
                {if $v}
                    <li{if $page->categoryId==$k} class="active"{/if}>
                        <a href="#">{htmlspecialchars($v)}</a></li>
                {/if}
            {/foreach}
        </ul>
        {if $page->categoryId}
            <ul class="nav_sl clearfix con guide">
                <li {if $page->categoryId==$page->topCategoryId['topCategoryId']} class="hover" {/if}>
                    <a href="{$_root}{$___urls['route']}" title="全部">全部</a>
                </li>
                {foreach $page->categoryTree[$page->topCategoryId['topCategoryId']] as $k=>$v}
                    {if $v}
                        <li{if $page->categoryId==$k} class="hover"{/if}>
                            <a href="{$_root}{$___urls['route']}{$_COOKIE['city_key']}-{htmlspecialchars($k)}" title="{$v}">{$v}</a>
                        </li>
                    {/if}
                {/foreach}
            </ul>
        {/if}
        {*{if $page->categoryId}*}
        {*<ul class="nav_sl clearfix con guide" id="nav_sl">*}
        {*<li {if $page->categoryId==$page->topCategoryId['topCategoryId']} class="hover" {/if}>*}
        {*<a href="{$_root}{$___urls['route']}" title="全部">全部</a>*}
        {*</li>*}
        {*{$i=0}*}
        {*{foreach $page->categoryTree[$page->topCategoryId['topCategoryId']] as $k=>$v}*}
        {*{if $v}*}
        {*{if $i==7}*}
        {*<li class="click"><a href="#" onclick="$('#nav_sl').toggleClass('nav_sll');">查看更多&raquo;</a></li>*}{*此li放在第8个之后*}
        {*{/if}*}
        {*<li{if $page->categoryId==$k} class="hover"{/if} id="aaa{$i++}">*}
        {*<a href="{$_root}{$___urls['route']}{$k}" title="{$v}">{$v}</a>*}
        {*</li>*}
        {*{/if}*}
        {*{/foreach}*}
        {*</ul>*}
        {*{/if}*}
        {*<script>*}
        {*window.onload = SeeMore();*}
        {*function SeeMore() {*}
        {*var position = $('#nav_sl .hover').index();*}
        {*if (position > 8) {*}
        {*$('#nav_sl').addClass('nav_sll');*}
        {*} else {*}
        {*$('#nav_sl').removeClass('nav_sll');*}
        {*}*}
        {*}*}

        {*</script>*}
        <span class="nar"><i class="fa fa-angle-right"></i></span>
    </div>

    <!--筛选区域开始 -->
    <div class="table-responsive">
        {if !$page->filterAttr||empty($page->filterAttr)}
            <div class="filter_outside" style="padding: 0"></div>
        {else}
            <div class="filter_outside">
                <div class="filter_selected hidden">
                    <div class="filter_title_selected">
                        已选条件：
                    </div>
                    <div class="filter_item">
                        <ul class="filter_item_selected">
                        </ul>
                    </div>
                    <a href="#" class="clearup" style="color: #34495e;">清空所有条件</a>
                </div>
                {foreach $page->filterAttr as $k=>$v}
                    {if $v['val']&&count($v['val'])>0}
                    <div class="filter_unselected" style="border-bottom: none;">
                        <div class="filter_title">
                            {if tplDisplayShortAttrName($v['tags'])}
                                {tplDisplayShortAttrName($v['tags'])}:
                            {/if}
                        </div>
                        <div class="filter_unselected_item">
                            <ul class="dropdrown">
                                {foreach $v['val'] as $vk=>$vv}
                                    {if $vv}
                                        <li>
                                            <a href="{$_route}{Page_Site_Global::concatUrlTags($k, $vk)}#list_content" {if $page->request['filter'][$k]==$vk} style="color:#00c3c3;" {/if}>
                                            {*<a href="?{$page->filterString}filter[{urlencode($k)}]={urlencode($vk)}#list_content"{if $page->request['filter'][$k]==$vk} style="color:#00c3c3;" {/if}>*}
                                                {htmlspecialchars($vk)}
                                            </a>
                                        </li>
                                    {/if}
                                {/foreach}
                            </ul>
                        </div>
                        <div class="clear"></div>
                    </div>
                    {/if}
                {/foreach}
                {if $nav_index==1}
                    <div class="filter_unselected">
                        <div class="filter_title">
                            场地面积：
                        </div>
                        <div class="filter_unselected_item">
                            <ul class="dropdrown">
                                {foreach $page->size_range as $sizek=>$sizev}
                                    <li>
                                        {*<a href="?{$page->filterString}size_range={$sizek}#list_content">{$sizev}</a>*}
                                        <a href="?size_range={htmlspecialchars($sizek)}#list_content" {if $page->request_filter['size_range']==$sizek} style="color:#00c3c3;" {/if}>{htmlspecialchars($sizev)}</a>
                                    </li>
                                {/foreach}
                            </ul>
                        </div>
                        <div class="clear"></div>
                    </div>
                {/if}
            </div>
        {/if}
        <div class="search_outside">
            <form class="form-inline" action="{$_root}{$___urls['route']}?{$page->filterString}" method="get">
                <div class="form-group form_search">
                    <label class="sr-only" for="search">...</label>
                    <div class="input-group input_search">
                        <input type="text" class="form-control input-lg is" placeholder="搜索空间/服务/供应商名称等" name="keyword"
                               value="{htmlspecialchars($page->request_filter['keyword'])}">
                    <span class="input-group-btn">
                        <button type="submit" class="input-lg search_button">
                            <i class="fa fa-search"></i>&nbsp;搜索
                        </button>
                    </span>
                    </div>
                </div>
            </form>
        </div>
        <!--展开更多开始 -->
    </div>
    <div class="mose_ke mose_ke_border" onclick="OpenConditions()">
        展开更多筛选条件
    </div>
    <script>
        function shaixuan() {
            var selectBut = '';
            {foreach $page->request as $key=>$val}
            {if $key=='filter'}
            {foreach $val as $k=>$v}
            {if $k}
            {*selectBut += ' <li>{$v}<button type="button" class="close close_button" data-dismiss="alert" aria-label="Close">' +*}
            {*'</button><a href="?{$page->filterString}&filter[{$k}]=all">&times;</a></li>';*}
            selectBut += ' <li>{$v}<button type="button" class="close close_button" data-dismiss="alert" aria-label="Close">' +
            '</button><a href="{$_route}{Page_Site_Global::concatUrlTags($k)}">&times;</a></li>';
            {/if}
            {/foreach}
            {/if}
            {if $key=='size_range'}
            {if $val}
            {*selectBut += ' <li>{$page->size_range[$val]}<button type="button" class="close close_button" data-dismiss="alert" aria-label="Close">' +*}
            {*'</button><a href="?{$page->filterString}&size_range=0">&times;</a></li>';*}
            selectBut += ' <li>{$page->size_range[$val]}<button type="button" class="close close_button" data-dismiss="alert" aria-label="Close">' +
            '</button><a href="?&size_range=0">&times;</a></li>';
            {/if}
            {/if}
            {/foreach}
            if (selectBut) {
                $('.filter_selected').removeClass('hidden');
            }
            $('.filter_item_selected').html(selectBut);
        }
        shaixuan();
        //展开筛选条件
        function OpenConditions() {
            $('.table-responsive').toggle();
        }
    </script>
</div>
