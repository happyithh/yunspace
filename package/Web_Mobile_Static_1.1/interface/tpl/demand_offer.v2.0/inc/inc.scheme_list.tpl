{if $sum>0}
    <ul class="quote-needs-details quote-cust" {$i=1}>
        {foreach $schemeList as $k=>$val}
            <li>
                <a href="http://www.yunspace.com.cn/m/baike/{$val['space_name']}" target="_blank"
                   style="overflow: auto;color: #000">
                    <div class="quote-needs-cont clearfix">
                        <div class="li-tit clearfix">
                            <div class="fl index">第<span>{$i}</span>份</div>
                            <div class="fr time" {$i=$i+1}>报价时间：<span>{$val['offer_time']}</span></div>
                        </div>
                        <div class="img">
                            <img src="{Page_Site_Global::displayMedia($val['logo'],200,200)}">
                        </div>
                        <div class="cont">
                            <h2>
                                <a href="http://www.yunspace.com.cn/m/baike/{$val['space_name']}">{$val['item_name']}</a>
                            </h2>

                            <p><img src="img/demand_tender.v1.0/icon_01.png">城市：{$val['city']}</p>

                            <p><img src="img/demand_tender.v1.0/icon_02.png">地址：{$val['addr']}</p>

                            <p><img src="img/demand_tender.v1.0/icon_03.png">面积：{$val['size']}㎡</p>

                            <p class="price">
                                {if {$val['offer_price']> 0}}
                                    ￥
                                    <span>{$val['offer_price']}/<span
                                                style="font-size: 14px;">{$val['offer_unit']}</span></span>
                                {else}
                                    面议
                                {/if}
                                {if $val['is_update']}
                                    <span style="color: red;font-size: 14px">(重新报价)</span>
                                {/if}
                            </p>
                        </div>
                        <p class="remarks quote-p"><span class="tit">其他备注：</span><span class="ct">
                         {$val['offer_info']['其他备注']}</span>
                        </p>
                    </div>

                    {if $val['change_phone_time'] && $val['change_phone_time']!=-1}
                        <div class="contact-sj">
                            <p class="numb">商家：<span>{$val['offer_info']['联系人']}-{$val['offer_info']['联系电话']}</span>
                            </p>

                            <a class="icon-phone" style="cursor: pointer" onclick="operation.callPhone(this)"
                               data-type="customer"
                               data-phone="{$val['offer_info']['联系电话']}"
                               data-result="{Func_NumEncode::e($val['id'])}"><img
                                        src="img/demand_tender.v1.0/icon-phone-org.png"></a>
                        </div>
                    {else}
                        <div class="contact-sj-btn">
                            {if $val['countdown']>0}
                                <p class="dmd-hint clearfix">还剩<span class="countdown" id="countdown{$i}"
                                                                     data-time="{$val['countdown']}"></span>，超时即视为无意向哦！
                                </p>
                            {/if}
                            {if $val['change_phone_time']==-1}
                                <h6 class="chaoshi-hint">无意向(超时未确认)<span
                                            style="float: right">{$val['last_view_time']}</span></h6>
                            {/if}
                        </div>
                        {if $val['change_phone_time']==0}
                            <div class="contact-sj-btn">
                                <input class="js-getnumb" data-result-id="{$val['result_id']}"
                                       data-demand-id="{$demand_offer['demand_id']}" type="button"
                                       onclick="operation.clickGetContact(this)" value="点击获得商家联系方式">

                            </div>
                        {/if}
                        {*<div class="contact-sj-btn">*}

                        {*</div>*}
                    {/if}
                </a>
            </li>
        {/foreach}

    </ul>
{else}
    {if $demand_offer['status'] < 0}
        <div class="img_quote_end">
            <img src="img/demand_tender.v1.0/img_quote_end.png">

            <p>报价已结束</p>
        </div>
    {elseif $demand_offer['isThirty']}
        <div class="wait-inq">
            <div class="wait-inq-tit clearfix">
                <span class="icon-time"></span>

                <h2 class="orange">正在等待商家报价</h2>
            </div>
            <p>云·SPACE将在30分钟后以短信、微信服务号推送报价信息，记得要看哦！</p>

        </div>
        <div class="wait-inq">
            <p style="text-align: center">
                <img src="/package/Web_Mobile_Static_1.1/interface/assets/img/demand_tender.v1.0/qrcode_v2.jpg"
                     width="100%;">
            </p>
        </div>
    {else}
        <!--正在等待商家报价-->
        {*<div class="wait-inq">*}
        {*<div class="wait-inq-tit clearfix">*}
        {*<span class="icon-time"></span>*}

        {*<h2 class="orange">正在等待商家报价</h2>*}
        {*</div>*}
        {*<p>云·SPACE将在30分钟后以短信、微信服务号推送报价信息，记得要看哦！</p>*}

        {*</div>*}
        <div class="wait-inq">
            <p style="text-align: center">
                <img src="/package/Web_Mobile_Static_1.1/interface/assets/img/demand_tender.v1.0/qrcode_v2.jpg"
                     width="100%;">
            </p>
        </div>
        {*<div class="wait-inq">*}

        {*<p>云·SPACE将在30分钟后以短信、微信服务号推送报价信息，记得要看哦！</p>*}

        {*<p style="text-align: center">*}
        {*<img src="/package/Web_Mobile_Static_1.1/interface/assets/img/demand_tender.v1.0/qrcode.jpg">*}
        {*</p>*}
        {*</div>*}
    {/if}
{/if}
<!--确认并获取商家联系方式-->
<div class="demand-popup js-pop-cont hide">
    <div class="popup-exchange-ph popup-btn">
        <p class="quote-bg-wrt">合作事宜请与商家联系，</br>云•SPACE不参与具体沟通。
        </p>
        <input class="quote-bg-wrt js-confirm confirm" type="submit" onclick="operation.changePhone()"
               value="确认获取联系方式">
        <a class="quote-bg-wrt js-cancel cancel" href="javascript:;">取消</a>
    </div>
</div>
<script>
    $(function () {


        $(".countdown").each(function () {
            var _id = $(this).attr('id');
            var _endTime = $(this).attr('data-time');
            addTimer(_id, _endTime);
        });
    })
</script>