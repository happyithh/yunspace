
$(document).ready(function(){

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
//创建和初始化地图函数：
    var thisMapZoom = 14;
    function initMap(){
        createMap();//创建地图
        setMapEvent();//设置地图事件
        addMapControl();//向地图添加控件
        addMapOverlay();//向地图添加覆盖物
        localAddr();//定位当前
    }
    function createMap(){
        map = new BMap.Map("l-map");
        map.centerAndZoom(new BMap.Point(121.447752,31.254775),thisMapZoom);
    }
    function setMapEvent(){
        map.disableScrollWheelZoom();
        map.enableKeyboard();
        map.enableDragging();
        map.enableDoubleClickZoom()
    }
    function addClickHandler(target,window){
        target.addEventListener("click",function(){
            target.openInfoWindow(window);
        });
    }
    function addMapOverlay(){
    }
    //向地图添加控件
    function addMapControl(){
        //var scaleControl = new BMap.ScaleControl({anchor:BMAP_ANCHOR_BOTTOM_LEFT});
        //scaleControl.setUnit(BMAP_UNIT_IMPERIAL);
        //map.addControl(scaleControl);
        var navControl = new BMap.NavigationControl({anchor:BMAP_ANCHOR_TOP_LEFT,type:BMAP_NAVIGATION_CONTROL_LARGE});
        map.addControl(navControl);
        //var overviewControl = new BMap.OverviewMapControl({anchor:BMAP_ANCHOR_BOTTOM_RIGHT,isOpen:true});
        //map.addControl(overviewControl);
    }
    function localAddr(){
        //var local = new BMap.LocalSearch(map, {
        //    renderOptions:{map: map}
        //});
        //var local_addr = $('.local_addr').eq(0).text();
        //local.search(local_addr);

        var point = new BMap.Point(thisLng,thisLat),
        htm = '<div class="pt-wrap">'
            + '<a class="icon-c icon-map-marker icon-map-pointer" href="javascript:;"></a>'
            + '<div class="pt-detail">'
            + thisSpaceName
            + '<span class="jiao">◆</span>'
            + '</div>'
            + '</div>';

        //htm = '<p>css</p>' +
        //    '<a id='+pointData['id']+' class="icon-c icon-map-marker icon-map-nopointer" href="javascript:;">' +
        //    '</a>';

        var rm = new BMapLib.RichMarker(htm, point, { "anchor": new BMap.Size(0, 0)});
        map.addOverlay(rm);

        var container = $(rm._container);
        container.css({
            'z-index':99
        })
        //var rNode = .childNodes[0].childNodes[1];
        var pt = container.find('.pt-detail');
        pt.css({
            'left': - pt.width()/2 + 'px',
        });
        map.centerAndZoom(point,thisMapZoom);

        $('.baike_m_nearby_area li').each(function(){
            var lng = $(this).data('lng')/10000;
            var lat = $(this).data('lat')/10000;
            var point2 = new BMap.Point(lng,lat),
            htm2 = '<a class="icon-c icon-map-marker icon-map-nopointer" href="javascript:;"></a>';
            var rm2 = new BMapLib.RichMarker(htm2, point2, { "anchor": new BMap.Size(0, 0)});
            map.addOverlay(rm2);
        })

    }
    var map;
    initMap();
    map.setMapStyle({styleJson:yunspaceMapStyle});
    map.disableScrollWheelZoom();
    map.disableDragging();//禁止拖拽

});