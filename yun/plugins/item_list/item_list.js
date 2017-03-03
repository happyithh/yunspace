yun('global/jquery-1.11.1.min.js');

var plugin = {
    itemInfo: function (element, args, callback) {
        var allItems = $(args.items).find('.subspace-cont');
        var thisItem = allItems.eq($(element).index());
        yun.load(thisItem, function (ele) {
            allItems.hide().removeClass('padding-bottom');
            thisItem.show().addClass('padding-bottom');
            $(element).parent().find("li").removeClass("current");
            $(element).addClass("current");
        });
    },
    load:function(element, args, callback){
        yun.load(element, function (ele) {
        }, 1);
    },

}
