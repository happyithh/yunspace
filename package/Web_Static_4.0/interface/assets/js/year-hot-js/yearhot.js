$(function(){
    // banner轮播
    var initialSlide = 0;
    var swiper = new Swiper('.swiper-container', {
        pagination: '.swiper-pagination',
        initialSlide :initialSlide,
        paginationClickable: true,
        nextButton: '.yun-swiper-next',
        prevButton: '.yun-swiper-prev',
        loop:true,
        autoplay : false,
        autoplayDisableOnInteraction :false,
        paginationBulletRender: function (index, className) {
            return '<span class="' + className + '">' + (index + 1) + '</span>';
        }
    });

    //设置banner下ul第一个元素高度
    setTimeout(function(){
        var ht = $('.spacelist li:nth-child(2)').outerHeight();
        $('.spacelist li.explan').outerHeight(ht);
    },200);


    /*下拉框*/
    $(".select>p").on("click",function(e){
        $(this).parent().toggleClass("open");
        e.stopPropagation();
    });

    $(".select ul li").on("click",function(e){
        $(this).addClass("selected").siblings().removeClass("selected");
        $(this).parents('.select').find('p').text($(this).text());
        //console.log($(this).text());
        $(".select").removeClass("open");
        e.stopPropagation();
    });
    $(document).on("click",function(){
        $(".select").removeClass("open");
    });
    $('.metformul>li').on('click',function(){
        $(this).find('input').focus();
    });

    /*侧边显示/隐藏、返回顶部*/
    $(document).on('scroll',function(){
        var docScrollTop=$(document).scrollTop();
        var Hnav=$('.sidenav').height();
        if(docScrollTop>530){
            $('.sidenav').css({
                'position':'fixed',
                'top':20
            });
        }else{
            $('.sidenav').css({
                'position':'absolute',
                'top':530
            });
        }
    });
    $('.js-backtop').on('click',function(){
        $('body,html').animate({scrollTop:0},500);
        return false;
    });
    $('.sidenav a').on('click',function(){
        var id = $(this).data('id');
        if($("#"+id).length>0){
            $("html,body").animate({scrollTop:$("#"+id).offset().top},500);
        }
    });

    /**日历初始化**/
    $('#config-demo').daterangepicker({
        autoApply: true,
        language:  'zh-CN',
        opens : 'left',
        autoUpdateInput : false,
        locale : {
            format: "YYYY/MM/DD",
            separator: ' - '
        }
    }, function(start, end, label) {
        $('#config-demo').val(start.format('YYYY/MM/DD')+' - '+ end.format('YYYY/MM/DD'));
    });


    //手机号过滤
    function isMobile(phone){
        if(phone==null)return false;
        var exp= /^(0|86|17951)?(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$/;
        if(exp.test(phone)){
            return true;
        }else{
            return false;
        }
    }

    $('.js-submit').on('click',function(){
        var time=$("input[name='time']").val();
        var company = $("input[name='compyname']").val().replace(/ /g,''),
            username = $("input[name='username']").val().replace(/ /g,''),
            phone= $("input[name='telphone']").val().replace(/ /g,''),
            startTime= time.substr(0,10),
            endTime= time.substr(time.length-10),
            actPersons=$("#peoplenumbs").text(),
            event_type=$("#eventtype").text(),
            space_item =$("input[name='space_item']").val(),
            annual_id =$("input[name='annual_id']").val(),
            auth_token =$("input[name='auth_token']").val();



        /*过滤必填项*/
        if(!company){
            alert('您的公司名称不能为空');
            return false;
        }
        if(!time){
            alert('年会时间不能为空');
            return false;
        }
        if(!event_type){
            alert('活动类型不能为空');
            return false;
        }
        if(!actPersons){
            alert('年会人数不能为空');
            return false;
        }
        if(!username){
            alert('您的称呼不能为空');
            return false;
        }
        if(!isMobile(phone)){
            alert('手机格式不正确');
            return false;
        }
        $('.js-submit').text('正在努力提交,请稍等^_^');
        //else{
        //    alert('提交成功')
        //}
        //console.log(username,phone,startTime,endTime,actPersons,compyname,eventtype);
        //return false;
        YunSpace.api('demand/create.jsonp', {
            username : username,
            phone :phone,
            start_date :startTime,
            end_date :endTime,
            people :actPersons,
            company :company,
            event_type :event_type,
            annual_id :annual_id,
            space_item :space_item,
            //auth_token:auth_token,
            action : 'annual_meeting_package'
        }, function (data) {
            if (data.status == 1) {
                //$("input[name='time']").val('');
                //$("input[name='username']").val('');
                //$("input[name='telphone']").val('');
                //$("input[name='yzcode']").val('');
                //$("#peoplenumbs").text('');
                //$("#yzm_captcha").show();
                //$('.btnyzcode').hide();
                $('.js-submit').text('提交');
                top.alert(data.msg);
                $('.onekeyorder').addClass('hide');
                $('.pop-mask').addClass('hide');
            } else {
                $('.js-submit').text('提交');
                top.alert(data.msg);
            }
        });


    });

    //空间详情导航悬浮
    var hTitle=$('.spacedtl .title');
    var offtop = [];
    hTitle.each(function(){
        var h3=$(this).offset().top;
        offtop.push(h3)
    });

    console.log(offtop)

    $(document).on('scroll',function(){
        var docScrollTop=$(document).scrollTop();
        var h1=$('.hot-location').outerHeight();
        var h2=$('.spacetop').outerHeight();
        var topH=h1+h2;
        if(docScrollTop>topH){
            $('.navlist').addClass('col-md-9 col-xs-9 position');
            $('.orderbtn').addClass('col-md-3 col-xs-3 position');
        }else{
            $('.navlist').removeClass('col-md-9 col-xs-9 position');
            $('.orderbtn').removeClass('col-md-3 col-xs-3 position');
        }

        for(var i = 0;i<offtop.length;i++){
            if(docScrollTop < offtop[i+1] && docScrollTop >= offtop[i]-200){
                $('.navlist  li').removeClass('current');
                $('.navlist  li').eq(i).addClass('current');
                //console.log(hTitle[i])
                console.log(i)
            }
            if(docScrollTop > offtop[offtop.length -1]-200){
                $('.navlist  li').removeClass('current');
                $('.navlist  li').eq(i).addClass('current');
            }
        }

    });
    //定位
    $('.navlist li').on('click',function(){
        $('.navlist li').removeClass('current');
        $(this).addClass('current');

        var id = $(this).data('id');
        if($("#"+id).length>0){
            $("html,body").animate({scrollTop:$("#"+id).offset().top},500);
        }
    });

    //弹窗
    function setPopForm(){
        //关闭背景遮罩
        function closemask(){
            $('.pop-mask').addClass('hide');
        }
        //关闭弹窗
        function closepop(){
            $('.onekeyorder').addClass('hide');
        }
        //打开背景遮罩
        function openmask(){
            $('.pop-mask').removeClass('hide');
        }
        //打开弹窗
        function openpop(){
            $('.onekeyorder').removeClass('hide');
        }

        $('.js-showform').on('click',function(){
            //console.log($(this).attr('data-id'),$(this).attr('data-space_name'));
            //return false;
            openpop();
            openmask();
            $('.onekeyorder').find("input[name='space_item']").val($(this).attr('data-space_name'));
            $('.onekeyorder').find("input[name='annual_id']").val($(this).attr('data-id'));
        })
        $('.js-close').on('click',function(){
            closepop();
            closemask();
        });
    }
    setPopForm();

});