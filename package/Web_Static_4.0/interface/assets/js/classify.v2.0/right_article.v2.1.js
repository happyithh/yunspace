/**
 * Created by pzl on 16/5/19.
 */
/*
 * @$ jquery对象
 * @win window对象
 * @doc document对象
 * */
(function($,win,doc){

    //dom对象
    var $$={
        //classifyRt:$(".classify_rt1"),
        classifyFl1:$(".classify_fl1"),
        classifyFl:$(".classify_fl"),
        container:$(".container"),
        classifyRtImg:$(".classify_rt_img "),
        fixedRtImg:$(".fixed-rt-img"),
        linkTrue:$(".link-true"),
        fixedRtIcon:$(".fixed-rt-icon "),
        smallIconList:$(".small-icon-list"),
        classifyLoadMore:$(".load_more"),
        newArticles:$(".new_articles"),
        articleLeftGuide:$(".article_left_guide")
    };
    var f={
        containerWidth:$$.container.width(),
        t:"",
        /*
         * 右侧浮动
         * */
        rightFix:function(o){
            var ww=$(o).width();
            if(f.containerWidth<ww){
                $$.classifyRt.css({
                    right:(ww- f.containerWidth)/2+"px"
                });
            }else{
                $$.classifyRt.css({
                    right:"-"+(f.containerWidth-ww)+"px"
                });
            }

        },
        /*
         * 显示小图片
         * */
        showLink:function(o){
            o.find('li').each(function(index,dom){
                var $dom=$(dom);
                $dom.hover(function(){
                    $$.linkTrue.removeClass("link-img-active");
                    $$.linkTrue.eq(index).addClass("link-img-active");
                    $$.smallIconList.find('li').removeClass('small-icon-active');
                    $$.smallIconList.find('li').eq(index).addClass('small-icon-active');
                },function(){});
            });
        }

    };

    f.showLink($$.fixedRtIcon);
    f.showLink($$.smallIconList);
    $$.fixedRtImg.hover(function(){
        $$.smallIconList.addClass('small-icon-list-active');
    },function(){
        $$.linkTrue.removeClass("link-img-active");
        $$.smallIconList.removeClass('small-icon-list-active');
    });


    $('.classify_right_article_title').click(function(){
        $(this).parent().siblings().find('.classify_right_article_title').removeClass('classify_right_article_down');
          $(this).next().slideToggle("fast");
        $(this).toggleClass('classify_right_article_down');
        $(this).parent().siblings().find(".classify_right_article_content").hide();
    });



    var fixed=false;
    var crh=$(".classify_rt1").height(),srst=$(".classify_rt1").offset().top;
    window.onscroll=function(){
        var scrollTop=document.documentElement.scrollTop||document.body.scrollTop;
        if(scrollTop>crh+srst){
            if(fixed==true)return;
            fixed=true;
            $('.fixed-rt-img').addClass("fixed-rt-img-active");
            $('.classify_right_bottom').addClass("classify_right_bottom_active");
        }else{
            if(fixed==false)return;
            fixed=false;
            $('.fixed-rt-img').removeClass("fixed-rt-img-active");
            $('.classify_right_bottom').removeClass("classify_right_bottom_active");
        }
    }

})(jQuery,window,document);
