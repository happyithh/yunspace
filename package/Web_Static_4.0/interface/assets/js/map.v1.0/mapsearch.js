var range = '1' || 1;//公里数
var addressSearchCircle;//搜索的圈圈
var addressSearchMarker;//跳动的点
var map = window.map;
var mapZoom = 16;
var postArguments = window.postArguments = {};
var maplevel = {minZoom:13,maxZoom:18,enableMapClick:false};
map = new BMap.Map("map",maplevel);
var allFieldsData;
var allFieldPoint = {};
var allArguments = {
    searchCircle : '#cae0fb',
    place : ''
};
var customPlace = $('#customPlace');
var customDistance = $('#customDistance');
var yunspaceMapStyle = [
    {
        "featureType": "land",
        "elementType": "all",
        "stylers": {
            "color": "#f6f6f6"
        }
    },
    {
        "featureType": "water",
        "elementType": "all",
        "stylers": {
            "color": "#c3d6fd"
        }
    },
    {
        "featureType": "green",
        "elementType": "all",
        "stylers": {
            "color": "#e1ebff"
        }
    },
    {
        "featureType": "manmade",
        "elementType": "geometry",
        "stylers": {
            "color": "#000000",
            "visibility": "off"
        }
    },
    {
        "featureType": "building",
        "elementType": "all",
        "stylers": {
            "visibility": "off"
        }
    },
    {
        "featureType": "boundary",
        "elementType": "all",
        "stylers": {}
    },
    {
        "featureType": "highway",
        "elementType": "geometry",
        "stylers": {
            "color": "#ffffff"
        }
    },
    {
        "featureType": "highway",
        "elementType": "labels.text.fill",
        "stylers": {
            "color": "#83abfd"
        }
    },
    {
        "featureType": "highway",
        "elementType": "labels.text.stroke",
        "stylers": {
            "color": "#f6f6f6"
        }
    },
    {
        "featureType": "arterial",
        "elementType": "geometry",
        "stylers": {
            "color": "#ffffff",
            "weight": "0.5"
        }
    },
    {
        "featureType": "arterial",
        "elementType": "labels.text.stroke",
        "stylers": {
            "color": "#f6f6f6"
        }
    },
    {
        "featureType": "local",
        "elementType": "geometry",
        "stylers": {
            "color": "#ffffff",
            "weight": "0.7"
        }
    },
    {
        "featureType": "local",
        "elementType": "labels.text.fill",
        "stylers": {
            "color": "#cccccc"
        }
    },
    {
        "featureType": "local",
        "elementType": "labels.text.stroke",
        "stylers": {
            "color": "#f6f6f6"
        }
    },
    {
        "featureType": "poi",
        "elementType": "labels.text.fill",
        "stylers": {
            "color": "#666666"
        }
    },
    {
        "featureType": "railway",
        "elementType": "all",
        "stylers": {
            "visibility": "off"
        }
    },
    {
        "featureType": "arterial",
        "elementType": "labels.text.fill",
        "stylers": {
            "color": "#999999"
        }
    }
];
map.setMapStyle({styleJson:yunspaceMapStyle});
//map.setMapStyle({style:'grayscale'});
function GetQueryString(name)
{
    var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
    var r = window.location.search.substr(1).match(reg);
    if(r!=null)return  unescape(r[2]);
    return '';
}

function getCookie(c_name)
{
    var cookie = decodeURIComponent(document.cookie);
    if (cookie.length>0)
    {
        c_start=cookie.indexOf(c_name + "=");
        if (c_start!=-1)
        {
            c_start=c_start + c_name.length+1;
            c_end=cookie.indexOf(";",c_start);
            if (c_end==-1) c_end=cookie.length;
            return unescape(cookie.substring(c_start,c_end))
        }
    }
    return "";
}

var distanceFromLastPage = decodeURI(GetQueryString('distance')) ;
var placeFromLastPage = decodeURI(GetQueryString('place'));

function changeCustomPlaceholder(text){
    customPlace.attr('placeholder',text);
}

