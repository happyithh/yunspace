<!--筛选条件无结果时-开始-->
<div class=" mcont-none">
    <div class="mcont-logo"><img src="img/mapsearch/m_logo.png" alt="logo"></div>
    <p>没找到这个场地呢，来看看我们的推荐吧</p>
    <a class="mcont-btn f-room" href="javascript:;">我要办活动</a>
</div>
{if $recommend}
    <div>
        <div class="recommend-title">相关推荐</div>
        <ul class="mcont-list-cont recommend">
            {foreach $recommend as $k=>$val}
                <li class=" clearfix">
                    <a href="{$_root}service_info{$val['id']}.html" target="_blank">
                        <div class="mcont-img">

                            <img src="{$val['logo']}">

                        </div>
                        <div class="mcont-details">
                            <h2>
                                {$val['product_name']}</h2>

                            <p>{$val['addr']}</p>

                            <div class="m-tag">
                                {foreach $val['activity_type'] as $vv}
                                    <span>{$vv}</span>
                                {/foreach}
                            </div>
                            <p>
                                {if $val['order_people_number']}
                                    {$val['order_people_number']}人|
                                {/if}
                                {if $val['order_product_size']}
                                    {$val['order_product_size']}㎡ |
                                {/if}
                                {if $val['addr']}
                                    {$val['addr']}
                                {/if}
                            </p>
                        </div>
                        <!--mcont-details-end-->
                        <div class="mcont-price">
                            {if $val['price'] > 100}
                                <strong>{$val['price']}</strong>
                                <span>/元</span>
                            {else}
                                <strong></strong>
                                <span>面议</span>
                            {/if}
                        </div>
                    </a>
                </li>
            {/foreach}
        </ul>
    </div>
{/if}
<!--筛选条件无结果时-结束-->
<script>

    $(".f-room").on("click", function () {
        $(".cover-body").fadeIn(200);
        $(".demand-one").show();
        var wH = $(window).height();
        if (wH < 760) {
            var sT = $(window).scrollTop();
            $('.demand-body').css({
                'position': 'absolute'
            });
            $(".demand-one").animate({
                top: sT + wH * 0.1 + 'px'
            }, 400)
        } else {
            $('.demand-body').css({
                'position': 'fixed'
            });
            $(".demand-one").animate({
                top: "10%"
            }, 400)
        }
    });
</script>