/**
 * Created by Alex Shen on 2015/6/10.
 */
//用于将位置信息存入cookie
//在启用百度地图的回调之前，需要先对缓存区域进行检查
//用以防止因频繁更新界面而产生的多次回调，从而引起糟糕的用户体验
(function () {
    var point = new BMap.Point(116.331398, 39.897445);
    var strCookie = document.cookie;
    var arrCookie = strCookie.split("; ");
    var baidu_lngs = "";
    var baidu_lats = "";
    for (var i = 0; i < arrCookie.length; i++) {
        var arr = arrCookie[i].split("=");
        if ("baidu_lng" == arr[0]) {
            baidu_lngs = arr[1];
        }
        if ("baidu_lat" == arr[0]) {
            baidu_lats = arr[1];
        }
    }
    if ((baidu_lats === "" ) && (baidu_lngs === "")) {
        var geoLocation = new BMap.Geolocation();
        geoLocation.getCurrentPosition(function (r) {
                if (this.getStatus() == BMAP_STATUS_SUCCESS) {
                    document.cookie = "baidu_lng=" + r.point.lng;
                    document.cookie = "baidu_lat=" + r.point.lat;
                }
            }, {
                enableHighAccuracy: true
            }
        )
    }
}());
//这里用于存储相似列表页中，不相同的元素
var controllerPool = {};
$(document).ready(function () {
    controllerPool.aType = $('#type-space');
    controllerPool.aTypeContent = $('.space-type');
    controllerPool.url = $("body").attr("data-url");
});

//用于存放筛选条件
var conditionPool = {
    position: "附近",
    position_range: "nearbymi",
    position_range_buffer: "nearbymi",
    category_id: 0,
    //以下的两个字段是考虑到能够在最大程度上与其他列表兼容，因此
    //虽然名字与空间列表和配套服务列表相同，但是意义不同
    size_range: "",
    activity: "",
    orderBy: 1,
    price_start: "",
    price_end: "",
    dp: 1,
    dn: 12,
    dtp: 1,
    setConditionToServer: function (successCB, errorCB, timeoutCB) {
        var ajaxData = {
            "position_range": conditionPool.position,
            "category_id": conditionPool.category_id,
            "peoplenum": (conditionPool.size_range === 0) ? "" : conditionPool.size_range,
            "daynum": conditionPool.activity,
            "orderBy": conditionPool.orderBy,
            "price_start": conditionPool.price_start,
            "price_end": conditionPool.price_end,
            "dp": conditionPool.dp,
            "dn": conditionPool.dn,
            "dtp": conditionPool.dtp
        };
        ajaxData[conditionPool.position_range] = conditionPool.position;
        if ("nearbymi" === conditionPool.position_range) {
            var strCookie = document.cookie;
            var arrCookie = strCookie.split("; ");
            var baidu_lngs = "";
            var baidu_lats = "";
            for (var i = 0; i < arrCookie.length; i++) {
                var arr = arrCookie[i].split("=");
                if ("baidu_lng" == arr[0]) {
                    baidu_lngs = arr[1];
                }
                if ("baidu_lat" == arr[0]) {
                    baidu_lats = arr[1];
                }
            }
            ajaxData["baidu_lng"] = baidu_lngs;
            ajaxData["baidu_lat"] = baidu_lats;
        }
        $.ajax({
            url: controllerPool.url,
            type: "post",
            dataType: "json",
            timeout: timeoutCB,
            data: ajaxData,
            success: function (jsonData) {
                successCB(jsonData);
            },
            error: function (jsonData) {
                if (errorCB) {
                    errorCB(jsonData);
                }
            }
        });
    }
}