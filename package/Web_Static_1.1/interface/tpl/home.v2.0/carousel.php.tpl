{static "home.v2.0/slide.css"}
{static "js/bootstrap.min.js"}
<div id="carousel-example-generic" class="carousel slide" data-ride="carousel">
    <!-- Indicators -->
    <ol class="carousel-indicators">
        {if $banner}
            {foreach $banner as $k  =>$val}
                <li data-target="#carousel-example-generic" data-slide-to="{$k}"  {if $k==0} class="active" {/if}></li>
            {/foreach}
        {else}
            <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
        {/if}
    </ol>
    <!-- Wrapper for slides -->
    <div class="carousel-inner" role="listbox">
        {if $banner }
            {foreach $banner as $k=>$val}
                <div class="item {if $k==0} active {/if}">
                    <a href="{$val['url']}">
                        <img src="{$val['path']}" title="{$val['title']}" alt="{$val['title']}">
                    </a>
                </div>
            {/foreach}
        {else}
            <div class="item active">
                <a href="javascript:void(0)">
                    <img src="img/home.v2.0/img_main_5.jpg" title="云.space，活动场地专家" alt="云.space，活动场地专家">
                </a>
            </div>
        {/if}
    </div>
</div>