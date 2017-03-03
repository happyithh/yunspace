{if $page->getBaikeList['page']['dt'] !=0 && $page->getBaikeList['rows']}
    <div class="pagers">
        {if $page->getBaikeList['page']['dpll']}
            <a href="{$page->getBaikeList['page']['dup']}1" title="First">第一页</a>
            <a href="{$page->getBaikeList['page']['dup']}{$page->getBaikeList['page']['dp']-1}"
               title="Prev">上一页</a>
        {else}
            <a href="" class="prev first gray"><span>&laquo;&nbsp;</span>第一页</a>
            <a href="" class="prev gray">&lt;&nbsp;上一页</a>
        {/if}
        {for $i=$page->getBaikeList['page']['dpl'] to $page->getBaikeList['page']['dpr']}
            <a href="{$page->getBaikeList['page']['dup']}{$i}"{if $i==$page->getBaikeList['page']['dp']} class="active"{/if}>{$i}</a>
        {/for}

        {if $page->getBaikeList['page']['dprr']}
            <a href="{$page->getBaikeList['page']['dup']}{$page->getBaikeList['page']['dp']+1}"
               title="Next">下一页&nbsp;&gt;</a>
            <a href="{$page->getBaikeList['page']['dup']}{$page->getBaikeList['page']['dtp']}"
               title="Last">最后页&nbsp;&raquo;</a>
        {else}
            <a href="" class="next gray">下一页&nbsp;&gt;</a>
            <a href="" class="next last gray">最后页<span>&nbsp;&raquo;</span></a>
        {/if}
    </div>
{/if}