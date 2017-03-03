/**
 * Created by pzl on 16/4/27.
 */
/**
 * Created by pzl on 16/4/25.
 */
(function($,win,doc){
    var $$={
        spaceImg:$(".space-img"),
        soJoin:$(".so-join"),
        companyJoin:$(".step-content"),
        win:$(win),
        body:$('body'),
        submit:$("#join"),
        error:$(".error"),
        double:$(".double"),
        successCase:$(".success-case"),
        joinTip:$(".join-tip")
    };
    $$.spaceImg.each(function(index,dom){
        var $dom=$(dom);
        $dom.FadeSlide({
            speed:500,
            delay:5000
        })
    });
    $$.soJoin.on('click',function(){
        var $this=$(this),
            offsetT=$$.companyJoin.offset().top,
            winH=$$.win.height(),
            winOffH=$$.win.scrollTop();
        ch=$$.companyJoin.height();
        var t=setInterval(function(){
            var st=$$.win.scrollTop();
            if(st>=offsetT){
                clearInterval(t);
            }
            winOffH+=10;
            $$.win.scrollTop(winOffH);
        },1);
    });
    var err=false;
    $$.submit.on("click",function(){
        err=false;
        $$.error.removeClass("error-active");
        $(".form").find('input').each(function(index,dom){
            if(err)return;
            var $dom=$(dom);
            var type=$dom.data('type'),
                val=$dom.val(),
                error=$dom.data('error')
            switch(type){
                case "number":
                    if(parseInt(val)<0||val==""){
                        alertError(error);
                        err=true;
                        return;
                    }
                    break;
                case 'phone':
                    var exp=/^(0|86|17951)?(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$/;
                    if(!exp.test(val)){
                        alertError(error);
                        err=true;
                        return ;
                    }
                    break;
                default:
                    if(val==""){
                        alertError(error);
                        err=true;
                        return ;
                    }
            }
        })
        if(!err){
            //没报错ajax请求
            var company=$("input[name='company']").val(),
                brand=$("input[name='pinpai']").val(),
                mode=$("input[name='method']").val(),
                number=$("input[name='shop_num']").val(),
                contacts=$("input[name='username']").val(),
                phone=$("input[name='join_phone']").val();
            YunSpace.api('cooperation/brand/form/submit.jsonp',{
                company:company,
                brand:brand,
                mode:mode,
                number:number,
                contacts:contacts,
                phone:phone
            },function(data){
                $$.joinTip.text(data.msg).show().fadeOut(5000);
            })
        }
    });
    $$.double.find('span').each(function(i,o){
        $(o).hover(function(){
            $$.double.find('span').removeClass('tab-active');
            $(this).addClass("tab-active");
            $$.successCase.addClass('none');
            $$.successCase.eq(i).removeClass('none');
        },function(){});
    });

    var mySwiper = new Swiper('.swiper-container',{
        slidesPerView : 5,
        autoplay : 3000,
        prevButton:'.swiper-button-prev',
        nextButton:'.swiper-button-next',
        loop : true,
        autoplayDisableOnInteraction : false,
    })

    function alertError(message){
        $$.error.text(message).addClass("error-active");
    }

})(jQuery,window,document);
