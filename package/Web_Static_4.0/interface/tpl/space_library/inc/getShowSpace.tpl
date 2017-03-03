
    <ul class="list clearfix bg-color1">
        <li></li>
        {foreach $page->getShowSpace as $k=>$v}
            <li>
                <a target="_blank" href="/site/{Func_Url::str_urlencode($v['space_name'],1)}">
                    <div class="img-block">
                        <img src="{Page_Site_Global::displayMedia($v['logo'],288,288)}" alt="">
                    </div>
                    <p class="space-name"><span>{$v['space_name']}</span></p>
                    <p class="space-des">
                                <span>
                                  {if mb_strlen($v['des'])>150}
                                      {mb_substr(strip_tags($v['des']),0,150,"utf8")}...
                                  {else}
                                      {$v['des']}
                                  {/if}
                                </span>
                    </p>
                    <div class="cov cov1"></div>
                </a>
            </li>
        {/foreach}
    </ul>
