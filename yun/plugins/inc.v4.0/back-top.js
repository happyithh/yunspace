var plugin={
    nodes:{},
    init:function(){
        var that=this;
        that.nodes={
            backTop:$(".back-top"),
            win:$(window)
        };
        getScroll();
        that.nodes.win.on('scroll',function(){
            getScroll();
        });
        that.backTop();
        function getScroll(){
            var st=$(window).scrollTop();
            if(st>=600){
                that.nodes.backTop.removeClass('none');
            }else{
                that.nodes.backTop.addClass('none');
            }
        }
    },
    backTop:function(){
        var that=this;
        that.nodes.backTop.on("touchend",function(){
            var st=that.nodes.win.scrollTop();
            var scrollTime=setInterval(function(){
                that.nodes.win.scrollTop(st-=100);
                if(st<=0){
                    clearInterval(scrollTime);
                }
            },10);
        })
    }
}