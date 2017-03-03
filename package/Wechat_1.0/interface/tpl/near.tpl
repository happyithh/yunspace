<!DOCTYPE html>
<html>
<head lang="en">
    {include file="Web::inc/html_head.tpl"}
    <meta name="viewport" content="width=divice-width,initial-scale=1"/>
    <link rel="stylesheet" type="text/css" href="css/css.css">
    <link rel="stylesheet" type="text/css" href="css/owl.carousel.css">
    <link rel="stylesheet" type="text/css" href="css/owl.theme.css">
    <script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=aaNCRRcGGai6klHMOGZ8yBbP"></script>
    <script src="js/base.js"></script>
    <title></title>
    <style>
        <style>
        .clear{
            clear: both;
        }
        a:hover{
            text-decoration:none;
        }
        body{
            position: relative;
            font-family:微软雅黑, microsoft yahei, Arial, sans-serif;
            background: #ededed;
        }
        .main{
            width:100%;
            margin-bottom: 42px;

        }
        header{
            width:100%;
            height:42px;
            background: #d5d5d5;
        }
        .near_market{
            line-height: 42px;
            text-align: center;
            font-weight: bold;
            font-size: 15px;
            color:#000000;
        }
        .footer{
            width:100%;
            height:40px;
            background: #f9f9f9;
            position:fixed;
            bottom:0px;
        }
        .model{
            position:relative;
            float: left;
            margin:14px 14px 10px 14px;
            border-radius: 5px;
            box-shadow: 3px 3px 3px #dcdcdc;
            background: #ffffff;
            width:90%;
        }
        .model_img{
            width:100%;
        }
        .model_img img{
            width:100%;
            height:150px;
        }
        .left{
            float:left;
            width:20%;
            text-align: center;
            margin-top: 5px;
            font-size: 15px;
            line-height: 35px;
            border-right:1px solid #eaeaea;
        }
        .menu{
            float:right;
            width:20%;
            text-align: center;
            margin-top: 7px;
            font-size: 15px;
            line-height: 35px;
            border-left:1px solid #eaeaea;
        }
        .center{
            float:left;
            width:60%
        }
        .next{
            text-align: center;
        }
        .change{
            display: block;
            width:100%;
            font-size: 10px;
            line-height: 42px;
            text-align: center;

        }
        .message{
            padding:10px;
        }
        .message-list{
            width:50%;
            line-height: 15px;
            font-size: 12px;;
        }
        .model_title{
            color: #ffffff;
            font-weight: bold;
            position: absolute;
            top:100px;
            left:10px;
        }
        .logo_img{
            width:100%
        }
        /*.bgc {*/
            /*width: 100%;*/
            /*position: absolute;*/
            /*top: 0px;*/
            /*background: rgba(0, 0, 0, 1);*/
        /*}*/
    </style>

</head>

<body>
{include file="Web::inc/header_nav.tpl"}
<div class="main">
    <header>
        <p class="near_market">附近商场</p>
    </header>
    <div id="allmap"></div>
        <div class="content">

        </div>
    <div class="clearfix"></div>
    <div class="footer">
        <div class="left">
            <a href="" style="display: block;color:#80a4d6"><span class="glyphicon glyphicon-menu-left"></span></a>
        </div>
        <div class="center">
            <div class="next ">
                <span class=""></span>
                <a href="" class="change">换一组</a>
            </div>
        </div>
        <div class="menu">
            <a href="" style="display: block;color:#80a4d6"><span class="glyphicon glyphicon-option-horizontal"></span></a>
        </div>
    </div>
</div>
<script type="text/javascript" src=" http://int.dpool.sina.com.cn/iplookup/iplookup.php?format=js"></script>
<script>
    $(function(){
        {foreach $_data as $key=>$v}
        var map = new BMap.Map("allmap");
        var point = new BMap.Point(116.331398,39.897445);
        map.centerAndZoom(point,12);
        var geolocation = new BMap.Geolocation();
        geolocation.getCurrentPosition(function(r){
            if(this.getStatus() == BMAP_STATUS_SUCCESS){
                var mk = new BMap.Marker(r.point);
                map.addOverlay(mk);
                map.panTo(r.point);
                console.log(r.point);
                map.centerAndZoom(remote_ip_info['city'],12);  //初始化地图,设置城市和地图级别。
                console.log({$v['geo_lng']});
                console.log({$v['geo_lat']});
                    var pointA = new BMap.Point(r.point.lng,r.point.lat);
                    var pointB = new BMap.Point({$v['geo_lng']},{$v['geo_lat']});
                    var distance=(map.getDistance(pointA,pointB)).toFixed(2);

                if(distance<=5000){
                    var distan=parseInt(distance/10)*10;
                    var info='<div class="model">'
                            +'<a href="">'
                            +'<div class="model_img"><img src="{$v['logo']}" alt="" class="logo_img"/></div>'
                            +'<div class="bgc"><div class="model_title">{$v["event_name"]}</div></div>'
                            +'</a>'
                            +'<div class="message">'
                            +'<p class="message-list"  style="float: left;">活动类型:{$v["attr"]["类型"]}</p>'
                            +'<p class="message-list" style="float: right;color:#989898;width:40%">{$v["event_time"]}</p>'
                            +'<div class="clear"></div>'
                            +'<p class="message-list" style="float:left;color:#666666;" id="addr"><span class="glyphicon glyphicon-map-marker"></span> &nbsp;{$v["addr"]}</p>'
                            +'<p  class="message-list" style="float: right;color:#989898;width:40%">距离：'+parseInt(distan)+' 米。</p>'
                            +'<p class="lng" style="display: none">{$v['geo_lng']}</p><p class="lat" style="display: none">{$v["geo_lat"]}</p>'
                            +'</div>'
                            +'</div>';
                    $('.content').append(info);
                }

            }
            else {
                alert('failed'+this.getStatus());
            }
        },{
            enableHighAccuracy: true
        })

        {/foreach}
    })
</script>
</body>
</html>