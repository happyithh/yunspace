<div class="form-body none">
    <div class="step-success">
        <p class="tip-success">提交成功</p>
        <p class="tip-p" style="line-height: 26px;">
            {if $is_work_time}
                您的需求已提交成功,系统将会为你匹配场地&场景,，30分钟之内会有工作人员与你联系。
            {else}
                您的需求已提交成功,系统将会为你匹配场地&场景,，待工作时间会有工作人员与你联系，请保持通讯正常 <br />我们工作时间是周一至周五 9：00-18：00
            {/if}
        </p>
    </div>
    <p class="step2-t">需求信息</p>
    <div class="form-group">
        <p class="label info">基本信息</p>
        <ul class="step1-show clearfix info-list">
            <li>所需城市 - <code _data="retail::city"></code></li>
            <li>所需区域 - <code _data="retail::area"></code></li>
            <li>场地类型 - <code _data="retail::cate"></code></li>
            <li>落位区域 - <code _data="retail::address"></code></li>
            <li>商业客流 - <code _data="retail::guest"></code></li>
        </ul>
        <p class="label info">联系方式</p>
        <ul class="step1-show clearfix info-list">
            <li>公司名称 - <code _data="retail::company"></code></li>
            <li>您的称呼 - <code _data="retail::username"></code></li>
            <li>手机号码 - <code _data="retail::phone"></code></li>
        </ul>
        <p class="label info">补充条件</p>
        <ul class="step1-show clearfix info-list">
            <li>目标客群 - <code _data="retail::guest_type">无</code></li>
            <li>档期周期 - <code _data="retail::calender">无</code></li>
            {*<li>空间层高 - <code _data="retail::floor"></code></li>*}
            <li>装置尺寸 - <code _data="retail::device_size">无</code></li>
            {*<li>购物中心标签 - <code _data="retail::shopping_code"></code></li>*}
            <li>产品类型 - <code _data="retail::produce_type">无</code></li>
            <li>其他要求 - <code _data="retail::other_demand">无</code></li>
        </ul>
    </div>
</div>