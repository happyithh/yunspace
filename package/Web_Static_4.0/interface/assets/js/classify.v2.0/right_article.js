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
        classifyRt:$(".classify_rt"),
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
            },
            /*
            * scroll事件及初始化
            * */
            doScroll:function(o){
                var classifyFlOneHeight=$$.classifyFl1.outerHeight(),
                    classifyFlHeight=$$.classifyFl.outerHeight(),
                    classifyRtH2=$$.classifyRt.outerHeight(),
                    winScrTop=o.scrollTop(),
                    wh=$(window).height(),ws=$(window).scrollTop(),
                    footerOutsideTop=$$.classifyLoadMore.offset().top;
                if($$.classifyFl.length>0&&classifyFlHeight<=classifyRtH2){
                    return;
                }
                if($$.classifyFl1.length>0&&classifyFlOneHeight<=classifyRtH2){
                    var classifyRtHInfo= $$.classifyRt.outerHeight(),
                        classifyRtTInfo=$$.classifyRt.offset().top,
                        articleLeftGuideT=$$.articleLeftGuide.offset().top,
                        articleLeftGuideH=$$.articleLeftGuide.height();
                    if(winScrTop+articleLeftGuideT-180>=classifyRtTInfo+classifyRtHInfo){
                        if(!shareFix)return;
                        shareFix=false;
                        $$.articleLeftGuide.addClass('article_left_guide_absolute').removeClass('article_left_guide_fixed').css({
                            top:winScrTop+86+'px',
                        })
                    }else{
                        if(shareFix)return;
                        shareFix=true;
                        $$.articleLeftGuide.removeClass('article_left_guide_absolute').addClass('article_left_guide_fixed').css({
                            top:"100px"
                        });
                    }
                    return;
                }
                 //var wh=$(window).height(),ws=$(window).scrollTop(),
                 //   footerOutsideTop=$$.classifyLoadMore.offset().top;
                //if($$.classifyFl1.length>0&&!scrollfixed){
                //    winScrTop-=100;
                //}
                if(ws>classifyH ){
                    scrollAbsolute=false;
                    var classifyRtH=$$.classifyRt.height(),
                        newArtH=$$.newArticles.height()+55,
                        fixedRtImgH=$$.fixedRtImg.height()+30,
                        classifyOffTop=$$.classifyRt.offset().top;
                    if(ws+newArtH+fixedRtImgH+250>footerOutsideTop){
                        if(bottomAbs==true)return;
                        bottomAbs=true;
                        scrollfixed=false;
                        $$.classifyRt.addClass("classify_rt_absolute").removeClass('fixed');
                        f.t=$$.fixedRtIcon.offset().top;
                        $(".js-action").addClass('classify_left_guide_absolute').removeClass('classify_left_guide_fixed').css({
                            top:f.t+"px"
                        });
                       $$.articleLeftGuide.addClass('article_left_guide_absolute').removeClass('article_left_guide_fixed').css({
                           top:f.t+"px"
                        })
                    }else{
                        $(win).on('resize',function(){
                            f.rightFix($(this));
                        });
                        if(scrollfixed)return;
                        scrollfixed=true;
                        scrollAbsolute=false;
                        bottomAbs=false;
                        f.rightFix($(win));
                        $$.classifyRtImg.addClass('none');
                        $$.classifyRt.addClass("fixed").removeClass('classify_rt_absolute');
                        $$.fixedRtImg.removeClass('none').addClass('transition');
                        f.t=$$.fixedRtIcon.offset().top-30;
                        $(".js-action").removeClass('classify_left_guide_absolute').addClass('classify_left_guide_fixed').css({
                            top:f.t+"px"
                        });
                        $$.articleLeftGuide.removeClass('article_left_guide_absolute').addClass('article_left_guide_fixed').css({
                            top:"100px"
                        });
                        setTimeout(function(){
                            $$.fixedRtImg.addClass("fixed-rt-img-active");
                        },1);
                    }
                }else{
                    if(scrollAbsolute)return;
                    scrollAbsolute=true;
                    scrollfixed=false;
                    $$.classifyRt.removeClass("fixed");
                    $$.classifyRtImg.removeClass('none');
                    $$.fixedRtImg.addClass('none').removeClass('fixed-rt-img-active');
                    f.t=$$.fixedRtIcon.offset().top-30;
                    $(".js-action").removeClass('classify_left_guide_absolute').addClass('classify_left_guide_fixed').css({
                        top:f.t+"px"
                    });
                    $$.articleLeftGuide.removeClass('article_left_guide_absolute').addClass('article_left_guide_fixed').css({
                        top:"100px"
                    });
                }

            }
        };
    //$$.classifyRt.addClass("fixed").removeClass('transition');
    //var sriScrollTop=$$.classifyRtImg.offset().top,
    var classifyH=$$.classifyRtImg.height(),
        scrollAbsolute=false,
        scrollfixed=false;
        bottomAbs=false,
        shareFix=true;
    //f.doScroll($(window));
    $(win).on('scroll',function(){
        f.doScroll($(this));
    });
    f.showLink($$.fixedRtIcon);
    f.showLink($$.smallIconList);
    $$.fixedRtImg.hover(function(){
        $$.smallIconList.addClass('small-icon-list-active');
    },function(){
        $$.linkTrue.removeClass("link-img-active");
        $$.smallIconList.removeClass('small-icon-list-active');
    });
})(jQuery,window,document);
