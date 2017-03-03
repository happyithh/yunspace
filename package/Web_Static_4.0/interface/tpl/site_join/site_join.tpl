<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    {include file="Web_Static::inc/head_meta.tpl"}
    {static "v4.0/common.css"}
    {static "site_join/sitejoin.css"}
    {static "site_join/featureCarousel.css"}

</head>
<body>
{include file="Web_Static::inc/header_1.tpl"}
<div class="wrapper">
    <div class="crumb">
        <a href="{$_home}">首页</a>&gt;<a href="{$_root}site_join" class="active">场地出租</a>
    </div>
</div>
<div class="head" id="head">
     {*<img src="img/site_join/j_banner.jpg" alt="云SPACE助您轻松解决场地烦恼">*}
    <div class="j-header j-1032">
        <div class="fl j-header-text">
            <h2>场地<span>闲置</span>？没有<span>人气</span>？管理<span>麻烦</span>？</h2>
            <h5>云·SPACE助您轻松解决场地烦恼</h5>
            <div class="j_joinbtn-wrapper">
                <div class="opacity-bg"></div>
                <a class="j_joinbtn" href="http://master.yunspace.com.cn/register">立即加入</a>
            </div>
            <p>咨询热线：400-056-0599</p>
        </div>
        <div class="fr j-login-wrapper" id="j-login-app">
            {*<div class="j-login-app"></div>*}
            <div class="fei-word-back">
                <img src="img/site_join/fei_word2.png">
            </div>
            <div class="j-login-app"></div>
            <div class="opacity-bg"></div>
            <h3 class="j-login-title">登录<span>场地大师</span>空间场地管理系统</h3>
            <div class="j-login">
                {*<form action="http://master.yunspace.com.cn/login_do" method="post">*}
                    <input type="hidden"  class="login_ways" name="login_ways" value="auth_login" />
                    <div class="ipt-waper">
                        <div class="opacity-bg"></div>
                        <input type="text" class="phone" name="phone" placeholder="手机号码">
                    </div>
                    <div class="ipt-waper auth_login_l">
                        <div class="opacity-bg"></div>
                        <input type="text" name="auth_code" class="auth_code" placeholder="验证码">
                        <button class="send-code send_code_btn hide">②获取短信验证码</button>
                        <button id="yzm_captcha"  style="width: 180px;" class="send-code">①滑块拼图验证</button>
                    </div>
                    <div id="captcha"></div>
                    <script src="http://static.geetest.com/static/tools/gt.js"></script>
                    <div class="ipt-waper  pass_login_l none">
                        <div class="opacity-bg"></div>
                        <input type="password" class="password" name="password" placeholder="输入密码">
                        {*<button class="send-code">发送验证码</button>*}
                    </div>
                    <div class="ipt-waper rember" style="height: 25px;">
                        <label class="fl"><input class="fl ckbox" type="checkbox"><p class="fl">记住手机号码</p></label>
                        <span class="fr auth_login none"  >验证码登录</span>
                        <span class="fr pass_login"  >密码登录</span>
                    </div>
                    <p class="none error-block">  <span class="login_error_msg">  </span></p>
                    <div class="ipt-waper">
                        <button  type="button" class="btn-login-reg login_btn">登录</button>
                    </div>
                {*</form>*}
                <div class="text-wrap clearfix">
                    <a class="fl text creat" href="http://master.yunspace.com.cn/register">没有场地，立即申请创建</a>
                    <a class="fr text nocode" href="http://master.yunspace.com.cn/find_password">忘记密码？</a>
                </div>
            </div>
        </div>
        <div class="fr j-login-wrapper none" id="j-login-pc">
            <div class="fei-word-back">
                <img src="img/site_join/fei_word1.png">
            </div>
            <div class="j-login-pc"></div>
            <div class="opacity-bg"></div>
            <div class="j-login-title-app">云SPACE场地大师APP</div>
            <div class="j-login">
                <div class="app-er">
                    <img src="img/site_join/app_er.jpg"/>
                </div>
                <div class="app_sao">
                    手机扫一扫<br>
                    Android，iOS智能下载
                </div>
            </div>
        </div>
    </div>

</div>


<div class="wrapper1">
    <div class="content1">
        <div class="heading1">
            <img src="img/site_join/j_title1.jpg" alt="中国商业地产空间的Airbnb">
        </div>
        <div class="word1 j-785">
            云space是国内商业空间短租的集合平台，集场地、活动、IP文创项目、零售短租等业务服务，打造多元消费场景，汇聚全球资源持续为商业空间注入潮流“内容及品牌”，助力商业空间去库存变现、增加客流，可最大提升租赁坪效！
        </div>
        <div class="heading1">
            <img src="img/site_join/j_cont1.jpg" alt="一站式管理工具场地大师">
        </div>
        <div class="word2">助您大大提升场地使用率，快速增加场地人气，高效管理您的场地！</div>
        <div class="heading1">
            <img src="img/site_join/index_03.jpg" alt="icon">
        </div>
    </div>
</div>
<div class="wrapper2">
    <div class="topside"></div>
    <div class="heading1">
        <img src="img/site_join/j_title2.jpg" alt="8大加盟优势">
    </div>
    <div class="word3">
        让您的空间不再是“空”间!
    </div>
    <div class="heading1">
        <img src="img/site_join/j_cont2.jpg" alt="平台推广、海量订单、业务管理">
    </div>
    <div class="topbottom"></div>
