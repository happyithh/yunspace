<!DOCTYPE html>
<!--[if IE 8]>
<html lang="en" class="ie8 no-js"> <![endif]-->
<!--[if IE 9]>
<html lang="en" class="ie9 no-js"> <![endif]-->
<!--[if !IE]><!-->
<html lang="en" class="no-js">
<!--<![endif]-->
<!-- BEGIN HEAD -->
<head>
    <title>{$title}</title>
    <meta content="" name="description"/>
    {include "Admin::inc/html_head.tpl"}
    <style>
        .mask {
            position: fixed;
            top: 0;
            left: 0;
            bottom: 0;
            right: 0;
            background-color: #868484;
            font-size: 20px;
            color: #fff;
            -webkit-box-pack: center;
            -moz-box-pack: center;
            -webkit-box-align: center;
            -moz-box-align: center;

            display: box;
            display: -webkit-box;
            display: -moz-box;
        }

        body .mask {
            display: none;
        }
    </style>

</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->
<body style="background:#FaFaFa !important; position: relative">
<div class="portlet addrConList">
    <div class="portlet-title">
        <div class="caption">
            <i class="fa fa-globe"></i>未收录的公司地址
        </div>
    </div>
    {foreach $addrData as $k=>$v}
        <div class="portlet-body addrCon">
            <span class="label label-danger" style="margin-right: 15px">产品名称:</span>  {$v['product_name']}
            <span class="label label-danger" style="margin:0 20px 0 30px">地址:</span>  {$v['newAddr']}
        </div>
    {/foreach}
</div>
<button class="btn btn-primary" id="submitMapInfo" style="width: 250px;margin: auto; display: block">
    确认更新
</button>
<div id="mask" class="mask">正在提交数据...</div>
</body>
<script src="http://libs.baidu.com/jquery/1.9.0/jquery.js"></script>
<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=aaNCRRcGGai6klHMOGZ8yBbP"></script>
<script>
    $('#openMap').on('show.bs.modal', function (e) {
//            openMap();
    })
    //var map = new BMap.Map("map_con");
    // map.centerAndZoom(new BMap.Point(121.449608,31.24557), 18);
    // map.enableScrollWheelZoom(true);
    var index = 0;
    var indexComplete = 0;
    var myGeo = new BMap.Geocoder();
    var addrInfo = new Array();
    var adds = [
        {foreach $addrData as $k=>$v}
        "{$v['newAddr']}",
        {/foreach}
    ];
    var addsId = [
        {foreach $addrData as $k=>$v}
        "{$v['id']}",
        {/foreach}
    ];
    $('#submitMapInfo').bind('click', submintAddrList);
    function openMap() {
        {*if (mapIsOpen)return;*}
        {*// 百度地图API功能*}
        {*var map = new BMap.Map("map_con");*}
        {*var point = new BMap.Point(116.331398, 39.897445);*}
        {*map.centerAndZoom(point, 12);*}
        {*map.enableScrollWheelZoom();   //启用滚轮放大缩小，默认禁用*}
        {*map.enableContinuousZoom();    //启用地图惯性拖拽，默认禁用*}
        {*var top_right_navigation = new BMap.NavigationControl({*}
        {*anchor: BMAP_ANCHOR_TOP_RIGHT,*}
        {*type: BMAP_NAVIGATION_CONTROL_SMALL*}
        {*}); //右上角，仅包含平移和缩放按钮*}
        {*map.addControl(top_right_navigation);*}
        {*// 创建地址解析器实例*}
        {*var myGeo = new BMap.Geocoder();*}
        {*// 将地址解析结果显示在地图上,并调整地图视野*}
        {*myGeo.getPoint("{$info['attr']['城市']}市{$info['addr']}", function (point) {*}
        {*if (point) {*}
        {*map.centerAndZoom(point, 16);*}
        {*var marker = new BMap.Marker(point);  // 创建标注*}
        {*map.addOverlay(marker);*}
        {*marker.setAnimation(BMAP_ANIMATION_BOUNCE); //跳动的动画*}
        {*} else {*}
        {*alert("您选择地址没有解析到结果!");*}
        {*}*}
        {*}, "{$info['attr']['城市']}市");*}
        {*mapIsOpen = true;*}

    }
    function bdGEO() {
        var add = adds[index];
        geocodeSearch(add, index);
        index++;
    }
    function geocodeSearch(add, index) {
        if (index < adds.length) {
            setTimeout(window.bdGEO, 100);
        }
        var newAddr = [];
        myGeo.getPoint(add, function (point) {
            if (point) {
                newAddr.push(addsId[index]);
                newAddr.push(point.lng);
                newAddr.push(point.lat);

//                newAddr['lng'] = point.lng;
//                newAddr['lat'] = point.lat;
//                newAddr['id'] = addsId[index];
                addrInfo.push(newAddr);
                $('.addrConList .addrCon').eq(index).append('<span class="label label-danger" style="margin:0 20px 0 30px">经纬度：</span>' + point.lng + ',' + point.lat + '');
                myGeo.getLocation(point, function (rs) {
                    var addrComp = rs.addressComponents;
                    var addrCompInfo = addrComp.district;
                    var newAttr = new Array();
                    newAttr.push(rs.business);
                    newAttr.push(addrCompInfo);
                    newAddr.push(newAttr);
                    $('.addrConList .addrCon').eq(index).append('<span class="label label-danger" style="margin:0 20px 0 30px">商圈：</span>' + rs.business + '');
                    $('.addrConList .addrCon').eq(index).append('<span class="label label-danger" style="margin:0 20px 0 30px">行政区：</span>' + addrCompInfo + '');
                    //console.log(addrComp.province+','+addrComp.city+','+addrComp.district+','+addrComp.street+','+addrComp.streetNumber)
                })
            }
            indexComplete++;
            if (adds.length > 0 && indexComplete >= adds.length) {
//            submintAddrList();如果地图信息全部获取结束
                $('#submitMapInfo').click();
            }
        }, "");


    }
    // 编写自定义函数,创建标注
    function addMarker(point, label) {
        var marker = new BMap.Marker(point);
        map.addOverlay(marker);
        marker.setLabel(label);
    }
    //    geocodeSearch();
    function submintAddrList() {
//        console.log(addrInfo);
        var jsonInfo = JSON.stringify(addrInfo);

        $('#submitMapInfo').addClass('disabled');
        $('#mask').show();
        $.ajax({
            type: 'post',
            url: '{$_root}{$_package}product_search/update_product_info_list',
            data: {
                addrInfos: jsonInfo,
                action: 'update_product_submit'
            },
            success: function (data) {
//                console.log(data);
                if (data == 'ok') {
                    $('#mask').hide();
                    window.location.href = location.href;
                } else {
                    $('#mask').hide();
//                    top.alert('无数据更新！')
                }
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                console.log(XMLHttpRequest.status);
                console.log(textStatus);
                console.log(errorThrown);
            }
//            dataType:'json'
        })
    }
    bdGEO()
</script>
</html>