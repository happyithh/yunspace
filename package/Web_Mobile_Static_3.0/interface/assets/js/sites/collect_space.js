var isCollected = false;
$(document).ready(function () {
    //收藏
    $('.collect').click(function () {
        checkCollectArticle()
        // 收藏功能
        if (window.localStorage) {
            var history_space = localStorage.getItem('space_item');
            var space = JSON.parse(history_space);
            var item_id = $(this).data('space_id');
            $(this).toggleClass('active');
            if ($(this).hasClass('active') == true) {
                if (space == null) {
                    var space = {};
                }
                space[item_id] = {};
                // 获取要收藏的数据
                space[item_id]['title'] = $(this).data('item_name');
                space[item_id]['url'] = $('.getSpaceItemUrl').attr('href');
                space[item_id]['addr'] = $('.adress').text();
                space[item_id]['price'] = $('.price_start').data('min_price');
                if(space[item_id]['price']==''){
                    space[item_id]['price'] = '面议';
                }
                space[item_id]['logo'] = $(this).data('space_logo');
                var spaceStr = JSON.stringify(space);
                localStorage.setItem('space_item', spaceStr);
                $('.collect').addClass('active');
                $('.js-star-move').show();
                $('.js-star-move').hide(1000);
                $('.js-star-move').addClass('starOn');
            } else {
                if (space[item_id] != null) {
                    delete space[item_id];
                    var spaceStr = JSON.stringify(space);
                    localStorage.setItem('space_item', spaceStr);
                }
                $('.collect').removeClass('active');
            }
            toggleCollect();
        } else {
            alert("浏览器不支持收藏功能！");
        }
    });
    checkCollectArticle()
    function checkCollectArticle() {
        // ------收藏功能----------
        var history_space = localStorage.getItem('space_item');
        var space = JSON.parse(history_space);
        var space_id = $('.collect').data('space_id');

        if (space) {
            if (space_id in space) {
                isCollected = true;
                $('.collect').addClass('active');

            } else {
                isCollected = false;
            }

        } else {
            isCollected = false;
        }

        toggleCollect();
    }

    function toggleCollect() {
        if ($('.collect').hasClass('active')) {
            $('.collect p').text('已收藏');
            $('.js-favorite').find(".icon").removeClass('ion-android-star-outline').addClass('ion-android-star');


        } else {
            $('.collect p').text('收藏');
            $('.js-favorite').find(".icon").removeClass('ion-android-star').addClass('ion-android-star-outline');

        }
    }

    Object.size = function (obj) {
        var size = 0, key;
        for (key in obj) {
            if (obj.hasOwnProperty(key)) size++;
        }
        return size;
    };
})
