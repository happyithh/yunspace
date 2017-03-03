{if $isCustomer}
    {*打开时-没有方案**}
    {if $demand_offer['status']>=0 && $matchSum == 0  && !$_COOKIE["noScheme{$demand_offer['demand_id']}s"]}
        <div class="jud-rej  js-pop-cont">
            <div class="cont">
                <p class="text">
                    没有找到合适的场地
                </p>

                <p class="text-qust">修改您的活动需求在试试吧</p>
            </div>
            <div class="btn-wrap">
                <a class="btn btn-no fl js-close" href="javascript:;"
                   onclick="operation.CustomerUpdateStatus('noScheme',false)">关闭活动</a>
                <a class="btn btn-yes fr js-noScheme" href="javascript:;" TARGET="_blank"
                   onclick="operation.goEdit('noScheme',true)" data-demand-id="{$demand_offer['demand_id']}">立即修改</a>
            </div>
        </div>
        <div class="popup_bg"></div>
    {/if}

    {*打开时-是否继续等待商家报价*}
    {if $demand_offer['update_time'] < (time()-1200) && $demand_offer['status']>=0 && $sum > 0 && $sum<3 && !$_COOKIE["waiting{$demand_offer['id']}s"]}
        <div class="jud-rej js-pop-judge  js-pop-cont">
            <div class="cont">
                <p class="text">
                    您目前已收到<span>{$sum}</span>份场地报价<br>还有<span>{$matchSum}</span>个匹配的场地正在报价中
                </p>

                <p class="text-qust">是否继续等待商家报价？</p>
            </div>

            <div class="btn-wrap">
                <a class="btn btn-no fl js-close" href="javascript:;"
                   onclick="operation.CustomerUpdateStatus('waiting',false)">否</a>
                <a class="btn btn-yes fr" href="javascript:;"
                   onclick="operation.CustomerUpdateStatus('waiting',true)">是</a>
            </div>
        </div>
        <div class="popup_bg"></div>
    {/if}

    {*询价中-是否关闭报价*}
    {if $demand_offer['update_time'] < (time()-1200) && $demand_offer['status']>=0 && $sum>10 && !$_COOKIE["close{$demand_offer['id']}s"]}
        <div class="jud-rej js-judge-inq  js-pop-cont">
            <div class="cont">
                <p class="text">
                    您目前已收到<span>{$sum}</span>份场地报价<br>正在等待更多商家报价</p>

                <p class="text-qust">是否关闭报价？</p>
            </div>

            <div class="btn-wrap">
                <a class="btn btn-no fl js-close" href="javascript:;">否</a>
                <a class="btn btn-yes fr" href="javascript:;"
                   onclick="operation.CustomerUpdateStatus('close',true)">是</a>
            </div>
        </div>
        <div class="popup_bg"></div>
    {/if}
    {*已关闭-是否重新接受商家报价*}
    {if $demand_offer['update_time'] < (time()-1200) && $demand_offer['status'] < 0 && $sum>0 && !$_COOKIE["open{$demand_offer['id']}s"] && $demand_offer}
        <div class="jud-rej js-pop-rejudge  js-pop-cont">
            <div class="cont">
                <p class="text">
                    您目前已收到<span>{$sum}</span>份场地报价<br>此活动需求已关闭
                </p>

                <p class="text-qust">是否重新接受商家报价？</p>
            </div>

            <div class="btn-wrap">
                <a class="btn btn-no fl js-close" href="javascript:;">否</a>
                <a class="btn btn-yes fr" href="javascript:;"
                   onclick="operation.CustomerUpdateStatus('open',true)">是</a>
            </div>
        </div>
        <div class="popup_bg"></div>
    {/if}

{/if}
{*商家*}
<!--请完善您的场地标签-->
{if $newTags && !$isCustomer && !$_COOKIE["perfect{$demand_offer['demand_id']}s"]}
    <div class="jud-rej js-pop-mk hide js-pop-cont">
        <div class="cont">
            <h5>{$newTags['item_name']}</h5>
            {foreach $newTags['newTags'] as $k=>$val}
                <p class="p-mk-big hide">该客户需要：<span data-value="{$k}">{$val}</span></p>
            {/foreach}
            <p class="p-mk-sm">您的场地是否符合?</p>
        </div>

        <div class="btn-wrap">
            <a class="btn btn-no fl" onclick="NewTagsUpdate(0)" href="javascript:;">否</a>
            <a class="btn btn-yes fr" onclick="NewTagsUpdate(1)" href="javascript:;">是</a>
        </div>
    </div>
    <div class="popup_bg"></div>
{/if}

<!--温馨提示弹窗-->
<div class="js-reminder-box hide js-pop-cont" style="width: 100%;height: 100%;">
    <div class="reminder">
        <h1>温馨提示</h1>

        <p>由于移动运营商短信限制，您的这个活动需求只能收到一次短信报价提醒，我们还提供了微信服务号报价提醒功能，关注云·SPACE服务号后您可以实时的收到每个报价的提醒，您保存如下二维码在微信里识别，或者在微信里搜索【<span
                    class="orange">yunspacefwh</span>】进行关注。</p>

        <div class="code-copy clearfix">
            <div class="qr-code"><img src="img/demand_tender.v1.0/qr_code.jpg"></div>
            <div class="text"><img src="img/demand_tender.v1.0/img_text.jpg"></div>
        </div>
        <a class="w-close js-cancel" href="javascript:;"></a>
    </div>
</div>



