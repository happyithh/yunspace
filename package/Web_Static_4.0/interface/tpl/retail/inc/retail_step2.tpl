<div class="form-body none step2-form">
    <div id="text"></div>
    <p class="step2-t">基本信息</p>
    <div class="form-group">
        <ul class="step1-show clearfix">
            <li>所需城市 - <code _data="retail::city"></code></li>
            <li>所需区域 - <code _data="retail::area"></code></li>
            <li>场地分类 - <code _data="retail::cate"></code></li>
            <li>位置要求 - <code _data="retail::address"></code></li>
            <li>客户人群 - <code _data="retail::guest"></code></li>
        </ul>
    </div>
    <p class="step2-t">联系方式&nbsp;<code>(必填)</code></p>
    <div class="form-group">
        <div class="form-input clearfix">
            <label class="fl"><code>*&nbsp;</code>公司名称</label>
            <input type="text" name="" class="fl company" placeholder="请填写您的所在公司">
            <span class="tips fl">例:上海*****公司</span>
            <span class="error fl none">此项不能为空</span>
        </div>
        <div class="form-input clearfix">
            <label class="fl"><code>*&nbsp;</code>您的称呼</label>
            <input type="text" name="" class="fl username" placeholder="请填写您的真实姓名">
            <span class="tips fl">保证姓名的真实性,方便客服与您联系</span>
            <span class="error fl none">此项不能为空</span>
        </div>
        <div class="form-input clearfix">
            <label class="fl"><code>*&nbsp;</code>手机号码</label>
            <input type="text" name="" class="fl phone" placeholder="请填写您的手机号码">
            <span class="tips fl">手机号(仅支持中国大陆)</span>
            <span class="error fl none">请输入有效的手机号码</span>
        </div>
    </div>
    <p class="step2-t">补充条件&nbsp;<code style="color:#999999;font-size:12px;">(可选填)</code></p>
    <div class="form-group">
        <p class="label">目标客群</p>
        <ul class="tag clearfix guest_type_select">
            <li>商务</li>
            <li>白领</li>
            <li>家庭</li>
            <li>学生</li>
            <li>其他</li>
        </ul>
    </div>
    <div class="form-group">
        <p class="label">产品类型&nbsp;</p>
        <ul class="form-group-list">
            <li class="clearfix">
                <input type="hidden" data-type="快闪店/体验店" class="final-data">
                <div class="input-label fl">
                    快闪店/体验店
                </div>
                <div class="input-body fl">
                    <span class="fl">数量</span>
                    <div class="input fl">
                        <input type="text" class="num" placeholder="如:10-100">/个
                    </div>
                </div>
                <div class="input-body fl">
                    <span class="fl">预算</span>
                    <div class="input fl">
                        <input type="text" class="price" placeholder="如:10-100">/万
                    </div>
                </div>
                <div class="input-body fl">
                    <span class="fl">面积</span>
                    <div class="input fl input-drop">
                        <span class="square placeholder">请选择</span>/m<sup>2</sup>
                        <ul class="drop-list">
                            <li data-p="<10">小于10</li>
                            <li data-p="10-50">10-50</li>
                            <li data-p="50-100">50-100</li>
                            <li data-p="100-300">100-300</li>
                            <li data-p=">300">300以上</li>
                        </ul>
                    </div>
                </div>
                <div class="input-body fl">
                    <span class="fl">层高</span>
                    <div class="input fl input-drop">
                        <span class="floor placeholder">请选择</span>/m
                        <ul class="drop-list">
                            <li data-p="4">4m以内</li>
                            <li data-p="5">5m以内</li>
                            <li data-p="6">6m以内</li>
                            <li data-p=">6">6m以上</li>
                        </ul>
                    </div>
                </div>
            </li>
            <li class="clearfix">
                <input type="hidden" data-type="BP点(售卖机/展示点)" class="final-data">
                <div class="input-label fl">
                    DP点(售卖机/展示点)
                </div>
                <div class="input-body fl">
                    <span class="fl">数量</span>
                    <div class="input fl">
                        <input type="text" class="num" placeholder="如:10-100">/个
                    </div>
                </div>
                <div class="input-body fl">
                    <span class="fl">预算</span>
                    <div class="input fl">
                        <input type="text" class="price" placeholder="如:10-100">/万
                    </div>
                </div>
                <div class="input-body fl">
                    <span class="fl">面积</span>
                    <div class="input fl input-drop">
                        <span class="square placeholder">请选择</span>/m<sup>2</sup>
                        <ul class="drop-list">
                            <li data-p="<10">小于10</li>
                            <li data-p="10-50">10-50</li>
                            <li data-p="50-100">50-100</li>
                            <li data-p="100-300">100-300</li>
                            <li data-p=">300">300以上</li>
                        </ul>
                    </div>
                </div>
                <div class="input-body fl">
                    <span class="fl">层高</span>
                    <div class="input fl input-drop">
                        <span class="floor placeholder">请选择</span>/m
                        <ul class="drop-list">
                            <li data-p="4">4m以内</li>
                            <li data-p="5">5m以内</li>
                            <li data-p="6">6m以内</li>
                            <li data-p=">6">6m以上</li>
                        </ul>
                    </div>
                </div>
            </li>
            <li class="clearfix">
                <input type="hidden" data-type="品牌特卖" class="final-data">
                <div class="input-label fl">
                    品牌特卖
                </div>
                <div class="input-body fl">
                    <span class="fl">数量</span>
                    <div class="input fl">
                        <input type="text" class="num" placeholder="如:10-100">/个
                    </div>
                </div>
                <div class="input-body fl">
                    <span class="fl">预算</span>
                    <div class="input fl">
                        <input type="text" class="price" placeholder="如:10-100">/万
                    </div>
                </div>
                <div class="input-body fl">
                    <span class="fl">面积</span>
                    <div class="input fl input-drop">
                        <span class="square placeholder">请选择</span>/m<sup>2</sup>
                        <ul class="drop-list">
                            <li data-p="<10">小于10</li>
                            <li data-p="10-50">10-50</li>
                            <li data-p="50-100">50-100</li>
                            <li data-p="100-300">100-300</li>
                            <li data-p=">300">300以上</li>
                        </ul>
                    </div>
                </div>
                <div class="input-body fl">
                    <span class="fl">层高</span>
                    <div class="input fl input-drop">
                        <span class="floor placeholder">请选择</span>/m
                        <ul class="drop-list">
                            <li data-p="4">4m以内</li>
                            <li data-p="5">5m以内</li>
                            <li data-p="6">6m以内</li>
                            <li data-p=">6">6m以上</li>
                        </ul>
                    </div>
                </div>
            </li>
            <li class="clearfix">
                <input type="hidden" data-type="店中店" class="final-data">
                <div class="input-label fl">
                    店中店
                </div>
                <div class="input-body fl">
                    <span class="fl">数量</span>
                    <div class="input fl">
                        <input type="text" class="num" placeholder="如:10-100">/个
                    </div>
                </div>
                <div class="input-body fl">
                    <span class="fl">预算</span>
                    <div class="input fl">
                        <input type="text" class="price" placeholder="如:10-100">/万
                    </div>
                </div>
                <div class="input-body fl">
                    <span class="fl">面积</span>
                    <div class="input fl input-drop">
                        <span class="square placeholder">请选择</span>/m<sup>2</sup>
                        <ul class="drop-list">
                            <li data-p="<10">小于10</li>
                            <li data-p="10-50">10-50</li>
                            <li data-p="50-100">50-100</li>
                            <li data-p="100-300">100-300</li>
                            <li data-p=">300">300以上</li>
                        </ul>
                    </div>
                </div>
                <div class="input-body fl">
                    <span class="fl">层高</span>
                    <div class="input fl input-drop">
                        <span class="floor placeholder">请选择</span>/m
                        <ul class="drop-list">
                            <li data-p="4">4m以内</li>
                            <li data-p="5">5m以内</li>
                            <li data-p="6">6m以内</li>
                            <li data-p=">6">6m以上</li>
                        </ul>
                    </div>
                </div>
            </li>
            <li class="clearfix">
                <input type="hidden" data-type="其他" class="final-data">
                <div class="input-label fl">
                    其他
                </div>
                <div class="input-body">
                    <input type="text" class="other-pro-type" placeholder="请输入您的产品类型,数量,预算,面积,层高">
                </div>
            </li>
        </ul>
    </div>
    <div class="form-group">
        <p class="label">档期周期</p>
        <ul class="tag clearfix calendar_select">
            <li>一个月内</li>
            <li>1-3个月</li>
            <li>3-6个月</li>
            <li>6个月以上</li>
        </ul>
    </div>
    <div class="form-group">
        <p class="label">装置尺寸</p>
        <div class="input-body2-all clearfix device">
            <div class="input-body2 fl">
                <label class="fl">长*高*宽</label>
                <div class="input fl">
                    <input type="text" class="fl device_size" placeholder="如:40*50*80">/m
                </div>
            </div>
            <div class="input-body2 fl">
                <label class="fl">用电功率</label>
                <div class="input fl">
                    <input type="text" class="fl device_power" placeholder="如:10-1000">/w
                </div>
            </div>
            <div class="input-body2 fl">
                <label class="fl">上下水</label>
                <div class="input fl" style="line-height:25px;">
                    <input type="text" class="fl device_sx" placeholder="如:10-1000">/m<sup>3</sup>
                </div>
            </div>
        </div>

    </div>
    <div class="form-group">
        <p class="label">其他要求</p>
        <ul class="tag clearfix other_select">
            <li>搭建</li>
            <li>舞台</li>
            <li>用餐</li>
            <li>报批</li>
            <li>媒体设备</li>
            <li>演员</li>
            <li>促销员</li>
            <li>安保</li>
            <li>保洁</li>
            <li>电源(所需电量)</li>
            <li>上下水</li>
            <li>POS机</li>
            <li>网络(WIFI)</li>
            <li>库房(面积)</li>
            <li>补货</li>
            <li>运维(含场地协调)</li>
            <li>背景板</li>
            <li>桁架</li>
            <li>VIP休息室</li>
            <li>座椅</li>
            <li>发电车</li>
            <li>摇臂</li>
            <li>游机</li>
            <li>摄影师</li>
            <span class="tip">（可多选）</span>
        </ul>
    </div>
    <button class="next-step to-step3">提交</button>
    <a href="javascript:;" class="to-pre"><<返回上一步</a>
</div>