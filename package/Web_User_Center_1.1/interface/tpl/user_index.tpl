<!DOCTYPE html>
<html>
<head>
    {include file="Web_Static::v2.0/html_head.tpl"}
    {static "user_center.css"}
    {static "user_popup.css"}
</head>
<body>
{include file="Web_Static::id_validate/inc/validate_head.tpl"}
<div class="user-center-main clearfix">
    <!--网站侧导航-->
    {include file="Web_User_Center::inc/sidenav.tpl"}

    <!--网站主体内容部分-->
    <div class="user-center-cont fl clearfix">
        <!--温馨提示-->
        <div class="reminder">
            <strong>温馨提示！</strong>
            您的身份还未认证，如需认证请点击
            <a href="" class="magenta">这里前往</a>
        </div>

        <!--当前页面位置-->
        <div class="user-location">
            <h3>我的云SPACE中心</h3>
        </div>

        <!--网站中间主要内容-->
        <div class="user-cont-wrap fl clearfix">
            <!--用户信息-->
            <div class="user-info">
                <div class="user-info-img fl"><img src="img/user_img_head.png" width="108px" height="108px"></div>
                <div class="user-info-details fl clearfix">
                    <div class="user-info-title">
                        <h2>陈晓菲私人企业</h2>
                        <span class="nocert">未认证</span>
                        <span class="audit">个人审核中</span>
                        <span class="hvcert">个人认证</span>
                        <span class="ord-user">普通用户</span>
                        <span class="compy-audit">企业审核中</span>
                        <span class="compy-hvcert">企业认证</span>
                    </div>
                    <ul class="user-info-cont clearfix">
                        <li>
                            <p><span>钱包余额：</span>18521038577</p>
                            <a href="">修改手机</a>
                        </li>
                        <li>
                            <p><span>手机号：</span><strong class="magenta">0.00</strong>元</p>
                            <a href="">绑定银行卡</a>
                        </li>
                        <li>
                            <p><span>邮 箱：</span>未绑定</p>
                            <a href="">修改邮箱</a>
                        </li>
                        <li>
                            <p><span>安全等级：</span>
                               <div class="progress-bar"><i class="bg-magenta"></i></div>
                               <strong class="magenta">高</strong>
                            </p>
                            <a href="">修改密码</a>
                        </li>
                    </ul>
                    <div class="user-info-apply clearfix">
                        {*<div class="apply-link">*}
                            {*<a href="" class="magenta">供应商审核中...</a>*}
                        {*</div>*}
                        {*<div class="apply-link">*}
                            {*<a href="" class="magenta">经纪人审核中...</a>*}
                        {*</div>*}
                        <div class="apply-link">
                            <a href="javascript:;" class="dk-blue js-pop js-apply-suppliers">申请成为供应商</a>
                            <div class="icon-doubt js-icon-doubt">
                                <div class="quest-details">
                                    <p>什么是供应商？</p>
                                    <p>供应商是指您有满足云SPACE平台上业务类型的商品（空间场地、硬体搭建、设备凭租、多媒体制作、演出人力、物料制作、外烩餐饮、其他），并有兴趣与我们平台取得合作，在云SPACE平台上展现您的商品，来获取更多的客户。</p>
                                </div>
                            </div>
                        </div>
                        <div class="apply-link">
                            <a href="javascript:;" class="dk-blue js-pop js-apply-agents">申请成为经纪人</a>
                            <div class="icon-doubt js-icon-doubt">
                                <div class="quest-details">
                                    <p>什么是经纪人？</p>
                                    <p>经纪人是介于活动方和采购方之间类似中介的一个角色，供应商可以对商品设置佣金百分比，当经纪人通过云SPACE网站帮供应商的商品推荐给力活动方，并促使成功下单，完成活动后，将以该商品的价格乘以佣金百分比来拿取服务费。</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div><!--user-info-details-end-->
            </div><!--user-info-end-->

            <!--插件-->
            <div class="plug-ins">
                <ul class="plug-ins-ul">
                    <li>
                        <span><img src="" ></span><br>
                        <p>插件</p>
                    </li>
                    <li>
                        <span><img src="" ></span><br>
                        <p>插件</p>
                    </li>
                    <li>
                        <span><img src="" ></span><br>
                        <p>插件</p>
                    </li>
                    <li>
                        <span><img src="" ></span><br>
                        <p>插件</p>
                    </li>
                    <li>
                        <span><img src="" ></span><br>
                        <p>添加插件</p>
                    </li>
                </ul>
            </div><!--plug-ins-end-->

            <!--最新消息-->
            <div class="latest-news">
                <div class="user-title">
                    <h2>最新消息</h2>
                    <a href="" class="more">查看更多</a>
                </div>
                <div class="latest-news-ul clearfix">
                    <li>
                        <div class="news-img"><img src="img/user_img_collect1.png" ></div>
                        <div class="news-cont">
                            <div class="news-cont-tit">
                                <a href="">系统通知</a>
                                <span>2015-04-01</span>
                            </div>
                            <p class="news-cont-p"><a href="">您好，欢迎注册云space通行证账号，快来开启您的云space之旅吧</a></p>
                        </div>
                        <a href="" class="news-more">查看</a>
                    </li>
                    <li>
                        <div class="news-img"><img src="img/user_img_collect1.png" ></div>
                        <div class="news-cont">
                            <div class="news-cont-tit">
                                <a href="">上海星期网络有限公司</a>
                                <span>2015-04-01</span>
                            </div>
                            <p class="news-cont-p"><a href="">请问“上海体育馆”6月20可以预定吗？</a></p>
                        </div>
                        <a href="" class="news-more">查看</a>
                    </li>
                    <li>
                        <div class="news-img"><img src="img/user_img_collect1.png" ></div>
                        <div class="news-cont">
                            <div class="news-cont-tit">
                                <a href="">上海星期网络有限公司</a>
                                <span>2015-04-01</span>
                            </div>
                            <p class="news-cont-p"><a href="">请问“上海体育馆”6月20可以预定吗？</a></p>
                        </div>
                        <a href="" class="news-more">查看</a>
                    </li>
                    <li>
                        <div class="news-img"><img src="img/user_img_collect1.png" ></div>
                        <div class="news-cont">
                            <div class="news-cont-tit">
                                <a href="">系统通知</a>
                                <span>2015-04-01</span>
                            </div>
                            <p class="news-cont-p"><a href="">您的需求已被工作人员认领，请等待工作人员与您联系</a></p>
                        </div>
                        <a href="" class="news-more">查看</a>
                    </li>
                    <li>
                        <div class="news-img"><img src="img/user_img_collect1.png" ></div>
                        <div class="news-cont">
                            <div class="news-cont-tit">
                                <a href="">上海星期网络有限公司</a>
                                <span>2015-04-01</span>
                            </div>
                            <p class="news-cont-p"><a href="">请问“上海体育馆”6月20可以预定吗？</a></p>
                        </div>
                        <a href="" class="news-more">查看</a>
                    </li>
                </div>
            </div><!--latest-news-end-->

            <!--我的需求-->
            <div class="myneeds">
                <div class="user-title">
                    <h2>我的需求</h2>
                    <a href="" class="more">查看更多</a>
                </div>
                <table class="myneeds-table my-table" cellpadding="0" cellspacing="0">
                    <tr>
                        <th width="22%">时间</th>
                        <th width="52%">需求</th>
                        <th width="13%">状态</th>
                        <th width="13%">操作</th>
                    </tr>
                    <tr>
                        <td>2015-06-19 17:19:15</td>
                        <td>预约咨询：车辆租赁</td>
                        <td>已处理</td>
                        <td><a href="" class="check btn">查看</a></td>
                    </tr>
                    <tr>
                        <td>2015-06-19 17:19:15</td>
                        <td>预约咨询：车辆租赁</td>
                        <td>已处理</td>
                        <td><a href="" class="abandon btn">放弃</a></td>
                    </tr>
                    <tr>
                        <td>2015-06-19 17:19:15</td>
                        <td>预约咨询：车辆租赁</td>
                        <td>已处理</td>
                        <td><a href="" class="check btn">查看</a></td>
                    </tr>
                    <tr>
                        <td>2015-06-19 17:19:15</td>
                        <td>预约咨询：车辆租赁</td>
                        <td>已处理</td>
                        <td><a href="" class="check btn">查看</a></td>
                    </tr>
                    <tr>
                        <td>2015-06-19 17:19:15</td>
                        <td>预约咨询：车辆租赁</td>
                        <td>已处理</td>
                        <td><a href="" class="check btn">查看</a></td>
                    </tr>
                </table>

                <!--无内容状态-开始-->
                <div class="user-nocont" style="display: none;">
                    <span class="icon-nocont"><img src="img/user_icon_noneeds.png"></span>
                    <p>您还没有发布过需求，赶紧去<a href="">创建</a>需求吧！</p>
                </div>
                <!--无内容状态-结束-->
            </div><!--myneeds-end-->

            <!--我的订单-->
            <div class="myorders">
                <div class="user-title">
                    <h2>我的订单</h2>
                    <a href="" class="more">查看更多</a>
                </div>
                <table class="myorders-table my-table" cellpadding="0" cellspacing="0">
                    <tr>
                        <th width="32%">服务内容</th>
                        <th width="20%">实付款</th>
                        <th width="22%">下单时间</th>
                        <th width="13%">交易状态</th>
                        <th width="13%">交易操作</th>
                    </tr>
                    <tr>
                        <td>打包<br>2015-07-16 — 2015-07-16</td>
                        <td>100元/100元</td>
                        <td>2015-06-19 17:19:15</td>
                        <td>已处理</td>
                        <td><a href="" class="check btn">查看</a></td>
                    </tr>
                    <tr>
                        <td>打包<br>2015-07-16 — 2015-07-16</td>
                        <td>100元/100元</td>
                        <td>2015-06-19 17:19:15</td>
                        <td>已处理</td>
                        <td><a href="" class="check btn">查看</a></td>
                    </tr>
                    <tr>
                        <td>打包<br>2015-07-16 — 2015-07-16</td>
                        <td>100元/100元</td>
                        <td>2015-06-19 17:19:15</td>
                        <td>已处理</td>
                        <td><a href="" class="check btn">查看</a></td>
                    </tr>
                    <tr>
                        <td>打包<br>2015-07-16 — 2015-07-16</td>
                        <td>100元/100元</td>
                        <td>2015-06-19 17:19:15</td>
                        <td>已处理</td>
                        <td><a href="" class="check btn">查看</a></td>
                    </tr>
                    <tr>
                        <td>打包<br>2015-07-16 — 2015-07-16</td>
                        <td>100元/100元</td>
                        <td>2015-06-19 17:19:15</td>
                        <td>已处理</td>
                        <td><a href="" class="check btn">查看</a></td>
                    </tr>
                </table>
                <!--无内容状态-开始-->
                <div class="user-nocont" style="display: none;">
                    <span class="icon-nocont"><img src="img/user_icon_noorders.png"></span>
                    <p>您挑选的东西太少了，这里都空空的，快去<a href="">挑选</a>合适的商品吧！</p>
                </div>
                <!--无内容状态-结束-->
            </div><!--myorders-end-->
        </div><!--user-cont-wrap-end-->

        <!--网站右边内容-->
        <div class="user-right-wrap fr clearfix">
            <!--快捷入口-->
            <div class="user-tools">
                <div class="user-title">
                    <h2>快捷入口</h2>
                </div>
                <ul class="user-tools-ul clearfix">
                    <li>
                        <a href="">
                            <span><img src="img/user_icon_news.png"></span>
                            <p>我的消息</p>
                        </a>
                    </li>
                    <li>
                        <a href="">
                            <span><img src="img/user_icon_needs.png"></span>
                            <p>活动需求</p>
                        </a>
                    </li>
                    <li>
                        <a href="">
                            <span><img src="img/user_icon_collect.png"></span>
                            <p>我的收藏</p>
                        </a>
                    </li>
                    <li>
                        <a href="">
                            <span><img src="img/user_icon_create.png"></span>
                            <p>创作需求</p>
                        </a>
                    </li>
                    <li>
                        <a href="">
                            <span><img src="img/user_icon_sub.png"></span>
                            <p>添加子账号</p>
                        </a>
                    </li>
                    <li>
                        <a href="">
                            <span><img src="img/user_icon_trade.png"></span>
                            <p>交易对账</p>
                        </a>
                    </li>
                    <li style="border-bottom: none;">
                        <a href="">
                            <span><img src="img/user_icon_check.png"></span>
                            <p>门票查询</p>
                        </a>
                    </li>
                    <li style="border-bottom: none;">
                        <a href="">
                            <span><img src="img/user_icon_cpcert.png"></span>
                            <p>添加企业认证</p>
                        </a>
                    </li>
                    <li style="border-bottom: none;">
                        <a href="javascript:;" class="js-more-entrance">
                            <span><img src="img/user_icon_more.png"></span>
                            <p>更多</p>
                        </a>
                    </li>
                </ul>
            </div><!--user-tools-end-->

            <!--我的需求/收藏/订单-->
            <ul class="mynumbs">
                <li>
                    <a href="">
                        <strong>1</strong>
                        <p>我的需求</p>
                    </a>
                </li>
                <li>
                    <a href="">
                        <strong>2</strong>
                        <p>我的收藏</p>
                    </a>
                </li>
                <li style="border: none;">
                    <a href="">
                        <strong>0</strong>
                        <p>我的订单</p>
                    </a>
                </li>
            </ul>

            <!--钱包余额-->
            <div class="my-balance clearfix">
                <h2 class="balance">钱包余额：<strong class="magenta">2,3000</strong>元</h2>
                <select>
                    <option>2015-06</option>
                    <option>2015-06</option>
                    <option>2015-06</option>
                </select>
                <div class="inout clearfix">
                    <p class="fl">收入：<span>2,3000</span>元</p>
                    <p class="fr">支出：<span>0,00</span>元</p>
                </div>
                <div class="checkorder fr clearfix">
                    <a href="">查看交易对账</a>
                </div>
            </div><!--my-balance-end-->

            <!--我的收藏-->
            <div class="my-collect">
                <div class="user-title">
                    <h2>我的收藏</h2>
                    <a href="" class="more">查看更多</a>
                </div>
                <ul class="my-collect-ul clearfix">
                    <li>
                        <a href="" class="li-img"><img src="img/user_img_collect1.png"></a>
                        <a href="" class="li-txt">万和昊美艺术酒店</a>
                    </li>
                    <li style="border-right: none;">
                        <a href="" class="li-img"><img src="img/user_img_collect1.png"></a>
                        <a href="" class="li-txt">万和昊美艺术酒店</a>
                    </li>
                    <li style="border-bottom: none;">
                        <a href="" class="li-img"><img src="img/user_img_collect1.png"></a>
                        <a href="" class="li-txt">万和昊美艺术酒万和昊美艺术酒万和昊美艺术酒店</a>
                    </li>
                    <li style="border-bottom: none; border-right: none;">
                        <a href="" class="li-img"><img src="img/user_img_collect1.png"></a>
                        <a href="" class="li-txt">万和昊美艺术酒店</a>
                    </li>
                </ul>
                <!--无内容状态-开始-->
                <div class="user-nocont" style="display: none;">
                    <span class="icon-nocont"><img src="img/user_icon_nocollect.png"></span>
                    <p>您还没有心仪的商品，快去<a href="">逛逛</a>吧！</p>
                </div>
                <!--无内容状态-结束-->
            </div><!--my-collect-end-->

        </div><!--user-right-wrap-end-->
    </div><!--user-center-cont-end-->

</div><!--user-center-main-end-->
{include file="Web_User_Center::inc/user-pop-up.tpl"}
{include file="Web_Static::id_validate/inc/validate_foot.tpl"}
{*{static "user_center.js"}*}
<script src="js/user_center.js"></script>
</body>
</html>