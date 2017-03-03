{foreach $winchance_list as $k => $v}
    <li>
        <a href="{$_home}site/{$v['active_name']}-百科">
            <div class="banner4-img">
                <img src="{$v['cover_logo']}" alt="{$v['active_name']}">
            </div>
            <div class="bg-cover">
                <p class="banner4-title">{$v['active_name']}</p>
                <p class="banner4-des">
                    {$v['ip_des']}
                </p>
                <div class="bn-data">
                    <p><span>{$v['click']}</span></p>
                    <p><span>{$v['is_love']+$v['is_go']}</span></p>
                </div>
            </div>
        </a>
    </li>
{/foreach}