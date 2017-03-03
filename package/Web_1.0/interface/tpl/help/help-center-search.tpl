<form class="form-horizontal" role="form" action="{$_root}help" method="get">
    <input type="hidden" name="is_search" value="1">
    <div class="hc1 col-md-12">
        <div class="ha" >
            <div class="pull-left hb"><input type="text" name="keyword" placeholder="请输入搜索内容" value="{($_REQUEST['keyword'])}"></div>
            <div class="pull-left hc "><button class="btn btn-primary">搜索</button></div>
            <div class="pull-left hot1">热门搜索：
                {foreach $page->readHotSearch as $k=>$v}
                    <a href="{$_route}?is_search=1&keyword={$v}">{$v}</a>

                {/foreach}
            </div>
            <div class="clearfix"></div>
        </div>
    </div>
</form>