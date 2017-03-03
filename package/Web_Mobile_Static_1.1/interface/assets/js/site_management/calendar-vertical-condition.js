var currentDate = new Date;
var currentYear = currentDate.getFullYear();
var currentmonth = currentDate.getMonth();
var dayNames = new Array("日","一","二","三","四","五","六");
var testData = [
    {
        "title": "5天",
        "start": "2015-11-04",
        "end" : "2015-11-08",
        "type" : "1"
    },
    {
        "title": "挎月份",
        "start": "2015-11-20",
        "end" : "2015-12-08",
        "type" : "1"
    },
    {
        "title": "6天",
        "start": "2015-11-25",
        "end" : "2015-11-30",
        "type" : "1"
    },
    {
        "title": "5天",
        "start": "2015-11-26",
        "end" : "2015-11-30",
        "type" : "1"
    },
    {
        "title": "4天",
        "start": "2015-11-17",
        "end" : "2015-11-20",
        "type" : "1"
    },
    {
        "title": "2天",
        "start": "2015-11-1",
        "end" : "2015-11-2",
        "type" : "1"
    },
    {
        "title": "2天",
        "start": "2015-11-2",
        "end" : "2015-11-3",
        "type" : "1"
    },
    {
        "title": "2天全",
        "start": "2015-11-3",
        "end" : "2015-11-4",
        "type" : "1"
    },
    {
        "title": "9月份;2天",
        "start": "2015-9-4",
        "end" : "2015-9-5",
        "type" : "2"
    },
    {
        "title": "已预订",
        "start": "2015-11-4",
        "end" : "2015-11-25",
        "type" : "2"
    },
    {
        "title": "已预订",
        "start": "2015-11-6",
        "end" : "2015-11-7",
        "type" : "2"
    },
    {
        "title": "11月份",
        "start": "2015-11-4",
        "end" : "2015-11-7",
        "type" : "2"
    },
    {
        "title": "11月份",
        "start": "2015-11-4",
        "end" : "2015-11-7",
        "type" : "4"
    },
    {
        "title": "10月份",
        "start": "2015-10-4",
        "end" : "2015-10-7",
        "type" : "4"
    },
    {
        "title": "10月份至11月份",
        "start": "2015-10-4",
        "end" : "2015-11-7",
        "type" : "4"
    },
    {
        "title": "7月份",
        "start": "2015-7-4",
        "end" : "2015-7-7",
        "type" : "4"
    },
    {
        "title": "12",
        "start": "2016-1-4",
        "end" : "2016-2-7",
        "type" : "4"
    },
    {
        "title": "2015年12月至2016年2月",
        "start": "2015-12-4",
        "end" : "2016-2-7",
        "type" : "4"
    },
    {
        "title": "2222",
        "start": "2015-12-4",
        "end" : "2016-2-7",
        "type" : "1"
    },
    {
        "title": "2015年12月至2016年1月",
        "start": "2016-1-5",
        "end" : "2016-1-7",
        "type" : "1"
    },
    {
        "title": "123",
        "start": "2016-7-5",
        "end" : "2016-7-7",
        "type" : "1"
    },
    {
        "title": "123",
        "start": "2017-1-5",
        "end" : "2017-7-7",
        "type" : "1"
    }


];
var getScheData = [];
var allData = {

};


var pieceCfg = {
    width : 36
};

var intentOffsetLeft = $(window).width();
var windowW = $(window).width();

var typeData = [];
var pieceOffSetLeft = {
    intentOffSetLeft : windowW * 0.15,
    prepaidOffSetLeft : windowW * 0.55,
    signningOffSetLeft : windowW * 0.70,
    signedOffSetLeft : windowW * 0.85
};

var mainContent = $('#calendarContent');
var nowDate = new Date();
var nowYear = nowDate.getFullYear();
var nowMonth = nowDate.getMonth();
var nowDay = nowDate.getDate();


