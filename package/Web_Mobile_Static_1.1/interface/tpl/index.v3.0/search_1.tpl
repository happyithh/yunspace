<div class="search-bar">

    <div class="city-select-header">
        <div class="city-select-center-left">
            <a href="javascript:;" class="close-city-select  cancel-search"><span class="ion-close"></span></a>
        </div>
        <form action="{$_home}space?" method="post">
            <input type="hidden" name="searchtype" value="{Core::$urls['action']}">
            <div class="search-header-left">
               <input type="text" class="search-in" name="keyword" placeholder="搜索空间/服务/供应商名称/地址等">
           </div>
            <div class="search-header-right">
                <button class="search-click">搜索</button>
            </div>
        </form>
    </div>
    <div class="city-select-body">
        <div class="city-selected">
            <p class="city-p">最新搜索</p>
            <div class="search-show-list">
                <ul class="search-show-li">
                    <li class="hide"><a href="">上海</a></li>
                    {foreach $list as $k=>$v}
                        <li><a href="../{Core::$urls['action']|default:"m/space"}/?keyword={$v['search_title']}">{$v['search_title']}</a></li>
                    {/foreach}
                </ul>
            </div>
        </div>

    </div>
</div>