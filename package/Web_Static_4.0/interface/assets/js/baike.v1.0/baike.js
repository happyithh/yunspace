
$(function(){
    //子空间列表样式显示（有子空间价格就显示子空间价格，如果子空间价格是显示的不公开，则显示面议）
    $("#nv-hireArea table tr").each(function(index,ele){
        var text3=$(ele).find("td").eq(3).text().trim();
        // var min_price=$(ele).find("td").eq(3).data("min_price");
        // var max_price=$(ele).find("td").eq(3).data("max_price");
        // var price_unit=$(ele).find("td").eq(3).data("price_unit");
        var text_show='';
        if(!text3){
            // if(!price_unit){
            //     price_unit="天";
            // }

            // if(min_price>100){
            //     if (min_price==max_price){
            //         text_show="￥"+min_price+"元/"+price_unit;
            //     }else{
            //         text_show="￥"+min_price+" ~ ￥"+max_price+"元/"+price_unit;
            //     }
                    
            // }else{
            //     text_show='面议';
            // }  
            $(ele).find("td").eq(3).text("面议");
        }            
    });

    //租场地去边框/去padding
    $('.comn-baike-lease li:nth-child(4n)').css({
        'border':'none',
        'padding-right':0
    });
    $('.comn-baike-lease li:nth-child(4n+1)').css({
        'padding-left':0
    });
    $('.comn-baike-lease li:last-child').css({
        'border':'none'
    });

    //场地位置内容列表去最后一个边框
    $('.position-describe-ul li:last-child').css({
        'border':'none'
    });

    //词条目录悬浮
    if($('.baike-content').length > 0){
        $(document).scroll(function(){
                var st = $(document).scrollTop();
                var bt=$('.baike-content').offset().top;
                //console.log(st);
                if(st>bt-35){
                    $('.side-nav').addClass('side-nav-fixed');
                }else{
                    $('.side-nav').removeClass('side-nav-fixed');
                }
        });
    }
    $('.baike-imglist-ul li').hover(function(){
        $(this).addClass('active');
    },function(){
        $(this).removeClass('active');
    });
    $('#nav').onePageNav();

    //标签切换具体内容
    //var openTimeout;
    //$(".subspace-menu li").each(function(index){
    //    var thisa=$(this);
    //    thisa.mouseover(function() {
    //        openTimeout=setTimeout(function() {
    //            $(".subspace-menu li").removeClass("current");
    //            $(".subspace-box .cont").removeClass("current");
    //            thisa.addClass("current");
    //            $(".subspace-box .cont").eq(index).addClass("current");
    //        },200);
    //    }).mouseout(function(){
    //        clearTimeout(openTimeout);
    //    });
    //});



    $('.comn-space-img .linkimg').hover(function () {
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


    //无banner时图片加载更多

    var load_more=$(".load-more-btn");
    var start_num=load_more.attr('data-start-num');
    var media_string=$(".media_all").text();
    if(media_string.length > 0){
        var data=JSON.parse(media_string);
        load_more.click(function(){
            var total_num=$(this).attr('data-count-media');
            if(parseInt(start_num) >= parseInt(total_num)){
                start_num=total_num;
                return false;
            }
            for(var i=start_num;i<parseInt(start_num)+12;i++){
                var cloneImg=$(".load-img").first().clone().removeClass("none");
                if(data[i]){
                    $(cloneImg).attr("href",data[i]["big_src"]);
                    $(cloneImg).find("img").attr("src",data[i]["small_src"]);
                    $(cloneImg).find("img").attr("title",data[i]["name"]);
                    $(".comn-baike-pic").append(cloneImg);
                }else{
                    start_num=total_num;
                }

            }
            start_num=parseInt(start_num)+12;
            if(start_num>=total_num){
                load_more.find("span").text("已加载全部");
                load_more.find("img").addClass("none");
                var y=total_num%4;

                switch (y){
                    case 1:
                        for(var i=0;i<3;i++){
                            var cloneLoad=$(".loading-img").first().clone().removeClass("none");
                            $(".comn-baike-pic").append(cloneLoad);
                        }
                        break;
                    case 2:
                        for(var i=0;i<2;i++){
                            var cloneLoad=$(".loading-img").first().clone().removeClass("none");
                            $(".comn-baike-pic").append(cloneLoad);
                        }
                        break;
                    case 3:
                        for(var i=0;i<1;i++){
                            var cloneLoad=$(".loading-img").first().clone().removeClass("none");
                            $(".comn-baike-pic").append(cloneLoad);
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
            };
            if(typeof $.fancybox =='function'){
                $(".fancybox-a").fancybox({
                    helpers: {
                        title : {
                            type : 'inside'
                        },
                    },
                    maxWidth : 770,

                });
            };
        });
    }
    
    if(typeof $.fancybox =='function'){
        $(".fancybox-a").fancybox({
            helpers: {
                title : {
                    type : 'inside'
                },
            },
            maxWidth : 770,

        });
    };

    //百科页面子空间图片展示
    $(".linkimg").fancybox({
        'titlePosition' : 'over',
        'cyclic'        : true,
        helpers : {
            title: {
                type: 'outside'
            }
        },
        'titleFormat'    : function(title, currentArray, currentIndex, currentOpts) {
            return (title.length ? '   ' + ('<p>'+title+'</p>') : '') + '<span id="fancybox-title-over">' + (currentIndex + 1) +
                ' / ' + currentArray.length + '</span>';
        }
    });


    //查询档期和价格,合作咨询
    $(".pop-show").click(function(){
        $(".cover,.search-box").fadeIn();
    });
    $('.search-box-placeholder').click(function(){
        $(this).css('display','none');
        $(this).siblings(".search-box-input").focus();
    });
    $('#search-box-close').on('click',function(){
        $(".cover,.search-box").fadeOut();
    });
    $('.search-date-start').focus(function(){
        $('.search-date-outside').show();
    });
    $(".cover").click(function(){
        $(".cover,.search-box").fadeOut();
    })
    $(".search-box-btn").click(function(){
        var contact_name = $(".search-box").find("input[name='username']").val();
        var contact_phone = $(".search-box").find("input[name='phone']").val();
        var start_time = $(".search-box").find("input[name='date_start']").val();
        var end_time = $(".search-box").find("input[name='date_end']").val();
        var other_demand = $(".search-box").find("input[name='other_demand']").val();
        var space_id = $(".search-box").find(".space_id").val();
        var space_name = $(".search-box").find(".space_name").val();
        var demand_city = $(".search-box").find(".demand_city").val();
        var from_type = $(".search-box").find("input[name='from_type']").val();
        var data_a='';

        //名称不为空
        if(contact_name==''){
            $(".search-box").find(".error_msg").removeClass('none');
            $(".search-box").find(".error_msg").html('请填写您的称呼，方便我们联系你！');
            setTimeout("$('.search-box').find('.error_msg').addClass('none')",3000);
            return false;
        }

        // 联系方式不为空
        if(contact_phone==''){
            $(".search-box").find(".error_msg").removeClass('none');
            $(".search-box").find(".error_msg").html('请填写您的手机号，方便我们联系你！');
            setTimeout("$('.search-box').find('.error_msg').addClass('none')",3000);
            return false;
        }
        if(from_type!=''){
            switch (from_type){
                case '1':
                    from_demand = "来源百科id:"+space_id+"百科名："+space_name;
                    //判断开始时间和结束时间
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
                    //组装数据
                    data_a = {
                        username: contact_name,
                        phone: contact_phone,
                        content: other_demand+from_demand,
                        object_id: space_id,
                        object_name: space_name,
                        object_type: "site",
                        start_time: start_time,
                        end_time: end_time,
                        from_type: from_type,
                        demand_city:demand_city,
                        action: 'new_events'
                    };
                    break;
                case '2':
                    from_demand = "来源资讯id:"+space_id+"资讯标题："+space_name;
                    //文创项目合作
                    if(other_demand==''){
                        $(".search-box").find(".error_msg").removeClass('none');
                        $(".search-box").find(".error_msg").html('请填写你要咨询的问题！');
                        setTimeout("$('.search-box').find('.error_msg').addClass('none')",3000);
                        return false;
                    }
                    data_a = {
                        username: contact_name,
                        phone: contact_phone,
                        content: other_demand+from_demand,
                        object_id: space_id,
                        object_name: space_name,
                        object_type: "site",
                        from_type: from_type,
                        demand_city:demand_city,
                        action: 'new_events'
                    };
                    break;
               default:
                   //合作咨询
                   from_demand = "来源场地id:"+space_id+"咨询场地："+space_name;
                    //判断咨询内容
                    if(other_demand==''){
                        $(".search-box").find(".error_msg").removeClass('none');
                        $(".search-box").find(".error_msg").html('请填写你要咨询的问题！');
                        setTimeout("$('.search-box').find('.error_msg').addClass('none')",3000);
                        return false;
                    }
                    data_a = {
                        username: contact_name,
                        phone: contact_phone,
                        content: other_demand+from_demand,
                        object_id: space_id,
                        object_name: space_name,
                        object_type: "site",
                        from_type: from_type,
                        demand_city:demand_city,
                        action: 'new_events'
                    };
                    break;
            }

        }
        YunSpace.api("demand/create.jsonp", data_a, function (data) {
            if (data.status == 1) {
                alert('提交成功，我们会尽快与您联系！');
                $(".cover,.search-box").fadeOut();
            }else{
                alert(data.msg);
            }
        });
    });

});
function showLgImg(){
    $('.comn-space-img .linkimg').click(function(){
        $('.popup_bg').remove();
        //if($(this).hasClass("loading-img")){
        //    return false;
        //}
        $('.pop-img .img img').attr("src","");
        var src=$(this).find("img").attr('data-src');
        var title=$(this).find("img").attr('title');
        var number=$(this).find("img").attr('data-number');
        //console.log(src,title,number);
        $('.pop-img .img_title').text(title);
        $('.pop-img .img_number').text(number);
        $('.pop-img .img img').attr("src",src);
        //$('.pop-img').show(300).after('<div class="popup_bg"></div>');
        $('.pop-img').show(300).after('<div class="popup_bg"></div>');
    });
}

function jsClose(){
    $('.js-close').click(function(){
        $('.pop-img').hide();
        $('.popup_bg').remove();
    });
}