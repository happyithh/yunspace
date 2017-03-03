
    <div class="news-content news-noresult">
        <div class="news-noresult-cont">
            <p class="prompt"><i></i><span>{if  $page->baikeAction=="讨论组"}暂无相关评论{else}暂无相关内容{/if}</span></p>
        </div>
        {if $page->baikeAction!="讨论组"}
        <div class="news-noresult-recommend">
            <div class="recommend-title clearfix">
                <i class="icon-rmd"></i><span>推荐阅读</span>
            </div>
            <ul class="recommend-list clearfix">
                {foreach $page->recommendArticle as $k=>$v}
                <li>
                    <a class="img" href="{$_home}article/{Func_NumEncode::e($v['id'])}.html"><img src="{Page_Site_Global::displayMedia($v['logo'],185,120)}"></a>
                    <a class="txt" href="">{$v['title']}</a>
                </li>
                {/foreach}
            </ul>
        </div>
        {/if}
    </div>