function dealJsonData(month,year){
    month += 1;
    year = parseInt(year);
    var dataLenght = getObjectLength(getScheData);
    var wrap = $('<div class="schedule-month-content"></div>');
    for(var i =0;i< dataLenght ;i++){
        //alert(typeof dataLenght);
        var bgColor = '';
        var pieceOffSet = 0;

        var start = getScheData[i].activity_start_time,
            end = getScheData[i].activity_end_time,
            startData = start.split('-'),
            endData = end.split('-'),
            startDay = parseInt(startData[2]),
            endDay =  parseInt(endData[2]),
            startMonth = parseInt(startData[1]),
            endMonth =  parseInt(endData[1]),
            startYear = parseInt(startData[0]),
            endYear = parseInt(endData[0]),
            secNum = 0,//piece高度
            offSetTop = 1;


        if(year < startYear || year > endYear ){
            continue;
        }

        if(!allData[year]){
            allData[year] = {}
        }

        if(!allData[year][month]){//不存在则创建
            allData[year][month] = {
                intentData:[],
                prepaidData:[],
                signningData:[],
                signedData:[]
            };
        }

        if(getScheData[i].status == 1){
            bgColor = '#2c9a42';
            pieceOffSet = pieceOffSetLeft.intentOffSetLeft;
            typeData = allData[year][month].intentData;
        }
        if(getScheData[i].status == 2){
            bgColor = '#ff4539 ';
            pieceOffSet = pieceOffSetLeft.prepaidOffSetLeft;
            typeData = allData[year][month].prepaidData;
        }
        if(getScheData[i].status == 3){
            bgColor = '#db8925 ';
            pieceOffSet = pieceOffSetLeft.signningOffSetLeft;
            typeData = allData[year][month].signningData;
        }
        if(getScheData[i].status == 4){
            bgColor = '#3b8ede ';
            pieceOffSet = pieceOffSetLeft.signedOffSetLeft;
            typeData = allData[year][month].signedData;
        }
        var index = getListNum(startDay,endDay,typeData,getScheData[i].status);
        if(isNaN(index)){
            continue
        }

        if(year > startYear && year <= endYear){//夸年了

                if( month < endMonth){
                    secNum = 31;
                    offSetTop = 1;
                    for(var j = 1;j <= endDay;j++){
                        j = parseInt(j);
                        if(typeData[index].indexOf(j) < 0){
                            typeData[index].push(parseInt(j));
                        }
                    }
                }
                else if(month == endMonth){
                    secNum = endDay;
                    offSetTop = 1;
                    for(var j = 1;j <= endDay;j++){
                        j = parseInt(j);
                        if(typeData[index].indexOf(j) < 0){
                            typeData[index].push(parseInt(j));
                        }
                    }
                }

        }
        else if( year == startYear && year < endYear){ //从这年开始 跨到下一年

                if(month > startMonth){
                    secNum = 31;
                    offSetTop = 1;
                    for(var j = 1;j <= endDay;j++){
                        j = parseInt(j);
                        if(typeData[index].indexOf(j) < 0){
                            typeData[index].push(parseInt(j));
                        }
                    }
                }else if(month == startMonth){
                    secNum = 31;
                    offSetTop = startDay;
                    for(var j = 1;j <= endDay;j++){
                        j = parseInt(j);
                        if(typeData[index].indexOf(j) < 0){
                            typeData[index].push(parseInt(j));
                        }
                    }
                }
        }
        else if( year == startYear && year == endYear ){//同一年
            //对月份进行判断
            //alert(11)
            if(startMonth < month && endMonth == month){//不是该月份 从上个月份到这个月份 到这个月为止
                secNum = endDay;
                offSetTop = 1;
                for(var j = 1;j <= endDay;j++){
                    j = parseInt(j);
                    if(typeData[index].indexOf(j) < 0){
                        typeData[index].push(parseInt(j));
                    }
                }
            }

            else if( endMonth > month && startMonth == month){ //从这个月开始 夸到下个月份

                secNum = 31 - startDay + 1;
                offSetTop = startDay;
                for(var j = startDay;j <= 31;j++){
                    j = parseInt(j);
                    if(typeData[index].indexOf(j) < 0){
                        typeData[index].push(parseInt(j));
                    }
                }
            }

            else if( endMonth > month && startMonth < month ){ // 不是从这个月开始 并且跨到下个月
                secNum = 31;
                offSetTop = 1;
                for(var j = startDay;j <= 31;j++){
                    j = parseInt(j);
                    if(typeData[index].indexOf(j) < 0){
                        typeData[index].push(parseInt(j));
                    }
                }
            }

            else if( endMonth == month && startMonth == month ){ //同一月份

                secNum = endDay - startDay + 1;
                offSetTop = startDay;
                for(var j= startDay;j<=endDay;j++){
                    j = parseInt(j);
                    if(typeData[index].indexOf(j) < 0){
                        typeData[index].push(parseInt(j));
                    }
                }
            }
        }

        //if(year == startYear && year == endYear && endMonth < month){
        //    continue;
        //
        //}else{
        //
        //}
        if(secNum > 0){

            var piece = $('<div class="intentPieceWrap"><a href="#"><div class="intentPiece">' +
            '<div class="content"><span>'+getScheData[i].detail['活动名称']+'</span></div>'+
                //'<div class="content">有意向</div>'+
            '</div></a></div>');
            piece.css({
                "left": pieceOffSet + (index*pieceCfg.width)+'px',//注意多出来的border
                'top':(offSetTop-1) * 60 + 'px',
                'height': secNum * 60 + 'px',
                'background':bgColor
                //'line-height':array1.length * 60 + 'px',
            });
            //var spanHeight = piece.find('span').height();
            //piece.find('span').css({
            //    //'height':secNum * 60 + 'px'
            //    'margin-top' : -spanHeight/2 + 'px'
            //});
            if(getScheData[i].status != 1){
                piece.css({
                    'width':'15%'
                });
            }
            wrap.append(piece);
        }

    }
    return wrap;


}

