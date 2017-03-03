<!DOCTYPE html>
<html>
<head>
    {include file="inc/html_head.tpl"}
    <link rel="stylesheet" type="text/css" href="css/css.css">
</head>
<body>
{include file="inc/header_nav.tpl"}
<div class="content">
    <div class="solution_head_back">
        <div class="solution_head_outside">
            <div class="solution_left">
                <img src="img/head_solution.jpg">
            </div>
            <form action="{$_root}demand_submit/solution" method="post">
                <div class="solution_right">
                    <div class="s_title mb15">
                        活动日期
                        <input class="form-control screening" name="data[活动日期]">
                    </div>
                    <div class="s_title mb15">
                        活动规模
                        <input class="form-control screening" name="data[活动规模]">
                    </div>
                    <div class="s_title mb15">
                        活动类型
                        <select class="form-control screening" name="data[活动类型]">
                            {foreach $attr['活动类型'] as $v}
                                <option>{$v}</option>
                            {/foreach}
                        </select>
                    </div>
                    <div class="s_title mb15">
                        活动行业
                        <select class="form-control screening" name="data[活动行业]">
                            {foreach $attr['服务行业'] as $v}
                                <option>{$v}</option>
                            {/foreach}
                        </select>
                    </div>
                    <div class="s_title">
                        <div style="float:left;">具体要求</div>
                        <div style="float:left;">
                            <textarea class="form-control screening1" rows="5" name="data[具体要求]"></textarea>
                        </div>
                        <div class="clear"></div>
                    </div>
                    {*<div class="checkbox checkbox_solution">*}
                    {*<label><input type="checkbox" value="寻求场地" name="data[需求][]" checked="checked">寻求场地</label>*}
                    {*<label><input type="checkbox" value="配套服务" name="data[需求][]">配套服务</label>*}
                    {*</div>*}
                    <button type="submit" class="btn btn-solution">
                        提交需求
                    </button>
                </div>
            </form>

            <div class="clear"></div>
        </div>
    </div>
    {*<div class="wbs">*}
    {*<div class="booking_step  wrap">*}
    {*<div class="title_solution">*}
    {*<div class="title_l"><h2>套餐方案</h2></div>*}
    {*<div class="title_r">*}
    {*<button type="button" class="btn btn-default btn-sm btn_more">*}
    {*查看更多*}
    {*</button>*}
    {*</div>*}
    {*<div class="clear"></div>*}
    {*</div>*}
    {*<div class="solution_product_outside">*}
    {*<div class="solution_product_inside">*}
    {*<div class="solution_item">*}
    {*<div class="solution_icon">时长<br>1天*}
    {*</div>*}
    {*<div class="solution_t">1905咖啡厅*}
    {*</div>*}
    {*<div class="solution_pic">*}
    {*<img src="img/s_pic.jpg"></div>*}
    {*<div class="solution_word">*}
    {*<p1>万怡一天会议套餐</p1>*}
    {*<p2>*}
    {*包括一天会议室场租，包括一天会议室场租，包括一天会议室场租。*}
    {*</p2>*}
    {*<p3>￥5220<span>起</span></p3>*}
    {*<p4>原价￥7410</p4>*}
    {*<div class="clear"></div>*}
    {*</div>*}
    {*<div class="solution_info">*}
    {*<div class="solution_info_l">*}
    {*<span1>88</span1>*}
    {*<span2>人已浏览</span2>*}
    {*</div>*}
    {*<div class="solution_info_r">*}
    {*<span2>人均</span2>*}
    {*<span1>￥373</span1>*}
    {*</div>*}
    {*<div class="clear"></div>*}
    {*</div>*}
    {*</div>*}
    {*<div class="solution_item">*}
    {*<div class="solution_icon">时长<br>1天*}
    {*</div>*}
    {*<div class="solution_t">1905咖啡厅*}
    {*</div>*}
    {*<div class="solution_pic">*}
    {*<img src="img/s_pic.jpg"></div>*}
    {*<div class="solution_word">*}
    {*<p1>万怡一天会议套餐</p1>*}
    {*<p2>*}
    {*包括一天会议室场租，包括一天会议室场租，包括一天会议室场租。*}
    {*</p2>*}
    {*<p3>￥5220<span>起</span></p3>*}
    {*<p4>原价￥7410</p4>*}
    {*<div class="clear"></div>*}
    {*</div>*}
    {*<div class="solution_info">*}
    {*<div class="solution_info_l">*}
    {*<span1>88</span1>*}
    {*<span2>人已浏览</span2>*}
    {*</div>*}
    {*<div class="solution_info_r">*}
    {*<span2>人均</span2>*}
    {*<span1>￥373</span1>*}
    {*</div>*}
    {*<div class="clear"></div>*}
    {*</div>*}
    {*</div>*}
    {*<div class="solution_item">*}
    {*<div class="solution_icon">时长<br>1天*}
    {*</div>*}
    {*<div class="solution_t">1905咖啡厅*}
    {*</div>*}
    {*<div class="solution_pic">*}
    {*<img src="img/s_pic.jpg"></div>*}
    {*<div class="solution_word">*}
    {*<p1>万怡一天会议套餐</p1>*}
    {*<p2>*}
    {*包括一天会议室场租，包括一天会议室场租，包括一天会议室场租。*}
    {*</p2>*}
    {*<p3>￥5220<span>起</span></p3>*}
    {*<p4>原价￥7410</p4>*}
    {*<div class="clear"></div>*}
    {*</div>*}
    {*<div class="solution_info">*}
    {*<div class="solution_info_l">*}
    {*<span1>88</span1>*}
    {*<span2>人已浏览</span2>*}
    {*</div>*}
    {*<div class="solution_info_r">*}
    {*<span2>人均</span2>*}
    {*<span1>￥373</span1>*}
    {*</div>*}
    {*<div class="clear"></div>*}
    {*</div>*}
    {*</div>*}
    {*</div>*}
    {*</div>*}
    {*</div>*}
    {*</div>*}
    <div class="solution_process_p wrap">
        <img src="img/solution_pic.jpg"/>
        <img src="img/e1.jpg">
    </div>
</div>
{include file="Web_Static::v2.0/html_footer.tpl"}
</body>
</html>