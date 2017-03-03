<!DOCTYPE>
<html>
<head>
    {include file="Web_Mobile_Static::inc/header_meta.tpl"}
    <meta name="full-screen" content="yes" />
    <meta name="x5-fullscreen" content="true" />
    {static "comment/comment.css"}
    {static "sign_in/sign_in.css"}
    <!--引用百度地图API-->
    <script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=aaNCRRcGGai6klHMOGZ8yBbP"></script>
</head>
<body style="background: #eaeaea;">
<div class="sign-title">
    {*<div class="fl state">*}
        {*<p class="icon-state-dai">签</p>*}
        {*<h3>待签到</h3>*}
    {*</div>*}

    {*<div class="fl state clearfix">*}
        {*<p class="icon-state-refuse">拒</p>*}
        {*<h3>审核拒绝</h3>*}
    {*</div>*}

    {*<div class="fl state clearfix">*}
        {*<p class="icon-state-shen">审</p>*}
        {*<h3>审核中</h3>*}
    {*</div>*}

    <div class="fl state clearfix">
        <p class="icon-state-hv">签</p>
        <h3>已签到</h3>
    </div>
</div>
<div class="refuse-reason">
    <p>拒绝理由：今天要开周会</p>
</div>

<div class="sign-cont">
    <ul class="sign-cont-ul">
        <li class="clearfix"><span>离开时间：</span><p class="dtl">2015-09-25 9:00</p></li>
        <li class="clearfix"><span>返回时间：</span><p class="dtl">2015-09-25 9:00</p></li>
        <li class="clearfix"><span>外出地址：</span><p class="dtl">云SPACE宝山秀场</p></li>
        <li class="clearfix"><span>外出事由：</span><p class="dtl">客户对宝山秀场感兴趣，带他去看场地客户对宝山秀场感兴趣，带他去看场地
</p></li>
        <li class="clearfix li-map"><span>外出位置：</span>
            <div class="dtl">
                <div class="sign-map" id="map">
                    {*<div id="map" style="width: auto;height: 100%;overflow: hidden;"></div>*}

                </div>
                <div id="js-sign-map-adress" class="sign-map-adress">正在获取位置...</div>
            </div>
        </li>
    </ul>
    {*<input type="button" value="外出签到" class="btn-goout">*}
</div>
{static "v1.0/jquery-1.11.1.min.js"}
<script>
    var map = new BMap.Map('map');
    map.centerAndZoom(new BMap.Point(121.491, 31.233), 18);

    //经纬度
    var new_point = new BMap.Point(121.491, 31.243);
    var marker = new BMap.Marker(new_point);  // 创建标注
    map.addOverlay(marker);              // 将标注添加到地图中
    map.panTo(new_point);

    var geoc = new BMap.Geocoder();
    geoc.getLocation(new_point, function(rs){
        var addComp = rs.addressComponents;
//        alert(addComp.province + ", " + addComp.city + ", " + addComp.district + ", " + addComp.street + ", " + addComp.streetNumber);

        //定位地址
        $('#js-sign-map-adress').text(addComp.city+addComp.district+addComp.street+addComp.streetNumber)
    });

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

</script>
</body>
</html>
