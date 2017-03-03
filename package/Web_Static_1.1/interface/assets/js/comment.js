/*
 *
 *  @评论提交
 * 基于jquery.js
 *
 * */
$(document).ready(function () {


    $(".comment_submit").on("click", function (e) {
        var from_id = $(this).attr('from-id');
        var user_id = $(this).attr('user-id');
        var parent_id = $(this).attr('parent-id');
        var from_type = $(this).attr('from-type');
        var comment_cont = $('.comment_cont').val();
        if (!comment_cont) {
            alert('您要说点东西我才能提交哦！');
            $('.comment_cont').focus();
            return false;
        }

        //转化jquery时间格式
        Date.prototype.Format = function (fmt) { //author: meizz
            var o = {
                "M+": this.getMonth() + 1, //月份
                "d+": this.getDate(), //日
                "h+": this.getHours(), //小时
                "m+": this.getMinutes(), //分
                "s+": this.getSeconds(), //秒
                "q+": Math.floor((this.getMonth() + 3) / 3), //季度
                "S": this.getMilliseconds() //毫秒
            };
            if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
            for (var k in o)
                if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
            return fmt;
        }

        var photo = $('#photo').attr('src');
        var comment_time = new Date().Format("yyyy-MM-dd hh:mm:ss");
        var username = $('.log').attr('data-username');

        var commentHTML = '<li><div class="comment-pic"><img title="头像" src="' + photo + '"></div><div class="comment-list-content"><div class="comment-list-title"><span>' + username + '&nbsp; </span><span>' + comment_time + '</span></div><div class="comment-list-detail">' + comment_cont + '</div><div class="clear"></div></div></li>';

        YunSpace.api('raiders/comment.jsonp', {
            from_id: from_id,
            from_type: from_type,
            user_id: user_id,
            parent_id: parent_id,
            comment_cont: comment_cont
        }, function (data) {
            if (data.status == 1) {
                alert(data.msg);
                $(".comment_cont").val('');
                $(".comment-list").prepend(commentHTML);
            } else {
                alert(data.msg);
            }
        });
    });

    //回复哦
    $(".comment_reply").on('click', function (e) {
        var click_count = parseInt($(this).attr('click-count')) + 1;
        $(".comment_reply").attr('click-count', click_count);
        if (click_count % 2 !== 0) {

            $(this).parent(".comment-replay").append('<textarea rows="6" class="comment-input comment-cont" placeholder="随便说吧"></textarea><a href="javascript:void(0)" from-type="1" parent-id ="" user-id = "" from-id="" class="comment-btn comment-submit">回复</a>');

            var parent_id = $(this).attr('parent-id');

            var from_id = $(this).attr('from-id');
            var user_id = $(this).attr('user-id');
            var from_type = $(this).attr('from-type');

            $(".comment-cont").focus();
            $(".comment-submit").attr('parent-id', parent_id);
            $(".comment-submit").attr('from-id', from_id);
            $(".comment-submit").attr('from-type', from_type);
            $(".comment-submit").attr('user-id', user_id);
            //$(".comment_submit").attr('parent-id', parent_id);
            //$(".comment_cont").focus();
            //$(".comment_submit").text('回复');
        } else {
            $(".comment-cont").remove();
            $(".comment-submit").remove();
            //$(this).parent(".comment-replay").remove('.comment-submit');
        }

    });


    $(".comment-replay").on("click", ".comment-submit", function () {
        //$(".comment-submit").on("click", function (e) {
        var from_id = $(this).attr('from-id');
        var user_id = $(this).attr('user-id');
        var parent_id = $(this).attr('parent-id');
        var from_type = $(this).attr('from-type');
        var comment_cont = $('.comment-cont').val();
        if (!comment_cont) {
            alert('您要说点东西我才能提交哦！');
            $('.comment-cont').focus();
            return false;
        }


        YunSpace.api('raiders/reply.jsonp', {
            from_id: from_id,
            from_type: from_type,
            user_id: user_id,
            parent_id: parent_id,
            comment_cont: comment_cont
        }, function (data) {
            if (data.status == 1) {
                alert(data.msg);
                $(".comment-cont").val('');
                //$(messageHTML).appendTo("#message_list");
            } else {
                alert(data.msg);
            }
        });
    });


    //点赞
    $(".nice").on("click", function () {
        var title_id = $(this).attr('title_id');
        var praise = $(this).attr('praise');
        //获取点赞数，点赞数为0则允许点赞
        if (praise == 0) {

            YunSpace.api('raiders/praise/up.jsonp', {
                id: title_id
            }, function (data) {
                if (data.status == 1) {
                    $(function () {
                        var n = parseInt($(".nice").text());
                        n++;
                        $(".nice").text(n);
                        $(".nice").attr("praise", 1);
                        $(".nice").css("background", "url(/package/Web_Static_1.1/interface/assets/img/raiders-info/icon9.jpg) no-repeat top left");
                    })
                } else {
                    alert(data.msg);
                }
            });

        }
        //点赞数为1则取消点赞
        if (praise == 1) {

            YunSpace.api('raiders/praise/down.jsonp', {
                id: title_id
            }, function (data) {
                if (data.status == 1) {
                    $(function () {
                        var n = parseInt($(".nice").text());
                        n--;
                        $(".nice").text(n);
                        $(".nice").attr("praise", 0);
                        $(".nice").css("background", "url(/package/Web_Static_1.1/interface/assets/img/raiders-info/icon7.jpg) no-repeat top left");
                    })
                } else {
                    alert(data.msg);
                }
            });
        }
    });

    //评论点赞
    $(".comment-nice").on("click", function () {
        var comment_id = $(this).attr('comment_id');
        var praise = $(this).attr('comment-praise');
        var comment = $(this);
        if (praise == 0) {
            YunSpace.api('raiders/comment/up.jsonp', {
                id: comment_id
            }, function (data) {
                if (data.status == 1) {
                    $(function () {
                        var n = comment.attr('data-number');
                        n++;
                        comment.text(n);
                        comment.attr("comment-praise", 1);
                        comment.attr("data-number",1);
                        comment.css("background", "url(/package/Web_Static_1.1/interface/assets/img/raiders-info/icon9.jpg) no-repeat top left");
                    })
                } else {
                    alert(data.msg);
                }
            });
        }

        if (praise == 1) {
            YunSpace.api('raiders/comment/down.jsonp', {
                id: comment_id
            }, function (data) {
                if (data.status == 1) {
                    $(function () {
                        var n = comment.attr('data-number');
                        n--;
                        comment.text(n);
                        comment.attr("comment-praise", 0);
                        comment.attr("data-number",0);
                        comment.css("background", "url(/package/Web_Static_1.1/interface/assets/img/raiders-info/icon7.jpg) no-repeat top left");
                    })
                } else {
                    alert(data.msg);
                }
            });
        }

    });


});