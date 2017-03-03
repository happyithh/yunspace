<!--请完善您的场地标签-->
{if $newTags && !$isCustomer && !$_COOKIE["perfect{$demand_offer['demand_id']}s"]}
    <div class="marks-choice js-marks-choice js-pop-cont">
        <h1>活动方需求关键词</h1>
        <ul class="mk-edit clearfix js-mk-edit-new">
            {foreach $newTags['newTags'] as $key=>$val}
                <li onclick="newTagsAlert(this)">{$val}<span class="icon-cg" data-value="{$key}"></span></li>
            {/foreach}
        </ul>
        <p>勾选你有的,推荐给您的会更匹配哦</p>

        <div class="step-btn">
            <button class="next-step-btn" onclick="operation.vendorNewTagsUpdate(this)">确定</button>
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

{*结束报价弹窗*}
<div class="jud-rej js-pop-noaccept hide js-pop-cont">
    {*<div class="pop-noacpt">*}
        {*<p class="quote-bg-wrt">*}
            {*是否确定接不了？还可以分享<br>问问其他场地哦*}
        {*</p>*}

        {*<div class="btn-wrap btn-noaccept">*}
            {*<a class="btn fl" href="javascript:;">分享</a>*}
            {*<a class="btn fl btn-yes js-btn-yes" href="javascript:;">确认</a>*}
            {*<a class="btn fl btn-no js-close" href="javascript:;">取消</a>*}
        {*</div>*}
    {*</div>*}

    <div class="pop-refuse">
        <a class="refuse-close js-close" href="javascript:;"></a>

        <h1>是否确认接不了？</h1>
        <textarea placeholder="请输入拒绝订单的原因（选填）"></textarea>
        <div class="btn-wrapper">
            <button class="fl btn bg-write js-close">取消</button>
            <button class="fr btn bg-orange js-close">确认</button>
        </div>
    </div>
</div>


<!--新的接受不了弹窗-->


{*提交修改报价弹窗*}
{*<div class="jud-rej js-pop-revise hide js-pop-cont">*}
    {*<p class="quote-bg-wrt">*}
        {*确定要修改报价信息?*}
    {*</p>*}

    {*<div class="btn-wrap">*}
        {*<a class="btn btn-no fl js-close" href="javascript:;">取消</a>*}
        {*<a class="btn btn-yes fr" href="javascript:;"*}
           {*onclick="operation.offerEditSubmit(this)" demand-id="{Func_NumEncode::e($_REQUEST['demand_id'])}">确认</a>*}
    {*</div>*}
{*</div>*}



















