$(function(){

    /*页面向下滚动到1/4时 立即咨询按钮 显示*/
    var scollHalf=$(document).height()/4;
    $(document).scroll(function () {
        var scollTop=$(document).scrollTop();
        if(scollTop>scollHalf){
            $(".consult-btn-wrap").fadeIn();
        }else if(scollTop>50){
            $(".consult-btn-wrap").fadeOut();
        }
    });

    /*----弹窗----*/
    /*弹窗公共部分*/
    $(".close").click(function(){
        $('.popup_bg').remove();
        $(".wechat_pop-bg").fadeOut();
        $(".pop-cont").fadeOut();
    });
    $(".js-btn").click(function(){
        $('.wechat_pop-bg').fadeIn().after('<div class="popup_bg"></div>');
    });

    /*弹出活动说明*/
    $(".js-expalin-btn").click(function(){
        $(".pop_explan").fadeIn();
    });
    /*弹出投票成功*/
    $(".js-vote-btn").click(function(){
        //$(".pop_voted").fadeIn();
    });
    /*弹出立即咨询*/
    $(".js-consult-btn").click(function(){
        $(".consult").fadeIn();
    });
    /*立即咨询 输入框点击变色效果*/
    $('.inquiry-ul-contleft .fill').focus(function(){
        $(this).parent().addClass('focused');
    });
    $('.inquiry-ul-contleft .fill').blur(function(){
        $(this).parent().removeClass('focused');
    });
    $('.inquiry-ul-contleft li').click(function () {
        $(this).find('.fill').focus();
    });


    $(".js-vote-btn").click(function () {
        //var year_id = $(this).attr("year_id");
        ////console.log(year_id);
        //YunSpace.api('yearmeeting/vote.json', {
        //    'year_id': year_id
        //}, function (data) {
        //    if (data.status == 1) {
        //        //投票成功
        //        $(".pop_voted").fadeIn();
        //    }else{
        //        $(".wechat_pop-bg").hide();
        //        $('.popup_bg').remove();
        //        alert(data.msg);
        //    }
        //    console.log(data);
        //});
    });


    $(".inquiry-btn").click(function () {
        var contact = $(".fill:eq(0)").val();
        var contact_phone = $(".fill:eq(1)").val();
        var content = $(".fill:eq(2)").val();
        var code = $("#look_price_code").val();
        console.log(code);
        if(!code){
            top.alert("请输入验证码！");
            return false;
        }
        YunSpace.api('common/check/auth/code.json', {
            phone: contact_phone,
            auth_code: code
        }, function (data) {
            if (data.status == 1) {
                YunSpace.api('demand/yearmeeting.json', {
                    'contact': contact,
                    'contact_phone': contact_phone,
                    'content': content
                }, function (data) {
                    if (data.status == 1) {
                        $(".close").click();
                    }
                    alert(data.msg);
                });
            } else {
                alert("验证码不正确！！")
            }
        });
    });

    var yearAdvance={
        days:["11_9","11_16","11_23","11_30","12_7","12_14","12_21","12_28"],
        scrTop:"",
        conFirstH:"",
        needScrTop:"",
        bottomShow:false,
        loadImg:false,
        moveTop:"",
        init:function(){
            var __self=this;
            $(window).scrollTop(0)
            __self.scrTop=$(window).scrollTop();
            __self.conFirstH=$(".year_body").outerHeight();
            __self.needScrTop=__self.conFirstH/3*2;
            //加载相应的图片
            __self.loadImg();
            __self.showTopic();
            return __self;
        },
        //加载相应的图片
        loadImg:function(m,d){
            var __self=this;
            if(__self.isLocal()){
                    __self.attrImg(__self.getTime().m,__self.getTime().d);
            }else{
                __self.loadAfter();
            }
        },
        //判断存不存在
        isLocal:function(){
            var __self=this;
            var imgName=__self.getTime().m+"_"+__self.getTime().d;
            var isL=$.inArray(imgName,__self.days);
            if(isL>=0){
                return true;
            }else{
                return false;
            }
        },
        //不存在的情况下，加载下一个图片
        loadAfter:function(){
            var __self=this;
            var imgName=__self.getTime().m+"_"+__self.getTime().d;
            var newDays=[];
            var td=Date.parse(new Date())+3600*8*1000;
            var d3=__self.strToTime("2015-12-28");
            var d4=__self.strToTime("2015-11-09");
            if(td>d3){
                __self.addSrc("year_end");
                return;
            }
            if(td<d4)return;
            for(var k in __self.days){
                var date=__self.days[k].split("_");
                var date1=date.join("-");
                var date2="2015-"+date1;
                date = new Date(Date.parse(date2.replace(/-/g, "/")));
                date = date.getTime();
                if(date<td){
                    newDays.push(__self.days[k]);
                }else{
                    continue;
                }
            }
            newDays.indexOf(newDays)
            var index=newDays.length;
            __self.addSrc(__self.days[index]);
            return __self;
        },
        attrImg:function(m,d){
            var __self=this;
            var imgName=m+"_"+d;
            __self.addSrc(imgName);
        },
        addSrc:function(imgName){
            var loadImg="img/wechat_year/"+imgName+".jpg";
            var initSrc= $(".year_body_advance_banner").attr("src");
            var indImg=initSrc.indexOf("img");
            var packLoad=initSrc.substr(0,indImg);
            var finalLoadImg=packLoad+loadImg;
            $(".year_body_advance_banner").attr("src",finalLoadImg);
        },
        winScrollEvent:function(){
            var __self=this;
            $(window).on("scroll",function(){
                __self.scrTop=$(window).scrollTop();
                __self.showBottom();
                __self.moveTop=__self.conFirstH-__self.scrTop;
            });
            return __self;
        },
        //是否显示查看主题
        showBottom:function(){
            var __self=this;
            if(__self.needScrTop<__self.scrTop){
                if(__self.bottomShow==true)return;
                    $(".year_body_advance_bottom").show();
                    __self.bottomShow=true;
            }else{
                if(__self.bottomShow==false)return;
                $(".year_body_advance_bottom").hide();
                __self.bottomShow=false;
            }
            return __self;
        },
        showTopic:function(){
            var __self=this;
            $(".year_body_advance_bottom").on("click",function(){
                $(this).remove();
                var t=__self.conFirstH;
                var wH=$(window).height();
                $(".year_body").eq(1).removeClass("none");
                var advanceH=$(".year_body_advance").height();
                $(".content").velocity({
                    marginTop:"-"+(__self.moveTop)+"px"
                }, { duration: 500 });
                var v=$(".year_body1").height()-__self.moveTop;
                setTimeout(function(){
                    $(".year_body1").css({
                        height:(__self.moveTop-40)+"px"
                    });
                    $(window).scrollTop(0);
                },510);
            });
        },
        getTime:function(){
            var curDate = new Date();
            var myDate=new Date(curDate.getTime() + 8*60*60*1000);
            var m=myDate.getMonth()+1;
            var d=myDate.getDate();
            return {m:m,d:d};
        },
        //将字符串转化成时间戳
        strToTime:function(str){
            var d1=str;
            var d2 = new Date(Date.parse(d1.replace(/-/g, "/")));
            var d3 = d2.getTime();
            return d3;
        }
    }
    yearAdvance.init().winScrollEvent().getTime();
});