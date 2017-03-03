var plugin={
    nodes:{},
    ac:"",
    map:"",  //map
    geoc:"",  //地图的对象
    siteLibrary:{city:"",city_select:"",active_type:"",addr:"",geo:{}}, //local赋值对象
    init:function(ele,args,fn){
        this.nodes={
            win:$(window),
            doc:$(document),
            publicContainer:$("#public-container"),
            publicList:$(".public-list"),
            publicSelect:$(".public-select"),
            publicSelectH:$(".public-select-h"),
            publicDropBody:$(".public-drop-body"),
            publicDrop:$(".public-drop"),
            publicInput:$("#public-input"),
            publicInputTwo:$("#public-input2"),
            publicCateTitle:$(".public-cate-title"),
            publicSelectList:$(".public-select-list"),
            publicSelectListH:$(".public-select-list-h"),
            searchSpace:$("#search-space-three"),
            headerBodyForm:$(".header-body-form"),
            searchTab:$("#searchTab"),
            searchLabelList:$(".search_label_list")
        }
        var that=this;
        var st=this.nodes.win.scrollTop();
        if(st>=300){
            this.nodes.publicContainer.show();
        }else{
            this.nodes.publicContainer.hide();
        }
        this.nodes.publicInputTwo.on('keyup',function(e){
            if (e.keyCode == 13){
                that.nodes.searchSpace.trigger("click");
            }
        });
        //console.log(this.nodes.publicList.find("li:nth-of-type(4n) a").length);
        this.nodes.publicList.find("li:nth-of-type(4n) a").css({ border:"0"})
        this.showPublicSpace().showPublicDrop().docTake().searchBaidu().keywordBind().initLocation();
        this.initPublicStyle();
        this.searchSpace();

    },
    //初始化定位
    initLocation:function(){
        var geolocation = new BMap.Geolocation(),that=this,citys=[];
        that.nodes.publicContainer.find(".public-select-list-h:first li").each(function(index,dom){
            var $dom=$(dom);
            citys.push($dom.text());
        });
        //定位
        var cityLocal;
        that.siteLibrary=that.getLocationStorage()||that.siteLibrary;
        //console.log(that.siteLibrary.city_select,11);
        if( that.siteLibrary.city_select!=undefined&&that.siteLibrary.city_select!=""){
            cityLocal=that.siteLibrary.city_select;
            if(window.ac!=undefined){
                window.ac.setLocation(cityLocal);
            }
            for (var i in citys){
                if(cityLocal.indexOf(citys[i])>-1){
                    that.handleLocalText(citys,i);
                    //if(that.siteLibrary.active_type!=undefined&&that.siteLibrary.active_type!=""){
                    var url=window.location.href;
                    if(url.indexOf('/space')==-1){
                        $("input[name='active_type']").val(that.siteLibrary.active_type);
                        that.nodes.headerBodyForm.find(".public-select-h:last input").val(that.siteLibrary.active_type);
                        that.nodes.publicContainer.find(".public-select-h:last input").val(that.siteLibrary.active_type);
                    }
                    //else{
                        //$("input[name='active_type']").val("");
                        //that.nodes.headerBodyForm.find(".public-select-h:last input").val("");
                        //that.nodes.publicContainer.find(".public-select-h:last input").val("");
                    //}
                    that.handleLocationStorage();
                    return that;
                }
            }
            if(that.nodes.headerBodyForm.length>0){
                that.nodes.headerBodyForm.find(".public-select-h:first input").val('不限');
            }
            that.nodes.publicContainer.find("input[name='city']").val('不限');
            that.nodes.publicContainer.find(".public-select-h:first input").val('不限');
            that.handleLocationStorage();
        }else{
            //geolocation.getCurrentPosition(function(r){
            var city=that.nodes.publicContainer.data('city');
            that.geoc.getPoint(city, function(r) {
                that.geoc.getLocation(r, function (rs) {
                    var addComp = rs.addressComponents;
                    if (window.ac != undefined) {
                        window.ac.setLocation(addComp.city);
                    }
                    cityLocal = addComp.city;
                    for (var i in citys) {
                        if (cityLocal.indexOf(citys[i]) > -1) {
                            that.handleLocalText(citys, i);
                            //that.siteLibrary=that.getLocationStorage();
                            that.siteLibrary.geo = {lng: r.lng, lat: r.lat};
                            that.siteLibrary.city = citys[i];
                            that.siteLibrary.city_select =citys[i];
                            that.setLocationStorage(that.siteLibrary);
                            return that;
                        }
                    }
                    if (that.nodes.headerBodyForm.length > 0) {
                        that.nodes.headerBodyForm.find(".public-select-h:first input").val('不限');
                    }
                    that.nodes.publicContainer.find("input[name='city']").val('不限');
                    that.nodes.publicContainer.find(".public-select-h:first input").val('不限');
                    that.handleLocationStorage();
                    that.geoc.getPoint("北京", function (point) {
                        that.siteLibrary.geo = {lng: point.lng, lat: point.lat};
                        that.siteLibrary.city = "北京";
                        that.siteLibrary.city_select = "北京";
                        that.setLocationStorage(that.siteLibrary);
                    })
                });
            });
            //},{enableHighAccuracy: true});
        }
        return this;
    },
    handleLocalText:function(citys,i){
        var that=this;
        if(that.nodes.headerBodyForm.length>0){
            that.nodes.headerBodyForm.find(".public-select-h:first input").val(citys[i]);
            //that.nodes.headerBodyForm.find(".public-select-h:first input").val(citys[i]);
            that.nodes.headerBodyForm.find(".public-select-h:last input").val(that.siteLibrary.active_type);
        }
        if(window.city==""||window.city==undefined){
            that.nodes.publicContainer.find("input[name='city']").val(citys[i]);
            that.nodes.publicContainer.find(".public-select-h:first input").val(citys[i]);
            $("input[name='city']").val(citys[i]);
            that.nodes.publicContainer.find(".public-select-h:first input").val(citys[i]);
            that.ac.setLocation(citys[i]);
        }else{
            that.ac.setLocation(window.city);
        }
    },
    //处理当前地标的本地存储(在搜索页面的时候)
    handleLocationStorage:function(){
        var url=window.location.href,that=this,citys=[];
        if(url.indexOf('/space')>-1&&that.siteLibrary.city!=""){
           setTimeout(function(){
               that.siteLibrary=that.getLocationStorage();
               //that.siteLibrary.city=window.city;
               that.siteLibrary.active_type=$(".space_form").find("input[name='active_type']").val();
               that.siteLibrary.addr=$("#search-input2").val();
               that.nodes.publicContainer.find(".public-select-list-h:first li").each(function(index,dom){
                   var $dom=$(dom);
                   citys.push($dom.text());
               });
               //console.log(window.city ,111);
               if(window.city!=""){
                   that.siteLibrary=that.getLocationStorage();
                   that.siteLibrary.city_select=window.city;
                   that.setLocationStorage(that.siteLibrary);
                   $(".space_form").find(".result span").text(that.siteLibrary.city_select);
                   that.nodes.publicContainer.find("input[name='city']").val(that.siteLibrary.city_select);
                   that.nodes.publicContainer.find(".public-select-h:first input").val(that.siteLibrary.city_select);
               }else{
                   $(".space_form").find(".result span").text('不限');
                   that.nodes.publicContainer.find("input[name='city']").val('不限');
                   that.nodes.publicContainer.find(".public-select-h:first input").val('不限');
               }
               that.setLocationStorage(that.siteLibrary);
               /*填补公共头部搜索框*/
               //that.nodes.publicContainer.find("#public-input2").val($("#search-input2").val());
               that.nodes.publicContainer.find(".public-select-h:last input").val(that.siteLibrary.active_type);
               //再次根据搜索框定位,且处理地标显示
               //that.geoc.getPoint(window.keyword, function(point){
               //    if(point==null){
               //        //alert('定位失败,请重新搜索!aasd!');
               //        return;
               //    }
               //    that.geoc.getLocation(point, function(rs){
               //        var addComp = rs.addressComponents;
               //        var newCity=addComp.city;
               //        $(".space_form").find(".result span").text(that.siteLibrary.city_select);
               //        var currentCity=$(".space_form").find(".result span").text();
               //        if(addComp.city.indexOf(currentCity)>-1){
               //             return;
               //        }
               //        if(addComp.city.indexOf("市")>-1){
               //            newCity=addComp.city.substr(0,addComp.city.indexOf("市"));
               //        }
               //        $(".space_form").find(".result span").text(newCity);
               //        that.nodes.publicContainer.find("input[name='city']").val(newCity);
               //        that.nodes.publicContainer.find(".public-select-h:first input").val(newCity);
               //        //that.siteLibrary.city=newCity;
               //        //that.setLocationStorage(that.siteLibrary);
               //    });
               //});
               localStorage.setItem('site_library',JSON.stringify(that.siteLibrary));
           },1000);

        }
    },
    initPublicStyle:function(){
        $(".select-wrapper").removeClass('none');
        this.nodes.publicInputTwo.removeClass('none');
        this.nodes.publicInput.addClass('none');
        this.nodes.publicContainer.find('form').attr('action','/space');
        $("input[name='search_type']").val('site_library');
        this.nodes.publicSelect.find("code").text("找场地");
        return this;
        //var searchType=localStorage.getItem('public_space');
        //if(searchType!=null){
        //    searchType=JSON.parse(searchType).publicSelect;
        //}
        //if(searchType==null||searchType!="找场地"){
        //    $(".select-wrapper").addClass('none');
        //    this.nodes.publicInputTwo.addClass('none');
        //    this.nodes.publicInput.removeClass('none');
        //    this.nodes.publicContainer.find('form').attr('action','/database');
        //}else{
        //
        //}
    },
    showPublicSpace:function(){
        var that=this;
        var show=false;
        that.nodes.win.on("scroll",function(){
            $(".tangram-suggestion-main").css('display','none');
            var $this=$(this);
            var st=$this.scrollTop();
            //TODO::滚动一定高度显示
            if(st>=300){
                if( show==true)return;
                that.nodes.publicContainer.show();
                show=true;
            }else{
                if( show==false)return;
                that.nodes.publicContainer.hide();
                that.nodes.publicSelectList.addClass("none");
                that.nodes.publicDropBody.addClass("none");
                that.nodes.publicSelect.find(".down-icon").css({
                    backgroundPosition:"-89px -11px"
                });
                show=false;
            }
        });
        return that;
    },
    showPublicDrop:function(){
        var that=this;
        $(document).on("click",function(e){
            if($(e.target).closest(".public-select-h").length==0){
                $('.public-select-list-h').addClass('none');
                $(".down-icon").css({
                    backgroundPosition:"-89px -11px"
                });
            }
        });
        //城市、活动类型选择下拉
        that.nodes.publicSelectH.hover(function(){
            $('.public-select-list-h').addClass('none');
            $(".down-icon").css({
                backgroundPosition:"-89px -11px"
            });
            $(this).find('.public-select-list-h').removeClass("none");
            $(this).find(".down-icon").css({
                backgroundPosition:"-89px -78px"
            });
        },function(){
            $('.public-select-list-h').addClass('none');
            $(this).find(".down-icon").css({
                backgroundPosition:"-89px -11px"
            });
        });
        that.nodes.publicSelectListH.find("li").each(function(index,dom){
            var $dom=$(dom);
            $dom.on("click",function(){
                var $this=$(this);
                var v=$this.text();
                //$(this).parent().siblings("span").html("<code>"+v+'</code><i class="down-icon"></i>');
                $(this).parent().siblings("span").html('<input type="text" value="'+v+'">'+'<i class="down-icon"></i>');
                that.siteLibrary=that.getLocationStorage();
                if($(this).parent().hasClass("city")){
                    $(".city").val(v);
                    window.city=v;
                    that.siteLibrary.city_select=v;
                    if(v=="不限"){
                        that.setLocationStorage(that.siteLibrary);
                    }else{
                        that.geoc.getPoint(v, function(point){
                            if(point==null){
                                alert('定位失败,请重新搜索!!');
                                return;
                            }
                            that.ac.setLocation(v);
                            /*设置搜索范围,window.ac来自home1.js*/
                            if(window.ac!=undefined){
                                window.ac.setLocation(v);
                            }
                            that.siteLibrary.geo={lng:point.lng,lat:point.lat};
                            that.setLocationStorage(that.siteLibrary);
                            //var href=$("#public-container").data('root');
                            //var url=href+"space?"+city+"&active_type="+active_type+"&lng="+point.lng+"&lat="+point.lat+"&keyword2="+addr;
                            //window.location.href=url;
                        });
                    }

                }
                if($(this).parent().hasClass("active_type")){
                    that.siteLibrary.active_type=v;
                    that.setLocationStorage(that.siteLibrary);
                    $(".active_type").val(v);
                }
                $(this).parents('.public-select-list-h').addClass("none");
                $(this).parent().siblings().find(".down-icon").css({
                    backgroundPosition:"-89px -11px"
                });
            })
        });
        that.nodes.publicSelect.find("span").on("click",function(){
            that.nodes.publicSelectList.toggleClass("none");
            if(that.nodes.publicSelectList.hasClass("none")){
                that.nodes.publicSelect.find(".down-icon").css({
                    backgroundPosition:"-89px -11px"
                });
            }else{
                that.nodes.publicDropBody.addClass("none");
                that.nodes.publicSelect.find(".down-icon").css({
                    backgroundPosition:"-89px -78px"
                });
            }
        });
        that.nodes.publicSelectList.find("li").each(function(index,dom){
            var $dom=$(dom);
            $dom.unbind('click').on("click",function(){
                var $this=$(this);
                var v=$this.text();
                that.nodes.publicSelect.find("span").html("<code>"+v+'</code><i class="down-icon down-icon-white"></i>');
                switch (v){
                    case '找场地':
                        that.nodes.publicDrop.find("input[name='search_type']").val('site_library');
                        that.nodes.publicInput.addClass("none");
                        that.nodes.publicInputTwo.removeClass("none");
                        $(".select-wrapper").removeClass('none');
                        that.nodes.publicContainer.find('form').attr('action','/space');
                        break;
                    case '找资讯':
                        that.nodes.publicDrop.find("input[name='search_type']").val('project_library');
                        that.nodes.publicInput.removeClass("none");
                        that.nodes.publicInputTwo.addClass("none");
                        $(".select-wrapper").addClass('none');
                        that.nodes.publicContainer.find('form').attr('action','/database');
                        break;
                    case '找公司':
                        that.nodes.publicDrop.find("input[name='search_type']").val('company_library');
                        that.nodes.publicInput.removeClass("none");
                        that.nodes.publicInputTwo.addClass("none");
                        $(".select-wrapper").addClass('none');
                        that.nodes.publicContainer.find('form').attr('action','/database');
                        break;
                    case '找文库':
                        that.nodes.publicDrop.find("input[name='search_type']").val('paper_library');
                        that.nodes.publicInput.removeClass("none");
                        that.nodes.publicInputTwo.addClass("none");
                        $(".select-wrapper").addClass('none');
                        that.nodes.publicContainer.find('form').attr('action','/database');
                        break;
                }
                if(that.nodes.searchTab.length>0){
                    switch (v){
                        case '找场地':
                            //that.nodes.publicDrop.find("input[name='search_type']").val('site_library');
                            //that.nodes.publicInput.addClass("none");
                            //that.nodes.publicInputTwo.removeClass("none");
                            //$(".select-wrapper").removeClass('none');
                            //that.nodes.publicContainer.find('form').attr('action','/space');
                            that.nodes.searchTab.find("a").eq(0).trigger("click");
                            break;
                        case '找资讯':
                            //that.nodes.publicDrop.find("input[name='search_type']").val('project_library');
                            //that.nodes.publicInput.removeClass("none");
                            //that.nodes.publicInputTwo.addClass("none");
                            //$(".select-wrapper").addClass('none');
                            //that.nodes.publicContainer.find('form').attr('action','/database');
                            that.nodes.searchTab.find("a").eq(1).trigger("click");
                            break;
                        case '找公司':
                            //that.nodes.publicDrop.find("input[name='search_type']").val('company_library');
                            //that.nodes.publicInput.removeClass("none");
                            //that.nodes.publicInputTwo.addClass("none");
                            //$(".select-wrapper").addClass('none');
                            //that.nodes.publicContainer.find('form').attr('action','/database');
                            that.nodes.searchTab.find("a").eq(2).trigger("click");
                            break;
                        case '找文库':
                            //that.nodes.publicDrop.find("input[name='search_type']").val('paper_library');
                            //that.nodes.publicInput.removeClass("none");
                            //that.nodes.publicInputTwo.addClass("none");
                            //$(".select-wrapper").addClass('none');
                            //that.nodes.publicContainer.find('form').attr('action','/database');
                            that.nodes.searchTab.find("a").eq(3).trigger("click");
                            break;
                    }
                }
                if(that.nodes.searchLabelList.length>0){
                    switch (v){
                        case '找场地':
                            //that.nodes.publicDrop.find("input[name='search_type']").val('site_library');
                            that.nodes.publicInput.addClass("none");
                            that.nodes.publicInputTwo.removeClass("none");
                            $(".public-input").find(".select-wrapper").removeClass("none");
                            //$(".select-wrapper").removeClass('none');
                            that.nodes.searchLabelList.find("li").eq(0).trigger("click");
                            break;
                        case '找资讯':
                            //that.nodes.publicDrop.find("input[name='search_type']").val('project_library');
                            that.nodes.publicInput.removeClass("none");
                            that.nodes.publicInputTwo.addClass("none");
                            $(".public-input").find(".select-wrapper").addClass("none");
                            //$(".select-wrapper").addClass('none');
                            //that.nodes.publicContainer.find('form').attr('action','/database');
                            that.nodes.searchLabelList.find("li").eq(1).trigger("click");
                            //console.log(that.nodes.searchLabelList);
                            break;
                        case '找公司':
                            //that.nodes.publicDrop.find("input[name='search_type']").val('company_library');
                            $(".public-input").find(".select-wrapper").addClass("none");
                            that.nodes.publicInput.removeClass("none");
                            that.nodes.publicInputTwo.addClass("none");
                            //$(".select-wrapper").addClass('none');
                            //that.nodes.publicContainer.find('form').attr('action','/database');
                            that.nodes.searchLabelList.find("li").eq(2).trigger("click");
                            break;
                        case '找文库':
                            //that.nodes.publicDrop.find("input[name='search_type']").val('paper_library');
                            that.nodes.publicInput.removeClass("none");
                            that.nodes.publicInputTwo.addClass("none");
                            $(".public-input").find(".select-wrapper").addClass("none");
                            //$(".select-wrapper").addClass('none');
                            //that.nodes.publicContainer.find('form').attr('action','/database');
                            that.nodes.searchLabelList.find("li").eq(3).trigger("click");
                            break;
                    }
                }

                that.nodes.publicSelectList.addClass("none");
                that.nodes.publicSelect.find(".down-icon").css({
                    backgroundPosition:"-89px -11px"
                });
            })
        });
        that.nodes.publicDrop.hover(function(){},function(){
            that.nodes.publicDropBody.addClass("none");
            that.nodes.publicInput.blur();
        });
        var publicInput=that.nodes.publicInput||that.nodes.publicInputTwo;
        publicInput.on("focus",function(){
            var v=that.nodes.publicInput.val();
            if(v!=""){
                that.nodes.publicDropBody.eq(1).removeClass("none");
                return that;
            }
            that.nodes.publicDropBody.addClass("none");
            that.nodes.publicDropBody.eq(0).removeClass("none");
            //that.nodes.publicDropBody.eq(1).removeClass("none");
        });
        publicInput.on("keyup",function(){
            var $this=$(this);
            var keyword=$this.val();
            var show=false;
            if(keyword!=""){
                YunSpace.api("search/get/library/list.jsonp",{
                    keyword : keyword
                },function(data){
                    if(data.status==1){
                        that.nodes.publicDropBody.eq(1).find('ul').remove();
                        that.nodes.publicDropBody.eq(1).append(data.data);
                        that.nodes.publicDropBody.eq(0).addClass("none");
                        that.nodes.publicDropBody.eq(1).removeClass("none");
                        $(".chose_keyword").click(function(){
                            var key_word  = $(this).find('span').text();
                            var search_type =  that.nodes.publicDrop.find("input[name='search_type']").val();
                            window.location.href="/database?action=is_submit&search_type="+search_type+"&keyword="+key_word;
                        });
                    }else{
                        that.nodes.publicDropBody.eq(1).addClass("none");
                        that.nodes.publicDropBody.eq(0).removeClass("none");
                    }
                })
                //if(show==true){return;}
                //that.nodes.publicDropBody.eq(0).addClass("none");
                //that.nodes.publicDropBody.eq(1).removeClass("none");
                //show=true;
                //return;
            }else{
                that.nodes.publicDropBody.eq(1).addClass("none");
                that.nodes.publicDropBody.eq(0).removeClass("none");
            }

        });
        return that;
    },
    docTake:function(){
        var that=this;
        that.nodes.doc.on("click",function(e){
            if($(e.target).closest(".public-select").length==0){
                that.nodes.publicSelectList.addClass("none");
                that.nodes.publicSelect.find(".down-icon").css({
                    backgroundPosition:"-89px -11px"
                });
            }
        })
        return that;
    },
    searchBaidu:function(){
        var that=this;
        that.map = new BMap.Map("l-map");
        that.geoc = new BMap.Geocoder();
        that.map.centerAndZoom("上海",12);
        var href=$("#public-input2").data('href');
        var ac = new BMap.Autocomplete(    //建立一个自动完成的对象
            {
                "input" : "public-input2"
                 //,"location" : that.map
            });
        that.ac=ac;
        ac.addEventListener("onconfirm", function(e) {    //鼠标点击下拉列表后的事件
            var addr=$("#search-input2").val();
            var root=that.nodes.searchSpace.data("root");
            addr = encodeURI(encodeURI(addr));
            //var url= root+"map2?addr="+addr;
            var item= e.item.value;
            var addr=item.province+item.city+item.district+item.street+item.streetNumber+item.business;
            that.siteLibrary=that.getLocationStorage();
            $(".tangram-suggestion-main").remove();
            that.geoc.getPoint(addr, function(point){
                if(point==null){
                    alert('定位失败,请重新搜索!!');
                    return;
                }
                that.handleUrlAndLocalStorage(point,addr);
            });
        });
        $(".tangram-suggestion-main").addClass('hidden');
        return that;
    },
    ///*搜索字段存储,优先关键字搜索*/
    handleUrlAndLocalStorage:function(point,addr){
        var that=this;
        var href=that.nodes.publicContainer.data('root');
        that.siteLibrary=that.getLocationStorage();
        that.siteLibrary.geo=point;
        that.siteLibrary.addr=addr;
        if(point!=null){
            /*如果关键字坐标存在则改变localstorage的city_select*/
            that.geoc.getLocation(point, function(rs){
                var addComp = rs.addressComponents;
                that.siteLibrary.city_select=addComp.city;
                if(addComp.city.indexOf('市')>-1){
                    that.siteLibrary.city_select=addComp.city.substr(0,addComp.city.indexOf('市'));
                }
                var city_select=(!that.siteLibrary.hasOwnProperty('city_select')||that.siteLibrary.city_select=="")?"":"&city="+that.siteLibrary.city_select;
                var active_type=(!that.siteLibrary.hasOwnProperty('active_type')||that.siteLibrary.active_type=="")?"":"&active_type="+that.siteLibrary.active_type;
                that.setLocationStorage(that.siteLibrary);
                var url=href+"space?"+city_select+active_type+"&lng="+point.lng+"&lat="+point.lat+"&keyword2="+addr;
                window.location.href=url;
            });
        }else{
            var city_select=(!that.siteLibrary.hasOwnProperty('city_select')||that.siteLibrary.city_select=="")?"":"&city="+that.siteLibrary.city_select;
            var active_type=(!that.siteLibrary.hasOwnProperty('active_type')||that.siteLibrary.active_type=="")?"":"&active_type="+that.siteLibrary.active_type;
            that.setLocationStorage(that.siteLibrary);
            var url=href+"space?"+city_select+active_type+"&keyword2="+addr;
            window.location.href=url;
        }
    },
    searchSpace:function(){
        var that=this;
        var geoc = new BMap.Geocoder();
        that.nodes.searchSpace.on("click",function(){
            var $this=$(this),city;
            if($("#public-input2").hasClass('none')){
                city=$("#public-input").val();
            }else{
                city=$("#public-input2").val();
            }
            setTimeout(function(){$(".tangram-suggestion-main").hide();},10);
            var search_type =  that.nodes.publicContainer.find("input[name='search_type']").val();
            switch(search_type){
                case 'site_library':
                    var keyword2 = $('#public-input2').val();
                    var city_new=$(".public-form").find(".city").val();
                    if(city_new!=''){
                        //var city=data.data.city;
                        //var addr=data.data.keyword2;
                        this.siteLibrary=that.getLocationStorage();
                        var suggestion=$(".tangram-suggestion-main:last tr:first>td").text();
                        if(suggestion&&suggestion.indexOf(' ')){
                            suggestion = $(".tangram-suggestion-main:last tr>td").eq(1).text();
                        }
                        if(keyword2){
                            //$('#public-input2').val(suggestion);
                            if(city_new=='不限'){
                                that.siteLibrary=that.getLocationStorage();
                                that.siteLibrary.addr=keyword2;
                                that.setLocationStorage(that.siteLibrary);
                                $(".public-sea").submit();
                            }else{
                                geoc.getPoint(keyword2, function(point){
                                    var lat="",lng="";
                                    that.siteLibrary.addr=keyword2;
                                    if(point!=null){
                                        lat=point.lat;
                                        lng=point.lng;
                                        that.geoc.getLocation(point, function(rs){
                                            var addComp = rs.addressComponents;
                                            that.siteLibrary.city_select=addComp.city;
                                            if(addComp.city.indexOf('市')>-1){
                                                that.siteLibrary.city_select=addComp.city.substr(0,addComp.city.indexOf('市'));
                                            }
                                            $(".pub-lat").val(point.lat);
                                            $(".pub-lng").val(point.lng);
                                            that.siteLibrary.geo={lng:point.lng,lat:point.lat}
                                            that.setLocationStorage(that.siteLibrary);
                                            //setTimeout(function(){$(".tangram-suggestion-main").hide();},10);
                                            $(".public-sea").submit();
                                        })
                                    }else{
                                        that.setLocationStorage(that.siteLibrary);
                                        //setTimeout(function(){$(".tangram-suggestion-main").hide();},10);
                                        $(".public-sea").submit();
                                    }
                                },city_new);
                            }
                        }else{
                            that.siteLibrary=that.getLocationStorage();
                            that.siteLibrary.addr="";
                            that.setLocationStorage(that.siteLibrary);
                            $(".public-sea").submit();
                        }
                    }else{
                        alert('请先选择城市!!');
                    }
                    break;
                default:
                    key_word= that.node.headerBodyInput.find("input.keyword1").val()==""?"":"&keyword2="+that.node.headerBodyInput.find("input.keyword1").val();;
                    window.location.href="http://"+ window.location.host+'/database?action=is_submit&search_type='+search_type+key_word;
            }

        });
        return that;
    },
    keywordBind:function(){
        var local=this.getLocationStorage();
        //var t=setInterval(function(){
        //    $(".tangram-suggestion-main").css('display','none');
        //},1);
        //setTimeout(function(){
        //    clearInterval(t);
        //    $("#suggestId2,#public-input2,#search-input2").val(local.addr);
        //},1000);
        //$("#public-input2").on('focus',function(){
        //    $(this).val(local.addr);
        //});
        var that=this,inputs=["suggestId2","public-input2","search-input2","suggestId"];
        $("#suggestId2,#public-input2,#search-input2,#suggestId").on("keyup",function(e){
            var v1=$(this).val(),$this=$(this);
            inputs.forEach(function(v,k){
                if($this.attr('id')==v){
                    return;
                }
                $("#"+v).val(v1);
            });
            //$("#suggestId2,#public-input2,#search-input2,#suggestId").val(v);
        });
        $("#suggestId2,#public-input2,#search-input2,#suggestId").on("focus",function(e){
            $(this).select();
            if($(e.target).attr('id')=="search-input2"
                ||$(e.target).attr('id')=="suggestId2"
                ||$(e.target).attr('id')=="suggestId"){
                $(".tangram-suggestion-main:last").addClass('hidden');
            }
            if($(e.target).attr('id')=="public-input2"){
                $(".tangram-suggestion-main:first").addClass('hidden');
            }
            //$(this).select();
        });
        $("#suggestId2,#public-input2,#search-input2,#suggestId").on("blur",function(e){
            if($(e.target).attr('id')=="search-input2"
                ||$(e.target).attr('id')=="suggestId2"
                ||$(e.target).attr('id')=="suggestId"){
                $(".tangram-suggestion-main:last").removeClass('hidden');
            }
            if($(e.target).attr('id')=="public-input2"){
                $(".tangram-suggestion-main:first").removeClass('hidden');
            }
        });

        setTimeout(function(){
            var keyword="";
            if($("#search-input2").length>0){
                keyword=$("#search-input2").val();
            }else{
                keyword=that.getLocationStorage().addr;
            }
            //var a=that.getLocationStorage();
            $(".tangram-suggestion-main").removeClass('hidden').css('display','none');
            if(window.location.href.indexOf("space/")>-1){
                $("#suggestId2,#public-input2,#search-input2,#suggestId").val("");
                return;
            }
            //if(keyword==undefined){
            //    return;
            //}
            $("#suggestId2,#public-input2,#search-input2,#suggestId").val(keyword);
        },10);
        return this;
    },
    //初始化本地存储
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
}