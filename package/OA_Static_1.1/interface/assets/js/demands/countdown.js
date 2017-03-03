/**
 * Created by zzc on 2015/12/16.
 */
//给个时间戳 倒计时
var countdown = function () {
    var list = [],
        interval;

    return function (id, time) {
        if (!interval)
            interval = setInterval(go, 1000);
        list.push({ele: document.getElementById(id), time: time});
    }

    function go() {
        for (var i = 0; i < list.length; i++) {
            list[i].ele.innerHTML = getTimerString(list[i].time ? list[i].time -= 1 : 0);
            if (!list[i].time)
                list.splice(i--, 1);
        }
    }

    function getTimerString(time) {
        d = Math.floor(time / 86400),
            h = Math.floor((time % 86400) / 3600),
            m = Math.floor(((time % 86400) % 3600) / 60),
            s = Math.floor(((time % 86400) % 3600) % 60);
        if (time > 0) {
            var timeString = '';
            if (d) {
                timeString = timeString + d + '天';
            }
            if (h) {
                timeString = timeString + h + '小时';

            }
            if (m) {
                timeString = timeString + m + '分';
            }
            return timeString + s + "秒";


        } else {
            return "0";
        }
    }
}();