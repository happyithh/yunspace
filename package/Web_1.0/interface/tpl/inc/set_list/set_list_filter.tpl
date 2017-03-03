<div class=" wrap clearfix s_lt">

    <div id="nav_scr" class="nav_scr">
        <ul class="nav_sl clearfix con guide">
            <li {if $page->categoryId==0} class="hover" {/if}>
                <a href="{$_root}{$___urls['route']}" title="全部">全部</a>
            </li>
            {foreach $page->allCategory as $key=>$val}
                <li {if $page->categoryId==$key} class="hover"{/if}>
                    <a href="{$_root}{$___urls['route']}{$_COOKIE['city_key']}-{$key}" title="{$val}">{$val}</a>
                </li>
            {/foreach}
        </ul>
        {*<ul class="nav_sl clearfix con guide" id="nav_sl"{$i=0}>*}
        {*<li {if $page->categoryId==0} class="hover" {/if}>*}
        {*<a href="{$_root}{$___urls['route']}" title="全部">全部</a>*}
        {*</li>*}
        {*{foreach $page->allCategory as $key=>$val}*}
        {*{if $i==7}*}
        {*<li class="click" onclick="$('#nav_sl').toggleClass('nav_sll');"><a href="#">查看更多»</a></li>*}
        {*{/if}*}
        {*<li {if $page->categoryId==$key} class="hover"{/if} {$i++}>*}
        {*<a href="{$_root}{$___urls['route']}{$key}" title="{$val}">{$val}</a>*}
        {*</li>*}
        {*{/foreach}*}
        {*</ul>*}
        {*<script>*}
        {*window.onload = SeeMore();*}
        {*function SeeMore() {*}
        {*var position = $('#nav_sl .hover').index();*}
        {*if (position > 8) {*}
        {*$('#nav_sl').addClass('nav_sll');*}
        {*} else {*}
        {*$('#nav_sl').removeClass('nav_sll');*}
        {*}*}
        {*}*}
        {*</script>*}
        <span class="nar"><i class="fa fa-angle-right"></i></span>
    </div>
    <div class="table-responsive">
        <div class="filter_outside">
            <div class="filter_selected hidden">
                <div class="filter_title_selected">
                    已选条件：
                </div>
                <div class="filter_item">
                    <ul class="filter_item_selected">

                    </ul>
                </div>
                <a href="?" class="clearup" style="color: #34495e;">清空所有条件</a>
            </div> {foreach $page->searchValue as $key =>$val}
                <div class="filter_unselected" style="border-bottom: none;">
                    <div class="filter_title">
                        {$key}：
                    </div>
                    <div class="filter_unselected_item">
                        <ul class="dropdrown">
                            {foreach $val as $kk=>$vv}
                                <li>
                                    <a href="?{$page->filterString}filter[{urlencode($key)}]={urlencode($kk)}#list_content"  {if $_REQUEST['filter'][$key]==$kk} style="color:#00c3c3;" {/if}>
                                        {$vv}
                                    </a>
                                </li>
                            {/foreach}
                        </ul>
                    </div>
                    <div class="clear"></div>
                </div>
            {/foreach}

            {foreach $page->filterAttr as $k=>$v}
                <div class="filter_unselected" style="border-bottom: none;">
                    {if {$v['tags']}}
                        <div class="filter_title">
                            {$v['tags']}:
                        </div>
                        <div class="filter_unselected_item">
                            <ul class="dropdrown">
                                {foreach $v['val'] as $vk=>$vv}
                                    {if $vv}
                                        <li>
                                            <a href="?{$page->filterString}filter[{urlencode($k)}]={urlencode($vk)}#list_content" {if $_REQUEST['filter'][$k]==$vk} style="color:#00c3c3;" {/if}>
                                                {$vk}
                                            </a>
                                        </li>
                                    {/if}
                                {/foreach}
                            </ul>
                        </div>
                        <div class="clear"></div>
                    {/if}
                </div>
            {/foreach}

            <div class="filter_unselected">
                <div class="filter_title">
                    价格区间：
                </div>
                <div class="from-inline">
                    <div class="filter_unselected_item">
                        <div class="price-range">
            <span>
                <input placeholder="￥" class="start_price" name="price[start]"
                       value="{htmlspecialchars($_REQUEST['price']['start'])}">
            </span>
                            <span style="color: #ddd;">—</span>
            <span>
                <input placeholder="￥" class="end_price" name="price[end]"
                       value="{htmlspecialchars($_REQUEST['price']['end'])}">
            </span>
                            <span>元</span>
                            <button class="search_price">确定</button>
                            <button style="background:#696969" onclick="clearprice()">清除</button>
                        </div>
                    </div>
                </div>
                <div class="clear"></div>
            </div>

        </div>
        <div class="search_outside">
            <div class="form-inline">
                <div class="form-group form_search">
                    <label class="sr-only" for="search">...</label>

                    <div class="input-group input_search">
                        <input type="text" class="form-control input-lg is input_keyowrd " placeholder="搜索套餐/地址等"
                               name="keyword" value="{htmlspecialchars($_REQUEST['keyword'])}">
<span class="input-group-btn">
<button class="input-lg search_button search_keyword">
    <i class="fa fa-search"></i>&nbsp;搜索
</button>
</span>
                    </div>
                </div>
            </div>
        </div>

    </div>
    <div class="mose_ke mose_ke_border" onclick="OpenConditions()">
        展开更多筛选条件
    </div>
    <script type="text/javascript">
        (function () {
            var selectBut = '';
            {foreach $page->request as $key=>$val}
            {if $key=='filter'}
            {foreach $val as $k=>$v}
            {if $k=='人数'}
            selectBut += ' <li>{$page->searchValue['人数'][$v]}<button type="button" class="close close_button" data-dismiss="alert" aria-label="Close">' +
            '</button><a href="?{$page->filterString}&filter[人数]=all">&times;</a></li>';
            {/if}
            {if $k=='天数'}
            selectBut += ' <li>{$page->searchValue['天数'][$v]}<button type="button" class="close close_button" data-dismiss="alert" aria-label="Close">' +
            '</button><a href="?{$page->filterString}&filter[天数]=all">&times;</a></li>';
            {/if}
            {if $k !='天数' && $k !='人数'}
            selectBut += ' <li>{$v}<button type="button" class="close close_button" data-dismiss="alert" aria-label="Close">' +
            '</button><a href="?{$page->filterString}&filter[{$k}]=all">&times;</a></li>';
            {/if}

            {/foreach}
            {/if}

            {/foreach}
            if (selectBut) {
                $('.filter_selected').removeClass('hidden');
            }
            $('.filter_item_selected').html(selectBut);
        })();
        //展开筛选条件
        function OpenConditions() {
            $('.table-responsive').toggle();
        }
        $(".search_keyword").on('click', function (e) {
            var keyword = $(".input_keyowrd").val();
            if (keyword) {
                window.location.href = '?{$page->filterString}keyword=' + keyword;
            } else {
                window.location.href = '?';
            }
        });
        $(".search_price").on('click', function (e) {
            var start = $(".start_price").val();
            var end = $(".end_price").val();
            window.location.href = '?{$page->filterString}price[start]=' + start + '&price[end]=' + end;
        });
        function clearprice() {
            var start = $('.start_price').val();
            var end = $('.end_price').val();
            if (start != '' || end != '') {
                var clearjg = '';
                $('.start_price').val(clearjg);
                $('.end_price').val(clearjg);
            }
        }
    </script>
</div>