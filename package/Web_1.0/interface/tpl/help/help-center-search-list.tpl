<ul>
    <div class="nav-b"><h4>您正在搜索的是：</h4></div>
    {foreach $page->searchHelpCenter as $k=>$v}
        <li><a href="{$_route}info/{$v['id']}.html"> · {$v['title']}</a> </li>
        <input type="hidden" name="id" value="{$v['id']}">
        <input type="hidden" name="category" value="{$v['category']}">
    {/foreach}
</ul>


