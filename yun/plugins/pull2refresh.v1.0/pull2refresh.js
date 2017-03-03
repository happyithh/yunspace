/**
 * Created by Alex Shen on 2015/7/14.
 */
/**
 * Created by Alex Shen on 2015/6/25.
 */
yun('global/jquery-1.9.1.min.js');
//该插件用于列表页面的下拉更新
//需要传入的参数是列表更新使用的接口函数
//以及默认的，可以不填写的异常处理函数
var plugin = {
    initPlugin: function (ele, args, fn) {
        var startListen = false;
        var touchStartPos = 0;
        var shouldUpdate = false;
        var node = args;
        $(node).bind("touchstart", function () {
            if (0 === node.clientHeight + node.scrollTop - node.scrollHeight) {
                startListen = true;
                touchStartPos = window.event.touches[0].pageY;
            }
        }).bind("touchmove", function () {
            if (startListen) {
                if (touchStartPos - window.event.touches[0].pageY > 30) {
                    shouldUpdate = true;
                    touchStartPos = 0;
                    startListen = false;
                }
            }
        }).bind("touchend", function (e) {
            if (shouldUpdate) {
                fn(e);
            }
            shouldUpdate = false;
        });
    }
};
