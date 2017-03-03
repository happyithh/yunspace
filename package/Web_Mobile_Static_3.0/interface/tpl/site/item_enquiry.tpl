<!DOCTYPE html>
<html lang="en">
<head>
    {include "Web_Mobile_Static::baike/inc.baike_head.tpl"}
    {static "product.v2.0/product_enquiry_h.css"}
    <link rel="stylesheet" href="plugins/Swiper-master/css/swiper.min.css">
    <link rel="stylesheet" href="plugins/ionicons-master/css/ionicons.min.css">
    {static "index.v2.0/data-picker.css"}
</head>
<body yun="product.v2.0/enquiry_h.js::init">
<div yun="hide-app/hide-app.js::isApp"></div>
<div class="content">


    <div class="enquiry-tab-body-eq">
        <div class="enquiry-con-header">
            预定场地
        </div>
        <div class="enquiry-con">
            <div class="enquiry-con-body ajax-form"  data-validate="true" >
                <!--场地相关信息-->
                <div class="enquiry-con-detail clearfix">
                    <div class="fl img">

                        {if !empty($spaceInfo['mobile_logo'])}
                            <img src="{Page_Site_Global::displayMedia($spaceInfo['mobile_logo'],'182','144')}"/>
                        {elseif empty($spaceInfo['mobile_logo']) && !empty($spaceInfo['logo'])}
                            <img src="{Page_Site_Global::displayMedia($spaceInfo['logo'],'182','144')}"/>
                        {else}
                            <img src="img/no_img.jpg"/>
                        {/if}
                        <span class="icon-intent"></span>
                    </div>
                    <div class="fl cont">
                        {if $spaceInfo['space_name']!=$itemInfo[0]['item_name']}
                        <h5>{$spaceInfo['space_name']}-{$itemInfo[0]['item_name']}</h5>
                        {else}
                        <h5>{$spaceInfo['space_name']}</h5>
                        {/if}
                        <div class="marks">
                            {if !empty($itemInfo[0]['tags_new'])}
                                {foreach $itemInfo[0]['tags_new'] as $v}
                            <span>{$v}</span>
                                {/foreach}
                            {/if}
                            <!--标签做限制，最多显示3个-->
                        </div>
                        <p class="adress">{$spaceInfo['city']}{$spaceInfo['addr']}</p>
                    </div>
                </div>
                <input type="hidden"  class="select" name="space_name" value="{$spaceInfo['space_name']}">
                <input type="hidden" class="select" name="item_name" value="{$itemInfo[0]['item_name']}">
                <input type="hidden"  class="select" name="item_id" value="{$itemInfo[0]['item_id']}">
                <div class="enquiry-con-input" yun="product.v2.0/enquiry_h.js::select@click" yun-select="2">
                    <div class="enquiry-con-input-name">
                        <span class="red">*</span>
                        <span>空间报价规格</span>
                        <span class="red">（必填）</span>
                    </div>
                    <div class="enquiry-con-input-con">
                        <input type="text" placeholder="请选择规格" readonly="readonly" UNSELECTABLE='true' class="select" name="item_price">
                        <span class="dropDown-icon ion-arrow-down-b"></span>
                    </div>
                </div>
                <div class="enquiry-con-input">
                    <div class="enquiry-con-input-name">
                        <span class="red">*</span>
                        <span>您的称呼</span>
                        <span class="red">（必填）</span>
                    </div>
                    <div class="enquiry-con-input-con">
                        <input type="text" placeholder="请输入您的真实姓名"  data-validate="true" data-error="请填写您的称呼"  yun="form-validate/form-validate.js::typeValidate@keyup" name="username" >
                    </div>
                </div>

                <div class="enquiry-con-input">
                    <div class="enquiry-con-input-name">
                        <span class="red">*</span>
                        <span>您的联系方式</span>
                        <span class="red">（必填）</span>
                    </div>
                    <div class="enquiry-con-input-con">
                        <input type="text" placeholder="请输入有效的11位手机号码"  yun="form-validate/form-validate.js::typeValidate@keyup" data-error="请填写11位的手机号码" data-length="11"
                               name="phone" yun-type="phone" class="phone3" yun-error="" yun-style="fontSize:25px,position:absolute,right:5px,line-height:30px,color:#ff0000" data-validate="true">
                    </div>
                </div>
                <div class="enquiry-con-input">
                    <div class="enquiry-con-input-name">
                        <span class="red">*</span>
                        <span>手机验证码</span>
                        <span class="red">（必填）</span>
                    </div>
                    <div class="enquiry-con-input-con">
                        <input type="text" id="look_price_code" name="code" yun-type="code" yun-phone=".phone3"  yun-error="" yun="form-validate/form-validate.js::typeValidate@keyup" data-error="请输入正确验证码" class="fill js-y-code" placeholder="请输入6位数验证码" data-validate="true" data-length="6">
                    </div>
                    <button type="button" class="get-code orange" yun-second="30" yun-phone=".phone3" yun="identify-code.v1.0/identify-code.v1.0.js::sendCode@click" >获取验证码</button>
                    {*<button type="button" class="get-code gray">重新发送（59）</button>*}
                </div>
                <!---活动城市--->
                <input type="hidden" name="city" value="{$spaceInfo['city']}">
                <div class="enquiry-con-input">
                    <div class="enquiry-con-input-name" yun="product.v2.0/enquiry_h.js::dateSelect@click">
                        <span>活动时间</span>
                    </div>
                    <div class="enquiry-con-input-con">
                        <input name="date_start" type="text" placeholder="开始日期" readonly="readonly" unselectable="on" style="width:33%;float: left" yun="product.v2.0/enquiry_h.js::dateSelect@click" class="datePicker"  data-validate="true" data-error="请填写完整的活动日期" >
                        <span style="float: left;width:15%;line-height: 30px;text-align: center">至</span>
                        <input name="date_end" type="text" placeholder="结束日期" readonly="readonly" unselectable="on" style="width:33%;float: left" yun="product.v2.0/enquiry_h.js::dateSelect@click" class="datePicker"  data-validate="true" data-error="请填写完整的活动日期" >
                        <div class="clear"></div>
                    </div>
                </div>

                <div class="enquiry-con-input"  yun="product.v2.0/enquiry_h.js::select@click" yun-select="0">
                    <div class="enquiry-con-input-name">
                        <span>活动人数</span>
                    </div>
                    <div class="enquiry-con-input-con">
                        <input type="text" placeholder="请选择活动人数" readonly="readonly" unselectable="on"  name="people" class="select">
                        <span class="dropDown-icon ion-arrow-down-b"></span>
                    </div>
                </div>
                <div class="enquiry-con-input" yun="product.v2.0/enquiry_h.js::select@click" yun-select="1">
                    <div class="enquiry-con-input-name">
                        <span>活动类型</span>
                    </div>
                    <div class="enquiry-con-input-con">
                        <input type="text" placeholder="请选择活动类型" readonly="readonly" unselectable="on"  class="select" name="date_activity">
                        <span class="dropDown-icon ion-arrow-down-b"></span>
                    </div>
                </div>

                <div class="enquiry-con-input js-other-asks">
                    <div class="enquiry-con-input-name">
                        <span>其他要求:</span>
                        <span class="red">（可多选）</span>
                    </div>
                    <div class="enquiry-con-input-con">
                        <textarea readonly="readonly" unselectable="on" class="other-asks-fill" placeholder="请选择其他要求"
                                 name="other_demand" style="width:95%;border: 0px;border-radius: 0px;"></textarea>
                        <span class="dropDown-icon ion-arrow-down-b"></span>
                    </div>
                </div>

                <div class="enquiry-con-input">
                    <div class="enquiry-con-input-name">
                        <span>补充要求</span>
                    </div>
                    <div class="enquiry-con-input-con">
                        <textarea placeholder="请详细填写具体要求，方便系统及时快速适配！" name="content" data-error="请填写活动需求"
                                  style="width:95%;border: 0px;border-radius: 0px;"></textarea>
                        {*<input type="text" placeholder="请填写更多的详细信息，帮助您快速找到合适的场地" name="content" data-validate="true" data-error="请填写活动需求">*}
                    </div>
                </div>

                <input type="text" class="price-look"/>
            </div>
        </div>
    </div>

    {*<div class="enquiry-tab-body-eq" >*}
    <div class="enquiry-tab-body-eq none">
        <div class="enquiry-con"style="padding: 0px;">
            {*ion-checkmark enquiry-li-check-active*}
            <div class="enquiry-li none">
                <input type="text" class="enquiry-checked none">
                <div class="enquiry-li-check fl">
                    <span class="check-cir ion-checkmark enquiry-li-check-active"></span>
                </div>
                <div class="enquiry-li-p fl">
                    <span></span>
                </div>
                <div class="enquiry-li-delete">
                    <span>删除</span>
                </div>
            </div>
        </div>
        {*<div class="enquiry-btn">*}
        {*<button>一键询价</button>*}
        {*</div>*}
    </div>
    {*</div>*}

    <div class="enquiry-btn">
        <button yun="form-validate/form-validate.js::ajaxSubmit@click" yun-url="demand/create.jsonp" yun-ajax="demand_new"
                yun-error=".d-s-error" yun-form=".ajax-form" data-id="0" class="demand-submit-btn">提交</button>
    </div>
    {*input选项*}
    <div class="cover1 none"></div>

    <div class="show-select-list none">
        <div class="show-select-li">50人以下</div>
        <div class="show-select-li">50-100人</div>
        <div class="show-select-li">100-300人</div>
        <div class="show-select-li">300-500人</div>
        <div class="show-select-li">500人以上</div>
    </div>
    <div class="show-select-list none">
        {if !empty($active)}
            {foreach $active as $v}
                <div class="show-select-li">{$v}</div>
            {/foreach}
        {/if}
    </div>
    <div class="show-select-list none">
        {if !empty($itemInfo)}
            {foreach $itemInfo as $k=>$v}
                {if !empty($v['discount_price'])}
                    <div class="show-select-li">{$v['standard']}&nbsp; ￥{$v['discount_price']}{$v['price_unit']}</div>
                {else}
                    <div class="show-select-li">面议</div>
                {/if}
            {/foreach}
        {/if}
        {*<div class="show-select-li">平日&nbsp; ￥8000/天</div>*}
        {*<div class="show-select-li">搭建&nbsp; ￥7000/天</div>*}
        {*<div class="show-select-li">常规&nbsp; ￥20000/天</div>*}
    </div>
    <div class="show-select-list-cont none">
        <ul class="ul-asks clearfix">
            <li>
                <div class="icon-h"><img src="img/intent/icon-asks1.png"></div>
                <p>搭建</p>
            </li>
            <li>
                <div class="icon-h"><img src="img/intent/icon-asks2.png"></div>
                <p>搭建舞台</p>
            </li>
            <li>
                <div class="icon-h"><img src="img/intent/icon-asks3.png"></div>
                <p>用餐报批</p>
            </li>
            <li>
                <div class="icon-h"><img src="img/intent/icon-asks4.png"></div>
                <p>媒体设备</p>
            </li>
            <li>
                <div class="icon-h"><img src="img/intent/icon-asks5.png"></div>
                <p>演员</p>
            </li>
            <li>
                <div class="icon-h"><img src="img/intent/icon-asks6.png"></div>
                <p>背景板</p>
            </li>
            <li>
                <div class="icon-h"><img src="img/intent/icon-asks7.png"></div>
                <p>桁架</p>
            </li>
            <li>
                <div class="icon-h"><img src="img/intent/icon-asks8.png"></div>
                <p>VIP休息室</p>
            </li>
            <li>
                <div class="icon-h"><img src="img/intent/icon-asks9.png"></div>
                <p>座椅</p>
            </li>
            <li>
                <div class="icon-h"><img src="img/intent/icon-asks10.png"></div>
                <p>发电车</p>
            </li>
            <li>
                <div class="icon-h"><img src="img/intent/icon-asks11.png"></div>
                <p>安保保洁</p>
            </li>
            <li>
                <div class="icon-h"><img src="img/intent/icon-asks12.png"></div>
                <p>摇臂游机</p>
            </li>
            <li>
                <div class="icon-h"><img src="img/intent/icon-asks13.png"></div>
                <p>摄影师</p>
            </li>
            <li>
                <div class="icon-h"><img src="img/intent/icon-asks14.png"></div>
                <p>摄像师</p>
            </li>
        </ul>
        <div class="asks-btn-wrap">
            <button class="asks-btn js-asks-btn">确定</button>
        </div>
    </div>

    <div class="error-all none">
        <span>用户名必须填写</span>
    </div>

    <div class="date none">
        <div yun="data-picker/js/date-picker.js::initPlugin" class="date-picker" yun-input=".datePicker"
             yun-with-input="false"></div>
    </div>

</div>

<script src="plugins/Swiper-master/js/swiper.min.js"></script>
<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=aaNCRRcGGai6klHMOGZ8yBbP"></script>
{static "v1.0/jquery-1.11.1.min.js"}
{static "core/yunspace.js"}
</body>
</html>