/*
*查看参考价
*/
$(function(){

    //查看参考价
    $(".js-look-price").click(function(){
        $(".look-more,.hint").hide();
        $(".inquiry-ul-contleft input").val("");

        $(".consult").show().after('<div class="popup_bg"></div>');
        $(".consult-look-price").show();

    });


    //查看参考价弹窗内容js
    $(".js-oninput").after("<span class='hint hide'>*请输入正确的手机号码</span>");
    $(".js-oninput").on("input propertychange",function(){
        var phone = $("input[name='data[联系手机号码]']").val();
        if(phone.length==11){
            if(!phone.match(/^(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$/)){
                $(this).parent().find('.hint').show();

            }else{
                $(this).parent().find('.hint').hide();
                $(".look-more").slideDown();
            }

        }else if(phone.length>11){
            $(this).parent().find('.hint').show();
            $(".look-more").slideUp();
        }
    });
    $(".js-y-code").on("input propertychange",function(){
        if($(this).val()){
            $(".js-lokprc-btn").addClass("blue");
        }else{
            $(".js-lokprc-btn").removeClass("blue");
        }
    });

    $(".look_price_submit").click(function(){
        var phone=$(".phone3").val();
        var space_name=$(".banner-info .space_name").text();
        var demand_city=$(".site_location .baike_city").text();
        var code = $("#look_price_code").val();
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
                    phone :phone,
                    space_name:space_name,
                    demand_city: demand_city,
                    action: 'look_price'
                }, function (data) {
                    if (data.status == 1) {
                        $(".js-close").trigger("click");
                        $(".js-look-price").addClass("hide");
                        $(".ref-price").removeClass("hide");
                        $(".item_price_show").removeClass("hide");
                    } else {
                        top.alert(data.msg);
                    }
                });
            } else {
                alert("验证码不正确！！")
            }
        });
    })

})