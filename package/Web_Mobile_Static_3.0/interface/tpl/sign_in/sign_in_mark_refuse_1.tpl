<!DOCTYPE>
<html>
<head>
    <title>签到详情页面</title>
    {include file="Web_Mobile_Static::inc/header_meta.tpl"}
    <meta name="full-screen" content="yes" />
    <meta name="x5-fullscreen" content="true" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
    {static "comment/comment.css"}
    {static "sign_in/sign_in.css"}
    <title>详情页面</title>
    <!--引用百度地图API-->
    <script type="text/javascript" src="http://map.qq.com/api/js?v=2.exp"></script>
</head>
<body style="background: #eaeaea;">
<div class="sign-title">
    {if count($page->signInDetail) >0}

    <div class="fl state">
        {if $page->signInDetail['status']==1}
        <p class="icon-state-dai">签</p>
        <h3>待签到</h3>
            {elseif $page->signInDetail['status']==0}
            <p class="icon-state-shen">审</p>
            <h3>审核中</h3>
            {elseif $page->signInDetail['status']==-1}
            <p class="icon-state-refuse">拒</p>
            <h3>审核拒绝</h3>
            {elseif $page->signInDetail['status']==2}
            <p class="icon-state-hv">签</p>
            <h3>已签到</h3>
        {/if}
    </div>
    {/if}
</div>
{if $page->signInDetail['status']==-1}
<div class="refuse-reason">
    <p>拒绝理由：{$page->signInDetail['reject_reason']}</p>
</div>
{/if}

<div class="sign-cont">
    <ul class="sign-cont-ul">
        <li class="clearfix"><span>离开时间：</span><p class="dtl">{date('Y-m-d h:i',$page->signInDetail['outside_time'])}</p></li>
        <li class="clearfix"><span>返回时间：</span><p class="dtl">{date('Y-m-d h:i',$page->signInDetail['check_time'])}</p></li>
        <li class="clearfix"><span>公出地址：</span><p class="dtl">{$page->signInDetail['address']}</p></li>
        <li class="clearfix"><span>公出事由：</span><p class="dtl">{$page->signInDetail['outside_reason']}</p></li>
        {if $page->signInDetail['sign_time']}
        <li class="clearfix"><span>签到时间：</span><p class="dtl">{date('Y-m-d h:i',$page->signInDetail['sign_time'])}</p></li>
        <li class="clearfix li-map" data-latitude="{$page->signInDetail['latitude']}" data-longitude="{$page->signInDetail['longitude']}">
            <p class="dtl sign_addr" style="width: 100%;line-height: 24px;"></p>
        </li>
        {/if}

    </ul>
    {if $page->signInDetail['sign_time']}
    <div class="dtl">
        <div class="sign-map" id="map">
            <div id="map" style="width: auto;height: 100%;overflow: hidden;"></div>
        </div>
        {*<div id="js-sign-map-adress" class="sign-map-adress">正在获取位置...</div>*}
    </div>
    {/if}
    {if $page->signInDetail['status']>=1}
    <input type="button" data-id="{Func_NumEncode::e($page->signInDetail['id'])}" id="getLocation" value="公出签到" class="btn-goout">
    {/if}
</div>
{static "v1.0/jquery-1.11.1.min.js"}
<script src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script>
    window.onload = function(){
        //初始化地图函数  自定义函数名init
        function init() {
            //定义map变量 调用 qq.maps.Map() 构造函数   获取地图显示容器
            var latitude=$('.li-map').data('latitude');
            var longitude=$('.li-map').data('longitude');
            var marker = null;
            if(latitude&&longitude){
                var map = new qq.maps.Map(document.getElementById("map"), {
                    center: new qq.maps.LatLng(latitude,longitude),      // 地图的中心地理坐标。
                    zoom:16,                                     // 地图的中心地理坐标。
                    zoomControl: false
                });
                var latLng = new qq.maps.LatLng(latitude, longitude);
                if (marker != null) {
                    marker.setMap(null);
                }
                //设置marker标记
                marker = new qq.maps.Marker({
                    map: map,
                    position: latLng,
                    zoom:16
                });
                $.post('http://{Core::$urls['host']}/static/api/sign/in/get/poi.jsonp', {
                    'lat':latitude,
                    'lng':longitude
                }, function (data) {
                    if (data.status==0) {
                        console.log(data.msg);
                    } else {
                        $('.sign_addr').empty();
                        $('.sign_addr').append('签到位置：'+data.data.result.address+'<br/>位置描述：'+data.data.result.formatted_addresses.recommend);
                    }
                },"json")
            }
        }
        //调用初始化函数地图
        init();
//        $('#js-sign-map-adress').text(addComp.city+addComp.district+addComp.street+addComp.streetNumber)

    }

    //    var geolocation = new BMap.Geolocation();
//    geolocation.getCurrentPosition(function(r){
//        if(this.getStatus() == BMAP_STATUS_SUCCESS){
//            var mk = new BMap.Marker(r.point);
//            map.addOverlay(mk);
//            map.panTo(r.point);
//            console.log(r);
////            alert('您的位置：'+r.point.lng+','+r.point.lat);
//            map.centerAndZoom(new BMap.Point(r.point.lng, r.point.lat), 17);
//
//
//            var geoc = new BMap.Geocoder();
//            geoc.getLocation(r.point, function(rs){
//                var addComp = rs.addressComponents;
//                alert(addComp.province + ", " + addComp.city + ", " + addComp.district + ", " + addComp.street + ", " + addComp.streetNumber);
//            });
//        }
//        else {
//            alert('failed'+this.getStatus());
//        }
//    },{ enableHighAccuracy: true } )
    wx.config({
        debug: false,
        appId: '{$signPackage['appId']}',
        timestamp: '{$signPackage['timestamp']}',
        nonceStr: '{$signPackage['nonceStr']}',
        signature: '{$signPackage['signature']}',
        jsApiList: [
            'getLocation'
            // 所有要调用的 API 都要加到这个列表中
        ]
    });
    $('#getLocation').click(function(){
//    document.querySelector('#getLocation').onclick = function () {
        if(!localStorage.algetlocation){
            localStorage.algetlocation = 1;
            alert('请确保【您的网络正常，GPS已开启】');
        }
        var conf = false;
        {if $page->signInDetail['sign_time']}
            var rs = confirm("你已经签到过了。还要再次签到吗？");
            if(rs){
                conf = true;
            }
        {else}
             conf = true;
        {/if}
        {*{/literal}*}
        if(conf){
            wx.ready(function () {
                //  获取当前地理位置
                wx.getLocation({
                    type: 'gcj02', // 默认为wgs84的gps坐标，如果要返回直接给openLocation用的火星坐标，可传入'gcj02'
                    success: function (res) {
                        var latitude = res.latitude; // 纬度，浮点数，范围为90 ~ -90
                        var longitude = res.longitude; // 经度，浮点数，范围为180 ~ -180。
                        var id = $('#getLocation').data('id');
                        YunSpace.api('sign/in/setLocation.jsonp',{
                            latitude:latitude,longitude:longitude,id:id
                        },function(data){
                            if(data.status ==1){
                                alert(data.msg);
                                location.reload();
                                return false
                            }else{
                                alert(data.msg);
                            }
                        },'json')

                    }
                });

            });
        }


    })
{static "core/yunspace.js"}
</script>
</body>
</html>
