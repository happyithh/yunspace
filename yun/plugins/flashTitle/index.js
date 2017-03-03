/**
 * title 闪烁.
 * 使用方法
 * 1.正确引入文件
 * 2.调用方法即可
 *
 */
var flashTitle = {
    start: function (msg) {
        this.title = document.title;
        if (!this.action) {
            try {
                this.action = function (ttl) {
                    top.document.title = ttl;
                };
            } catch (e) {
                this.action = function (ttl) {
                    document.title = ttl;
                };
                delete this.element;
            }
            this.toggleTitle = function () {
                this.action('【' + this.messages[this.index = this.index == 0 ? 1 : 0] + '】【云·Space－活动场地专家】提供会议场地_会场_会议室_找场地上云·Space');
            };
        }
        this.messages = [msg];
        var n = msg.length;
        var s = '';
        while (n > 0) {
            s += '　';
            n--;
        }
        this.messages.push(s);
        this.index = 0;
        this.timer = setInterval(function () {
            flashTitle.toggleTitle();
        }, 1000);
    },
    stop: function () {
        if (this.timer) {
            clearInterval(this.timer);
            this.action(this.title);
            delete this.timer;
            delete this.messages;
        }
    }
};
