/**
 * Created by Administrator on 2015/7/14.
 */
yun('global/jquery-1.9.1.min.js');

var plugin = {
    elec: '',
    index: 0,
    isOpen: false,
    init: function (ele, elec) {
        this.elec = $(elec);
        this.resize();
        var self = this;
        $(window).resize(function () {
            self.resize();
        });
        this.elec.find(".nav-click").click(function () {
            self.tab($(this).parent().index());
        });
    },
    resize: function () {
        conHeight = $(window).height()
        if (conHeight > 650) {
            conHeight = 650;
        }
        this.elec.find(".tab-cont, .tab-cont iframe").css({
            height: (conHeight - 85) + "px"
        });
    },
    open: function (ele, elec) {
        if (!this.elec) {
            this.init(ele, elec);
        }
        this.elec.addClass("bar-active");
        this.isOpen = true;
        this.tab(this.index);
    },
    close: function () {
        this.elec.removeClass("bar-active");
        this.elec.find("iframe").attr("src", "");
        this.isOpen = false;
    },
    openTab: function (ele, args) {
        if(!this.elec){
            this.open(ele,'.chat-bar');
        }
        return this.tab(args.index, args.url);
    },
    tab: function (index, url) {
        if (!url) {
            url = this.elec.find(".nav-click").eq(index).data('src');
        }
        this.index = index;
        if (this.isOpen !== true) {
            return this.open('', this.elec);
        }
        this.elec.find("iframe").attr("src", "");
        this.elec.find(".nav-active").removeClass("nav-active");
        this.elec.find(".nav-click").eq(index).addClass('nav-active');
        this.elec.find(".tab-active").removeClass("tab-active");
        this.elec.find(".tab").eq(index).addClass('tab-active').find('iframe').eq(0).attr('src', url);
    }
}