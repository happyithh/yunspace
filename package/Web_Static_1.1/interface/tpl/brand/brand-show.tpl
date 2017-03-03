<!DOCTYPE html>
<html>
<head>
    {include file="Web_Static::v2.0/html_head.tpl"}
    <link rel="stylesheet" type="text/css" href="css/v2.0/common.css">
    <link rel="stylesheet" type="text/css" href="css/raiders/raiders-info.css">
    <link rel="stylesheet" type="text/css" href="css/brand/brand.css">
    <link rel="stylesheet" type="text/css" href="css/brand/album.css">
    <script src="js/brand/slides-1.1.1-min.js" type="text/javascript"></script>
</head>
<body>
{include file="Web_Static::v2.0/html_header3.1.tpl"}
<div class="brand_container">
    <p class="brand_site"><a href="#">上海</a>&nbsp;>&nbsp;<a href="#">活动品牌</a>&nbsp;>&nbsp;<a href="#">丰田汽车</a> </p>
    <div class="brand_list_left">
        <div class="brand_info_title">
            <div class="brand_logo">
                <img src="img/brand/brand.jpg">
            </div>
            <div class="brand_name">
                丰田汽车公司（TOYOTA MOTOR CORPORATION）
            </div>
            <div class="clear"></div>
        </div>

    </div>



    <div class="clear"></div>
</div>



<script type="text/javascript">
    $(function(){
        $('#sildes').olvSlides(
                {
                    thumb:true,
                    thumbPage:true,
                    thumbDirection:"Y",
                    effect:'fade'

                }
        );
    })
</script>
</head>
<body>
<div class="wrap">
    <p class="show-title">品牌展示</p>
    <div id="sildes">
        <div class="cont">
            <div class="control">
                <ul class="change">

                </ul>
            </div>
        </div>
        <div class="thumbWrap">
            <div class="all-pic">所有图片</div>
            <div class="thumbCont">
                <ul>

                    <!-- img属性, url=url, text=描述, bigimg=大图, alt=标题  -->

                    <li><div><img src="img/brand/a_0.jpg" url="url" bigImg="/package/Web_Static_1.1/interface/assets/img/brand/a.jpg" alt="1/11"></div></li>
                    <li><div><img src="img/brand/b_0.jpg" url="url" bigImg="/package/Web_Static_1.1/interface/assets/img/brand/b.jpg" alt="2/11"></div></li>
                    <li><div><img src="img/brand/c_0.jpg" url="url" bigImg="/package/Web_Static_1.1/interface/assets/img/brand/c.jpg" alt="3/11"></div></li>
                    <li><div><img src="img/brand/d_0.jpg" url="url" bigImg="/package/Web_Static_1.1/interface/assets/img/brand/d.jpg" alt="4/11"></div></li>
                    <li><div><img src="img/brand/a_0.jpg" url="url" bigImg="/package/Web_Static_1.1/interface/assets/img/brand/a.jpg" alt="5/11"></div></li>
                    <li><div><img src="img/brand/b_0.jpg" url="url" bigImg="/package/Web_Static_1.1/interface/assets/img/brand/b.jpg" alt="6/11"></div></li>
                    <li><div><img src="img/brand/c_0.jpg" url="url" bigImg="/package/Web_Static_1.1/interface/assets/img/brand/c.jpg" alt="7/11"></div></li>
                    <li><div><img src="img/brand/d_0.jpg" url="url" bigImg="/package/Web_Static_1.1/interface/assets/img/brand/d.jpg" alt="8/11"></div></li>
                    <li><div><img src="img/brand/a_0.jpg" url="url" bigImg="/package/Web_Static_1.1/interface/assets/img/brand/a.jpg" alt="9/11"></div></li>
                    <li><div><img src="img/brand/b_0.jpg" url="url" bigImg="/package/Web_Static_1.1/interface/assets/img/brand/b.jpg" alt="10/11"></div></li>
                    <li><div><img src="img/brand/c_0.jpg" url="url" bigImg="/package/Web_Static_1.1/interface/assets/img/brand/c.jpg" alt="11/11"></div></li>
                </ul>
            </div>
        </div>
    </div>
</div>
<div class="brand_container">
<div class="brand_list_right" style="margin-top: -180px; margin-bottom: 100px;">
    <div class="weixin_left">
        <img src="img/brand/weixin.jpg" alt="云space公众号">
    </div>
    <div class="weixin_right">
        <p class="weixin_p1"><span><img src="img/brand/weixin_icon.jpg" alt="微信icon"> </span>微信扫一扫</p>
        <p class="weixin_p2">关注云SPACE公众号</p>
    </div>
    <div class="clear"></div>
</div>
</div>

{include file="Web_Static::v2.0/form.tpl"}
{include file="Web_Static::v2.0/html_footer.tpl"}
{static "core/yunspace.js"}

</body>
</html>