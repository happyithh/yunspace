<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no,minimal-ui">
    <meta name="format-detection" content="telephone=no"/>
    <link type="text/css" rel="stylesheet" href="css/v1.0/style_public.css">
    <link type="text/css" rel="stylesheet" href="css/demand_off.v2.0/quote.css">
    <script src="js/v1.0/jquery-1.11.1.min.js"></script>
    <title>标签修改-【云·SPACE】</title>

</head>
<body>
<!--编辑标签-->
<div class="dmd-tend-my">

    {if $data['tags']}
        <ul class="mk-edit clearfix js-mk-edit">
            {foreach $data['tags'] as $k =>$val}
                <li data-value="{$k}">{$val}<span class="icon-cg"></span></li>
            {/foreach}
        </ul>
        <a href="javascript:;" class="mk-editbtn hv-mk-editbtn js-mk-editbtn">+添加</a>
    {else}
        <ul class="mk-edit clearfix js-mk-edit">
        </ul>
        <div class="nomarks-text">有了标签，场地才能更容易被选中哦。<br>给我的场地贴标签</div>
        <a href="javascript:;" class="mk-editbtn no-mk-editbtn js-mk-editbtn">+添加</a>
    {/if}

</div>
{if $data['tags']}
    <div class="recommended-marks">
        <h2>推荐标签</h2>
        <ul class="mk-edit clearfix">
            {foreach $tags_recommend as $key =>$val}
                <li data-id="{$val['id']}" onclick="operation.clickRecommend(this)" item-id="{$data['id']}"  result-id="{$_REQUEST['result_id']}" >{$val['tag_value']}</li>
            {/foreach}

        </ul>
    </div>
{/if}

<div class="fill-fot-btn clearfix hide dmd-delt-btn">
    <button class="form-sbt bg-orange " onclick="operation.delTagSubmit(this)" item-id="{$data['id']}"
            result-id="{$_REQUEST['result_id']}">删除
    </button>
</div>

<!--确认删除弹窗-->
<div class="demand-popup js-pop-cont hide pop-dmd-delt">
    <div class="popup-exchange-ph popup-btn">
        <input class="quote-bg-wrt confirm" type="button"
               onclick="operation.mkSubmit(this)" item-id="{$data['id']}" result-id="{$_REQUEST['result_id']}"
               value="确认并修改">
        <a class="quote-bg-wrt js-cancel cancel" href="javascript:;">取消</a>
    </div>
</div>

<!--添加标签弹窗-->
<div class="jud-rej js-pop-addmarks hide js-pop-cont">
    <p class="quote-bg-wrt">
        标签名称（10个字以内）
    </p>

    <div class="addmarks-text">
        <input class="addmarks-text-ipt" type="text">
    </div>
    <div class="btn-wrap">
        <a class="fl btn btn-no js-close" href="javascript:;">取消</a>
        <a class="fr btn btn-yes js-close" href="javascript:;" onclick="operation.addTagSubmit(this)"
           item-id="{$data['id']}" result-id="{$_REQUEST['result_id']}">确认</a>
    </div>
</div>
{*<!--标签删除确认弹窗-->*}
{*<div class="jud-rej js-pop-dltmarks hide js-pop-cont">*}
{*<p class="quote-bg-wrt">*}
{*部分标签已删除，确认删除*}
{*</p>*}

{*<div class="btn-wrap">*}
{*<a class="btn btn-no fl js-close" href="javascript:;">取消</a>*}
{*<a class="btn btn-yes fr js-close " onclick="operation.delTagSubmit(this)" item-id="{$data['id']}"*}
{*result-id="{$_REQUEST['result_id']}" href="javascript:;">确认</a>*}
{*</div>*}
{*</div>*}

<script>


</script>

{static "core/yunspace.js"}
{static 'demand_offer.v2.0/demand_offer_operation.js'}
{static "demand_offer.v2.0/pop.js"}
</body>

</html>