<!DOCTYPE html>
<html>
<head>
    <script type='text/javascript'>
        function uaredirect(murl){
            try {
                if(document.getElementById("bdmark") != null){
                    return;
                }
                var urlhash = window.location.hash;
                if (!urlhash.match("fromapp")){
                    if ((navigator.userAgent.match(/(iPhone|iPod|Android|ios|iPad)/i))) {
                        location.replace(murl);
                    }
                }
            } catch(err){ }
        }
        uaredirect('http://www.yunspace.com.cn/feature_mobile/2015.5/annual_meeting/index.html');
    </script>
    {include file="inc/html_head.tpl" owl=1}
    <link href="css/pr.css" type="text/css" rel="stylesheet">
</head>
<body>
{include 'inc/header_nav.tpl'}

<div class="party_head">
    <img src="img/nhft1.jpg" alt="一年一会，做老板就应该对自己的员工好一点！"/>
    <img src="img/nhft2.jpg" alt="一年一会，做老板就应该对自己的员工好一点！"/>
    <img src="img/nhft3.jpg" alt="一年一会，做老板就应该对自己的员工好一点！"/>
    <img src="img/nhft4.jpg" alt="一年一会，做老板就应该对自己的员工好一点！"/>
</div>

<!----胡同里101---->
<div class="content_text">
    <p><img src="img/nht1.png" alt="云·SPACE秀场"/> </p>
    <p>以商务办公，创意创业，现代产业园为主体，区域内商业的时尚汇聚地和潮流风向标业态满足目标客户需求的，更丰啊富贴切的吸引更多的品牌概念客户在项目中形成集聚效应。</p>
    <p>
        <span style="margin-right: 0px;">云·SPACE特价：</span>
        <span1 style="color:#36c0d4;">￥3299/桌</span1>
        <span>容纳人数：40~50桌（40桌起订）</span>
    </p>
    <p>
        <a href="http://www.yunspace.com.cn/set_info/33.html" type="button" target="_blank" class="btn8">点击查看详情</a>
    </p>
   <p> <img src="img/bsb.jpg" alt="一年一会，做老板就应该对自己的员工好一点！"/></p>
</div>
<!---end---->

<!----新时线--->
<div class="party_back1">
    <div class="content_text">
        <p><img src="img/nht2.png" alt="玫瑰婚典壹号会馆"/> </p>
        <p>会馆主体建筑风格独特，是ARTDECO大师邬达克的力作。会馆三面临水，千米长的亲水岸线沿苏州河蜿蜒而行，富于韵味的人文背景、生趣盎然的天然景观构成会馆独一无二的特色。</p>
        <p >
            <span style="margin-right: 0px;">云·SPACE特价：</span>
            <span1 style="color: #964a95;">￥2899/桌 </span1>
            <span>容纳人数：15~22桌（15桌起订）</span>
        </p>
        <p>
            <a href="http://www.yunspace.com.cn/set_info/34.html" type="button" target="_blank" class="btn9">点击查看详情</a>
        </p>
        <p> <img src="img/mghb1.jpg" alt="一年一会，做老板就应该对自己的员工好一点！"/></p>
    </div>
</div>
<!---end---->

<!----THE BOOK---->
<div class="content_text">
    <p><img src="img/nht3.png" alt="墨西哥艺术中心"/> </p>
    <p> 墨西哥馆是一座由“风筝”组成的奇幻世界。在墨西哥，风筝代表人们对未来美好生活的期盼。</p>
    <p>
        <span style="margin-right: 0px;">云·SPACE特价：</span>
        <span1 style="color:#cb662d;">￥2599/桌</span1>
        <span>容纳人数：20~28桌（20桌起订）</span>
    </p>
    <p>
        <a href="http://www.yunspace.com.cn/set_info/35.html" type="button" target="_blank" class="btn10">点击查看详情</a>
    </p>
    <p> <img src="img/mxgb.jpg" alt="一年一会，做老板就应该对自己的员工好一点！"/></p>
</div>
<!---end---->


{include file="inc/html_footer.tpl"}
</body>
</html>