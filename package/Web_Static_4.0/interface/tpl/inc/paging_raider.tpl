{if $page->getRaidersList['page']['dt'] !=0 && $page->getRaidersList['rows']}
    <div class="pagers">
        {if $page->getRaidersList['page']['dpll']}
            <a href="{$page->getRaidersList['page']['dup']}1" title="First">第一页</a>
            <a href="{$page->getRaidersList['page']['dup']}{$page->getRaidersList['page']['dp']-1}"
               title="Prev">上一页</a>
        {else}
            <a href="" class="prev first gray"><span>&laquo;&nbsp;</span>第一页</a>
            <a href="" class="prev gray">&lt;&nbsp;上一页</a>
        {/if}
        {for $i=$page->getRaidersList['page']['dpl'] to $page->getRaidersList['page']['dpr']}
            <a href="{$page->getRaidersList['page']['dup']}{$i}"{if $i==$page->getRaidersList['page']['dp']} class="active"{/if}>{$i}</a>
        {/for}

        {if $page->getRaidersList['page']['dprr']}
            <a href="{$page->getRaidersList['page']['dup']}{$page->getRaidersList['page']['dp']+1}"
               title="Next">下一页&nbsp;&gt;</a>
            <a href="{$page->getRaidersList['page']['dup']}{$page->getRaidersList['page']['dtp']}"
               title="Last">最后页&nbsp;&raquo;</a>
        {else}
            <a href="" class="next gray">下一页&nbsp;&gt;</a>
            <a href="" class="next last gray">最后页<span>&nbsp;&raquo;</span></a>
        {/if}
    </div>
{/if}