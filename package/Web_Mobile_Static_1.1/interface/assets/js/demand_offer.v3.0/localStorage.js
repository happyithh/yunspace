/**
 * Created by Administrator on 2015/12/3.
 * jquery
 */
$(document).ready(function () {
    _localStorage.autoSet();
    _localStorage.autoShow();
});
_localStorage = {

    autoShow: function () {
        //商家联系人
        if (localStorage.contact) {
            $("input[name=contact]").val(localStorage.contact);
        }
        //商家联系电话
        if (localStorage.contact_phone) {
            $("input[name=contact_phone]").val(localStorage.contact_phone);
        }
        //商家报价
        if (localStorage.quote) {
            $("input[name=quote]").val(localStorage.quote);
        }
        //单位
        if (localStorage.quote_unit) {
            $("select[name=quote-unit] option").each(function () {
                if ($(this).val() == localStorage.quote_unit) {
                    $(this).attr('selected', true);
                }
            });
        }

        if (localStorage.remark) {
            $("textarea[name=remark]").val(localStorage.remark);
        }
        //
        //$("input[name=contact]").val(localStorage.contact);
        //$("input[name=contact]").val(localStorage.contact);
    }, autoSet: function () {
        //商家联系电话
        $("input[name=contact_phone]").on('blur', function () {
            //alert($(this).val())
            localStorage.contact_phone = $(this).val();
        });
        //商家联系人
        $("input[name=contact]").on('blur', function () {
            localStorage.contact = $(this).val();
        });
        //商家报价name="quote"
        $("input[name=quote]").on('blur', function () {
            localStorage.quote = $(this).val();
        });

        $("select[name=quote-unit]").change(function () {
            localStorage.quote_unit = $(this).val();
        });

        $("textarea[name=remark]").on('blur', function () {

            localStorage.remark = $(this).val();

        });


    }
};