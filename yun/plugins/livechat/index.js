/**
 * Created by liushengchun on 15/7/20.
 */
yun('global/jquery-1.9.1.min.js');

yun('flashTitle/index.js');

var plugin = {
    tplPool: '',
    config: '',
    intv: '',
    isMobile: '',
    init: function (ele, args) {
        this.config = args;
        this.tplPool = $(this.config.tpl);
        var self = this;
        self.intv = setInterval(function () {
            self.heartBeat();
        }, 5000);
        $(this.config.send).on("click", function () {
            self.send();
        })
        $(document).keyup(function (event) {
            if (event.keyCode == 13) {
                self.send();
            }
        });
        var urlhash = window.location.hash;
        if (!urlhash.match("fromapp")) {
            if ((navigator.userAgent.match(/(iPhone|iPod|Android|ios|iPad)/i))) {
                this.isMobile = true;
            }
        }
        this.toBottom();
    },
    toBottom: function () {
        $(window).scrollTop(999999);
        if (this.isMobile) {
            location.href = "#to_bottom";
        }
    },
    heartBeat: function () {
        var self = this;
        YunSpace.api('livechat/message/read.jsonp', {
            to_account_id: self.config.to_account_id,
            time_after: self.config.time_after
        }, function (data) {
            if (data.data && data.data.length > 0) {
                $(self.config.target).find('.isTemp').remove();
                for (var i in data.data) {
                    self.newMessage(data.data[i]);
                }
                self.toBottom();
                flashTitle.start(' 您有一条新消息 ');
            }
        });
    },
    send: function (ele, media) {
        var self = this;
        var data = {
            create_time: 0,
            id: '',
            from_account_id: this.config.from_account_id,
            to_account_id: this.config.to_account_id,
            message: null,
            media: null,
            is_sender: 1
        };
        data.id = Math.round(Math.random() * 100000);
        if (media) {
            data.media = media;
        } else {
            data.message = $(this.config.send_input).val();
            if (!data.message) {
                $(this.config.send_input).focus();
                return false;
            }
        }
        $(this.config.send_input).val('');
        self.newMessage(data);
        $(this.config.send_input).trigger('blur');
        self.toBottom();
        //Api
        YunSpace.api('livechat/message/send.jsonp', {
            to_account_id: this.config.to_account_id,
            message: data.message,
            media: data.media
        }, function (data) {
            //TODO:发送失败时标记
        });
        clearInterval(self.intv);
        self.intv = setInterval(function () {
            self.heartBeat();
        }, 5000);
    },
    newMessage: function (data, isBefore) {
        if (!data.id || $('#message_ii' + data.id).size() > 0) {
            return false;
        }
        data.is_sender *= 1;
        if (data.create_time > this.config.time_after) {
            this.config.time_after = data.create_time;
        }

        if (data.media) {
            var msg = this.newMessageMedia(data);
        } else {
            var msg = this.newMessageNormal(data);
        }
        if (isBefore) {
            msg.prependTo(this.config.target);
        } else {
            msg.appendTo(this.config.target);
        }
    },
    newMessageNormal: function (data) {
        var tpl = {};
        if (data.is_sender) {
            tpl = this.tplPool.find('.send-normal').clone();
        } else {
            tpl = this.tplPool.find('.receive-normal').clone();
        }
        if (!data.create_time) {
            tpl.addClass('isTemp');
        }
        tpl.attr('id', 'message_ii' + data.id);
        tpl.find('.avatar img').attr('src', this.config.avatar_pre + data.from_account_id + '.jpg');
        tpl.find('.received-message').html(data.message);
        return tpl;
    },
    newMessageMedia: function (data) {
        var tpl = {};
        if (data.is_sender) {
            tpl = this.tplPool.find('.send-media').clone();
        } else {
            tpl = this.tplPool.find('.receive-media').clone();
        }
        if (!data.create_time) {
            tpl.addClass('isTemp');
        }
        tpl.attr('id', 'message_ii' + data.id);
        tpl.find('.avatar img').attr('src', this.config.avatar_pre + data.from_account_id + '.jpg');
        if (data.media.url) {
            tpl.find('.share-link').attr('href', data.media.url);
        }
        tpl.find('.share-img img').attr('src', data.media.pic);
        tpl.find('.share-title').html(data.media.title);
        tpl.find('.share-des').html(data.media.des);
        if (this.config.demand_id) {
            this.insertRecommend(data.media);
        }
        return tpl;
    },
    insertRecommend: function (data) {
        YunSpace.api('recommend/add.jsonp', {
            only_add: 1,
            product_id: data.product_id,
            set_id: data.set_id,
            demand_id: this.config.demand_id,
            recommend_account_id: this.config.from_account_id
        }, function (data) {
            if (data.status == 0) {
                alert('推荐记录未能成功的插入到相关需求中');
            }
        });
    },
    loadMore: function (element) {
        $(element).hide();
        var self = this;
        var time_before = $(this.config.target).find('div').eq(1).attr('data-time');
        if (!time_before) {
            return;
        }
        YunSpace.api('livechat/message/read.jsonp', {
            to_account_id: self.config.to_account_id,
            time_before: time_before
        }, function (data) {
            if (data.data && data.data.length > 0) {
                $(self.config.target).find('.isTemp').remove();
                for (var i in data.data) {
                    self.newMessage(data.data[i], 1);
                }
            }
            if (data.data.length >= 10) {
                $(element).show().prependTo(self.config.target);
            } else {
                $(element).remove();
            }
        });
    },
    bell: function (e) {
        var audio = document.createElement('AUDIO');
        audio.setAttribute('src', '/newMsg.ogg');
        audio.play();
    }

};