function getListNum(start,end,typeData,type){
    start = parseInt(start);
    end = parseInt(end);
    var length = typeData.length;

    if(length >=3 && type == 1 ){
        return "已超过"
    }
    if(length >=1 && type != 1 ){
        return "已超过"
    }

    for(var j = 0;j <= length;j++){
        if(!typeData[j]){//不存在则创建
            typeData[j] = [];
        }
        if(typeData[j].indexOf(start) < 0 && typeData[j].indexOf(end) < 0){
            return j;
        }
       //if(!(intentData[j].indexOf(start) >= 0 || intentData[j].indexOf(end) >= 0)){
       //
       //}
    }
    //if(!intentData[length]){//不存在则创建
    //    intentData[length] = [];
    //}
    //alert(length)
    //return length;

}


function drawingmonth(activemonth,year,date,isPre){

    var activeDate = new Date(year,activemonth);
    activeDate.setDate(1);
    var month = activeDate.getMonth();
    var diff = 1 - activeDate.getDay();
    activeDate.setDate(diff); //这个月的起始日期
    var wrap = $('<div class="schedule-month-content-wrap"></div>');
    for(var i=0; i<42; i++){
        var week =  dayNames[activeDate.getDay()];
        var innerMonth = activeDate.getMonth() + 1;
        var innerDate = activeDate.getDate();
        var innerYear = activeDate.getFullYear();
        var text =  innerMonth + '月' + innerDate + '日';
        var myDate = year + '-' + innerMonth + '-' + innerDate;

        var html = '<div class="schedule_content_item">'+
            '<div class="item_date" data-date="'+myDate+'">'+text+'<br> '+'星期'+week+' </div>' +
            '<div class="item_intention"></div>'+
            '<div class="item_booked"></div>'+
            '<div class="item_process"></div>'+
            '<div class="item_signed"> </div>'+
            '</div>';
        if(activeDate.getMonth()!=month){ //是否是当前月份

        }else{
            if( activemonth == nowMonth &&  year == nowYear && innerDate == nowDay){
                html = $(html).find('.item_date').addClass('active').parents('.schedule_content_item');
            }
            //console.log(year);
            //console.log(innerYear);
            if(activemonth == activeDate.getMonth() &&  year == innerYear && innerDate == date){
                html = $(html).find('.item_date').addClass('pitch').parents('.schedule_content_item');
            }
            wrap = wrap.append(html);
        }
        activeDate.setDate(innerDate+1);
    }
    if(isPre){
        $('#calendarContent').prepend(wrap).prepend(dealJsonData(activemonth,year));
        $('body').scrollTop(28*60);
    }else{
        $('#calendarContent').append(dealJsonData(activemonth,year)).append(wrap);
    }


}
function getObjectLength(object){
    var length = 0;
    for(i in object){
        length ++
    }
    return length;
}

