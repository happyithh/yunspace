/**
 * Created by pzl on 15/12/18.
 */
var plugin={
    nodes:{},
    init:function(){
        this.nodes={
            win:$(window),
            doc:$(document),
            searchList:$('.search_list'),
            spaceDetails:$('.space-fit-details'),
            publicContainer:$("#public-container"),
            //searchSortJg:$('.search-sort-list .sort-jg'),
            //searchSortZs:$('.search-sort-list .sort-zs'),
            tableTr:$('.space-fit-details table tr'),
            publicSelect:$('.search_label'),
            publicDrop:$('.search-drop'),
            publicInput:$('#search-input'),
            publicInputTwo:$('#search-input2'),
            publicSelectList:$('.public-select-list'),
            searchSpace:$('#search-space-btn'),
            searchRight:$('.search-no-right'),
            btnConfigMore:$('.infrastructure li.btn-config-more'),
            infra:$('.infrastructure'),
            infraLi:$('.infrastructure li'),
            searchLabelList:$(".search_label_list")
        };
        var that=this;
        this.showSearchList()
            //.listSort()
            //.showLookPrice()
            .showPublicDrop()
            .docTake()
            .searchBaidu()
            .searchSpace()
            .searchRightScroll();
        setTimeout(function(){
            $('#search-input2').val($('#search-input2').attr("value"));
        },10)
        setTimeout(function(){
            $('.tangram-suggestion-main').hide();
        },1400);
        this.nodes.publicInputTwo.on('keyup',function(e){
            if (e.keyCode == 13){
                that.nodes.searchSpace.trigger("click");
            }
        })

    },

    ////排序点击效果
    //listSort:function(){
    //    var that=this;
    //    //价格排序
    //    that.nodes.searchSortJg.on('click',function(){
    //        var tsort=$(this).find('.icon-sort');
    //
    //        if(tsort.hasClass('down')){
    //            tsort.removeClass('down');
    //            tsort.addClass('up');
    //        }else if(tsort.hasClass('up')){
    //            tsort.removeClass('up');
    //        }else{
    //            tsort.addClass('down');
    //        }
    //    });
    //
    //    //指数排序
    //    that.nodes.searchSortZs.on('click',function(){
    //        var tsort=$(this).find('.icon-sort');
    //
    //        if(tsort.hasClass('up')){
    //            tsort.removeClass('up');
    //            tsort.addClass('down');
    //        }else if(tsort.hasClass('down')){
    //            tsort.removeClass('down');
    //        }else{
    //            tsort.addClass('up');
    //        }
    //    });
    //
    //    return that;
    //},

    //子空间信息列表展示/隐藏
    showSearchList:function(){
        var that=this;
        //场地配置显示更多
        that.nodes.infra.each(function(){
            var infraLiNum=$(this).find('li').length-1;
            if(infraLiNum>6){
                $(this).find('.config-mask').show();
                $(this).find('.btn-config-more').show();
            }else{
                $(this).find('.btn-config-more').hide();
            }
        });
        that.nodes.btnConfigMore.on('click',function(){
            $(this).siblings('.config-mask').hide();
            $(this).hide();
        });
        //子空间信息列表展示/隐藏
        that.nodes.searchList.hover(function(){
            //$(this).find('.space-fit-details').addClass('itemshow');
            var $this=$(this);
            $this.addClass("search_list_transition");
            $this.find(".space-fit-details").addClass("space-fit-details-transition");
            setTimeout(function(){
                $this.css({
                    border:"1px solid #6b96ef"
                });
                $this.find(".space-fit-details").addClass('itemshow');
            },20);
            //查看档期和价格展示/隐藏
            $(this).find('.space-fit-details').find('tr').on({
                mouseover:function(){
                    $(this).find('.lookprice').show();
                    $(this).find('.lookprice').on('click',function(){
                        $(".cover,.search-box").fadeIn();
                    });
                },
                mouseout:function(){
                    $(this).find('.lookprice').hide();
                }
            });
        },function(){
            $(this).removeClass("search_list_transition").css({
                border:"1px solid #fff"
            });
            $(this).find(".space-fit-details").removeClass("space-fit-details-transition itemshow");
        });

        return that;
    },

    //搜索功能-开始
    showPublicDrop:function(){
        var that=this;
        that.nodes.publicSelect.find("span").on("click",function(){
            that.nodes.publicSelectList.toggleClass("none");
            if(that.nodes.publicSelectList.hasClass("none")){
                that.nodes.publicSelect.find(".down-icon").css({
                    backgroundPosition:"-89px -11px"
                });
            }else{
                that.nodes.publicSelect.find(".down-icon").css({
                    backgroundPosition:"-89px -78px"
                });
            }
        });
        that.nodes.searchLabelList.find("li").each(function(index,dom){
            var $dom=$(dom);
            $dom.on("click",function(){
                var $this=$(this);
                var v=$this.text();
                //that.nodes.publicSelect.find("span").html("<code>"+v+'</code><i class="down-icon"></i>');
                switch (v){
                    //这里的publicInput为search-input
                    case '找场地':
                        that.nodes.publicDrop.find("input[name='search_type']").val('site_library');
                        that.nodes.publicInput.addClass("none");
                        that.nodes.publicInputTwo.removeClass("none");

                        $("#public-input").addClass("none");
                        $("#public-input2").removeClass("none");
                        $(".public-input").find(".select-wrapper").removeClass("none");
                        break;
                    case '找资讯':
                        that.nodes.publicDrop.find("input[name='search_type']").val('project_library');
                        that.nodes.publicInput.removeClass("none");
                        that.nodes.publicInputTwo.addClass("none");

                        $("#public-input").removeClass("none");
                        $("#public-input2").addClass("none");
                        $(".public-input").find(".select-wrapper").addClass("none");
                        break;
                    case '找公司':
                        that.nodes.publicDrop.find("input[name='search_type']").val('company_library');
                        that.nodes.publicInput.removeClass("none");
                        that.nodes.publicInputTwo.addClass("none");

                        $("#public-input").removeClass("none");
                        $("#public-input2").addClass("none");
                        $(".public-input").find(".select-wrapper").addClass("none");
                        break;
                    case '找文库':
                        that.nodes.publicDrop.find("input[name='search_type']").val('paper_library');
                        that.nodes.publicInput.removeClass("none");
                        that.nodes.publicInputTwo.addClass("none");

                        $("#public-input").removeClass("none");
                        $("#public-input2").addClass("none");
                        $(".public-input").find(".select-wrapper").addClass("none");
                        break;
                }
                that.nodes.publicSelectList.addClass("none");
                that.nodes.publicSelect.find(".down-icon").css({
                    backgroundPosition:"-89px -11px"
                });
            })
        });
        that.nodes.publicDrop.hover(function(){},function(){
            that.nodes.publicInput.blur();
        });
        var publicInput=that.nodes.publicInput||that.nodes.publicInputTwo;


        publicInput.on("keyup",function(){

            var $this=$(this);
            var keyword=$this.val();
            var show=false;
            //if(keyword!=""){
            //    YunSpace.api("search/get/library/list.jsonp",{
            //        keyword : keyword
            //    })
            //}

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
        var map = new BMap.Map("l-map");
        var geoc = new BMap.Geocoder();
        map.centerAndZoom("上海",12);
        this.handleCitySelected(map,geoc);
        var href=$("#search-input2").data('href');
        var allWords=$('body').data('all');
        var ac = new BMap.Autocomplete(    //建立一个自动完成的对象
            {
                "input" : "search-input2"
                //,"location" : map
            });
        that.geoc = new BMap.Geocoder();
        var ci=$("input[name='city']").val();
        ac.setLocation(ci);
        ac.addEventListener("onconfirm", function(e) {    //鼠标点击下拉列表后的事件
            //that.siteLibrary=that.getLocationStorage();
            var addr=$("#search-input2").val();
            var root=that.nodes.searchSpace.data("root");
            addr = encodeURI(encodeURI(addr));
            //var url= root+"map2?addr="+addr;
            var item= e.item.value;
            //var city=window.city==""?"":"city="+window.city;
            var city=item.city;
            if(item.city.indexOf('市')>-1){
                city=item.city.slice(0,item.city.indexOf('市'));
            }
            var addr=item.province+item.city+item.district+item.street+item.streetNumber+item.business;
            $(".tangram-suggestion-main").remove();
            geoc.getPoint(addr, function(point){
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
        var category=window.category==""?"":"&category="+window.category;
        var activeType=window.activeType==""?"":"&activeType="+window.activeType;
        var size_range=window.size_range==""?"":"&size_range="+window.size_range;
        var people_range=window.people_range==""?"":"&people_range="+window.people_range;
        var is_outside=window.is_outside==""?"":"&is_outside="+window.is_outside;
        var city_select=(!that.siteLibrary.hasOwnProperty('city_select')||that.siteLibrary.city_select=="")?"":"&city="+that.siteLibrary.city_select;
        var active_type=(!that.siteLibrary.hasOwnProperty('active_type')||that.siteLibrary.active_type=="")?"":"&active_type="+that.siteLibrary.active_type;
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
                //var url=href+"space?"+city_select+"&active_type="+active_type+"&lng="+point.lng+"&lat="+point.lat+"&keyword2="+addr;
                //window.location.href=url;
                var url=href+"space?"+city+category+activeType+size_range+people_range+is_outside+"&lng="+point.lng+"&lat="+point.lat+"&keyword2="+addr;
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
    handleCitySelected:function(map,geoc){
        var addr=$("#search-input2").val();
        var cityArr=[];
        $(".select").first().find("li").each(function(index,dom){
            var $dom=$(dom);
            var c=$dom.find("a").text();
            cityArr.push(c);
        });
        if($(".space_form").find("input[name='city']").val()==""){
            geoc.getPoint(addr, function(point){
                if(point==null){return;}
                geoc.getLocation(point, function(rs){
                    for(var i in cityArr){
                        if(rs.addressComponents.city.indexOf(cityArr[i])>-1){
                            $(".city-more:first").find("a:first>span").text(cityArr[i]);
                            window.city=cityArr[i];
                            $("input[name='city']").val(cityArr[i]);
                            return;
                        }
                    }
                    $(".city-more:first").find("a:first>span").text(rs.addressComponents.city);
                    window.city=rs.addressComponents.city;
                    //cityArr.forEach(function(v,k){
                    //    console.log(rs.addressComponents.city.indexOf(v));
                    //
                    //});
                });
                //window.location.href=url;
            });
        }

    },
    searchSpace:function(){
        var that=this;
        var clicked=false;
        var geoc = new BMap.Geocoder();
        var searchForm=function(){
            var $this=that.nodes.searchSpace,city;
            if($("#search-input2").hasClass('none')){
                city=$("#search-input").val();
                $("#search-input2").remove();
            }else{
                city=$("#search-input2").val();
                $("#search-input").remove();
            }
            //if(city=="")return false;
            var root=$this.data('root');
            var new_action=$this.attr('data-aciton');
            if(new_action=="space"){
                that.siteLibrary=that.getLocationStorage();
                var keyword2 = $('.search_input_body').find("input[name='keyword2']").val();
                 $('.public-drop').find("input[name='city']").val(that.siteLibrary.city_select);
                var city_new = $('.public-drop').find("input[name='city']").val();
                if(city_new!=''){
                    var city="city="+city_new;
                    //$(".public-drop").find("input[name='city']").val(data.data.city_new);
                    setTimeout(function(){
                        clicked=false;
                    },1000);
                    if(keyword2!=""){
                        if(city_new=='不限'){
                            //var city_select=that.node.headerBodyForm.find('.public-select-h:first input').val();
                            that.siteLibrary=that.getLocationStorage();
                            that.siteLibrary.addr=keyword2;
                            that.setLocationStorage(that.siteLibrary);
                            $(".space_form").submit();
                        }else{
                            geoc.getPoint(keyword2, function(point){
                                if(point!=null){
                                    $(".ajax_lat").val(point.lat);
                                    $(".ajax_lng").val(point.lng);
                                    that.siteLibrary.geo={lng:point.lng,lat:point.lat};
                                    geoc.getLocation(point,function(rs){
                                        var addComp = rs.addressComponents;
                                        that.siteLibrary.city_select=addComp.city.substr(0,addComp.city.indexOf('市'));
                                        $('.public-drop').find("input[name='city']").val(that.siteLibrary.city_select);
                                        that.siteLibrary.addr=keyword2;
                                        that.setLocationStorage(that.siteLibrary);
                                        $(".space_form").submit();
                                    })
                                }else{
                                    that.siteLibrary.addr=keyword2;
                                    that.setLocationStorage(that.siteLibrary);
                                    $(".space_form").submit();
                                }
                            },city_new);
                        }
                    }else{
                        that.siteLibrary=that.getLocationStorage();
                        that.siteLibrary.addr="";
                        that.setLocationStorage(that.siteLibrary);
                        $(".space_form").submit();
                    }
                }
            }else{
                var url=root+"database/site?action=is_submit&search_type=site_library&keyword="+city;
                window.open(url);
            }
        };
        that.nodes.searchSpace.on("click",function(){
            if(clicked==true)return;
            clicked=true;
            setTimeout(function(){$(".tangram-suggestion-main").hide();},10);
            searchForm();
            //$(".tangram-suggestion-main:first").find("table tr:first td").trigger('click');
            //var addr=$(".tangram-suggestion-main:first").find("table tr:first td>i").text();
            //if(b==true){
            //    var suggestion=$(".tangram-suggestion-main:first").find("table tr:first td>i").text();
            //    var ad= suggestion.replace(/\s/g,"");
            //    if(ad!=""){
            //        if(confirm("你确定要搜索"+suggestion+"吗?")){
            //            $(".tangram-suggestion-main:first").find("table tr:first td").trigger('click');
            //        }else{
            //            searchForm();
            //        }
            //    }else{
            //        searchForm();
            //    }
            //}else{
            //    searchForm();
            //}
        });
        var b=false;
        $('#search-input2').unbind('keyup').on("keyup",function(e){
            if(e.keyCode==13){
                that.nodes.searchSpace.trigger("click");
                //var addr=$(".tangram-suggestion-main:first").find("table tr:first td>i").text();
                //if(b==true){
                //    var ad= addr.replace(/\s/g,"");
                //    if(ad!="") {
                //        if (confirm("你确定要搜索 " + addr + " 吗?")) {
                //            $(".tangram-suggestion-main:first").find("table tr:first td").trigger('click');
                //        } else {
                //            searchForm();
                //        }
                //    }else{
                //        searchForm();
                //    }
                //}else{
                //    searchForm();
                //}
            }
            //else{
            //    setTimeout(function(){
            //        var dis=$(".tangram-suggestion-main:first").css('display');
            //        if(dis=='block') b=true;
            //        else b=false;
            //    },100);
            //}
        });
        return that;
    },
    //搜索功能-结束
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
    //右侧滚动
    searchRightScroll:function(){
        var that=this, sft;
        if(that.nodes.searchRight.length>0){
            sft =that.nodes.searchRight.offset().top;
        }
        //var winH=that.nodes.win.height();
        //var docH=that.nodes.doc.height();
        if($('#searchleft').offset()){
            //var offsetTop1 = $('#searchleft').offset().top;
            //var bottomOffset = $('.footer-outside').offset().top;
            var docHeight = $(document).height();
            var footerH = $('.footer-outside').height() + $('.bottom-outside').height();
            var sprtH=$('.search-no-right').outerHeight();
            var winH = $(window).height();

            function dealFixed(){
                var st = $(document).scrollTop();
                var sl = $(document).scrollLeft();
                var offsetLeft = $('.search_content_right_no').offset().left;
                var residue = docHeight - st -winH; //剩余的文档高度

                if( sl > 0){
                    offsetLeft -= sl;
                }
                if(st >= (sft-50)){
                    var sprtOffsetTop=$('.search-no-right').offset().top;
                    var sprtBottom=docHeight-sprtH-footerH-sprtOffsetTop;
                    //var sprtFootH=sprtH+footerH;

                    $('.search-no-right').css({
                        'position':'fixed',
                        'left': offsetLeft
                    });
                    if(sprtBottom<=20){
                        $('.search-no-right').css({
                            'bottom':footerH+20-residue,
                            'top':'auto'
                        });
                    }else{
                        $('.search-no-right').css({
                            'top':'45px',
                            'bottom':'auto'
                        });
                    }
                }else{
                    $('.search-no-right').css({
                        'position':'relative',
                        'top':0,
                        'left': 0,
                        'bottom':'auto'
                    });
                }


            }

            window.onscroll = function(){
                dealFixed();
            };
            window.onresize = function(){
                winH = $(window).height();
                dealFixed()
            }
        }



        //window.onscroll = function(){
        //    var st=that.nodes.win.scrollTop();
        //    var ss=docH-winH-st;
        //
        //    if(st>=(sft-50)){
        //        that.nodes.searchRight.addClass('fixed');
        //    }else{
        //        that.nodes.searchRight.removeClass('fixed');
        //    }
        //
        //    if(ss<110){
        //        $('.search-no-right.fixed').css({
        //            top:"auto",
        //            bottom:400-ss
        //        });
        //    }else{
        //        $('.search-no-right.fixed').css({
        //            top:"30px"
        //        });
        //    }
        //
        //}
    }

}