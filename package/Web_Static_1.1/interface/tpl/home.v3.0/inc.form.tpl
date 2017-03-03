<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    {static "v2.0/header.css"}
    {static "home.v3.0/home.css"}
    {static "home.v3.0/form.js"}
    {static "home.v3.0/data-picker.css"}
    <link rel="stylesheet" href="plugins/ionicons-master/css/ionicons.min.css">
    <script src="js/jquery-1.9.1.min.js"></script>
    <title></title>
</head>
<body>


    <div class="demand-full">


        <div class="d-s-form">
            <div class="d-s-name"><i style="color:#ff0000"></i>预算范围</div>
            <div class="d-s-input">
                <input type="text" class="hide select-input range-input"  name="pre_range" value="2万"/>
                <div class="d-s-input-val select-click select4"><div style="font-size:14px;" class="par5">2万</div><span class="ion-arrow-down-b p-r-icon"  style="color:#c5c5c5"></span></div>
                <span class="down"></span>
                <div class="drop-down-home dropDown pre-range hide" style="z-index:14500!important;background:rgba(255,255,255,1);z-index:12000;border-color: #c4c4c4 ;border-top:none;margin-left:-1px;"  data-drop="1">
                    <ul style="height: 164px;">
                        <li>
                            2万以下
                            {*<a href="" class="two_m" style="color:#000">2万以下</a>*}
                            {*<ul class="lt_two hide">*}
                            {*<li>5千</li>*}
                            {*<li>1万</li>*}
                            {*<li>1万到2万</li>*}
                            {*</ul>*}
                        </li>
                        <li>2-5万</li>
                        <li>5-10万</li>
                        <li>10万以上</li>
                    </ul>
                </div>
            </div>
            <div class="clear"></div>
        </div>

        <div class="d-s-form">
            <div class="d-s-name">活动日期</div>
            <div class="d-s-input">
                <input type="text" id="datepicker" readonly name="act_date" class="datePicker" placeholder="请在下方选择活动日期"/>
            </div>
            <div yun="data-picker/js/date-picker.js::initPlugin" class=" date-picker" yun-input=".datePicker" yun-time_show="false"
                 style="top:40px;width:261px;border:1px solid #c4c4c4"
                 yun-with-input="false"> </div>
            <div class="clear"></div>
        </div>

        {*<div class="d-s-form">*}
            {*<div yun="data-picker/js/date-picker.js::initPlugin" class=" date-picker" yun-input=".datePicker"*}
                 {*style="top:50px;width:261px;"*}
                 {*yun-with-input="false"> </div>*}
            {*<div class="clear"></div>*}
        {*</div>*}

        {*<div class="d-s-form">*}
            {*<div class="d-s-name">其他要求</div>*}
            {*<div class="d-s-input">*}
                {*<input type="text" name="other_demand" placeholder="填写更多详细信息，帮助你快速找到合适的场地" class="other-demand" />*}
            {*</div>*}
            {*<div class="clear"></div>*}
        {*</div>*}
    </div>
</div>
    {*{static "home.v3.0/homepage.js"}*}
    {static "core/yunspace.js"}
</body>
</html>