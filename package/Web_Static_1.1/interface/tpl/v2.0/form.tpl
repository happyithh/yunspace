<div class="cover-body hide"></div>



<div class="demand-body demand-one">
    <div class="demand-close"><span class="ion-close"></span></div>
    <div style="position: relative;height:100%">

        <div class="demand-submit">
            {*<form action=""  data-validate="true"  yun="form-validate/form-validate.js::formSubmit" yun-error=".d-s-error">*}
            <div class="ajax-form"  data-validate="true" >
                <div class="d-s-body">
                    <div class="d-s-form" style="position: absolute;top:0px;width:50%;left:25%">
                        <div class="d-s-title">
                            我要办活动
                        </div>
                        <div class="clear"></div>
                    </div>
                    <div class="show-demand" style="margin-bottom: 55px;margin-top:50px;">

                        {*<div class="demand-full demand-first">*}
                        <div class="d-s-form" style="color:#999999;font-size:12px;margin:10px 0px;">
                            留下你的联系方式
                        </div>
                        {*<input type="hidden" name="demand_city" value="{$_REQUEST['cities'][$_COOKIE['city_key']]}" />*}
                        <div class="d-s-form">
                            <div class="d-s-name"><i style="color:#ff0000;width: 19px;display: inline-block">*</i>您的称呼</div>
                            <div class="d-s-input">
                                <input type="text" data-validate="true" data-error="请填写您的称呼"  yun="form-validate/form-validate.js::typeValidate@keyup" name="username" placeholder="请填写您的称呼"/>
                            </div>
                            <div class="clear"></div>
                        </div>
                        <div class="d-s-form">
                            <div class="d-s-name"><i style="color:#ff0000;width: 19px;display: inline-block">*</i>手机号码</div>
                            <div class="d-s-input">
                                <input type="text" yun="form-validate/form-validate.js::typeValidate@keyup" data-error="请填写11位的手机号码" data-length="11" placeholder="请填写11位的手机号码"
                                       name="phone"     yun-type="phone"  yun-error="" yun-style="fontSize:25px,position:absolute,right:5px,line-height:30px,color:#ff0000" data-validate="true" class="js-formoninput phone3"/>
                            </div>
                            <div class="clear"></div>
                        </div>
                        <div class="d-s-form look-more hide">
                            <div class="d-s-name"><i style="color:#ff0000;width: 19px;display: inline-block">*</i>手机验证码</div>
                            <div class="d-s-input">
                                <input type="text" id="look_price_code" name="code"   yun-error=""  yun-phone=".phone3" yun-type="code" class="fill js-y-code" placeholder="请输入6位数验证码" yun="form-validate/form-validate.js::typeValidate@keyup" data-error="请输入6位验证码" data-validate="true" data-length="6">
                            </div>
                            <button type="button" class="get-code green" yun-second="30" yun-phone=".phone3" yun="identify-code.v1.0/identify-code.v1.0.js::sendCode@click" >获取验证码</button>
                            {*<button type="button" class="get-code gray">重新发送（59）</button>*}
                            <div class="clear"></div>
                        </div>

                        <div class="d-s-form">
                            <div class="d-s-name"><i style="width: 19px;display: inline-block"></i>活动城市</div>
                            <div class="d-s-input">
                                <input type="text" class="per-in hide select-input city-input" name="city" value="上海"/>
                                <div class="d-s-input-val select-click select4"><div style="font-size:14px;"  class="par4">上海</div><span class="ion-arrow-down-b p-r-icon" style="color:#c5c5c5"></span></div>
                                <span class="down"></span>
                                <div class="drop-down-home dropDown pre-range hide" style="background:rgba(255,255,255,1);z-index:12000!important;border-color: #c4c4c4 ;border-top:none;margin-left:-1px;"  data-drop="1">
                                    <ul>
                                        {foreach $_REQUEST['cities'] as $v}
                                            <li>{$v}</li>
                                        {/foreach}
                                    </ul>
                                </div>
                            </div>
                            <div class="clear"></div>
                        </div>
                        <div class="d-s-form">
                            <div class="d-s-name"><i style="width: 19px;display: inline-block"></i>活动人数</div>
                            <div class="d-s-input">
                                <input type="text" class="per-in hide select-input person-input" name="person_num" value="50-100人"/>
                                {*<input type="text" class="hide select-input place-input" data-validate="true" data-error="请将预算范围填写完整" name="pre_range"/>*}
                                <div class="d-s-input-val select-click select4"><div style="font-size:14px;"  class="par1">50-100人</div><span class="ion-arrow-down-b p-r-icon" style="color:#c5c5c5"></span></div>
                                <span class="down"></span>
                                <div class="drop-down-home dropDown pre-range hide" style="background:rgba(255,255,255,1);z-index:12000!important;border-color: #c4c4c4 ;border-top:none;margin-left:-1px;"  data-drop="1">
                                    <ul>
                                        <li>50人以下</li>
                                        <li>50-100人</li>
                                        <li>100-300人</li>
                                        <li>300-500人</li>
                                        <li>500人以上</li>
                                    </ul>
                                </div>
                            </div>
                            <div class="clear"></div>
                        </div>
                        <div class="d-s-form">
                            <div class="d-s-name"><i style="width: 19px;display: inline-block"></i>活动类型</div>
                            <div class="d-s-input">
                                {*<input type="text" data-validate="true" data-error="请填写活动类型" class="act-out" name="activity_name"/>*}
                                <input type="text" class="act-in hide select-input  cate-input" name="activity_name" value="路演/展览/发布会"/>
                                <div class="d-s-input-val select-click select4" style="z-index:1"><div style="font-size:14px"  class="par2">路演/展览/发布会</div><span class="ion-arrow-down-b p-r-icon"  style="color:#c5c5c5"></span></div>
                                <span class="down"></span>
                                <div class="drop-down-home dropDown pre-range hide" style="background:rgba(255,255,255,1);z-index:12000;border-color: #c4c4c4 ;border-top:none;margin-left:-1px;height:204px;"  data-drop="1">
                                    <ul>
                                        <li>派对/典礼/沙龙</li>
                                        <li>晚会/年会/演出</li>
                                        <li>路演/展览/发布会</li>
                                        <li>会议/讲座</li>
                                        <li>团建/拓展</li>
                                    </ul>
                                </div>
                            </div>
                            <div class="clear"></div>
                        </div>

                        <div class="d-s-form" style="margin-bottom: 0px;">
                            {*<div class="d-s-name"></div>*}
                            {*<div class="d-s-input" style="border: none;padding-left: 25%;">*}
                                {*<label>*}
                                    {*<input type="checkbox" name="demand_other_1" value="1" id ="demand_other_1"  checked='' class="check-protocol"  />*}
                                    {*30分钟实时报价(工作日)*}
                                {*</label>*}
                            {*</div>*}
                            {*<div class="d-s-input" style="border: none;padding-left: 25%">*}
                                {*<label>*}
                                    {*<input type="checkbox" name="demand_other_2" value="1" id ="demand_other_2"  checked='' class="check-protocol"  />*}
                                    {*场地方直接联系*}
                                {*</label>*}
                            {*</div>*}
                            {*<div class="d-s-input" style="border: none;padding-left: 25%">*}
                                {*<label>*}
                                    {*<input type="checkbox" name="demand_other_3" value="1" id ="demand_other_3"  checked='' class="check-protocol"  />*}
                                    {*需要场地*}
                                {*</label>*}
                            {*</div>*}
                            <div class="d-s-input" style="border: none;padding-left: 25%">
                                <label>
                                    <input style="width:14px;height:14px;padding:0;box-sizing: content-box;" type="checkbox" name="demand_other_4" value="1" id ="demand_other_4"  checked='' class="check-protocol"  />
                                    <span>还需要其他的供应商服务</span>
                                </label>
                            </div>
                            <div class="clear"></div>
                        </div>
                        <div class="d-s-form" style="margin-bottom: 0px;">
                            <div class="d-s-error">
                            </div>
                            <div class="clear"></div>
                        </div>

                        <div class="d-s-form" style="height: 130px;width: 100%;margin-left: 40px;">
                            <div class="form-coder" style="width: 35%">
                                <img src="img/home.v3.0/space_fwh.jpg" alt="">
                            </div>
                            <div class="form-coder" style="width: 60%;">
                                <p>举起手机，扫一扫关注<br/><b>云·SPACE</b>微信公众号<br/>随时随地获取方案。</p>
                            </div>
                        </div>

                        {*</div>*}
                    </div>

                    <div class="d-s-form bottom-submit" style="margin-top: 20px;position: absolute;bottom:-5px;width:70%;left:50%;margin-left:-35%;">
                        <div class="d-s-button" style="width:100%">
                            <button yun="form-validate/form-validate.js::ajaxSubmit@click" yun-url="demand/create.jsonp" yun-ajax="demand"
                                    yun-error=".d-s-error" yun-form=".ajax-form" data-id="0" class="demand-submit-btn">提交</button>
                        </div>
                        <div class="clear"></div>
                    </div>
                </div>
                {*</form>*}
            </div>
        </div>
    </div>
