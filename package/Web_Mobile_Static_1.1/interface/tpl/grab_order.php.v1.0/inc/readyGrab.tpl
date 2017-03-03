{if $list}
    {foreach $list as $key=>$val}
        <div class="grab-comn clearfix" id="readyGrab">
            <div class="state-icon" id="ready{$val['id']}" style="display: none">已读</div>
            {if $val['mark_tags'][20]}
                <div class="state-icon">重复单</div>
            {/if}
            <a href="javascript:void(0)" class="grab-comn-cont clearfix " data-id="{$val['id']}"
               onclick="goToDetail(this)">
                <div class="grab-comn-title clearfix">
                    <div class="co-t clearfix">
                        <p class="fl">等待抢单</p>

                        <p class="fr time"><i class="icon_time"></i><span id="time{$key}"
                                                                          data-time="{$val['end_time']}"></span>
                        </p>
                    </div>
                    <div class="co-b clearfix">
                        <p class="fl">NO.{$val['id']}</p>

                        <div class="fr balance-icon">{$val['integral']}积分</div>
                        <div class="fr progress"></div>
                    </div>
                </div>

                <div class="fl text clearfix " style="padding-top: 10px;">
                    <p>公司名称：{$val['demand']['公司名称']}</p>

                    <p>活动人数：{$val['demand']['活动人数']}</p>

                    <p>活动档期：{$val['schedule']}</p>

                    <p>活动预算：{$val['price']}</p>
                </div>
                <div class="fr btn-in clearfix"></div>
            </a>
        </div>
    {/foreach}
{else}
    {if $_REQUEST['no_alert']==1}
        {"<script>alert('您来晚了，订单已被抢走了！')</script>"}
    {/if}
{/if}
<script>
    $(function () {
        $("#readyGrab .state-icon").each(function () {
            var id = $(this).attr('id');
            if (localStorage.getItem(id) == 1) {
                $(this).show();
            }
        });

        $("#readyGrab span").each(function () {
            var _id = $(this).attr('id');
            var _endTime = $(this).attr('data-time');
            addTimer(_id, _endTime);
        });
    })

    function goToDetail(e) {
        var _id = $(e).attr('data-id');
        window.location.href = '?type=A&action=detail&id=' + _id;
        var ready = 'ready' + _id;
        localStorage.setItem(ready, 1);

    }
</script>