/**
 * Created by pzl on 16/7/7.
 */
(function($,win,document){
    var $$={
        searchRight:$('.search_content_right_no'),
        contUse:$('ul.cont-use'),
        btnMore:$('ul.cont-use li.more'),
        searchInput:$('.search-text-fill'),
        searchList:$('.search_list'),
        searchContWrapper:$('.search-cont-wrapper'),
        record:$('.cont-record .record'),
        noRecord:$('.cont-record .no-record'),
        btnRecordclear:$('.js-record-clear')
    };
    var f={
        init:function(){
            f.loadingMore()
                .searchTool()
                .clearRecord()
        },
        //击加载更多
        loadingMore:function(){
            $$.btnMore.on('click',function(){
                $$.contUse.css('height','auto');
                $(this).hide();
            });
            return f;
        },

        //清空历史记录
        clearRecord:function(){
            $$.btnRecordclear.on('click',function(){
                $$.record.hide();
                $$.noRecord.css('display','block');
            });
            return f;
        },

        //搜索框
        searchTool:function(){
            //搜索时的下拉列表显示/隐藏
            var searchShowHide = {
                searchShow:function(){
                    $$.searchContWrapper.addClass('hidden');
                    $$.searchList.removeClass('hidden');
                },
                searchHide:function(){
                    $$.searchContWrapper.removeClass('hidden');
                    $$.searchList.addClass('hidden');
                }
            };
            $$.searchInput.on('keyup',function(){
                searchShowHide.searchShow();
                $('#index-cross').show();
                $('#index-cross').on('click',function(){
                    $$.searchInput.val('');
                    $(this).hide();
                    searchShowHide.searchHide();
                });
                if($$.searchInput.val()==''){
                    searchShowHide.searchHide();
                }
            });
            return f;
        },
    }
})(jQuery,window,document);