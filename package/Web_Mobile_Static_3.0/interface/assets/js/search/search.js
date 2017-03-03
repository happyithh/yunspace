
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
            var searchContent = $('.search-input').val();
            $('.s-history,.tags').hide();
            var url = $('.search-recommend').data('url');
            var url_name = url+"action=space_name?keyword="+searchContent;
            var url_add = url+"action=address?keyword="+searchContent;
            //$('.search-recommend').find('.search-name span').eq(0).text('搜索含 '+searchContent+' 名称的');
            //$('.search-recommend').find('.search-addr span').eq(0).text('搜索含 '+searchContent+' 名称的');
            YunSpace.api('search/getbaikecount.jsonp', {
                q:searchContent
            },function (data) {
                if(data.status == 1){
                    console.log(data.data);
                    //alert(data.data['name_count']);
                    $('.search-recommend').find('li').eq(0).html("<a href='"+url_name+"'><p class='fl search-name'><span>搜索含 "+searchContent+" 名称的</span><span class='orange'>场地</span></p> <span class='fr result name-result'>"+data.data['name_count']+"个结果</span></a>");
                    $('.search-recommend').find('li').eq(1).html("<a href='"+url_add+"'><p class='fl search-name'><span>搜索含 "+searchContent+" 名称的</span><span class='orange'>地址</span></p> <span class='fr result name-result'>"+data.data['addr_count']+"个结果</span></a>");
                    //$('.search-recommend').find('.name-result').text(data.data['name_count']+'个结果');
                    //$('.search-recommend').find('.addr-result').text(data.data['addr_count']+'个结果');
                    //window.location.href=url;
                }
            });
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

    /*按回车键默认选中第一个（搜索场地）*/
    $("body").keydown(function() {
        if (event.keyCode == "13") {//keyCode=13是回车键
            window.location.href='http://www.baidu.com'
        }
    });

});