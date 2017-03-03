<div class="fl clearfix">
    <div class="no-result-head">
        <p><img src="img/noresult-logo.jpg"></p>

        <p>{if {htmlspecialchars($_REQUEST['keyword'])}}没有找到关于<span>“{htmlspecialchars($_REQUEST['keyword'])}“</span>的相关信息{else}本栏目下暂时没有相关信息{/if}，我们为您推荐一下信息。<br>
            可以登记您的需求，我们会尽快帮您找到合适的场地或服务。</p>
    </div>
    <div class="no-result-form">
        {*<div class="no-result-form-c">*}
            {*<div class="no-r-form-l" style="margin-top: 5px;">需求类型</div>*}
            {*<div class="no-r-form-r" style="margin-top: 8px;">*}

                    {*<label class="radio-inline" style="font-size: 12px; color: #666; margin-right: 28px;">*}
                        {*<input type="radio" name="data[state]" value="空间场地" checked="" style="margin-top: 3px;">*}
                        {*空间场地*}
                    {*</label>*}
                    {*<label class="radio-inline" style="font-size: 12px; color: #666; margin-right: 28px;">*}
                        {*<input type="radio" name="data[state]" value="配套服务" style="margin-top: 3px;">*}
                        {*配套服务*}
                    {*</label>*}
                    {*<label class="radio-inline" style="font-size: 12px; color: #666;">*}
                        {*<input type="radio" name="data[state]" value="超值套餐" style="margin-top: 3px;">*}
                        {*超值套餐*}
                    {*</label>*}
            {*</div>*}
            {*<div class="clear"></div>*}
        {*</div>*}
        <div class="no-result-form-c">
            <div class="no-r-form-l">您的称呼</div>
            <div class="no-r-form-r">
                <input type="text"  name="username" class="no-result-form-input"  placeholder="请填写您的称呼">
            </div>
            <div class="clear"></div>
        </div>
        <div class="no-result-form-c">
            <div class="no-r-form-l">手机号码</div>
            <div class="no-r-form-r">
                <input type="text" name="phone" class="no-result-form-input" placeholder="请填写11位的手机号码">
            </div>
            <div class="clear"></div>
        </div>
        <div class="no-result-form-c">
            <div class="no-r-form-l">所在地区</div>
            <div class="no-r-form-r">
               <select class="no-result-form-input" id="select-city">
                   {foreach $_REQUEST['cities'] as $k=>$v}
                   <option>{$v}</option>
                   {/foreach}
                   {*<option>北京</option>*}
                   {*<option>广州</option>*}
                   {*<option>深圳</option>*}
                   {*<option>成都</option>*}
                   {*<option>杭州</option>*}
                   {*<option>南京</option>*}
                   {*<option>苏州</option>*}
               </select>
            </div>
            <div class="clear"></div>
        </div>
        <div class="no-result-form-c">
            <div class="no-r-form-l">活动人数</div>
            <div class="no-r-form-r">
                <select class="no-result-form-input" id="select-person">
                    <option>50人以下</option>
                    <option>50-100人</option>
                    <option>100-300人</option>
                    <option>300-500人</option>
                    <option>500人以上</option>
                </select>
            </div>
            <div class="clear"></div>
        </div>
        <div class="no-result-form-c">
            <div class="no-r-form-l">活动类型</div>
            <div class="no-r-form-r">
                <select class="no-result-form-input" id="select-activity">
                    <option >派对/典礼/沙龙</option>
                    <option>晚会/年会/演出</option>
                    <option>路演/展览/发布会</option>
                    <option>会议/讲座</option>
                    <option>团建/拓展</option>
                </select>
            </div>
            <div class="clear"></div>
        </div>
        {*<div class="no-result-form-c">*}
            {*<div class="no-r-form-l">需求描述</div>*}
            {*<div class="no-r-form-r">*}
                 {*<input type="text" class="no-result-form-input" placeholder="输入您的具体需求，我们会尽快为您配对场地！">*}
            {*</div>*}
            {*<div class="clear"></div>*}
        {*</div>*}
        <div class="no-result-form-c">
            <div class="d-s-input" style="border: none;padding-left: 25%">
                <label for="tnc" >
                    <input type="checkbox" name="demand_other" value="1" id ="demand_other"  checked='' class="check-protocol"  />
                    还需要其他的供应商服务
                </label>
            </div>
            <div class="clear"></div>
        </div>
        {*<div class="no-result-form-c">*}
            {*<div class="no-r-form-l">验证码</div>*}
            {*<div class="no-r-form-r">*}
                {*<input class="no-r-y-input" type="text">*}
                {*<button class="no-r-y-button">获取验证码</button>*}
                {*<div class="clear"></div>*}
            {*</div>*}
            {*<div class="clear"></div>*}

        {*</div>*}
        <div class="no-result-form-c error_msg" style="display: none;margin-bottom: 0;margin-left: 40px;">
        <p id="error" style="line-height: 25px;color:red;padding-left: 60px;"></p>
        </div>
        <div class="no-result-form-c">
            <button class="no-r-button submit_btn">提交</button>
        </div>
        <p class="btn-tishi">*请注意查收您的手机短信，我们会尽快为您推荐合适的场地或服务</p>
    </div>
    <div class="no-result-weixin">
        <p><img src="img/noresult-weixin.jpg"> </p>
        <p>举起手机，扫一扫关注云·SPACE微信公众号<br>
            随时随地获取方案。</p>
    </div>
    <div class="related">
        <div class="relate-title">相关推荐</div>
        <ul class="product_list get_more_list">
            {foreach $page->getRandList as $k=>$v}
            <li>
                <div class="product_img">
                    <a href="{$_root}service_info/{$v['id']}.html" >
                        {if $v['logo']}
                            <img src="{Page_Site_Global::displayMedia($v['logo'],275,195)}" alt="{$v['product_name']}">
                        {else}
                            <img src="images/vendor.jpg">
                        {/if}
                    </a>
                </div>
                <h1>
                    <a href="{$_root}service_info/{$v['id']}.html">{$v['product_name']}</a><br>
                    <small>
                        <a href="{$_root}vendor_info/{$v['vendor_id']}.html">{$v['vendor_name']}</a>
                    </small>
                </h1>
            </li>
            {/foreach}
            {*<li>*}
                {*<div class="product_img">*}
                    {*<a href="/service_info/4599.html">*}
                        {*<img src="/uploads/275_195/201505/o_19m51j18qpb51h1mrjg3f78q6b.png" alt="">*}
                    {*</a>*}
                {*</div>*}
                {*<h1>*}
                    {*<a href="/service_info/4599.html">平安银行-员工宣传片</a><br>*}
                    {*<small>*}
                        {*<a href="/vendor_info/3723.html">上海众庶文化传播有限公司</a>*}
                    {*</small>*}
                {*</h1>*}
            {*</li>*}
            {*<li>*}
                {*<div class="product_img">*}
                    {*<a href="/service_info/4609.html">*}
                        {*<img src="/uploads/275_195/201505/o_19m530ihn1vglsc914h11r493o8b.png" alt="">*}
                    {*</a>*}
                {*</div>*}
                {*<h1>*}
                    {*<a href="/service_info/4609.html">芝华士宣传片 蔡永康篇</a><br>*}
                    {*<small>*}
                        {*<a href="/vendor_info/3175.html">上海觉品文化传播有限公司</a>*}
                    {*</small>*}
                {*</h1>*}
            {*</li>*}

        </ul>
    </div>
</div>
<script type="text/javascript" src="js/no_result.js"></script>
