<!DOCTYPE html>
<html>
<head lang="en">
    {include "Web_Mobile_Static::v1.0/head_meta.tpl"}
    {static "v1.0/global.css"}
    {static "grab_order.v1.0/grab.css"}
    {static "v1.0/jquery-1.11.1.min.js"}
    {static "core/yunspace.js"}

    {static "grab_order.v1.0/grab.js"}
    {static "grab_order.v1.0/operation.js"}
</head>
<body>
<div class="wrapper">
    <div class="grab-title">
        <h2 class="state">已接单
            {if $data['mark_tags'][2]}
                (私)
            {/if}
            {if $data['mark_tags'][20]}
                (重复)
            {/if}
        </h2>

        <div class="fr progress">
            <p class="fl">进度{$data['step']}%</p>

            <div class="fl bar-wrap">
                <div class="bar" style="width: {$data['step']}%"></div>
            </div>
        </div>
    </div>
    {include "Web_Mobile_Static::grab_order.php.v1.0/inc/demand_detail.tpl"}
    {*****客户意向*********}
    {if $events}
        <div class="contact-records">
            <div class="contact-records-title">客户咨询</div>
            <ul class="contact-records-list">
                {foreach $events as $val}
                    <li>
                        <a href="{$_home}baike/{Func_Url::str_urlencode($val['space_name'])}" target="_blank"
                           style="text-align: left">
                            <p>城市：{$val['city']}</p>

                            <p>场地：{$val['space_name']}</p>

                            <p>地址：{$val['addr']}</p>

                            <p>档期：{$val['demand']['开始时间']} 至 {$val['demand']['结束时间']}</p>

                            <p>要求：{$val['demand']['具体要求']}</p>
                        </a>
                    </li>
                {/foreach}
            </ul>
        </div>
    {/if}


    {if $data['step'] >= 0 && $data['step'] <100}
        <!--更新进度记录-->
        <div class="update-records">
            <div class="update-records-title">更新进度记录</div>
            <div class="update-records-cont">
                {*<div class="col clearfix">*}
                    {*<span class="icon icon1"></span>*}
                    {*<select id="record_step">*}
                        {*{foreach $step as $key=>$val}*}
                            {*{if $key > $data['step'] || $key < 0}*}
                                {*<option value="{$key}">{$val}--{$key}%</option>*}
                            {*{/if}*}
                        {*{/foreach}*}
                    {*</select>*}
                    {*<span class="icon-pull"></span>*}
                {*</div>*}
                {*<div class="col clearfix">*}
                    {*<span class="icon icon2"></span>*}
                    {*<textarea id="record_content" placeholder="请输入10个汉字以上的说明"></textarea>*}
                {*</div>*}
                {*<button class="update-btn js-update-btn" onclick="operation.recordSubmit(this)" data-id="{$data['id']}">*}
                    {*提交*}
                {*</button>*}
                <form method="">
                    <div class="col clearfix">
                        <span class="icon icon1"></span>

                        <select id="col-selected">
                            {foreach $step as $key=>$val}
                            {if $key > $data['step'] || $key < 0}
                            <option value="{$key}">{$val}--{$key}%</option>
                            {/if}
                            {/foreach}
                            {*<option>已电话-10%</option>*}
                            {*<option>已电话-20%</option>*}
                            {*<option value="1000">此单为重复单，关闭</option>*}
                        </select>
                        <span class="icon-pull"></span>
                    </div>
                    <div class="col col-reason hide clearfix">
                        <h6>请选择关闭理由</h6>
                        <ul class="reason-list">
                            <li><label><input type="radio" name="reason" value="客户预算不足">客户预算不足</label></li>
                            <li><label><input type="radio" name="reason" value="没有合适的产地推荐">没有合适的产地推荐</label></li>
                            <li><label><input type="radio" name="reason" value="客户跳单">客户跳单</label></li>
                            <li><label><input type="radio" name="reason" value="客户已经自己找到场地">客户已经自己找到场地</label></li>
                            <li><label><input type="radio" name="reason" value="活动取消">活动取消</label></li>
                            <li><label><input type="radio" name="reason" value="客户不再接听电话">客户不再接听电话</label></li>
                            <li><label><input type="radio" name="reason" value="公关公司比稿失败">公关公司比稿失败</label></li>
                            <li><label><input type="radio" name="reason" class="reason-other" value="2000">其他</label></li>
                            <li class="hide reason-textarea"><textarea rows="3" placeholder="请输入关闭的理由"></textarea></li>
                        </ul>
                    </div>
                    <div class="col clearfix" id="input-reason">
                    <span class="icon icon2"></span>
                    <textarea placeholder="请输入10个汉字以上的说明"  id="record_content"></textarea>
                    </div>

                    <a class="update-btn js-update-btn" href="javascript:void(0)" onclick="operation.recordSubmit(this)" data-id="{$data['id']}">提交</a>
                </form>
            </div>
        </div>
    {/if}
    <!--历史联系记录-->

    <div class="contact-records">
        <div class="contact-records-title">历史联系记录</div>
        {if $record}
            <ul class="contact-records-list">
                {foreach $record as $val}
                    <li>
                        <div class="time clearfix"><p class="fl">{$val['create_time']}</p>

                            <div class="fr progress">
                                <p class="fl">进度{$val['step']}%</p>
                                {*<div class="fl bar-wrap">*}
                                {*<div class="bar" style="width: {$val['step']}%"></div>*}
                                {*</div>*}
                            </div>
                        </div>
                        <p>{$val['reason']}</p>
                    </li>
                {/foreach}
            </ul>
        {/if}
    </div>

</div>
{include "Web_Mobile_Static::grab_order.php.v1.0/inc/menu.tpl"}
<!--wrapper-end-->
<script>
    localStorage.clear();
</script>
</body>
</html>