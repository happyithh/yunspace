<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    {include "Web_Mobile_Static::v1.0/head_meta.tpl"}
    {static "v1.0/global.css"}
    {static "broke_the_news.v1.0/broke_validate.css"}
    <title>我的爆料详情[云·Space 爆料]</title>
</head>
<body>
<div class="tab-change">
    {*tab导航*}
    {*col-2:width50%
    col-3:width33.3%
    col-4:width25%
    col-5:width20%
    *}
    {*当tab-nav宽度变化时，line宽度也需变化*}
    <ul class="tab-nav cle relative">
        <li class="col-4 fl">
            <a href="javascript:;" class="nav-click nav-click-active"  yun="tabChange/js/tabChange.js::tabChange@click" yun-id="1">
                全部
                <div class="v-line"></div>
            </a>
        </li>
        <li class="col-4 fl">
            <a href="javascript:;" class="nav-click"  yun="tabChange/js/tabChange.js::tabChange@click" yun-id="2">
                审核中
                <div class="v-line"></div>
                {*{if !empty($data['dataCount']['waitingBroke'])}*}
                {*<p class="v-num"></p>*}
                {*{/if}*}
            </a>
            </li>
        <li class="col-4 fl">
            <a href="javascript:;" class="nav-click"  yun="tabChange/js/tabChange.js::tabChange@click" yun-id="3">
                已通过
                <div class="v-line"></div>
                {*{if !empty($data['dataCount']['doneBroke'])}*}
                {*<p class="v-num"></p>*}
                {*{/if}*}
            </a>
        </li>
        <li class="col-4 fl">
            <a href="javascript:;" class="nav-click"  yun="tabChange/js/tabChange.js::tabChange@click" yun-id="4">
                未通过
                <div class="v-line"></div>
                {*{if !empty($data['dataCount']['abandonBroke'])}*}
                {*<p class="v-num"></p>*}
                {*{/if}*}
            </a>
        </li>
        <li class="line col-4 absolute"></li>
    </ul>
    {*tab内容*}
    <div class="tab-cont">
        <div class="tab cle tab-active">
            {if empty($data['dataCount']['sumBroke'])}
                <div class="v-logo">
                    <img src="img/broke_the_news.v1.0/logo.png" alt="">
                    <p>没有审核中的爆料</p>
                </div>
                <div class="v-btn">
                    <a href="{$_home}broke_news">我要爆料</a>
                </div>
            {else}
            <ul class="validate">
                {foreach $data['list'] as $k=>$v}
                    {if $v['demand_status'] !=0 && $v['demand_status'] !=-1}
                        <li>
                            <p class="v-statue v-ok">审核已通过&nbsp;<span>{date('Y.m.d',$v['resolve_time'])}</span></p>

                            <ul class="v-info">
                                <li>活动地点：{$v['city']}</li>
                                <li>{$v['demand']['具体要求']}</li>
                                <li>活动方联系人：{$v['demand']['联系人']}</li>
                                <li>活动方联系电话：{$v['phone']}</li>
                            </ul>
                            <p class="v-date">提交日期：{date('Y.m.d',$v['create_time'])}</p>

                        </li>
                    {/if}
                {/foreach}
                {foreach $data['list'] as $k=>$v}
                    {if $v['demand_status']==-1}
                        <li>
                            <p class="v-statue v-yet">审核未通过&nbsp;<span>{date('Y.m.d',$v['update_time'])}</span></p>
                            <ul class="v-info">
                                <li>活动地点：{$v['city']}</li>
                                <li>{$v['demand']['具体要求']}</li>
                                <li>活动方联系人：{$v['demand']['联系人']}</li>
                                <li>活动方联系电话：{$v['phone']}</li>
                            </ul>
                            <p class="v-date">提交日期：{date('Y.m.d',$v['create_time'])}</p>

                        </li>
                    {/if}
                {/foreach}
                {foreach $data['list'] as $k=>$v}
                    {if $v['demand_status']==0}
                        <li>

                            <p class="v-statue v-ing">审核中</p>
                            <ul class="v-info">
                                <li>活动地点：{$v['city']}</li>
                                <li>{$v['demand']['具体要求']}</li>
                                <li>活动方联系人：{$v['demand']['联系人']}</li>
                                <li>活动方联系电话：{$v['phone']}</li>
                            </ul>
                            <p class="v-date">提交日期：{date('Y.m.d',$v['create_time'])}</p>

                        </li>
                    {/if}
                {/foreach}
            </ul>
            {/if}
        </div>

        <div class="tab cle">
            {*无内容样式*}
            {if empty($data['dataCount']['waitingBroke'])}
                <div class="v-logo">
                    <img src="img/broke_the_news.v1.0/logo.png" alt="">
                    <p>没有审核中的爆料</p>
                </div>
                <div class="v-btn">
                    <a href="{$_home}broke_news">我要爆料</a>
                </div>
            {else}
            {*有内容样式*}
                {if $data['list']}
                    <ul class="validate">
                    {foreach $data['list'] as $k=>$v}
                        {if $v['demand_status']==0}
                            <li>
                                <p class="v-statue v-ing">审核中</p>
                                <ul class="v-info">
                                    <li>活动地点：{$v['city']}</li>
                                    <li>{$v['demand']['具体要求']}</li>
                                    <li>活动方联系人：{$v['demand']['联系人']}</li>
                                    <li>活动方联系电话：{$v['phone']}</li>
                                </ul>
                                <p class="v-date">提交日期：{date('Y.m.d',$v['create_time'])}</p>
                            </li>
                        {/if}
                    {/foreach}
                    </ul>
                {/if}
            {/if}
        </div>
        <div class="tab cle">
            {*无内容样式*}
            {if empty($data['dataCount']['doneBroke'])}
                <div class="v-logo">
                    <img src="img/broke_the_news.v1.0/logo.png" alt="">
                    <p>没有已通过的爆料</p>
                </div>
                <div class="v-btn">
                    <a href="{$_home}broke_news">我要爆料</a>
                </div>
            {else}
                    {if $data['list']}
                        {foreach $data['list'] as $k=>$v}
                            {if $v['demand_status'] !=0 && $v['demand_status'] !=-1}
                                <ul class="validate">
                                    <li>
                                        <p class="v-statue v-ok">审核已通过&nbsp;<span>{date('Y.m.d',$v['resolve_time'])}</span></p>
                                        <ul class="v-info">
                                            <li>活动地点：{$v['city']}</li>
                                            <li>{$v['demand']['具体要求']}</li>
                                            <li>活动方联系人：{$v['demand']['联系人']}</li>
                                            <li>活动方联系电话：{$v['phone']}</li>
                                        </ul>
                                        <p class="v-date">提交日期：{date('Y.m.d',$v['create_time'])}</p>
                                    </li>
                                </ul>
                            {/if}
                        {/foreach}
                    {/if}
            {/if}
        </div>
        <div class="tab cle">
            {*无内容样式*}
            {if empty($data['dataCount']['abandonBroke'])}
                <div class="v-logo">
                    <img src="img/broke_the_news.v1.0/logo.png" alt="">
                    <p>没有未通过的爆料</p>
                </div>
                <div class="v-btn">
                    <a href="{$_home}broke_news">我要爆料</a>
                </div>
            {else}
                {if $data['list']}
                    {foreach $data['list'] as $k=>$v}
                        {if $v['demand_status'] ==-1}
                            <ul class="validate">
                                <li>
                                    <p class="v-statue v-yet">审核未通过&nbsp;<span>{date('Y.m.d',$v['update_time'])}</span></p>
                                    <ul class="v-info">
                                        <li>活动地点：{$v['city']}</li>
                                        <li>{$v['demand']['具体要求']}</li>
                                        <li>活动方联系人：{$v['demand']['联系人']}</li>
                                        <li>活动方联系电话：{$v['phone']}</li>
                                    </ul>
                                    <p class="v-date">提交日期：{date('Y.m.d',$v['create_time'])}</p>
                                </li>
                            </ul>
                        {/if}
                    {/foreach}
                {/if}
            {/if}

        </div>
    </div>
</div>
{static "v1.0/jquery-1.11.1.min.js"}
{static "core/yunspace.js"}
<script>
    $(".v-num").each(function(index,dom){
        var t=$(dom).text();
        if(t>99){
            $(dom).text("99+");
        }
    })
</script>
</body>
</html>