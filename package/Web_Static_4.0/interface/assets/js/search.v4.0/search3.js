/**
 * Created by pzl on 16/7/25.
 */
(function(win,doc,$){
    $(function(){
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
        var $$={
            cityMore:$(".city-more"),
            cusInput:$(".cus-input"),
            searchList:$(".search_list"),
            searchLeft:$("#searchleft"),
            mapSection:$(".map-section"),
            publicContainer:$(".public-container"),
            saoCode:$(".sao-code"),
            footerOutside:$(".footer-outside"),
            searchSelect:$(".search_select"),
            toMap:$(".to-map"),
            searchListTitle:$(".search_list_title")
        };
        var f={
            map:new BMap.Map("allmap4"),// 创建Map实例
            style:[],
            siteLibrary:"",
            init:function(){
                f.selectSearch().doMap();
                f.handleInput().handleHightLight();
            },
            searchListHover:function(){
                //f.siteLibrary.city=$(".city-more:first >a").find("span").text();
                //f.siteLibrary.active_type=$(".city-more:eq(1) >a").find("span").text();
                //f.setLocationStorage(f.siteLibrary);
            },
            selectSearch:function(){
                var that=this;
                $$.cityMore.find(".select li").on('click',function(){
                    var $this=$(this);
                    that.siteLibrary=that.getLocationStorage();
                    var city_input=$("input[name='city']");
                    var active_type_input=$("input[name='active_type']");
                    if($(this).parent().hasClass("city")){
                        var city_select=$(this).find('a').text();
                        that.siteLibrary.city_select=city_select;
                        //that.siteLibrary.city=$("#public-container").data("city");
                    }
                    if($(this).parent().hasClass("active_type")){
                        var active_type=$(this).find('a').text();
                        that.siteLibrary.active_type=active_type;
                    }
                    if(city_select=='不限'){
                        that.setLocationStorage(that.siteLibrary);
                        return;
                    }
                    var geoc=new BMap.Geocoder();
                    geoc.getPoint(that.siteLibrary.city_select, function(point){
                        if(point==null){
                            //alert('定位失败,请重新搜索!!');
                            return;
                        }
                        that.siteLibrary.geo=point;
                        that.setLocationStorage(that.siteLibrary);
                    });
                    var txt=$this.text();
                    if(city_input.length>0){
                        var a=$this.parents('.city-more').find("a").eq(0);
                        if(a.hasClass("res2")){
                            a.text(txt);
                            active_type_input.val(txt);
                            if(a.hasClass("color1")){
                                a.removeClass('color1');
                            }
                        }else{
                            city_input.val(txt);
                            a.text(txt);
                        }
                    }
                });
                return f;
            },
            handleInput:function(o){
                $$.cusInput.find("input").on('keyup',function(){
                    var v=$(this).val();
                    if(v!=""){
                        $(this).parents(".cus-input").find("button").removeClass('none');
                    }else{
                        $(this).parents(".cus-input").find("button").addClass('none');
                    }
                });
                return f;
            },
            doMap:function(){
                //var geolocation = new BMap.Geolocation();
                //var map=new BMap.Map("allmap4");
                var that=this;
                var obj={};
                var top_left_navigation = new BMap.NavigationControl({anchor: BMAP_ANCHOR_TOP_RIGHT});// 左上角，添加比例尺
                this.map.addControl(top_left_navigation);
                if($$.searchList.length>0){
                    obj.lat=parseFloat(parseInt($$.searchList.eq(0).data('lat'))/10000);
                    obj.lng=parseFloat(parseInt($$.searchList.eq(0).data('lng'))/10000);
                    obj.id=$$.searchList.eq(0).data('id');
                    obj.name=$$.searchList.eq(0).data('name');
                    obj.href=$$.searchList.eq(0).data('href');
                    var point = new BMap.Point(obj.lng,obj.lat);
                    this.map.centerAndZoom(point, 15);  // 初始化地图,设置中心点坐标和地图级别
                    f.style[0]=true;
                    f.handleStyle(this.map);
                    f.handleMark(obj,this.map);
                }
                this.map.setMapStyle({styleJson:yunspaceMapStyle});
                f.handleHover().scrollMap().getDistance();
                //f.handlePageForKeyword();
                if($$.searchList.length==0){
                    //$$.mapSection.addClass('none');
                    $$.mapSection.css({
                        height:"270px"
                    });
                    that.siteLibrary=JSON.parse(localStorage.getItem('site_library'));
                    var myGeo = new BMap.Geocoder();
                    var geolocation = new BMap.Geolocation();
                    var top_left_navigation = new BMap.NavigationControl({anchor: BMAP_ANCHOR_TOP_RIGHT});// 左上角，添加比例尺
                    this.map.addControl(top_left_navigation);
                    this.map.setMapStyle({styleJson:yunspaceMapStyle});
                    if(that.siteLibrary==null){
                        myGeo.getPoint( $(".space_form").find("input[name='city']").val(), function(point){
                            if (point) {
                                that.map.centerAndZoom(point, 10);
                            }
                        });
                        return f;
                    }
                    myGeo.getPoint(that.siteLibrary.city, function(point){
                        if (point) {
                            that.map.centerAndZoom(point, 10);
                        }
                    });
                    return f;
                }
                return f;
            },
            handleHover:function(){
                var _self=this;
                //f.handleStyle(_self.map);
                var root=$("#public-container").data('root');
                $$.searchList.each(function(index,dom){
                    var $dom=$(dom);
                    var obj={};
                    $dom.hover(function(){
                        $(".pt-detail").addClass('none');
                        $(".pt-wrap").find(".icon-map-marker").removeClass("icon-map-marker-animate");
                        obj.lat=parseFloat(parseInt($(this).data('lat'))/10000);
                        obj.lng=parseFloat(parseInt($(this).data('lng'))/10000);
                        obj.id=$(this).data('id');
                        obj.name=$(this).data('name');
                        obj.href=$(this).data('href');
                        obj.addr=$(this).data('addr')
                        var addr = encodeURI(encodeURI(obj.addr));
                        var url= root+"map2?addr="+addr;
                        $$.toMap.attr('href',url);
                        if(f.style[index]==undefined|| f.style[index]!=true){
                            f.style[index]=true;
                            f.handleMark(obj,_self.map);
                        }
                        $("#"+obj.id).find(".icon-map-marker").css({
                            backgroundPosition: "2px -55px"
                        });
                        $("#"+obj.id).find(".pt-detail").removeClass('none').css({
                            'left': "-"+$("#"+obj.id).find(".pt-detail").width() / 2 + 'px',
                        });
                        var point = new BMap.Point(obj.lng,obj.lat);
                        _self.map.centerAndZoom(point,15);
                        //map.panTo(point);
                    },function(){
                        $("#"+obj.id).find(".icon-map-marker").css({
                            backgroundPosition: "-23px -55px"
                        });
                        $("#"+obj.id).find(".pt-detail").addClass("none");
                    });
                });
                return f;
            },
            handleStyle:function(map){
                map.setMapStyle({styleJson:yunspaceMapStyle});
            },
            handleMark: function (obj,map){
                var point = new BMap.Point(obj.lng, obj.lat);
                htm = '<div class="pt-wrap" id=' + obj.id + '>'
                    + '<a class="icon-c icon-map-marker icon-map-nopointer" href="javascript:;" target="_blank"></a>'
                    + '<div class="pt-detail none">'
                    +'<a href="'+obj.href+'" class="blank"  target="_blank">' + obj.name
                    +'<span class="img-blank"></span>'
                    +'<span class="jiao">◆</span>'
                    +'</a>'
                    +'</div>'
                    + '</div>';
                var rm = new BMapLib.RichMarker(htm, point, {"anchor": new BMap.Size(0, 0)});
                map.addOverlay(rm);
                $("#"+obj.id).on("click",function(){
                    $(".pt-detail").addClass('none');
                    $(".pt-wrap").find(".icon-map-marker").removeClass("icon-map-marker-animate");
                    $(this).find(".icon-map-marker").addClass("icon-map-marker-animate");
                    $(this).find('.pt-detail').css({
                        'left': "-"+$(this).find(".pt-detail").width() / 2 + 'px',
                    });
                    $(this).find(".pt-detail").removeClass('none');
                });
                $(".blank").unbind('click').on("click",function(){
                    window.open($(this).attr('href'));
                })
            },
            scrollMap:function(){
                var lst=$$.searchLeft.offset().top;
                var saoCodeH=$$.saoCode.outerHeight();
                var mapSectionH=$$.mapSection.outerHeight();
                var wh=$(window).height();
                var footerOutsideSt=$$.footerOutside.offset().top;
                handleScroll();
                $(win).on("scroll",function(){
                    handleScroll();
                });
                $(".others_search_more").on("click",function(){
                    lst=$$.searchLeft.offset().top;
                });
                function handleScroll(){
                    //console.log(mapSectionH+saoCodeH,$$.searchLeft.height());
                    if($$.searchLeft.height()<1000){
                        $$.mapSection.removeClass("map-section-fixed");
                        return;
                    }
                    var st=$(window).scrollTop();
                    //console.log(st+wh,footerOutsideSt);
                    if(st+wh>footerOutsideSt){
                        if(!$$.mapSection.hasClass("map-section-fixed")){
                            var w=$(win).width();
                            var r=(w-1180)/2;
                            $$.mapSection.css({
                                right:r+"px",
                                zIndex:1000
                            });
                            $$.mapSection.addClass("map-section-fixed");
                        }
                        if(wh-(mapSectionH+saoCodeH+50)>$$.footerOutside.height()){
                            var v=(mapSectionH+saoCodeH+50)+$$.footerOutside.height()-$(win).height();
                            if(v<0){
                                $$.mapSection.css({
                                    top:v/2+"px",
                                });
                            }
                            return;
                        }
                        var t=st+wh-footerOutsideSt+50;
                        $$.mapSection.css({
                            top:"-"+t+"px"
                        });
                    }else{
                        if(st>=lst-50){
                            $$.mapSection.addClass("map-section-fixed");
                            var w=$(win).width();
                            var r=(w-1180)/2;
                            $$.mapSection.css({
                                top:"50px",
                                right:r+"px",
                                zIndex:1000
                            });
                        }else{
                            $$.mapSection.removeClass("map-section-fixed");
                            //if(!$("#search_selected").hasClass("none")){
                            //    $$.mapSection.css({
                            //        top:"65px",
                            //        right:"0px"
                            //    });
                            //}else{
                            //    $$.mapSection.css({
                            //        top:"0px",
                            //        right:"0px"
                            //    });
                            //}
                            $$.mapSection.css({
                                top:"0px",
                                right:"0px"
                            });

                        }
                    }
                }
                $(win).on("resize",function(){
                    wh=$(window).height();
                    if($$.mapSection.hasClass("map-section-fixed")){
                        var w=$(win).width();
                        var r=(w-1180)/2;
                        if(w>=1180){
                            $$.mapSection.css({
                                right:r+"px"
                            });
                        }else{
                            $$.mapSection.css({
                                right:"0px"
                            });
                        }
                    }
                })
                return f;
            },
            getDistance:function(){
                if(window.lng==""||window.lat=="" || window.is_distance==""){
                    $$.searchList.find(".distance").addClass('none');
                    return f;
                }
                var pB = new BMap.Point(parseFloat(window.lng/10000),parseFloat(window.lat/10000));  // 创建点坐标B
                //console.log(parseFloat(window.lng/10000),parseFloat(window.lat/10000));
                $$.searchList.each(function(index,dom){
                    var $dom=$(dom);
                    var map = new BMap.Map("l-map");
                    var geo={lng:parseFloat(parseInt($dom.data('lng'))/10000),lat:parseFloat(parseInt($dom.data('lat'))/10000)};
                    var pA = new BMap.Point(geo.lng,geo.lat);  // 创建点坐标A
                    var distance=parseInt((map.getDistance(pA,pB))),finalDis;
                    if(distance<=10){
                        finalDis="<10米";
                    }else if(distance>10&&distance<1000){
                        finalDis=distance+"米";
                    }else if(distance>1000&&distance<100000){
                        finalDis=distance/1000+"公里";
                    }else if(distance>=100000){
                        finalDis=">100公里";
                    }
                    $dom.find(".distance").text("距离\n"+finalDis);
                });
                return f;
            },
            /*根据关键字进行是否重新刷新页面*/
            handlePageForKeyword:function(){
                var word=$('body').data('keyword'),that=this;
                var geoc = new BMap.Geocoder();
                if(word!=""){
                    var city="city="+$('body').data('city');
                    var category=window.category==""?"":"&category="+window.category;
                    var activeType=window.activeType==""?"":"&activeType="+window.activeType;
                    var size_range=window.size_range==""?"":"&size_range="+window.size_range;
                    var people_range=window.people_range==""?"":"&people_range="+window.people_range;
                    var is_outside=window.is_outside==""?"":"&is_outside="+window.is_outside;
                    var addr=word;
                    geoc.getPoint(word, function(point){
                        if(point==null){
                            return;
                        }
                        var href=$("#search-input2").data('href');
                        var url=href+"space?"+city+category+activeType+size_range+people_range+is_outside+"&lng="+point.lng+"&lat="+point.lat+"&keyword2="+addr;
                        window.location.href=url;
                    },$('body').data('city'));
                }
            },
            handleHightLight:function(){
                var that=this;
                that.siteLibrary=that.getLocationStorage();
                var keyword=that.siteLibrary.addr,keywords=[];
                if(keyword==undefined){
                    return f;;
                }
                keyword=keyword.split("");
                var l=2;
                /*获取关键字数组*/
                while(l<=keyword.length){
                    for(var k=0;k<keyword.length-1;k++){
                        var a=keyword[k];
                        for(var i=1;i<l;i++){
                            if(keyword[k+i]!=undefined){
                                a+=keyword[k+i];
                            }
                        }
                        keywords.push(a);
                    }
                    l++;
                }
                //去重
                var finalKeyword=[];
                for(var i in keywords){
                    if(finalKeyword.indexOf(keywords[i])==-1){
                        finalKeyword.push(keywords[i]);
                    }
                }
                //关键字渲染
                $$.searchListTitle.each(function(k,dom){
                    var $dom=$(dom);
                    var lt=$dom.find('a').html();
                    var addr=$dom.parents(".search_list").find(".adress p").text();
                    var keyWordMax='';
                    for(var i in keywords){
                        //console.log(keywords[i],1);
                        if(lt.indexOf(keywords[i])>-1){
                            if(keywords[i].length>keyWordMax.length){
                                keyWordMax=keywords[i];
                            }
                        }
                        if(addr.indexOf(keywords[i])>-1){
                            if(keywords[i].length>keyWordMax.length){
                                keyWordMax=keywords[i];
                            }
                        }
                    }
                    var newTitle=lt.replace(keyWordMax,"<font color='#f04'>"+keyWordMax+"</font>");
                    var addrress=addr.replace(keyWordMax,"<font color='#f04'>"+keyWordMax+"</font>");
                    $dom.find('a').html(newTitle);
                    $dom.parents(".search_list").find(".adress p").html(addrress);
                });
                return f;
            },
            /*初始化localstorage*/
            initLocationStorage:function(){
                var that=this;
                that.siteLibrary=localStorage.getItem('site_library');
                if(that.siteLibrary==null){
                    var a={};
                    a=JSON.stringify(a);
                    localStorage.setItem('site_library',a);
                    that.siteLibrary=localStorage.getItem('site_library');
                }
                that.siteLibrary=that.getLocationStorage();
                return that;
            },
            setLocationStorage:function(obj){
                localStorage.setItem('site_library',JSON.stringify(obj));
            },
            getLocationStorage:function(){
                return JSON.parse(localStorage.getItem('site_library'));
            }
        };
        f.init();
    })


})(window,document,jQuery);
