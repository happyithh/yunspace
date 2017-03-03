var plugin= {
    joinSubmit:function() {
        $('.js-feedback-btn').click(function () {
            var fedbak = $('#fedbak').val();
            var feedback = $('#feedback').val();
            var contact = $('#contact').val();
            var form_type = 1;
            var data = new Array();
            data[0] = feedback
            data[1] = contact
            var key = new Array();
            key[0] = '意见反馈'
            key[1] = '联系方式'

            if(feedback==""){
                //if (!isMobile(tel)) {
                //    $('.pop-status,.pop-bg').show();
                //    $('.pop-status-error').find("p").text("手机号码不正确!!");
                //    $('.pop-status-error').show();
                //    return false;
                //}
                $('.pop-status,.pop-bg').show();
                $('.pop-status-error').find("p").text("意见反馈栏为空哦");
                $('.pop-status-error').show();
                $('.js-close').click(function(){
                    $('.pop-status,.pop-bg').hide();
                    $('.pop-status-success').hide();
                    $('.pop-status-error').hide();
                });
                return;
            }
            //if (!isMobile(contact)) {
            //    $('.pop-status,.pop-bg').show();
            //    $('.pop-status-error').find("p").text("请填写正确格式的号码!!");
            //    $('.pop-status-error').show();
            //    return;
            //}
            $.ajax({
                type: "post",
                //url: 'http://yun.cc/form',
                url: 'http://www.yunspace.com.cn/form',
                data: {
                    id: fedbak,
                    data: data,
                    key: key,
                    form_type: form_type
                },
                async: false,
                dataType: "json",
                success: function (data) {
                    if (data.status == 1) {
                        //top.alert(data.msg);
                        $('.pop-status,.pop-bg').show();
                        $('.pop-status-success').show();
                        $('.js-close').click(function(){
                            $('.pop-status,.pop-bg').hide();
                            $('.pop-status-success').hide();
                            $('.pop-status-error').hide();
                        });
                        $("input").val("");
                        $(".input").removeClass("p-active bg-active");
                    } else {
                        //top.alert(data.msg);
                        $('.pop-status,.pop-bg').show();
                        $('.pop-status-error').find("p").text(data.msg);
                        $('.pop-status-error').show();
                        $('.js-close').click(function(){
                            $('.pop-status,.pop-bg').hide();
                            $('.pop-status-success').hide();
                            $('.pop-status-error').hide();
                        });
                    }

                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    console.log(XMLHttpRequest);
                    console.log(textStatus);
                    console.log(errorThrown);
                }
            });

        });
    }
}
//function isMobile(phone){
//    if(phone==null)return false;
//    var exp= /^(0|86|17951)?(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$/;
//    if(exp.test(phone)){
//        return true;
//    }else{
//        return false;
//    }
//
//}