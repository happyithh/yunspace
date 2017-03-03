<!DOCTYPE html>
<html>
<head lang="en">
    {include "Web_Mobile_Static::v1.0/head_meta.tpl"}
    {static "v1.0/global.css"}
    {static "grab_order.v2.0/grab.css"}
</head>
<body class="body-fff">
<div class="wrapper padding-bottom-68">
    <div class="filling-title clearfix">
        <a class="fl back" href=""></a>
        <h2 class="fl">完善场地信息</h2>
    </div>
    <div class="filling-cont-wrap">
        <div class="filling-cont">
            <div class="filling-select clearfix">
                <p class="icon icon-edt1"></p>
                <select>
                    <option>奢居会-8楼露台</option>
                    <option>奢居会-8楼露台</option>
                </select>
            </div>
            <div class="fill-ipt">
                <div class="ipt-wrp">
                    <p class="icon icon-edt3"></p>
                    <input type="text" name="contact" placeholder="请输入联系人名称"
                           value="{mb_substr($data[0]['contacts'],0,4,'utf-8')}">
                </div>
                <div class="ipt-wrp">
                    <p class="icon icon-edt4"></p>
                    <input type="number" name='contact_phone' placeholder="请输入联系手机" value="{$data[0]['phone']}">
                </div>
                <div class="ipt-wrp">
                    <p class="icon icon-edt-people"></p>
                    <input placeholder="请输入需求报价" value="50-100人"/>
                </div>
                <div class="ipt-wrp">
                    <p class="icon icon-edt5"></p>
                    <input type="number" name="quote"
                           placeholder="请输入需求报价"/>
                    <div class="total-selt">
                        <span class="jiao"></span>
                        <select name="quote-unit">
                            <option>总价</option>
                            <option>个</option>
                        </select>
                    </div>
                </div>
                <div class="filling-mkt clearfix">
                    <p class="icon icon-edt2"></p>
                    <div class="mkt" style='display: block;overflow:hidden;height:24px;'>
                        <span>文体娱乐</span>
                        <span>秀场展馆</span>
                        <span>文体娱乐</span>
                        <span>秀场展馆</span>
                        <span>文体娱乐</span>
                        <span>秀场展馆</span>
                        {*<p>为场地打个特色标签吧</p>*}
                    </div>
                    <p class="ellipsis">…</p>
                    <a class="icon-in" href=""></a>
                </div>
            </div>
        </div>
    </div><!--filling-cont-wrap-end-->
    <p class="hint">信息审核通过后，可得30积分哦！</p>
    <div class="fill-fot-btn clearfix">
        <button class="fr form-sbt form-sbt-revise">确定</button>
    </div>
</div><!--wrapper-end-->
</body>
</html>