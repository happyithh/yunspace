var isCollected = false;
$(document).ready(function () {
    //收藏
    //var isLoadData = false
    $('.collect').click(function(){

        checkCollectArticle()

        if (window.localStorage) {
            var history_article = localStorage.getItem('article');
            var article = JSON.parse(history_article);
            var article_id = $('.zan-collect-btn-collection').data('article_id');

            if(!window.isCollected){
                if (article == null) {
                    var article = {};
                }
                // 文章需要收藏的数据
                article[article_id] = {};
                article[article_id]['title'] = $('.article_content_title').text();
                article[article_id]['author'] = $('.article_author').text();
                article[article_id]['logo'] = $(this).data('article_logo');
                article[article_id]['counter_view'] = $(this).data('article_counter_view');
                article[article_id]['counter_praise'] = $('.counter_praise').text();
                var articleStr = JSON.stringify(article);
                localStorage.setItem('article', articleStr);
                $('.collect').addClass('active');

                var cart = $('.nav-point');
                var cloneStar = $('.js-star-move').clone()
                cloneStar.show().offset({ top:$('.collect .icon').offset().top, left:$('.collect .icon').offset().left })
                    .css({'opacity':'0.7', 'position':'absolute','z-index':'1000'})
                    .appendTo($('body'))
                    .animate({
                        'top':cart.offset().top,
                        'left':cart.offset().left
                    }, 500);
                cloneStar.animate({'width':0, 'height':0}, function(){ $(this).detach();$(this).remove()});

            }else{
                // 取消收藏

                if (article[article_id] != null) {
                    delete article[article_id];
                    var articleStr = JSON.stringify(article);
                    localStorage.setItem('article', articleStr);
                }
                $('.collect').removeClass('active');
            }

            toggleCollect();
        } else {
            alert("该浏览器不支持收藏功能！")
        }

    });

    checkCollectArticle()
    function checkCollectArticle(){
        // ------收藏功能----------
        var history_article = localStorage.getItem('article');
        var article = JSON.parse(history_article);
        var article_id = $('.zan-collect-btn-collection').data('article_id');
        if(article){
            if(article_id in article){
                isCollected = true;
                $('.collect').addClass('active');

            }else{
                isCollected = false;
            }

        }else{
            isCollected = false;
        }

        toggleCollect();
    }
    function toggleCollect(){
        if($('.collect').hasClass('active')){
            $('.collect span').text('已收藏') ;
            $('.js-favorite').find(".icon").removeClass('ion-android-star-outline').addClass('ion-android-star');


        }else{
            $('.collect span').text('收藏') ;
            $('.js-favorite').find(".icon").removeClass('ion-android-star').addClass('ion-android-star-outline');

        }
    }
    Object.size = function(obj) {
        var size = 0, key;
        for (key in obj) {
            if (obj.hasOwnProperty(key)) size++;
        }
        return size;
    };

});



