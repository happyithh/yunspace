/**
 * Created by pzl on 16/5/23.
 */
$(document).ready(function () {
    window.onload=function(){
        $(window).scrollTop(0);
    }
    $('.article_inside_content').find('p').eq(0).css({marginBottom:"0px"});
    var conW = $(".container").width();
    fixShare();
    var wh=$(window).height(),ws;
    $(window).on('resize', function () {
        wh=$(window).height();
        fixShare();
    });
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
        articleLeftGuide:$(".article_left_guide"),
        footerOutside:$(".footer-outside")
    };
    function fixShare() {
        var winW = $(window).width();
        var left = (winW - conW) / 2;
        var zw = $(".article_left_guide").width();
        if(winW>=conW){
            $(".article_left_guide").css({
                left: left + "px",
                display: "block"
            });
            //$('.to-top').css({
            //    right: right + "px",
            //})
        }else{
            $(".article_left_guide").css({
                left: "0px",
                display: "block"
            });
            //$('.to-top').css({
            //    right: "0px",
            //})
        }
    }
    function toTop(){
        $(window).on("scroll",function(){
            ws=$(this).scrollTop();
            wh=$(this).height();
            if(ws>wh){
                if(!$('.to-top').hasClass('none'))return;
                $('.to-top').removeClass('none');
            }else{
                if($('.to-top').hasClass('none'))return;
                $('.to-top').addClass('none');
            }
        });
        $('.to-top').on('click',function(){
            var winOffH=$(window).scrollTop();
            var t=setInterval(function(){
                var st=$(window).scrollTop();
                if(st<=0){
                    clearInterval(t);
                }
                winOffH-=100;
                $(window).scrollTop(winOffH);
            },1);
        });
    }
    toTop();
    $(".classify_rt_img").find('a').each(function (index, dom) {
        var $dom = $(dom);
        $dom.children().addClass('none').find('.right_icon_img').removeClass('none');
        $dom.find('.right_icon').removeClass('none');
    });
    /**
     * 详情页加载更多
     */
    var articleInsideLoadMore=$("#article_inside_load_more");
    var initPath=window.location.pathname.split('/').pop();
    var initId=initPath.substring(0,initPath.indexOf("."));
    var initOff=$("#art_"+initId).offset().top,initH=$("#art_"+initId).height();

    var classifyH=$$.classifyRtImg.height();
    var loaded=false,
        footerOutsideOffset=$$.footerOutside.offset().top,
        wh=$(window).height(),
        urlArr=[{offset:initOff,id:initId,height:initH,change:false}],
        temId;
    //console.log(footerOutsideOffset);
    var isRunOne=null,isRunTwo=null;
    $(window).on('scroll',function(){
        var ws=$(this).scrollTop();
        //console.log(ws+wh<footerOutsideOffset,loaded,isRunOne,isRunTwo);
        if(ws+wh<footerOutsideOffset||loaded==true||isRunOne||isRunTwo){
            return;
        }
        loaded=true;
        //var page = articleInsideLoadMore.attr('data-page');
        var load_src = articleInsideLoadMore.attr('data-src');
        var _id = articleInsideLoadMore.attr('data-id');
        isRunOne=setTimeout(function(){
            //获取next id
            YunSpace.api('Raiders/GetNextArticle.json', {
                id:_id,
                category_id: $("#article_all").attr('data-category')
            }, function (data) {
                if (data.status == 1) {
                    temId=data.data.id;
                    articleInsideLoadMore.attr('data-id',data.data.id);
                    var token_part1 = $('.token_part1').val();
                    var token_part2 = $('.token_part2').val();
                    var token_part3 = $('.token_part3').val();
                    var token = token_part1+token_part2+token_part3;
                    if(!token){
                        return false;
                    }
                    $.ajax({
                        type: "get",
                        url: window.location.href,
                        data: {
                            action:'page_content_load_more',
                            token: token,
                            ysp_id: data.data.id
                        },
                        dataType: "html",
                        success: function (htm) {
                            var article={offset:"",id:"",height:"",title:""};
                            $("#article_all").append(htm);
                            setTimeout(function(){
                                footerOutsideOffset=$$.footerOutside.offset().top;
                                loaded=false;
                                isRunOne=null;
                                isRunTwo=null;
                                //console.log(loaded,isRunOne,isRunTwo)
                            },1000);
                            //图片加载完毕之后回调函数
                            //var callback = function(){
                            //
                            //};
                            //var imgList = $(htm).find('img');
                            //
                            //var check = (function(count, fn){
                            //    return function(){
                            //        count--;
                            //        if(count == 0){
                            //            fn();
                            //        }
                            //    };
                            //})(imgList.length, callback);
                            //
                            //imgList.each(function(){
                            //    $(this).bind('load', check)
                            //        .attr("src", $(this).attr('src'));
                            //});

                            $(".classify_rt").addClass('fixed');
                            var ws=$(window).scrollTop();
                            if(ws<classifyH){
                                $(".classify_rt").removeClass('fixed');
                            }
                            if($(".classify_rt").hasClass('fixed')){
                                $$.classifyRtImg.addClass('none');
                                $(".classify_rt").removeClass('classify_rt_absolute');
                                $$.fixedRtImg.removeClass('none').addClass('transition');
                                rightFix();
                                $$.articleLeftGuide.removeClass('article_left_guide_absolute').addClass('article_left_guide_fixed').css({
                                    top:"100px"
                                });
                                isRunTwo=setTimeout(function(){
                                    $$.fixedRtImg.addClass("fixed-rt-img-active");
                                },1);
                            }
                            //console.log(footerOutsideOffset);
                            var appHtmTop=$("#art_"+temId).offset().top,
                                appHtmHeight=$("#art_"+temId).height();
                            article.offset=appHtmTop;
                            article.id=temId+"";
                            article.height=appHtmHeight;
                            article.change=false;
                            article.title=$("#art_"+temId).text();
                            urlArr.push(article);
                            handleChangeUrl()
                        }
                    });
                }else{
                    articleInsideLoadMore.text('已加载全部!!').css({lineHeight:"40px"});
                }
            });
        },2000);
    });
    var containerWidth=$$.container.width();
    function rightFix(){
        var ww=$(window).width();
        if(containerWidth<ww){
            $$.classifyRt.css({
                right:(ww- containerWidth)/2+"px"
            });
        }else{
            $$.classifyRt.css({
                right:"-"+(containerWidth-ww)+"px"
            });
        }

    }
    function handleChangeUrl(){
        $(window).on('scroll',function(){
            var ws=$(this).scrollTop();
            for(var k in urlArr){
                changeUrl(ws,k);
            }
        });
    }
    function changeUrl(ws,key){
        var stateObj = { foo: "bar" };
        var winH=$(window).height();
        if(ws+winH>urlArr[key].offset&&ws<=(urlArr[key].offset+parseInt(urlArr[key].height))){
            if(urlArr[key].change==true){
                return;
            }
            urlArr[key].change=true;
            window.history.pushState(stateObj, "page 2", urlArr[key].id+".html");
            changeTitle(urlArr[key].title);
        }else{
            urlArr[key].change=false;
        }
    }

    function changeTitle(title){
        $("title").text(title);
    }
})
