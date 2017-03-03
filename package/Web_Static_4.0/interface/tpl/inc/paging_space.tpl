{if $page->getSpaceList['page']['dt'] !=0 && $page->getSpaceList['rows']}
    <div class="pagers">
        {if $page->getSpaceList['page']['dpll']}
            <a href="{$page->getSpaceList['page']['dup']}1" title="First">第一页</a>
            <a href="{$page->getSpaceList['page']['dup']}{$page->getSpaceList['page']['dp']-1}"
               title="Prev">上一页</a>
        {else}
            <a href="" class="prev first gray"><span>&laquo;&nbsp;</span>第一页</a>
            <a href="" class="prev gray">&lt;&nbsp;上一页</a>
        {/if}
        {for $i=$page->getSpaceList['page']['dpl'] to $page->getSpaceList['page']['dpr']}
            <a href="{$page->getSpaceList['page']['dup']}{$i}"{if $i==$page->getSpaceList['page']['dp']} class="active"{/if}>{$i}</a>
        {/for}

        {if $page->getSpaceList['page']['dprr']}
            <a href="{$page->getSpaceList['page']['dup']}{$page->getSpaceList['page']['dp']+1}"
               title="Next">下一页&nbsp;&gt;</a>
            <a href="{$page->getSpaceList['page']['dup']}{$page->getSpaceList['page']['dtp']}"
               title="Last">最后页&nbsp;&raquo;</a>
        {else}
            <a href="" class="next gray">下一页&nbsp;&gt;</a>
            <a href="" class="next last gray">最后页<span>&nbsp;&raquo;</span></a>
        {/if}
    </div>
{/if}