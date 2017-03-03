<div class="step2 none">
    <div class='form-model'>
        <header>基本信息</header>
        <ul class="show-info">
            <li>所需城市 - <span _data="retail::city"></span></li>
            <li>所需区域 - <span _data="retail::area"></span></li>
            <li>场地分类 - <span _data="retail::cate"></span></li>
            <li>落位区域 - <span _data="retail::address"></span></li>
            <li>客户人群 - <span _data="retail::guest"></span></li>
        </ul>
    </div>
    <div class='form-model'>
        <header>联系方式 <small style="color:#f00;font-size: 12px;">(必填)</small></header>
        <ul class="chat">
            <li class="clearfix">
                <span class="title"><i>*&nbsp;</i>公司名称</span>
                {*<span class="error"><i class="fa fa-exclamation-circle" aria-hidden="true"></i>&nbsp;&nbsp;此项不能为空</span>*}
                <input type="text" placeholder="请填写您的所在公司" id="company"/>
            </li>
            <li class="clearfix">
                <span class="title"><i>*&nbsp;</i>您的姓名</span>
                {*<span class="error"><i class="fa fa-exclamation-circle" aria-hidden="true"></i>&nbsp;&nbsp;此项不能为空</span>*}
                <input type="text" placeholder="请填写您的真实姓名" id="username"/>
            </li>
            <li class="clearfix">
                <span class="title"><i>*&nbsp;</i>手机号码</span>
                {*<span class="error"><i class="fa fa-exclamation-circle" aria-hidden="true"></i>&nbsp;&nbsp;请填写正确的手机号码格式</span>*}
                <input type="text" placeholder="请填写您的手机号码" id="phone"/>
            </li>
        </ul>
    </div>
    <div class='form-model'>
        <header>补充条件 <small style="color:#999999;font-size: 12px;">(可选填)</small></header>
        <ul class="other">
            <li class="clearfix">
                <span>目标客群&nbsp;<i class="fa fa-chevron-down" aria-hidden="true"></i></span>
                <select name="" id="guest">
                    <option disabled selected value="">请选择</option>
                    <option value="商务">商务</option>
                    <option value="白领">白领</option>
                    <option value="家庭">家庭</option>
                    <option value="学生">学生</option>
                    <option value="其他">其他</option>
                </select>
                <ul class="show_selected clearfix none">

                </ul>
            </li>
            <li class="clearfix">
                <span>产品类型</span>
                <div>
                    <p class="title">你需要的类型</p>
                    <textarea type="text" placeholder="请输入关键信息,包括店铺类型(showroom、快闪店、集合店、点中店，DP店）、开店预算、面积、层高。" id="need-type"></textarea>
                </div>
            </li>
            <li class="clearfix">
                <span>档期周期&nbsp;<i class="fa fa-chevron-down" aria-hidden="true"></i></span>
                <select name="" id="time-during">
                    <option disabled selected value="">请选择</option>
                    <option value="1个月内">1个月内</option>
                    <option value="1-3个月">1-3个月</option>
                    <option value="3-6月">3-6月</option>
                    <option value="6个月以上">6个月以上</option>
                </select>
                <ul class="show_selected clearfix none">
                </ul>
            </li>
            <li class="clearfix">
                <span>其他要求&nbsp;<i class="fa fa-chevron-down" aria-hidden="true"></i></span>
                <select name="" id="other-demand" multiple>
                    <option disabled value="">(可多选)</option>
                    <option value="搭建">搭建</option>
                    <option value="舞台">舞台</option>
                    <option value="用餐">用餐</option>
                    <option value="报批">报批</option>
                    <option value="媒体设备">媒体设备</option>
                    <option value="演员">演员</option>
                    <option value="促销员">促销员</option>
                    <option value="安保">安保</option>
                    <option value="保洁">保洁</option>
                    <option value="电源(所需电量)">电源(所需电量)</option>
                    <option value="上下水">上下水</option>
                    <option value="POS机">POS机</option>
                    <option value="网络(wifi)">网络(wifi)</option>
                    <option value="库房(面积)">库房(面积)</option>
                    <option value="补货">补货</option>
                    <option value="运维(含场地协调)">运维(含场地协调)</option>
                    <option value="背景板">背景板</option>
                    <option value="桁架">桁架</option>
                    <option value="VIP休息室">VIP休息室</option>
                    <option value="座椅">座椅</option>
                    <option value="发电车">发电车</option>
                    <option value="摇臂">摇臂</option>
                    <option value="游机">游机</option>
                    <option value="摄影师">摄影师</option>
                </select>
                <ul class="show_selected clearfix none">
                </ul>
            </li>
        </ul>
    </div>
    <button class="sub-step submit-step-two">提交</button>
</div>