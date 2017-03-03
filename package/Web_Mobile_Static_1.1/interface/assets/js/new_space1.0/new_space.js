/**
 * Created by Administrator on 2015/12/2.
 */
/***提交start**/
$('.j-submit button').click(function () {
    //参数
    var product_name = $('input[name=product_name]').val();
    if (!product_name) {
     //   $('input[name=product_name]').parent().parent().find(".error-tip").html("请填写场地名称~");
        alert('请填写场地名称');
        $('input[name=product_name]').focus();
        return false;
    } else {
        $('input[name=product_name]').parent().parent().find(".error-tip").html("");
    }
    var category_id = $(".space-kinds").val();

    if (!category_id) {
      //  $('.c-select').parent().parent().find(".error-tip").html("请选择场地类型哦~");
        alert('请选择场地类型哦');
        $('.c-select').click();
        return false;
    } else {
        $('.c-select').parent().parent().find(".error-tip").html("");
    }
    var province = $('.province').val();
    var city = $('.cityname').val();
    var countyname = $('.countyname').val();
    if (!city) {
       // $('.city-selects').parent().parent().find(".error-tip").html("请选择城市~");
        alert('请选择城市');
        $('.city-selects').eq(1).click();
        return false;
    } else {
        $('.city-selects').parent().parent().find(".error-tip").html("");
    }
    var auth_code=$(".code").val();
    var addr = $('input[name=addr]').val();
    if (!addr) {
        //$('input[name=addr]').parent().parent().find(".error-tip").html("地址不能为空哦~");
        alert('地址不能为空哦');
        $('input[name=addr]').focus();
        return false;
    } else {
        $('input[name=addr]').parent().parent().find(".error-tip").html("");
    }

    var contact_people = $('input[name=contact_people]').val();
    if (!contact_people) {
        $('input[name=contact_people]').parent().find(".error-tip").html("联系人不能为空哦~");
        $('input[name=contact_people]').focus();
        return false;
    } else {
        $('input[name=contact_people]').parent().find(".error-tip").html("");
    }

  var  phone = $('input[name=phone]').val();
    checkPhone = /^(0|86|17951)?(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$/;
    if (!checkPhone.test(phone)) {
        $('input[name=phone]').parent().parent().find(".error-tip").html("请填写正确的手机号码~");
        $('input[name=phone]').focus();
        return false;
    } else {
        $('input[name=phone]').parent().parent().find(".error-tip").html("");
    }
    var email = $('input[name=e-mail]').val();
    if (!email) {
     //   $('input[name=e-mail]').parent().parent().find(".error-tip").html("请填写邮箱~");
        alert('请填写邮箱');
        $('input[name=e-mail]').focus();
        return false;
    } else {
        $('input[name=e-mail]').parent().parent().find(".error-tip").html("");
    }
    var product_media = $('input[name=card]').val();
    if (!product_media) {
        alert("请上传名片或营业执照");
        return false;
    }
    var account_id =$('#submit').data('id');
    console.log(account_id);
    YunSpace.api('common/check/auth/code.jsonp', {
        phone: phone,
        auth_code:auth_code
    }, function (data) {
        if(data['status']==1){

            //提交表单
            YunSpace.api('new/space.json', {
                action:'createspace',
                space_name: product_name,
                category_id: category_id,
                city: city,
                addr: addr,
                contacts: contact_people,
                phone: phone,
                email: email,
                media: product_media,
                countyname: countyname,
                account_id:account_id
            }, function (data) {
                if(data.status == 1){
                    alert(data.msg);
                    window.location.reload();
                }else {
                    alert(data.msg);
                }
            });
        }else{
            alert(data.msg);
        }
    })

});
/***提交end**/
