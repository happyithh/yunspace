/**
 * Created by pzl on 16/1/29.
 */
(function(window){
    var $$= {
        showImg: $('#show-img'),
        imgLi:$("#img-li"),
        footerOutside:$(".footer-outside"),
        loadMore:$(".load-more"),
        cityLoad:$(".city-load"),
        loadAll:$(".load-all"),
        noData:$(".no-data"),
        category_choice:$('.category_choice'),
        controlLoad:$(".control-load")
    };
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
    var $grid=$$.showImg.masonry({
        initLayout: false,
        columnWidth: 276,
        itemSelector: '.item',
        containerStyle: null,
        "gutter": 24,
        Default: { opacity:0.8, transform: 'scale(0.8)' },
        transitionDuration: '0.8s'
    });
    var docH=$('body').height();
    var footerTop= $$.footerOutside.offset().top;
    var winH=$(window).height();
    var listH;
    var maxHeight=[];
    function getItemElement(data,o) {
        $grid=$$.showImg.masonry({
            initLayout: false,
            columnWidth: 276,
            itemSelector: '.item',
            containerStyle: null,
            "gutter": 24,
            Default: { opacity:0.5, transform: 'scale(1)' },
            transitionDuration: '0s'
        });
        var ht='';
        for(var i in data){
            //console.log(i)
            var src=$$.showImg.data("src");
            src=data[i]['img'];
            ht+='<li class="item">'+
            '<a href='+encodeURI("/site/"+data[i].title)+' target="_blank">'+
            '<img src='+src+' alt="">'+
            '<p>'+
            '<span class="title">'+data[i].title+'</span>'+
            '<span>'+data[i].des+'</span>'+
            '</p>'+
            '</a>'+
            '</li>';
        }
        var $item=$(ht);
        $$.controlLoad.css({opacity:"0",filter:'alpha(opacity=0)'});
        $grid.append($item).masonry('appended',$item);
        o.removeClass("none");
        $$.cityLoad.addClass("none");
        var l=$("#show-img").find(".item").length;
        $("#show-img").find(".item").each(function(index,dom){
            var $dom=$(dom);
            $dom.find('img').bind('load',function(){
                setTimeout(function(){
                    var pt=$dom.position().top;
                    var h=$dom.outerHeight();
                    maxHeight.push(parseInt(pt)+parseInt(h));
                },500);
            });
        });
        setTimeout(function(){
            var maxH=getMax(maxHeight,'max');
            $("#show-img").css({height:maxH});
            $$.controlLoad.css({opacity:"1",filter:'alpha(opacity=100)'});
        },810);
    }

    function getMax (arr,maximin) {
        if (maximin == "max") {
            return Math.max.apply(Math, arr);
        }
    }
    //setImgListHeight();
//    var dp = 2;
    var city = $("#city_name_choice").html();
    var category_id = $("#category_choice_value").val();
    $$.loadMore.on("click",function(){
        var $this=$(this);
        var dp=$$.loadMore.attr("data-dp");
        $this.addClass("none");
        $$.cityLoad.removeClass("none");
        //var city = $this.attr('data-city');
        setTimeout(function(){
            //TODO::AJAX请求
            YunSpace.api('spacepedia/list.jsonp', {
                    city: city,
                    category_id:category_id,
                    dp: dp
                }, function (data) {
                    if(data.status == 1 &&data.data!=null){
                        if(data.data.data.length==0){
                            $$.loadAll.removeClass('none');
                            $$.loadMore.addClass("none");
                            $$.cityLoad.addClass("none");
                            return false;
                        }
                        getItemElement(data.data.data,$this);
                        $$.loadMore.attr('data-dp',data.data.next_dp);

                        if(data.data.total_num <= dp*4){
                            $$.loadAll.removeClass('none');
                            $$.loadMore.addClass('none');
                            $$.cityLoad.addClass("none");
                            return false;
                        }
//                        dp = dp+1;
                    }
                },
                'json'
            );
            //getItemElement(data,$this);
        },2000);
    });
    $$.category_choice.on("click",function(){
        var $this=$(this);
        $this.addClass("select-active");
        $this.siblings().removeClass("select-active");
        $$.loadMore.removeClass('none');
        $$.noData.addClass('none');
        $$.loadAll.addClass('none');
        $("#show-img").empty();
        $grid.masonry('destroy');
        //$$.showImg.css({height:'10px'});
        category_id = $this.attr('data-value');
        $("#category_choice_value").val(category_id);
        $$.loadMore.attr('data-dp',2);
        setTimeout(function(){
            //TODO::AJAX请求
            YunSpace.api('spacepedia/list.jsonp', {
                    city: city,
                    category_id:category_id,
                    dp: 1
                }, function (data) {
                    if(data.status == 1 && data.data!=null){
                        if(data.data.data.length==0){
                            $$.loadAll.removeClass('none');
                            $$.loadMore.addClass('none');
                            $$.cityLoad.addClass("none");
                            return false;
                        }
                        getItemElement(data.data.data,$this);
                        if(data.data.total_num <= 4){
                            $$.loadAll.removeClass('none');
                            $$.loadMore.addClass('none');
                            $$.cityLoad.addClass("none");
                            return false;
                        }
                    }else{
                        $$.noData.removeClass('none');
                        $$.loadMore.addClass('none');
                        $$.loadAll.addClass('none');
                        $$.cityLoad.addClass("none");
                    }
                    //if (data.status == 1 && data.data != null) {
                    //    console.log(data.data);
                    //    var hrefs = data.data['advertising_link'];
                    //    var html = '';
                    //    var medias = data.data['media'];
                    //    for (var k in medias) {
                    //        var srcs = medias[k]['path'];
                    //        html += " <a href='" + hrefs + "' target='_blank'><img src='" + srcs + "' alt=''></a>";
                    //        $('.' + homeC).html(html);
                    //    }
                    //}
                },
                'json'
            );
            //getItemElement(data,$this);
        },100);
    });
    //var img='http://api.map.baidu.com/staticimage/v2?ak=aaNCRRcGGai6klHMOGZ8yBbP&center=116.403874,39.914888&width=300&height=200&zoom=11';
    //$("#allmap>img").attr('src',img);
    //var src=$("#allmap").data('src');
    //src=src+'img/city_baike/dingwei.png';
    var map = new BMap.Map("allmap");
    //var point = new BMap.Point(116.404, 39.915);
    map.centerAndZoom(city, 12);
    map.setMapStyle({styleJson:yunspaceMapStyle});
    map.disableScrollWheelZoom();
    map.disableDragging();
    //// 编写自定义函数,创建标注
    //function addMarker(point){
    //    var myIcon = new BMap.Icon(src, new BMap.Size(300,157));
    //    var marker = new BMap.Marker(point,{icon:myIcon});
    //    map.addOverlay(marker);
    //}
    //// 随机向地图添加25个标注
    //var bounds = map.getBounds();
    //var sw = bounds.getSouthWest();
    //var ne = bounds.getNorthEast();
    ////var lngSpan = Math.abs(sw.lng - ne.lng);
    ////var latSpan = Math.abs(ne.lat - sw.lat);
    ////for (var i = 0; i < 25; i ++) {
    ////TODO::ajax请求地址经纬度
    //    var point = new BMap.Point(116.404, 39.915);
    //    addMarker(point);
    ////}
})(window);