//初始化定位
var myGeo = new BMap.Geocoder();
var city = getCookie("city");
var cityCenter = city + '市中心';

if(distanceFromLastPage){//用户使用头部的搜索框 传过来的距离处理
    range = parseFloat(distanceFromLastPage);
    customDistance.val(distanceFromLastPage);
    dealRange();
}
if(placeFromLastPage){
    myGeo.getPoint(placeFromLastPage, function(point){ //用户使用头部的搜索框  可能无法定位 需要else处理
        if (point) {
            changeCustomPlaceholder(placeFromLastPage);
            mapAddZoomEvent();//添加zoom世界
            placeChange();

        }else{
            //TODO //没有这个点的提示
            tolerantGetPoint()
        }
    },city);

}else{
    tolerantGetPoint()
}
//以城市中心定位地图

function tolerantGetPoint(){
    changeCustomPlaceholder(cityCenter);
    myGeo.getPoint(cityCenter, function(point){
        console.log(point);
        if (point) {
            initMapWithPoint(point);
            mapAddZoomEvent();
            requestData();
        }else{
            //TODO //没有这个点的提示
        }
    },city);

}
var lngAndLats;
function getNowLngAndLats(){
    var bs = map.getBounds();   //获取可视区域
    var bssw = bs.getSouthWest();   //可视区域左下角
    var bsne = bs.getNorthEast();   //可视区域右上角
    //alert("当前地图可视范围是：" + bssw.lng + "," + bssw.lat + "到" + bsne.lng + "," + bsne.lat);
    lngAndLats = {
        right_top_lat:bsne.lat,
        right_top_lng:bsne.lng,
        left_down_lat:bssw.lat,
        left_down_lng:bssw.lng
    };
}


//搜索框下拉效果

$("#searchForm").on("submit",function(){
    conditionChange();
    return false;
});

$(".select-click").on("click",function(){
    $(".dropDown").hide();
    $(".select-click").removeClass("act");
    $(this).addClass("act");
    $(this).parent().find(".dropDown").fadeIn(200);
    $(".select-click").find("span").removeClass("s-s-active");
    $(this).find("span").addClass("s-s-active");
});

//活动列表收起张开
$('.choice-more .more').click(function () {
    $('.slidehide').stop().slideToggle();
    var status = $(".dlist").eq(3).css('display');
    if (status == 'none') {
        $(".dlist").show();
    } else {
        $(".dlist").eq(3).hide();
        $(".dlist").eq(4).hide();

    }
    $(this).parent().addClass('hide');
    $(this).parent().siblings('.choice-more').removeClass('hide');
});


$(".dlist dd a").on("click",function(){
    var dlist = $(this).parents(".dlist");
    var dataDlist = dlist.attr("id");
    var value = $(this).data('value');

    $(".hv-choice-list a").each(function(){
        if ($(this).hasClass(dataDlist)){
            $(this).remove();
        }
    });
    $(this).siblings().removeClass("on");

    if (value == 0){//不限

    }else{
        if (!$(this).hasClass("on")){
            var cloneLink = $(this).clone().append('<span class="c-close">×</span>');
            cloneLink.addClass(dataDlist);
            cloneLink.attr("data-dlist",dataDlist);
            $('#chosenList').append(cloneLink);
            $(this).addClass("on");
        }else{
            $(this).removeClass("on")
        }
    }
    requestData();
    return false
});

