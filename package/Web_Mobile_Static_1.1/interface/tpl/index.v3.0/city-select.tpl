<div class="city-select">
    <div class="city-select-header">
        <div class="city-select-center-left">
            <a href="javascript:;" class="close-city-select"><span class="ion-close"></span></a>
        </div>
        <div class="city-select-center-center">
            <p>当前城市-上海</p>
        </div>
    </div>
    <div class="city-select-body">
        <div class="city-selected">
            <p class="city-p">定位城市</p>
            <div class="city-show-list">
                <ul class="city-show-li">
                    <li><a href="javascript:;"  class="city-sel">{$city}</a></li>
                </ul>
            </div>
        </div>
        {*<div class="city-selected">*}
            {*<p class="city-p">最近访问</p>*}
            {*<div class="city-show-list">*}
                {*<ul class="city-show-li">*}
                    {*<li><a href="javascript:;">上海</a></li>*}
                    {*<li><a href="javascript:;">北京</a></li>*}
                    {*<li><a href="javascript:;">成都</a></li>*}
                {*</ul>*}
            {*</div>*}
        {*</div>*}
        <div class="city-selected">
            <p class="city-p">热门城市</p>
            <div class="city-show-list">
                <ul class="city-show-li">
                    {foreach $_REQUEST['cities'] as $v}
                        <li><a href="javascript:;" class="city-sel">{$v}</a></li>
                    {/foreach}
                </ul>
            </div>
        </div>
    </div>
</div>