<ul class="set_intro">
    <li>
        <p class="title">套餐简介</p>

        <div class="text-row">
            <div class="left-text">
                {$page->info['des']}
            </div>
        </div>
    </li>
    {foreach $page->space_info['tags'] as $vk=>$vv}
        <li>
            <p class="title"> {$vk}</p>

            <div class="text-row">

                {foreach $vv as $vvk=>$vvv}
                    {if $page->space_info['attr_new'][$vvk]}
                        <div class="left-text">
                            <c>{$vvv['tags_name']} :
                                {$page->space_info['attr_new'][$vvk]}
                            </c>
                        </div>
                    {/if}
                {/foreach}

            </div>
            <div class="clearfix"></div>
        </li>
    {/foreach}
    <li>
        <p class="title">配套服务</p>

        <div class="text-row">
            <div class="left-text">
                {$page->info['detail_des']}
            </div>
        </div>
    </li>

</ul>