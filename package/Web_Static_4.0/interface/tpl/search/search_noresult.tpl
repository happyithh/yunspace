<!DOCTYPE html>
<html lang="en">
<head>
    {include file="Web_Static::inc/head_meta.tpl"}
    {static "search.v4.0/search.css"}
    {static "search.v4.0/box.css"}
    {static "v4.0/data-picker.css"}


</head>
<body>
{include file="Web_Static::inc/header.tpl"}
{*搜索框*}
<div class="search_head_back">
    <div class="search_head">
        <div class="search_head_content">
            <form action="/search" method="get">
            <div class="search_label">
                场地库
                <div class="search_input_value">收搜场地资料/文创</div>
            </div>

            <input class="search_input"/>
            <button class="search_button clearfix">
                <span class="search_icon"></span>
                搜索一下
            </button>
            </form>
        </div>
    </div>
</div>

{*搜索页面主体内容*}
<div class="search_content">

    {*左边*}
    <div class="search_content_left_no">
        {*搜索筛选*}
        <div class="search_select_outside none" id="search_selected">
            <div class="search_select">
                <div class="search_selected_title">你已选择</div>
                <ul class="search_selected">
                    <li><span>上海</span><a href="#"></a></li>
                    <li><span>浦东新区</span><a href="#"></a></li>
                    <li><span>主题派对</span><a href="#"></a></li>
                    <li><a href="#" class="search_selected_deleted"> 全部删除</a></li>
                    <div class="clear"></div>
                </ul>
                <div class="clear"></div>
            </div>
            <a href="#" class="search_select_btn" id="search_selected_btn">
                <i class="search_select_icon1"></i>

                <div class="search_select_word clearfix">筛选</div>
            </a>

            <div class="clear"></div>
        </div>
        <div class="search_select_outside" id="search_content">
            <div class="search_select">

                <div class="search_select_content">
                    <div class="search_select_section">
                        <div class="search_select_section_left">
                            行业类型
                        </div>
                        <ul id="search_industry_type" class="search_select_section_right">
                            <li>黄浦区</li>
                            <li>静安区</li>
                            <li>长宁区</li>
                            <li class="search_select_active">徐汇区</li>
                            <li>普陀区</li>
                            <li>松江区</li>
                            <li>虹口区</li>
                            <li>杨浦区</li>
                            <li>闵行区</li>
                            <li>闸北区</li>
                            <li>宝山区</li>
                            <li>嘉定区</li>
                            <li>青浦区</li>
                            <div class="clear"></div>
                        </ul>
                        <div class="clear"></div>
                    </div>
                    <div class="search_select_section">
                        <div class="search_select_section_left">
                            活动类型
                        </div>
                        <ul id="search_activity_type" class="search_select_section_right">
                            <li>商业发布</li>
                            <li>展览展示</li>
                            <li>主题派对</li>
                            <li class="search_select_active">文体娱乐</li>
                            <li>会议会务</li>
                            <li>演场演出</li>
                            <li>晚会年会</li>
                            <li>新品发布会</li>
                            <li>培训演讲</li>
                            <li>推广路演</li>
                            <li>亲子活动</li>
                            <li>宴会会议</li>
                            <li>时尚走秀</li>
                            <li>艺术品展出</li>
                            <li>体验品鉴会</li>
                            <li>主题展览</li>
                            <li>颁奖晚会/盛典</li>
                            <div class="clear"></div>
                        </ul>
                        <div class="clear"></div>
                    </div>
                    <div class="search_select_section">
                        <div class="search_select_section_left">
                            场地面积
                        </div>
                        <ul id="search_area_type" class="search_select_section_right">
                            <li>小于200㎡</li>
                            <li>200-500㎡</li>
                            <li>500-800㎡</li>
                            <li>800-1000㎡</li>
                            <li class="search_select_active">1000-2000㎡</li>
                            <li>2000㎡以上</li>
                            <div class="clear"></div>
                        </ul>
                        <div class="clear"></div>
                    </div>
                </div>
            </div>
            <a href="#" class="search_select_btn" id="search_content_btn">
                <i class="search_select_icon"></i>

                <div class="search_select_word clearfix">收起</div>
            </a>

            <div class="clear"></div>
        </div>
        {*搜索无结果*}
        <div class="search-no">
            <div class="search-no-fig">找到相关场地0个</div>
            <div class="search-no-title">抱歉，没有找到与“<span>奢居会</span>”相关的场地内容！</div>
            <p class="search-no-suggest">建议您：</p>
            <ul class="search-no-suggest-content">
                <li>“<a href="#" class="search-no-back-home">返回首页</a>” 或“<a href="" class="search-no-refresh" onclick="window.location.reload();">刷新</a>”。</li>
                <li>任何咨询、建议、意见请找<a href="mailto:service@yunspace.com.cn" class="search-no-mail"> service@yunspace.com.cn</a>。</li>
                <li>检查输入的文字是否有无。</li>
            </ul>
        </div>
    </div>
    {*右边*}
    <div class="search_content_right_no clearfix">
        <ul class="search-no-right">
            <li style="padding-top: 0px;">
                <p class="search-no-right-img"><a href="#"><img src="css/search.v4.0/img/search-no-icon1.png"></a></p>
                <p class="search-no-right-title"><a href="{Web_Global::createRentSpaceUrl()}">一键租场地</a></p>
                <p class="search-no-right-word">
                    <a href="#">
                        为活动方在上千家场地中挑选最合适的活动场地，为客户省去挑选场地所耗费的时间成本； 全方位的数据档方位期<span1>“键租场地”</span1>
                    </a>
                </p>
            </li>
            <li>
                <p class="search-no-right-img"><a href="#"><img src="css/search.v4.0/img/search-no-icon2.png"> </a></p>
                <p class="search-no-right-title"><a href="#">我有场地要出租</a></p>
                <p class="search-no-right-word">
                    <a href="#">
                        为活动方在上千家场地中挑选最合适的活动场地，为客户省去挑选场地所耗费的时间成本； 全方位的数据信息提期<span2>“我有场地要出租”</span2>
                    </a>
                </p>
            </li>
            <li style="border-bottom: none;">
                <div class="search-no-right-weixin">
                    <img src="img/qrcode_space.png">
                </div>
                <div class="search-no-right-content">
                    <div class="search-no-weixin-title">举起手机，扫一扫关注</div>
                    <div class="search-no-weixin-word">云·space微信公众号<br>随时随地获取方案</div>
                </div>
                <div class="clear"></div>
            </li>
        </ul>

    </div>
</div>







{include file="Web_Static::inc/public_space.tpl"}
{include file="Web_Static::inc/html_footer.tpl"}
{static "core/yunspace.js"}
{static "search.v4.0/search.js"}
</body>
</html>