var isRequestData = false;
function requestData(isOnlyGetListData,page,orderBy,besePoint){

    if (isRequestData){
        return;
    }else{
        isRequestData = true
    }
    window.postArguments = {};
    getNowLngAndLats();

    if(lngAndLats){
        for(i in lngAndLats){
            window.postArguments[i] = lngAndLats[i];
        }
    }

    var condition = {};
    $('#chosenList a').each(function(){
        var key = $(this).data('dlist');
        var value = $(this).data('value');
        window.postArguments[key] = value;
        condition[key] = value;
        //console.log(JSON.stringify(postArguments))
    });

    var c = getObjectLength(condition);
    var hasCondition = c > 0 ? true : false;

    if(page){
        window.postArguments['p'] = page;
    }
    if(orderBy){
        window.postArguments['order'] = orderBy;
    }
    if(besePoint){//根据中心点及距离
        window.postArguments['baidu_lng'] = besePoint.lng;
        window.postArguments['baidu_lat'] = besePoint.lat;
        window.postArguments['nearbymi'] = range;
    }

    var argLength = getObjectLength(window.postArguments);
    $('#loadingImg').show();
    if(mapZoom >= 14 || isOnlyGetListData){//只更新列表 或者 调取点数据 不调区域数据
        $.ajax({
            type: "get",
            url: "/static/api/map/search/spaceList.json?handle=ajaxSearch",
            dataType: 'json',
            data:window.postArguments,
            success:function(data){
                isRequestData = false;
                var coordinate = data['coordinate'];
                var status = data['status'] * 1;
                var re = {};
                if (!isOnlyGetListData && !besePoint){//是否只更新列表不更新地图

                    if(status != 0){
                        for (var i = 0;i<coordinate.length;i++){
                            var id = coordinate[i]['id'];
                            re[id] = true;

                            //对为添加到地图上的点进行添加
                            if(!allFieldPoint[id]){
                                drawingPoint(coordinate[i]);
                            }
                        }
                        for(j in allFieldPoint){//j就是ID

                            if (re[j] == true){
                                allFieldPoint[j].show();
                            }else{
                                allFieldPoint[j].hide();
                            }
                        }

                    }else{

                        for(j in allFieldPoint){//j就是ID
                            allFieldPoint[j].hide();
                        }
                    }
                    hideAreaCircle();//隐藏区域圈
                    showCondition();//同时显示筛选条件
                }
                if (page){
                    scrollToList();
                }
                $('#listContent').html(data['data']);
                $('#loadingImg').hide();

            },
            error:function(XMLHttpRequest, textStatus, errorThrown){
                console.log(XMLHttpRequest, textStatus, errorThrown);
                isRequestData = false;
                $('#loadingImg').hide();
            }
        });
        if (argLength<=0){
            //groupDrawing(allFieldsData);//分批次渲染
            //drawingOnce(allFieldsData);//一次渲染
        }else{
            //console.log(window.postArguments.length());
        }
    }else{
        getOrShowAreaData();
        hideCondition();
    }


}
function hideCondition(){
    $('#mcont-screening').hide();
}
function showCondition(){
    $('#mcont-screening').show();
}
function scrollToList(){
    $(".mapsearch-content").animate({scrollTop:0},100);
}

function getObjectLength(object){
    var length = 0;
    for(i in object){
        length ++
    }
    return length;
}

map.addEventListener("dragend", function(){
    getNowLngAndLats();
    requestData();
});
function mapAddZoomEvent(){
    map.removeEventListener('zoomend');
    map.addEventListener("zoomend", function(){
        window.mapZoom = map.getZoom();
        requestData();
    });
}
$(document).on("click",".c-close",function(){
    var dlist = $(this).parent().data("dlist");
    $('#mcont-screening #'+dlist+'').find(".on").removeClass("on");
    $(this).parent().remove();
    requestData();
    return false;
});
$(document).on('click',"#pagers a",function(){
    var value = $(this).data('value');
    if (value){
        requestData(true,value)
    }
});

$('#chosenList a').on('click',function(){
    return false;
});

$(document).on('click',"#chosenList a",function(){
    return false;
});

$(document).on('mouseenter',"#listContent ul li",function(){
    var id = $(this).data('id');
    if (allFieldPoint[id]){
        var node = allFieldPoint[id]._container.childNodes[0];

        if(node.className.match('pt-click')){//click事件之后需要添加一个class
            node.className = "pt-wrap pton pt-click";
        }else{
            node.className = "pt-wrap pton";
        }
    }
});
$(document).on('mouseleave',"#listContent ul li",function(){
    //clearTimeout(positionTimeOut);
    var id = $(this).data('id');
    //var c = $(allFieldPoint[id].getContent()).removeClass("pton")[0];
    if(allFieldPoint[id]){
        var node = allFieldPoint[id]._container.childNodes[0];
        if(node.className.match('pt-click')){//click事件之后需要添加一个class
            node.className = "pt-wrap pt-click";
        }else{
            node.className = "pt-wrap";
        }
    }

});
$('#sortList a').on('click',function(){

    if(!$(this).hasClass('active')){
        var id = $(this).data('id');
        requestData(true,false,id);
        $(this).addClass('active').siblings('a').removeClass('active');
    }
    return false

});

