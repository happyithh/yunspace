<!DOCTYPE>
<html>
<head>
    <title>公出签到列表</title>
    {include file="Web_Mobile_Static::inc/header_meta.tpl"}
    <meta name="full-screen" content="yes"/>
    <meta name="x5-fullscreen" content="true"/>
    {static "comment/comment.css"}
    {static "sign_in/mobiscroll_002.js"}
    {static "sign_in/mobiscroll_004.js"}
    {static "sign_in/mobiscroll.js"}
    {static "sign_in/mobiscroll_003.js"}
    {static "sign_in/mobiscroll_005.js"}
    {static "sign_in/mobiscroll_003.css"}
    {static "sign_in/mobiscroll_002.css"}
    {static "sign_in/mobiscroll.css"}
    {static "sign_in/sign_in.css"}

</head>
<body style="background: #eaeaea;">
<div class="tab-list">
    <a href="{$_home}sign_in/list/status_all" {if $page->signStatus=='all'}class="current"{/if}>全部</a>
    <a href="{$_home}sign_in/list/status_waiting" {if $page->signStatus=='waiting'}class="current"{/if}>审核中</a>
    <a href="{$_home}sign_in/list/status_done" {if $page->signStatus=='done'}class="current"{/if}>待签到</a>
    <a href="{$_home}sign_in/list/status_sign_done" {if $page->signStatus=='sign_done'}class="current"{/if}>已签到</a>
    <a href="{$_home}sign_in/list/status_reject" {if $page->signStatus=='reject'}class="current"{/if}>审核拒绝</a>
</div>
{if count($page->signInList)>0}
    {foreach $page->signInList as $k=>$v}
        <a href="{$_home}sign_in/detail/{Func_NumEncode::e($v['id'])}" class="column">
            <div class="column-title clearfix">
                <div class="fl state">
                    {if $v['status']==0}
                        <p class="icon-state-shen">审</p>
                        <h3>审核中</h3>
                    {elseif $v['status']==1}
                        <p class="icon-state-dai">待</p>
                        <h3>待签到</h3>
                    {elseif $v['status']==2}
                        <p class="icon-state-hv">签</p>
                        <h3>已签到</h3>
                    {elseif $v['status']==-1}
                        <p class="icon-state-refuse">拒</p>
                        <h3>审核拒绝</h3>
                    {/if}
                </div>
                <div class="fr time">{date('Y.m.d',$v['create_time'])}</div>
            </div>
            <div class="column-cont">
                <p><span>离开时间：</span>{date('Y-m-d h:i',$v['outside_time'])}</p>

                <p><span>返回时间：</span>{date('Y-m-d h:i',$v['back_time'])}</p>

                <p><span>公出地址：</span>{$v['address']}</p>

                <div class="icon-in" href="javascript:;">&gt;</div>
            </div>
        </a>
    {/foreach}
{/if}
<a href="{$_home}sign_in/sign" class="new-built clearfix" style="width:100%;">
<div class="new-built-wrap">
    <div style="width: 70px; margin:auto;">
    <i class="icon-bulit"></i><span>新建</span>
    </div>
</div>
</a>

<div style="height: 40px;width: 100%;background: none"></div>
</body>
</html>
