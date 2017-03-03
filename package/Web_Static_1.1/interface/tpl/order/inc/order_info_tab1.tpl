
    <!--订单确认-->
    {if $orderinfo['is_buyer']}
        <div class="order-comn order-confirm">
            <h1 style="text-align: center;">等到供应商家接单中...</h1>
            <h2>预计<span class="magenta">30分钟内</span>商家会接单，此页面关闭后您可到“采购管理-交易管理”中查看结果</h2>
            <p>您还可拨打服务热线 <span class="green">400-056-0599</span> 咨询</p>
            {*<p>如果不想继续，您可 <a href="" class="blue" style="text-decoration: underline;">取消订单</a></p>*}
            <p>如果不想继续，您可 <a href="javascript:;" data-status="-1" class="blue js-cancel" style="text-decoration: underline;">取消订单</a></p>
        </div><!--order-confirm-end-->
    {else}
        <div class="order-submit order-submit-m">
            <input class="fl orsm-mcf bg-magenta js-orsm-mcf confirm_order" type="button" value="确认订单">
            <input class="fr orsm-mrf blue js-orsm-mrf js-refuse" type="button" data-status="-1" value="拒绝接单">
        </div>
    {/if}




