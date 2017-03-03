yun('global/jquery-1.11.1.min.js');

var plugin = {
    next: function (element, args, callback) {
        var page_body = yun.initialArgs($(args.page_body));
        if (!page_body.args.page) {
            page_body.args.page = 1;
        }
        page_body.args.page++;
        if (page_body.args.page >Math.ceil(page_body.args.page_dt/page_body.args.page_size) ) {
            //alert('已经达到最大页~');
            page_body.args.page--;
            return false;
        }
        //page_body.args.page++;
        yun.load(page_body, function (ele) {
            $(ele.args.page_display).val(ele.args.page);        //页码显示
        }, 1);
    },
    prev: function (element, args, callback) {
        var page_body = yun.initialArgs($(args.page_body));
        if (!page_body.args.page) {
            page_body.args.page = 1;
        }
        if (page_body.args.page < 2) {
            //alert('已经达到第1页~');
            return false;
        }
        page_body.args.page--;
        yun.load(page_body, function (ele) {
            $(ele.args.page_display).val(ele.args.page);        //页码显示
        }, 1);
    },
    size: function (element, args, callback) {

        var page_body = yun.initialArgs($(args.page_body));
        page_body.args.page = 1;
        page_body.args.page_size = $(element).val();
        yun.load(page_body, function (ele) {
            $(page_body.args.page_total_id).html(Math.ceil(page_body.args.page_dt/page_body.args.page_size));
            $(ele.args.page_display).val(ele.args.page);        //页码显示
        }, 1);
    },
    goto: function (element, args, callback) {
        var page_body = yun.initialArgs($(args.page_body));
        if (args.page) {
            var page_num = args.page;
        } else {
            var page_num = $(element).val() * 1;
        }
        if (page_num < 1) {
            console.log("请输入正常页码");
            return false;
        }
        if (Math.ceil(page_body.args.page_dt/page_body.args.page_size) < page_num) {
            console.log('已经超过最大页~');
            return false;
        }
        page_body.args.page = page_num;
        yun.load(page_body, function (ele) {
            $(ele.args.page_display).val(ele.args.page);        //页码显示
        }, 1);
    },
    load:function(element, args, callback){
        yun.load(element, function (ele) {
        }, 1);
    },
    setTotal: function (element, args, callback) {
        var page_body = yun.initialArgs($(args.page_body));
        if(args.total){
            page_body.args.page_dt = args.total;
            $(page_body.args.page_total_id).html(Math.ceil(page_body.args.page_dt/page_body.args.page_size));
        }else{
            $(page_body.args.page_total_id).html(0);
        }
    }
}
