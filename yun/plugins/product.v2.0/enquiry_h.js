/**
 * Created by pzl on 15/10/23.
 */
var plugin={
    wH:$(window).height(),
    scrH:"",
    init:function(){
        var __self=this;
        __self.tabChange();
        __self.delEnquiry();
        __self.otherchoice();
        var item = localStorage.getItem("ProductList");
        if(item!=null){$(".enquiry-tab").removeClass("none");}
        $(".enquiry-con-input").on("click",function(){
            $(".enquiry-con-input").css({background:"#fff"});
            $("input").css({background:"#fff"});
            $("textarea").css({background:"#fff"});
            $(this).css({
                background:"rgb(255, 235, 235)"
            });
            $(this).find("input").css({
                background:"rgb(255, 235, 235)"
            })
            $(this).find("textarea").css({
                background:"rgb(255, 235, 235)"
            })
            $(this).find("input").trigger("focus");
        });
        $(".input").on("focus",function(){
            $(this).css({
                background:"rgb(255, 235, 235)"
            })
        });
        selectAbsolute();
        $(window).on("scroll",function(){
            selectAbsolute();
        });
        function selectAbsolute(){
            __self.scrH=$(window).scrollTop();
            $(".show-select-list").each(function(index,dom){
                var selectH=$(dom).height();
                var top1=$(this).outerHeight()/2;
                $(dom).css({ "margin-top":-top1+"px" });
            });
            var dateH=$(".date").height();
            var top2=__self.wH/2+__self.scrH-dateH;
            $(".date").css({ top:top2+"px" });
        }
        //safari上readonly禁用输入
        $('input[readonly],textarea[readonly]').on('focus', function(ev) {
            $(this).trigger('blur');
        });
    },

    //其他要求选择
    otherchoice:function(){
        $('.js-other-asks').on('click',function(){
            $('.show-select-list-cont').fadeIn(400);
            $(".cover1").fadeIn(400);
            $(".cover1").on("touchstart",function(){
                $(".cover1").fadeOut(400);
                $('.show-select-list-cont').fadeOut(400);
            });
        });

        $('.ul-asks li').on('click',function(){
            $(this).toggleClass('active');
        });
        $('.js-asks-btn').on('click',function(){
            var oLiText='';
            $('.ul-asks li.active p').each(function(){
                oLiText+=$(this).text()+'  ';
            });
            $('.other-asks-fill').text(oLiText);
            $(".cover1").fadeOut(400);
            $('.show-select-list-cont').fadeOut(400);
        });
    },

    //tab切换
    tabChange:function(){
        $(".enquiry-tab-eq").each(function(index,dom){
            $(dom).on("touchend",function(){
                $(".enquiry-tab-eq").removeClass("enquiry-tab-eq-active");
               $(this).addClass("enquiry-tab-eq-active");
                $(".enquiry-tab-body-eq").addClass("none");
                $(".enquiry-tab-body-eq").eq(index).removeClass("none");
            })
        });
    },
    //询价表单
    delEnquiry:function(){
        var nStartX,nChangX;
        $(".enquiry-li").each(function(index,dom){
            document.getElementsByClassName("enquiry-li")[index].addEventListener('touchstart', function (e) {
                nStartX = e.targetTouches[0].pageX;
            });
            document.getElementsByClassName('enquiry-li')[index].addEventListener('touchend', function (e) {
                nChangX = e.changedTouches[0].pageX;
                if(nChangX-nStartX<-10&&!$(dom).hasClass("enquiry-li-delete-active")){
                    $(".enquiry-li").removeClass("enquiry-li-delete-active");
                    $(dom).addClass("enquiry-li-delete-active");
                }else if(nChangX-nStartX>-10&&nChangX-nStartX<=0){
                    $(dom).find(".check-cir").toggleClass("ion-checkmark enquiry-li-check-active");
                    var d=$(dom).find(".enquiry-checked").data("val");
                    if( $(dom).find(".check-cir").hasClass("ion-checkmark")&& !$(dom).hasClass("enquiry-li-delete-active")){
                        $(dom).find(".enquiry-checked").val(d);
                    }else {
                        $(dom).find(".enquiry-checked").val("");
                    }
                }

                if(nChangX-nStartX>10){
                    $(dom).removeClass("enquiry-li-delete-active");
                }
            });
        });

        $(".enquiry-li-delete").each(function(index,dom){
            $(dom).on("click",function(){
                var val=$(this).parent().find(".enquiry-li-p > span").text();
                console.log(val);
//                 $(".enquiry-checked").
                $(this).parent().find(".enquiry-checked").val("");
                $(this).parent().addClass("enquiry-li-delete-del");
                setTimeout(function(){
                    $(this).parent().addClass("none");
                },400);
            });
        });
    },
    select:function(ele,args,fn){
        var id=args.select;
        $(".cover1").fadeIn(400);
        $(".show-select-list").eq(id).fadeIn(400);
        $(".cover1").on("touchstart",function(){
            $(".cover1").fadeOut(400);
            $(".show-select-list").eq(id).fadeOut(400);
        });
        $(".show-select-list").eq(id).each(function(index,dom){
            $(dom).find(".show-select-li").on("click",function(){
                var t=$(this).text();
                $(".cover1").trigger("touchstart");
                $(ele).find(".select").val(t);
            });
        });
    },
    dateSelect:function(ele,args,fn){
        $(".cover1,.date").fadeIn();
        $(".cover1").on("touchstart",function(){
            $(".cover1,.date").fadeOut();
        });
    }
}
getSpaceList();

function getSpaceList(){
    var listDiv = $('.enquiry-con').eq(1);
    var htmls = '';
    if(listDiv){
        var item = localStorage.getItem("ProductList");
        if(item){
            var productList = JSON.parse(item);
            var num = productList.length;
            for(var i=0; i<productList.length; i++){
                var label = $(".enquiry-li").first().clone().removeClass("none");
                $(label).find(".enquiry-li-p > span").text(productList[i]);
                $(label).find(".enquiry-checked").attr("data-val",productList[i]);
                $(label).find(".enquiry-checked").val(productList[i]);
                listDiv.append(label);
            }
            //console.log(html);
//            listDiv.append(htmls);
        }else{

        }
    }
}

