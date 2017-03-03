$(document).ready(function(){
    //订单提交
    $(".booking_submit").click(function () {
        var start_date=$("input[name=start_date]").val();
//        var start_hours=$("select[name=start_hours]").find("option:selected").val();
        var end_date=$("input[name=end_date]").val();
//        var end_hours=$("select[name=end_hours]").find("option:selected").val();
        YunSpace.api('order/booking/submit.jsonp', {
                id: $("input[name=id]").val(),
//                start_date:start_date+' '+start_hours,
                start_date:start_date,
//                end_date:end_date+' '+end_hours,
                end_date:end_date,
                memo : $("input[name=memo]").val(),
                order_number:$("input[name=order_number]").val(),
                demand_id:$("input[name=demand_id]").val(),
                action:$("input[name=action]").val()
            },
            function (data) {
                if (data.status == 1) {
                    $('.normal-popup').show().after('<div class="popup_bg"></div>');
                    $('.order-success').show();
                    //关闭弹框跳转
                    $('.popup-close').addClass('submit_redirect').removeClass('.popup-close');
//                    $('.order-success a').attr('href',"http://"+ window.location.host+'/order_info_new/'+data.data);
                    $('.submit_redirect').click(function(){
                        window.location.href="http://"+ window.location.host+'/order_info_new/'+data.data;
                    });
                    //3秒自动跳转
                    setTimeout(function(){
                        window.location.href="http://"+ window.location.host+'/order_info_new/'+data.data;
                    },3000);
                } else {
                    $('.booking_warning').show();
                    $('.booking_warning .schedule_warning').text(data.msg);
                }
            }
        );
    });

    //买家取消订单
    $('.cancel_order').click(function(){
        var order_no=$('.order_no_input').val();
        var order_status=$('.order_status_cancel').val();
        YunSpace.api('order/operate.jsonp', {
                order_no:order_no,
                reason:$("select[name=cancel_reason]").find("option:selected").val(),
                order_status:order_status,
                action:'cancel'
            },
            function (data) {
                if (data.status == 1) {
                    $('.cancel-reason').hide();
                    if(order_status == -1){
                        $('.order-success-cancel').show();
                    }else{
                        $('.order-waiting-confirm-cancel').show();
                    }
                    $('.popup-close').addClass('cancel-order-close').removeClass('.popup-close');
                    $('.cancel-order-close').click(function(){
                        window.location.reload();
                    });
                    //3秒自动跳转
                    setTimeout(function(){
                        window.location.reload();
                    },3000);
                } else {
                    alert(data.msg);
                }
            }
        );
    });

    //卖家取消订单
    $('.refuse_order').click(function(){
        var order_no=$('.order_no_input').val();
        var order_status=$('.order_status_refuse').val();
        YunSpace.api('order/operate.jsonp', {
                order_no:order_no,
                reason:$("select[name=refuse_reason]").find("option:selected").val(),
                order_status:order_status,
                action:'cancel'
            },
            function (data) {
                if (data.status == 1) {
                    $('.refuse-reason').hide();
                    if(order_status == -1){
                        $('.order-success-cancel').show();
                    }else{
                        $('.order-waiting-confirm-cancel').show();
                    }
                    $('.popup-close').addClass('cancel-order-close').removeClass('.popup-close');
                    $('.cancel-order-close').click(function(){
                        window.location.reload();
                    });
                    //3秒自动跳转
                    setTimeout(function(){
                        window.location.reload();
                    },3000);
                } else {
                    alert(data.msg);
                }
            }
        );
    });

    //拒绝取消订单
    $('.refuse_cancel_order').click(function(){
        var order_no=$('.order_no_input').val();
        YunSpace.api('order/operate.jsonp', {
                order_no:order_no,
//                refuse_cancel_reason:$("select[name=refuse_cancel_reason]").find("option:selected").val(),
                order_status:$('.status_refuse_cancel').val(),
                action:'refuse_cancel'
            },
            function (data) {
                if (data.status == 1) {
                    window.location.reload();
                } else {
                    alert(data.msg);
                }
            }
        );
    });

    //确认订单取消
    $('.confirm_cancel_order').click(function(){
        var order_no=$('.order_no_input').val();
        YunSpace.api('order/operate.jsonp', {
                order_no:order_no,
                action:'confirm_cancel'
            },
            function (data) {
                if (data.status == 1) {
                    window.location.reload();
                } else {
                    alert(data.msg);
                }
            }
        );
    });


    //订单审核通过
    $('.confirm_order').click(function(){
        var order_no=$('.order_no_input').val();
        YunSpace.api('order/operate.jsonp', {
                order_no:order_no,
                action:'pending'
            },
            function (data) {
                if (data.status == 1) {
//                    $('.normal-popup').show().after('<div class="popup_bg"></div>');
                    $('.order-success-m').show();
                    $('.popup-close').addClass('vendor_pending').removeClass('.popup-close');
                    $('.vendor_pending').click(function(){
                        window.location.reload();
                    });
                    //3秒自动跳转
                    setTimeout(function(){
                        window.location.reload();
                    },3000);
                } else {
                    alert(data.msg);
                }
            }
        );
    });

    //添加合同
    $('.add_conform').click(function(){
        var order_no=$('.order_no_input').val();
        var ajaxData = [];
        for(var i = 1; i< $(".fujian").length; i++){
            ajaxData.push(
                {
                    path:$(".fujian").eq(i).find(".adjunct-path").val(),
                    name:$(".fujian").eq(i).find(".adjunct-name").val()
                }
            );
        }
        YunSpace.api('order/operate.jsonp', {
                order_no:order_no,
                action:'add_conform',
                conform_id: $("input[name=conform_id]").val(),
                conform_title: $("input[name=conform_title]").val(),
                conform_amount: $("input[name=conform_amount]").val(),
                conform_path:ajaxData
            },
            function (data) {
                if (data.status == 1) {
                    $('.ormc-cert').hide();
                    $('.ormc-cert-sucs').show();
                    $('.popup-close').addClass('upload_conform_success').removeClass('.popup-close');
                    $('.upload_conform_success').click(function(){
                        window.location.reload();
                    });
                    //3秒自动跳转
                    setTimeout(function(){
                        window.location.reload();
                    },3000);

                }else{
                    $('.conform-warning').css('display','block');
                    $('.conform-warning').text(data.msg);
                }
            }
        );
    });

    //删除合同
    $('.confirm-delete-conform').click(function(){
        var order_no=$('.order_no_input').val();
        YunSpace.api('order/operate.jsonp', {
                order_no:order_no,
                action:'conform_delete',
                conform_id:$(this).attr('data-cid'),
                conform_title:$(this).attr('data-title')
            },
            function (data) {
                if (data.status == 1) {
                    window.location.reload();
                } else {
                    alert(data.msg);
                }
            }
        );
    });


    //买家签约
    $('.conform_assign').unbind("click").bind("click",function(){
        var order_no=$('.order_no_input').val();
        var check_type=$(this).attr('data-type');
        YunSpace.api('order/operate.jsonp', {
                order_no:order_no,
                action:'conform_sign',
                password2: $(".password2").val(),
                check_code:$('.check_code').val(),
                phone:$('#buyer-phone-num').val(),
                check_type:check_type,
                conform_id: $("input[name=conform_id]").val()
            },
            function (data) {
                if (data.status == 1) {
                    $('.order-confirm3').hide();
                    $('.order-confirm1').show();
                    $('.popup-close').addClass('conform_assign_success').removeClass('.popup-close');
                    $('.conform_assign_success').click(function(){
                        window.location.reload();
                    });
                    //3秒自动跳转
                    setTimeout(function(){
                        window.location.reload();
                    },3000);
                } else {
                    if (check_type=='pwd'){
                        $('.password2_warning').css('display','block');
                        $('.password2_warning').text(data.msg);
                    }else if (check_type=='code'){
                        $('.code_warning').css('display','block');
                        $('.code_warning').text(data.msg);
                    }

                }
            }
        );
    });

    //买家拒绝合同
    $('.confirm-refuse-conform').click(function(){
        var order_no=$('.order_no_input').val();
        YunSpace.api('order/operate.jsonp', {
                order_no:order_no,
                action:'refuse_conform',
//                refuse_reason: $("select[name=refuse_conform_reason]").find("option:selected").val(),
                refuse_reason: "买家拒绝确认此合同，请线下协商",
                conform_id: $('.confirm-refuse-conform').attr('data-conform-id')
            },
            function (data) {
                if (data.status == 1) {
                    window.location.reload();
                } else {
                    alert(data.msg);
                }
            }
        );
    });

    //线下支付
    $(".js-l-paybtn").click(function(){
        var payment_id=$(this).attr('data-pid');
        var order_no=$('.order_no_input').val();
        $('.transfer-popup').show().after('<div class="popup_bg"></div>');
        $(".transfer-popup").load("http://"+window.location.host+"/pay_transfer",{order_no:order_no, payment_id:payment_id },function(){

            //获取输入框焦点时，隐藏错误提示信息
            $('.ipt-txt').on('focus',function(){
                $('.warning').hide();
            });

            $('.popup-close').click(function(){
                $('.popup-close').addClass('hide');
                $('.order-payline').addClass('hide');
                $('.transfer-popup').hide();
                $(".popup_bg").remove();
            });

            $('.pay-transfer-submit').click(function(){
                var transferData = [];
                for(var i = 1; i< $(".pay_certify_file").length; i++){
                    transferData.push(
                        {
                            path:$(".pay_certify_file").eq(i).find(".certify-path").val(),
                            name:$(".pay_certify_file").eq(i).find(".certify-name").val()
                        }
                    );
                }

                YunSpace.api('order/operate.jsonp', {
                        order_no:order_no,
                        action:'transfer_pay',
                        payment_id:payment_id,
                        transfer_info:transferData,
                        名称:$('.order-payline .transfer_title').val(),
                        金额:$('.order-payline .transfer_amount').val(),
                        支付备注:$('.order-payline .transfer_title').val()
                    },
                    function (data) {
                        if (data.status==1) {
                            $('.order-payline').addClass('hide');
                            $('.order-payline-sucs').show();
                            $('.popup-close').addClass('transfer_pay_submit').removeClass('.popup-close');
                            $('.transfer_pay_submit').click(function(){
                                window.location.reload();
                            });
                            //3秒自动跳转
                            setTimeout(function(){
                                window.location.reload();
                            },3000);
                        } else {
                              $('.transfer_pay_warning').css('display','block');
                              $('.transfer_pay_warning').text(data.msg);
                        }
                    }
                );

            })

        });
    });

    //卖家确认线下支付款项
    $('.confirm-transfer-pay-submit').click(function(){
        var payment_id=$(this).attr('data-pid');
        var order_no=$('.order_no_input').val();
        YunSpace.api('order/operate.jsonp', {
                order_no:order_no,
                action:'confirm_transfer',
                payment_id:payment_id
            },
            function (data) {
                if (data.status==1) {
                    window.location.reload();
                } else {
                    alert(data.msg);
                }
            }
        );
    });

    //卖家拒绝线下支付款项
    $('.refuse-transfer-pay-submit').click(function(){
//        var payment_id=$('.payment_id').val();
        var payment_id=$(this).attr('data-pid');
        var order_no=$('.order_no_input').val();
//        var refuse_reason=$("select[name=refuse_transfer_reason]").find('option:selected').val();
        var refuse_reason="未收到该款项";
        YunSpace.api('order/operate.jsonp', {
                order_no:order_no,
                action:'not_confirm_transfer',
                payment_id:payment_id,
                refuse_reason:refuse_reason
            },
            function (data) {
                console.log(data);
                if (data.status==1) {
                    window.location.reload();
                } else {
                    alert(data.msg);
                }
            }
        );
    });


    //买家创建款项
    $('.buyer_create_pay_submit').click(function(){
        var order_no=$('.order_no_input').val();
        YunSpace.api('order/operate.jsonp', {
                order_no:order_no,
                action:'buyer_create_pay',
                名称:$('.order-payonline .payment_title').val(),
                金额:$('.order-payonline .amount').val(),
                支付备注:$('.order-payonline .payment_title').val()
            },
            function (data) {
                console.log(data);
                if (data.status==1 && data.data) {
                    window.open("http://"+window.location.host+"/order_pay_new/bank/"+data.data);
                } else {
                    $('.online_pay_warning').css('display','block');
                    $('.online_pay_warning').text(data.msg);
                }
            }
        );
    });

    //买家删除支付款项
    $('.confirm-delete-payment').click(function(){
        var order_no=$('.order_no_input').val();
        YunSpace.api('order/operate.jsonp', {
                order_no:order_no,
                action:'delete_pay',
                payment_id:$(this).attr('data-payId'),
                amount:$(this).attr('data-amount')
            },
            function (data) {
                if (data.status == 1) {
                    window.location.reload();
                } else {
                    alert(data.msg);
                }
            }
        );
    })

    //卖家更换在线支付收款账号
   $('.change_cash').change(function(){
       var order_no=$('.order_no_input').val();
       var bank_id=$(this).find('option:selected').val();
       var bank_info=$(this).find('option:selected').text();
       YunSpace.api('order/operate.jsonp', {
               order_no:order_no,
               action:'change_bank',
               bank_id:bank_id,
               bank_info:bank_info
           },
           function (data) {
               $('.normal-popup').show().after('<div class="popup_bg"></div>');
               $('.change_account_show').show();
               $('.change_account_show h1 span').text(data.msg);
               //3秒自动关闭弹框
               setTimeout(function(){
                   $('.change_account_show').hide();
                   $('.normal-popup').hide();
                   $('.popup_bg').remove();;
               },3000);
           }
       );
   });

    //供应商完成订单
    $('.vendor_complete_order').click(function(){
        var order_no=$('.order_no_input').val();
        YunSpace.api('order/operate.jsonp', {
                order_no:order_no,
                action:'vendor_complete'
            },
            function (data) {
                if (data.status == 1) {
                    $('.normal-popup').show().after('<div class="popup_bg"></div>');
                    $('.order-complete').show();
                    $('.popup-close').addClass('order-complete-close').removeClass('.popup-close');
                    $('.order-complete-close').click(function(){
                        window.location.reload();
                    });
                    //3秒自动跳转
                    setTimeout(function(){
                        window.location.reload();
                    },3000);
                }else{
                    alert(data.msg);
                }
            }
        );
    });

    //账户支付
    $('.account_pay').click(function(){
        YunSpace.api('order/pay.jsonp', {
                action:'balance_pay',
                payment_id:$(".account_payment_id").val(),
                password2:$(".account_password2").val()
            },
            function (data) {
                if (data.status == 1) {
                    $('.normal-popup').show().after('<div class="popup_bg"></div>');
                    $('.order-payonline-sucs').show();
                    $('.popup-close').addClass('account_pay_success').removeClass('.popup-close');
                    $('.account_pay_success').click(function(){
                        window.location.href="http://"+window.location.host+"/order_info_new/"+data.data;
                    });
                    //3秒自动跳转
                    setTimeout(function(){
                        window.location.href="http://"+window.location.host+"/order_info_new/"+data.data;
                    },3000);
                }else{
                    $('.pay_warning').css('display','block');
                    $('.pay_warning').text(data.msg);
                }
            }
        );
    });

    //订单评价
    $('.evaluate_submit').click(function(){
        var order_no=$('.order_no_input').val();
        YunSpace.api('order/operate.jsonp', {
                order_no:order_no,
                action:'evaluate',
                quality:$("input[name=quality]:checked").val(),
                service:$("input[name=service]:checked").val(),
                speed:$("input[name=speed]:checked").val(),
                demo:$("textarea[name=demo]").val()
            },
            function (data) {
                if (data.status == 1) {
                    window.location.reload();
                }else{
                    alert(data.msg);
                }
            }
        );
    });

})