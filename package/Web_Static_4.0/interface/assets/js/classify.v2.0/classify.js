$(document).ready(function () {
    $('.classify_tab_ul li a').remove();
    $('.tags_tab li div').hover(function () {
        //$(this).css('background','#f8f8f8');
        $(this).find("ul").css('display', 'block');
    }, function () {
        $(this).find('ul').css('display', 'none');
        //$(this).css('background','#fff');
    });
    $(".div_box span").click(function () {
        handleTopArticleClassifyClick(this);
    });
    $('.classify_tab_ul li').click(function () {
        handleTopArticleClassifyClick(this);
        $(this).siblings().show();
        $(this).hide();
        if (!localStorage.getItem('seo_title')) {
            localStorage.setItem('seo_title', document.title);
        }
        document.title = stc + ',' + localStorage.getItem('seo_title');
    });
    var wh=$(window).height(),ws;
    $(window).on('resize', function () {
        wh=$(window).height();
    });
    function toTop(){
        $(window).on("scroll",function(){
            ws=$(this).scrollTop();
            wh=$(this).height();
            if(ws>wh){
                if(!$('.to-top').hasClass('none'))return;
                $('.to-top').removeClass('none');
            }else{
                if($('.to-top').hasClass('none'))return;
                $('.to-top').addClass('none');
            }
        });
        $('.to-top').on('click',function(){
            var winOffH=$(window).scrollTop();
            var t=setInterval(function(){
                var st=$(window).scrollTop();
                if(st<=0){
                    clearInterval(t);
                }
                winOffH-=100;
                $(window).scrollTop(winOffH);
            },1);
        });
    }
    toTop();

    $('.tags_tab li div:first').click(function () {
        $('.tags_tab li div').removeClass('tags_tab_active')
        $(this).addClass('tags_tab_active');
    });
    $(".classify_more").on('click', function () {
        $(".tags_tab").css({
            height: "auto"
        });
    });
    $(".classify_load_more").on('click', function () {
        var page_body = $(this).data("page_body");
        //var load_src = $(page_body).attr('yun-load');
        var load_src = window.location.href;
        var page = $(page_body).attr('yun-page');
        var max_page = $(page_body).attr('yun-page_max');
        if ((page * 1) >= (max_page * 1)) {

            $(this).text('已加载全部');
            return false;
        }
        var next_page = page * 1 + 1;
        $(page_body).attr('yun-page', next_page);
        //alert(load_src);
        var c_id = $(".tags_tab_active").attr('value');

        function isSetId(id, o) {
            var idStr = localStorage.getItem("classify_id");
            var idArr = idStr.split(',');
            if ($.inArray(id + "", idArr) < 0) {
                return false;
            } else {
                return true;
            }
        }

        var search = {};
        search['category'] = c_id;
        var token_part1 = $('.token_part1').val();
        var token_part2 = $('.token_part2').val();
        var token_part3 = $('.token_part3').val();
        var token = token_part1 + token_part2 + token_part3;
        if (!token) {
            return false;
        }
        $.ajax({
            type: "get",
            url: load_src,
            data: {
                action: 'page_list_load_more',
                search: search,
                token: token,
                page: next_page
            },
            dataType: "html",
            success: function (htm) {

                if (htm.length > 500) {
                    $(page_body).append(htm);
                    var classifyFH = $(".classify_fl").outerHeight();
                    var classifyRtH = $(".classify_rt").outerHeight();
                    if (classifyFH > classifyRtH) {
                        $(".classify_rt").addClass('fixed').removeClass('classify_rt_absolute');
                    }
                    //var t=$$.fixedRtIcon.offset().top;
                    var t = $(".fixed-rt-icon").offset().top;
                    $(".js-action").removeClass('classify_left_guide_absolute').addClass('classify_left_guide_fixed').css({
                        top: t + "px"
                    });
                    $('.zan').each(function (index, dom) {
                        var id = $(dom).data('id');
                        if (isSetId(id, $(dom))) {
                            $(dom).addClass('active');
                        }
                    });
                }
            }
        });
    });

});
/**
 * 处理头部文章分类的点击
 */
function handleTopArticleClassifyClick(e) {
    if (!e) {
        return false;
    }
    var stc = $(e).text();
    var c_id = $(e).attr('value');
    $(e).parents('.classify_tab').find('span').text(stc);
    $('.classify_tab').removeClass('tags_tab_active');
    $(e).parents('.classify_tab').addClass('tags_tab_active');
    $(e).parents('.classify_tab').attr('value', c_id);
    //每次分类重置分页
    $('#article_list_body').attr('yun-page', 1);
}




