
//购票页面买票数量选择
var addreduce = {
    totalPrice:0,
    totalNum:0,
    numBeforeOnBlur:0,
    add: function () {
        var price = $(".tkt-choice-price .active").attr("date_price");
        var ticketNum = $(".tkt-choice-price .active").attr("date-stock");
        var total_score = $("#total_score").text();
        var total_money = parseInt($(".js-total-money").text())+20;
        //console.log(total_score,total_money);

        if(parseInt($(".js-buy-num").val()) >= parseInt(ticketNum) ){
            alert('您好，当前余票仅剩'+ticketNum+'张,');
            return false;
        }
        if(parseInt(total_money) > parseInt(total_score)) {
            $(".submit").hide();
            $(".quit").show();
        }
        addreduce.totalPriceAndNum("add",price,1);

    },
    reduce: function (o) {
        var price = $(".tkt-choice-price .active").attr("date_price");
        var total_score = $("#total_score").text();
        var total_money = parseInt($(".js-total-money").text())-20;
        console.log(total_score,total_money);
        addreduce.totalPriceAndNum("reduce",price,1);
        if(parseInt(total_money) <= parseInt(total_score)) {
            $(".quit").hide();
            $(".submit").show();
        }
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
        $(".js-buy-num").attr("value",addreduce.totalNum);
        $(".js-total-money").html(addreduce.totalPrice);
        $(".ticket_id").val($(".tkt-choice-price .active").attr("data_ticket_id"));
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
        var price = $(".tkt-choice-price .active").attr("date_price");
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
initPriceAndNum();
function initPriceAndNum(){
    addreduce.totalNum = 0;
    var price =$(".tkt-choice-price .active").attr("date_price");
    addreduce.totalPriceAndNum("add",price,1);
}
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
    if("disabled" === $(this).attr("disabled")){
        return;
    }
    addreduce.totalPrice = 0;
    addreduce.totalNum = 0;
    addreduce.numBeforeOnBlur = 0;
    $(".js-buy-num").attr("value",0);
    $(".js-total-money").html(0);
    $(".tkt-choice-price li").removeClass("active");
    $(this).addClass("active");
    initPriceAndNum();
})

$('.tkt-choice-time li').bind("click",function(){
    addreduce.totalPrice = 0;
    addreduce.totalNum = 0;
    addreduce.numBeforeOnBlur = 0;
    $(".js-buy-num").attr("value",0);
    $(".js-total-money").html(0);
    $(".tkt-choice-time li").removeClass("active");
    $(this).addClass("active");
    $(".tkt-choice-price li").remove();
    var pricePool = dataObject[$(this).text()];
    var price_is_score = $("#price_is_score").val();
    var virtualDom = "";
    var isTabActive = false;
    for(var i = 0; i<pricePool.length; i++){
        virtualDom +="<li data_ticket_id='"+pricePool[i]["id"]+"' date_price='"+pricePool[i]["price"]+"' date-stock='"+pricePool[i]["stock"]+
        (pricePool[i]["stock"]<=0?"' class='hasno' disabled":"'");
        if((0===i)&&(pricePool[i]["stock"]>0) || ((pricePool[i]["stock"]>0)&&(!isTabActive))){
            if(price_is_score==1) {
                virtualDom += " class='active'";
            }else{
                virtualDom += " class='active'";
            }
            isTabActive = true;
        }
        if(price_is_score==1){
            virtualDom+=">"+pricePool[i]["name"]+"&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;"+pricePool[i]["price"]+"&nbsp;积分</li>";
        }else{
            virtualDom+=">"+pricePool[i]["name"]+"&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;"+pricePool[i]["price"]+"&nbsp;元</li>";
        }
        //virtualDom+=">"+pricePool[i]["name"]+"&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;"+pricePool[i]["price"]+"&nbsp;元</li>";
    }
    $(".tkt-choice-price ul").append(virtualDom);
    $(".tkt-choice-price li").unbind("click").bind("click",function(){
        if("disabled" === $(this).attr("disabled")){
            return;
        }
        addreduce.totalPrice = 0;
        addreduce.totalNum = 0;
        addreduce.numBeforeOnBlur = 0;
        $(".js-buy-num").attr("value",0);
        $(".js-total-money").html(0);
        $(".tkt-choice-price li").removeClass("active");
        $(this).addClass("active");
        initPriceAndNum();
    });
    initPriceAndNum();
})