$("#distanceDrop.dropDown").find("li").on("click",function(){//范围改了

    $(".dropDown").hide();
    $(".select-click").find("span").removeClass("s-s-active");

    var txt = $(this).text();
    var place = $(this).parents(".range-room");
    $(this).parents(".r-r-select").find("input").val(txt);

    range = parseFloat($(this).text());
    dealRange();
    distanceRangeChange()

});

function dealRange(){

    switch (range){
        case 3:
            window.mapZoom = 14;
            break;
        case 5:
            window.mapZoom = 14;
            break;
        case 7:
            window.mapZoom = 13;
            break;
        case 1:
        case 2:
            window.mapZoom = 16;
            break;
        case 10:
            window.mapZoom = 13;
            break;
    }
}

function distanceRangeChange(){//距离范围改变
    var area = $('#showAreaText').data('area');
    var place = customPlace.val() || placeFromLastPage || (area || cityCenter );
    myGeo.getPoint(place, function(point){
        if (point) {
            initMapWithPoint(point);
            //requestData(false,false,false,point);
            requestData();
        }else{
            //alert("您选择地址没有解析到结果!");
        }
    }, city);
}

$('#areaDrop li').on('click',function(){//区域变化
    var txt = $(this).text();
    $(".dropDown").hide();
    $('#showAreaText').attr('data-area',txt);
    $('#showAreaText').text(txt);
    customPlace.val('');
    changeCustomPlaceholder('输入地址');
    myGeo.getPoint(txt, function(point){
        if (point) {
            initMapWithPoint(point);
            requestData();
        }else{
            //var point2 = new BMap.Point(121.47954,31.235853);
            //initMapWithPoint(point2);
        }
    }, city);
});

$('#customPlace').change(function(){
    placeChange();
});
$('#customPlace').on('keydown',function(event){//兼容表单提交 回车提交可以被地图插件禁了
    if(event.keyCode == 13){
        placeChange();
    }
});

function placeChange(){
    $('#showAreaText').attr('data-area','');
    $('#showAreaText').text('选择区域');
    var place = customPlace.val() || placeFromLastPage;
    //if (allArguments.place != place){
    //    allArguments.place = place;
        myGeo.getPoint(place, function(point){
            if (point) {
                window.mapZoom = 16;//地址改变设置层级
                initMapWithPoint(point);
                //requestData(false,false,false,point);
                requestData();
            }else{

                //alert("您选择地址没有解析到结果!");
            }
        }, city);
    //}

}

function initMapWithPoint(point){
    map.removeOverlay(addressSearchMarker);
    addressSearchMarker = new BMap.Marker(point);
    map.centerAndZoom(point,window.mapZoom);
    map.addOverlay(addressSearchMarker);

    map.enableScrollWheelZoom(false);
    //addressSearchMarker.setAnimation(BMAP_ANIMATION_BOUNCE);//跳动的动画

    map.removeOverlay(addressSearchCircle);
    addressSearchCircle = new BMap.Circle(point,window.range*1000,{strokeColor:"blue", strokeWeight:1, strokeOpacity:0.3,fillColor:allArguments.searchCircle}); //创建圆
    map.addOverlay(addressSearchCircle);
}

