
$(function(){


    //查询档期和价格,合作咨询
    $(".pop-show").click(function(){
        $(".cover,.search-box").fadeIn();
    });
    $('.search-box-placeholder').click(function(){
        $(this).css('display','none');
        $(this).siblings(".search-box-input").focus();
    });
    $('#search-box-close').on('click',function(){
        $(".cover,.search-box").fadeOut();
    });
    $(".cover").click(function(){
        $(".cover,.search-box").fadeOut();
    })
    $(".search-box-btn").click(function(){
        var contact_name = $(".search-box").find("input[name='username']").val();
        var contact_phone = $(".search-box").find("input[name='phone']").val();
        var other_demand = $(".search-box").find("input[name='other_demand']").val();
        var from_type = $(".search-box").find("input[name='from_type']").val();

        //名称不为空
        if(contact_name==''){
            $(".search-box").find(".error_msg").removeClass('none');
            $(".search-box").find(".error_msg").html('请填写您的称呼，方便我们联系你！');
            setTimeout("$('.search-box').find('.error_msg').addClass('none')",3000);
            return false;
        }

        // 联系方式不为空
        if(contact_phone==''){
            $(".search-box").find(".error_msg").removeClass('none');
            $(".search-box").find(".error_msg").html('请填写您的手机号，方便我们联系你！');
            setTimeout("$('.search-box').find('.error_msg').addClass('none')",3000);
            return false;
        }

        //判断咨询内容
        if(other_demand==''){
            $(".search-box").find(".error_msg").removeClass('none');
            $(".search-box").find(".error_msg").html('请填写你要咨询的问题！');
            setTimeout("$('.search-box').find('.error_msg').addClass('none')",3000);
            return false;
        }
        var data_a = {
            username: contact_name,
            phone: contact_phone,
            content: other_demand,
            from_type:from_type,
            object_type: "insurance",
            action: 'new_events'
        };

        YunSpace.api("demand/create.jsonp", data_a, function (data) {
            if (data.status == 1) {
                alert('提交成功，我们会尽快与您联系！');
                $(".cover,.search-box").fadeOut();
            }else{
                alert(data.msg);
            }
        });
    });

});
