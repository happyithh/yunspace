/**
 * Created by liushengchun on 15/7/20.
 */
yun('global/jquery-1.9.1.min.js');

var plugin = {
    isInit: false,
    type: '',
    tempData: {},
    init: function (ele, args) {
        this.isInit = true;
        var self = this;
        $(".search-input").on("keyup", function (media) {
            var proName = $(".search-input").val();
            YunSpace.api('product/search/all.jsonp', {
                action: self.type,
                q: proName
            }, function (data) {
                self.showResult(data.data);
                //yun("livechat/read.js::send", data);
            });
        })
    },
    showRecommend: function (element, args, callback) {
        $(".js-message-body-more").toggleClass("message-more-active");
        $(".js-message-icon").toggleClass("rotate");
    },
    showSearch: function (element, args, callback) {
        if (!this.isInit) {
            this.init();
        }
        this.type = args.id;
        $(".js-search-recommend-title").html($(element).html());
        $(".cover").fadeIn(400);
        $(".js-recommend-search").fadeIn(400);
        $(".js-message-body-more").removeClass("message-more-active");
        $(".js-message-icon").removeClass("rotate");
        $(".js-close,.cover").on("click", function () {
            $(".cover").fadeOut(400);
            $(".js-recommend-search").fadeOut(400);
            $(".js-search-result").html('');
        });
    },
    showResult: function (data) {
        this.tempData = {};
        var ht = '';
        for (var i in data) {
            this.tempData[data[i].id] = data[i];
            ht += '<li><p class="result-title">' + data[i].name + '</p><p class="recommend-submit" data-id="' + data[i].id + '">推荐</p><div class="clear"></div></li>';
        }
        var self = this;
        $('.js-search-result').html(ht).find('.recommend-submit').click(function () {
            self.sendRecommend($(this).data('id'));
        });
    },
    sendRecommend: function (id) {
        $(".js-close,.cover").trigger("click");
        if (this.tempData[id]) {
            var media = {
                pic: this.tempData[id].logo,
                title: this.tempData[id].native_name,
                des: this.tempData[id].des,
                url: this.tempData[id].url,
                product_id: this.type == 'set' ? '' : id,
                set_id: this.type == 'set' ? id : ''
            };
            yun('livechat/index.js::send', media);
        }
    }
}