
$(function(){
    /*清除历史记录*/
    $('.js-clearbtn').on('click',function(){
        $('.s-history dd').remove();
    });
    /*逐条清除历史记录*/
    $('.js-clear-line').on('click',function(){
        $(this).parents('dd').remove();
    });

    /*搜索框清除输入内容按钮*/
    /*搜索时下拉内容显示/隐藏*/
    var searchShowHide = {
        searchShow:function(){
            $('.s-history,.tags').show();
            $('.search-recommend').hide();
        },
        searchHide:function(){
            $('.s-history,.tags').hide();
            $('.search-recommend').show();
        }
    };
    $('#searchBox').on('keyup',function(){
        searchShowHide.searchHide();
        $('#index-cross').show().click(function(){
            $('#searchBox').val('');
            $(this).hide();
            searchShowHide.searchShow();
        });

        if($('#searchBox').val()==''){
            $('#index-cross').hide();
            searchShowHide.searchHide();
        }
    });
});