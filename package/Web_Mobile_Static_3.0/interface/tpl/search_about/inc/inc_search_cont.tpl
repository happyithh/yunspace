<div class="search-cont-wrapper">
    <!--位置-->
    <div class="cont-title">位置</div>
    <div class="cont cont-adress clearfix">
        <p class="fl address-point"></p>
        <a class="btn-location center" href="javascript:;">&nbsp;我的位置</a>
    </div>

    <!--用途搜索-->
    <div class="cont-title clearfix">
        <p class="fl">用途搜索</p>
        {*<p class="fr">-- 公益展览、艺术展出、主题展览...</p>*}
    </div>
    <ul class="cont cont-use clearfix">
        {foreach $page->getActiveName as $k=>$v}
        <li data-active="{$v}"><a href="javascript:;">{$v}</a></li>
        {/foreach}
        <li class="more"><a href="javascript:;"></a></li>
    </ul>

    <!--热词搜索-->
    <div class="cont-title">热词搜索</div>
    <ul class="cont cont-hot clearfix">
        <li data-active="Party活动"><a href="javascript:;">Party活动</a></li>
        <li data-active="商务会议"><a href="javascript:;">商务会议</a></li>
        <li data-active="培训讲座"><a href="javascript:;">培训讲座</a></li>
        <li data-active="婚礼喜宴"><a href="javascript:;">婚礼喜宴</a></li>
        <li data-active="晚会年会"><a href="javascript:;">晚会年会</a></li>
    </ul>

    <!--历史记录-->
    <div class="cont-title clearfix">
        <p class="fl">历史记录</p>
        <a class="fr record-clear js-record-clear" href="javascript:;">清空</a>
    </div>
    <div class="cont cont-record clearfix">
        <p class="no-history none">暂无历史记录</p>
        {*<a class="record" href="javascript:;">长宁红坊创意园</a>*}
        {*<a class="record" href="javascript:;">正大广场</a>*}
        {*<a class="record" href="javascript:;">推广路演</a>*}
    </div>
</div>
