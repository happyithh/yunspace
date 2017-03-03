/**
 * Created by bll on 15/7/16.
 */
var plugin = {
    cate: 'space',
    demand_id: '',
    recommend_id: '',
    group_id: '',
    showDemand: function (element, args, callback) {
        $(".change").removeClass("change-click-active");
        $(element).addClass("change-click-active");
        var move = 100 * (args['id'] - 1);
        var index = parseInt(args['id']) - 1;
        var tab = $(".tab-demand").eq(index);
        tab.siblings().hide();
        if (index == 2) {
            $(".change").eq(index).find("span").css({
                color: "#ffffff"
            })

        } else {
            $(".change").eq(2).find("span").css({
                color: "#d5cfcf"
            })
        }
        tab.fadeIn(200);
    },
    showState: function (element, args, callback) {
        $(element).find("span").toggleClass("ion-chevron-up");
        $(element).parent().parent().next().find(".record-state").fadeToggle(200);
    },
    stateActive: function (element, args, callback) {
        if (args['feedback']) {
            YunSpace.api('recommend/customerfeedback.jsonp', {
                feedback: args['feedback'],
                demand_id: args['demand-id'],
                recommend_id: args['recommend-id']
            }, function (data) {
                if (data.status == 1) {
                    $(".record-state").fadeOut(400);
                } else {
                    alert(data.msg);
                }
            });
        }
        window.location.reload();
    },
    makeActive: function (element, args, callback) {
        $(element).parent().siblings().find("a").removeClass("record-make-active");
        $(element).addClass("record-make-active");
    },
    //showMake: function (element, args, callback) {
    //    $(element).find("span").toggleClass("ion-chevron-up");
    //    $(".record-make").fadeToggle(200);
    //},
    showMake: function (element, args, callback) {
        $(element).find("span").toggleClass("ion-chevron-up");
        $(".record-make").fadeToggle(200);
        if ($(".js-more-recommend-click").find('span').hasClass("ion-close-circled")) {
            $(".js-more-recommend-click").find('span').removeClass("ion-close-circled");
            $(".js-more-recommend-click").find('span').addClass("ion-plus-circled");
            $(".demand-body-more").removeClass("demand-body-more-active");
        }
    },
    tabActive: function (element, args, callback) {
        $(element).parent().siblings().find(".demand-tab-change-list-click").removeClass("demand-tab-change-list-click-active");
        $(element).addClass("demand-tab-change-list-click-active");
        var tabId = args['id'];
        $(".demand-tab").eq(tabId).siblings().hide();
        $(".demand-tab").eq(tabId).fadeIn(400);
    },
    showRecommend: function (element, args, callback) {
        this.demand_id = args['demand_id'];
        this.account_id = args['account_id'];
        $(".record-state").fadeOut(400);
        $(".js-more-recommend-click").find('span').toggleClass("ion-close-circled");
        $(".js-more-recommend-click").find('span').toggleClass("ion-plus-circled");
        $(".demand-body-more").toggleClass("demand-body-more-active");

        if ($(".js-more-make-click").find("span").toggleClass("ion-chevron-up")) {
            $(".js-more-make-click").find("span").removeClass("ion-chevron-up");
            $(".record-make").fadeOut(200);
        }
    },
    showRecommendModal: function (element, args, callback) {
        var cate = $(element).data("id");
        var title;
        /*cate区分搜索的内容*/
        switch (cate) {
            case 'set':
                cate = "set";
                this.cate = 'set';
                title = "请搜索推荐套餐";
                break;
            case 'room':
                cate = "space";
                this.cate = 'space';
                title = "请搜索推荐场地";
                break;
            case 'service':
                cate = "service";
                this.cate = 'service';
                title = "请搜索推荐配套服务";
                break;
        }
        $(".cover").fadeIn(400);
        $(".js-recommend-demand-search").fadeIn(400);
        $(".js-search-recommend-title").html(title);
        $(".demand-body-more").removeClass("demand-body-more-active");
        $(".js-more-recommend-click").find('span').removeClass("ion-close-circled");
        $(".js-more-recommend-click").find('span').addClass("ion-plus-circled");
    },
    closeRecommendModal: function (element, args, callback) {
        $(".cover").fadeOut(400);
        $(".js-recommend-demand-search").fadeOut(400);
        $(element).parent('div').hide();
        $(".js-search-result").html('');
    },
    searchResult: function (element) {
        $(".js-search-result").html('');
        var ht = "";
        var proName = $('.js-search-input').val();
        var cate = this.cate;
        var demand_id = this.demand_id;
        var account_id = this.account_id;
        YunSpace.api('product/search/all.jsonp', {
            action: cate,
            q: proName,
            account_id: account_id
        }, function (data) {
            if (data.status == 1) {
                var dataList = data.data;
                for (var key in dataList) {
                    newList = $("#js-search-result").find('.hidden').clone().removeClass('hidden');
                    newList.find('.result-title').text(dataList[key]['native_name']);
                    newList.find('span').attr('data-id', dataList[key]['id']);
                    newList.find('span').attr('data-cate', cate);
                    newList.find('span').attr('data-demand-id', demand_id);
                    $(".js-search-result").append(newList);
                }
                $(".js-search-result").append(ht);
                demandRecommend('.js-recommend-submit');
            }
        })
    },
    demandTakeLook: function (element, args) {
        this.recommend_id = args['recommend-id'];
        this.demand_id = args['demand-id'];
        $(".record-state").fadeOut(400);
        $(".cover").fadeIn(400);
        $(".demand-take-look").fadeIn(400);
    },
    demandTakeLookSubmit: function (element, args) {
        var look_remark = $(".take-look-remark").val();
        //var look_time
        var month = $("select[name=take-look-month]").find('option:selected').text();
        var day = $("select[name=take-look-day]").find('option:selected').text();
        var time = $("select[name=take-look-time]").find('option:selected').text();
        YunSpace.api('recommend/takelook.jsonp', {
            demand_id: this.demand_id,
            recommend_id: this.recommend_id,
            look_remark: look_remark,
            look_time: month + '-' + day + '-' + time
        }, function (data) {
            if (data.status == 1) {
                $('.js-close').click();
            } else {
                alert(data.msg);
            }
        });
    },
    demandRecommendRemarkSubmit: function (element, args) {
        var remark = $('.demand_recommend_remark').val();
        YunSpace.api('recommend/remark.jsonp', {
            recommend_id: args['recommend-id'],
            demand_id: args['demand-id'],
            remark: remark
        }, function (data) {
            if (data.status == 1) {
                alert(data.msg);
                window.location.reload();
            } else {
                alert(data.msg);
            }
        });
    },
    demandRenew: function (element, args) {
        YunSpace.api('demand/renew.jsonp', {
            demand_id: args['demand_id']
        }, function (data) {
            if (data.status == 1) {
                window.location.href = 'chat_demand';
            } else {
                alert(data.msg);
            }
        });
    },
    demandRecommendRemarkShow: function (element, args) {
        $(element).hide();
        $(args['show']).fadeIn(300);
    }
};
function demandRecommend(e) {
    $(e).on('click', function (e) {
        var id = $(this).attr('data-id');
        var cate = $(this).attr('data-cate');
        var demand_id = $(this).attr('data-demand-id');
        YunSpace.api('recommend/add.jsonp', {
            product_id: cate == 'set' ? '' : id,
            set_id: cate == 'set' ? id : '',
            demand_id: demand_id
        }, function (data) {
            if (data.status == 1) {
                window.location.href = 'chat_demand_recommend?demand_id=' + demand_id;
            } else {
                alert(data.msg);
            }
            $(".js-close").click();
        });
    });
}


