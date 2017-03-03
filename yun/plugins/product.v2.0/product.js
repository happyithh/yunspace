/**
 * Created by pzl on 15/10/22.
 */
var plugin={
    loadNum1:"",
    init:function(){
        this.loadedNum1=$(".load-btn1").data("start-num");
        navScroll.init().showNav().showNavClick().scrollPosition().navScrolled();
        this.showPosition();
        var winH=$(window).height();
        var fix=false;
        var name=$("#addToOrder").data("name");
        if(localStorage.getItem("ProductList")!=null){
            if(localStorage.getItem("ProductList").length>0){
                var l=JSON.parse(localStorage.getItem("ProductList")).length;
                $(".circle1").text(l);
            }
            var c1=$(".circle1").text();
            if(c1=="")$(".circle1").addClass("none");else $(".circle1").removeClass("none");

            if(localStorage.getItem("ProductList").indexOf(name)>=0){
                $("#addToOrder").text("已加入询价单");
                $(".product-fix-js").addClass("product-fix-js-active");
            }
        }
        $(window).on("scroll",function(){
            var winScr=$(window).scrollTop();
            if(winScr>=winH){
                if(fix==true)return;
                $(".product-fix").show();
                $(".product-back-top").show();
                fix=true;
            }else{
                if(fix==false)return;
                $(".product-fix").hide();
                $(".product-back-top").hide();
                fix=false;
            }
        })
        //$(".BMap_mask").on("touchstart",function(e){e.preventDefault(); return false;})
    },
    // 百度地图API功能
    showPosition:function(){
        var map = new BMap.Map("allmap");
        var local = new BMap.LocalSearch(map, {
            renderOptions:{map: map}
        });
//        map.removeOverlay();
        map.disableDragging();
        var local_addr=$('.product-part1-des-addr > span').text();
        local.search(local_addr);
    },
    //加入询价单动画
    joinPrice:function(ele){
        var name=$(ele).data("name");
           if(localStorage.getItem("ProductList")&&localStorage.getItem("ProductList").indexOf(name)>0){return false;}
           $(".circle2").removeClass("none").addClass("circle2-active");
           $(".circle1").removeClass("none");
           setTimeout(function(){
               $(".circle2").addClass("none").removeClass("circle2-active");
           },500);
           $(".product-fix-js").addClass("product-fix-js-active");
           var n=$(".circle1").text();
           $(".circle1").text(++n);
           $(ele).text("已加入询价单");
    },
    backTop:function(ele,args,fn){
        $(window).scrollTop(0);
        $(ele).hide();
    },
    //加载更多图片
    loadMoreImg:function(ele,args,fn){
        var __self=this;
        var moreBtn=$(".load-btn1");
        var count=moreBtn.data("count-media");
        if(__self.loadedNum1>=count){ $(".loaded1").show();return false};
        $(".loading-more1").show();
        moreBtn.addClass("none");
        $.post("?",{ start_num :__self.loadedNum1,limit:3 },function(data){
            if(data.status ==1){
                var l=0;
                for(var k  in data.data.media_data){
                    var cloneImg=$(".more-img").first().clone().removeClass("none");
                    $(cloneImg).find("img").attr("src",data.data.media_data[k]["small_src"]);
                    $(".product-part2-img-list1").append(cloneImg);
                    l++;
                }
                __self.loadedNum1=__self.loadedNum1+l;
                moreBtn.attr("data-count-media",count);
                moreBtn.removeClass("none");
                $(".loading-more1").hide();
                if(__self.loadedNum1>=count){
                    moreBtn.addClass("none");
                    $(".loaded1").show();
                }
            }
        },"json")
    },

    //加载更多案例
    loadMoreCase:function(){
        var last_id=$(".product-part2-img-list2 > li:last").data("last_id");
        console.log(last_id);
    }

}

