
<div class="wechat_pop-bg hide">
    <div class="close"></div>
    <!--活动说明-->
    <div class="pop-cont pop_explan hide">
        <h1>活动说明</h1>
        <h3>邀请好友参与投票，可以让你所支持的主题获得更高的票数哦~</h3>
        <p class="title">1、活动时间</p>
        <p>投票时间：11月1日 - 12月27日</p>

        <p class="title">2、活动奖品</p>
        <p>1）手气最佳粉丝奖</p>
        <ul>
            <li>Kindle电子书阅读器、小米平板、电动独轮车、电动滑板车、千足金金条等豪礼</li>
            <li>每周抽出1名送出其中一个奖品</li>
        </ul>
        <p>2）阳光普照粉丝奖</p>
        <ul>
            <li>50积分</li>
            <li>若干名</li>
        </ul>
        <p>3）投票积分奖</p>
        <ul>
            <li>5积分</li>
            <li>全部投票者</li>
        </ul>

        <p class="title">3、活动规则</p>
        <p>1）投票选出你最喜爱的创意年会主题（关注云·SPACE订阅号参与投票，每个用户仅可投一个主题）；</p>
        <p>2）投票成功后，关注云·SPACE微信订阅号yunspace2013，回复“年会”申请加群（群人数有限，加满即止）；</p>
        <p>3）“手气最佳粉丝奖”抽奖方式：每周日23点59分截止统计主题票数，投票数第一名的主题对应粉丝群内发放随机红包，手气最佳的粉丝可以获得；</p>
        <p>4）“阳光普照粉丝奖”抽奖方式：在活动结束2016年1月3日23点59分截止统计主题票数，投票数第一名的主题对应粉丝群内，全部粉丝均可获得50积分奖励；</p>
        <p>5）领奖方式：“手气最佳粉丝奖”与工作人员联系领奖；积分会发放到个人中心的积分账户；</p>
        <p>6）积分可用于在云·SPACE公众号积分专区兑换活动门票。</p>
        <p>*若因用户所留联系方式有误等原因，7个工作日内无法联系到中奖用户，则视为自动放弃中奖资格。</p>

        <p class="title">4、本次活动解释权归云·SPACE所有。</p>
    </div>
    <!--活动说明-结束-->

    <!--投票给它-->
    <div class="pop-cont pop_vdrd pop_voted hide">
        <h1>投票成功</h1>
        <div class="h1-line"></div>

        <p>第一步：投票</p>
        <p class="point">
            .<br>
            .<br>
            .<br>
        </p>

        <h2>第二步：关注云·SPACE微信订阅号<strong>yunspace2013</strong><br>回复“年会”申请加群</h2>

        <p class="point">
            .<br>
            .<br>
            .<br>
        </p>
        <p>第三步：进群等待抽奖</p>

        <div class="qrcode">
            <img class="img1" src="img/wechat_year/yun_code.jpg">
            <img class="img2" src="img/wechat_year/yun_code_text.jpg">
        </div>
    </div>
    <!--投票给它-结束-->

    <!--温馨提示-->
    <div class="pop-cont pop_vdrd pop_reminder hide">
        <h1>温馨提示</h1>
        <div class="h1-line"></div>
        {*<p>您已给XXXX年会主题投过票啦~</p>*}
        <p>您已给{if $vote_year==1}文艺表演{elseif $vote_year==2}度假旅游{elseif $vote_year==3}创意内容{elseif $vote_year==4}特色餐饮{/if}年会主题投过票啦~</p>

        <h2>关注云·SPACE微信订阅号<strong>yunspace2013</strong><br>回复“年会”申请加群<br>进群等待每周一的抽奖</h2>

        <div class="qrcode">
            <img class="img1" src="img/wechat_year/yun_code.jpg">
            <img class="img2" src="img/wechat_year/yun_code_text.jpg">
        </div>
    </div>
    <!--温馨提示-结束-->

    <!--立即咨询-->
    <div class="pop-cont consult hide">
        <h2>我要办年会</h2>
        <ul class="inquiry-ul-contleft clearfix">
            <li>
                <label>您的称呼</label>
                <input type="text" class="fill" placeholder="请输入您的真实姓名">
            </li>
            <li>
                <label>您的联系方式</label>
                <input type="text" class="fill phone3" placeholder="请输入有效的11位手机号码">
            </li>
            <li class="li-code">
                <label>手机验证码</label>
                <input type="text" id="look_price_code" class="fill js-y-code" placeholder="请输入6位数验证码">
                <button type="button" class="get-code orange" yun-second="30" yun-phone=".phone3" yun="identify-code.v1.0/identify-code.v1.0.js::sendCode@click" >获取验证码</button>
                {*<button type="button" class="get-code gray">重新发送（59）</button>*}
            </li>
            <li class="li-textrea">
                <label>您的需求内容</label>
                <textarea class="fill" placeholder="请输入您的年会需求"></textarea>
            </li>
        </ul>
        <button class="inquiry-btn">提交</button>
    </div>
    <!--立即咨询-结束-->

</div>
<!--wechat_pop-bg(弹窗共用背景)-结束-->