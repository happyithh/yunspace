/**
 * Created by pzl on 16/3/3.
 */
var plugin={
    nodes:{},
    _floorActive:1,
    _winH:"",
    _winW:"",
    _scrollTop:"",
    siteLibrary:{},
    geoc:"",
    ac:"",
    init:function(){
        this.nodes={
            win:$(window),
            doc:$(document),
            footerLi:$(".footer-li"),
            footerActList:$(".footer-act-list"),
            hotSpace:$("#hot-space"),
            sideFix:$("#side-fix"),
            hotBody:$("#hot-body"),
            fixBg:$(".fix-bg"),
            joinBlock:$(".join-block"),
            getRange:$(".get-range"),
            circlesSlider:$("#circles-slider"),
            tabList:$("#tab-list"),
            numPerson:$("#num-person"),
            cateList:$("#cate-list"),
            some:$(".some"),
            searchSpace:$("#search-space"),
            citySelectMap:$("#city-select-map"),
            changeCity:$(".change-city"),
            rentSpace:$("#rent-space"),
            moreCateList:$("#more-cates").parent(),
            cateNav:$("#cate-nav"),
            cateNavList:$("#cate-nav-list"),
            publicContainer:$("#public-container"),
        };
        this._winH=this.nodes.win.height();
        this._scrollTop=this.nodes.win.scrollTop();
        this._winW=this.nodes.win.width();
        var that=this;
        $(window).on("resize",function(){
            that.sidePosition();
            that._winH=that.nodes.win.height();
            that._winW=that.nodes.win.width();
        });
        //that.nodes.hotBody.find(".body:eq(0)").removeClass('none');
        //$("img").lazyload({
        //    effect: "fadeIn",
        //    threshold: 10,
        //});
        $("#suggestId").on('keyup',function(e){
            if(e.keyCode==13){
                that.nodes.searchSpace.trigger("click");
            }
        });
        this.isCityCookie().showFooterList()
            .isShowfix()
            .sidePosition()
            .floorAct()
            .toFloor()
            .swiper()
            .slide()
            .hotTab()
            .backRentSpace()
            .selectRentSpace()
            .changeCity()
            .searchBaidu()
            .searchSpace()
            .showCitySpace()
            .rentSpace()
            .scrollFloorState()
            .showNavList();
    },
    isCityCookie:function(){
        var that=this;
        var cookieArr=document.cookie.split(";");
        var city="";
        for(var k in cookieArr){
            if(cookieArr[k].indexOf('city=')>-1){
                city=cookieArr[k].substring(cookieArr[k].indexOf('=')+1);
            }
        }
        city=decodeURI(city);
        $('.cn').text(city);
        that.nodes.citySelectMap.find("li").each(function(index,dom){
            var $dom=$(dom);
            var c=$dom.find("a").first().text();
            if(c==city){
                that.nodes.citySelectMap.find("li a").removeClass("city-active");
                $dom.find("a").first().addClass("city-active");

            }
        });
        return that;
    },
    showFooterList:function(){
        var that=this;
        that.nodes.footerLi.each(function(index,dom){
            var $dom=$(dom);
            $dom.hover(function(){
                var $this=$(this);
                that.nodes.footerLi.find(".footer-li-header").removeClass('footer-li-header-active');
                $this.find(".footer-li-header").addClass('footer-li-header-active');
                that.nodes.footerActList.addClass("none");
                that.nodes.footerActList.eq(index).removeClass('none');
            },function(){});
        });
        return that;
    },
    sidePosition:function(){
        var that=this;
        that._winW=$(window).width();
        var w=that._winW-that.nodes.hotBody.width();
        that.nodes.fixBg.css({width: (w/2-10)+"px"});
        return that;
    },
    floorAct:function(){
        var that=this;
        var fix=false;
        that.nodes.win.on("scroll",function(){
            that._scrollTop=that.nodes.win.scrollTop();
            that.isShowfix();
        });
        return that;
    },
    isShowfix:function(){
        var that=this;
        var _hotOff=that.nodes.hotBody.offset().top;
        var _getH=that._scrollTop+that._winH-700;
        var joinOffTop=that.nodes.joinBlock.offset().top;
        var h2=that.nodes.joinBlock.outerHeight();
        //that._scrollTop+that._winH<joinOffTop+h2+50 底部范围
        if(_hotOff<=_getH){
            that.nodes.fixBg.removeClass('none');
        }else{
            that.nodes.fixBg.addClass('none');
        }
        return that;
    },
    toFloor:function(){
        var that=this;
        var do_st;
        that.nodes.sideFix.find(".list > li").each(function(index,dom){
            var $dom=$(dom);
            $dom.on("click",function(){
                clearInterval(do_st);
                that.nodes.sideFix.find(".list > li").removeClass("active");
                $dom.addClass("active");
                if($dom.hasClass("mao-active")){
                    var st=that.nodes.joinBlock.offset().top;
                    do_st=setInterval(function(){
                        if(that._scrollTop>=st){clearInterval(do_st);}
                        that._scrollTop=100+that._scrollTop;
                        $(window).scrollTop(that._scrollTop);
                        if(that._scrollTop>=st){clearInterval(do_st);}
                    },1);
                    return false;
                }
                that.nodes.hotBody.find('.body').each(function(k,o){
                    var $o=$(o);
                    if(!$o.hasClass("none")){
                        var st=$o.find(".some:eq("+index+")").offset().top;
                        if(window.addEventListener){
                            if(that._scrollTop>st){
                                //向上滚
                                do_st=setInterval(function(){
                                    if(that._scrollTop<=st-100)return;
                                    that._scrollTop=that._scrollTop-50;
                                    $(window).scrollTop(that._scrollTop);
                                    if(that._scrollTop<=st-100){clearInterval(do_st);}
                                },1);
                            }else{
                                //向下滚
                                do_st=setInterval(function(){
                                    if(that._scrollTop>=st+100)return;
                                    that._scrollTop=50+that._scrollTop;
                                    $(window).scrollTop(that._scrollTop);
                                    if(that._scrollTop>=st-100){clearInterval(do_st);}
                                },1);
                            }
                        }else{
                            $(window).scrollTop(st);
                        }
                    }
                })
            });
        });
        return that;
    },
    swiper:function(){
        $('#bannerBaike').YunSlide({
            delay : 5000,
            nav : '#bannerNav',
            next : '.carousel-control.right',
            prev : '.carousel-control.left',
        });
        return this;
    },
    slide:function(){
        var that=this;
        var hanzi = ["10","100","200","300","400","500+"];
        $("#circles-slider")
            .slider({
                min:0,
                max: 500,
                value: 100,
                step:1,
                animate: true,
                //range: true
            })
            .slider("pips",
            {
                rest: "label",
                step:100,
            })
            .slider("float", {
                labels: hanzi
            })
            .on('slide',function(e,ui){
                var getW=ui.value/500*that.nodes.circlesSlider.width();
                that.nodes.getRange.css({width:getW+"px"});
                var v=ui.value;
                that.nodes.numPerson.text(v);
                $("input[name='price']").val(v);
                if(v<=10){
                    $("input[name='price']").val(10);
                    that.nodes.numPerson.text(10);
                }
            })
            .on("slidestop",function(e,ui){
                var getW=ui.value/500*that.nodes.circlesSlider.width();
                that.nodes.getRange.css({width:getW+"px"});
                var v=ui.value;
                that.nodes.numPerson.text(v);
                $("input[name='price']").val(v);
                if(v<=10){
                    $("input[name='price']").val(10);
                    that.nodes.numPerson.text(10);
                }
            })
        $(".ui-slider-label:last").text("500+");
        $(".ui-slider-label:first").text("10");
        return that;
    },
    hotTab:function(){
        var that=this;
        that.nodes.tabList.find("li").each(function(k,o){
            var $o=$(o);
            $o.on("click",function(){
                that.nodes.tabList.find("li").removeClass("li-active").find("a").removeClass("i-active");
                $o.addClass("li-active").find("a").addClass("i-active");
                //that.nodes.hotBody.find(".body").addClass('none');
                //that.nodes.hotBody.find(".body:eq("+k+")").removeClass("none");
                switch(k){
                    case 0:
                        that.nodes.sideFix.find("li").eq(0).trigger('click');
                        break;
                    case 1:
                        that.nodes.sideFix.find("li").eq(1).trigger('click');
                        break;
                    case 2:
                        that.nodes.sideFix.find("li").eq(2).trigger('click');
                        break;
                    case 3:
                        that.nodes.sideFix.find("li").eq(3).trigger('click');
                        break;
                    case 4:
                        that.nodes.sideFix.find("li").eq(4).trigger('click');
                        break;
                }
            });
        });
        return that;
    },
    /*返回顶部一键租场地*/
    backRentSpace:function(){
        var that=this;
        $(".public-link").find("a").on("click",function(e){
            e.preventDefault();
            var toTop=setInterval(function(){
                that._scrollTop-=100;
                $(window).scrollTop(that._scrollTop);
                if(that._scrollTop<=0){
                    clearInterval(toTop);
                    return false;
                }
            },1);
        });
        return that;
    },
    selectRentSpace:function(){
        var that=this;
        this.nodes.cateList.find("a").on("click",function(){
            var $this=$(this);
            $("input[name='cate']").val($this.text());
            that.nodes.cateList.find("a").removeClass('active');
            $this.addClass("active");
        });
        return that;
    },
    changeCity:function(){
        var that=this;
        that.nodes.some.each(function(k1,s){
            var $s=$(s);
            $s.find(".change-city>li").each(function(k2,o){
                var $o=$(o);
                $o.on("click",function(){
                    switch (k1) {
                        case 0:
                            $s.find(".change-city>li>a").removeClass("active-one");
                            $o.find("a").addClass("active-one");
                            break;
                        case 1:
                            $s.find(".change-city>li>a").removeClass("active-two");
                            $o.find("a").addClass("active-two");
                            break;
                        case 2:
                            $s.find(".change-city>li>a").removeClass("active-three");
                            $o.find("a").addClass("active-three");
                            break;
                        case 3:
                            $s.find(".change-city>li>a").removeClass("active-four");
                            $o.find("a").addClass("active-four");
                            break;
                        case 4:
                            $s.find(".change-city>li>a").removeClass("active-five");
                            $o.find("a").addClass("active-five");
                            break;
                    }
                    //$(o).parents(".some").find(".img").addClass("none");
                    $(o).parents(".some").find(".img:eq("+k2+")").removeClass("none");
                });
            })
        });
        return that;
    },
    /*显示相应的城市图片*/
    showCitySpace:function(){
        var that=this;
        that.nodes.citySelectMap.find("a").each(function(k,o){
          var $o=$(o);
            $o.on("click",function(){
                var $this=$(this);
                var c=$this.text();
                that.siteLibrary=that.getLocationStorage();
                that.siteLibrary.city_select=$(this).text();
                that.setLocationStorage(that.siteLibrary);
                that.ac.setLocation(that.siteLibrary.city_select);
                $("input[name='lib_city']").val(c);
                switch(c){
                    case "上海":
                        that.cityTriggerClick(0);
                        break;
                    case "北京":
                        that.cityTriggerClick(1);
                        break;
                    case "广州":
                        that.cityTriggerClick(2);
                        break;
                    case "深圳":
                        that.cityTriggerClick(3);
                        break;
                    case "成都":
                        that.cityTriggerClick(4);
                        break;
                }
            });
        });
        return that;
    },
    cityTriggerClick:function(key){
        var that=this;
        that.nodes.changeCity.each(function(k,o){
            var $o=$(o);
            $o.find("li").eq(key).trigger("click");
        })
    },
    searchBaidu:function(){
        var that=this;
        that.ac = new BMap.Autocomplete(    //建立一个自动完成的对象
            {
                "input" : "suggestId"
                ,"location" : map
            });
        that.geoc = new BMap.Geocoder();
        that.ac.setLocation($(".cn").text());
        that.ac.addEventListener("onconfirm", function(e) {    //鼠标点击下拉列表后的事件
            //var addr=$("#suggestId").val();
            //var root=that.nodes.searchSpace.data("root");
            //addr = encodeURI(encodeURI(addr));
            //var url= root+"map2?addr="+addr;
            //
            //window.open(url);
            //that.siteLibrary=that.getLocationStorage();
            var addr=$("#suggestId").val();
            var root=that.nodes.searchSpace.data("root");
            addr = encodeURI(encodeURI(addr));
            var item= e.item.value;
            var city=item.city;
            if(item.city.indexOf('市')>-1){
                city=item.city.slice(0,item.city.indexOf('市'));
            }
            var addr=item.province+item.city+item.district+item.street+item.streetNumber+item.business;
            $(".tangram-suggestion-main").remove();
            that.geoc.getPoint(addr, function(point){
                if(point==null){
                    alert('输入的关键字定位失败,请重新输入!!');
                    return;
                }
                that.handleUrlAndLocalStorage(point,addr);
            });

        });
        return that;
    },
    ///*搜索字段存储,优先关键字搜索*/
    handleUrlAndLocalStorage:function(point,addr){
        var that=this;
        var href=that.nodes.publicContainer.data('root');
        that.siteLibrary=that.getLocationStorage();
        var city_select=(!that.siteLibrary.hasOwnProperty('city_select')||that.siteLibrary.city_select=="")?"":"&city="+that.siteLibrary.city_select;
        //var active_type=(!that.siteLibrary.hasOwnProperty('active_type')||that.siteLibrary.active_type=="")?"":"&active_type="+that.siteLibrary.active_type;
        that.siteLibrary.geo=point;
        that.siteLibrary.addr=addr;
        if(point!=null){
            /*如果关键字坐标存在则改变localstorage的city_select*/
            that.geoc.getLocation(point, function(rs){
                var addComp = rs.addressComponents;
                that.siteLibrary.city_select=addComp.city;
                that.siteLibrary.geo=point;
                if(addComp.city.indexOf('市')>-1){
                    that.siteLibrary.city_select=addComp.city.substr(0,addComp.city.indexOf('市'));
                }
                var city="city="+that.siteLibrary.city_select;
                that.setLocationStorage(that.siteLibrary);
                var url=href+"space?"+city+"&lng="+point.lng+"&lat="+point.lat+"&keyword2="+addr;
                window.location.href=url;
            });
        }else{
            alert('输入的关键字定位失败,请重新输入!!');
            //that.setLocationStorage(that.siteLibrary);
            //var url=href+"space?"+city+category+activeType+size_range+people_range+is_outside+"&lng="+point.lng+"&lat="+point.lat+"&keyword2="+addr;
            //window.location.href=url;
        }

    },
    setLocationStorage:function(obj){
        localStorage.setItem('site_library',JSON.stringify(obj));
    },
    getLocationStorage:function(){
        return JSON.parse(localStorage.getItem('site_library'));
    },
    searchSpace:function(){
        var that=this;
        that.nodes.searchSpace.on("click",function(){
            /*var $this=$(this),city=$("#suggestId").val();
            if(city=="")return false;
            var root=$this.data('root');
            var url=root+"database/site?action=is_submit&search_type=site_library&keyword="+city;
            window.open(url);*/
            that.siteLibrary=that.getLocationStorage();
            var addr=$("#suggestId").val();
            //var suggestion=$(".tangram-suggestion-main tr>td:first").text();
            //suggestion= suggestion.replace(/\s/g,"");
            //if(suggestion&&suggestion.indexOf(' ')){
            //    suggestion = $(".tangram-suggestion-main tr>td").eq(1).text();
            //}
            setTimeout(function(){$(".tangram-suggestion-main").hide();},10);
            if(addr){
                that.geoc.getPoint(addr, function(point){
                    if(point!=null){
                        $(".lib_lat").val(point.lat);
                        $(".lib_lng").val(point.lng);
                        that.siteLibrary.geo={lng:point.lng,lat:point.lat};
                        that.geoc.getLocation(point,function(rs){
                            var addComp = rs.addressComponents;
                            that.siteLibrary.city_select=addComp.city.substr(0,addComp.city.indexOf('市'));
                            //$('.lib_form').find("input[name='city']").val(that.siteLibrary.city_select);
                            that.siteLibrary.addr=addr;
                            that.setLocationStorage(that.siteLibrary);
                            //setTimeout(function(){$(".tangram-suggestion-main").hide();},10);
                            $(".lib_form").submit();
                        })
                    }else{
                        //$("#search-input2").val("");
                        $(".lib_form").submit();
                        //alert('输入的关键字定位失败,请重新输入!!')
                    }
                },that.siteLibrary.city_select);
            }else{
                $(".lib_form").submit();
            }


        });
        return that;
    },
    rentSpace:function(){
        var that=this;
        that.nodes.rentSpace.on("click",function(){
            var $this=$(this);
            var people=that.nodes.numPerson.text();
            if(people == 500){
                people="500人以上";
            }
            var activity=$("input[name=cate]").val();
            var root=$this.data('root');
            var url=root+"space_library?action=form&people="+people+"&activity="+activity;
            window.location=url;
        });
        return that;
    },
    scrollFloorState:function(){
        var that=this,someScollHeight=[];
        that.nodes.some.each(function(k,o){
            var $o=$(o);
            var t=$o.offset().top;
            someScollHeight.push(t);
        });
        someScollHeight.push(that.nodes.joinBlock.offset().top);
        that.rangeScroll(someScollHeight,that.nodes.sideFix);
        return that;
    },
    rangeScroll:function(scrollArg,ele){
        var that=this;
        $(window).on("scroll",function(){
            that._scrollTop=$(this).scrollTop();
             that.nodes.some.each(function(k,o){
                var $o=$(o);
                if(that._scrollTop>(scrollArg[k]-100) && that._scrollTop<(scrollArg[k+1]-100)){
                    ele.find("li").removeClass("active");
                    ele.find("li:eq("+k+")").addClass("active");
                }
                 if(that._scrollTop>(scrollArg[k+1]-100)){
                    ele.find("li").removeClass("active");
                }
            });

        })
    },
    showNavList:function(){
        var that=this;
        that.nodes.moreCateList.hover(function(){
            var h=that.nodes.cateNavList.height();
            that.nodes.cateNavList.stop().animate({
                height:"402px"
            },1000,"easeOutQuart");
        },function(){});
        that.nodes.cateNav.hover(function(){},function(){
            that.nodes.cateNavList.stop().animate({
                height:"110px"
            },1000,"easeOutQuart");
        })
        return that;
    },
};
