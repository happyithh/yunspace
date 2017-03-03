/**
 * Created by pzl on 15/10/26.
 */
var plugin={
    imgScroll:[],
    imgBool:[],
    imgSrc:[],
    init:function(){
        var __self=this;
        $("img[data-lazy='true']").each(function(index,dom){
            __self.imgScroll[index]=$(dom).offset().top;
            __self.imgSrc[index]=$(dom).attr("data-src");
        });
        __self.loadImg();
    },
    loadImg:function(){
        var __self=this;
        var winScr,winH=$(window).height();
        var maxSrc=__self.imgScroll[0];
        var l=  $("img[data-lazy='true']").length;
        for(var k=0;k<l;k++){
            if(maxSrc<=__self.imgScroll[k])
                maxSrc=__self.imgScroll[k];
        }
        $(window).on("scroll",function(){
            winScr=$(window).scrollTop();
            $("img[data-lazy='true']").each(function(index,dom){
                if(winScr+winH>=__self.imgScroll[index]+50&&winScr+winH<__self.imgScroll[index+1]){
                    if(__self.imgBool[index]==false){
                        return false;
                    }
                    $(dom).attr("src",__self.imgSrc[index]);
                    __self.imgBool[index]=false;
                }else if(winScr+winH>=maxSrc){
                    if(__self.imgBool[l-1]==false){
                        return false;
                    }
                    $("img[data-lazy='true']").last().attr("src",__self.imgSrc[l-1]);
                    __self.imgBool[l-1]=false;

                }
            })

        })
    }
}

