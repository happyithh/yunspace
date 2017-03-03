var isCollected = false;
$(document).ready(function () {
	//收藏
	$('.collect').click(function(){
        checkCollectArticle()
        // 收藏功能
        if (window.localStorage) {
            var history_space = localStorage.getItem('space');
            var space = JSON.parse(history_space);
            var space_id = $(this).data('space_id');
            $(this).toggleClass('active');
            if($(this).hasClass('active') == true){
                if(space==null){
                    var space = {};
                }
                space[space_id] = {};
                // 获取要收藏的数据
                space[space_id]['title'] = $('.product-title').text();
                space[space_id]['addr'] = $('.product-addr').text();
                space[space_id]['price'] = $('.product-price').text();
                space[space_id]['logo'] = $(this).data('space_logo');
                var spaceStr = JSON.stringify(space);
                localStorage.setItem('space',spaceStr);
                $('.collect').addClass('active');
                $('.js-star-move').show();
                $('.js-star-move').hide(1000);
                $('.js-star-move').addClass('starOn');
            }else{
                if(space[space_id] != null){
                    delete space[space_id];
                    var spaceStr = JSON.stringify(space);
                    localStorage.setItem('space', spaceStr);
                }
                $('.collect').removeClass('active');
            }
            toggleCollect();
        }else{
            alert("浏览器不支持收藏功能！");
        }
	});
    checkCollectArticle()
    function checkCollectArticle(){
        // ------收藏功能----------
        var history_space = localStorage.getItem('space');
        var space = JSON.parse(history_space);
        var space_id = $('.collect').data('space_id');

        if(space){
            if(space_id in space){
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
            $('.collect p').text('已收藏') ;
            $('.js-favorite').find(".icon").removeClass('ion-android-star-outline').addClass('ion-android-star');


        }else{
            $('.collect p').text('收藏') ;
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
})
