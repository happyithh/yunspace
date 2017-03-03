/**
 * Created by Administrator on 2015/9/17.
 */
    /*    $(".j-submit").find("button").on("click", function () {
     var ok = true;
     if (ok) {
     $(".cover").fadeIn(400);
     } else {
     $(".j-input").show();
     }
     })*/
//协议


$("#submit").on('click', function () {
    var vendor_name = $('.vendor_name').val();
    if (!vendor_name) {
        alert("请输入供应商名称！");
        return false;
    }
    var city = $('.cityname option').val();
    if (!city) {
        alert("请输入城市！");
        return false;
    }
    var contact_people = $('.contact_people').val();
    if (!contact_people) {
        alert("请输入联系人！");
        return false;
    }
    var phone = $('.phone').val();
    checkPhone = /^(0|86|17951)?(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$/;
    if (!checkPhone.test(phone)) {
        alert("请输入正确手机号！");
        return false;
    }
    var product_type = $('.subBusiness option:selected').attr("valueId");
    if (!product_type) {
        alert("请选择主营商品！");
        return false;
    }
    var product_name = $('.product-name').val();
    if (!product_name) {
        alert("请输入商品名称！");
        return false;
    }
    var card =$('input[name=card]').val();
    var media = $('input[name=media]').val();
    if (!media) {
        alert("请上传商品图片");
        return false;
    }
    var content = $('textarea[name=content]').val();
    if (!content) {
        alert("请输入商品介绍！");
        return false;
    }

    if ($('.js-input').is(":visible")) {
        var  phone = $("input[name=account_phone]").val();
        $('input[name=phone]').val(phone);
        var auth_code = $("input[name=code]").val();
        if (!auth_code) {
            $("input[name=code]").focus();
            return false;
        }
    }
    phone = $('input[name=phone]').val();
    YunSpace.api('vendor/join.jsonp', {
            vendor_name: vendor_name,
            city: city,
            contact_people: contact_people,
            phone: phone,
            category_id: product_type,
            card:card,
            product_name:product_name,
            product_des:content,
            media:media,
            auth_code:auth_code
        }, function (data) {
            console.log(data.data);

            if (data.status == 1) {
                top.alert("申请成功，请耐心等待审核。\n 记得登录电脑版云·SPACE官网，进入商户管理完善供应商及商品信息，炫出特色来吧！    如有问题请致电400-056-0599");
                window.location.reload();
            } else if (data.status == 2) {
                //验证手机号
                $("input[name=account_phone]").val(phone);
                $('.js-input').removeClass("hide");
            } else {
                alert(data.msg);
            }
        }
    );
});







