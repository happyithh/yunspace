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

<div style="position: fixed;left:0%;top:0%;z-index: 15000;display: none"  class="loading">
    <img src="img/home.v3.0/loading.gif" alt="" style="width:100%;height:auto">
</div>
{*<div class="submit-success">*}
    {*<div class="demand-close"><span class="ion-close"></span></div>*}
    {*<div class="success-title"><span class="ion-ios-lightbulb-outline"></span>&nbsp;&nbsp;提交成功</div>*}
    {*<div class="success-con">小二正在为您查找匹配，30分钟后为你提供报价！</div>*}
    {*<div class="success-btn">*}
        {*<p>您可以继续完善信息，方便您快速找到适配场地</p>*}
        <div class="home_question">
            <p>1、您是否需要比较有逼格的场地环境？</p>
            <div class="radio">
                <input type="radio" name="envir_ok1" class="ans" id="question1">
                <label for="question1">&nbsp;&nbsp;是</label>
            </div>
            <div class="radio">
                <input type="radio" name="envir_ok1" class="ans" id="question2">
                <label for="question2">&nbsp;&nbsp;不是</label>
            </div>
        </div>
        <div class="home_question hide">
            <p>2、您是否需要比较有逼格的场地环境？</p>
            <div class="radio">
                <input type="radio" name="envir_ok2" class="ans" id="question1">
                <label for="question1">&nbsp;&nbsp;是</label>
            </div>
            <div class="radio">
                <input type="radio" name="envir_ok2" class="ans" id="question2">
                <label for="question2">&nbsp;&nbsp;不是</label>
            </div>
        </div>
        <div class="home_question hide">
            <p>3、您是否需要比较有逼格的场地环境？</p>
            <div class="radio">
                <input type="radio" name="envir_ok3" class="ans" id="question1">
                <label for="question1">&nbsp;&nbsp;是</label>
            </div>
            <div class="radio">
                <input type="radio" name="envir_ok3" class="ans" id="question2">
                <label for="question2">&nbsp;&nbsp;不是</label>
            </div>
        </div>
        <div class="home_question hide">
            <p>4、您是否需要比较有逼格的场地环境？</p>
            <div class="radio">
                <input type="radio" name="envir_ok4" class="ans" id="question1">
                <label for="question1">&nbsp;&nbsp;是</label>
            </div>
            <div class="radio">
                <input type="radio" name="envir_ok4" class="ans" id="question2">
                <label for="question2">&nbsp;&nbsp;不是</label>
            </div>
        </div>

    {*</div>*}
{*</div>*}
{*{static "home.v3.0/homepage.js"}*}
{static "core/yunspace.js"}
</body>
</html>