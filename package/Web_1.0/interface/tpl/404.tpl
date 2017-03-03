<!DOCTYPE html>
<html>
<head>
    {include file="Web_Static::v2.0/html_head.tpl"}
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
</head>
<body>
{include file="Web_Static::v2.0/html_header3.1.tpl"}
<style>
     .mian{
         width:800px;
         margin:0 auto;
         padding:110px 0;
     }
    .no_img{
        float:left;
        width: 48%;
    }
    .no_img img{
        width:100%;
    }
    .found{
        float: left;
        margin-top: 60px;
        text-align: right;
        width: 50%;
    }
    h1{
        font-weight: bold;
        font-size:80px;
        color:#7f8f8f
    }
    .error{
        font-size: 25px;
        color:#77777a;
    }
    .text{
        font-size: 25px;
        color:#5d5d5e;
        margin-top:10px;
    }
    .index{
        margin-top: 30px;
        float: right;
        display: block;
        width:35%;
        color:#ffffff;
        text-align: center;
        line-height: 33px;
        background: #f54545;
        margin-right: 30px;
    }
    .back{
        margin-top: 30px;
        float: right;
        display: block;
        width:35%;
        color:#ffffff;
        text-align: center;
        line-height: 33px;
        background: #01c3c3;
    }
    @media (max-width: 1024px){
        .mian{
            width: 100%;
            padding: 90px 0;
        }
        .top,.no_img,.header3-bg{
            display:none
        }
        .found{
            margin-top: 50px;
            text-align:center;
            width: 100%;
        }
        h1{
            font-weight: bold;
            font-size:50px;
            color:#7f8f8f
        }
        .error{
            font-size: 20px;
            color:#77777a;
        }
        .text{
            font-size: 20px;
            color:#5d5d5e;
        }
        .index{
            margin-top: 25px;
            float: left;
            display: block;
            width:50%;
            color:#ffffff;
            margin: 0 auto;
            text-align: center;
            line-height: 50px;
            background: #f54545;
            font-size: 16px;
        }
        .back{
            margin-top: 25px;
            display: block;
            float: left;
            color:#ffffff;
            width:50%;
            margin: 0 auto;
            text-align: center;
            line-height: 50px;
            background: #01c3c3;
            font-size: 16px;
        }
        .code{
            width :92%;
            margin:50px auto;
        }
        .bottom-outside{
            position: absolute;
            bottom:0;
        }
    }
</style>

<div class="mian clearfix">

    <div class="no_img">
        <img src="images/s1.png" alt="" style="float:right;"/>
    </div>
    <div class="found">
        <h1>404</h1>
        <p class="error">ERROR PAGE</p>
        <p class="text" >页面不见了，建议您</p>
        <p class="code clearfix"><a href="javascript:;" onclick="goBack()" class="back">后退一步</a><a href="{$_root}" class="index">返回首页</a></p>
    </div>
</div>

<script>
    function goBack()
    {
        window.history.back()
    }
</script>

{include file="Web_Static::v2.0/form.tpl"}
{include file="Web_Static::v2.0/html_footer.tpl"}
</body>
</html>