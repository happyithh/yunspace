<ul class="cases">
    {foreach $page->eventInfo['rows'] as $ek=>$ev}
        <li>
            <a href="/event_info/{$ev['event_id']}.html"><img src="{Page_Site_Global::displayMedia($ev['case_logo'],275,195,2)}"/></a>

            <p class="title">{$ev['case_name']|default:$ev['event_name']}</p>
            <div class="introduction">{mb_substr(strip_tags($ev['des']),0,60,'utf-8')}</div>
        </li>
    {/foreach}
</ul>