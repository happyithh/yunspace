{static "v4.0/consult_list.css"}
<ul class="consult-list">
    {*{var_dump($consultData['new_space'] )}*}
    {foreach $consultData['new_space'] as $k=>$v}
        <li>
            <a href="{$_home}article/{$v['id']}.html" class="consult-li">
                <div class="circle"></div>
                <div class="title"><span>{$v['title']}</span></div>
                <div class="time"><span>{Func_Time::format($v['create_time'])}</span></div>
            </a>
        </li>
    {/foreach}

</ul>