var navScroll={
    fix:false,  //判断是否已经fixed
    needTop:"",
    mySwiper:"",
    partTop:[], //各个部分偏移高度
    scrollRange:[],//各个部分定位之后的开关，将内存消耗最小化
    init:function(){
        var __self=this;
        __self.needTop=$(".product-part1").height()+20;  //part1高度+20
        $(".product-part2-nav").css({top:__self.needTop+"px"});
        var length=$(".swiper-slide").length;
        for(var i=1;i<=length-1;i++){
            var index=i+1;
            __self.partTop[i]=$(".product-part"+index).offset().top ;
        }
        //__self.navScrolledEvent();
        __self.setNavPositon();
        __self.navScroll();
        $(".cover1").on("touchstart",function(){
            __self.navHided();
        })
        return __self;
    },
    navScroll:function(){
        var __self=this;
        this.mySwiper = new Swiper('.swiper-container',{
            autoplay:false,//可选选项，自动滑动
            slidesPerView : 4,
            slidesPerGroup : 1,
            onTap: function(swiper){

                __self.swiperNavClick(swiper);
            }
        });
        return __self;
    },
    //滚动执行事件
    scrollPosition:function(){
        var __self=this;
        $(window).on("scroll",function(){
            __self.setNavPositon();
        });
        return __self;
    },
    //设置nav位置
    setNavPositon:function(){
        var scrTop=$(window).scrollTop();
        if(scrTop > this.needTop){
            if(this.fix==true){return;}
            $(".product-part2-nav").addClass("product-part2-nav-fix").css({top:"0px"});
            this.fix=true;
        }else{
            if(this.fix==false){return;}
            $(".product-part2-nav").removeClass("product-part2-nav-fix").css({top:this.needTop+"px"});
            this.fix=false;
        }
        return this;
    },
    //sweiper点击执行事件
    swiperNavClick:function(o){
        var __self=this;
            this.navClicked(o.clickedIndex);
            $(window).scrollTop(__self.partTop[o.clickedIndex+1]-44);
    },
    //点击下拉菜单
    showNav:function(){
        var __self=this;
        $(".show-nav-click").on("touchend",function(){
            __self.navShowed(this)
        })
        return __self;
    },
    navShowed:function(o){
        $(".product-part2-nav-dropdown").eq(1).toggleClass("none");
        $(".show-floor-p").toggleClass("none");
        $(".show-floors").toggleClass("none");
        $(".swiper-container").toggleClass("none");
        $(this).find("span").toggleClass("ion-ios-arrow-up");
        if($(".show-floor-p").hasClass("none")){
            $(".cover1").addClass("none");
        }else{
            $(".cover1").removeClass("none")
        }
    },
    navHided:function(){
        $(".product-part2-nav-dropdown").eq(1).removeClass("none");
        $(".show-floor-p").addClass("none");
        $(".show-floors").addClass("none");
        $(".swiper-container").removeClass("none");
        $(".ion-ios-arrow-down").find("span").removeClass("ion-ios-arrow-up");
        $(".cover1").addClass("none");
        return;
    },
    //showNav点击事件
    showNavClick:function() {
        var __self=this;
        $(".show-floors-li").find("li").each(function (index, dom) {
            $(dom).on("touchend",function(){
                __self.navClicked(index);
                $(window).scrollTop(__self.partTop[index+1]-44);
            })
        })
        return __self;
    },
    //点击执行事件
    navClicked:function(index){
        var __self=this;
        var slideW=$(".swiper-slide").width();
        $(".swiper-slide").find("span:first").addClass("none");
        $(".show-floors-li > li").find("span:first").addClass("none");
        $(".swiper-slide").find("span:last").removeClass("pos-color");
        $(".show-floors-li  > li").find("span:last").removeClass("pos-color");
        $(".swiper-slide").eq(index).find("span:first").removeClass("none");
        $(".swiper-slide").eq(index).find("span:last").addClass("pos-color");
        $(".show-floors-li").find("li").eq(index).find("span:first").removeClass("none");
        $(".show-floors-li").find("li").eq(index).find("span:last").addClass("pos-color");
        if(index<=3){
            $(".swiper-wrapper").css({ transform: "translate3d(-"+((index-1)*slideW)+"px, 0px, 0px)","transition-duration": "500ms" });
        }else{
            $(".swiper-wrapper").css({ transform: "translate3d(-"+(3*slideW)+"px, 0px, 0px)" ,"transition-duration": "500ms" });
        }
    },
    //滚动事件
    navScrolled:function(){
        var __self=this;
        $(window).on("scroll",function(){
            //if($(".cover1").hasClass("none")){console.log(111);return false;}
            __self.navScrolledEvent();
        });
        return __self;
    },
    //滚动后执行事件
    navScrolledEvent:function(){
        var __self=this;
        var winH=$(window).height();
        var scrTop=$(window).scrollTop();
        if(scrTop<=__self.needTop){
            __self.navHided();
        }
        if(scrTop>arrayMax(__self.partTop)-44){__self.navClicked(6);return false}
        for(var k=0;k<__self.partTop.length;k++){
            if(scrTop<__self.partTop[0])return;
            if(scrTop >= __self.partTop[k]-44&& scrTop <__self.partTop[k+1]-44){
                if(__self.scrollRange[k]==true)return;
                __self.scrollRange[k]=true;
                __self.navClicked(k-1);
            }else{
                __self.scrollRange[k]=false;
            }

        }
    }
}
function arrayMax(arr){
    var max = arr[1];
    for(var i=2;i<arr.length;i++){
        if(max<=arr[i])max=arr[i];
    }
    return max;
}



