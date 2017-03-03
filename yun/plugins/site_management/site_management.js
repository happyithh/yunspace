/**
 * Created by pzl on 15/11/25.
 */
var plugin={
    init:function(){
        var __self=this;
        var bh=$(".site_header").height()+$(".site_content").height();
        $("body.body-c").height(bh);
        var date=new Date();
        var month=date.getMonth();
        var year=date.getFullYear();
        __self.calendarObj().showDrop().calendarState(year,month);
        //if($(".item_li").text()==''){
        //    var item=$(".show_dropDown ul > li:first").text();
        //    var item_id=$(".show_dropDown ul > li:first").data('id');
        //    $(".item_li").text(item);
        //    $(".item_li").attr('data-id',item_id);
        //}

    },
    calendarObj:function(){
        var __self=this;
        var __self=this;
        var days;
        var myApp = new Framework7({
            animateNavBackIcon:true
        });
        var $$ = Dom7;
        var monthNames = ['01月', '02月', '03月', '04月', '05月', '06月', '07月', '08月' , '9月' , '10月', '11月', '12月'];
        var calendarInline = myApp.calendar({
            container: '#calendar-inline-container',
            value: [],
            weekHeader: true,
            dayNamesShort:['日','一','二','三','四','五','六'],
            toolbarTemplate:
            '<div class="toolbar calendar-custom-toolbar">' +
            '<div class="today-click"><span>今天</span></div>'+
            '<div class="toolbar-inner">' +
            '<div class="left">' +
            '<a href="#" class="link icon-only"><i class="icon icon-back icon-chevron-left"></i></a>' +
            '</div>' +
            '<div class="center"></div>' +
            '<div class="right">' +
            '<a href="#" class="link icon-only"><i class="icon icon-forward icon-chevron-right"></i></a>' +
            '</div>' +
            '</div>' +
            '</div>',
            onOpen: function (p) {
                days= $(".picker-calendar-day");
                $$(".picker-calendar-day-today > span").text("今");
                $$('.calendar-custom-toolbar .center').text( p.currentYear+'年'+monthNames[p.currentMonth] );
                $$('.calendar-custom-toolbar .left .link').on('click', function () {
                    calendarInline.prevMonth();
                });
                $$(".today-click").on('click',function(){
                    var date=new Date(),
                        d=date.getDate(),
                        m=date.getMonth()+ 1,
                        y=date.getFullYear(),
                        date_str=y+"-"+m+"-"+ d;
                    p.setYearMonth(y, m-1, 100);
                    p.updateValue([date_str]);
                    $$(".picker-calendar-day-today > span").text("今");
                    $$(".picker-calendar-day").removeClass("picker-calendar-day-selected");
                    var time_int=__self.getTimeInt(date_str);
                    __self.addFestival();
                    //var date=new Date().getTime();
                })
                $$('.calendar-custom-toolbar .right .link').on('click', function () {
                    calendarInline.nextMonth();
                });
                __self.addFestival();
            },
            onDayClick:function(p, dayContainer, year, month, day){
                var o=$(dayContainer);
                o.addClass("picker-calendar-dsay-selected");
                days.find("span").removeClass("background_none");
                $(".site_content_table").removeAttr("style");
                if(!o.find("span").hasClass("state1")&&!o.find("span").hasClass("state2")){
                    o.find("span").addClass("background_none text-white");
                }
                __self.loadState(dayContainer);
            },
            onMonthYearChangeStart: function (p, year, month) {
                //var month=parseInt(month)+1;
                //var date_int=__self.getTimeInt(year+"-"+month+"-01")+9;
                //var item_id=$(".item_li").attr('data-id')||{};
                $$(".picker-calendar-day").removeClass("picker-calendar-day-selected");
                //YunSpace.api('demand/product/list.json', {
                //    activity_time:date_int,
                //    item_id:item_id
                //}, function (data) {
                //    console.log(data.data);
                //    if(data.status==1){
                //        var $info=$("#site_content_table_body_message_info");
                //        $info.find("p").first().text(data.data.total.year+"年"+data.data.total.month+"月  "+data.data.total['item_name']);
                //        $info.find("p").eq(1).text("有"+data.data.total['total_item']+"家在您的空间场地举办活动（含已签协议和活动结束）");
                //        $info.find("p").eq(2).text("共占用场地"+data.data.total['total_day']+"天；场地月利用率"+data.data.total['total_rate']+" %");
                //        $info.find("p").eq(3).text("目标租金： "+data.data.total['目标租金']+"元");
                //        $info.find("p").eq(4).text("实际租金： "+data.data.total['实际租金']+"元");
                //        $info.find("p").eq(5).text("租金目标达成率 "+data.data.total['租金达成率']+"%");
                //    }
                //});
                $$(".picker-calendar-day-today > span").text("今");
                __self.addFestival();
                //TODO:: 状态显示
                __self.calendarState(year,month);
                $$('.calendar-custom-toolbar .center').text(p.currentYear+'年'+monthNames[p.currentMonth] );
            }
        });
        return __self;
    },
    GoTable:function(st){
        var timer=setInterval(function(){
            currentPosition=$(window).scrollTop();
            currentPosition+=10;
            if(currentPosition<st)
            {
                window.scrollTo(0,currentPosition);
            }
            else
            {
                window.scrollTo(0,st);
                clearInterval(timer);
            }
            if($(window).scrollTop()>=$(document).height()-$(window).height()){
                clearInterval(timer);
                return;
            }
        },1);
    },
    //日历状态渲染
    calendarState:function(year,month){
        var __self=this;
        var month=parseInt(month)+1;
        var date_int=__self.getTimeInt(year+"-"+month+"-01")+9;
        var item_id=$(".item_li").attr('data-id')||{};
        //var date_int={};
        //console.log(year,month,date_int,item_id);
        YunSpace.api('demand/product/list.json', {
            activity_time:date_int,
            item_id:item_id
        }, function (data) {
            if(data.status==1) {
                //console.log(data);
                var $info=$("#site_content_table_body_message_info");
                $info.find("p").first().text(data.data.total.year+"年"+data.data.total.month+"月  "+data.data.total['item_name']);
                $info.find("p").eq(1).text("有"+data.data.total['total_item']+"家在您的空间场地举办活动（含已签协议和活动结束）");
                $info.find("p").eq(2).text("共占用场地"+data.data.total['total_day']+"天；场地月利用率"+data.data.total['total_rate']+" %");
                $info.find("p").eq(3).text("目标租金： "+data.data.total['目标租金']+"元");
                $info.find("p").eq(4).text("实际租金： "+data.data.total['实际租金']+"元");
                $info.find("p").eq(5).text("租金目标达成率 "+data.data.total['租金达成率']+"%");
                for (var k in data.data.data) {
                    var startTime = data.data.data[k]['activity_start_time'];
                    var endTime = data.data.data[k]['activity_end_time'];
                    var state = data.data.data[k]['status'];
                    $(".picker-calendar-day").each(function (index, dom) {
                        var dom = $(dom);
                        var date_year = dom.data('year'),
                            date_month = parseInt(dom.data('month')) + 1,
                            date_day = dom.data('day');
                        var date_int = __self.getTimeInt(date_year + "-" + date_month + "-" + date_day);
                        if (date_int >= startTime && date_int <= endTime) {
                            switch (state) {
                                case "1":
                                    dom.find("span").addClass("state1");
                                    break;
                                case "2":
                                    dom.find("span").addClass("state2");
                                    break;
                                case "3":
                                    dom.find("span").addClass("state2");
                                    break;
                                case "4":
                                    dom.find("span").addClass("state2");
                                    break;
                                case "6":
                                    dom.find("span").addClass("state2");
                                    break;
                            }

                        }

                    });
                }
            }

        });
    },
    //数据请求
    loadState:function(dayContainer){
        var __self=this;
        var date_year=$(dayContainer).data('year'),
            date_month=parseInt($(dayContainer).data('month'))+1,
            date_day=$(dayContainer).data('day');
        var date_int=__self.getTimeInt(date_year+"-"+date_month+"-"+date_day);
        var scrTop=$(".site_content_table").offset().top;
        var item_id=$(".item_li").attr('data-id')||{};
        __self.GoTable(scrTop);
        $(".site_content_table_body").addClass('none');
        //TODO:: 数据变化
        YunSpace.api('demand/product/list.json', {
            activity_time:date_int,
            item_id:item_id
        }, function (data) {
            var c1=0,c2=0;
            var $one=$("#state_one_num"),$two=$("#state_two_num");
            if(data.status==1) {
                $(".state_ordered .state_order").remove();
                $(".state_pre .state_order").remove();
                var all_clone1="",all_clone2="";
                //if(data.data.data.length==0){return false;}
                if(data.data.data.length==0) {
                    $(".no_content").removeClass("none");
                    $(".no_content").html("没有订单信息");
                    $one.find("span").text("已预订（"+c1+"）");
                    $two.find("span").text("意向预订（"+c2+"）");
                    return false;
                }
                $(".no_content").addClass("none");
                for(var k in data.data.data){
                    if(data.data.data[k]['from_where']==1) {
                        data.data.data[k]['from_where']='云SPACE';
                    }else if(data.data.data[k]['from_where']==2) {
                        data.data.data[k]['from_where']='朋友介绍';
                    }else if(data.data.data[k]['from_where']==3){
                        data.data.data[k]['from_where']='老客户';
                    }else if(data.data.data[k]['from_where']==4) {
                        data.data.data[k]['from_where']='媒体广告';
                    }else if(data.data.data[k]['from_where']==5) {
                        data.data.data[k]['from_where']='其他渠道';
                    }
                    var clone_state_order=$(".clone_state_order").first().clone().removeClass("none");
                    var startTime=new Date(parseInt(data.data.data[k]['activity_start_time']*1000));
                    var endTime=new Date(parseInt(data.data.data[k]['activity_end_time']*1000));
                    startTime=__self.formDate(startTime);
                    endTime=__self.formDate(endTime);
                    var href=clone_state_order.find(".state_order_three > a").attr("href");
                    clone_state_order.find(".state_order_three > a").attr("href",href+""+data.data.data[k]['id']);
                    clone_state_order.find(".state_order_one > span").text(startTime+"~"+endTime);
                    clone_state_order.find(".state_order_two > span").text(data.data.data[k]['detail']['price']);
                    //clone_state_order.find(".state_order_three > a").attr("href",href+""+data.data.data[k]['item_id']);
                    clone_state_order.find(".state_order_three > a > span").html('No.'+data.data.data[k]['demand_id']+"<br/>"+data.data.data[k]['detail']['活动名称']);
                    //clone_state_order.find(".state_order_three > a > span").text(data.data.data[k]['detail']['活动名称']);
                    clone_state_order.find(".state_order_four > span").text(data.data.data[k]['from_where']);
                    if(data.data.data[k]['status']==1){
                        c2++;
                        var all1="<div class='state_order'>"+clone_state_order.html()+"</div>";
                        all_clone1+=all1;
                    }
                    if(data.data.data[k]['status']==2 ||data.data.data[k]['status']==3 || data.data.data[k]['status']==4 || data.data.data[k]['status']==6){
                        c1++;
                        var all2="<div class='state_order'>"+clone_state_order.html()+"</div>";
                        all_clone2+=all2;
                    }
                }
               console.log(c1,c2);
                if(c1!=0){
                    $one.find("span").text("已预订（"+c1+"）");
                    $(".state_ordered").append(all_clone2);
                    $(".state_ordered").removeClass('none');
                }
                if(c2!=0){
                    $(".state_pre").append(all_clone1);
                    $two.find("span").text("意向预订（"+c2+"）");
                    $(".state_pre").removeClass('none');
                }
                var bh=$(".site_body").height();
                $("body").height(bh);
            }else{
                alert('修改失败!!');
            }
        });
    },
    //添节日
    addFestival:function(){
        var fes={
            "2015-1-1":"元旦","2015-2-14":"情人节","2015-2-18":"除夕","2015-2-19":"春节","2015-3-5":"元宵节",
            "2015-3-8":"妇女节","2015-3-12":"植树节","2015-4-1":"愚人节","2015-4-5":"清明节","2015-5-1":"劳动节",
            "2015-5-04":"青年节","2015-5-10":"母亲节","2015-6-1":"儿童节","2015-6-20":"端午节","2015-6-21":"父亲节",
            "2015-7-1":"建党节","2015-8-1":"建军节","2015-8-20":"七夕节","2015-9-27":"中秋","2015-10-1":"国庆节",
            "2015-10-21":"重阳节","2015-12-26":"感恩节","2015-12-25":"圣诞节",
            "2016-1-1":"元旦","2016-1-17":"腊八节","2016-02-1":"小年","2016-2-7":"除夕","2016-2-8":"春节","2016-02-14":"情人节",
            "2016-2-22":"元宵节", "2016-3-8":"妇女节","2016-3-12":"植树节","2016-3-27":"复活节",
            "2016-4-1":"愚人节","2016-4-5":"清明节","2016-5-1":"劳动节",
            "2016-5-4":"青年节","2016-5-8":"母亲节","2016-6-1":"儿童节","2016-6-9":"端午节","2016-6-19":"父亲节",
            "2016-7-1":"建党节","2016-8-1":"建军节","2016-8-9":"七夕节","2016-9-10":"教师节","2016-9-15":"中秋","2016-10-1":"国庆节",
            "2016-10-9":"重阳节","2016-11-24":"感恩节","2016-12-25":"圣诞节",
        };
        $("#calendar-inline-container").find(".picker-calendar-day").each(function(index,dom){
            var dom=$(dom);
            var date_year=dom.data('year'),
                date_month=parseInt(dom.data('month'))+1,
                date_day=dom.data('day');
            var date=date_year+"-"+date_month+"-"+date_day;
            for(var i in fes){
                if(i==date){
                    var l=dom.children(".fes").length;
                    var fesn='<i class="fes">'+fes[i]+'</i>';
                    dom.find("span").append(fesn);
                }
            }
        });

    },
    showDrop:function(){
        var t1;
        var animate=false;
        var $site_header_dropDown=$(".site_header_dropDown");
        var site_cover=$("#site_cover");
        site_cover.on("click",function(){
            $site_header_dropDown.trigger("click");
        });
        //$("#show_dropDown").on("click",'a',function(e){
        //    var obj=$(e.target);
        //    var txt=$(this).text();
        //    $site_header_dropDown.find("code").text(txt);
        //    $site_header_dropDown.trigger("click");
        //    window.location.href=""+obj.attr('href');
        //});
        $site_header_dropDown.on("click",function(e){
            var $dropDown=$(this).parent().find('.show_dropDown');
            $(this).toggleClass("show");
            if($(this).hasClass("show")){
                $(".site_cover").fadeIn(200);
                $(this).find("span").addClass("icon-angle-up").removeClass("icon-angle-down");
                $dropDown.velocity({ top: 45 ,opacity:1 }, {
                    duration: 1000,
                    easing: [ 300, 8 ],
                    begin: function(elements) {$(elements).removeClass("none"); },
                    //complete: function() {
                    //    animate=true;
                    //}
                });
                t1=setInterval(function(){
                    $(window).scrollTop(0);
                },1);
            }else{
                clearInterval(t1);
                $(this).find("span").removeClass("icon-angle-up").addClass("icon-angle-down");
                site_cover.fadeOut(200);
                $dropDown.velocity({ top: 0,opacity:0  }, {
                    duration: 200,
                    complete: function() {
                        $dropDown.addClass("none");
                    }
                });
            }
        });
        return this;
    },
    getTimeInt:function(dateStr){
        var newstr = dateStr.replace(/-/g,'/');
        var date =  new Date(newstr);
        var time_str = date.getTime().toString();
        return time_str.substr(0, 10);
        return date;
    },
    formDate:function(time){
            var   year=time.getFullYear();
            var   month=time.getMonth()+1;
            var   date=time.getDate();
            return  month+"."+date;
    }
}