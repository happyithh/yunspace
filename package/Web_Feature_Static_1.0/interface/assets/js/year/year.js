/**
 * Created by pzl on 15/10/27.
 */
//var

$(document).ready(function () {

    var ym_id = 0;
    var t_number = 0;
    var ym_title = '';

    $(".year-cate-btn").click(function () {
        ym_id = $(this).find("input[name=yearmeeting_id]").val();
        t_number = $(this).parent().find(".ticket-number").text();
        ym_title = $(this).parent().find(".year-cate-title").children("span").text();
    });

    $('.year-submit-btn').click(function () {
        YunSpace.api('demand/yearmeeting.json', {
            'year_id': ym_id,
            'contact': $("input[name=yearmeeting_username]").val(),
            'contact_phone': $("input[name=yearmeeting_phone]").val(),
            'content': $("textarea[name=content]").val(),
            'title': ym_title,
            'ticket_number': t_number
            //'action' : 'now_consulting'
        }, function (data) {
            if (data.status == 1) {
                $('.year-submit-close').click();
            }
            alert(data.msg);
        });

    });

    //$(".year-form-submit").click(function () {
    //    YunSpace.api('demand/yearmeeting.json', {
    //        'activity_number': $("select[name=activity_number]").val(),
    //        'activity_area': $("select[name=activity_area]").val(),
    //        'action' : 'submit_demend'
    //    }, function (data) {
    //        if (data.status == 1) {
    //            //$('.year-submit-close').click();
    //        }
    //        //alert(data.msg);
    //        console.log(data);
    //    });
    //});
});