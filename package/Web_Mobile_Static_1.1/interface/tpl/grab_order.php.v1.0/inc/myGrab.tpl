<style>
    .sub_menu {
        height: 25px;
        line-height: 25px;
        text-align: center;
        margin-top: 10px;
        padding: 5px;
        background-color: #FFF;
    }

    .sub_menu li {
        float: left;
        width: 30%;
        border: 1px solid rgb(241, 83, 83);
        border-radius: 3px;
        margin-left: 2%;
    }

    .active {
        background: rgb(204, 204, 204);
        border: 1px solid rgb(0, 0, 0);
    }

</style>
{*<ul class="sub_menu">*}
{*<li>未开始</li>*}
{*<li>进行中</li>*}
{*<li class="active">完成</li>*}
{*</ul>*}
{if $list}

    {foreach $list as $key=>$val}
        <div class="grab-comn clearfix">

            {if $val['mark_tags'][20]}
                <div class="state-icon">重复单</div>
            {/if}
            {if $val['mark_tags'][2]}
                <div class="state-icon">私</div>
            {/if}
            <a href="?type=B&action=detail&id={$val['id']}" class="grab-comn-cont clearfix">
                <div class="grab-comn-title clearfix">
                    <div class="co-t clearfix">
                        <p class="fl">
                            已接单{if $val['backup_demand']['联系人']}({$val['backup_demand']['联系人']},{$val['backup_demand']['联系电话']}){else}({$val['demand']['联系人']},{$val['demand']['联系电话']}){/if}</p>

                        <p class="fr time">{$step[$val['step']]}</p>
                    </div>
                    <div class="co-b clearfix">
                        <p class="fl">NO.{$val['id']}</p>

                        <div class="fr progress">

                            <p class="fl">进度{$val['step']}%</p>

                            <div class="fl bar-wrap">
                                <div class="bar" style="width: {$val['step']}%"></div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="fl text clearfix" style="padding-top: 10px;">

                    <p>公司名称：{$val['demand']['公司名称']}</p>

                    <p>活动人数：{$val['demand']['活动人数']}</p>

                    <p>活动档期：{$val['schedule']}</p>

                    <p>活动预算：{$val['price']}</p>
                </div>
                <div class="fr btn-in clearfix"></div>
            </a>
        </div>
    {/foreach}
{/if}