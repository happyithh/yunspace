<ul class="cases">
    {foreach $case as $k=>$v}
        <li>
            <a href="" class="case-lists">
                <div class="case-img">
                    <img src="{$v['media']['path']}" alt=""/>
                </div>
                <div class="case-text">
                    <p class="case-p1">{$v['case_name']}</p>

                    <p class="case-p2">
                        {$v['des']}
                    </p>
                </div>
            </a>

            <div class="clear"></div>
        </li>
    {/foreach}
</ul>