(function($,win,doc){
    $(function(){
        var $$={
            filterTitle:$(".filter-title"),
            filterPrice:$("#filter-price"),
            filterSort:$("#filter-sort"),
            filterFilter:$("#filterFilter"),
            filterCon:$(".filter-con"),
            cover:$(".cover"),
            filterFixed:$(".filter-fixed"),
            filterContent:$(".filter-content"),
            searchPrice:$('.search_price'),
            searchSort:$('.search_sort'),
            filterArea:$('.filter_area'),
            filterType:$('.filter_type'),
            filterSelected:$(".filter_selected"),
            searchFilterReset:$(".search_filter_reset"),
            searchFilterConfirm:$(".search_filter_confirm"),
            searchPriceBtn:$(".search_price_btn"),
            circle:$(".circle"),
            inquiry:$('.inquiry'),
            inquiryTwo:$('.inquiry-2'),
            spaceIconDefault:$(".space-icon-default"),
            spaceIcon:$(".space-icon"),
            inquirySum:$(".inquiry-sum"),
            searchInput:$(".search_input"),
            searchBody:$("#search-body"),
            searchCancel:$(".search-cancel"),
            searchTop:$(".search_top"),
            btnLocation:$(".btn-location"),
            addressPoint:$(".address-point"),
            locationAddr:$(".location_addr"),
            locationBtn:$(".location_btn"),
            yunLoadTab:$(".yun-load-tab"),
            filterList:$(".filter-list"),
            filterTitleSort:$(".filter-title-sort"),
            location:$(".location"),
            filterTitlePrice:$("#filter-title-price"),
            yunLoading:$(".yun-loading"),
            currentBody:$("#current-body"),
            filterTitleFilter:$("#filter-title_filter")
        };
        var f={
            filterData:{
                priceDuring:"不限",
                price:[0,60000],
                priceText:"",
                area:"",
                size:"",
                type:"",
                typeText:"",
                sort:"综合排序",
                searchText:"",
                priceLook:[],
                priceLookLi:[],
                searchType:0,
                searchResult:"",
                locationPlace:[],
                active_type:"",
                hot:"",
                address:"",
                dp:0,
                lng:"",
                lat:"",
            },
            localFilter:{},
            city_current:"",
            //判断定位是否失败
            defeatLocation:true,
            //判断是否第一次选择,
            filterFirst:true,
            down:false,
            touch:false,
            his:"",
            tempSt:"",
            st:0,
            init:function(){
                f.initPage().showFilter().priceSelect().sortSelect().
                filterSelect().animateCircle().touchDirection().loadSearch().loadMore().showAddedCurrent().toTop().handleScrollStop();
                //f.doLocation(function(){
                //    console.log(22222);
                //    $$.locationAddr.text(f.filterData.address);
                //});
                $(window).on('scroll',function(){
                    f.st=$(window).scrollTop();
                });
                //$$.location.find(".filter_selected_item").on("click",function() {
                //    f.removeSelect(this);
                //});
            },
            initPage:function(){
                var a=f.getLocationStorage();
                if(a==null){
                    f.setLocationStorage(f.localFilter);
                }else{
                    f.localFilter=f.getLocationStorage();
                }

                //console.log(f.localFilter);
                f.handlePageHtmlAndData();
                return f;
            },
            handlePageHtmlAndData:function(){
                var allT="";
                if(f.localFilter!=undefined){
                    if(f.localFilter.priceDuring!=undefined&&f.localFilter.priceDuring!=""){
                        f.filterData.priceDuring=f.localFilter.priceDuring;
                        allT+='<div class="filter_selected_item t1">' +
                            f.localFilter.priceDuring+
                            '&nbsp;&nbsp;<a href="#" class="ion-close-circled filter_selected_deleted" ' +
                            'data-pack="default" data-tags="delete, trash, kill, x">' +
                            '</a>' +
                            '</div>';
                        $$.searchPrice.find('li').each(function(index,dom){
                            var $dom=$(dom);
                            var v1=$dom.text();
                            if(f.filterData.priceDuring==v1){
                                $$.searchPrice.find('li').removeClass('search_price_active');
                                $dom.addClass('search_price_active');
                            }
                        })
                    }
                    if(f.localFilter.price!=undefined&&f.localFilter.price!=""){
                        f.filterData.price=f.localFilter.price;
                        allT+='<div class="filter_selected_item t2">' +
                            f.localFilter.price+
                            '&nbsp;&nbsp;<a href="#" class="ion-close-circled filter_selected_deleted" ' +
                            'data-pack="default" data-tags="delete, trash, kill, x">' +
                            '</a>' +
                            '</div>';
                    }
                    if(f.localFilter.area!=undefined&&f.localFilter.area!=""){
                        f.filterData.area=f.localFilter.area;
                        f.filterData.size=f.localFilter.size;
                        allT+='<div class="filter_selected_item t3">' +
                            f.localFilter.size+
                            '&nbsp;&nbsp;<a href="#" class="ion-close-circled filter_selected_deleted" ' +
                            'data-pack="default" data-tags="delete, trash, kill, x">' +
                            '</a>' +
                            '</div>'
                        $$.filterArea.find("li").each(function(index,dom){
                            var $dom=$(dom);
                            var v1=$dom.text();
                            if(f.filterData.size==v1){
                                $$.filterArea.find('li').removeClass('filter_content_active');
                                $dom.addClass('filter_content_active');
                            }
                        })
                    }
                    if(f.localFilter.type!=undefined&&f.localFilter.type!=""){
                        f.filterData.type=f.localFilter.type;
                        allT+='<div class="filter_selected_item t4">' +
                            f.localFilter.type+
                            '&nbsp;&nbsp;<a href="#" class="ion-close-circled filter_selected_deleted" ' +
                            'data-pack="default" data-tags="delete, trash, kill, x">' +
                            '</a>' +
                            '</div>';
                        $$.filterType.find("li").each(function(index,dom){
                            var $dom=$(dom);
                            var v1=$dom.text();
                            if(f.filterData.type==v1){
                                $$.filterType.find('li').removeClass('filter_content_active');
                                $dom.addClass('filter_content_active');
                            }
                        })
                    }
                    if(f.localFilter.sort!=undefined&&f.localFilter.sort!=""){
                        f.filterData.sort=f.localFilter.sort;
                        $$.searchSort.find("li").each(function(index,dom){
                            var $dom=$(dom);
                            var txt=$dom.find("span:first").text();
                            if(txt==f.filterData.sort){
                                $$.searchSort.find("li >span:eq(1)").addClass('none');
                                $$.searchSort.find("li").removeClass('search_sort_active');
                                $dom.find("span:last").removeClass('none');
                                $dom.addClass("search_sort_active");
                                $$.filterTitleSort.find('span:first').text(txt);
                            }
                        })
                    }
                    $$.location.append(allT);
                    if(f.localFilter.address!=""){
                        f.filterData.searchText=f.localFilter.address;
                        f.filterData.searchType=f.localFilter.searchType;
                        f.filterData.lng=f.localFilter.lng;
                        f.filterData.lat=f.localFilter.lat;
                        f.filterData.active_type="";
                        $$.searchInput.text(f.localFilter.address)
                    }else{
                        f.filterData.active_type=f.localFilter.active_type;
                        f.filterData.searchText="";
                        f.filterData.searchType="";
                        $$.searchInput.text(f.localFilter.active_type)
                    }
                    f.filterFirst=true;
                    f.handleFilterData(function(){
                        f.filterData.dp++;
                    });
                }
                $$.locationBtn.on("click",function(){
                    f.doLocation(function(){
                        $$.searchBody.find(".address-point").text(f.filterData.address);
                        $$.searchBody.find(".btn-location").addClass('fr').removeClass("fl");
                        $$.searchInput.text(f.filterData.address);
                        $$.locationAddr.text(f.filterData.address);
                        f.filterData.searchText=f.filterData.address;
                        f.localFilter.address=f.filterData.address;
                        f.localFilter.searchType="2";
                        f.setLocationStorage(f.localFilter);
                        f.filterFirst=true;
                        f.handleFilterData(function(){
                            $$.searchBody.find('.search-cancel').trigger('click');
                            f.filterData.dp++;
                        });
                    });
                });
            },
            showFilter:function(){
                $$.filterTitle.find('li').each(function(index,dom){
                    var $dom=$(dom);
                    $dom.on('click',function(){
                        $$.filterTitle.find('li').removeClass('filter-title-active').find('span').removeClass('ion-android-arrow-dropup filter-title-active');
                        $(this).addClass('filter-title-active');
                        $(this).find('span:last').addClass('ion-android-arrow-dropup filter-title-active');
                        $$.filterCon.removeClass("filter-con-transition filter-con-active");
                        $$.filterCon.eq(index).addClass("filter-con-transition filter-con-active");
                        $$.cover.removeClass('none');
                    });
                });
                $$.cover.on('click',function(){
                    if($$.filterTitleFilter.hasClass("filter-title-active")){
                        $$.searchFilterConfirm.trigger("click");
                    }
                    if($$.filterTitlePrice.hasClass("filter-title-active")){
                        $$.searchPriceBtn.trigger("click");
                    }
                    $$.filterCon.removeClass("filter-con-transition filter-con-active");
                    $$.cover.addClass('none');
                    $$.filterTitle.find('li').removeClass('filter-title-active');
                    $$.filterTitle.find('li').find('span:last').removeClass('ion-android-arrow-dropup filter-title-active');
                })
                return f;
            },
            /*
            处理高度增加之后的list列表样式
            * */
            handleListStyle:function(){
                var locationH=$$.location.outerHeight(),
                    searchTopH=$$.searchTop.outerHeight(),
                    filterTitleH=$$.filterTitle.outerHeight();
                //console.log(locationH+searchTopH+filterTitleH);
                if($$.location.hasClass("none")){
                    $$.filterContent.css({
                        marginTop:searchTopH+filterTitleH+"px"
                    });
                }else{
                    $$.filterContent.css({
                        marginTop:locationH+searchTopH+filterTitleH+"px"
                    });
                }

                return f;
            },
            priceSelect:function(){
                $$.searchPrice.find('li').each(function(index,dom){
                    var $dom=$(dom);
                    $dom.on('click',function(){
                        $$.searchPrice.find('li').removeClass("search_price_active");
                        $(this).addClass('search_price_active');
                        f.filterData.priceDuring=$(this).text();
                        if(f.filterData.priceDuring!="不限"){
                            var htm='<div class="filter_selected_item t1">'+
                                f.filterData.priceDuring+'&nbsp;&nbsp;' +
                                '<a href="#" class="ion-close-circled filter_selected_deleted" data-pack="default" data-tags="delete, trash, kill, x"></a>'+
                                '</div> ' ;
                            $$.location.find('.t1').remove();
                            $$.location.append(htm);
                            f.handleShowSelected(true);
                            f.handleListStyle();
                        }else{
                            f.filterData.priceDuring=null;
                            $$.location.find(".t1").remove();
                            if($$.location.children().length==0){
                                f.handleShowSelected(false);
                            }
                        }
                        $$.location.find(".t1").unbind('click').on("click",function() {
                            f.removeSelect(this);
                        });
                        //$('div .filter_price_content').eq(index).removeClass('none').siblings().addClass('none');
                    });

                });
                f.selectPrice();
                var touched=false;
                $$.searchPriceBtn.on("click",function(){
                    /*TODO::AJAX价格筛选
                     * 参数
                     * f.filterData.priceDuring
                     * f.filterData.price
                     * */
                    if(touched==true)return;
                    touched=true;
                    f.localFilter.priceDuring= f.filterData.priceDuring;
                    f.localFilter.priceText=f.filterData.priceText;
                    f.localFilter.price=f.filterData.price;
                    //if(f.filterData.price[1]<60000){
                    //    f.localFilter.price=f.filterData.price.join("-")+"元";
                    //    if(f.filterData.price[0]==0){
                    //        f.localFilter.price=f.filterData.price[1]+"元以下";
                    //    }
                    //}else if(f.filterData.price[1]=='不限'&&f.filterData.price[0]!=0){
                    //    f.localFilter.price=f.filterData.price[0]+"元以上";
                    //}else{
                    //    //$$.location.find('.t2').remove();
                    //    //f.filterData.price[1]=0;
                    //    //if($$.location.children().length==0){
                    //    //    f.handleShowSelected(false)
                    //    //}
                    //    //f.handleShowSelected(false);
                    //}
                    f.setLocationStorage(f.localFilter);
                    f.filterFirst=true;
                    f.handleFilterData(function(){
                        touched=false;
                        f.filterData.dp++;
                    });
                 });
                return f;
            },
            selectPrice:function(){
                var connectSlider = document.getElementById('slider');
                noUiSlider.create(connectSlider, {
                    start: [0,60000],
                    connect: false,
                    step:5000,
                    cancelable:true,
                    range: {
                        'min': 0,
                        'max': 60000
                    },
                    pips: {
                        mode: 'values',
                        values: [0,10000,20000,30000,40000,50000,60000],
                        density: 10
                    }
                });
                var connectBar = document.createElement('div'),
                    connectBase = connectSlider.querySelector('.noUi-base');

                // Give the bar a class for styling and add it to the slider.
                connectBar.className += 'connect';
                connectBase.appendChild(connectBar);

                connectSlider.noUiSlider.on('update', function( values, handle, a, b, handlePositions ) {
                    //console.log(values, handle, a, b, handlePositions);
                    f.filterData.price=values;
                    for(var k in f.filterData.price){
                        if(parseInt(f.filterData.price[k])==60000){
                            f.filterData.price[k]="不限";
                            continue;
                        }
                        f.filterData.price[k]=parseInt(f.filterData.price[k]);
                    }
                    var priceStr;
                    //f.filterData.priceDuring=$(this).text();
                    //console.log(f.filterData.price);
                    if(f.filterData.price[1]<60000){
                        priceStr=f.filterData.price.join("-")+"元";
                        if(f.filterData.price[0]==0){
                            priceStr=f.filterData.price[1]+"元以下";
                        }
                        f.filterData.priceText=priceStr;
                        //ion-compose修改icon
                        var htm='<div class="filter_selected_item t2">'+
                            priceStr+'&nbsp;&nbsp;' +
                            '<a href="#" class="ion-close-circled filter_selected_deleted" data-pack="default" data-tags="delete, trash, kill, x"></a>'+
                            '</div> ' ;
                        $$.location.find('.t2').remove();
                        $$.location.append(htm);
                        f.handleShowSelected(true);
                    }else if(f.filterData.price[1]=='不限'&&f.filterData.price[0]!=0){
                        f.filterData.price[1]=0;
                        priceStr=f.filterData.price[0]+"元以上";
                        f.filterData.priceText=priceStr;
                        var htm='<div class="filter_selected_item t2">'+
                            priceStr+'&nbsp;&nbsp;' +
                            '<a href="#" class="ion-close-circled  filter_selected_deleted" data-pack="default" data-tags="delete, trash, kill, x"></a>'+
                            '</div> ' ;
                        $$.location.find('.t2').remove();
                        $$.location.append(htm);
                        f.handleShowSelected(true);
                    }else{
                        //priceStr="不限";
                        //var htm='<div class="filter_selected_item t2">'+
                        //    priceStr+'&nbsp;&nbsp;' +
                        //    '<a href="#" class="ion-compose filter_selected_deleted" data-pack="default" data-tags="delete, trash, kill, x"></a>'+
                        //    '</div> ' ;
                        //$$.location.find('.t2').remove();
                        //$$.location.append(htm);
                        $$.location.find('.t2').remove();
                        f.filterData.price[1]=0;
                        //f.filterData.priceDuring="不限";
                        //if($$.location.children().length==0){
                        //    $$.location.addClass('none');
                        //}
                        if($$.location.children().length==0){
                            f.handleShowSelected(false)
                        }
                        //f.handleShowSelected(false);
                    }
                    f.handleListStyle();
                    $$.location.find(".t2").unbind('click').on("click",function() {
                        f.removeSelect(this);
                        connectSlider.noUiSlider.set([0, 60000]);
                    });
                    var offset = handlePositions[handle];
                    // Right offset is 100% - left offset
                    if ( handle === 1 ) {
                        offset = 100 - offset;
                    }
                    // Pick left for the first handle, right for the second.
                    connectBar.style[handle ? 'right' : 'left'] = offset + '%';
                });
                if(f.localFilter.price!=undefined){
                    connectSlider.noUiSlider.set([f.localFilter.price[0], f.localFilter.price[1]]);
                }

                $(".noUi-value").each(function(index,dom){
                    switch(index) {
                        case 1:
                            $(dom).text('1万');
                            break;
                        case 2:
                            $(dom).text('2万');
                            break;
                        case 3:
                            $(dom).text('3万');
                            break;
                        case 4:
                            $(dom).text('4万');
                            break;
                        case 5:
                            $(dom).text('5万');
                            break;
                        case 6:
                            $(dom).text('不限');
                            break;
                    }
                })
            },
            sortSelect:function(){
                $$.searchSort.find('li').each(function(index,dom){
                    var $dom=$(dom);
                    $dom.on("click",function(){
                        $$.searchSort.find('li').removeClass("search_sort_active");
                        $$.searchSort.find('li .search_sort_selected').addClass('none');
                        $(this).addClass("search_sort_active").find('.search_sort_selected').removeClass('none');
                        f.filterData.sort=$(this).find('span').eq(0).text();
                        f.localFilter.sort=f.filterData.sort;
                        f.setLocationStorage(f.localFilter);
                        /*TODO::ajax请求排序
                        * 参数
                        * f.filterData.sort
                        * */
                        f.filterFirst=true;
                        f.handleFilterData(function(){
                            $$.filterTitleSort.find('span:first').text(f.filterData.sort);
                            f.filterData.dp++;
                        });
                     });
                });
                return f;
            },
            filterSelect:function(){
                $$.filterArea.find("li").each(function(index,dom){
                    var $dom=$(dom);
                    $dom.on('click',function(){
                        $$.filterArea.find("li").removeClass('filter_content_active');
                        $(this).addClass('filter_content_active');
                        f.filterData.area=$(this).data('size');
                        f.filterData.size=$(this).text();
                        var v=$(this).text();
                        if(v!="不限"){
                            var htm='<div class="filter_selected_item t3">'+
                                $(this).text()+'&nbsp;&nbsp;' +
                                '<a href="#" class="ion-close-circled filter_selected_deleted" data-pack="default" data-tags="delete, trash, kill, x"></a>'+
                                '</div> ' ;
                            $$.location.find('.t3').remove();
                            //$$.filterSelected.find('.vertical').remove();
                            $$.location.append(htm);
                            f.handleShowSelected(true);
                            f.handleListStyle();
                            $$.location.find(".t3").unbind('click').on("click",function() {
                                f.removeSelect(this);
                                f.handleListStyle();
                            });
                        }else{
                            f.filterData.area="";
                            $$.location.find(".t3").remove();
                            if($$.location.children().length==0){
                                f.handleShowSelected(false)
                            }
                        }
                    })
                });
                $$.filterType.find("li").each(function(index,dom){
                    var $dom=$(dom);
                    $dom.on('click',function(){
                        $$.filterType.find("li").removeClass('filter_content_active');
                        $(this).addClass('filter_content_active');
                        f.filterData.type=$(this).data('category');
                        f.filterData.typeText=$(this).text();
                        var v=$(this).text();
                        if(v!='不限'){
                            var htm='<div class="filter_selected_item t4">'+
                                $(this).text()+'&nbsp;&nbsp;' +
                                '<a href="#" class="ion-close-circled filter_selected_deleted" data-pack="default" data-tags="delete, trash, kill, x"></a>'+
                                '</div>';
                            $$.location.find('.t4').remove();
                            $$.location.append(htm);
                            f.handleShowSelected(true);
                            f.handleListStyle();
                            $$.location.find(".t4").unbind('click').on("click",function() {
                                f.removeSelect(this);
                                f.handleListStyle();
                            })
                            //$$.searchFilterReset.on("click",function(){
                            //    f.removeSelect(this);
                            //    f.handleListStyle();
                            //});
                        }else{
                            f.filterData.type="";
                            $$.location.find(".t4").remove();
                            if($$.location.children().length==0){
                                f.handleShowSelected(false)
                            }
                        }

                    })
                });
                f.removeSelect();
                var touched=false;
                $$.searchFilterReset.on("click",function(){
                    f.filterData.area="";
                    f.filterData.type="";
                    f.removeSelect(this);
                    f.handleListStyle();
                });
                $$.searchFilterConfirm.unbind('click').on("click",function(){
                    /*TODO::ajax请求筛选
                    * 参数
                    * f.filterData.type;   类型
                    * f.filterData.area;   面积
                    * */
                    if(touched==true)return;
                    touched=true;
                    f.localFilter.area=f.filterData.area;
                    f.localFilter.size=f.filterData.size;
                    f.localFilter.type=f.filterData.typeText;
                    f.setLocationStorage(f.localFilter);
                    f.filterFirst=true;
                    f.handleFilterData(function(){
                        touched=false;
                        f.filterData.dp++;
                    });
                 });
                return f;
            },
            /*删除要选择的*/
            removeSelect:function(o){
                //$(".vertical").remove();
                if($(o).hasClass("t1")){
                    $(o).remove();
                    f.filterData.priceDuring=null;
                    f.filterFirst=true;
                    if($(o).html().indexOf('不限')==-1){
                        $$.searchPrice.find('li').removeClass("search_price_active");
                        $$.searchPrice.find('li').eq(0).addClass("search_price_active");
                    }
                    f.handleFilterData(function(){
                        f.filterData.dp++;
                    });
                }
                if($(o).hasClass("t2")){
                    //$$.filterTitlePrice.trigger('click');
                    $(o).remove();
                    f.filterData.price=[0,0];
                    f.filterFirst=true;
                    f.handleFilterData(function(){
                        f.filterData.dp++;
                    });
                }
                //if($(o).hasClass("t2")){
                //    $(o).remove();
                //    //$$.searchPrice.find("li").removeClass('search_price_active');
                //    f.filterData.price=[];
                //}
                if($(o).hasClass("t3")){
                    $(o).remove();
                    $$.filterArea.find("li").removeClass('filter_content_active');
                    f.filterData.area="";
                    f.filterFirst=true;
                    f.handleFilterData(function(){
                        f.filterData.dp++;
                    });
                }
                if($(o).hasClass("t4")){
                    $(o).remove();
                    $$.filterType.find("li").removeClass('filter_content_active');
                    f.filterData.type="";
                    f.filterFirst=true;
                    f.handleFilterData(function(){
                        f.filterData.dp++;
                    });
                }
                if($(o).hasClass("search_filter_reset")){
                    $$.filterArea.find("li").removeClass('filter_content_active');
                    $$.filterType.find("li").removeClass('filter_content_active');
                    $$.location.find(".t3,.t4").remove();
                    f.filterData.type="";
                    f.filterData.area="";
                    //$$.filterSelected.children().remove();
                }
                if($$.location.children().length==0){
                    $$.location.addClass('none');
                }
                f.handleListStyle();
            },
            /*
            * 处理已选择的显示
            * */
            handleShowSelected:function(show){
                if(show==true){
                    $$.location.removeClass("none");
                }else{
                    $$.location.addClass("none");
                }
            },
            /*
            * 添加档期查询,小球运动
            * */
            animateCircle:function(){
                $$.filterList.find('.space-icon').on("click",function(e){
                    var $this=$(this);
                    var id=$this.data('id');
                    var price=$this.data('price');
                    var baike_id=$this.data('baike_id');
                    if(f.filterData.priceLook.indexOf(id)>-1)return;
                    if($this.data("add")==true){
                        return;
                    }
                    $this.attr("data-add",true);
                    if($this.hasClass("space-icon-default")){
                        var ww=$(window).height();
                        $$.circle.css({
                            bottom: (ww-e.clientY)+"px"
                        }).removeClass('none');
                        if($$.inquiry.hasClass('none')){
                            $$.inquiryTwo.addClass('none');
                            $$.inquiry.removeClass('none');
                        }
                        setTimeout(function(){
                            var priceLookData={id:id,price:price,baike_id:baike_id};
                            $this.addClass("space-icon-active").removeClass("space-icon-default");
                            $$.circle.addClass("circle-active");
                            setTimeout(function(){
                                f.filterData.priceLook.push(priceLookData);
                                $$.inquirySum.text(f.filterData.priceLook.length);
                                $$.inquirySum.removeClass('none');
                                var htm=$this.parent().prop('outerHTML');
                                f.filterData.priceLookLi.push(htm);
                                //console.log(f.filterData.priceLookLi,112);
                                $$.circle.removeClass("circle-active").addClass('none');
                            },500);
                        },10);
                    }
                    //else{
                        //$$.inquirySum.text(parseInt($$.inquirySum.text())-1);
                        //$this.removeClass("space-icon-active").addClass("space-icon-default");
                        //remove(f.filterData.priceLook,id);
                        //console.log(f.filterData.priceLook);
                    //}
                });
                $$.inquiry.on('click',function(){
                    /*TODO::AJAX请求底部
                    * 批量查询参数
                    * f.filterData.priceLook
                    * */
                });
                return f;
            },
            /*
            * 判断滑动方向
            * */
            touchDirection:function(){
                var y1,y2,y3;
                $(window).on("scroll",function(){
                    var st=$(window).scrollTop();
                    if(st<=50){
                        $$.filterFixed.removeClass('none');
                    }else{
                        document.getElementById('filter-content').addEventListener('touchstart', function (e) {
                            y1 = e.targetTouches[0].pageY;
                        });
                        document.getElementById('filter-content').addEventListener('touchmove', function (e) {
                            y3 = e.targetTouches[0].pageY;
                            //handleFilterFixed(y3);
                        });
                        document.getElementById('filter-content').addEventListener('touchend', function (e) {
                            y2 = e.changedTouches[0].pageY;
                            handleFilterFixed(y2);
                        });
                    }
                });
                function handleFilterFixed(y){
                    if(y-5>y1){
                        $$.filterFixed.removeClass('none');
                    }
                    if(y1-5>y){
                        $$.filterFixed.addClass('none');
                    }
                    //var locationH=$$.location.outerHeight(),
                    //    searchTopH=$$.searchTop.outerHeight(),
                    //    filterTitleH=$$.filterTitle.outerHeight(),
                    //    st=$(window).scrollTop();
                    //if(locationH+searchTopH+filterTitleH>st){
                    //    $$.filterFixed.removeClass('none');
                    //}
                }
                return f;
            },
            /*
            * 后加载搜索页面
            * */
            loadSearch:function(){
                var loaded=false;
                var url=$$.searchInput.data('src');
                //$$.locationBtn.on('touchend',function(){
                //    $$.searchInput.trigger('touchend');
                //});
                $$.searchInput.on("click",function(e){
                    document.body.style.overflow='hidden';
                    if(loaded==true){
                        f.doSearch(e);
                        return;
                    }
                    var e=e;
                    $.ajax({
                        type: "post",
                        url: url,
                        dataType: "html",
                        success: function (htm) {
                            $$.searchBody.append(htm);
                            f.doSearch(e);
                            loaded=true;
                        }
                    });
                });
                return f;
            },
            /*
            * search显示后执行
            * */
            doSearch:function(e){
                $$.searchBody.addClass("search-body-active");
                //$$.filterFixed.addClass("filter-fixed-hidden");
                //$$.filterContent.addClass("filter-content-hidden");
                //$$.searchTop.addClass("search_top_hidden");
                //$$.inquiry.addClass("inquiry-hidden");
                f.tempSt=f.st;
                $(window).scrollTop(0);
                $("#suggestId").focus();
                $$.searchBody.find(".search-cancel").on('click',function(){
                    document.body.style.overflow='auto';
                    $$.searchBody.removeClass("search-body-active");
                    $(window).scrollTop(f.tempSt);
                    $$.searchBody.find(".search-text-fill").trigger("blur");
                });
                //$$.searchBody.find(".search-text-fill").on('focus',function(){
                //    $$.filterContent.css({
                //        display:'none'
                //    })
                //});
                //$$.searchBody.find(".search-text-fill").on('blur',function(){
                //    $$.filterContent.css({
                //        display:'block'
                //    })
                //});
                f.showHistory(e);
                $$.searchBody.find(".btn-location").on("click",function(){
                    f.doLocation(function(){
                        $$.searchBody.find(".address-point").text(f.filterData.address);
                        $$.searchBody.find(".btn-location").addClass('fr').removeClass("fl");
                        $$.searchInput.text(f.filterData.address);
                        $$.locationAddr.text(f.filterData.address);
                        f.localFilter.address=f.filterData.address;
                        f.localFilter.searchType="2";
                        f.setLocationStorage(f.localFilter);
                        f.filterFirst=true;
                        f.handleFilterData(function(){
                            $$.searchBody.find('.search-cancel').trigger('click');
                            f.filterData.dp++;
                        });
                    });
                });
                f.loadingMore()
                .searchTool()
                .clearRecord()
                .searchBaidu()
                .searchClickSearch();
            },
            searchClickSearch:function(){
                $$.searchBody.find(".cont >li").each(function(index,dom){
                    var $dom=$(dom);
                    var doAjax=false;
                    if(!$dom.hasClass('more')){
                        $dom.unbind('click').on('click',function(){
                            if(doAjax==true)return;
                            doAjax=true;
                            if($dom.parent().hasClass("cont-use")){
                                f.filterData.active_type=$dom.data("active");
                                $$.searchInput.text(f.filterData.active_type);
                            }
                            if($dom.parent().hasClass("cont-hot")){
                                f.filterData.active_type=$dom.data("active");
                                $$.searchInput.text(f.filterData.active_type);
                            }
                            f.localFilter.active_type=f.filterData.active_type;
                            f.localFilter.address="";
                            f.localFilter.searchType="";
                            f.setLocationStorage(f.localFilter);
                            f.filterFirst=true;
                            f.handleFilterData(function(){
                                $$.searchBody.removeClass('search-body-active');
                                f.filterData.dp++;
                                //$$.searchBody.find('.search-cancel').trigger('touchend');
                            });
                        });
                    }
                });
            },
            /*
            * 定位
            * */
            doLocation:function(fn){
                var map = new BMap.Map("allmap");
                var geolocation = new BMap.Geolocation();
                //console.log($$.yunLoadTab);
                $$.yunLoadTab.removeClass("none");
                setTimeout(function(){
                    // 百度地图API功能
                    geolocation.getCurrentPosition(function(r){
                        if(this.getStatus() == BMAP_STATUS_SUCCESS){
                            f.city_current= r.address.city;
                            var mk = new BMap.Marker(r.point);
                            var geoc = new BMap.Geocoder();
                            map.addOverlay(mk);
                            map.panTo(r.point);
                            //alert('您的位置：'+r.point.lng+','+r.point.lat);
                            f.filterData.lng=r.point.lng;
                            f.filterData.lat=r.point.lat;
                            var pt = r.point;
                            geoc.getLocation(pt, function(rs){
                                var addComp = rs.addressComponents;
                                f.filterData.address=addComp.city +addComp.district+ addComp.street + addComp.streetNumber;
                                //alert(f.filterData.address);
                                $$.yunLoadTab.addClass("none");
                                if(fn instanceof Function){
                                    fn();
                                }
                            });
                        }
                        else {
                            alert('failed:'+this.getStatus());
                        }
                    },{
                        enableHighAccuracy: true
                    })
                },2000);
            },
            //击加载更多
            loadingMore:function(){
                $$.searchBody.find('ul.cont-use li.more').on('click',function(){
                    $$.searchBody.find('ul.cont-use').css('height','auto');
                    $(this).hide();
                });
                return f;
            },
            //清空历史记录
            clearRecord:function(){
                $$.searchBody.find('.js-record-clear').on('click',function(){
                    $$.searchBody.find('.cont-record .record').remove();
                    localStorage.setItem('history',"");
                    f.his="";
                    $$.searchBody.find('.no-history ').removeClass('none');
                });
                return f;
            },

            //搜索框
            searchTool:function(){
                //搜索时的下拉列表显示/隐藏
                //var searchShowHide = {
                //    searchShow:function(){
                //    },
                //    searchHide:function(){
                //        $$.searchBody.find('.search-cont-wrapper').removeClass('hidden');
                //        $$.searchBody.find('.search_list').addClass('hidden');
                //    }
                //};
                $$.searchBody.find('.search-text-fill').on('keyup',function(){
                    if($$.searchBody.find('.search-text-fill').val()==''){
                        $$.searchBody.find('.search-cont-wrapper').removeClass('hidden');
                        $$.searchBody.find('.search_list').addClass('hidden');
                        return;
                    }
                    f.filterData.searchResult=$$.searchBody.find('.search-text-fill').val();
                    $$.searchBody.find('.search-cont-wrapper').addClass('hidden');
                    $$.searchBody.find('.search_list').removeClass('hidden');
                    $('#index-cross').show();
                    $('#index-cross').on('click',function(){
                        $$.searchBody.find('.search-text-fill').val('');
                        $(this).hide();
                        $$.searchBody.find('.search-cont-wrapper').removeClass('hidden');
                        $$.searchBody.find('.search_list').addClass('hidden');
                    });
                    /*
                     * TODO::AJAX搜索列表
                     * 参数
                     * f.filterData.searchText
                     * */
                    //$.ajax({
                    //    type: "post",
                    //    url: 'http://map.baidu.com/su?wd=上海&callback=BMap._rd._cbk13278&cid=131&type=0&t=1468208972396',
                    //    dataType: "json",
                    //    success: function (data) {
                    //       console.log(data);
                    //    }
                    //});
                });
                return f;
            },
            showHistory:function(e){
                f.his=localStorage.getItem('history');
                if(f.his==undefined||f.his==""){
                    $$.searchBody.find('.no-history ').removeClass('none');
                    return;
                }
                $$.searchBody.find('.record').remove();
                var his= f.his.split(",,");
                var htmAll="";
                his.forEach(function(v,k){
                    //console.log(v);
                    var v1=JSON.parse(v);
                    var htm='<a class="record" href="javascript:;" data-type="'+v1.searchType+'">'+ v1.text+'</a>';
                    htmAll+=htm;
                });
                $$.searchBody.find('.cont-record').append(htmAll);
                $$.searchBody.find('.record').each(function(index,dom){
                    var $dom=$(dom);
                    $dom.on('click',function(){
                        f.filterData.searchText=$(this).text();
                        $$.searchInput.text(f.filterData.searchText);
                        //f.filterData.
                        f.localFilter.address= f.filterData.searchText;
                        f.localFilter.searchType= 2;
                        f.setLocationStorage(f.localFilter);
                        f.filterFirst=true;
                        f.handleFilterData(function(){
                            $$.searchBody.find('.search-cancel').trigger('click');
                            f.filterData.dp++;
                        });
                    });
                })
                if($(e.target).hasClass("res")){
                    $$.searchBody.find('.no-history').addClass('none');
                    $$.searchBody.find('.search_list').addClass('hidden');
                    $$.searchBody.find('.search-cont-wrapper').removeClass('hidden');
                    //setTimeout(function(){
                    //    $$.searchBody.find('.search-cancel').trigger('touchend');
                    //},1000);
                    //console.log(e.target);
                    $$.searchBody.removeClass("search-body-active");
                }

            },
            getHistoryLocal:function(){
                f.his=localStorage.getItem('history');
                if(f.his==undefined||f.his==""){
                    return;
                }
            },
            setHistoryLocal:function(text,fn){
                f.his=localStorage.getItem('history');
                if(f.his==undefined||f.his==""|| f.his==null){
                    localStorage.setItem('history',text);
                    if(fn instanceof Function){
                        fn();
                    }
                    return;
                }

                var his=[];
                if(f.his.indexOf(",,")>-1){
                    if(f.his.indexOf(text)>-1){
                        if(fn instanceof Function){
                            fn();
                        }
                        return;
                    }
                    his=f.his.split(",,");
                    his.push(text);
                    f.his=his.join(",,");
                    localStorage.setItem('history',f.his);
                //   存储未处理
                }else{
                    if(text==f.his){
                        //console.log(f.his,"pp2");
                        if(fn instanceof Function){
                            fn();
                        }
                        return;
                    }
                    his.push(f.his);
                    his.push(text);
                    f.his=his.join(",,");
                    localStorage.setItem('history',f.his);
                }
                if(fn instanceof Function){
                    fn();
                }

            },
            /*
            * list筛选
            * ajax请求
            * */
            handleFilterData:function(fn){
                //console.log(f.filterData.sort);
                if(f.filterFirst){
                    f.filterData.dp=1;
                }
                if(!f.filterFirst&&f.filterData.dp==0){
                    f.filterData.dp=2;
                }
                //$$.inquiryTwo.removeClass('none');
                //console.log(f.filterData);
                YunSpace.api('search/mobile/get/item/list.jsonp',{
                    size_range: f.filterData.area,
                    category: f.filterData.type,
                    price_unit: f.filterData.priceDuring,
                    price: f.filterData.price,
                    rank: f.filterData.sort,
                    keyword: f.filterData.searchText,
                    type:f.filterData.searchType,
                    active_type:f.filterData.active_type,
                    hot:f.filterData.hot,
                    dp:f.filterData.dp,
                    geo_lat: f.filterData.lat,
                    geo_lng: f.filterData.lng,
                    priceLook:f.filterData.priceLook
                }, function (data) {
                    if(data==null){
                        if(f.filterFirst==true){
                            var nospace=$("#no-space").attr('src');
                            var htm='<div class="search-nospace">' +
                                ' <div class="nospace-img">' +
                                '<img src="'+nospace+'">' +
                                '</div> ' +
                                '<div class="nospace-words">' +
                                ' <p>抱歉，没有找到符合的场地</p>' +
                                ' <p>建议您修改筛选条件或者留下您的需求</p>' +
                                ' <p>会有专业客服30分钟内与您联系</p>' +
                                '</div> ' +
                                '<div class="nospace-btn-wrapper"> ' +
                                '<a href="/m/inquiry" class="nospace-btn">一键租场地</a>' +
                                ' </div> ' +
                                '</div>';
                            $$.filterList.html("");
                            $$.filterList.append(htm);
                            $$.cover.trigger('click');
                            $$.filterFixed.removeClass('none');
                            //$$.yunLoading.addClass("none");
                            if(!$$.inquiryTwo.hasClass('none')){
                                $$.inquiryTwo.addClass('none');
                            }
                            if(fn instanceof Function){
                                fn();
                            }
                            return;
                        }else{
                            $$.yunLoading.find(".load-animate").text("云SPACE已经全部加载");
                        }
                        return;
                    }
                    if(data.status=="1"){
                        //console.log(data.data.rows);
                        var allHtm="",rows=data.data.rows;
                        if(rows.length<8){
                            $$.yunLoading.find(".load-animate").text("云SPACE已经全部加载");
                        }
                        //$$.inquiryTwo.removeClass('none');
                        rows.forEach(function(v,k){
                            var htm='',size="",addr="",min_price,item_media="";
                            if(v.size!="0"|| v.size!=undefined){
                                size='<div class="space-squer fl"><span></span>&nbsp;'+ v.size+'㎡</div>';
                            }
                            if(v.attr!=null){
                                addr=' <div class="space-addr fl"><span></span>&nbsp;'+ v.attr["所属商圈"]+'</div>'
                            }
                            if(v.min_price!=0){
                                min_price=' <div class="space-price-symbol ion-social-yen fl" data-pack="social"'+
                                            'data-tags="currency, trade, money, japanese">' +
                                            '</div>'+
                                            '<div class="space-price-number fl">'+ v.min_price+'</div>'+
                                            '<div class="space-price-unit fl">'+v.price_unit+'&nbsp;起</div>'+
                                            '<div class="space-price-icon ion-ios-arrow-right fl" data-pack="ios"'+
                                            'data-tags="chevron">' +
                                            '</div>'
                            }else{
                                min_price='<div class="space-price-unit fl">面议</div>';
                            }
                            if(v.item_media!=null){
                                if(v.item_media.length!=0){
                                    item_media='<div class="space-img-sum">'+v.item_media.length+'张</div>'
                                }else{
                                    item_media="";
                                }
                            }

                            if(v.baike_mobile_logo==''){
                                v.baike_mobile_logo = $("#no-item-logo").attr('src');

                            }
                            htm='<li class="clearfix">'+
                                    '<a href="/m/site/'+ v.baike_name+'-百科-'+ v.item_id+'">'+
                                        '<div class="filter-list-img">'+
                                            '<img src="'+ v.baike_mobile_logo+'" alt="'+ v.baike_item_name+'">'+
                                                item_media+
                                        '</div>'+
                                        '<div class="filter-list-right">'+
                                            '<div class="space-title clearfix">'+
                                            '<div class="space-name">'+v.baike_item_name+'</div>'+
                                            '</div>'+
                                            '<div class="space-label clearfix">'+
                                                size+addr+
                                            '<div class="space-distance fr" data-geo_lat="'+ v.geo_lat+'" data-geo_lng="'+ v.geo_lng+'">&nbsp;</div>'+
                                            '</div>'+
                                            '<div class="space-price clearfix">'+
                                                min_price+
                                            '</div>'+
                                        '</div>'+
                                    '</a>'+
                                    '<div class="space-icon-default space-icon" data-baike_id="'+ v.baike_id+'" data-id="'+v.item_id+'"></div>'+
                                '</li>';
                            allHtm+=htm;
                        });
                        //console.log($$.filterList.length);
                        //console.log(allHtm);
                        if(f.filterFirst==true){
                            $$.filterList.html("");
                        }
                        $$.filterList.append(allHtm);
                        $$.cover.trigger('click');
                        f.animateCircle();
                        /*
                        *
                        * 获取到所所有的经纬度
                        * */
                        f.defeatLocation=true;
                        if(f.filterData.searchType=="2"){
                            $$.filterList.find("li").each(function(index,dom){
                                var $dom=$(dom),geo={};
                                var $distance=$dom.find(".space-distance");
                                var lng=$distance.data("geo_lng"),lat=$distance.data("geo_lat");
                                f.getDistance(f.filterData.searchText,lng,lat,$dom);
                            });
                            if(fn instanceof Function){
                                fn();
                            }
                            return;
                        }
                        if(f.filterData.address!=""){
                            $$.filterList.find("li").each(function(index,dom){
                                var $dom=$(dom),geo={};
                                var $distance=$dom.find(".space-distance");
                                var lng=$distance.data("geo_lng"),lat=$distance.data("geo_lat");
                                f.getDistance(f.filterData.address,lng,lat,$dom);
                            });
                            if(fn instanceof Function){
                                fn();
                            }
                            return;
                        }
                        if(fn instanceof Function){
                            fn();
                        }
                    }else{
                        alert('网络请求错误或者参数不正确!!')
                    }
                    /*
                     * 这里面处理查询的值
                     * */
                });
            },
            /*
            * 搜索接口
            * */
            handleSearchResult:function(locationHtm){
                if(!f.filterData.searchResult)return;
                YunSpace.api('search/case/title/handle.jsonp',{
                    q: f.filterData.searchResult,
                }, function (data) {
                    if(data.status=="1"){
                        var d=data.data,allHtm="";
                        if(d.length>0){
                            d.forEach(function(v,k){
                                var  htm='<li>'+
                                    '<a href="JavaScript:;" class="res" data-type="1">'+
                                    '<p class="fl">'+ v +'</p>'+
                                    '<span class="fr">用途</span>'+
                                    '</a>'+
                                    '</li>';
                                allHtm+=htm;
                            });
                        }
                        //console.log(f.filterData.locationPlace,2222);
                        $$.searchBody.find('.search_list').html("");
                        $$.searchBody.find('.search_list').append(allHtm+locationHtm);
                        /*
                         * ajax后执行
                         * */
                        $$.searchBody.find('.search_result a').each(function(index,dom){
                            document.body.style.overflow='auto';
                            var $dom=$(dom);
                            $dom.on('click',function(e){
                                var e=e;
                                var text=$dom.find('p').text();
                                $$.searchInput.text(text);
                                $$.locationAddr.text(text);
                                f.filterData.searchText=text;
                                f.filterData.searchType=$(this).data('type');
                                f.filterData.lng=$(this).data('lng');
                                f.filterData.lat=$(this).data('lat');
                                f.localFilter.address=f.filterData.searchText;
                                f.localFilter.lng=f.filterData.lng;
                                f.localFilter.lat=f.filterData.lat;
                                if($dom.data('type')=="1"){
                                    f.localFilter.searchType=f.filterData.searchType;
                                }
                                if($dom.data('type')=="2"){
                                    f.localFilter.searchType=f.filterData.searchType;
                                }
                                f.setLocationStorage(f.localFilter);
                                var historyObj={text:text,searchType:$(this).data('type')};
                                //console.log(JSON.stringify(historyObj));
                                f.setHistoryLocal(JSON.stringify(historyObj), function(){
                                    f.showHistory(e);
                                });
                                //$("#suggestId").attr('autocomplete','on').val(text);
                                f.filterFirst=true;
                                f.handleFilterData(function(){
                                    f.filterData.dp++;
                                });
                            });
                        });
                    }else{
                        console.error('网络请求失败或者参数错误!!');
                    }
                })
            },
            /*搜索地标*/
            searchBaidu:function(){
                var map = new BMap.Map("allmap");
                map.centerAndZoom("北京",12);
                var myGeo = new BMap.Geocoder();// 初始化地图,设置城市和地图级别。
                var ac = new BMap.Autocomplete(    //建立一个自动完成的对象
                    {
                        "input" : "suggestId",
                        onSearchComplete:function(v) {
                            //console.log(v);
                            var allHtm="";
                            f.filterData.locationPlace=[];
                            v.wr.splice(0,4).forEach(function (v, k) {
                                var addr=v.province + v.city  + v.district  + v.street  + v.streetNumber+ v.business;
                                myGeo.getPoint(addr, function(point){
                                    if(point==null)return;
                                    var htm='<li>'+
                                        '<a href="JavaScript:;" class="res" data-type="2" data-lng="'+point.lng+'" ' +
                                        ' data-lat="'+point.lat+'">'+
                                        '<p class="fl">'+ addr +'</p>'+
                                        '<span class="fr">地标</span>'+
                                        '</a>'+
                                        '</li>';
                                    allHtm+=htm;
                                    if(k>=3){
                                        f.handleSearchResult(allHtm);
                                    }
                                }, f.city_current);
                            });
                        }
                    });
                setTimeout(function(){
                    var v=$(".search_input").text();
                    $("#search-body").find("#suggestId").val(v);
                },500);
                return f;
            },
            /*获取距离*/
            getDistance:function(currentAddr,lng,lat,o,defeatLocation){
                var map = new BMap.Map("allmap");
                // 创建地址解析器实例
                var myGeo = new BMap.Geocoder();
                myGeo.getPoint(currentAddr, function(point){
                    if (point) {
                        var pointA = new BMap.Point(point.lng,point.lat);
                        var pointB = new BMap.Point(parseFloat(lng/10000).toFixed(4),parseFloat(lat/10000).toFixed(4));
                        var distance=parseInt(map.getDistance(pointA,pointB)),dt="";
                        dt=distance+"m";
                        if(distance>1000&&distance<100000){
                            var d=parseFloat(distance/1000).toFixed(2);
                            dt=d+"km";
                        }
                        if(distance>100000){
                            dt=">100km";
                        }
                        if(distance<=1000&&distance>100){
                            dt=parseInt(distance/10)*10+"m";
                        }
                        if(distance<=100){
                            dt="<100m";
                        }
                        o.find(".space-distance").text(dt);
                    }else{
                        if(f.defeatLocation==false)return;
                        f.defeatLocation=false;
                        alert("您选择地址没有解析到结果,请重新搜索地标!!");
                    }
                });
            },
            /*加载更多*/
            loadMore:function(){
                var load=false;
                $(window).on('scroll',function(){
                    var st=$(window).scrollTop(),wh=$(window).height(),
                        fh=$$.filterFixed.outerHeight(),topH=$$.searchTop.outerHeight(),flh=$$.filterList.outerHeight();
                    if(topH+fh+flh+40>wh){
                        if(st+wh>=topH+fh+flh+40){
                            if(load==true)return;
                            load=true;
                            //$$.yunLoading.removeClass('none');
                            $(window).scrollTop(topH+fh+flh+40+40);
                            var t=setTimeout(function(){
                                f.filterFirst=false;
                                f.handleFilterData(function(){
                                    f.filterData.dp++;
                                    load=false;
                                    //$$.yunLoading.addClass('none');
                                    clearTimeout(t);
                                });
                            },3000);
                        }
                    }
                });
                return f;
            },
            //显示需要询问的档期
            showAddedCurrent:function(){
                var loaded=false;
                var url=$$.inquiry.data('src');
                $$.inquiry.on("click",function(e){
                    $$.currentBody.addClass('current-body-active');
                    document.body.style.overflow='hidden';
                    if(loaded==true){
                        f.handleCurrent(e);
                        return;
                    }
                    var e=e;
                    $.ajax({
                        type: "post",
                        url: url,
                        dataType: "html",
                        success: function (htm) {
                            $$.currentBody.append(htm);
                            loaded=true;
                            f.handleCurrent(e);
                        }
                    });
                });
                return f;
            },
            handleCurrent:function(e){
                f.removeCurrent().hiddenCurrentBody();
            },
            handleCurrentFinalUrl:function(){
                var idStr="";
                if(f.filterData.priceLook.length==0){
                    $$.currentBody.find(".inquiry").attr('href','javascript:;');
                    return;
                }
                f.filterData.priceLook.forEach(function(v,k){
                    idStr+=v.baike_id+",";
                });
                var href=$('body').data('root')+"inquiry?space_id="+idStr.substring(0,idStr.length-1);
                $$.currentBody.find(".inquiry").attr('href',href);
            },
            /*删除已选择的查询数量*/
            removeCurrent:function(){
                //console.log(f.filterData.priceLook);
                $$.currentBody.find(".inquiry span").text("询价（"+ f.filterData.priceLook.length+"家）");
                $$.currentBody.find(".inquiry").removeClass('none');
                $$.currentBody.find(".search_top").removeClass('none');
                var allLi = "";
                f.filterData.priceLookLi.forEach(function(v,k){
                    allLi+=v;
                });
                $$.currentBody.find(".filter-list").html("").append(allLi);
                $$.currentBody.find(".filter-list .space-icon").removeClass("space-icon-active").addClass("space-icon-dlt");
                f.handleCurrentFinalUrl();
                $$.currentBody.find(".space-icon-dlt").on("click",function(){
                    var $this=$(this),cb=$$.currentBody;
                    var id=$this.data("id");
                    $this.parents("li").remove();
                    f.filterData.priceLook.forEach(function(v,k){
                        if(v.id==id){
                            f.filterData.priceLook.splice(k,1);
                        }
                    });
                    f.handleCurrentFinalUrl();
                    //if(f.filterData.priceLook.indexOf(parseInt(id))>-1){
                    //    f.filterData.priceLook.splice(f.filterData.priceLook.indexOf(parseInt(id)),1);
                    //}
                    var num=f.filterData.priceLook.length;
                    cb.find(".inquiry span").text("询价（"+num+"家）");
                    $$.filterList.find("li").each(function(index,dom){
                        var $dom=$(dom);
                        var delId=$dom.find(".space-icon").data('id');
                        if(delId==id){
                            $dom.find(".space-icon").removeClass("space-icon-active").addClass("space-icon-default");
                            $dom.find(".space-icon").attr("data-add",false);
                        }
                    });
                    f.filterData.priceLookLi.forEach(function(v,k){
                        var idStr='data-id="'+id+'"';
                        if(v.indexOf(idStr)>-1){
                            f.filterData.priceLookLi.splice(k,1);
                        }
                    });
                    $$.inquirySum.text(f.filterData.priceLook.length);
                    if(f.filterData.priceLook.length==0){
                        $$.inquiryTwo.removeClass('none');
                        $$.inquiry.addClass('none');
                    }
                });
                return f;
            },
            /*返回*/
            hiddenCurrentBody:function(){
                $$.currentBody.find(".back_icon").on("click",function(){
                    $$.currentBody.removeClass('current-body-active');
                    $$.currentBody.find(".inquiry").addClass('none');
                    $$.currentBody.find(".search_top").addClass('none');
                    document.body.style.overflow='auto';
                });
            },
            toTop:function(){
                $("#topcontrol").on("click",function(){
                    $$.filterFixed.removeClass('none');
                });
                return f;
            },
            handleScrollStop:function(){
               var canAutoScroll=true;
                var timeout = null;
                $(window).scroll(function(){
                    if(timeout != null){
                        clearTimeout(timeout);
                    }
                    if(f.filterData.priceLook.length==0){
                        if(!$$.inquiryTwo.hasClass('none')){
                            $$.inquiryTwo.addClass('none');
                        }
                    }else{
                        if(!$$.inquiry.hasClass('none')){
                            $$.inquiry.addClass('none');
                        }
                    }
                    window.canAutoScroll = false;
                    //1000ms后，假定认为停止滚动
                    timeout =setTimeout(function(){
                       canAutoScroll = true;
                        if(f.filterData.priceLook.length==0){
                            $$.inquiryTwo.removeClass('none');
                        }else{
                            $$.inquiry.removeClass('none');
                        }
                    },1000);
                });
                return f;
            },
            /*初始化localstorage*/
            initLocationStorage:function(){
                var that=this;
                that.siteLibrary=localStorage.getItem('filter_data');
                if(that.siteLibrary==null){
                    var a={};
                    a=JSON.stringify(a);
                    localStorage.setItem('filter_data',a);
                    that.siteLibrary=localStorage.getItem('filter_data');
                }
                that.siteLibrary=that.getLocationStorage();
                return that;
            },
            setLocationStorage:function(obj){
                localStorage.setItem('filter_data',JSON.stringify(obj));
            },
            getLocationStorage:function(){
                return JSON.parse(localStorage.getItem('filter_data'));
            }
        };
        f.init();
    });
    var indexOf = function(arr,val) {
        for (var i = 0; i < arr.length; i++) {
            if (arr[i] == val) return i;
        }
        return -1;
    };
    var remove = function(arr,val) {
        var index = indexOf(val);
        if (index > -1) {
            arr.splice(index, 1);
        }
    };
})(jQuery,window,document);