//function initMap(){
//    //createMap();//创建地图
//    setMapEvent();//设置地图事件
//    addMapControl();//向地图添加控件
//    addMapOverlay();//向地图添加覆盖物
//}
//function setMapEvent(){
//    map.enableScrollWheelZoom(false);
//    //map.disableScrollWheelZoom();
//    map.enableKeyboard(false);
//    map.enableDragging(false);
//    map.enableDoubleClickZoom(false);
//    //map.addControl(new BMap.MapTypeControl());
//
//}
//function addClickHandler(target,window){
//    target.addEventListener("click",function(){
//        target.openInfoWindow(window);
//    });
//}
//function addMapOverlay(){
//}
////向地图添加控件
//function addMapControl(){
//    var navControl = new BMap.NavigationControl({anchor:BMAP_ANCHOR_TOP_LEFT,type:0});
//    map.addControl(navControl);
//}
//
//initMap();

// 百度地图API功能  搜索功能
function G(id) {
    return document.getElementById(id);
}

//var map = new BMap.Map("l-map");
//map.centerAndZoom("北京",12);                   // 初始化地图,设置城市和地图级别。

var ac = new BMap.Autocomplete(    //建立一个自动完成的对象
    {"input" : "customPlace"
        ,"location" : map
    });

ac.addEventListener("onhighlight", function(e) {  //鼠标放在下拉列表上的事件
    var str = "";
    var _value = e.fromitem.value;
    var value = "";
    if (e.fromitem.index > -1) {
        value = _value.province +  _value.city +  _value.district +  _value.street +  _value.business;
    }
    str = "FromItem<br />index = " + e.fromitem.index + "<br />value = " + value;

    value = "";
    if (e.toitem.index > -1) {
        _value = e.toitem.value;
        value = _value.province +  _value.city +  _value.district +  _value.street +  _value.business;
    }
    str += "<br />ToItem<br />index = " + e.toitem.index + "<br />value = " + value;
    //G("searchResultPanel").innerHTML = str;
});

var myValue;
ac.addEventListener("onconfirm", function(e) {    //鼠标点击下拉列表后的事件
    var _value = e.item.value;
    myValue = _value.province +  _value.city +  _value.district +  _value.street +  _value.business;
    //G("searchResultPanel").innerHTML ="onconfirm<br />index = " + e.item.index + "<br />myValue = " + myValue;

    setPlace();
});

function setPlace(){
    //map.clearOverlays();    //清除地图上所有覆盖物
    function myFun(){
        var pp = local.getResults().getPoi(0).point;    //获取第一个智能搜索的结果
        //map.centerAndZoom(pp, 18);
        //var Marker = new BMap.Marker(pp);
        //map.addOverlay(Marker);    //添加标注
        //Marker.setAnimation(BMAP_ANIMATION_BOUNCE);
        initMapWithPoint(pp);
    }
    var local = new BMap.LocalSearch(map, { //智能搜索
        onSearchComplete: myFun
    });
    local.search(myValue);
}

// 百度地图API功能  搜索功能 到此结束
function drawingPoint(pointData){

    var lat,lng,point,htm,rm,product_name,url;
    lat = pointData['geo_lat']/1000;
    lng = pointData['geo_lng']/1000;
    product_name = pointData['product_name'];
    url = '/service_info/'+ pointData['id'] +'.html';
    point = new BMap.Point(lng,lat);
    htm = '<div class="pt-wrap" id='+pointData['id']+'>'
    + '<div class="pt"></div>'
    + '<div class="pt-detail">'+product_name+'<span class="jiao">◆</span></div>'
    + '</div>';

    rm = new BMapLib.RichMarker(htm, point, { "anchor": new BMap.Size(0, 0)});
    window.map.addOverlay(rm);

    var rNode = rm._container.childNodes[0].childNodes[1];
    //rNode.style.display="block";

    rNode.style.left = -rNode.offsetWidth/2+15+"px";

    rNode.style.display="none";

    rm.addEventListener('onmouseover',function(e){
        //console.log(e.target.className)
        var node = this._container.childNodes[0];

        if(node.className.match('pt-click')){//click事件之后需要添加一个class
            node.className = "pt-wrap pton pt-click";
        }else{
            node.className = "pt-wrap pton";
        }


    });

    rm.addEventListener('onmouseout',function(e){
        //console.log(e.target.className)
        var node = this._container.childNodes[0];
        if(node.className.match('pt-click')){ //click事件之后需要添加一个class
            node.className = "pt-wrap pt-click";
        }else{
            node.className = "pt-wrap";
        }

    });

    rm.addEventListener('click',function(e){
        var node = this._container.childNodes[0];
        var href = node.href;
        for(i in allFieldPoint){
            var node2 = allFieldPoint[i]._container.childNodes[0];
            node2.className = "pt-wrap";
        }
        node.className = "pt-wrap pton pt-click";
        var id = node.id;

        getOnePlaceInfo(id);

    });

    allFieldPoint[pointData['id']] = rm;

}

