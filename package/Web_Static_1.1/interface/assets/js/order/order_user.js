$(document).ready(function(){

    //评价订单-明细列表收起/展开
    $('.js-hvpay-btndown').click(function(){
        $(this).parents('.hdt1').slideUp(100);
        $('.hdt2').slideDown();
        $('.hvpay-table-wrap').slideDown();
    });
    $('.js-hvpay-btnup').click(function(){
        $(this).parents('.hdt2').slideUp(100);
        $('.hdt1').slideDown();
        $('.hvpay-table-wrap').slideUp();
    });

    //初始化预订总价
    $('.js-total-money').text(($('.js-buy-num').val())*($('.unit_price').val()));
    //预订数量
    var addreduce = {
        totalPrice:0,
        totalNum:0,
        numBeforeOnBlur:0,
        unitPrice:$('.unit_price').val(),
        add: function (o) {
            var $this=$(o).siblings("input"),
                n=$this.val(),
                num=parseInt(n)+1;
            var maxNum = $this.attr("data-max-value");
            if(parseInt(num) > parseInt(maxNum) ){
                $('.unusual-txt').show();
                return false;
            }
            addreduce.totalPriceAndNum(num);
            $this.val(num);
            $('.unusual-txt').hide();

        },
        reduce: function (o) {
            var $this=$(o).siblings("input"),
                n=$this.val(),
                num=parseInt(n)-1;
            var minNum = $this.attr("data-min-value");
            if(parseInt(num) < parseInt(minNum) ){
                $('.unusual-txt').show();
                return false;
            }
            addreduce.totalPriceAndNum(num);
            $this.val(num);
            $('.unusual-txt').hide();
        },
        totalPriceAndNum: function(num){
            addreduce.totalNum = num;
            addreduce.totalPrice = (addreduce.totalNum) * (addreduce.unitPrice);
            console.log(addreduce);
            if(addreduce.totalNum<0){
                addreduce.totalNum = 0;
            }
            if(addreduce.totalPrice<0){
                addreduce.totalPrice = 0;
            }
            $(".js-total-num").html(addreduce.totalNum);
            $(".js-total-money").html(addreduce.totalPrice);
            $('.unusual-txt').hide();
        },
        totalPriceAndNumAfterOnBlur:function(o){
            var $this=$(o);
            var r = /^[0-9]*[1-9][0-9]*$/;

            if(!(r.test($this.val()))){
                $this.val(0);
            }
            var currentNum = $this.val();

            var maxNum = $this.attr("data-max-value");
            var minNum = $this.attr("data-min-value");
            if(parseInt(currentNum) > parseInt(maxNum) ){
                $('.unusual-txt').show();
                $this.val(maxNum);
                addreduce.totalPriceAndNum($this.val());
                return false;
            }
            if(parseInt(currentNum) < parseInt(minNum) ){
                $('.unusual-txt').show();
                $this.val(minNum);
                addreduce.totalPriceAndNum($this.val());
                return false;
            }
            $('.unusual-txt').hide();
            addreduce.totalPriceAndNum(currentNum);
        }
    };

    $(".js-btn-reduce").click(function(){
        addreduce.reduce(this);
    });
    $(".js-btn-add").click(function(){
        addreduce.add(this);
    });
    $(".js-buy-num").blur(function(){
        addreduce.totalPriceAndNumAfterOnBlur(this);
    });
    $('.num-tip-close').click(function(){
        $('.unusual-txt').hide();
    })

    //提示/警告
//    $('.ipt-txt').on('focus',function(){
//        $('.warning').css('display','block');
//    });
//    $('.ipt-txt').on('blur',function(){
//        $('.warning').hide();
//    });
});