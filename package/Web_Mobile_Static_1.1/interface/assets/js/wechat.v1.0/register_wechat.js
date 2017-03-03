$(function () {
    //$("#register-success").click(function () {
    //    $(".js-cover,.js-modal1").show();
    //})
    $(".js-register-phone").val(localStorage.phone);

    $(".register_submit").on('click', function (e) {
        var code = $(".js-register-code").val();
        var phone = $(".js-register-phone").val();
        if (!phone) {
            $(".js-register-phone").focus();
            alert('请填写手机号');
            return false;
        }
        localStorage.phone = phone;
        if (!code) {
            $(".js-register-code").focus();
            alert('请填写验证码！');
            return false;
        }
        $.ajax({
            url: '?',
            data: {
                action: 'is_submit',
                phone: phone,
                code: code
            },
            dataType: 'json',
            type: 'get',
            success: function (data) {
                if (data.status == 1) {
                    window.location.href = data.data.url;
                }
                alert(data.msg);
            }
        })
    })
})
