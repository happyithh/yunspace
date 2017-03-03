$(function(){

    //首页入口图片变宽动画
    //$('.topic-entrance li').on('mouseenter',function(){
    //    $(this).stop().animate({'width':'34%'},500);
    //    $(this).siblings().stop().animate({'width':'22%'},500);
    //});
    //$('.topic-entrance li').on('mouseleave',function(){
    //    $('.topic-entrance li').stop().animate({'width':'25%'},500);
    //});

    var handler = function (captchaObj) {
        // 将验证码加到id为captcha的元素里
        captchaObj.bindOn("#yzm_captcha");
        captchaObj.onReady(function(){
            var elements_n = $('.gt_holder');
            if (elements_n.length > 0) {
                elements_n.first().css({ 'z-index' : 10 });
            }
            var elements = $('.gt_mask');
            if (elements.length > 0) {
                elements.first().css({ 'z-index' : 500 });
            }
        });
        captchaObj.onSuccess(function(){
            $("#yzm_captcha").hide();
            $(".btnyzcode").show();
        });
        captchaObj.appendTo("#captcha");
    };
    YunSpace.api("common/start/cs.json?rand="+Math.round(Math.random()*100),{
    },function(data){
        initGeetest({
            gt: data.gt,
            challenge: data.challenge,
            product: "popup", // 产品形式
            offline: !data.success
        }, handler);
    })
    //$.ajax({
    //    // 获取id，challenge，success（是否启用failback）
    //    url:"http://{Core::$urls['host']}/static/api/common/start/cs.json?rand="+Math.round(Math.random()*100),
    //    type: "get",
    //    dataType: "json", // 使用jsonp格式
    //    success: function (data) {
    //        // 使用initGeetest接口
    //        // 参数1：配置参数，与创建Geetest实例时接受的参数一致
    //        // 参数2：回调，回调的第一个参数验证码对象，之后可以使用它做appendTo之类的事件
    //        initGeetest({
    //            gt: data.gt,
    //            challenge: data.challenge,
    //            product: "popup", // 产品形式
    //            offline: !data.success
    //        }, handler);
    //    }
    //});
    /*下拉框*/
    $(".select>p").on("click",function(e){
        $(".select").toggleClass("open");
        e.stopPropagation();
    });

    $(".select ul li").on("click",function(e){
        $(this).addClass("selected").siblings().removeClass("selected");
        $(".select>p").text($(this).text());
        $(".select").removeClass("open");
        e.stopPropagation();
    });
    $(document).on("click",function(){
        $(".select").removeClass("open");
    });
    $('.metformul>li').on('click',function(){
        $(this).find('input').focus();
    });

    // banner轮播

    var initialSlide = 0;
    var url = window.location.href;
    function addani(){
        $('.swiper-container').addClass('ani-from-above');
        $('.move-to-top').addClass('ani-from-abelow');
    }
    function removeani(){
        $('.swiper-container').removeClass('ani-from-above');
        $('.move-to-top').removeClass('ani-from-abelow');
    }
    function GetQueryString (name){
        var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
        var r = window.location.search.substr(1).match(reg);
        if(r!=null)return  unescape(r[2]);
        return '';
    };
    var p = GetQueryString('p');
    if($("#"+p).length>0){
        $("html,body").animate({scrollTop:$("#"+p).offset().top},750);
    }

    if(url.indexOf('largesize') > -1){
        initialSlide = 0;
        //removeani();
        //addani();
    }
    if(url.indexOf('midsize') > -1){
        initialSlide = 1
        //removeani();
        //addani();

    }
    if(url.indexOf('creative') > -1){
        initialSlide = 2
        //removeani();
        //addani();
    }
    if(url.indexOf('nationsize') > -1){
        initialSlide = 3
        //removeani();
        //addani();
    }

    var swiper = new Swiper('.swiper-container', {
        pagination: '.swiper-pagination',
        initialSlide :initialSlide,
        paginationClickable: true,
        nextButton: '.yun-swiper-next',
        prevButton: '.yun-swiper-prev',
        loop:true,
        autoplay : 4000,
        autoplayDisableOnInteraction :false,
        paginationBulletRender: function (index, className) {
            return '<span class="' + className + '">' + (index + 1) + '</span>';
        }
    });

    /*侧边显示/隐藏、返回顶部*/
    $(document).on('scroll',function(){
        var docScrollTop=$(document).scrollTop();
        var Hnav=$('.sidenav').height();
        if(docScrollTop>700){
            $('.sidenav').css({
                'position':'fixed',
                'top':20
            });
            $('.sidefu').removeClass('hide');
            $('.sidefu').css({
                'top':Hnav+30
            });
        }else{
            $('.sidenav').css({
                'position':'absolute',
                'top':700
            });
            $('.sidefu').addClass('hide');
        }
    });
    $('.js-backtop').on('click',function(){
        $('body,html').animate({scrollTop:0},1000);
        return false;
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
    /*验证码*/
    $('.btnyzcode').on('click',function(){
        var nmb=60;
        var $this=$(this);
        var phone= $("input[name='telphone']").val().replace(/ /g,'');
        if(!isMobile(phone)){
            top.alert('手机格式不正确');
            return false;
        }
        $this.addClass('bggray');
        $this.attr('disabled',true);
        var settime=setInterval(function(){
            nmb--;
            var str='('+nmb+')'+'秒后重新发送';
            $this.text(str);
            if(nmb<1){
                str='重新发送';
                clearInterval(settime);
                $this.removeClass('bggray');
                $this.text(str);
                $this.attr('disabled',false);
                $("#yzm_captcha").show();
                $this.hide();
            }

        },1000);
        //console.log(phone,$('.geetest_challenge').val(),$('.geetest_validate').val(),$('.geetest_seccode').val());
        //return false;
        YunSpace.api("common/send/auth/code.jsonp",{
            phone: phone,
            geetest_challenge: $('.geetest_challenge').val(),
            geetest_validate: $('.geetest_validate').val(),
            geetest_seccode: $('.geetest_seccode').val()
        },function(data){
            console.log(data.msg);
        })
    });
    $('.js-submit').on('click',function(){
        var time=$("input[name='time']").val();
        var username = $("input[name='username']").val().replace(/ /g,''),
            phone= $("input[name='telphone']").val().replace(/ /g,''),
            startTime= time.substr(0,10),
            endTime= time.substr(time.length-10),
            actPersons=$("#peoplenumbs").text(),
            yzcode=$("input[name='yzcode']").val().replace(/ /g,'');

        /*过滤必填项*/
        if(!username){
            alert('您的称呼不能为空');
            return false;
        }if(!time){
            alert('年会时间不能为空');
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
        //console.log(username,phone,startTime,endTime,actPersons,$('.geetest_challenge').val(),$('.geetest_validate').val(),$('.geetest_seccode').val());
        //return false;
        YunSpace.api('demand/create.jsonp', {
            username : username,
            phone :phone,
            start_date :startTime,
            end_date :endTime,
            people :actPersons,
            auth_code:yzcode,
            action : 'annual_meeting'
        }, function (data) {
            if (data.status == 1) {
                $("input[name='time']").val('');
                $("input[name='username']").val('');
                $("input[name='telphone']").val('');
                $("input[name='yzcode']").val('');
                $("#peoplenumbs").text('');
                $("#yzm_captcha").show();
                $('.btnyzcode').hide();
                $('.js-submit').text('提交');
                top.alert(data.msg);
            } else {
                $('.js-submit').text('提交');
                top.alert(data.msg);
            }
        });
        //$.ajax({
        //    type: "post",
        //    url: "http://{$hone}/static/api/demand/create.jsonp",
        //    data: {
        //
        //    },
        //    success: function(data){
        //
        //    }
        //
        //});

    });
});