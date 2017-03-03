<div class="slide-content fr">
    <div class="small-title">优质空间</div>
    <div class="slide-img">
        <ul>
            {foreach $page->qualitySpace as $k=>$v}
            <li>
                <a href="{$_home}site/{Func_Url::str_urlencode($v['space_name'])}">
                    <img src="{Page_Site_Global::displayMedia($v['logo'],278,168)}" alt="">

                    <p>{$v['space_name']}</p>
                </a>
            </li>
            {/foreach}
        </ul>
    </div>
    <div class="small-title">最新资讯</div>
    <div class="new-news">
        <ul>
            {foreach $page->newInformation as $k=>$v}
            <li><a href="{$_home}article/{Func_NumEncode::e($v['id'])}.html">{$v['title']}</a></li>
            {/foreach}
        </ul>
    </div>
</div>