
<div class="public-fixed-right">
  <div class="pfr-relative">
    {*<div class="pfr-code  pfr-phone-active"  id="share_box">*}
        {*<img src="" alt="">*}
        {*<a style="background: none;!important;position: absolute;*}
        {*width: 24px;height: 45px;top: 0px;right: 1px;" data-cmd="weixin" title="分享到微信"></a>*}
    {*</div>*}
    <div class="pfr-phone ">
        <img src="" alt="">
    </div>
   <div class="pfr-table">
     <div style="position:relative">
        <ul class="pfr-tab clearfix">
            <li class='pfr-tab-active'>发送场地信息到手机</li>
            <li>扫码收藏</li>
        </ul>
        <div class="pfr-div">
            <p class="p1">填写手机号，场地信息随身带走！</p>
            <div class="pfr-phone-2">
                <input type="text" placeholder="输入您的手机号" id="pfr-phone"/>
            </div>
            <div class="pfr-code-2 clearfix none">
              <input type="text" placeholder="验证码" class="fl" />
              <button class="pfr-send-code fl" yun="identify-code.v1.0/identify-code.v1.0.js::sendCode@click" yun-phone="#pfr-phone">获取验证码</button>
            </div>
            <div class="pfr-submit">
               <button>下一步</button>
            </div>
        </div>
        <div class="pfr-div none">
            <div class="qcode" id="pfr-code">

            </div>
            <p class="p2">随时随地看场地！</p>
        </div>
         <div class="pfr-div none">
             <p class="success"><span>提交成功</span></p>
         </div>
        <p class="pfr-error">手机号码不正确！！</p>
     </div>
    </div>   
  </div>
</div>
{*<div class="public-fixed-center none">*}
    {*<div class="pfc-relative">*}
        {*<div class="pfc-table">*}
          {*<div class="pfc-table-cell">*}
              {*<div class="pfc-tc-close"></div>*}
              {*<p class="pfc-error">手机号码格式不正确！！</p>*}
              {*<div class="pfc-tc-0">*}
                {*<p style="font-size:16px;font-weight:bold">友情提示</p>*}
                {*<p id="pfc-look-space" style="margin-top:10px;">你正在浏览<span>面积200㎡，活动场地</span>的场地近<code>500</code>个</p>*}
                {*<p>是否需要云SPACE场地顾问帮您精准筛选？</p>*}
                {*<button class="pfc-tc-0-b0">否</button>*}
                {*<button class="pfc-tc-0-b1">是</button>*}
              {*</div>*}
              {*<div class="pfc-tc-1 none">*}
                  {*<p class="pfc-tc-1-title">提交您的基本信息<br/>以便场地顾问及时与您联系</p>*}
                  {*<div class="pfc-tc-1-input clearfix">*}
                    {*<label for="pfc-username">您的称呼</label>*}
                    {*<div>*}
                         {*<input type="text" id="pfc-username" placeholder="请输入您的真实姓名"/>*}
                    {*</div>*}
                  {*</div>*}
                  {*<div class="pfc-tc-1-input clearfix">*}
                    {*<label for="pfc-phone">您的手机号码</label>*}
                    {*<div>*}
                       {*<input type="text" id="pfc-phone" placeholder="请输入您的手机号码"/>*}
                    {*</div>*}
                  {*</div>*}
                  {*<div class="pfc-tc-1-input clearfix none">*}
                    {*<label for="pfc-code">验证码</label>*}
                    {*<div class='pfc-code-div'>*}
                       {*<input type="text" id="pfc-code" placeholder="请输入您的验证码"/>*}
                       {*<button yun="identify-code.v1.0/identify-code.v1.0.js::sendCode@click" yun-phone="#pfc-phone">发送验证码</button>*}
                    {*</div>*}
                  {*</div>*}
                  {*<div class="pfc-tc-1-input clearfix">*}
                    {*<button class="pfc-tc-1-button">下一步</button>*}
                  {*</div>*}
              {*</div>*}
              {*<div class="pfc-tc-2 none">*}
                  {*<p><span>提交成功</span></p>*}
              {*</div>*}
          {*</div>*}
        {*</div>*}
    {*</div>*}
{*</div>*}