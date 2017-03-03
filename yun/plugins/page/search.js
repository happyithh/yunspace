yun('global/jquery-1.11.1.min.js');

var plugin = {
    request: function (element, args, callback) {
        var page_body = yun.initialArgs($(args.page_body));
        if (!page_body.args.search) {
            page_body.args.search = {};
        }
        page_body.args.search[$(element).attr('name')] = $(element).val()? $(element).val():$(element).attr('value');
        if (args.submit) {
            this.submit(element, args,this.clickZan);
        }
    },
    submit: function (element, args, callback) {
        yun('page/paging.js::goto', {
            page_body: args.page_body,
            page: 1
        }, callback);
    }
}
