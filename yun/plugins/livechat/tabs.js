yun('global/jquery-1.9.1.min.js');
var plugin = {
    frame: '',
    init: function (element, args, callback) {
        var self = this;
        self.frame = $(element).find('iframe');
        var height = $(document).height() - 46;
        self.frame.height(height);
        if (!args.index) {
            args.index = 0;
        }
        self.changeTab($(".tab-link").eq(args.index), {
            url: args.url
        });
        $(".tab-link").click(function () {
            self.changeTab(this);
        });
        $(window).on("resize", function () {
            var height = $(document).height() - 46;
            self.frame.height(height);
        });
    },
    changeTab: function (element, args, callback) {
        $(element).parents('ul').find("span").removeClass("tab-active");
        $(element).find("span").addClass("tab-active");
        this.changeSrc(args && args.url ? args.url : $(element).attr('yun-url'));
    },
    changeSrc: function (src) {
        this.frame.attr("src", src);
    }
}