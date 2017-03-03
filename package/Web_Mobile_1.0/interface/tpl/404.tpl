<!DOCTYPE html>
<html>
<head>

    {include file="Web::inc/html_head.tpl" owl=1}

</head>
<body>
{include file="Web::inc/header_nav.tpl"}
<style>
     .mian{
         width:100%;
         height:635px;
         background: url('{$_assets}img/s3.png');
         padding-top:95px;
     }
    .contents{
        width:100%;
        margin:0 auto;
        padding:0px 100px;
    }
    .row{
        margin-right: 0px;
    }
    .found{
        margin-top: 50px;
        text-align: right;
        padding-right:100px;
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
        color:#5d5d5e
    }
    .index{
        margin-top: 20px;
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
        margin-top: 20px;
        float: right;
        display: block;
        width:35%;
        color:#ffffff;
        text-align: center;
        line-height: 33px;
        background: #01c3c3;
    }
    @media (max-width: 1024px){
        .no_img{
            display:none
        }
        .found{
            margin-top: 50px;
            text-align:center;
            padding-left: 0px;
            padding-right:0px;
        }
        .contents{
            width:100%;
            margin:0 auto;
            padding:0px;
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
            color:#5d5d5e
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

            width :100%;
            margin:0 auto;
            margin-top: 20px;
        }
    }
</style>

<div class="mian">
    <div class="container">
        <div class="row contents" >
            <div class="col-md-6 no_img">
                <img src="img/s1.png" alt="" style="float:right;"/>
            </div>
            <div class="col-md-6 col-sm-12 found">
                <h1>404</h1>
                <p class="error">ERROR PAGE</p>
                <p class="text" >页面不见了，建议您</p>
                <p class="row code "><a href="javascript:;" onclick="goBack()" class="back col-sm-6 col-xs-6">后退一步</a><a href="{$_root}" class="index  col-sm-6 col-xs-6">返回首页</a></p>
            </div>
        </div>
    </div>
</div>
<script>
    function goBack()
    {
        window.history.back()
    }
</script>
{include file="Web::inc/html_footer.tpl"}
</body>
</html>