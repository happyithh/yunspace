
$(document).ready(function(){
    /*搜索框*/
    $(".hvselect").on("click",function(e){
        $(".select").toggleClass("open");
        e.stopPropagation();
    });
    $(".select ul li").on("click",function(e){
        $(this).addClass("selected").siblings().removeClass("selected");
        $(".hvselect").val($(this).text());
        $(".select").removeClass("open");
        e.stopPropagation();
    });
    $(document).on("click",function(){
        $(".select").removeClass("open");
    });
    $('.js-ipt-clean').on("click",function(){
        $(".hvselect").val('');
    });

    /*查看档期和价格*/
    //$('.mcont-list-cont li').on('mouseenter',function(){
    //    $(this).find('.icon-inq-gray').hide();
    //    $(this).find('.mcont-inquiry-details').stop().animate({
    //        'left':'-126px'
    //    },500);
    //});
    //$('.mcont-list-cont li').on('mouseleave',function(){
    //    $(this).find('.icon-inq-gray').show();
    //    $(this).find('.mcont-inquiry-details').stop().animate({
    //        'left':0
    //    },500);
    //});
    //$(document).on('mouseenter','.mcont-list-cont li',function(){
    //    $(this).find('.icon-inq-gray').hide();
    //    console.log(1111);
    //    $(this).find('.mcont-inquiry-details').stop().animate({
    //        'left':'-126px'
    //    },500);
    //})
    //$(document).on('mouseleave','.mcont-list-cont li',function(){
    //    $(this).find('.icon-inq-gray').show();
    //    $(this).find('.mcont-inquiry-details').stop().animate({
    //        'left':0
    //    },500);
    //})

    ///*标签向下展开/收缩*/
    //$('.js-a-downup').on('mouseenter',function(){
    //    $(this).parent().css({
    //        'height':'auto'
    //    });
    //    $(this).find('.a-downup').addClass('a-up');
    //});
    //$('.dlist dd').on('mouseleave',function(){
    //    $(this).animate({
    //        'height':'22px'
    //    });
    //    $(this).find('.a-downup').removeClass('a-up');
    //});


    ///*标签删除*/
    //$('.js-delete').on('click',function(){
    //    $(this).parent().remove();
    //});
    //$('.js-delete-all').on('click',function(){
    //    $('.dlchoice').remove();
    //});

////创建和初始化地图函数：
//    function initMap(){
//        createMap();//创建地图
//        setMapEvent();//设置地图事件
//        addMapControl();//向地图添加控件
//        addMapOverlay();//向地图添加覆盖物
//        localAddr();//定位当前
//    }
//    function createMap(){
//        map = new BMap.Map("map");
//        map.centerAndZoom(new BMap.Point(121.447752,31.254775),12);
//    }
//    function setMapEvent(){
//        map.disableScrollWheelZoom();
//        map.enableKeyboard();
//        map.enableDragging();
//        map.enableDoubleClickZoom()
//    }
//    function addClickHandler(target,window){
//        target.addEventListener("click",function(){
//            target.openInfoWindow(window);
//        });
//    }
//    function addMapOverlay(){
//    }
//    //向地图添加控件
//    function addMapControl(){
//        //var scaleControl = new BMap.ScaleControl({anchor:BMAP_ANCHOR_BOTTOM_LEFT});
//        //scaleControl.setUnit(BMAP_UNIT_IMPERIAL);
//        //map.addControl(scaleControl);
//        var navControl = new BMap.NavigationControl({anchor:BMAP_ANCHOR_TOP_LEFT,type:BMAP_NAVIGATION_CONTROL_LARGE});
//        map.addControl(navControl);
//        //var overviewControl = new BMap.OverviewMapControl({anchor:BMAP_ANCHOR_BOTTOM_RIGHT,isOpen:true});
//        //map.addControl(overviewControl);
//    }
//    function localAddr(){
//        var local = new BMap.LocalSearch(map, {
//            renderOptions:{map: map}
//        });
//        var local_addr = $('.local_addr').eq(0).text();
//        local.search(local_addr);
//    }
//    var map;
//    initMap();
//    map.setMapStyle({style:'grayscale'});
//    map.disableScrollWheelZoom();

});