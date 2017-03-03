var monthMap = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
var leapMonthMap = [31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
var weekMap = ["日", "一", "二", "三", "四", "五", "六"];
var currentDate = new Date();
var currentYear = currentDate.getFullYear();
var currentMonth = currentDate.getMonth() + 1;
var currentDay = currentDate.getDate();
var currentDateString = currentYear + "-" + currentMonth + "-" + currentDay;
var unavailableDatePool=[];
var url='http://'+window.location.host+$('.ajaxUrl').attr('data-url');
var id=$('.ajaxUrl').attr('data-id');
var type=$('.ajaxUrl').attr('data-type');



function AjaxDate(url,items,callback){
    $.ajax({
        type:"post",
        url:url,
        dataType:"json",
        data:items||{},
        success:function(data){
            if(callback instanceof Function){
                callback(data);
                return;
            }else{
                return false;
            }
        },
        error:function(XMLHttpRequest, textStatus, errorThrown){
            console.log(XMLHttpRequest+":"+textStatus+","+errorThrown);
        }
    })
}


function resizeTableCellHeight(ele) {
    var parentSize = ele.width();
    //235 像素以下
    if (parentSize <= 235) {
        ele.find(".dp-date").css({
            "line-height": "24px",
            "font-size": "12px"
        }).end().find(".dp-header-date").css(
            {
                "line-height": "30px",
                "font-size": "16px"
            }
        ).end().find(".dp-header").css(
            {
                "font-size": "12px"
            }
        ).end().find(".dp-table-usage").css(
            {
                "line-height": "24px",
                "font-size": "12px",
                "padding-top":"5px"
        }).find("div").css(
            {
                "margin-top": "3px",
                "font-size": "12px"
            });
    } else if ((235 < parentSize) && (parentSize <= 320 )) {
        ele.find(".dp-date").css({
            "line-height": "30px",
            "font-size": "14px"
        });
    } else if ((320 < parentSize) && (parentSize <= 480 )) {
        ele.find(".dp-date").css("line-height", "42px");
    } else {
        return;
    }
}
String.prototype.Trim = function()
{
    this.replace(/\s/g, "");
}
//单日时间差分
//这里的-1操作是考虑到一天的结束时23:59 而不是第二天的0:00
var dateDifference = Date.parse(new Date("2015-12-12")) - Date.parse(new Date("2015-12-11")) - 1;
var plugin = {
    isCssLoaded: false,
    count: 0,
    unavailableDatePool:[],
    initPlugin: function (ele, args, fn) {
        AjaxDate(url,{id:id,type:type},function(data){
            for(var k in data.data){
                unavailableDatePool.push(data.data[k]);
            }
            var invalidDateForWeek = [];
            var invalidDateForCertainDay = [];
            //初始化不可选择的星期
            if (args.invalid) {
                var  week=args.invalid.replace(/\s/g, "");
                invalidDateForWeek = week.split(",");
            }
            //初始化不可选择的日期
            var handles = {
                pluginHandle: this,
                domHandle: $(ele),
                datePool: [],
                invalidDateForWeek: invalidDateForWeek,
                invalidDateForCertainDay: invalidDateForCertainDay,
                readOnly: args["display-only"] ? args["display-only"] : "false",
                withInput: args["with-input"] ? args["with-input"] : "true"
            };
            this.count++;
            if (!this.isCssLoaded) {
                var css = document.createElement("link");
                css.rel = "stylesheet";
                //css.href = "css/data-picker.css";
                document.getElementsByTagName("head")[0].appendChild(css);
                this.isCssLoaded = true;
            }
            var preHtml= "<div class='data-cont'>" +
                "<table>" ;
            if (handles.withInput === "true") {
                preHtml+=
                    "<tr>" +
                    "<td class='dp-border-none dp-table-input' colspan='7'>" +
                    "<label>开始时间<input name='start_date' disabled placeholder='请点击日历' class='js-begin-date'/></label>" +
                    "<label>结束时间<input name='end_date' disabled  class='js-end-date' placeholder='请点击日历'/></label>" +
                    "</td>" +
                    "</tr>" ;
            }
            preHtml +=
                "<tr class='data-picker'>" +
                "<td class='dp-border-none dp-table-controller js-pre-month'>&lt;</td>" +
                "<td colspan='5' class='dp-header-date dp-border-none'><span class='dp-year'></span>年<span class='dp-month'></span>月</th>" +
                "<td class='dp-border-none dp-table-controller js-next-month'>&gt;</td>" +
                "</tr>" +
                "<tr>" +
                "<td class='dp-border-none dp-table-usage' colspan='7'>" +
                "<label>已售</label><div class='dp-used'></div>" +
                "<label>已选</label><div class='dp-selected'></div>" +
//            "<label>部分预定</label><div class='dp-part-selected' style='margin-right: 0'></div>" +
            "</tr>"+
            "</table>" +
            "</div>";

            $(ele).append(preHtml);
            var virtualHtml;
            //描绘当前月份以及 前后月份的操作按钮
            //描绘日期头部
            virtualHtml = "<tr>";
            for (var i = 0; i < 7; i++) {
                virtualHtml += "<td class='dp-header'>" + weekMap[i] + "</td>";
            }
            virtualHtml += "</tr>";
            //描绘日期本体
            for (var i = 0; i < 6; i++) {
                virtualHtml += "<tr>";
                for (var j = 0; j < 7; j++) {
                    virtualHtml += "<td class='dp-date'><p></p></td>";
                }
                virtualHtml += "</tr>";
            }
            $(ele).find(".js-next-month").click(function () {
                nextMonth(handles);
            });
            $(ele).find(".js-pre-month").click(function () {
                preMonth(handles);
            });
            $(ele).find(".data-picker").after(virtualHtml);
            resizeTableCellHeight($(ele));
            displayCurrentMonth.call(handles, currentYear, currentMonth);
        });
    }
};
//将时间戳转换为日期字符串
function convertTimestampToDateString(inputTimestamp) {
    var convert = new Date(parseInt(inputTimestamp));
    //对应火狐游览器无法解析形如"2015-12-12"这样的日期，火狐可解析的日期格式为"2015/12/12"
    return convert.getFullYear() + "/" + (convert.getMonth() + 1) + "/" + convert.getDate();
}
function convertTimestampToDateFullString(inputTimestamp) {
    var convert = new Date(parseInt(inputTimestamp));
    return convertTimestampToDateString(inputTimestamp) + " " + convert.getHours() + ":" + convert.getMinutes() + (convert.getMinutes() === 0 ? "0" : "");
}
//检查是否是可选的日期
function checkIfValid(inputTimestamp) {
    if (unavailableDatePool.length <= 0) {
        return true;
    } else {
        for (var i = 0; i < unavailableDatePool.length; i++) {
            if ((unavailableDatePool[i]["start"] <= inputTimestamp) && (inputTimestamp <= unavailableDatePool[i]["end"])) {
                return false;
            } else {
                continue;
            }
        }
        return true;
    }
}
//清除输入
function clearDateInput(handle) {
    handle.find(".js-begin-date").val("");
    handle.find(".js-end-date").val("");
};
//更新输入框
function updateDateInput(date1, date2) {
    var handles = this;
    var domHandle = this.domHandle;
    clearDateInput(domHandle);
    var begin;
    var end;
    if (date2 === 0) {
        if (date1 === 0) {
            domHandle.find(".js-begin-date").val("");
        } else {
            domHandle.find(".js-begin-date").val(convertTimestampToDateFullString(date1));
        }
        domHandle.find(".js-end-date").val("");
        begin = end = date1;
    } else {
        if (date1 < date2) {
            domHandle.find(".js-begin-date").val(convertTimestampToDateFullString(date1));
            domHandle.find(".js-end-date").val(convertTimestampToDateFullString(date2));
            begin = date1;
            end = date2;
        } else {
            domHandle.find(".js-begin-date").val(convertTimestampToDateFullString(date2));
            domHandle.find(".js-end-date").val(convertTimestampToDateFullString(date1));
            begin = date2;
            end = date1;
        }
    }
}
function preMonth(handles) {
    var year = parseInt(handles.domHandle.find(".dp-year").text());
    var month = parseInt(handles.domHandle.find(".dp-month").text());
    if (1 === month) {
        month = 12;
        year--;
    } else {
        month--;
    }
    displayCurrentMonth.call(handles, year, month);
    refreshDatePickerSelect.call(handles);
}
function nextMonth(handles) {
    var year = parseInt(handles.domHandle.find(".dp-year").text());
    var month = parseInt(handles.domHandle.find(".dp-month").text());
    if (12 === month) {
        month = 1;
        year++;
    } else {
        month++;
    }
    displayCurrentMonth.call(handles, year, month);
    refreshDatePickerSelect.call(handles);
}
function isLeapYear(targetYear) {
    return (((targetYear % 4) === 0 ) && (( targetYear % 400 ) !== 0 ));
}
function getWeekOfFirstDay(year, month) {
    var C;
    var y;
    var m
    if (month < 3) {
        m = 12 + month;
        year--;
    } else {
        m = month;
    }
    C = Math.floor(year / 100);
    y = year % 100;
    var result = Math.floor(C / 4) - 2 * C + y + Math.floor(y / 4) + Math.floor(13 * (m + 1) / 5);
    result = result < 0 ? result + 7 : result;
    return result % 7 + 1;
}
//更新日期选中情况
function refreshDatePool(obj, dateContent) {
    var handles = this;
    var datePool = handles.datePool;
    var o = $(obj);
    if ($(dateContent).attr("data-date") === "cancel-date") {
        var tempData = [];
        var cancelData = Date.parse(o.attr("data-date"));
        for (var i = 0; i < datePool.length; i++) {
            if ((cancelData <= datePool[i]) && (datePool[i] <= cancelData + dateDifference)) {
                continue;
            } else {
                tempData.push(datePool[i]);
            }
        }
        handles.datePool = tempData;
        return refreshDatePickerSelect.call(handles);
    }
    if (datePool.length === 2) {
        datePool = [];
    }
    //如果没有任何日期选中，并且在第一次就选择了全天的情况下，则认为开始时间为一天的开始，结束时间为一天的结束
    if (datePool.length === 0) {
        if ($(dateContent).attr("data-date") === "all-day") {
            var secondTimestampStart = Date.parse(o.attr("data-date"));
            var secondTimestampEnd = secondTimestampStart + dateDifference;
            datePool.push(secondTimestampStart);
            datePool.push(secondTimestampEnd);
            handles.datePool = datePool;
            return refreshDatePickerSelect.call(handles)
        }
    } else {
        //如果已经选择了某一个日期，第二次选择的是全天的情况下，则认为终止时间为第二次选择日期的结束时间
        //如果正好选择顺序与时间顺序逻辑相悖的情况下，需要硬性排序并重新理顺逻辑
        if ($(dateContent).attr("data-date") === "all-day") {
            var secondTimestampStart = Date.parse(o.attr("data-date"));
            var secondTimestampEnd = secondTimestampStart + dateDifference;
            //这里需要排除的是同一天的两次选择，如果第二次选择的是全天的情况下，那么认为第一次选择无效
            if ((secondTimestampStart <= datePool[0] ) && (datePool[0] < secondTimestampEnd)) {
                datePool = [];
                datePool.push(secondTimestampStart);
                datePool.push(secondTimestampEnd);
                handles.datePool = datePool;
                return refreshDatePickerSelect.call(handles);
            }
            if (secondTimestampEnd <= datePool[0]) {
                datePool.push(secondTimestampStart);
            } else {
                datePool.push(secondTimestampEnd);
            }
            handles.datePool = datePool;
            return refreshDatePickerSelect.call(handles);
        }
    }
    datePool.push(Date.parse(o.attr("data-date") + " " + $(dateContent).text()));
    handles.datePool = datePool;
    if (!refreshDatePickerSelect.call(handles)) {
        handles.datePool.pop();
        return false;
    } else {
        return true;
    }
}
//检查选中区域是否包含不可选日期
function containsValid(left, right) {
    for (var i = 0; i < unavailableDatePool.length; i++) {
        //这里需要对输入进行检查，而不是在填充输入数据的时候已经检查
        //这是处于程序运行效率以及可维护性考虑之下的结果
        if ((left === 0) || (right === 0)) {
            continue;
        }
        if ((left <= unavailableDatePool[i]["start"] ) && (unavailableDatePool[i]["end"] <= right)) {
            alert("所属档期已选，请重新选择！！");
            return true;
        } else {

            continue;
        }
    }
    return false;
}
function refreshDatePickerSelect() {
    var handles = this;
    var domHandle = this.domHandle;
    var datePool = this.datePool;
    var sortedDatePool = [];
    //确认输入时间戳的先后顺序
    if (datePool.length === 0) {
        sortedDatePool = [0, 0];
    } else if (datePool.length === 1) {
        sortedDatePool = [0, datePool[0]];
    } else {
        sortedDatePool = [datePool[0], datePool[1]];
        sortedDatePool.sort(function (a, b) {
            return a > b ? 1 : -1;
        });
    }
    if (containsValid(sortedDatePool[0], sortedDatePool[1])) {
        //因为所选日期区间包含不可选的日期，因此阻止程序继续操作并在合理的位置提醒用户
        return false;
    }
    var left = (sortedDatePool[0] === 0 ? sortedDatePool[1] : sortedDatePool[0]);
    var right = (sortedDatePool[1] === 0 ? sortedDatePool[0] : sortedDatePool[1]);
    while (left < right) {
        if (isInvalidWeek(handles.invalidDateForWeek, convertTimestampToDateString(left))) {
            alert("节假日不可选，或者不在活动时间范围内");
            return false;
        }
        left += dateDifference;
    }
    //清除选中
    domHandle.find(".dp-date").removeClass("dp-selected").removeClass("dp-part-selected");
    for (var i = 0; i < $(".dp-date").length; i++) {
        var targetDom = $(domHandle.find(".dp-date").get(i))
        var targetTimestamp = Date.parse(targetDom.attr("data-date"));
        if (((sortedDatePool[0] === 0) && (targetTimestamp < sortedDatePool[1]) && ((targetTimestamp + dateDifference) < sortedDatePool[1]) ) ||
            ((targetTimestamp < sortedDatePool[0]) && (((targetTimestamp + dateDifference) < sortedDatePool[0])))) {
            continue;
        }
        if (((sortedDatePool[0] !== 0 ) && (targetTimestamp >= (sortedDatePool[1]))) || (targetTimestamp > (sortedDatePool[1]))) {
            if (targetTimestamp === sortedDatePool[1]) {
                datePool[0] = (datePool[0] === sortedDatePool[1]) ? datePool[0] - 1 : datePool[0];
                datePool[1] = (datePool[1] === sortedDatePool[1]) ? datePool[1] - 1 : datePool[1];
                handles.datePool = datePool;
            }
            break;
        }
        //此处需要判断选中的日期是整天还是一天中的部分
        if (( sortedDatePool[1] < targetTimestamp + dateDifference ) || ((targetTimestamp < sortedDatePool[0]) && (sortedDatePool[0] < (targetTimestamp + dateDifference)))) {
            targetDom.addClass("dp-part-selected");
        } else {
            targetDom.addClass("dp-selected");
        }
    }
    return true;
}
function isInvalidWeek(invalidWeek, inputDateString) {
    var convert = new Date(inputDateString);
    inputDate = convert.getDay();
    for (var i = 0; i < invalidWeek.length; i++) {
        if (parseInt(invalidWeek[i]) === inputDate) {
            return true;
        }
    }
    return false;
}
function displayCurrentMonth(year, currentMonth) {
    var handles = this;
    var domHandle = this.domHandle;
    var isReadOnly = this.readOnly;
    var firstWeek = getWeekOfFirstDay(year, currentMonth);
    var currentMonthMap = isLeapYear(year) ? leapMonthMap : monthMap;
    var preMonthDateCount;
    var preMonthDateReserve;
    var preMonth;
    var nextMonth;
    var preYear;
    var nextYear;
    //填充上月数据
    //如果这个月的第一天是星期日，那么需要将上月的最后一个星期填入
    if (1 === firstWeek) {
        //如果当前月是1月 那么其上一个月的数据来自去年的12月
        preMonthDateReserve = 7;
    } else {
        preMonthDateReserve = firstWeek - 1;
    }
    if (1 === currentMonth) {
        preMonthDateCount = 31;
        preMonth = 12;
        nextMonth = 2;
        preYear = year - 1;
        nextYear = year;
    } else if (12 === currentMonth) {
        preMonthDateCount = currentMonthMap[currentMonth - 2];
        preMonth = 11;
        nextMonth = 1;
        preYear = year;
        nextYear = year + 1;
    } else {
        preMonthDateCount = currentMonthMap[currentMonth - 2];
        preMonth = currentMonth - 1;
        nextMonth = currentMonth + 1;
        preYear = nextYear = year;
    }
    for (var i = 0; i < preMonthDateReserve; i++) {
        var day = preMonthDateCount - preMonthDateReserve + i + 1;
        var dateString = preYear + "/" + preMonth + "/" + day;
        var targetDom = $(domHandle.find(".dp-date").get(i));
        if (Date.parse(dateString) < Date.parse(currentDateString)) {
            targetDom.html(day).attr("data-date", dateString).removeClass().addClass("dp-date").addClass("dp-pre-month").addClass("dp-pre-date").addClass("disabled", true);
        } else {
            targetDom.html(day).attr("data-date", dateString).removeClass().addClass("dp-date").addClass("dp-pre-month");
            if (Date.parse(dateString) === Date.parse(currentDateString)) {
                targetDom.addClass("dp-current").addClass("disabled");
            }
        }
        if (!checkIfValid(Date.parse(dateString))) {
            targetDom.addClass("dp-used");
        }
        if (isInvalidWeek(handles.invalidDateForWeek, dateString)) {
            targetDom.html(day).attr("data-date", dateString).removeClass().addClass("dp-date").addClass("dp-pre-month").addClass("dp-pre-date").addClass("disabled");
        }
    }
    //填充当月数据
    console.log(dateString);
    for (var i = preMonthDateReserve; i < currentMonthMap[currentMonth - 1] + preMonthDateReserve; i++) {
        var day = i + 1 - preMonthDateReserve;
        var dateString = year + "/" + currentMonth + "/" + day;
        if(navigator.userAgent.indexOf("Firefox")>0){
            dateString = dateString.replace(/\-/g, "/")
            currentDateString = currentDateString.replace(/\-/g, "/")
        }
        //if((navigator.userAgent.indexOf('MSIE') >= 0) && (navigator.userAgent.indexOf('Opera') < 0)){
        //    dateString = dateString.replace(/\-/g, "/")
        //    currentDateString = currentDateString.replace(/\-/g, "/")
        //}
        //console.log(dateString);


        var targetDom = $(domHandle.find(".dp-date").get(i));
        if (Date.parse(dateString) < Date.parse(currentDateString)) {

            targetDom.html(day).attr("data-date", dateString).removeClass().addClass("dp-date").addClass("dp-pre-date").addClass("disabled");
        } else {
            targetDom.html(day).attr("data-date", dateString).removeClass().addClass("dp-date");

            if (Date.parse(dateString) == Date.parse(currentDateString)) {
                targetDom.addClass("dp-current").addClass("disabled");

            }
        }
        if (!checkIfValid(Date.parse(dateString))) {
            targetDom.addClass("dp-used").addClass("disabled", true);
        }
        if (isInvalidWeek(handles.invalidDateForWeek, dateString)) {
            targetDom.html(day).attr("data-date", dateString).removeClass().addClass("dp-date").addClass("dp-pre-date").addClass("disabled");
        }
    }
    //填充下月数据
    for (var i = preMonthDateReserve + currentMonthMap[currentMonth - 1]; i < 49; i++) {
        var day = i - preMonthDateReserve - currentMonthMap[currentMonth - 1] + 1;
        var dateString = nextYear + "/" + nextMonth + "/" + day;
        var targetDom = $(domHandle.find(".dp-date").get(i));
        if (Date.parse(dateString) < Date.parse(currentDateString)) {
            targetDom.html(day).attr("data-date", dateString).removeClass().addClass("disabled").addClass("dp-date").addClass("dp-next-month").addClass("dp-pre-date");
        } else {
            targetDom.html(day).attr("data-date", dateString).removeClass().addClass("dp-date").addClass("dp-next-month");
            if (Date.parse(dateString) === Date.parse(currentDateString)) {
                targetDom.addClass("dp-current").addClass("disabled");
            }
        }
        if (!checkIfValid(Date.parse(dateString))) {
            targetDom.addClass("dp-used").addClass("disabled");
        }
        if (isInvalidWeek(handles.invalidDateForWeek, dateString)) {
            targetDom.html(day).attr("data-date", dateString).removeClass().addClass("dp-date").addClass("dp-next-month").addClass("dp-pre-date").addClass("disabled");
        }
    }
    domHandle.find(".dp-year").html(year);
    domHandle.find(".dp-month").html(currentMonth);

    if ("true" === isReadOnly) {
        domHandle.find(" .dp-date").addClass("disabled");
        return;
    }
    //日期点击事件在此处绑定
    domHandle.find(".dp-date").unbind("click").bind("click", function (e) {
        e.stopPropagation();
        var self = this;
        if ($(self).hasClass("disabled")) {
            return;
        }
        showDetailDate(self, function (dateContent) {
            if (refreshDatePool.call(handles, self, dateContent)) {
                var datePool = handles.datePool;
                updateDateInput.call(handles, datePool[0] ? datePool[0] : 0, datePool[1] ? datePool[1] : 0);
                handles.datePool = datePool;
            }
        });
    });
}
function showDetailDate(obj, fn) {
    $(".dp-detail-clock").remove();
    var virtualHtml =
        "<div class='dp-detail-clock";
    var parentIndex = $(obj).parent().index();
    var selfIndex = $(obj).index();
    if (4 < parentIndex) {
        virtualHtml += " dp-border-no-before dp-display-reversal";
    } else {
        virtualHtml += " dp-border-no-after";
    }
    if (3 < selfIndex) {
        virtualHtml += " dp-border-right";
    }
    virtualHtml +=
        "'><table>" +
        "<tr><td>0:00</td><td>1:00</td><td>2:00</td><td>3:00</td><td>4:00</td></tr>" +
        "<tr><td>5:00</td><td>6:00</td><td>7:00</td><td>8:00</td><td>9:00</td></tr>" +
        "<tr><td>10:00</td><td>11:00</td><td>12:00</td><td>13:00</td><td>14:00</td></tr>" +
        "<tr><td>15:00</td><td>16:00</td><td>17:00</td><td>18:00</td><td>19:00</td></tr>" +
        "<tr><td>20:00</td><td>21:00</td><td>22:00</td><td>23:00</td><td>23:59</td></tr>" +
        "<tr><td colspan='3' data-date='all-day'>全天</td><td colspan='2' data-date='cancel-date'>取消</td></tr>" +
        "</table>" +
        "</div>";
    $(obj).append(virtualHtml);
    $(".dp-detail-clock").get(0).focus();
    $(obj).find("td").unbind("click").bind("click", function (e) {
        e.stopPropagation();
        $(".dp-detail-clock").remove();
        fn(this);
    });
    $(document).bind("click", function (e) {
        e.stopPropagation();
        $(".dp-detail-clock").remove();
    })
}