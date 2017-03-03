{static "v3.0/nav.css"}
<div class="header-body-keys" yun="inc.v4.0/m_nav.js::init">
    <ul class="header-body-keys-list clearfix">
        <li>
            <a href="{$_home}site/{Func_Url::str_urlencode($page->spaceName)}-最新" {if $page->baikeAction=='最新'} class="header-body-key-active"{/if}>最新</a>
        </li>
        <li class="keys-line">
            <div></div>
        </li>
        <li>
            <a href="{$_home}site/{Func_Url::str_urlencode($page->spaceName)}-精华" {if $page->baikeAction=='精华'} class="header-body-key-active"{/if}>精华</a>
        </li>
        {if $page->isSpace}
            <li class="keys-line">
                <div></div>
            </li>
            <li>
                <a href="{$_home}site/{Func_Url::str_urlencode($page->spaceName)}-百科" {if $page->baikeAction=='百科' && $page->item_id==false} class="header-body-key-active"{/if}>百科词条</a>
            <li>
            {if count($page->spaceItem)>0}
                <li class="keys-line">
                    <div></div>
                </li>
                <li>
                    <a href="{$_home}site/{Func_Url::str_urlencode($page->spaceName,1)}-{Func_NumEncode::e($page->spaceItem[0]['id'])}#collection" {if $page->baikeAction=='百科' && $page->item_id>0} class="header-body-key-active"{/if}>子空间</a>
                </li>
            {/if}
        {/if}
    </ul>
</div>
<div class="header-body-keys nav-fixed">
    <ul class="header-body-keys-list clearfix header-body-keys-list-active">
        <li class="li-active {if $page->baikeAction=='最新'} bg-active{/if} {if !$page->isSpace}li-space{/if}">
            <a href="{$_home}site/{Func_Url::str_urlencode($page->spaceName)}-最新" class="nav-link-fix">最新</a>
        </li>
        <li class="li-active  {if $page->baikeAction=='精华'}bg-active{/if} {if !$page->isSpace}li-space{/if}">
            <a href="{$_home}site/{Func_Url::str_urlencode($page->spaceName)}-精华" class="nav-link-fix ">精华</a>
        </li>
        {if $page->isSpace}
            <li class="li-active {if $page->baikeAction=='百科' && $page->item_id==false}  bg-active{/if}">
                <a href="{$_home}site/{Func_Url::str_urlencode($page->spaceName)}-百科" class="nav-link-fix">百科词条</a>
            </li>
            {if count($page->spaceItem)>0}
                <li class="li-active {if $page->baikeAction=='百科' && $page->item_id>0} bg-active{/if}">
                    <a href="{$_home}site/{Func_Url::str_urlencode($page->spaceName,1)}-{Func_NumEncode::e($page->spaceItem[0]['id'])}#collection"
                       class="nav-link-fix">子空间</a>
                </li>
            {/if}
        {/if}
    </ul>
</div>