</div>

<div class="demand-body demand-two" style="top:-130%;">
    <div class="demand-close"><span class="ion-close"></span></div>
    <div style="position: relative;height:100%">
        <div class="demand-submit">
            {*<form action=""  data-validate="true"  yun="form-validate/form-validate.js::formSubmit" yun-error=".d-s-error">*}
            <div class="ajax-form"  data-validate="true" style="height:450px;ajax-form">
                <div class="d-s-body" style="height:330px;">
                    <div class="d-s-form" style="position: absolute;top:0px;width:50%;left:25%">
                        <div class="d-s-title" style="color:#06e1e1">
                            <span class="ion-ios-lightbulb-outline" style="font-size: 25px;"></span>&nbsp;&nbsp;提交成功
                        </div>

                        <div class="clear"></div>
                    </div>
                    {*<div class="d-s-form submit-text"  style="color:#999999;font-size:12px;margin:20px 0px;margin-top: 50px;">*}
                        {*请完善您的活动信息，云·SPACE场地报价系统将在 <span style="color:#59ebeb;font-size:13px;">30分钟内</span>为您提供多份精准场地报价*}
                    {*</div>*}
                    <div class="show-demand show2" style="margin-bottom: 70px;margin-top:20px;padding-top: 20px;height: 400px;">
                        {*<iframe src="" style="border: 0px; width:100%;height:100%" class="iframe" id="home-frame" name="home-frame">*}
                        {*</iframe>*}
                    </div>
                    <div class="d-s-form bottom-submit  bottom-submit2" style="margin-top: 20px;position: absolute;bottom:0px;width:100%;left:0px;">
                        <div class="d-s-button" style="width:100%;padding-left: 10%">
                            <button yun="form-validate/form-validate.js::ajaxSubmit@click" yun-url="demand/create.jsonp" yun-ajax="demand_next" style="width:50%;float:left;margin-left:15%"
                                    class="demand-ok"
                                    yun-error=".d-s-error" yun-form=".ajax-form" data-id="2">确认</button>
                        </div>
                        <div class="clear"></div>
                    </div>
                </div>
                {*</form>*}
            </div>
        </div>
    </div>
</div>
{static "v3.0/header.v3.0.js"}
{*<script type="text/javascript" src="js/v3.0/header.v3.0.js"></script>*}