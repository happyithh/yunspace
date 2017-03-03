<div class="top-area">
    {if $page->vendorInfo['logo']}
        <img src="{Page_Site_Global::displayMedia($page->vendorInfo['logo'],200,200,0)}">
    {else}
        <img src="img/v1.0/vendor.jpg"/>
    {/if}
    <p>{$page->vendorInfo['vendor_name']}</p>
</div>
<ul >
    <li>
        <div class="left-text">服务评分</div>
        <div class="right-text">{$page->vendorInfo['vendor_remarks']['内部评分']|default:'待定'}</div>
    </li>
    <li>
        <div class="left-text">服务区域</div>
        <div class="right-text">{$page->vendorInfo['attr']['城市']}</div>
    </li>
    <li>
        <div class="left-text">服务类型</div>
        <div class="right-text">{$page->vendorInfo['category_name']}</div>
    </li>
    <li>
        <div class="left-text">公司规模</div>
        <div class="right-text">{$page->vendorInfo['attr']['公司规模']}</div>
    </li>
    <li>
        <div class="left-text">活动标签</div>
        <div class="right-text">{$page->vendorInfo['attr']['活动类型']}</div>
        <div class="clear"></div>
    </li>
    <li>
        <div class="left-text">行业标签</div>
        <div class="right-text">{$page->vendorInfo['attr']['服务行业']}</div>
        <div class="clear"></div>
    </li>
</ul>
{*临时注释，之后回考虑恢复*}
{*<div class="bottom-area">*}
    {*<a href="#"><div class="green-button">进入商户</div></a>*}
{*</div>*}