function getOnePlaceInfo(placeId){
    var point = allFieldPoint[placeId].getPosition();
    var condition = {};
    $('#chosenList a').each(function(){
        var key = $(this).data('dlist');
        var value = $(this).data('value');
        window.postArguments[key] = value;
        condition[key] = value;
    });
    condition['id'] = placeId;
    condition['lat'] = point.lat;
    condition['lng'] = point.lng;
    $.ajax({
        type:"get",
        url:"static/api/map/search/pointShow.json",
        dataType:'json',
        data:condition,
        success:function(data){
            $('#listContent').html(data['data']);
        },
        error:function(XMLHttpRequest, textStatus, errorThrown){
            console.log(XMLHttpRequest, textStatus, errorThrown)
        }

    })
}

$(document).ready(function(){
    window.onresize = function () {
        requestData();
    }
});

//区域调取
var allAreaData = {};
function getOrShowAreaData(){ //获取或者显示地区数据
    if(!getObjectLength(allAreaData)){
        $.ajax({
            type:"get",
            url:"static/api/map/area.json",
            dataType:'json',
            success:function(data){
                //console.log(data);
                drawingAreaData(data.data);
                $('#loadingImg').hide();
                isRequestData = false;
            },
            error:function(XMLHttpRequest, textStatus, errorThrown){
                console.log(XMLHttpRequest, textStatus, errorThrown);
                $('#loadingImg').hide();
                isRequestData = false;
            }
        });

    }else{
        isRequestData = false;// IMPORTANT  记得将状态改变
        for(i in allAreaData){
            allAreaData[i].show();
        }
        $('#loadingImg').hide();
    }
    //列表数据获取
    $.ajax({
        type: "get",
        url: "/static/api/map/search/spaceList.json?handle=ajaxSearch",
        dataType: 'json',
        data:null,
        success:function(data){
            $('#listContent').html(data['data']);

        },
        error:function(XMLHttpRequest, textStatus, errorThrown){
            console.log(XMLHttpRequest, textStatus, errorThrown);
        }
    });
    hideAllPoint();
}
function hideAreaCircle(){
    for(i in allAreaData){
        allAreaData[i].hide();
    }
}
function hideAllPoint(){
    for(i in allFieldPoint){
        allFieldPoint[i].hide();
    }
}

function drawingAreaData(data){

    for(var i= 0;i < data.length;i++){
        var lat,lng,point,htm,rm,area_name,num;
        lat = data[i]['lat'];
        lng = data[i]['lng'];
        num = data[i]['num'];
        area_name = data[i]['name']?data[i]['name']:"暂未分区";

        //url = '/service_info/'+ pointData['id'] +'.html';
        point = new BMap.Point(lng,lat);
        htm = '<div class="area-detail">'+area_name+'<br/> '+num+' 个' +'</div>';

        rm = new BMapLib.RichMarker(htm, point, { "anchor": new BMap.Size(0, 0)});
        window.map.addOverlay(rm);
        rm.addEventListener('onmouseover',function(e){
            //console.log(e.target.className)
            var node = this._container.childNodes[0];
            node.className = "area-detail area-detail-on";
        });

        rm.addEventListener('onmouseout',function(e){
            //console.log(e.target.className)
            var node = this._container.childNodes[0];
            node.className = "area-detail";

        });
        rm.addEventListener('click',function(e){
            var position = this.getPosition();
            window.mapZoom = 15;
            map.centerAndZoom(position,window.mapZoom);
            this.hide();
        });
        allAreaData[area_name] = rm;
    }
}







