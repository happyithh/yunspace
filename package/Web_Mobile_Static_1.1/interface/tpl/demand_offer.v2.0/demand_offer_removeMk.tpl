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
    <ul class="mk-edit clearfix">
        <li>秀场速度快放假<span class="icon-cg"></span></li>
        <li>秀场速度放假<span class="icon-cg"></span></li>
        <li>秀放假<span class="icon-cg"></span></li>
        <li>快放假<span class="icon-cg"></span></li>
        <li>秀场速度快放假<span class="icon-cg"></span></li>
    </ul>
    <a href="javascript:;" class="mk-editbtn hv-mk-editbtn js-mk-editbtn">+添加</a>
    {*<div class="nomarks-text">有了标签，场地才能更容易被选中哦。<br>给我的场地贴标签</div>*}
    {*<a href="javascript:;" class="mk-editbtn no-mk-editbtn js-mk-editbtn">+添加</a>*}
</div>
{*<div class="recommended-marks">*}
{*<h2>推荐标签</h2>*}
{*<ul class="mk-edit clearfix">*}
{*<li>秀场速度快放假</li>*}
{*<li>秀场速度放假</li>*}
{*<li>秀放假</li>*}
{*<li>快放假</li>*}
{*<li>秀场速度快放假</li>*}
{*</ul>*}
{*</div>*}

<div class="fill-fot-btn clearfix hide dmd-delt-btn">
    <button class="form-sbt bg-orange js-delt-submit">删除</button>
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
        请填写标签名称，最长10个汉字
    </p>

    <div class="addmarks-text">
        <input class="addmarks-text-ipt" type="text">
    </div>
    <div class="btn-wrap">
        <a class="fl btn btn-no js-close" href="javascript:;">取消</a>
        <a class="fr btn btn-yes js-yesaddmark js-close" href="javascript:;">确认</a>
    </div>
</div>

<!--标签删除确认弹窗-->
<div class="jud-rej js-pop-dltmarks hide js-pop-cont">
    <p class="quote-bg-wrt">
        部分标签已删除，确认删除
    </p>

    <div class="btn-wrap">
        <a class="btn btn-no fl js-close" href="javascript:;">取消</a>
        <a class="btn btn-yes fr js-close js-deltmarks" href="javascript:;">确认</a>
    </div>
</div>

<div class="marks-choice js-marks-choice hide js-pop-cont">
    <h1>活动方需求关键词</h1>
    <ul class="mk-edit clearfix">
        <li>秀场速度快放假<span class="icon-cg"></span></li>
        <li>秀场速度放假<span class="icon-cg"></span></li>
        <li>秀放假<span class="icon-cg"></span></li>
        <li>快放假<span class="icon-cg"></span></li>
        <li>秀场速度快放假<span class="icon-cg"></span></li>
    </ul>
    <p>勾选你有的推荐给您的会更匹配哦</p>

    <div class="step-btn">
        <button class="next-step-btn js-close">确定</button>
    </div>
</div>
<script>
    $(window).load(function () {
        $(".js-marks-choice").fadeIn().after('<div class="popup_bg"></div>');
    });
    $(".js-yesaddmark").click(function () {
        var iptinner = $(".addmarks-text-ipt").val();
        //添加标签
        if (iptinner) {
            $(".addmarks-text-ipt").val('');
            $(".dmd-tend-my .mk-edit").append("<li >" + iptinner + "<span class='icon-cg'></span>" + "</li>");
            $(".no-mk-editbtn").removeClass("no-mk-editbtn").addClass("hv-mk-editbtn");
        }
        ;
    });
</script>
</body>
{static "core/yunspace.js"}
{static 'demand_offer.v2.0/demand_offer_operation.js'}
{static "demand_offer.v2.0/pop.js"}
</html>