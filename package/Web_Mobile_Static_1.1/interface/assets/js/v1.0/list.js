/**
 * Created by Administrator on 2015/5/28.
 */
$(document).ready(function () {
    //document.body.style.height = window.innerHeight + 'px';
    //这里是为了防止在弹出窗口后，还能通过触摸操作对遮罩层后方的列表进行滚动操作
    $(".dayer").bind("touchstart", function (event) {
        window.event.preventDefault(window.event);
    });
    conditionPool.initListPage = function(data){
        if(data){
            conditionPool.dp = data["data"]["page"]["dp"];
            conditionPool.dn = data["data"]["page"]["dn"];
            conditionPool.dtp = data["data"]["page"]["dtp"];
        }else{
            conditionPool.dp=1;
            conditionPool.dn=12;
            conditionPool.dtp=1;
        }
    };
    //根据加载更多按钮是否可用绑定事件
    var loadMoreButton = $(".button-load");
    conditionPool["dp"] = 1;
    conditionPool["dn"] = 12;
    loadMoreButton.bind("click", eventLoadMoreList);
    var aNearbyContent = $('.nearby');
    var aTypeContent = controllerPool.aTypeContent;
    var aFliterContent = $('.filter');
    var aSortContent = $('.sort');
    var aDayer = $('.dayer');
    var sortTabSubTitleNameText = [$('.area_tab>p').text(), $('.activity_tab>p').text(), $('.industry-tab>p').text()];
    var navBar = {
        data:{
            aNearby:[$('#nearby'),"aNearbyLi",aNearbyContent],
            aType:[controllerPool.aType,"aTypeLi",aTypeContent],
            aFilter:[$('#filter'),"aFilterLi",aFliterContent],
            aSort:[$('#sort'),"aSortLi",aSortContent]
        },
        initNav:function(){
            for(var li in navBar.data) {
                navBar.data[li][0].removeClass();
            }
        },
        eventClick:function(){
            var target = $(this);
            for(var li in navBar.data) {
                if (navBar.data[li][0].attr("id") === target.attr("id")) {
                    target.toggleClass("active-link");
                    subLiPool.changeStyleWithTabSwitch(subLiPool[navBar.data[li][1]]);
                    tabPool.switchTabWithTarget(navBar.data[li][2]);
                }else{
                    navBar.data[li][0].removeClass()
                }
            }
        }
    };
    //这里存储的是列表页面的一级功能筛选tab
    var tabPool = {
        data: [aNearbyContent, aTypeContent, aFliterContent, aSortContent],
        //用于切换tab
        switchTabWithTarget: function (target) {
            for (var i = 0; i < tabPool.data.length; i++) {
                if (target === tabPool.data[i]) {
                    tabPool.data[i].toggleClass("active");
                } else {
                    tabPool.data[i].removeClass("active");
                }
            }
            if (target.hasClass("active")) {
                topBar.addClass("active");
                listGuide.addClass("active");
                aDayer.addClass("active");
            } else {
                topBar.removeClass("active");
                listGuide.removeClass("active");
                aDayer.removeClass("active");
            }
        },
        //用于收缩全部tab
        shrinkTab: function () {
            for (var i = 0; i < tabPool.data.length; i++) {
                tabPool.data[i].removeClass("active");
            }
        }
    };
    //各个一级标签下的选项
    var subLiPool = {
        data: {
            aTypeLi:$('#type-li'),
            aFilterLi:$('#filter-li'),
            aSortLi:$('#sort-li'),
            aNearbyLi:$('#nearby-li')
        },
        changeStyleWithTabSwitch: function (target) {
            for(var li in subLiPool.data) {
                if (target === subLiPool.data[li]) {
                    subLiPool.data[li].toggleClass("active-guide");
                } else {
                    subLiPool.data[li].removeClass();
                }
            }
        }
    };
    var topBar = $('.top');
    var listGuide = $(".list-guide");
    function eventLoadMoreList() {
        conditionPool.dp++;
        conditionPool.setConditionToServer(function (data) {
            loadMoreList(data);
        });
    }

    //加载更多列表项
    function loadMoreList(data) {
        //验证结果是否成功
        if (data["status"] !== "1") {
            return;
        }
        var prePageCount = (conditionPool["dp"] === 1) ? 1 : (conditionPool["dp"] - 1);
        if (prePageCount === data["data"]["page"]["dtp"]) {
            loadMoreButton.unbind("click");

            loadMoreButton.addClass("disable");
            loadMoreButton.html("加载更多...");
            return;
        }
        $(".list-item").append(data["data"]["rows"]);
        //当已经显示的列表数小于总列表数量的情况下
        //需要将加载更多按钮的样式修改为不可操作，并移除其事件监听
        if (data["data"]["page"]["dtp"] <= data["data"]["page"]["dp"]) {
            loadMoreButton.unbind("click");
            loadMoreButton.addClass("disable");
            loadMoreButton.html("已加载全部");
        } else {
            loadMoreButton.unbind("click").bind("click", eventLoadMoreList);
            loadMoreButton.removeClass("disable");
            loadMoreButton.html("加载更多...");
        }
        conditionPool.initListPage(data);
        //更新列表
        //Todo 这里应该需要增加一个表示进度的控件,这将在近期的迭代中完成
    }

    //重置列表
    function refreshList(data) {
        //验证结果是否成功
        if (data["status"] !== "1") {
            return;
        }
        //更新选中条件
        //默认一页显示10条,因此在返回列表数量超过10条的情况下需要进行截取
        $(".list-item").empty();
        $(".list-item").html(data["data"]["rows"]);
        //当已经显示的列表数小于总列表数量的情况下
        //需要将加载更多按钮的样式修改为不可操作，并移除其事件监听
        if (data["data"]["page"]["dtp"] <= data["data"]["page"]["dp"]) {
            loadMoreButton.unbind("click");
            loadMoreButton.addClass("disable");
            loadMoreButton.html("已加载全部");
        } else {
            loadMoreButton.unbind("click").bind("click", eventLoadMoreList);
            loadMoreButton.removeClass("disable");
            loadMoreButton.html("加载更多...");
        }
        conditionPool.initListPage(data);
        //更新列表
        //Todo 这里应该需要增加一个表示进度的控件,这将在近期的迭代中完成
    }

    /*guide tab*/
    $('.sort-content li').click(function () {
        $('.sort-content li').removeClass();
        $(this).addClass('sort-active');
        aSortContent.toggleClass("active");
        aDayer.removeClass("active");
        navBar.data.aSort[0].removeClass('active-link');
        subLiPool.data.aSortLi.removeClass('active-guide');
        conditionPool.orderBy = $(this).attr("data_value");
        conditionPool.initListPage(null);
        conditionPool.setConditionToServer(function (data) {
            refreshList(data);
        });
    });

    $('.type-content li').click(function () {
        window.event.preventDefault(window.event);
        aTypeContent.removeClass("active");
        aDayer.removeClass("active");
        navBar.data.aType[0].removeClass('active-link');
        subLiPool.data.aTypeLi.removeClass('active-guide');
        conditionPool.category_id = $(this).find("a").attr("data_value");
        conditionPool.initListPage(null);
        conditionPool.setConditionToServer(function (data) {
            refreshList(data);
        });
        $(".top-title").text($(this).find("a").attr("text_value"));

        $('.type-content li a').removeClass("active");
        $('.type-content li').removeClass("active");
        $(this).addClass("active");
        $(this).find("a").addClass("active");
    });
    $('.space-type-content li').click(function () {
        window.event.preventDefault(window.event);
        aTypeContent.removeClass("active");
        aDayer.removeClass("active");
        navBar.data.aType[0].removeClass('active-link');
        subLiPool.data.aTypeLi.removeClass('active-guide');
        conditionPool.category_id = $(this).find("a").attr("data_value");
        conditionPool.initListPage(null);
        conditionPool.setConditionToServer(function (data) {
            refreshList(data);
        });
        $(".top-title").text($(this).find("a").attr("text_value"));
        $('.space-type-content li a').removeClass("active");
        $('.space-type-content li').removeClass("active");
        $(this).addClass("active");
        $(this).find("a").addClass("active");
    });
    for(var nav in navBar.data){
        navBar.data[nav][0].bind("click",navBar.eventClick);
    }
    $('.dayer').bind('touchend', function (event) {
        tabPool.shrinkTab();
        navBar.initNav();
        subLiPool.changeStyleWithTabSwitch(null);
        aDayer.removeClass("active");
    });

    /*filter son select*/
    $('.area_tab_icon').click(function () {
        $('.area_tab_icon').hide();
        $('.area_tab>p').text(sortTabSubTitleNameText[0]);
        $('.area_tab').removeClass('filter-tab-select');
        $('#area li a').removeClass("active");
        $('.area_tab').removeClass('selected');
        conditionPool.size_range = 0;
        conditionPool.initListPage(null);
        conditionPool.setConditionToServer(function (data) {
            refreshList(data);
        });
    });
    $('#area li').click(function () {
        $('.area_tab').addClass('filter-tab-select');
        $('.area_tab').addClass('selected');
        $('.area_tab>p').text($(this).text());
        $('.area_tab_icon').show();
        $('#area li a').removeClass("active");
        $(this).find("a").addClass("active");
        conditionPool.size_range = $(this).find("a").attr("data-value");
        conditionPool.initListPage(null);
        conditionPool.setConditionToServer(function (data) {
            refreshList(data);
        });
    });
    $('.activity_tab_icon').click(function () {
        $(this).hide();
        $('.activity_tab>p').text(sortTabSubTitleNameText[1]);
        $('.activity_tab').removeClass('filter-tab-select');
        $('#activity li a').removeClass("active");
        $('.activity_tab').removeClass('selected');
        conditionPool.activity = "";
        conditionPool.initListPage(null);
        conditionPool.setConditionToServer(function (data) {
            refreshList(data);
        });
    });
    $('#activity li').click(function () {
        $('.activity_tab').addClass('filter-tab-select');
        $('.activity_tab>p').text($(this).text());
        $('.activity_tab_icon').show();
        $('#activity li a').removeClass("active");
        $('.activity_tab').addClass('selected');
        $(this).find("a").addClass("active");
        conditionPool.activity = $(this).find("a").attr("data-value");
        conditionPool.initListPage(null);
        conditionPool.setConditionToServer(function (data) {
            refreshList(data);
        });
    });

    $('.industry_tab_icon').click(function () {
        $(this).hide();
        $('.industry-tab>p').text(sortTabSubTitleNameText[2]);
        $('.industry-tab').removeClass('filter-tab-select');
        $('#industry li a').removeClass("active");
        $('.industry-tab').removeClass('selected');
        conditionPool.industry = "";
        conditionPool.initListPage(null);
        conditionPool.setConditionToServer(function (data) {
            refreshList(data);
        });
    });
    $('#industry li').click(function () {
        $('.industry-tab').addClass('filter-tab-select');
        $('.industry-tab>p').text($(this).text());
        $('.industry_tab_icon').show();

        $('#industry li a').removeClass("active");
        $(this).find("a").addClass("active");
        $('.industry-tab').addClass('selected');
        conditionPool.industry = $(this).find("a").attr("data-value");
        conditionPool.initListPage(null);
        conditionPool.setConditionToServer(function (data) {
            refreshList(data);
        });
    });

    /*filter tab*/
    $('#area-tab').click(function () {
        $('#area').show();
        $('#activity').hide();
        $('#industry').hide();
        $('#area-tab').addClass('filter-tab-active');
        $('#activity-tab').removeClass('filter-tab-active');
        $('#industry-tab').removeClass('filter-tab-active');
    });
    $('#activity-tab').click(function () {
        $('#area').hide();
        $('#activity').show();
        $('#industry').hide();
        $('#activity-tab').addClass('filter-tab-active');
        $('#area-tab').removeClass('filter-tab-active');
        $('#industry-tab').removeClass('filter-tab-active');
    });
    $('#industry-tab').click(function () {
        $('#area').hide();
        $('#activity').hide();
        $('#industry').show();
        $('#industry-tab').addClass('filter-tab-active');
        $('#area-tab').removeClass('filter-tab-active');
        $('#activity-tab').removeClass('filter-tab-active');
    });

    $('.nearby-tab li').click(function () {
        $('.nearby-tab li').removeClass();
        $(this).addClass('nearby-active');
        var curIndex = $('.nearby-tab li').index(this);
        $('.nearby-right ul').removeClass("active");
        $('.nearby-right ul').eq(curIndex).addClass("active");
        conditionPool.position_range_buffer = $(this).attr("data-value");
    });

    //$('.nearby-right li').click(function () {
    //    $('.nearby-right li').removeClass();
    //    $(this).addClass('nearby-select');
    //    aNearbyContent.removeClass("active");
    //    aDayer.removeClass("active");
    //    navBar.data.aNearby[0].removeClass('active-link');
    //    subLiPool.data.aNearbyLi.removeClass('active-guide');
    //    conditionPool.position_range = conditionPool.position_range_buffer;
    //    conditionPool.position = $(this).attr("data-value");
    //    conditionPool.initListPage(null);
    //    conditionPool.setConditionToServer(function (data) {
    //        refreshList(data);
    //    });
    //});

    $(".js-btn-confirm").bind("click",function(){
        aDayer.removeClass("active");
        conditionPool.price_start = $(".price-range-low").val();
        conditionPool.price_end = $(".price-range-high").val();
        conditionPool.initListPage(null);
        conditionPool.setConditionToServer(function (data) {
            refreshList(data);
        });
        tabPool.shrinkTab();
    });
    $(".js-btn-clear").bind("click",function(){
        aDayer.removeClass("active");
        $(".price-range-low").val("");
        $(".price-range-high").val("");
        conditionPool.price_start = "";
        conditionPool.price_end = "";
        conditionPool.initListPage(null);
        conditionPool.setConditionToServer(function (data) {
            refreshList(data);
        });
        tabPool.shrinkTab();
    });

    //var oBtn = $("#topcontrol");
    //var timer = null;
    //var bSys = true;
    //window.onscroll = function () {
    //    if (!bSys) {
    //        clearInterval(timer);
    //    }
    //    bSys = false;
    //}
    //oBtn.bind("click",function () {
    //    timer = setInterval(function () {
    //        var scrollTop = document.documentElement.scrollTop || document.body.scrollTop;
    //        var iSpeed = Math.floor(-scrollTop / 4);
    //        if (scrollTop == 0) {
    //            clearInterval(timer);
    //        }
    //        bSys = true;
    //        document.body.scrollTop = document.documentElement.scrollTop = scrollTop + iSpeed;
    //    }, 30);
    //});
    //window.onscroll = function () {
    //    var scrollTop = document.documentElement.scrollTop || document.body.scrollTop;
    //    if (scrollTop < 100) {
    //        oBtn.css("display","none");
    //    } else {
    //        oBtn.css("display","block");
    //    }
    //}
});