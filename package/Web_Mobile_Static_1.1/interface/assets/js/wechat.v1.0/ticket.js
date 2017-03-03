
//购票页面买票数量选择
var addreduce = {
    totalPrice:0,
    totalNum:0,
    numBeforeOnBlur:0,
    add: function (o) {
        var $this=$(o).siblings("input"),
            n=$this.val(),
            num=parseInt(n)+1;
        var price = $this.attr("data-value");
        var ticketNum = $this.attr("ticket-value");
           if(parseInt(num) > parseInt(ticketNum) ){
               alert('您好，当前余票仅剩'+ticketNum+'张,');
               return false;
           }
        addreduce.totalPriceAndNum("add",price,1);
        $this.val(num);

    },
    reduce: function (o) {
        var $this=$(o).siblings("input"),
            n=$this.val(),
            num=parseInt(n)-1;

        if(num<0){
            return;
        }
        var price = $this.attr("data-value");
        addreduce.totalPriceAndNum("reduce",price,1);
        $this.val(num);
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
        $(".js-total-num").html(addreduce.totalNum);
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
        var price = $this.attr("data-value");
        var currentNum = $this.val();
        var ticketNum = $this.attr("ticket-value");
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
    addreduce.reduce(this);
});
$(".js-btn-add").click(function(){
    addreduce.add(this);
});
$(".js-buy-num").blur(function(){
    addreduce.totalPriceAndNumAfterOnBlur(this);
});
$(".js-buy-num").focus(function(){
    addreduce.setNumBeforeOnBlur(this);
});
