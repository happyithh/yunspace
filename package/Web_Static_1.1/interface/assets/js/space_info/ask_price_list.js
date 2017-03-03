/**
 * Created by Administrator on 15-10-23.
 * 询价清单js提交
 */
$(function(){
    $('.js-close').click(function(){
        $('.pop-img,.consult,.consult-versic').hide();
        $('.popup_bg').remove();
    });

    $('.username').val($('.container').data('username'));
    $('.phone').val($('.container').data('phone'));

    var arr=[];
    $(".inquiry-btn").click(function(){
        $('#inquirylist input:checked').each(function(index,dom){
            if($(this).val()){
                arr.push($.trim($(this).val()));
            }
        });
//        var price_list = JSON.stringify(arr);
        var price_list=arr.join(",");
        var username = $("input[name='data[联系人]']").val();
        var phone = $("input[name='data[联系电话]']").val();
        var content = $("textarea[name='data[具体要求]']").val();
        var people = $("select[name='data[活动人数]']").val();
        var demand_date= $("input[name='data[活动日期]']").val();
        var demand_style = $("select[name='data[活动类型]']").val();
        var demand_city=$("select[name='data[活动城市]']").val();
        var login = false;
        var user = $('#user_stat').data('username');
//        //如果登陆
//        if (user != null) {
        if(!username || !phone){
            alert('请填写称呼，联系方式');
            return false;
        }else{
            if(phone.length!=11 || !phone.match(/^(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$/)){
                alert('请填写正确的手机号！');
                return false;
            }else{
                YunSpace.api('demand/create.jsonp', {
                    username : username,
                    phone :phone,
                    content :content,
                    people :people,
                    demand_date:demand_date,
                    demand_style :demand_style,
                    price_list :price_list,
                    demand_city:demand_city,
                    action: 'spacepedia_price'
                }, function (data) {
                    if (data.status == 1) {
    //                    top.alert(data.msg);
                        deleteItem();
                        window.location.href="http://"+window.location.host+"/inquiry/alert_msg";
                        $(".js-close").trigger("click");
                    } else {
                        top.alert(data.msg);
                    }
                });
    //        } else {
    //            var second = 30;
    //            if (phone && username && content) {
    //                YunSpace.api('common/send/auth/code.json', {
    //                    phone: phone
    //                }, function (data) {
    //                    $('.consult-versic').show(function(){
    //                        $('.js-consult-btn1').click(function(){
    //                            $('.consult,.consult-versic').hide();
    //                            $('.popup_bg').remove();
    //
    //                        });
    //                    });
    //                    if (data.status == "0") {
    //                        $(".send-code").attr("disabled", false);
    //                        alert(data.msg);
    //                    } else {
    //                        $('.consult').show(300).after('<div class="popup_bg"></div>');
    //                        $('.consult-versic').show();
    //                        $(".send-code").attr("disabled", true);
    //                        var setTime = setInterval(function (e) {
    //                            second--;
    //                            var info = "重新发送(" + second + ")";
    //                            $(".send-code").text(info);
    //                            if (second < 1) {
    //                                info = "重新发送";
    //                                clearInterval(setTime);
    //                                $(".send-code").text(info);
    //                                $(".send-code").attr("disabled", false);
    //                            }
    //                        }, 1000);
    //                    }
    //
    //                });
    //            } else {
    //                alert('请填写称呼，联系方式，和具体要求！');
                }
        }

        $('#submit_price_list').on('click',function(){
            validatePriceCode();
        })
    });

    function validatePriceCode(e) {
        var price_list = JSON.stringify(arr);
        var username = $("input[name='data[联系人]']").val();
        var phone = $("input[name='data[联系电话]']").val();
        var content = $("textarea[name='data[具体要求]']").val();
        var people = $("select[name='data[活动人数]']").val();
        var demand_date= $("input[name='data[活动日期]']").val();
        var demand_style = $("select[name='data[活动类型]']").val();
        var demand_city=$("select[name='data[活动城市]']").val();
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
                    username : username,
                    phone :phone,
                    content :content,
                    people :people,
                    demand_date:demand_date,
                    demand_style :demand_style,
                    price_list :price_list,
                    demand_city:demand_city,
                    action: 'spacepedia_price'
                }, function (data) {
                    if (data.status == 1) {
//                        top.alert(data.msg);
                        deleteItem();
                        window.location.href="http://"+window.location.host+"/inquiry/alert_msg";
//                        $(".js-close").trigger("click");
                    } else {
                        top.alert(data.msg);
                    }
                });
            } else {
                alert("验证码不正确！！")
            }
        });
    }

    function deleteItem(){
        localStorage.removeItem("ProductList");
    }
})