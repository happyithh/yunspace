/**
 * Created by Administrator on 2016/1/13.
 */
space_item = {
    // 获取联系信息
    getSpaceItem: function (e) {
        $('.contacts').val($(e).data('item-contacts'));
        $('.phone').val($(e).data('item-phone'));
        $('.email').val($(e).data('item-email'));
        $('.id').val($(e).data('id'));

    },
//修改子空间联系信息
    update_info: function (o) {
        var id = $('.id').val();
        var contacts = $('.contacts').val();
        var phone = $('.phone').val();
        var email = $('.email').val();
        $.ajax({
                url:'?action=update_info',
                type:'post',
                data:{id:id,contacts:contacts,phone:phone,email:email},
                dataType:'json',
                success:function(data){
                    if(data.status==1){
                        top.alert(data.msg);
                        window.location.reload();
                    }else{
                        top.alert(data.msg);
                    }
                }
            }

        );
    },
    // 获取价格信息
    getItemPrice: function (e) {
        $('.min_price').val($(e).data('mix-price'));
        $('.max_price').val($(e).data('max-price'));
        $('.price_unit').val($(e).data('price-unit'));
        $('.id').val($(e).data('id'));

    },
//修改子空间联系信息
    update_price: function (o) {
        var id = $('.id').val();
        var min_price = $('.min_price').val();
        var max_price = $('.max_price').val();
        var price_unit = $('.price_unit').val();
        $.ajax({
                url:'?action=update_price',
                type:'post',
                data:{id:id,min_price:min_price,max_price:max_price,price_unit:price_unit},
                dataType:'json',
                success:function(data){
                    console.log(data);
                    if(data.status==1){
                        top.alert(data.msg);
                        window.location.reload();
                    }else{
                        top.alert(data.msg);
                    }
                }
            }
        );
    }

}
