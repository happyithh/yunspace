<div class="more">
    <button type="button" class="btn btn-success" id="question">查看更多问题类型</button>
    <div class="menu-a" style="display: none">
        <ul>

            <li class="pull-left"><a href="{$_root}help">最新问题</a> </li>
            <li  class="pull-right"><a href="{$_route}hot.html">热门问题</a> </li>
            <li class="pull-left"><a href="{$_route}guide.html">新手指南</a> </li>
            {$i=0}
            {foreach $page->readCategory as $k=>$v}
                <li class="pull-{if $i%2==0}right{else}left{/if}"><a href="{$_route}category/{$k}.html">{$v}</a></li>
                {$i=$i+1}
            {/foreach}
        </ul>
    </div>
</div>
<div class="pull-left nav1">
    {$search = $_REQUEST['search']}
    {$action = explode(".",Core::$urls['action'])}
    {$key = explode("/",$action[0])}
    <ul>
        {if empty($action[0]) && empty($search)}
            <div ><div class="nav-a"><li ><a href="{$_root}help/">最新问题</a> </li></div></div>
            {else}
        <div ><li ><a href="{$_root}help/">最新问题</a> </li></div>
        {/if}
        {if $key[0]=='hot'}
        <div><div class="nav-a"><li ><a href="{$_route}hot/">热门问题</a> </li></div></div>
            {else}
            <div><li ><a href="{$_route}hot/">热门问题</a> </li></div>
        {/if}
        {if $key[0]=='guide'}
            <div><div class="nav-a"><li><a href="{$_route}guide/">新手指南</a> </li></div></div>
            {else}
        <li><a href="{$_route}guide/">新手指南</a> </li>
        {/if}

        <div class="line1"></div>
        {foreach $page->readCategory as $k=>$v}
            {if $v==$page->helpCategory[0]['category']}<div class="nav-a">
                <li><a href="{$_route}category/{$k}.html">{$v}</a> </li>
                </div>
            {elseif $v==$page->helpDetail[0]['category']}
                <div class="nav-a">
                    <li><a href="{$_route}category/{$k}.html">{$v}</a> </li>
                </div>
                {else}
                <li><a href="{$_route}category/{$k}.html">{$v}</a> </li>
            {/if}
        {/foreach}
    </ul>
    <div class="clearfix"></div>
</div>