//询价清单


showOrderNum();//显示询价单数量
var productName,productId;
productName = $(".space_name").text();
productId =  $("body").data("sid");
$('#addToOrder').click(function() {
    if(isAddToList()){
        return false;
    }

//    $('.side-nav').fadeIn(200);
//    var cart = $('#inquiryOrder');
//    var imgtofly = $('<span style="display: block" class="circle1"></span>');
//    if (imgtofly) {
//        var imgclone = imgtofly.clone()
//            .offset({ top:$(this).offset().top, left:$(this).offset().left+108 })
//            .css({'opacity':'0.7', 'position':'absolute', 'height':'150px', 'width':'150px', 'z-index':'1000'})
//            .appendTo($('body'))
//            .animate({
//                'top':cart.offset().top + 10,
//                'left':cart.offset().left + 30,
//                'width':55,
//                'height':55
//            }, 500, 'easeOutQuad');
//        imgclone.animate({'width':0, 'height':0}, function(){ $(this).detach() });
//    }
    addToList();
    showOrderNum();
    return false;
});

function isAddToList(){
    var item = localStorage.getItem("ProductList");
    if(item){
        var productList = JSON.parse(item);
        for(var i=0; i<productList.length; i++){
            if(productName == productList[i]){
                return true;
            }
        }
    }
    return false;
}
function addToList(){
    var item = localStorage.getItem("ProductList");
    if(item){
        var productList = JSON.parse(item);
        productList.push(productName);
        var json = JSON.stringify(productList);
        localStorage.setItem('ProductList',json)
    }else{
        productList = [productName];
        var json = JSON.stringify(productList);
        localStorage.setItem('ProductList',json)
    }
    hasOrders = hasOrder();
}
function showOrderNum(){
    var item = localStorage.getItem("ProductList");
    if(item){
        var productList = JSON.parse(item);
        var num = productList.length;
        for(var i=0; i<productList.length; i++){
            if(productName == productList[i]){
                $('#addToOrder').text('已加入询价单').addClass('invalid');
            }
        }
        $('#inquiryOrder span').text(num);
    }else{
        $('#inquiryOrder span').text('0');
    }
}

function hasOrder(){
    var item = localStorage.getItem("ProductList");
    if(item){
        var productList = JSON.parse(item);
        if(productList.length > 0){
            return true
        }
    }
    return false;
}
