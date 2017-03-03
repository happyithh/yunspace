{*结束报价弹窗*}
<div class="jud-rej js-pop-endquote hide js-pop-cont">
    <p class="quote-bg-wrt">
        不再收取新报价<br>确定结束？
    </p>

    <div class="btn-wrap">
        <a class="btn btn-no fl js-close" href="javascript:;">取消</a>
        <a class="btn btn-yes fr" href="javascript:;"
           onclick="operation.CustomerUpdateStatus('close',true)">确认</a>
    </div>
</div>

{*拨打电话弹窗*}
<div class="jud-rej js-pop-phone hide js-pop-cont">
    <p class="quote-bg-wrt">
        <strong>提示</strong>
        <br>确定拨打电话：<span class="nm">
            {if $demand_offer['admin_phone']}
                {$demand_offer['admin_phone']}
            {else}400-056-0599{/if}
            </span>吗？
    </p>

    <div class="btn-wrap">
        <a class="btn btn-no fl js-close" href="javascript:;">取消</a>
        <a class="btn btn-yes fr" href="tel:{if $demand_offer['admin_phone']}{$demand_offer['admin_phone']}{else}400-056-0599{/if}">确认</a>
    </div>
</div>



























