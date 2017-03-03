/**
 * Created by pzl on 16/9/12.
 */
(function(win,doc,$){
    var $$={
        dowebok:$('#dowebok'),
        jsPainterNumberOne:$(".js-painter-number-one"),
        jsPainterNumberTwo:$(".js-painter-number-two"),
        jsPainterNumberThree:$(".js-painter-number-three"),
        jsPainterNumberFour:$(".js-painter-number-four"),
        jsPainterNumberFive:$(".js-painter-number-five"),
        jsPainterNumberSix:$(".js-painter-number-six"),
        jsPainterNumberSeven:$(".js-painter-number-seven"),
        jsVsOne:$(".js-vs-one"),
        jsVsTwo:$(".js-vs-two"),
        jsDes:$(".js-des"),
        jsBgVs:$(".js-bg-vs"),
        jsDemandList:$(".js-demand-list"),
        jsFlow:$(".js-flow"),
        jsSupportList:$(".js-support-list"),
        jsSupDiv:$(".js-sup-div"),
        ourDes:$(".our-des"),
        painterJoin:$(".painter-join"),
        loaded:$("#loaded"),
        macScreen:$(".mac-screen"),
        section:$(".section")
    };
    var f={
        flagUp:true,
        flagDown:true,
        flag:true,
        init:function(){
            f.handleFullpage()
             .handlePainterLogo()
             .handleNumberTrends($$.jsPainterNumberOne,300,10,"+",5)
             .handleJoin();

        },
        handleFullpage:function(){
            $$.section.first().find("div").removeClass('none');
           var fullPage=$$.dowebok.fullpage({
                sectionsColor : ['#1bbc9b', '#4BBFC3', '#7BAABE', '#f90'],
                //continuousVertical: true,
                'navigation': true,
                easing:"easeOut",
                scrollingSpeed:700,
                menu:true,
                css3:true,
                onLeave:function(index,nextIndex,direction){
                    switch(nextIndex){
                        case 1:
                            f.handleNumberTrends($$.jsPainterNumberOne,300,10,"+",5);
                            break;
                        case 2:
                            f.handleEnterTwoPage();
                            break;
                        case 3:
                            f.handleEnterThreePage();
                            break;
                        case 4:
                            f.handleEnterFourPage();
                            break;
                        case 5:
                            f.handleEnterFivePage();
                            break;
                        case 6:
                            f.handleEnterSixPage();
                            break;
                        case 8:
                            f.handleEnterEightPage();
                            break;
                    }
                    switch(index){
                        case 1:
                            $$.jsPainterNumberOne.text("0+");
                            break;
                        case 2:
                            f.handleLeaveTwoPage();
                            break;
                        case 3:
                            f.handleLeaveThreePage();
                            break;
                        case 4:
                            f.handleLeaveFourPage();
                            break;
                        case 5:
                            f.handleLeaveFivePage();
                            break;
                        case 6:
                            f.handleLeaveSixPage();
                            break;
                        case 8:
                            f.handleLeaveEightPage();
                            break;
                    }
                },
               afterLoad:function(anchorLink,index){
                   //console.log(index,f.flagUp,f.flagDown);
                   $.fn.fullpage.setAllowScrolling();
                   window.onmousewheel = document.onmousewheel = scrollFunc;
               }
            });

            var scrollFunc = function (e) {
                setTimeout(function(){
                    f.flagUp=true;
                    f.flagDown=true;
                },500);
                e = e || window.event;
                if (e.wheelDelta) {  //判断浏览器IE，谷歌滑轮事件&&Math.abs(e.wheelDeltaY)>=30
                    var swy=e.wheelDeltaY;
                    if (e.wheelDelta > 0) { //当滑轮向上滚动时
                        if(!f.flagUp){return;}
                        f.flagUp=false;
                        $.fn.fullpage.moveSectionUp();
                    }
                    if (e.wheelDelta < 0) { //当滑轮向下滚动时
                        if(!f.flagDown){return;}
                        f.flagDown=false;
                        $.fn.fullpage.moveSectionDown();
                    }
                } else if (e.detail) {  //Firefox滑轮事件
                    var swy=e.detail;
                    if (e.detail> 0) { //当滑轮向上滚动时
                        if(!f.flagUp){return;}
                        f.flagUp=false;
                        $.fn.fullpage.moveSectionUp();
                    }
                    if (e.detail< 0) { //当滑轮向下滚动时
                        if(!f.flagDown){return;}
                        f.flagDown=false;
                        $.fn.fullpage.moveSectionDown();
                    }
                }
            }
            //window.onmousewheel = document.onmousewheel = scrollFunc;
            //setInterval(function(){
            //    $.fn.fullpage.moveSectionDown();
            //}, 3000);
            return f;
        },
        handlePainterLogo:function(){
            var mySwiper = new Swiper('.swiper-container',{
                slidesPerView : 4,
                slidesPerGroup : 1,
                loop:true,
                autoplay : 2000,
                autoplayDisableOnInteraction : false,
                prevButton:'.swiper-button-prev',
                nextButton:'.swiper-button-next',
            });
            return f;
        },
        handleNumberTrends:function(dom,maxNum,time,lastStr,step){
            var n1 = 0;
            var t1 = setInterval(function(){
                if(step){
                    n1+=step;
                }else{
                    n1++;
                }
                dom.text(n1+lastStr);
                if(n1>=maxNum){
                    clearInterval(t1);
                }
            },time);
            return f;
        },
        handleEnterTwoPage:function(){
            $$.macScreen.find("img").addClass("img-active");
            $$.loaded.css({opacity:0});
        },
        handleLeaveTwoPage:function(){
            $$.macScreen.find("img").removeClass("img-active");
            $$.loaded.css({opacity:1})
        },
        handleEnterThreePage:function(){
            f.handleNumberTrends($$.jsPainterNumberTwo,20,50,"");
            f.handleNumberTrends($$.jsPainterNumberThree,1500,1,"",10);
            $$.jsVsOne.addClass('vs-div-active');
            $$.jsVsTwo.addClass('vs-div-active');
            $$.jsDes.find("p").addClass("vs-des-active");
            $$.jsBgVs.addClass("bg-vs-active");
        },
        handleLeaveThreePage:function(){
            $$.jsPainterNumberTwo.text("0");
            $$.jsPainterNumberThree.text("0");
            $$.jsVsOne.removeClass('vs-div-active');
            $$.jsVsTwo.removeClass('vs-div-active');
            $$.jsDes.find("p").removeClass("vs-des-active");
            $$.jsBgVs.removeClass("bg-vs-active");
        },
        handleEnterFourPage:function(){
            f.handleNumberTrends($$.jsPainterNumberFour,70,10,"");
            f.handleNumberTrends($$.jsPainterNumberFive,6000,1,"",40);
            f.handleNumberTrends($$.jsPainterNumberSix,70,10,"");
            $$.jsDemandList.find(".demand-icons").addClass("demand-icons-active");
            $$.jsDemandList.find("p").addClass("demand-list-p-active");
        },
        handleLeaveFourPage:function(){
            $$.jsPainterNumberFour.text("0");
            $$.jsPainterNumberFive.text("0");
            $$.jsPainterNumberSix.text("0");
            $$.jsDemandList.find(".demand-icons").removeClass("demand-icons-active");
            $$.jsDemandList.find("p").removeClass("demand-list-p-active");
        },
        handleEnterFivePage:function(){
            $$.jsFlow.find(".city-painter-t16").addClass("city-painter-t16-active");
            $$.jsFlow.find(".direction-one,.direction-two,.direction-three,.direction-four").addClass("direction-active-one");
            $$.jsFlow.find(".direction-five").addClass("direction-active-two");
        },
        handleLeaveFivePage:function(){
            $$.jsFlow.find(".city-painter-t16").removeClass("city-painter-t16-active");
            $$.jsFlow.find(".direction-one,.direction-two,.direction-three,.direction-four").removeClass("direction-active-one");
            $$.jsFlow.find(".direction-five").removeClass("direction-active-two");
        },
        handleEnterSixPage:function(){
            $$.jsSupportList.find(".support-no").each(function(i,d){
                var $d=$(d);
                $d.addClass("support-no-"+(++i)).addClass("support-no-active");
            });
            $$.jsSupDiv.each(function(i,d){
                var $d=$(d);
                $d.addClass("sup-div-"+(++i)).addClass("t12-t13-active");
            });
        },
        handleLeaveSixPage:function(){
            $$.jsSupportList.find(".support-no").each(function(i,d){
                var $d=$(d);
                $d.removeClass("support-no-"+(++i)).removeClass("support-no-active");
            });
            $$.jsSupDiv.each(function(i,d){
                var $d=$(d);
                $d.removeClass("sup-div-"+(++i)).removeClass("t12-t13-active");
            });
        },
        handleEnterEightPage:function(){
            f.handleNumberTrends($$.jsPainterNumberSeven,335,1,"");
            $$.ourDes.find("span").each(function(i,d){
                var $d=$(d);
                $d.addClass("des-"+i);
            });
        },
        handleLeaveEightPage:function(){
            $$.jsPainterNumberSeven.text("0");
            $$.ourDes.find("span").each(function(i,d){
                var $d=$(d);
                $d.removeClass("des-"+i);
            });
        },
        handleJoin:function(){
            $$.painterJoin.hover(function(){
                $(this).find(".join-line").each(function(i,d){
                   var $d=$(d);
                    $d.addClass("join-line-transition join-line-active-"+(++i));
                });
            },function(){
                $(this).find(".join-line").each(function(i,d){
                    var $d=$(d);
                    $d.removeClass("join-line-transition join-line-active-"+(++i));
                });
            });
        }
    };
    //window.onload=function(){
    //    f.init();
    //}
    $(function(){
        f.init();
    })
})(window,document,jQuery)