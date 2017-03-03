<div class="h-40"></div>
<div class="dcont-wrap-bg">
    <div class="dcont-wrap-bg-opty"></div>
    <div class="select-state clearfix">
        <div class="select">
            {if {$_REQUEST['search']['year']}}
                <p class="js-search-title">{$_REQUEST['search']['year']}年{$_REQUEST['search']['month']}月
                    |
                    {if $_REQUEST['search']['reported']=='reported' || !$_REQUEST['search']['reported']}
                        全部({$reported_count['sum']})
                    {/if}
                    {if $_REQUEST['search']['reported']=='reported-A'}
                        有意向({$reported_count['A']})
                    {/if}
                    {if $_REQUEST['search']['reported']=='reported-B'}
                        待确认({$reported_count['B']})
                    {/if}
                    {if $_REQUEST['search']['reported']=='reported-C'}
                        无意向({$reported_count['C']})
                    {/if}
                </p>
            {else}
                <p class="js-search-title">全部</p>
            {/if}
            {*{var_dump($_REQUEST['search']['reported'])}*}
            {*<p>2015年1月<span>|</span>全部10</p>*}

            <span class="txt-screen">筛选</span>
        </div>
        <!--select-end-->
    </div>
    <form action="?" method="get">
        <input type="hidden" name="status" value="{$_REQUEST['status']}"/>
        <input type="hidden" class="js-year-input" name="search[year]" value="{$_REQUEST['search']['year']}"/>
        <input type="hidden" class="js-month-input" name="search[month]" value="{$_REQUEST['search']['month']}"/>


        <div class="dcont-wrap">
            <div class="demand-select-cont">
                <div class="comn">
                    <h3>年份</h3>
                    <ul class="comn-ul comn-ul-year clearfix js-year">
                        {foreach $allTime as $k=>$val}
                            <li {if $k==$_REQUEST['search']['year']} class="current" {/if}> {$k}</li>
                        {/foreach}
                        {*<li class="current">2015年</li>*}
                        {*<li>2016年</li>*}
                    </ul>
                </div>
                <div class="comn">
                    <h3>月份</h3>
                    <ul class="comn-ul comn-ul-month clearfix js-month">
                        {foreach $allTime as $k =>$val}
                            <div id="month{$k}" {if $k!=$_REQUEST['search']['year']} style="display: none;overflow: auto"{/if}>
                                {foreach $val as $kk=>$vv}
                                    <li {if $vv==$_REQUEST['search']['month']} class="current" {/if}>{$vv}</li>
                                {/foreach}
                            </div>
                        {/foreach}
                    </ul>
                </div>
                {if  is_numeric(mb_strpos($_REQUEST['status'],'reported'))}
                    <div class="comn">
                        <h3>状态</h3>
                        {*<ul class="comn-ul comn-ul-state clearfix js-reported">*}
                        {*<li value="reported" class="current">全部</li>*}
                        {*<li value="reported-A">有意向</li>*}
                        {*<li value="reported-B">待确认</li>*}

                        {*</ul>*}
                        <ul class="comn-ul comn-ul-state clearfix js-reported">
                            <li value="reported" {if $_REQUEST['search']['reported']=='reported' || !$_REQUEST['search']['reported']} class="current" {/if}>
                                全部({$reported_count['sum']})
                            </li>
                            <li value="reported-A"
                                    {if $_REQUEST['search']['reported']=='reported-A'} class="current" {/if} >
                                有意向({$reported_count['A']})
                            </li>
                            <li value="reported-B"
                                    {if $_REQUEST['search']['reported']=='reported-B'} class="current"{/if}>
                                待确认({$reported_count['B']})
                            </li>

                            <li value="reported-C"
                                    {if $_REQUEST['search']['reported']=='reported-C'} class="current"{/if}>
                                无意向({$reported_count['C']})
                            </li>

                        </ul>
                        <input type="hidden" class="js-reported-input" name="search[reported]"
                               value="{$_REQUEST['search']['reported']}"/>
                    </div>
                {/if}

            </div>

            <div class="demand-select-btn clearfix">
                <a class="fl btn btn-reset" href="javascript:window.location.reload();">重置</a>
                <button class="fr btn btn-confirm js-submit" type="submit">确定</button>
            </div>
        </div>
    </form>
</div>
<script>
    $(function () {
//        if (localStorage.searchTitle) {
//            $(".js-search-title").text(localStorage.searchTitle);
//        }
        $(".js-year li").click(function () {
            var _val = $(this).text();
            $(this).addClass('current').siblings('li').removeClass('current');
            $(".js-month #month" + _val).show().siblings().hide();
            $(".js-year-input").val(_val);
        });
        $(".js-month li").click(function () {
            var _val = $(this).text();
            $(this).addClass('current').siblings().removeClass('current');
            $(".js-month-input").val(_val);
        })
        $(".js-reported li").click(function () {
            var _val = $(this).attr('value');
            $(this).addClass('current').siblings().removeClass('current');
            $(".js-reported-input").val(_val);
        });

    });
</script>