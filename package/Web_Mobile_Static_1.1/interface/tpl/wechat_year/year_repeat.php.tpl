<!DOCTYPE html>
<html lang="en">
<head>
    {include "Web_Mobile_Static::wechat_year/head_meta.tpl"}
    {static "wechat_year/year.css"}
    {static "wechat_year/wechat_pop.css"}
    <script>
        if (window.localStorage.p_explan==null) {
            window.localStorage.p_explan = 1;
            setTimeout(function () {
                $('.wechat_pop-bg').fadeIn().after('<div class="popup_bg"></div>');
                $(".pop_explan").fadeIn();
            }, 500);
        }
    </script>
</head>
<body>
<div class="banner">
    <img src="img/wechat_year/banner.jpg">
    <a class="active-expalin-btn js-expalin-btn js-btn" href="javascript:;">活动说明</a>
</div>

<div class="comn-wrap">
    <!--文艺表演-->
    <div class="comn">
        <div class="comn-theme">
            <div class="comn-theme-img">
                <img src="img/wechat_year/comn_img1.jpg">
                <div class="text-bg">
                    <div class="text">
                        <h2>文艺表演</h2>
                        <p>办一场更出彩文艺盛宴</p>
                    </div>

                    <div class="comn-theme-vote">
                        <a href="{$_home}year/vote?year_id=1" class="btn-magenta vote-btn js-vote-btn js-btn" year_id="1">立刻投票 抢礼品抢门票</a>
                        {*<a  class="btn-gray vote-btn-hv" href="javascript:;">已投票</a>*}
                        <div class="vote-numb">
                            <i></i>
                            <p>已有{$year_a}人投票</p>
                        </div>
                    </div>
                </div><!--text-bg-end-->
            </div><!--comn-theme-img-end-->
        </div>
        <div class="comn-list">
            <a class="cont" href="http://www.yunspace.com.cn/m/raiders-info/4684.html">
                <p class="fl text">宛如一场走秀般的年会——云space秀场年会</p>
                <div class="fr s-img">
                    <img src="img/wechat_year/st_img1.jpg">
                </div>
            </a>
            <a class="cont" href="http://www.yunspace.com.cn/m/raiders-info/4683.html">
                <p class="fl text">体验异国风味的年会——墨西哥艺术中心</p>
                <div class="fr s-img">
                    <img src="img/wechat_year/st_img2.jpg">
                </div>
            </a>
            <a class="cont" href="http://www.yunspace.com.cn/raiders-info/4696.html">
                <p class="fl text">韩国最牛喜剧jump show万圣节/年会套餐攻略！！！</p>
                <div class="fr s-img">
                    <img src="img/wechat_year/st_img3.jpg">
                </div>
            </a>
        </div>
    </div>

    <!--创意内容-->
    <div class="comn">
        <div class="comn-theme">
            <div class="comn-theme-img">
                <img src="img/wechat_year/comn_img2.jpg">
                <div class="text-bg">
                    <div class="text">
                        <h2>创意内容</h2>
                        <p>给员工一个有范儿的年会!</p>
                    </div>
                    <div class="comn-theme-vote">
                        <a  href="{$_home}year/vote?year_id=3" class="btn-lightblue vote-btn js-vote-btn js-btn" year_id="3">立刻投票 抢礼品抢门票</a>
                        <div class="vote-numb">
                            <i></i>
                            <p>已有{$year_c}人投票</p>
                        </div>
                    </div>
                </div><!--text-bg-end-->
            </div><!--comn-theme-img-end-->
        </div>
        <div class="comn-list">
            <a class="cont" href="http://www.yunspace.com.cn/m/raiders-info/4689.html">
                <p class="fl text">像“奥斯卡”颁奖礼那样办年会</p>
                <div class="fr s-img">
                    <img src="img/wechat_year/sc_img1.jpg">
                </div>
            </a>
            <a class="cont" href="http://www.yunspace.com.cn/m/raiders-info/4688.html">
                <p class="fl text">年会走红毯，体验明星"范”</p>
                <div class="fr s-img">
                    <img src="img/wechat_year/sc_img2.jpg">
                </div>
            </a>
            <a class="cont" href="http://www.yunspace.com.cn/m/raiders-info/4687.html">
                <p class="fl text">年会一起变"大咖"</p>
                <div class="fr s-img">
                    <img src="img/wechat_year/sc_img3.jpg">
                </div>
            </a>
        </div>
    </div>

    <!--度假旅游-->
    <div class="comn">
        <div class="comn-theme">
            <div class="comn-theme-img">
                <img src="img/wechat_year/comn_img3.jpg">
                <div class="text-bg">
                    <div class="text">
                        <h2>度假旅游</h2>
                        <p>年会也可以边走边看</p>
                    </div>
                    <div class="comn-theme-vote">
                        <a  href="{$_home}year/vote?year_id=2" class="btn-yellow vote-btn js-vote-btn js-btn" year_id="2">立刻投票 抢礼品抢门票</a>
                        <div class="vote-numb">
                            <i></i>
                            <p>已有{$year_b}人投票</p>
                        </div>
                    </div>
                </div><!--text-bg-end-->
            </div><!--comn-theme-img-end-->
        </div>
        <div class="comn-list">
            <a class="cont" href="http://www.yunspace.com.cn/m/raiders-info/4690.html">
                <p class="fl text">吃住京城，年会还可以这么办！</p>
                <div class="fr s-img">
                    <img src="img/wechat_year/sd_img1.jpg">
                </div>
            </a>
            <a class="cont" href="http://www.yunspace.com.cn/m/raiders-info/4692.html">
                <p class="fl text">吃货的年会之旅|舌尖上的广州</p>
                <div class="fr s-img">
                    <img src="img/wechat_year/sd_img2.jpg">
                </div>
            </a>
            <a class="cont" href="http://www.yunspace.com.cn/m/raiders-info/4467.html">
                <p class="fl text">边开年会边旅游，会奖旅游最佳目的地——上海</p>
                <div class="fr s-img">
                    <img src="img/wechat_year/sd_img3.jpg">
                </div>
            </a>
        </div>
    </div>

    <!--特色餐饮-->
    <div class="comn">
        <div class="comn-theme">
            <div class="comn-theme-img">
                <img src="img/wechat_year/comn_img4.jpg">
                <div class="text-bg">
                    <div class="text">
                        <h2>特色餐饮</h2>
                        <p>致那些吃货员工们</p>
                    </div>
                    <div class="comn-theme-vote">
                        <a  href="{$_home}year/vote?year_id=4" class="btn-deepblue vote-btn js-vote-btn js-btn" year_id="4">立刻投票 抢礼品抢门票</a>
                        <div class="vote-numb">
                            <i></i>
                            <p>已有{$year_d}人投票</p>
                        </div>
                    </div>
                </div><!--text-bg-end-->
            </div><!--comn-theme-img-end-->
        </div>
        <div class="comn-list">
            <a class="cont" href="http://www.yunspace.com.cn/m/raiders-info/4691.html">
                <p class="fl text">年会值得期待的美食 年会也要高大上</p>
                <div class="fr s-img">
                    <img src="img/wechat_year/sts_img1.jpg">
                </div>
            </a>
            <a class="cont" href="http://www.yunspace.com.cn/m/raiders-info/4466.html">
                <p class="fl text">现在魔都办一场高贵露台年会，这些地方你不可错过</p>
                <div class="fr s-img">
                    <img src="img/wechat_year/sts_img2.jpg">
                </div>
            </a>
            <a class="cont" href="http://pre0.yunspace.com.cn/raiders-info/4694.html">
                <p class="fl text">为十二星座特别定制年会晚宴</p>
                <div class="fr s-img">
                    <img src="img/wechat_year/sts_img3.jpg">
                </div>
            </a>
        </div>
    </div>

</div><!--comn-wrap-end-->

<div class="copy">
    <p>Copyright©2015</p>
    <p>云·SPACE 沪ICP备12039278号-2</p>
</div>

<div class="consult-btn-wrap">
    <a class="consult-btn js-btn js-consult-btn" href="javascript:;">我要办年会</a>
</div>

{include "Web_Mobile_Static::wechat_year/inc/wechat_pop.tpl"}
{static "v1.0/jquery-1.9.1.min.js"}
{static "core/yunspace.js"}
{static "wechat_year/year.js"}
{include "Web_Static::v2.0/html_tj.tpl"}
<script>
    $(document).ready(function () {
        $('.popup_bg').remove();
        $(".wechat_pop-bg").fadeOut();
        $(".pop-cont").fadeOut();

        $('.wechat_pop-bg').fadeIn().after('<div class="popup_bg"></div>');

//        $(".js-vote-btn").click(function(){
        $(".pop_reminder").fadeIn();
//        });
    })
</script>
</body>
</html>