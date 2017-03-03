{if $sum>0}
    <ul class="quote-needs-details">
        <div class="quote-needs-tit">
            <h1>我收到的场地报价</h1>
        </div>
        {foreach $schemeList as $k=>$val}
            <li>
                <a href="{$_root}m/baike/{$val['space_name']}" target="_blank" style="overflow: auto;color: #000">
                    <div class="quote-needs-cont clearfix">
                        <div class="time">报价时间：<span>{$val['offer_time']}</span></div>
                        <div class="img">
                            <img src="{Page_Site_Global::displayMedia($val['logo'],200,200)}">
                        </div>
                        <div class="cont">
                            <h2><a href="{$_root}spacepedia/{$val['item_id']}.html">{$val['item_name']}</a></h2>

                            <p><img src="img/demand_tender.v1.0/icon_01.png">城市：{$val['city']}</p>

                            <p style="white-space: normal;overflow: hidden;text-overflow: ellipsis;"><img
                                        src="img/demand_tender.v1.0/icon_02.png">地址：{$val['addr']}</p>

                            <p><img src="img/demand_tender.v1.0/icon_03.png">面积：{$val['size']}㎡</p>

                            <p class="price">￥<span>{$val['offer_price']}</span></p>
                        </div>

                        <p class="remarks quote-p"><span class="tit">其他备注：</span><span class="ct">
                            {$val['offer_info']['其他备注']}
                    </span></p>
                    </div>
                    {if $val['change_phone_time']}
                        <div class="contact-sj">
                            <p class="numb">联系商家：<span>{$val['offer_info']['联系人']}-{$val['offer_info']['联系电话']}</span>
                            </p>
                            <a class="icon-phone" href="tel:{$val['offer_info']['联系电话']}"><img
                                        src="img/demand_tender.v1.0/icon-phone-org.png"></a>
                        </div>
                    {else}
                        <div class="contact-sj-btn">
                            <input class="js-getnumb" data-result-id="{$val['result_id']}"
                                   data-demand-id="{$demand_offer['demand_id']}" type="button"
                                   onclick="operation.clickGetContact(this)" value="点击获得商家联系方式">
                        </div>
                    {/if}
                </a>
            </li>
        {/foreach}
    </ul>
{elseif $demand_offer['isThirty']}
    <div class="wait-inq">
        <div class="wait-inq-tit  clearfix">
            <span class="icon-time"></span>

            <h2 class="orange">正在等待商家报价</h2>
        </div>
        <p>云·SPACE将在您提交活动需求的30分钟后通过短信以及云·SPACE服务号向您推送报价结果，请您耐心等待。</p>
    </div>
{/if}
<!--确认并获取商家联系方式-->
<div class="demand-popup js-pop-cont hide">
    <div class="popup-exchange-ph popup-btn">
        <p class="quote-bg-wrt">云·SPACE为您快速匹配到合适的场地并提供报价，请双方自行洽谈合作事宜。云·SPACE对双方沟通结果不予负责</p>
        <input class="quote-bg-wrt js-confirm confirm" type="submit" onclick="operation.changePhone()"
               value="确认并获取商家联系方式">
        <a class="quote-bg-wrt js-cancel cancel" href="javascript:;">取消</a>
    </div>
</div>