/**
 * Created by Alex Shen on 2015/6/10.
 */
//这里用于存储相似列表页中，不相同的元素
var controllerPool = {};
$(document).ready(function(){
    $('#activity').show();
    controllerPool.aType = $('#type-service');
    controllerPool.aTypeContent = $('.type');
    controllerPool.url = $("body").attr("data-url");
});
//用于存放筛选条件
var conditionPool = {
    category_id: 0,
    activity: "",
    industry: "",
    orderBy: 1,
    dp:1,
    dn:12,
    dtp:1,
    setConditionToServer: function (successCB, errorCB, timeoutCB) {
        $.ajax({
            url: controllerPool.url,
            type: "post",
            dataType: "json",
            timeout: timeoutCB,
            data: {
                "category_id": conditionPool.category_id,
                "activity": conditionPool.activity,
                "industry": conditionPool.industry,
                "orderBy": conditionPool.orderBy,
                "dp":conditionPool.dp,
                "dn":conditionPool.dn,
                "dtp":conditionPool.dtp
            },
            success: function (jsonData) {
                successCB(jsonData);
            },
            error: function(jsonData) {
                if (errorCB) {
                    errorCB(jsonData);
                }
            }
        });
    }
}