</div>
<div class="wrapper1">
    <div class="content1">
        <div class="heading1">
            <img src="img/site_join/j_title3.jpg" alt="优秀活动案例">
        </div>
        <div class="word1" style="margin-top: 10px;">紧密的客户关系，O2O专业经验</div>


        <div id="featureCarousel">
            <div class="feature">
                <a href="javascript:;"><img alt="Image Caption" src="img/site_join/j_case01.jpg"></a>
                <div>
                    <p>
                        <span>云space搭桥华侨城创意园举办极品飞车发布会</span><br>
                        2016年4月19日，腾讯游戏与EA战略合作暨《极品飞车ONLINE》签约发布会在深圳市正式开启。这是腾讯游戏在中国电竞市场的又一次里程碑，并公布了“极品车神招募计划”，希望为更多的爱好者提供更好的平台。云space在时间紧张的情况下精准锁定匹配的场地华侨城创意园区C2馆，并为主办方临时的需求提供了及时、优质服务，保障了发布会的顺利举行，活动也因其场地内的艺术文化气息而增色不少。
                    </p>
                </div>
            </div>
            <div class="feature">
                <a href="javascript:;"><img alt="Image Caption" src="img/site_join/j_case02.jpg"></a>
                <div>
                    <p>
                        <span>淘宝携手云SPACE开启双12线下移动集市</span><br>
                        2015年12月初，淘宝在全国三大城市北京、上海、成都同期举办“双12”线下活动，用集装箱打造“最大的小店”移动式集市，为大众呈现淘宝平台中上万种丰富有趣的商品。云SPACE作为主办方长期的线下活动场地提供商，利用丰富资源再次为淘宝进行了三地的场地服务。由于集装箱其较大的体积问题，云SPACE工作人员给出了因地制宜的解决方案，并协助用电、运输和消防等相关事宜。活动当天吸引了近10万的人流，现场一个主题为“15分钟主角”的集装箱受到最多欢迎，体验者纷纷表示新鲜感十足，非常喜欢这种新型活动形式。
                    </p>
                </div>
            </div>
            <div class="feature">
                <a href="javascript:;"><img alt="Image Caption" src="img/site_join/j_case03.jpg"></a>
                <div>
                    <p>
                        <span>云space获玛莎拉蒂suv Levante主办方高度评价</span><br>
                        云space为2016年4月15日“玛莎拉蒂suv Levante 新车发布会”提供了优质的服务，从匹配合适的场地到落地执行中遇到的实际问题，云space均在第一时间为主办方解决了问题，获得了主办发的高度赞扬。
                    </p>
                </div>
            </div>
        </div>


    </div>
</div>
<div class="wrapper2">
    <div class="topside1"></div>
    <div class="content2">
        <div class="heading1">
            <img src="img/site_join/j_title4.jpg" alt="我们的合作品牌">
        </div>
        <div class="word4">众多知名品牌企业在云SPACE找到场地</div>
        <div class="heading1">
            <img src="img/site_join/j_logos.png" alt="众多知名品牌企业在云SPACE找到场地">
        </div>
    </div>
    <div class="sidebottom"></div>
</div>
<div class="wrapper1" id="wrapper1">

    <div class="content1">

        <div class="heading1">

            <img src="img/site_join/j_title5.jpg" alt="加盟云SPACE">
        </div>
        <div class="word1" style="margin-top: 10px;">助您轻松解决场地烦恼</div>
        <div class="heading1">
            <a href="http://master.yunspace.com.cn/register" style="margin-bottom: 30px;display: block">
                <img src="img/site_join/j_cont5.jpg" alt="立即加入云SPACE">
            </a>
        </div>
    </div>

</div>
{include file="Web_Static::inc/html_footer.tpl"}
{include file="Web_Static::inc/public_space.tpl"}
{static "site_join/jquery.featureCarousel.js"}
{static "site_join/sitejoin.js"}
{static "core/yunspace.js"}
{static "site_join/join_login.js"}
<script>
    var handler = function (captchaObj) {
        captchaObj.onReady(function(){
            var elements_n = $('.gt_holder');
            if (elements_n.length > 0) {
                elements_n.first().css({ 'z-index' : 300});
            }
            var elements = $('.gt_mask');
            if (elements.length > 0) {
                elements.first().css({ 'z-index' : 500 });
            }
        });
        // 将验证码加到id为captcha的元素里
        captchaObj.bindOn("#yzm_captcha");
        captchaObj.onSuccess(function(){
            $("#yzm_captcha").hide();
            $("#origin_yzm_captcha").remove();
            $(".send_code_btn").removeClass('hide');
            $(".send_code_btn").css('display','block');
        });
        captchaObj.appendTo("#captcha");
    };
    $.ajax({
        // 获取id，challenge，success（是否启用failback）
        url:"http://master.yunspace.com.cn/static/api/common/start/cs.json?rand="+Math.round(Math.random()*100),
        type: "get",
        dataType: "json", // 使用jsonp格式
        success: function (data) {
            // 使用initGeetest接口
            // 参数1：配置参数，与创建Geetest实例时接受的参数一致
            // 参数2：回调，回调的第一个参数验证码对象，之后可以使用它做appendTo之类的事件
            initGeetest({
                gt: data.gt,
                challenge: data.challenge,
                product: "popup", // 产品形式
                offline: !data.success
            }, handler);
        }
    });
</script>
</body>

</html>