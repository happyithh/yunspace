/**
 * Created by Administrator on 15-10-23.
 * 了解更多js提交
 */
$(function(){
    //了解更多表单展示
    $('.js-more').click(function(){
        $('.consult').show(300).after('<div class="popup_bg"></div>');
        $('.consult-imd').show();

        $('.username').val($('#user_stat').data('username'));
        $('.phone').val($('#user_stat').data('phone'));
        var ask_name = $(this).attr('ask_name');
        var ask_type = $(this).attr('ask_type');
        $("#ask_name").val(ask_name);
        $("#ask_type").val(ask_type);
    });


    //了解更多表单提交

    $("#get_more").click(function(){
        var ask_name = $("#ask_name").val();
        var ask_type = 7;
        var username = $("input[name='data[联系人]']").val();
        var phone = $("input[name='data[联系电话]']").val();
        var content = $("textarea[name='data[咨询内容]']").val();
        var login = false;
        var user = $('#user_stat').data('username');
        //如果登陆
        if (user != null) {
            YunSpace.api('demand/create.jsonp', {
                ask_name: ask_name,
                ask_type: ask_type,
                username: username,
                phone: phone,
                content: content,
                action: 'consult'
            }, function (data) {
                if (data.status == 1) {
                    top.alert(data.msg);
                    $(".js-close").trigger("click");
                } else {
                    top.alert(data.msg);
                    $(".js-close").trigger("click");
                }
            });
        } else {
            var second = 30;
            if (phone && username && content) {
                if(phone.length!=11 || !phone.match(/^(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$/)){
                    alert('请填写正确的手机号！');
                    return false;
                }else{
                    YunSpace.api('common/send/auth/code.json', {
                        phone: phone
                    }, function (data) {
                        $('.consult-imd').hide();
                        $('.consult-versic').show(function(){
                            $('.js-consult-btn1').click(function(){
                                $('.consult-versic').hide();
                                $('.consult-imd').fadeIn();
                            });
                        });
                        if (data.status == "0") {
                            $(".send-code").attr("disabled", false);
                            alert(data.msg);
                        } else {
                            $(".send-code").attr("disabled", true);
                            var setTime = setInterval(function (e) {
                                second--;
                                var info = "重新发送(" + second + ")";
                                $(".send-code").text(info);
                                if (second < 1) {
                                    info = "重新发送";
                                    clearInterval(setTime);
                                    $(".send-code").text(info);
                                    $(".send-code").attr("disabled", false);
                                }
                            }, 1000);
                        }
                        $(".modal-dialog").hide();
                        $(".demand-code").fadeIn(200);
                        $(".remind").show(100, function () {
                            $(".remind").css({
                                top: "100px",
                                opacity: 0
                            });
                        });
                    },"json");
                }
            } else {
                alert('请填写称呼，联系方式，和咨询内容！');
            }
        }

        $('#submitCode').on('click',function(){
            validateCode()
        })
    });

    function validateCode(e) {
        var ask_name = $("#ask_name").val();
        var ask_type = 7;
        var username = $("input[name='data[联系人]']").val();
        var phone = $("input[name='data[联系电话]']").val();
        var content = $("textarea[name='data[咨询内容]']").val();
        var code = $("#inputCode").val();
        if(!code){
            top.alert("请输入验证码！");
            return false;
        }
        YunSpace.api('common/check/auth/code.json', {
            phone: phone,
            auth_code: code
        }, function (data) {
            if (data.status == 1) {
                YunSpace.api('demand/create.jsonp', {
                    ask_name: ask_name,
                    ask_type: ask_type,
                    username: username,
                    phone: phone,
                    content: content,
                    action: 'consult'
                }, function (data) {
                    if (data.status == 1) {
                        top.alert(data.msg);
                        $(".js-close").trigger("click");
                    } else {
                        top.alert(data.msg);
                        $(".js-close").trigger("click");
                    }
                });
            } else {
                alert("验证码不正确！！")
            }
        },"json");
    }
})