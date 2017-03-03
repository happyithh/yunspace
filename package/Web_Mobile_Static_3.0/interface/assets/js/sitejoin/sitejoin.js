var win=$(window);
$("#head").on("click",function(){
    var initScroll=$(window).scrollTop(),
        wrapperScrollTop=$("#wrapper1").offset().top;
    var t=setInterval(function(){
        if(initScroll>=wrapperScrollTop){
            clearInterval(t);
            return;
        };
        initScroll+=50;
        win.scrollTop(initScroll);
    },1);
});