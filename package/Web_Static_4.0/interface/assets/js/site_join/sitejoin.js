
$(document).ready(function(){
    $('#Space').hover(function(){
        $('#spaceContent').css('display', 'block');
    },function(){
        $('#spaceContent').css('display', 'none');
    });
    $('#spaceContent li').hover(function(){
        $('#spaceContent').css('display', 'block');
    },function(){
        $('#spaceContent').css('display', 'none');
    });
    $('#winchance').hover(function(){
        $('#winchanceContent').css('display', 'block');
    },function(){
        $('#winchanceContent').css('display', 'none');
    });
    $('#winchanceContent li').hover(function(){
        $('#winchanceContent').css('display', 'block');
    },function(){
        $('#winchanceContent').css('display', 'none');
    });

    $("#joinbtn").on("click",function(){
        $("html,body").animate({
            scrollTop:$("#wrapper1").offset().top
        },1000);
    });
    $('.j-login-app').click(function(){
        $('#j-login-app').toggleClass('none');
        $('#j-login-pc').toggleClass('none');
    });
    $('.j-login-pc').click(function(){
        $('#j-login-app').toggleClass('none');
        $('#j-login-pc').toggleClass('none');
    });

    setInterval(function(){
        $('.fei-word-back').addClass('fei-word');
        setTimeout(function(){
            $('.fei-word-back').removeClass('fei-word');
        },1000)
    },5000)
});
//var win=$(window);
//$("#head").on("click",function(){
//    var initScroll=$(window).scrollTop(),
//        wrapperScrollTop=$("#wrapper1").offset().top;
//    var t=setInterval(function(){
//        if(initScroll>=wrapperScrollTop){
//            clearInterval(t);
//            return;
//        };
//        initScroll+=50;
//        win.scrollTop(initScroll);
//    },1);
//});