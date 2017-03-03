var plugin = {
    wow: function (element, args, callback) {
        var wow = $(".js-wow");
        var wn = $(".wow-num-1");
        var num = wn.text();
        var title_id = $(".wow-num-1").attr('title_id');
        //wow.find(".wow-1").toggleClass("wow-active");
        var praise = wn.attr("praise");
        var url = wn.attr('yun');

        //if (wow.find(".wow-1").hasClass("wow-active")) {
        //if (praise == 1) {
        //    YunSpace.api('raiders/praise/down.json', {
        //        id: title_id
        //    }, function (data) {
        //        if (data.status == 1) {
        //            $(function () {
        //                num--;
        //                wn.text(num);
        //                wn.attr("praise",0);
        //                wow.find(".wow-1").removeClass("wow-active");
        //            })
        //        } else {
        //            alert(data.msg);
        //        }
        //    });
        //} if (praise == 0){
        //    YunSpace.api('raiders/praise/up.json', {
        //        id: title_id
        //    }, function (data) {
        //        if (data.status == 1) {
        //            $(function () {
        //                num++;
        //                wn.text(num);
        //                wn.attr("praise",1);
        //                wow.find(".wow-1").addClass("wow-active");
        //            })
        //        } else {
        //            alert(data.msg);
        //        }
        //    });
        //}
            YunSpace.api('raiders/praise/up.json', {
                id: title_id
            }, function (data) {
                if (data.status == 1) {
                    $(function () {
                        num++;
                        wn.text(num);
                        //wn.attr("praise",1);
                        wow.find(".wow-1").addClass("wow-active");
                    })
                } else {
                    alert(data.msg);
                }
            });
    },


    wowComment: function (element, args, callback) {
        var num = $(element).find(".wow-num-2").text();
        var comment_id = $(element).find(".wow-num-2").attr('comment_id');
        var praise = $(element).find(".wow-num-2").attr("comment-praise");

        //if ($(element).find(".wow-2").hasClass("wow-active")) {
            if (praise == 1) {

                YunSpace.api('raiders/comment/down.json', {
                    id: comment_id
                }, function (data) {
                    if (data.status == 1) {
                        $(function () {
                            num--;
                            $(element).find(".wow-num-2").text(num);
                            $(element).find(".wow-num-2").attr("comment-praise",0);
                            $(element).find(".wow-2").removeClass("wow-active");
                        })
                    } else {
                        alert(data.msg);
                    }
                });
        } if (praise ==0) {
            YunSpace.api('raiders/comment/up.json', {
                id: comment_id
            }, function (data) {
                if (data.status == 1) {
                    $(function () {
                        num++;
                        $(element).find(".wow-num-2").text(num);
                        $(element).find(".wow-num-2").attr("comment-praise",1);
                        $(element).find(".wow-2").addClass("wow-active");
                    })
                } else {
                    alert(data.msg);
                }
            });
        }
    },

    comment: function (element, args, callback) {
        var con = $(".comment-back-input-content").val();
        var photo = $('#photo').attr('src');

        //var from_id = $(element).find(".call-back-submit").attr('from_id');
        //var from_type = $(element).find(".call-back-submit").attr('from_type');
        //var user_id = $(element).find(".call-back-submit").attr('user_id');
        //var parent_id = $(element).find(".call-back-submit").attr('parent_id');

        var from_id = $(".call-back-submit").attr('from_id');
        var from_type = $(".call-back-submit").attr('from_type');
        var user_id = $(".call-back-submit").attr('user_id');
        var parent_id = $(".call-back-submit").attr('parent_id');

        var virturlDom = document.createElement("div");
        $(virturlDom).addClass("call-back clearfix");

        if (con == '') {
            alert("评论内容不能为空！");
            return false;
        }
        YunSpace.api('raiders/comment.json', {
            from_id: from_id,
            from_type: from_type,
            user_id: user_id,
            parent_id: parent_id,
            comment_cont: con
        }, function (data) {
            if (data.status == 1) {
                alert(data.msg);
                $(".comment-back-input-content").val('');
                var htm = '<li>'
                    + '<div class="comment-slide">'
                    + '<div class="comment-img">'
                    + '<img src="'+ photo +'" alt=""/>'
                    + '</div>'
                    + '</div>'
                    + '<div class="comment-body">'
                    + '<div class="comment-head clearfix" >'
                    + '<div class="comment-person">'
                    + data.data['fullname']
                    + '</div>'
                    + '<div class="comment-time">'
                    + data.data['comment_time']
                    + '</div>'
                    + '</div>'
                    + '<div class="comment-content">'
                    + '<p>' + con + '</p>'
                    + '</div>'
                    + '<div class="comment-chat">'
                    + '<a href="javascript:;" yun="comment/js/comment.js::wowComment@click">'
                    + '<span class="glyphicon glyphicon-thumbs-up wow-2"></span>'
                    + '<p class="wow-num-2" comment_id="' + data.data['id'] + '" comment-praise="0">'+0+'</p>'
                    + '</a>'
                    + '</div>'
                    + '<div class="comment-back">'
                    + '<div class="comment-back-input">'
                    + '<input type="text" class="comment-back-input-content""/>'
                    + '</div>'
                    + '<div class="call-submit clearfix">'
                    + '<a href="javascript:;" yun="comment/js/comment.js::callBackWithComment@click" class="call-back-submit js-call1" data-username="' + data.data['fullname'] + '" user_id="' + data.data['user_id'] + '" from_type="1" parent_id="' + data.data['id'] + '" from_id="' + data.data['from_id'] +'">回复</a>'
                    + '<div class="clear"></div>'
                    + '</div>'
                    + '</div>'
                    + '</li>';
                $(".comment-list").append(htm);
                window.YunSpace.buildPluginWithNodes($(".comment-list li").last(),true);
            } else {
                alert(data.msg);
            }
        });
    },
    createComment: function (element, target) {
        //var v=$(element).prev().find(".comment-back-input-content").val();
        var person = $(element).data("username");
        var v = $(target).find(".comment-back-input-content").last().val();
        //var v = $(element).parent().prev().find(".comment-back-input-content").val();
        var aPerson = '@<span class="at">' + person + '&nbsp;&nbsp;</span>';
        var virturlDom = document.createElement("div");
        $(virturlDom).addClass("call-back clearfix");

        var photo = $('#photo').attr('src');
        var from_id = target.find(".call-back-submit").attr('from_id');
        var from_type = target.find(".call-back-submit").attr('from_type');
        var user_id = target.find(".call-back-submit").attr('user_id');
        var parent_id = target.find(".call-back-submit").attr('parent_id');

        if (v == '') {
            alert("回复内容不能为空！");
            return false;
        }

        YunSpace.api('raiders/reply.json', {
            from_id: from_id,
            from_type: from_type,
            user_id: user_id,
            parent_id: parent_id,
            comment_cont: v
        }, function (data) {
            if (data.status == 1) {
                alert(data.msg);
                //console.log(data.data);
                target.find(".comment-back-input-content").val('');

                var hm = ''
                    + '<div class="comment-slide">'
                    + '<div class="comment-img">'
                    + '<img src="'+ photo +'" alt=""/>'
                    + '</div>'
                    + '</div>'
                    + '<div class="comment-body">'
                    + '<div class="comment-head clearfix">'
                    + '<div class="comment-person">'
                    + data.data['fullname']
                    + '</div>'
                    + '<div class="comment-time">'
                    + data.data['comment_time']
                    + '</div>'
                    + '</div>'
                    + '<div class="comment-content">'
                    + '<p>' + aPerson + '' + v + '</p>'
                    + '</div>'
                    + '<div class="comment-chat">'
                    + '<a href="javascript:;"  yun="comment/js/comment.js::wowComment@click">'
                    + '<span class="glyphicon glyphicon-thumbs-up wow-2"></span>'
                    + '<p class="wow-num-2" comment_id="' + data.data['id'] + '" comment-praise="0">' + 0 + '</p>'
                    + '</a>'
                    + '</div>'
                    + '<div class="comment-back">'
                    + '<div class="comment-back-input">'
                    + '<input type="text" class="comment-back-input-content""/>'
                    + '</div>'
                    + '<div class="call-submit">'
                    + '<a href="javascript:;" yun="comment/js/comment.js::callBack@click" class="call-back-submit js-call-2" data-username="' + data.data['fullname'] + '" user_id="' + data.data['user_id'] + '" from_type="1" parent_id="' + data.data['id'] + '" from_id="' + data.data['from_id'] + '">回复</a>'
                    + '</div>'
                    + '</div>'
                    + '</div>';

                //$(".comment-list").append(hm);
                //window.YunSpace.buildPluginWithNodes($(".comment-list li").last(),true);
                virturlDom.innerHTML = hm;
                target.append(virturlDom);
                window.YunSpace.buildPluginWithNodes(virturlDom, true);
            } else {
                alert(data.msg);
            }
        });
    },
    callBack: function (element, args, callback) {
        this.createComment(element, $(element).parent().parent().parent().parent().parent());
    },
    callBackWithComment: function (element, args, callback) {
        this.createComment(element, $(element).parent().parent());
    }

}