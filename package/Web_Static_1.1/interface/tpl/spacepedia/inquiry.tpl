<!DOCTYPE html>
<html>
<head>
    {include file="Web_Static::v2.0/html_head.tpl"}
    {static "space_info/space_inquiry.css"}
</head>
<!--引用百度地图API-->
<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=aaNCRRcGGai6klHMOGZ8yBbP"></script>
<body>
{include file="Web_Static::v2.0/html_header3.1.tpl"}
{include file="Web_Static::v2.0/form.tpl"}
<div class="container" data-username="{$smarty.session.user.username}" data-phone="{$smarty.session.user.phone}">
    <div class="inquiry-title">
        <h1>一键提交我的询价单</h1>
        <p>我们将在30分钟内为您提供多份精准场地报价</p>
    </div>
    <div class="inquiry-content clearfix">
        <div class="inquiry-content-left clearfix fl">
            <div class="title clearfix">
                <i class="icon-msg"></i><span>完善您的活动信息</span>
            </div>
            <ul class="inquiry-ul-contleft clearfix">
                <li>
                    <label>您的称呼</label>
                    <input type="text" class="fill username" name="data[联系人]" placeholder="请输入您的真实姓名">
                </li>
                <li>
                    <label>您的联系方式</label>
                    <input type="text" class="fill phone" name="data[联系电话]" placeholder="请输入您的手机号码">
                </li>
                <li>
                    <label>活动城市</label>
                    {*<input type="text" class="fill" name="data[活动城市]" placeholder="请输入活动城市">*}

                    <select class="fill" name="data[活动城市]">
                        {foreach $_REQUEST['cities'] as $k=>$v}
                            <option>{$v}</option>
                        {/foreach}
                        <option>其他</option>
                    </select>
                </li>
                <li>
                    <label>活动人数</label>
                    <select class="fill" name="data[活动人数]">
                        <option>50人以下</option>
                        <option>50-100人</option>
                        <option>100-300人</option>
                        <option>300-500人</option>
                        <option>500人以上</option>
                    </select>
                </li>
                <li>
                    <label>活动类型</label>
                    <select class="fill" name="data[活动类型]">
                        <option>派对/典礼/沙龙</option>
                        <option>年会/晚会/演出</option>
                        <option>路演/展览/发布会</option>
                        <option>会议/讲座</option>
                        <option>团建/拓展</option>
                    </select>
                </li>
                <li>
                    <label>活动日期</label>
                    <input type="text" class="fill" name="data[活动日期]" placeholder="请输入具体的活动日期">
                </li>
                <li class="li-textrea">
                    <label>具体要求</label>
                    <textarea class="fill" name="data[具体要求]" placeholder="填写更多详细信息，帮助你快速找到合适的场地！"></textarea>
                </li>
            </ul>
            <a href="javascript:;" class="inquiry-btn">我要办活动</a>
        </div>
        <div class="inquiry-content-right clearfix fr">
            <div class="title clearfix">
                <i class="icon-list"></i><span>询价清单</span>
            </div>
            <div class="inq-shadow shadow-top"></div>
            <div class="inquiry-ul-wrap">
                <div class="inquiry-ul-contright" id="inquirylist">
                </div>
                <div class="inq-shadow shadow-bottom"></div>
            </div><!--inquiry-ul-wrap-end-->
        </div><!--inquiry-content-right-end-->
    </div>
</div>
{include file="Web_Static::spacepedia/inc/pop_check_code.tpl"}
{include file="Web_Static::v2.0/html_footer.tpl"}
<script type="text/javascript" src="http://developer.baidu.com/map/custom/stylelist.js"></script>
<script src="js/space_info/space_inquiry.js"></script>
<script src="js/space_info/sidebar.js"></script>
<script src="js/space_info/ask_price_list.js"></script>
{include "Web_Static::v2.0/html_tj.tpl"}
</body>
</html>