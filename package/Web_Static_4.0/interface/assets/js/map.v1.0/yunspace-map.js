var map = window.map,myGeo = window.myGeo;

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

var yunspaceMap =  function(){
    var self = this;
    self.options = {
        city: null,
        cityCenter: null,
        distanceFromLastPage : null,
        placeFromLastPage : null,
        addrFromLastPage : null,
        lat : null,
        lng : null
    };
    self.mapData = {
        lngAndLats:null,
        mapZoom : 17,
        mapStyle : yunspaceMapStyle,
    };
    self.isRequestData = null; //是否在请求数据
    self.isOnlyGetListData = false;
    self.allFieldPoint = {};
    self.postArguments = {};
    self.mapOptions = {minZoom:12,maxZoom:18,enableMapClick:false};

    self.map = window.map = new BMap.Map("map",self.mapOptions);
    self.myGeo = window.myGeo = new BMap.Geocoder();

    self.init = function(){

        self.options.distanceFromLastPage = decodeURI(self.GetQueryString('distance')) ; //上页传过来的距离
        self.options.placeFromLastPage = decodeURI(self.GetQueryString('place'));//上页传过来的地址 与距离相关

        self.options.addrFromLastPage = decodeURI(self.GetQueryString('addr'));//上页传过来的地址

        self.options.lat = decodeURI(self.GetQueryString('lat'))/10000;
        self.options.lng = decodeURI(self.GetQueryString('lng'))/10000;

        self.options.city = self.getCookie("city");
        self.options.cityCenter = self.options.city + '市中心';

        self.map.setMapStyle({styleJson:self.mapData.mapStyle});

        self.bindEvent();
        self.dealContainerHeight();
        self.initSearchInput();

        self.tolerantGetPoint();//自动获取cookie定位
    };

    self.tolerantGetPoint = function(){

        var localMapCenter = window.localStorage.getItem('yunspaceMapCenter');
        localMapCenter = JSON.parse(localMapCenter);

        if(self.options.lat && self.options.lng){ //带中心点
            var point = new BMap.Point(self.options.lng,self.options.lat);
            self.initMapWithPoint(point);
            //self.request();
        }
        else if(self.options.addrFromLastPage){
            self.initMapWithPlace(self.options.addrFromLastPage);
            setTimeout(function(){
                $('#customPlace').val(self.options.addrFromLastPage);

            },1000)
            setTimeout(function(){
                $('.tangram-suggestion-main').hide();
            },1500)
        }
        else if(localMapCenter){ // 根据本地中心点  定位
            var center = new BMap.Point(localMapCenter.lng,localMapCenter.lat);
            var yunspaceMapZoom = window.localStorage.getItem('yunspaceMapZoom');
            self.mapData.mapZoom = yunspaceMapZoom ? yunspaceMapZoom : self.mapData.mapZoom;
            self.initMapWithPoint(center);
            //self.request();
        }
        else if(self.options.cityCenter){
            self.myGeo.getPoint(self.options.cityCenter, function(point){
                if (point) {
                    self.initMapWithPoint(point);
                    //self.request();
                }else{
                    //TODO //没有这个点的提示
                }
            },self.options.city);

            //定位读取点
            var geolocation = new BMap.Geolocation();
            geolocation.getCurrentPosition(function(r){
                if(this.getStatus() == BMAP_STATUS_SUCCESS){
                    self.initMapWithPoint(r.point);
                    //self.request();
                }
                else{ //定位失败不做处理

                }
            },{enableHighAccuracy: true})

        }

    };

    self.initMapWithPoint = function(point){
        self.map.centerAndZoom(point,self.mapData.mapZoom);
        self.map.enableScrollWheelZoom();
        self.request();
        self.initMap()
    };
    self.initMapWithPlace = function(place){
        self.myGeo.getPoint(place, function(point){
            if (point) {
                self.initMapWithPoint(point);
                self.setLocalPoint();
            }else{
                //TODO //没有这个点的提示
            }
        },self.options.city);
    };
    self.initMap = function(){
        var dragend=false,t;
        self.map.addEventListener("dragend", function(){
            self.getNowLngAndLats();
            self.request();
            self.setLocalPoint();
            if( dragend==true)return;
            dragend=true;
            t=setTimeout(function(){
                dragend=false;
                $('#mapsearchCont').slideUp();
            },10000);
            //$('#mapsearchCont').slideUp();
        });
        $('#mapsearchCont').hover(function(){
            clearInterval(t);
            dragend=false;
            $('#mapsearchCont').slideDown();
        },function(){});

        self.map.removeEventListener('zoomend');
        self.map.addEventListener("zoomend", function(){
            self.mapData.mapZoom = self.map.getZoom();
            self.request();
            self.setLocalPoint();
            $('#mapsearchCont').slideUp();
        });

    };
    self.getNowLngAndLats = function(){
        var bs = self.map.getBounds();   //获取可视区域
        var bssw = bs.getSouthWest();   //可视区域左下角
        var bsne = bs.getNorthEast();   //可视区域右上角
        //alert("当前地图可视范围是：" + bssw.lng + "," + bssw.lat + "到" + bsne.lng + "," + bsne.lat);
        self.mapData.lngAndLats = {
            right_top_lat:bsne.lat,
            right_top_lng:bsne.lng,
            left_down_lat:bssw.lat,
            left_down_lng:bssw.lng
        };
    };

    self.request = function(isOnlyGetListData,page,orderBy,besePoint){

        if (self.isRequestData){
            return;
        }else{
            self.isRequestData = true
        }

        if($('#showChosen .hv').length > 0){
            $('#showChosen').show()
        }else{
            $('#showChosen').hide()
        }

        self.postArguments = {};//清空参数
        self.getNowLngAndLats();

        if(self.mapData.lngAndLats){ // 地图信息传给服务器端
            for(i in self.mapData.lngAndLats){
                self.postArguments[i] = self.mapData.lngAndLats[i];
            }
        }

        $('#chosenList a').each(function(){
            var key = $(this).data('dlist');
            var value = $(this).data('value');
            if(key){
                self.postArguments[key] = value;
            }
        });

        if(page){
            self.postArguments['p'] = page;
        }
        if(orderBy){
            self.postArguments['order'] = orderBy;
        }
        //if(besePoint){//根据中心点及距离
        //    self.postArguments['baidu_lng'] = besePoint.lng;
        //    self.postArguments['baidu_lat'] = besePoint.lat;
        //    self.postArguments['nearbymi'] = range;
        //}

        $('#loadingImg').show();
        if(!self.isOnlyGetListData){//只更新列表 或者 调取点数据 不调区域数据
            $.ajax({
                type: "get",
                url: "/static/api/map/search/spaceList/v2.json?handle=ajaxSearch",
                dataType: 'json',
                data:self.postArguments,
                success:function(data){
                    //console.log(data);
                    self.isRequestData = false;

                    var coordinate = data['coordinate'];
                    var status = data['status'] * 1;
                    var re = {};

                    if (!self.isOnlyGetListData && !besePoint){//是否只更新列表不更新地图

                        if(status != 0){
                            for (var i = 0;i<coordinate.length;i++){
                                var id = coordinate[i]['id'];
                                re[id] = true;

                                //对为添加到地图上的点进行添加
                                if(!self.allFieldPoint[id]){
                                    self.drawingPoint(coordinate[i]);
                                }
                            }
                            for(j in self.allFieldPoint){//j就是ID

                                if (re[j] == true){
                                    self.allFieldPoint[j].show();
                                }else{
                                    self.allFieldPoint[j].hide();
                                }
                            }

                        }else{

                            for(j in self.allFieldPoint){//j就是ID
                                self.allFieldPoint[j].hide();
                            }
                        }
                        self.hideAreaCircle();//隐藏区域圈
                    }
                    if (page){
                        self.scrollToList();
                    }
                    $('#listContent').html(data['data']);
                    self.ajaxBind();
                    self.dealContainerHeight();
                    $('#loadingImg').hide();

                },
                error:function(XMLHttpRequest, textStatus, errorThrown){
                    console.log(XMLHttpRequest, textStatus, errorThrown);
                    self.isRequestData = false;
                    $('#loadingImg').hide();
                }
            });
        }else{
            //getOrShowAreaData();
        }
    }

    self.GetQueryString = function(name){
        var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
        var r = window.location.search.substr(1).match(reg);
        if(r!=null)return  unescape(r[2]);
        return '';
    };
    self.getCookie = function getCookie(c_name)
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
    };

    self.drawingPoint = function(pointData){
        var lat,lng,point,htm,rm,product_name,url,space_name_url;
        lat = pointData['geo_lat']/10000;
        lng = pointData['geo_lng']/10000;
        product_name = pointData['space_name'];
        space_name_url = pointData['space_name_url'];
        //url = '/service_info/'+ pointData['id'] +'.html';
        url = '/site/'+space_name_url;
        point = new BMap.Point(lng,lat);
        htm = '<div class="pt-wrap" id='+pointData['id']+'>'
            + '<a class="icon-c icon-map-marker icon-map-nopointer" href="javascript:;"></a>'
            + '<div class="pt-detail">'
            +'<a class="blank" href="'+url+'" target="_blank">'+product_name
            +'<span class="img-blank"></span>'
            +'<span class="jiao">◆</span>'
            +'</a>'
            +'</div>'
            + '</div>';

        //htm = '<p>css</p>' +
        //    '<a id='+pointData['id']+' class="icon-c icon-map-marker icon-map-nopointer" href="javascript:;">' +
        //    '</a>';

        rm = new BMapLib.RichMarker(htm, point, { "anchor": new BMap.Size(0, 0)});
        self.map.addOverlay(rm);

        var rNode = rm._container.childNodes[0].childNodes[1];
        var container = $(rm._container);
        //rNode.style.left = -rNode.offsetWidth/2+12+"px";
        rNode.style.display="none";

        $(rNode).find('.blank').on('click',function(){
            window.open(url);
        });

        //var rNode = rm._container.childNodes[0].childNodes[1];
        //rNode.style.left = -rNode.offsetWidth/2+15+"px";
        //rNode.style.display="none";

        rm.addEventListener('onmouseover',function(e){
            //console.log(e.target.className)
            var node = this._container.childNodes[0];
            $(node).find('.icon-map-marker').addClass('icon-map-pointer');
            //if(!$(node).hasClass('pt-click')){
            //   $(node).addClass('pt-click');
            //}

            //if(node.className.match('pt-click')){//click事件之后需要添加一个class
            //    node.className = "icon-c icon-map-marker icon-map-pointer pt-click";
            //}else{
            //    node.className = "icon-c icon-map-marker icon-map-pointer";
            //}


        });

        rm.addEventListener('onmouseout',function(e){
            //console.log(e.target.className)
            var node = this._container.childNodes[0];
            if(!$(node).hasClass('pt-click')){
                $(node).find('.icon-map-marker').removeClass('icon-map-pointer').addClass('icon-map-nopointer');
            }
            //if(!$(node).hasClass('pt-click')){
			//
            //}
            //if(node.className.match('pt-click')){ //click事件之后需要添加一个class
            //    node.className = "icon-c icon-map-marker icon-map-nopointer pt-click";
            //}else{
            //    node.className = "icon-c icon-map-marker icon-map-nopointer";
            //}
        });

        rm.addEventListener('click',function(e){
            self.pointClick.call(this)
        });

        self.allFieldPoint[pointData['id']] = rm;

    };
    self.pointClick = function(){
        var node = this._container.childNodes[0];
        var href = node.href;
        for(i in self.allFieldPoint){
            var node2 = self.allFieldPoint[i]._container.childNodes[0];
            $(node2).removeClass('pt-click');
            $(node2).find('.icon-map-marker').removeClass('icon-map-pointer').addClass('icon-map-nopointer');
            //node2.className = "icon-c icon-map-marker icon-map-nopointer";
        }
        if(!$(node).hasClass('deal')){
            $(node).find('.pt-detail').css({
                'left': - $(node).find('.pt-detail').width()/2 + 'px',
            });
        }

        $(node).addClass('deal');
        $(node).find('.icon-map-marker').addClass('icon-map-pointer');
        $(node).addClass('pt-click');
        //node.className = "icon-c icon-map-marker icon-map-nopointer pt-click";
        //self.getOnePlaceInfo(id);
    }
    self.offsetTop = function( elements ){
        var top = elements.offsetTop;
        var parent = elements.offsetParent;
        while( parent != null ){
            top += parent.offsetTop;
            parent = parent.offsetParent;
        };
        return top;
    };
    self.offsetLeft = function( elements ){
        var left = elements.offsetLeft;
        var parent = elements.offsetParent;
        while( parent != null ){
            left += parent.offsetLeft;
            parent = parent.offsetParent;
        };
        return left;
    };
    self.dealContainerHeight = function(){
        var winH = $(window).height();
        var dH = $('#mapsearchCont .mapsearch-cont').height();
        if(dH > (winH-150)){
            $('#mapsearchCont').css({
                'height':winH-150
            });
        }else {
            $('#mapsearchCont').css({
                'height':'auto'
            });
        }

    };
    self.getOnePlaceInfo = function (placeId){
        var point = self.allFieldPoint[placeId].getPosition();
        var condition = {};
        $('#chosenList a').each(function(){
            var key = $(this).data('dlist');
            var value = $(this).data('value');
            self.postArguments[key] = value;
            if(key){
                condition[key] = value;
            }
        });
        condition['id'] = placeId;
        condition['lat'] = point.lat;
        condition['lng'] = point.lng;
        $.ajax({
            type:"get",
            url:"/static/api/map/search/pointShow/v2.json",
            dataType:'json',
            data:condition,
            success:function(data){
                $('#listContent').html(data['data']);
                self.ajaxBind();
            },
            error:function(XMLHttpRequest, textStatus, errorThrown){
                console.log(XMLHttpRequest, textStatus, errorThrown)
            }

        })
    };
    self.getObjectLength = function(object){
        var length = 0;
        for(i in object){
            length ++
        }
        return length;
    };
    self.hideAreaCircle = function(){
        for(i in self.allAreaData){
            self.allAreaData[i].hide();
        }
    };
    self.getOrShowAreaData = function(){ //获取或者显示地区数据
        if(!self.getObjectLength(self.allAreaData)){
            $.ajax({
                type:"get",
                url:"static/api/map/area.json",
                dataType:'json',
                success:function(data){
                    //console.log(data);
                    self.drawingAreaData(data.data);
                    $('#loadingImg').hide();
                    self.isRequestData = false;
                },
                error:function(XMLHttpRequest, textStatus, errorThrown){
                    console.log(XMLHttpRequest, textStatus, errorThrown);
                    $('#loadingImg').hide();
                    self.isRequestData = false;
                }
            });

        }else{
            self.isRequestData = false;// IMPORTANT  记得将状态改变
            for(i in self.allAreaData){
                self.allAreaData[i].show();
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
        self.hideAllPoint();
    };
    self.hideAllPoint = function(){
        for(i in self.allFieldPoint){
            self.allFieldPoint[i].hide();
        }
    };
    self.scrollToList = function(){
        $("#mapsearchCont").animate({scrollTop:0},100);
    };
    self.togglePointClass = function(id){

        self.pointClick.call(self.allFieldPoint[id]);
    };

    //self.setZoom = function(zoom){
    //    self.map.setZoom();
    //    self.mapData.mapZoom = zoom;
    //};

    self.bindEvent = function(){
        $(document).on('click','#chosenList a',function(){
            return false;
        });
        $(document).on("click",'.j_search_date',function(){
            var space_id =$(this).attr('data-id');
            var space_name =$(this).attr('data-name');
            var demand_city =$(this).attr('date-city');
            $(".search-box").find(".space_id").val(space_id);
            $(".search-box").find(".space_name").val(space_name);
            $(".search-box").find(".demand_city").val(demand_city);
            $(".cover,.search-box").fadeIn();
        });
        $(document).on('click','#search-box-close',function(){
            $(".search-box").find("input[name='username']").val('');
            $(".search-box").find("input[name='phone']").val('');
            $(".search-box").find("input[name='date_start']").val('');
            $(".search-box").find("input[name='date_end']").val('');
            $(".search-box").find("input[name='other_demand']").val('');
            $(".cover,.search-box").fadeOut();
        });
        $('.search-box-btn').on('click',function(){
            var contact_name = $(".search-box").find("input[name='username']").val();
            var contact_phone = $(".search-box").find("input[name='phone']").val();
            var start_time = $(".search-box").find("input[name='date_start']").val();
            var end_time = $(".search-box").find("input[name='date_end']").val();
            var other_demand = $(".search-box").find("input[name='other_demand']").val();
            var space_id = $(".search-box").find(".space_id").val();
            var space_name = $(".search-box").find(".space_name").val();
            var from_type = $(".search-box").find(".from_type").val();
            var demand_city=$(".search-box").find(".demand_city").val();
            var from_demand = '';
            var data_a='';
            from_demand = "来源百科id:"+space_id+"百科名："+space_name;
            if(from_type!=''){
                if(contact_name==''){
                    $(".search-box").find(".error_msg").removeClass('none');
                    $(".search-box").find(".error_msg").html('请填写您的称呼，方便我们联系你！');
                    setTimeout("$('.search-box').find('.error_msg').addClass('none')",3000);
                    return false;
                }
                if(contact_phone==''){
                    $(".search-box").find(".error_msg").removeClass('none');
                    $(".search-box").find(".error_msg").html('请填写您的手机号，方便我们联系你！');
                    setTimeout("$('.search-box').find('.error_msg').addClass('none')",3000);
                    return false;
                }
            }
                if(start_time==''){
                    $(".search-box").find(".error_msg").removeClass('none');
                    $(".search-box").find(".error_msg").html('请选择开始日期，以便为您确定档期！');
                    setTimeout("$('.search-box').find('.error_msg').addClass('none')",3000);
                    return false;
                }
                if(end_time==''){
                    $(".search-box").find(".error_msg").removeClass('none');
                    $(".search-box").find(".error_msg").html('请选择结束日期，以便为您确定档期！');
                    setTimeout("$('.search-box').find('.error_msg').addClass('none')",3000);
                    return false;
                }
                data_a = {
                    username: contact_name,
                    phone: contact_phone,
                    content: other_demand+from_demand,
                    start_time: start_time,
                    end_time: end_time,
                    from_type: from_type,
                    object_id: space_id,
                    object_name: space_name,
                    demand_city:demand_city,
                    object_type: "site",
                    action: 'new_events'
                };
            //console.log(data_a);
            //return false;
            YunSpace.api("demand/create.jsonp", data_a, function (data) {
                if (data.status == 1) {
                    alert('提交成功，我们会尽快与您联系！');
                    $(".cover,.search-box").fadeOut();
                }else{
                    alert(data.msg);
                }
            });
            //$(".cover,.search-box").fadeOut();
        });

        $('.search-date-start').focus(function(){
            $('.search-date-outside').show();
        });
        $('.search-date-end').focus(function(){
            $('.search-date-outside').show();
        });
        $('.search-box-placeholder').click(function(){
            $(this).css('display','none');
            $(this).siblings(".search-box-input").focus();
            $('.search-date-outside').hide();
        });
        window.onresize = function(){
            self.dealContainerHeight();
        }
        $('.js-a-downup').on('click',function() {

            var thisI = $(this).find('i');
            if(thisI.hasClass('a-up')){
                $(this).parents('dd').css({
                    'height': 26+'px'
                });
                thisI.removeClass('a-up');
            }else{
                $(this).parents('dd').css({
                    'height': 'auto'
                });
                thisI.addClass('a-up');
            }

        })
        //$(document).on('click','.a-up',function(){
        //    $(this).parents('dd').css({
        //        'height': 22+ 'px'
        //    });
        //});

        $('#zoomUp').on('click',function(){
            if(self.mapData.mapZoom <= self.mapOptions.maxZoom && self.mapData.mapZoom > self.mapOptions.minZoom) {
                self.mapData.mapZoom -- ;
                self.map.setZoom(self.mapData.mapZoom);
            }
        });
        $('#zoomDown').on('click',function(){
            if(self.mapData.mapZoom < self.mapOptions.maxZoom && self.mapData.mapZoom >= self.mapOptions.minZoom){
                self.mapData.mapZoom  ++;
                self.map.setZoom(self.mapData.mapZoom);
            }

        });
        $('#clearInput').on('click',function(){
            $('#customPlace').val('');
        });
        $('#listContent').on('mouseenter','.mcont-list-cont li',function(){
            var placeId = $(this).find('.mcont-inquiry-details.j_search_date').data('id');
            self.togglePointClass(placeId)
        });
        $(document).on('click',"#pagers a",function(){
            var value = $(this).data('value');
            if (value){
                self.request(true,value)
            }
            return false;
        });
        //$('#customPlace').onfocus = function(){
        //
        //}

        $('#customPlace').on('mouseenter',function(){
            $('#mapsearchCont').slideDown();
        });

        $('#customPlace').on('keydown',function(event){//兼容表单提交 回车提交可以被地图插件禁了
            if(event.keyCode == 13){
                self.initMapWithPlace($(this).val());
            }
        });
        $('#customPlace').change(function(){
            self.initMapWithPlace($(this).val());
        });

        $('#sortList a').on('click',function(){

            if(!$(this).hasClass('active')){
                var id = $(this).data('id');
                self.request(true,false,id);
                $(this).addClass('active').siblings('a').removeClass('active');
            }
            return false
        });

        $(document).on("click",".c-close",function(){
            var dlist = $(this).parent().data("dlist");
            $('#mcont-screening #'+dlist+'').find(".on").removeClass("on");
            $(this).parent().remove();
            self.request();
            return false;
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
                    var cloneLink = $(this).clone().addClass('hv').append('<span class="delete-btn js-delete icon-c c-close"></span>');
                    cloneLink.addClass(dataDlist);
                    cloneLink.attr("data-dlist",dataDlist);
                    $('#chosenList').append(cloneLink);
                    $(this).addClass("on");
                }else{
                    $(this).removeClass("on")
                }
            }
            self.request();
            return false
        });
    };
    self.ajaxBind = function(){
        $('.mcont-list-cont li').on('mouseenter',function(){
            $(this).find('.icon-inq-gray').hide();
            $(this).find('.mcont-inquiry-details').stop().animate({
                'left':'-126px'
            },300);
        });
        $('.mcont-list-cont li').on('mouseleave',function(){
            $(this).find('.icon-inq-gray').show();
            $(this).find('.mcont-inquiry-details').stop().animate({
                'left':0
            },300);
        });
    };
    self.setLocalPoint = function(){
        var pt = self.map.getBounds().getCenter();
        var zoom =  self.map.getZoom();
        window.localStorage.setItem('yunspaceMapCenter',JSON.stringify(pt));
        window.localStorage.setItem('yunspaceMapZoom',zoom);
    };
    self.initSearchInput = function(){
        // 百度地图API功能  搜索功能
        function G(id) {
            return document.getElementById(id);
        }

        //var map = new BMap.Map("l-map");
        //map.centerAndZoom("北京",12);
        // 初始化地图,设置城市和地图级别。

        var ac = new BMap.Autocomplete(    //建立一个自动完成的对象
            {"input" : "customPlace"
                ,"location" : self.map
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
                self.initMapWithPoint(pp);

            }
            var local = new BMap.LocalSearch(map, { //智能搜索
                onSearchComplete: myFun
            });
            local.search(myValue);
        }

    };
    
    return self.init();
};
var newMap = yunspaceMap();