/**
 * Created by pzl on 16/4/5.
 */
var plugin={
    $$:{},
    initWindowHeight:"",
    init:function(){
        this.$$={
            input:$(".input"),
            dataOne:$("#data-one"),
            dataTwo:$("#data-two"),
            dataThree:$("#data-three"),
            dataImg:$("#data-img"),
            goodList:$(".good-list"),
            superList:$(".super-list"),
            fixPart:$(".fix-part"),
            quickJoin:$("#quick-join")
        };
        this.inputFocus()
            .changeData()
            .showChart()
            .showGood()
            .showSuper()
            .toBottom();
        $(window).scrollTop(0);
        this.initWindowHeight=$(window).height();
        //var _self=this;
        //$(window).on("resize",function(){
        //    var wh=$(this).height();
        //    if(wh<_self.initWindowHeight){
        //        _self.$$.fixPart.addClass('none');
        //    }else{
        //        _self.$$.fixPart.removeClass('none');
        //    }
        //});
        //$("input").on("focus",function(){
        //    _self.$$.fixPart.addClass('none');
        //})
    },
    inputFocus:function(){
        var _self=this;
        _self.$$.input.each(function(index,dom){
            var $dom=$(dom);
            $dom.on("touchend",function(e){
                $(this).find("input").focus();
                $(document).find(".dot").remove();
                _self.$$.input.removeClass("p-active bg-active");
                if($(this).find('.dot').length>0){
                    return ;
                }
                var left = e.target.clientWidth;
                var top = e.target.clientHeight;
                $dom.addClass("p-active");
                $(this).append('<div class="dot" style="top:' + top + 'px;left:' + left + 'px;"></div>')
                setTimeout(function () {
                    $dom.addClass("bg-active");
                    _self.$$.input.find(".dot").remove();
                }, 200);
            })
        });
        return _self;
    },
    changeData:function(){
        var _self=this;
        var userA=navigator.userAgent;
        var isUserA="Android"||"iPhone";
        _self.showData(_self.$$.dataOne,"+",5);
        if(navigator.userAgent.indexOf(isUserA)==-1){
            _self.showDataTwo();
        }
        $(window).on("scroll",function(){
            _self.showData(_self.$$.dataThree,"",5);
            _self.showDataTwo();
        });
        return _self;
    },
    showDataTwo:function(){
        var _self=this;
        _self.$$.dataTwo.find(".data-p1").each(function(index,dom){
            var $dom=$(dom);
            switch(index){
                case 0:
                    _self.showData($dom,"万+",1);
                    break;
                case 1:
                    _self.showData($dom,"+",100);
                    break;
                case 2:
                    _self.showData($dom,"万+",1);
                    break;
                case 3:
                    _self.showData($dom,"万+",1);
                    break;
            }
        });
    },
    showData:function(o,str,step){
        if(o.length==0)return;
        var offY=o.offset().top;
        var winH=$(window).height();
        var scrollTop=$(window).scrollTop();
        if((scrollTop+winH)>=offY) {
            var num = o.data('num');
            var text = parseInt(o.text());
            var t = setInterval(function () {
                if (text >= num) {
                    clearInterval(t);
                    return
                }
                text += step;
                o.text(text + str);
            }, 20);
        }
    },
    showChart:function(){
        var _self=this;
        $(window).on("scroll",function(){
            if(_self.$$.dataImg.length==0)return;
            var offY=_self.$$.dataImg.offset().top;
            var winH=$(window).height();
            var scrollTop=$(window).scrollTop();
            if((scrollTop+winH)>=offY) {
                _self.$$.dataImg.find("li").each(function(index,dom){
                    var $dom=$(dom);
                    $dom.addClass("active");
                })
            }
        });
        return _self;
    },
    showGood:function(){
        var _self=this;
        $(window).on("scroll",function(){
            _self.$$.goodList.find("li").each(function(index,dom){
                var $dom=$(dom);
                var offY=$dom.offset().top;
                var winH=$(window).height();
                var scrollTop=$(window).scrollTop();
                if((scrollTop+winH)>=offY) {
                    $dom.addClass("active");
                }
            })

        });
        return _self;
    },
    showSuper:function(){
        var _self=this;
        $(window).on("scroll",function(){
            _self.$$.superList.find("li").each(function(index,dom){
                var $dom=$(dom);
                var offY=$dom.offset().top;
                var winH=$(window).height();
                var scrollTop=$(window).scrollTop();
                if((scrollTop+winH)>=offY) {
                    $dom.addClass("active");
                }
            })

        });
        return _self;
    },
//    立即报名
    toBottom:function(){
        var _self=this;
        _self.$$.quickJoin.on("touchend",function(){
            var win=$(window),body=$("body");
            var bodyH=body.height();
            var winH=win.height();
            var initScroll=win.scrollTop();
            var t=setInterval(function(){
                if(initScroll+winH>=bodyH){
                    clearInterval(t);
                    return;
                };
                initScroll+=100;
                win.scrollTop(initScroll);
            },1);
        });
    }
}
