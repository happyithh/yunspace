<div class="jud-rej js-pop-judge hide js-pop-cont">
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
{*询价中-是否关闭报价*}
<div class="jud-rej js-judge-inq hide js-pop-cont">
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
{*已关闭-是否重新接受商家报价*}
<div class="jud-rej js-pop-rejudge  hide js-pop-cont">
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
