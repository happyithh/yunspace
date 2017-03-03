{static "v4.0/pop-list.css"}
<ul class="consult-list">
    {foreach $consultData['recommend'] as $k=>$v}
        <li>
            <h3></h3><a href="{$_home}article/{$v['id']}.html" class="consult-li">
                <div class="circle"></div>
                <div class="title"><span>{$v['space_title']}</span></div>
                <div class="time"><span>{Func_Time::format($v['create_time'])}</span></div>
            </a></h3>
        </li>
    {/foreach}
</ul>