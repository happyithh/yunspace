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
        uaredirect('http://www.yunspace.com.cn/feature_mobile/2015.5/party/salon.html');
    </script>
    {include file="inc/html_head.tpl" owl=1}
    <link href="css/pr.css" type="text/css" rel="stylesheet">
</head>
<body>
{include 'inc/header_nav.tpl'}

<div class="party_head">
    <img src="img/sb1.jpg" alt="沙龙如果在一个电影中的场景举办配上花式鸡尾酒,还怕没人来?"/>
    <img src="img/sb2.jpg" alt="沙龙如果在一个电影中的场景举办配上花式鸡尾酒,还怕没人来?"/>
    <img src="img/sb3.jpg" alt="沙龙如果在一个电影中的场景举办配上花式鸡尾酒,还怕没人来?"/>
    <img src="img/sb4.jpg" alt="沙龙如果在一个电影中的场景举办配上花式鸡尾酒,还怕没人来?"/>
</div>

<!----胡同里101---->
<div class="content_text">
    <p><img src="img/htl_t.png" alt="胡同里101"/> </p>
    <p>胡同里101是由旧上海四大上海滩大亨之一”黄金荣 ”的私家粮仓改造，紧临黄浦江保留了1927年红松木地板，承载着历史沧桑的木柱和点点斑驳的老墙。</p>
    <p>
        <span>市场价：￥2000 </span>
        <span style="margin-right: 0px;">云·SPACE特价：</span>
        <span1 style="color:#ea9931;">￥1499</span1>
        <span>容纳人数：30人</span>
    </p>
    <p>
        <a href="http://www.yunspace.com.cn/set_info/29.html" type="button" target="_blank" class="btn5">点击查看详情</a>
        <img src="img/htl_z.png" alt="7.4折" style="padding-bottom: 3px;"/>
    </p>
   <p> <img src="img/htl_p.jpg" alt="沙龙如果在一个电影中的场景举办配上花式鸡尾酒,还怕没人来?"/></p>
</div>
<!---end---->

<!----新时线--->
<div class="party_back1">
    <div class="content_text">
        <p><img src="img/xsx_t.png" alt="新时线媒体艺术空间"/> </p>
        <p>新视线媒体艺术中心是国内第一家专注于新媒体艺术实验、制作、研究、展览及教育的非盈利性艺术机构!</p>
        <p >
            <span>市场价：￥19400</span>
            <span style="margin-right: 0px;">云·SPACE特价：</span>
            <span1 style="color: #1bd6b1;">￥13999 </span1>
            <span>容纳人数：100人</span>
        </p>
        <p>
            <a href="http://www.yunspace.com.cn/set_info/26.html" type="button" target="_blank" class="btn6">点击查看详情</a>
            <img src="img/xsx_z.png" alt="7.2折" style="padding-bottom: 3px;"/>
        </p>
        <p> <img src="img/xsx_p.jpg" alt="沙龙如果在一个电影中的场景举办配上花式鸡尾酒,还怕没人来?"/></p>
    </div>
</div>
<!---end---->

<!----THE BOOK---->
<div class="content_text">
    <p><img src="img/tb_t.png" alt="the book room &cafe"/> </p>
    <p>书店？咖啡馆？当心别被它文艺的外表所欺骗！可当你慢慢推开塞满书籍的巨大书架时，将会发现一条通往二楼隐秘的酒廊！</p>
    <p>
        <span>市场价：￥15000 </span>
        <span style="margin-right: 0px;">云·SPACE特价：</span>
        <span1 style="color:#ee246d;">￥8499</span1>
        <span>容纳人数：50人</span>
    </p>
    <p>
        <a href="http://www.yunspace.com.cn/set_info/28.html" type="button" target="_blank" class="btn7">点击查看详情</a>
        <img src="img/tb_z.png" alt="5.6折" style="padding-bottom: 3px;"/>
    </p>
    <p> <img src="img/tb_p.jpg" alt="沙龙如果在一个电影中的场景举办配上花式鸡尾酒,还怕没人来?"/></p>
</div>
<!---end---->


{include file="inc/html_footer.tpl"}
</body>
</html>