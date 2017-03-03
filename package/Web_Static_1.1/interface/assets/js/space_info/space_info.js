$(function(){
    /*延迟加载当前页面的二维码*/
    $(".current_code").attr("src", $(".current_code").data('url'));

    /*活动案例*/
    $('.comn-space-case li').mouseenter(function(){
        $(this).find('.mask-bg').stop().fadeIn();
        $(this).find('.text').stop().slideDown();
    });
    $('.comn-space-case li').mouseleave(function(){
        $(this).find('.mask-bg').hide();
        $(this).find('.text').hide();
    });


    /*场地图片/立即咨询-弹窗*/
    $('.js-close').click(function(){
        $('.pop-img,.consult,.consult-versic,.consult-imd,.consult-look-price').hide();
        $('.popup_bg').remove();
    });
    showLgImg();
    function showLgImg(){
        $('.comn-space-img a').click(function(){
            if($(this).hasClass("loading-img")){
                return false;
            }
            $('.pop-img .img img').attr("src","");
            $src=$(this).find("img").attr('data-src');
            $title=$(this).find("img").attr('title');
            $number=$(this).find("img").attr('data-number');
            $('.pop-img .img_title').text($title);
            $('.pop-img .img_number').text($number);
            $('.pop-img .img img').attr("src",$src);
            $('.pop-img').show(300).after('<div class="popup_bg"></div>');
        });
    }

    //场地图片遮罩滑动效果
    //$('.comn-space-img').hover(function () {
    //    $('.space-mask').toggle();
    //});
    //$('.comn-space-img>a').mouseenter(function () {
    //    $('.space-mask').stop().animate({
    //        left: $(this).offset().left,
    //        top: $(this).offset().top - $(window).scrollTop()
    //    }, 200);
    //});
    $('.comn-space-img a').hover(function () {
        $(this).stop().animate({
            opacity:'0.75',
            filter:'alpha(opacity=75)'
        },500);
    }, function () {
        $(this).stop().animate({
            opacity:'1',
            filter:'alpha(opacity=100)'
        },300);
    });

    //子空间去边框
    $('.comn-space-subspace li:nth-child(4n-1)').css({
        border:'none'
    });
    //子空间加载更多效果
    $('.loading').hover(function(){
        $(this).addClass('loading-gif');
    },function(){
        $(this).removeClass('loading-gif');
    });

    //内容部分右边浮动
    $('.inquiry-ul-contleft .fill').focus(function(){
        $(this).parent().addClass('focused');
    });
    $('.inquiry-ul-contleft .fill').blur(function(){
        $(this).parent().removeClass('focused');
    });
    $('.inquiry-ul-contleft li').click(function () {
        $(this).find('.fill').focus();
    });

    var hasOrders = hasOrder();//是否已有询价单
    if($('#test').offset()){
        var offsetTop1 = $('#test').offset().top;
        var bottomOffset = $('.footer-outside').offset().top;
        var docHeight = $(document).height();
        var footerH = $('.footer-outside').height() + $('.bottom-outside').height();
        var sprtH=$('.space-right').height();
        var winH = $(window).height();



        function dealFixed(){
            var st = $(document).scrollTop();
            var sl = $(document).scrollLeft();
            var offsetLeft = $('.wrap').offset().left;
            var residue = docHeight - st -winH; //剩余的文档高度

            if( sl > 0){
                offsetLeft -= sl;
            }
            if(st >= offsetTop1-80){
                var sprtOffsetTop=$('.space-right').offset().top;
                var sprtBottom=docHeight-sprtH-footerH-sprtOffsetTop;
                var sprtFootH=sprtH+footerH;

                $('.space-right').css({
                    'position':'fixed',
                    'left': offsetLeft
                });
                if(sprtBottom<=20){
                    $('.space-right').css({
                        'bottom':footerH+20-residue,
                        'top':'auto'
                    });
                }else{
                    $('.space-right').css({
                        'top':'80px',
                        'bottom':'auto'
                    });
                }
            }else{
                $('.space-right').css({
                    'position':'relative',
                    'top':0,
                    'left': 0,
                    'bottom':'auto'
                });
            }
            //词条目录
            $('.side-nav').css({
                'left': offsetLeft+260
            });
            if(st > offsetTop1){
                $('.side-nav').fadeIn(200).addClass('side-nav-fixed');
            }else{
                if(!hasOrders){
                    $('.side-nav').fadeOut(200).removeClass('side-nav-fixed');
                }else{
                    $('.side-nav').removeClass('side-nav-fixed');
                }

            }
        }

        window.onscroll = function(){
            dealFixed();
        };
        window.onresize = function(){
            winH = $(window).height();
            dealFixed()
        }
        $('#nav').onePageNav();
        $('#nav1').onePageNav();
    }


    $('.side-nav .lione').click(function(){
        $('.side-nav .lione').removeClass('current');
        $(this).addClass('current');
    });

    //var offset = $("#inquiryOrder").offset();
    //$("#addToOrder").click(function(event){
    //    //console.log(offset);
    //    var addcar = $(this);
    //    //var img = addcar.parent().find('img').attr('src');
    //    var flyer = $('<img class="u-flyer" width="40" height="40" src="https://www.baidu.com/img/bdlogo.png">');
    //    flyer.fly({
    //        start: {
    //            left: event.pageX,
    //            top: event.pageY
    //        },
    //        end: {
    //            left: offset.left+10,
    //            top: offset.top+10,
    //            width: 0,
    //            height: 0
    //        },
    //        onEnd: function(){
    //            $("#msg").show().animate({width: '250px'}, 200).fadeOut(1000);
    //            addcar.css("cursor","default").removeClass('orange').unbind('click');
    //            this.destory();
    //        }
    //    });
    //    //return false;
    //});
    showOrderNum();//显示询价单数量
    $('#addToOrder').click(function() {
        if(isAddToList()){
            return false;
        }

        $('.side-nav').fadeIn(200);
        var cart = $('#inquiryOrder');
        var imgtofly = $('<span style="display: block" class="circle1"></span>');
        if (imgtofly) {
            var imgclone = imgtofly.clone()
                .offset({ top:$(this).offset().top, left:$(this).offset().left+108 })
                .css({'opacity':'0.7', 'position':'absolute', 'height':'150px', 'width':'150px', 'z-index':'1000'})
                .appendTo($('body'))
                .animate({
                    'top':cart.offset().top + 10,
                    'left':cart.offset().left + 30,
                    'width':55,
                    'height':55
                }, 500, 'easeOutQuad');
            imgclone.animate({'width':0, 'height':0}, function(){ $(this).detach() });
        }
        addToList();
        showOrderNum();
        return false;
    });

    $('#get_more').on('click',function(){

    })

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

    var load_more=$(".load-more-btn");
    var start_num=load_more.attr('data-start-num');
    load_more.click(function(){
        var total_num=$(this).attr('data-count-media');
        if(parseInt(start_num) >= parseInt(total_num)){
            return false;
        }
        $.post("?",{ start_num :start_num,limit:9 },function(data){
            if(data.status ==1){
                var k=0;
                for(var i in data.data.media_data){
                    var cloneImg=$(".load-img").first().clone().removeClass("none");
                    $(cloneImg).find("img").attr("data-src",data.data.media_data[i]["big_src"]);
                    $(cloneImg).find("img").attr("src",data.data.media_data[i]["small_src"]);
                    $(cloneImg).find("img").attr("title",data.data.media_data[i]["name"]);
                    $(cloneImg).find("img").attr("data-number",data.data.media_data[i]["order"]+1);
                    $(".comn-space-img").append(cloneImg);
                    k++;
                }
                start_num=parseInt(start_num)+k;
                   if(start_num==total_num){
                       load_more.find("span").text("已加载全部");
                       load_more.find("img").addClass("none");
                       var y=total_num%3;

                      switch (y){
                          case 1:
                              for(var i=0;i<2;i++){
                                  var cloneLoad=$(".loading-img").first().clone().removeClass("none");
                                  $(".comn-space-img").append(cloneLoad);
                              }
                              break;
                          case 2:
                              for(var i=0;i<1;i++){
                                  var cloneLoad=$(".loading-img").first().clone().removeClass("none");
                                  $(".comn-space-img").append(cloneLoad);
                              }
                              break;
                      }
                       $(".loading-img").hover(function(){
                           $(this).find("div").addClass("loading-gif");
                           $(this).css({ opacity:"0.75" });
                       },function(){
                           $(this).find("div").removeClass("loading-gif");
                           $(this).css({ opacity:"1" });
                       })
                   }
                    showLgImg();
            }
            console.log(data);
        },"json")
    })
});