var lastYear,lastMonth;

function loadMoreData(){//获取下个月的档期
    if(lastYear >= 2016 && lastMonth>=7){//日期不能超过 2016-7
        return;
    }
    lastMonth += 1;
    if(lastMonth > 11){
        lastMonth = 0;
        lastYear += 1 ;
        drawingmonth(lastMonth,lastYear);
    }else{
        drawingmonth(lastMonth,lastYear);
    }
    //console.log(lastYear+'-'+lastMonth)
}
var startYear,startMonth;
function loadPreData(){ //获取上个月的档期
    if(startYear <= 2015 && startMonth<=7){//日期不能小于 2015-7
        return;
    }
    startMonth -= 1;
    if(startMonth < 0){
        startMonth = 11;
        startYear -= 1 ;
        drawingmonth(startMonth,startYear,'',true);
    }else{
        drawingmonth(startMonth,startYear,'',true);
    }
}

function drawActiveDate(date){
    //$('.item_date').each(function(){
    //    var textDate = $(this).data('date');
    //    //console.log(textDate);
    //    //console.log(date);
    //    if (textDate == date){
    //        var offset = $(this).offset().top;
    //        $('body').scrollTop(offset - 170);
    //        $(this).addClass('pitch');
    //    }
    //});
    $('.item_date.pitch').each(function(){
        var offset = $(this).offset().top;
        $('body').scrollTop(offset - 170);
    })
}

$(function(){
    var itemId = $('#site_header_dropDown code').data('id');

    startQuery();
    $('#beginTime').datePicker({
        beginyear: 2015,
        endyear:2016,
        theme: 'date',
        callBack: function() {
            var getDate = $('#beginTime').val(),
                str = getDate.split('-'),
                year = parseInt(str[0]),
                month = parseInt(str[1]) - 1,
                date = parseInt(str[2]);
            mainContent.html("");
            allData = {};
            lastYear=startYear = year;
            lastMonth =startMonth= month;
            drawingmonth(month,year,date,'');
            drawActiveDate(getDate)
        }
    });

    function startQuery(){
        $.ajax({
            type: "get",
            url: "/static/api/demand/product/list/Byid.jsonp",
            //url: "http://d17.yunspace.com.cn/static/api/demand/product/list.jsonp",
            dataType: 'json',
            data:{
                item_id:itemId
            },
            success:function(data){
                getScheData = data.data.data;
                //console.log(getScheData);
                window.onscroll = function(){//加载上个月
                    var scrollTop = document.body.scrollTop;
                    if(scrollTop <= 0){
                        loadPreData();
                    }
                };
                $('#loadMore').on('click',function(){//加载下个月
                    loadMoreData();
                });

                (function(){
                    var date = nowDate.getDate();
                    lastYear = startYear = nowDate.getFullYear();
                    lastMonth = startMonth = nowDate.getMonth();
                    drawingmonth(lastMonth,lastYear);//画出当前月份
                    $('#beginTime').val(lastYear+'-'+(lastMonth+1)+'-'+date);
                    $('body').scrollTop(10);
                    loadMoreData();//加载下个月

                })();
            },
            error:function(XMLHttpRequest, textStatus, errorThrown){
                console.log(XMLHttpRequest, textStatus, errorThrown);
            }
        });
    }




//    $('#endTime').date({ theme:"datetime" });
});