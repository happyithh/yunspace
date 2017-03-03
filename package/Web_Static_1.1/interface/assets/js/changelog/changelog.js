/**
 * Created by Administrator on 2015/7/10.
 */
var plugin = {
    show: function (element, args, callback) {
        console.log(element);
        $(element).addClass("update-name-active");
        $(element).parent().siblings().find(".update-name").removeClass("update-name-active");
        var id=$(element).data("id");
        var showId=$("#"+id);
        showId.show();
        showId.siblings().hide();
    }

};