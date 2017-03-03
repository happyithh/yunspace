
//购票页面买票数量选择
var addreduce = {
    totalPrice:0,
    totalNum:0,
    numBeforeOnBlur:0,
    add: function () {
        var price = $(".tkt-choice-price .active").text();
        var ticketNum = $(".tkt-choice-price .active").attr("date-stock");
        if(parseInt($(".js-buy-num").val()) >= parseInt(ticketNum) ){
            alert('您好，当前余票仅剩'+ticketNum+'张,');
            return false;
        }
        addreduce.totalPriceAndNum("add",price,1);

    },
    reduce: function (o) {
        var price = $(".tkt-choice-price .active").text();
        addreduce.totalPriceAndNum("reduce",price,1);
    },
    totalPriceAndNum: function(method,data,unit){
        addreduce.totalNum += (method === "add")?unit:(-1)*unit;
        addreduce.totalPrice+= (method === "add")?(data*unit):(data*(-1)*unit);
        addreduce.totalPrice = Math.round(addreduce.totalPrice*100) /100;
        if(addreduce.totalNum<0){
            addreduce.totalNum = 0;
        }
        if(addreduce.totalPrice<0){
            addreduce.totalPrice = 0;
        }
        $(".js-buy-num").val(addreduce.totalNum);
        $(".js-total-money").html(addreduce.totalPrice);
    },
    setNumBeforeOnBlur:function(o){
        var $this=$(o);
        addreduce.numBeforeOnBlur = $this.val();
    },
    totalPriceAndNumAfterOnBlur:function(o){
        var $this=$(o);
        var r = /^[0-9]*[1-9][0-9]*$/;

        if(!(r.test($this.val()))){
            $this.val(0);
        }
        var price = $(".tkt-choice-price .active").text();
        var currentNum = $(".js-buy-num").val();
        var ticketNum = $(".tkt-choice-price .active").attr("date-stock");
        if(parseInt(currentNum) > parseInt(ticketNum) ){
            alert('您好，当前余票仅剩'+ticketNum+'张,');
            $this.val(ticketNum);
            addreduce.totalPriceAndNum("add",price,ticketNum-addreduce.numBeforeOnBlur);
            return false;
        }
        var changedNum = currentNum-addreduce.numBeforeOnBlur;
        addreduce.totalPriceAndNum("add",price,changedNum);
    }
};

$(".js-btn-reduce").click(function(){
    addreduce.reduce();
});
$(".js-btn-add").click(function(){
    addreduce.add();
});
$(".js-buy-num").blur(function(){
    addreduce.totalPriceAndNumAfterOnBlur(this);
});
$(".js-buy-num").focus(function(){
    addreduce.setNumBeforeOnBlur(this);
});
$(".tkt-choice-price li").bind("click",function(){
    addreduce.totalPrice = 0;
    addreduce.totalNum = 0;
    addreduce.numBeforeOnBlur = 0;
    $(".js-buy-num").val(0);
    $(".js-total-money").html(0);
    $(".tkt-choice-price li").removeClass("active");
    $(this).addClass("active");
})

$('.tkt-choice-time li').bind("click",function(){
    addreduce.totalPrice = 0;
    addreduce.totalNum = 0;
    addreduce.numBeforeOnBlur = 0;
    $(".js-buy-num").val(0);
    $(".js-total-money").html(0);
    $(".tkt-choice-time li").removeClass("active");
    $(this).addClass("active");
})