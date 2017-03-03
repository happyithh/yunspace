/**
 * Created by pzl on 15/12/18.
 */
var plugin={
    nodes:{},
    init:function(){
        this.nodes={
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
        this.loadingMore()
            .searchTool()
            .clearRecord()
            .showSearch();
    },

    //击加载更多
    loadingMore:function(){
        var that=this;
        that.nodes.btnMore.on('click',function(){
            that.nodes.contUse.css('height','auto');
            $(this).hide();
        });
        return that;
    },

    //清空历史记录
    clearRecord:function(){
        var that=this;
        that.nodes.btnRecordclear.on('click',function(){
            that.nodes.record.hide();
            that.nodes.noRecord.css('display','block');
        });
        return that;
    },

    //搜索框
    searchTool:function(){
        var that=this;

        //搜索时的下拉列表显示/隐藏
        var searchShowHide = {
            searchShow:function(){
                that.nodes.searchContWrapper.addClass('hidden');
                that.nodes.searchList.removeClass('hidden');
            },
            searchHide:function(){
                that.nodes.searchContWrapper.removeClass('hidden');
                that.nodes.searchList.addClass('hidden');
            }
        };

        that.nodes.searchInput.on('keyup',function(){
            searchShowHide.searchShow();
            $('#index-cross').show();
            $('#index-cross').on('click',function(){
                that.nodes.searchInput.val('');
                $(this).hide();
                searchShowHide.searchHide();
            });
            if(that.nodes.searchInput.val()==''){
                searchShowHide.searchHide();
            }
        });
        return that;
    },
    showSearch:function(ele,args,fn){
        console.log(13132);
        $(".search_input").on("click",function(){
            console.log(312312);
        });
        //$(".search-body").removeClass('none');
        //var body=$(args.page_body).attr('yun-load');
        //yun.load(body, function (ele) {
        //
        //}, 1);
    }

}