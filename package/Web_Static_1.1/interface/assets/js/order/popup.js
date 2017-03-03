$(document).ready(function(){

    $('.popup-close').click(function(){
        $('.normal-popup').hide();
        $('.popup_bg').remove();
        $('.order-confirm2').hide();
        $('.order-confirm3').hide();
        $('.order-payonline').hide();
        $('.order-payonline-fd').hide();
        $('.order-payonline-fail').hide();
        $('.order-payline-fd').hide();
        $('.ormc-cert-fd').hide();
        $('.ormc-cert').hide();
        $('.ormc-recert').hide();
        $('.download-show').hide();
        $('.cancel-reason').hide();
        $('.refuse-reason').hide();
        $('.refuse-cancel').hide();
        $('.refuse-conform').hide();
        $('.refuse-conform-reason').hide();
        $('.refuse-transfer').hide();
        $('.show-transfer-pay').hide();
        $('.order-complete').hide();
        $('.delete-payment').hide();
        $('.transfer-pay-alter').hide();
        $('.refuse-transfer-pay-alter').hide();
        $('.refuse-conform-alter').hide();
        $('.delete-conform').hide();

    });
    $('.js-delete-conform,.refuse-transfer-submit,.confirm-transfer,.payonline-delete,.confirm_order,.payonline-edit,.js-show-transfer-pay,.not-confirm-transfer,.js-refuse-conform-reason,.js-refuse-conform,.js-refuse-cancel,.js-refuse,.js-cancel,.download_conform,.js-order-submit,.js-confirm-btn,.js-onl-paybtn,.js-orsm-mcf,.js-upld-submit-m,.js-ormc-reupldbtn').click(function(){
        $('.normal-popup').show().after('<div class="popup_bg"></div>');
    });

    //获取输入框焦点时，隐藏错误提示信息
    $('.ipt-txt').on('focus',function(){
        $('.warning').hide();
    });

///////////////////用户///////////////////
    //取消订单
    $('.js-cancel').click(function(){
        $('.cancel-reason').show();
        $('.order_status_cancel').val($(this).attr('data-status'));

    });
    //拒绝订单
    $('.js-refuse').click(function(){
        $('.refuse-reason').show();
        $('.order_status_refuse').val($(this).attr('data-status'));
    });
    //拒绝取消订单
    $('.js-refuse-cancel').click(function(){
        $('.refuse-cancel').show();
        $('.status_refuse_cancel').val($(this).attr('data-status'));
    });
    //取消拒绝
    $('.cancel-refuse_cancel_order').click(function(){
        $('.normal-popup').hide();
        $('.popup_bg').remove();
        $('.refuse-reason').hide();
    })

    //确认合同
    $('.js-confirm-btn').click(function(){
        $('.conform_id').val($(this).attr('data-conform-id'));
        $('.order-confirm3').show();
        $('.order-confirm').show();
        $('.check_code').val('');
        //用交易密码确认
        $('.js-btn-code').click(function(){
            $('.order-confirm').hide();
            $('.order-confirm3').show();
            $('.order-confirm2').show();
            $('.password2').val('');
        });
        //返回到用验证码确认
        $('.js-btn-yanzh').click(function(){
            $('.order-confirm2').hide();
            $('.order-confirm3').show();
            $('.order-confirm').show();
            $('.check_code').val('');
        });
    });

    //拒绝合同
    $('.js-refuse-conform').click(function(){
            $('.refuse-conform-alter').show();
            $('.refuse-conform-alter .confirm-refuse-conform').attr('data-conform-id',$(this).attr('data-conform-id'));
//        $('.refuse-conform').show();
//        $('.conform_id').val($(this).attr('data-conform-id'));
    })

    //取消拒绝合同
    $('.cancel-refuse-conform').click(function(){
        $('.normal-popup').hide();
        $('.popup_bg').remove();
        $('.refuse-conform-alter').hide();
    })

    //查看拒绝合同理由(暂时不需要)
    $('.js-refuse-conform-reason').click(function(){
        $('.refuse-conform-reason').show();
        $('.refuse-conform-reason').text($(this).parent().find('.hide_refuse_reason').text());
    })

    //线上支付
    $('.js-onl-paybtn').click(function(){
        var identity=$(this).attr('data-identity');
        if(identity == 0){
            $('.order-payonline-fd').show();
        }else{
            $('.order-payonline').show();
            $('.order-payonline .amount').val('');
            $('.order-payonline .payment_title').val('');
        }
    });

    //删除支付信息
    $('.payonline-delete').click(function(){
        $('.delete-payment').show();
        $('.delete-payment .confirm-delete-payment').attr('data-payId',$(this).attr('data-payId'));
        $('.delete-payment .confirm-delete-payment').attr('data-amount',$(this).attr('data-amount'));
    });
    //取消删除支付信息
    $('.cancel-delete-payment').click(function(){
        $('.normal-popup').hide();
        $('.popup_bg').remove();
        $('.delete-payment').hide();
    })


    //修改线上支付信息
    $('.payonline-edit').click(function(){
        $('.order-payonline').show();
        $('.order-payonline .amount').val($(this).parents('tr').find('td').eq(0).find('span').text());
        $('.order-payonline .payment_title').val($(this).parents('tr').find('td').eq(1).find('span').text());
    })


    ///////////////////商户///////////////////
    //上传合同--新增
    $('.js-upld-submit-m').click(function(){
        var identity=$(this).attr('data-identity');
        if(identity == 0){
            $('.order-payonline-fd').show();
        }else{
            $('.ormc-cert').show();
            $("input[name=conform_id]").val('');
            $("input[name=conform_title]").val('');
            $("input[name=conform_amount]").val('');
            var contentCount = $(".fujian").length;
            for(var i = 1; i<contentCount;i++){
                $(".fujian").eq(1).remove();
            }
            $(".fujian").eq(0).find(".adjunct-name").val('');
            $(".fujian").eq(0).find(".adjunct-path").val('');
        }
    });

    //等待采购方确认合同-重新上传
    $('.js-ormc-reupldbtn').click(function(){
        $('.ormc-cert').show();
        var contentCount = $(".fujian").length;
        if(contentCount > 1){
            for(var i = 1; i<contentCount;i++){
                $(".fujian").eq(1).remove();
            }

        }
        $(".fujian").eq(0).find(".adjunct-name").val('');
        $(".fujian").eq(0).find(".adjunct-path").val('');


        var conform_id=$(this).attr('data-conform-id');
        var conform_title=$(this).parents('table tr').find('td').eq(0).text();
        var conform_amount=$(this).parents('table tr').find('td').eq(1).find('.conform_amount').text();
        $("input[name=conform_id]").val(conform_id);
        $("input[name=conform_title]").val(conform_title);
        $("input[name=conform_amount]").val(conform_amount);
        var nameContents = $(this).parents('table tr').find(".js-conform-name");
        var pathContents = $(this).parents('table tr').find(".js-conform-path");
        for(var i = 0; i<nameContents.length;i++){
            addFile(nameContents.eq(i).text(),pathContents.eq(i).text());
            $(".fujian").find('span').show();
        }
    });

    //删除合同
    $('.js-delete-conform').click(function(){
        $('.delete-conform').show();
        $('.delete-conform .confirm-delete-conform').attr('data-cid',$('.js-delete-conform').attr('data-cid'));
        $('.delete-conform .confirm-delete-conform').attr('data-title',$('.js-delete-conform').attr('data-title'));

    });

    //取消删除合同
    $('.cancel-delete-conform').click(function(){
        $('.normal-popup').hide();
        $('.popup_bg').remove();
        $('.delete-conform').hide();
    });

    //下载合同
    $('.download_conform').click(function(){
        $('.download-show').show();
        $(".download-show").html('');


        var nameContents = $(this).parents('table tr').find(".js-conform-name");
        var pathContents = $(this).parents('table tr').find(".js-conform-path");
        for(var i = 0; i<nameContents.length;i++){
            var newFile = $('.js-download-conform .js-download-p').eq(0).clone();
            newFile.find('.file_name').html('<i class="ion-paperclip blue" style="font-size: 20px;margin-right: 5px;"></i>'+nameContents.eq(i).text());
//            newFile.find('.file_path').attr('href','http://'+window.location.host+'/order_info_new/download?filename='+pathContents.eq(i).text());
            newFile.find('.file_path').attr('href','http://'+window.location.host+pathContents.eq(i).text());
            newFile.appendTo('.download-show');
        }

    });





    //查看支付凭证
    $('.js-show-transfer-pay').click(function(){
        $('.show-transfer-pay').show();
        $(".show-transfer-pay").html('');

        var nameContents = $(this).parents('table tr td').find(".transfer-pay-name");
        var pathContents = $(this).parents('table tr td').find(".transfer-pay-path");
        for(var i = 0; i<nameContents.length;i++){
            var newFile = $('.show-transfer-pay-div .show-transfer-pay-p').eq(0).clone();
            newFile.find('.file_name').html('<i class="ion-paperclip blue" style="font-size: 20px;margin-right: 10px;"></i>'+nameContents.eq(i).text());
//            newFile.find('.file_path').attr('href','http://'+window.location.host+'/order_info_new/download?filename='+pathContents.eq(i).text());
            newFile.find('.file_path').attr('href','http://'+window.location.host+pathContents.eq(i).text());
            newFile.appendTo('.show-transfer-pay');
        }
    });

    //确认线下支付
    $('.confirm-transfer').click(function(){
        $('.transfer-pay-alter').show();
        $('.transfer-pay-alter .confirm-transfer-pay-submit').attr('data-pid',$(this).attr('data-pid'));

    });
    //取消确认线下支付
    $('.cancel-confirm-transfer-pay').click(function(){
        $('.normal-popup').hide();
        $('.popup_bg').remove();
        $('.transfer-pay-alter').hide();
    });

    //拒绝线下支付
    $('.refuse-transfer-submit').click(function(){
        $('.refuse-transfer-pay-alter').show();
        $('.refuse-transfer-pay-alter .refuse-transfer-pay-submit').attr('data-pid',$(this).attr('data-pid'));
    });

    //取消拒绝线下支付
    $('.cancel-refuse-transfer-pay').click(function(){
        $('.normal-popup').hide();
        $('.popup_bg').remove();
        $('.refuse-transfer-pay-alter').hide();
    })

})










