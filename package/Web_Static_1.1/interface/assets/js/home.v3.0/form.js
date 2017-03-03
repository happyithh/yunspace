/**
/**
 * Created by pzl on 15/9/8.
 */
var browser=navigator.appName
var b_version=navigator.appVersion
var version=b_version.split(";");
var trim_Version=version[1].replace(/[ ]/g,"");
if(version.length>1) {
    if (browser == "Microsoft Internet Explorer" && (trim_Version == "MSIE7.0" || trim_Version == "MSIE8.0")) {
        $(".header-find-room").addClass("header-find-room-ie");
        $(".cover-body").addClass("cover-body-ie");
        $(".d-s-input").find("input").css({
            paddingTop: "10px"
        });
        $(".h-f-r-container").css({
            background: "none"
        })
        $(".dropDown").css({
            background: "#fff"
        });
        $(".cov").addClass("cov-ie");
        $(".product-name-title").addClass("product-name-title-ie");
    }
    if (browser == "Microsoft Internet Explorer" && (trim_Version == "MSIE9.0" || trim_Version == "MSIE10.0")) {
        $(".d-s-input").find("input").addClass('input-ie9-10');
    }
    if (browser == "Netscape" && trim_Version == "WOW64") {
        $(".d-s-input").find("input").css({
            paddingBottom: "13px"
        });
    }
}
//$(".iframe").attr("src","");
$(".dropDown").find("li").on("click",function(){
    //var twoM=$(this).find(".two_m");
    //if(twoM.length>0){
    //    console.log(123);
    //    twoM.parent().find(".lt_two").slideDown(200,function(){
    //        $(this).find("li").on("click",function(){
    //            var vall=$(this).text();
    //            $(this).parent().parent().parent().parent().parent().find(".select-input").val(vall);
    //            $(this).parent().parent().parent().parent().parent().find(".select-click").find("div").text(vall);
    //        })
    //    });
    //    return false;
    //}
    $(".dropDown").hide();
    $(".select-click").find("span").removeClass("s-s-active");
    var txt=$(this).text();
    var place=$(this).parent().parent().parent();
    if(place.find(".select-input").hasClass("city-input_a")) {
        $(".par1").text(txt);
        $(".city-input_a").val();
        alert((".city-input_a").val());
        if($(".person-input").val()!=""){
            place.parent().find(".distance").find(".select-click").trigger("click");
        }
    }
    if(place.find(".select-input").hasClass("person-input")) {
        $(".par1").text(txt);
        $(".person-input").val(txt);
        if($(".person-input").val()!=""){
            place.parent().find(".distance").find(".select-click").trigger("click");
        }
    }
    if(place.find(".select-input").hasClass("area-input")){
        $(".area-input").val(txt);
        if($(".area-input").val()!=""){
            place.parent().find(".distance").find(".select-click").trigger("click");
        }
    }
    if(place.find(".select-input").hasClass("cate-input")){
        $(".par2").text(txt);
        $(".cate-input").val(txt);
    }
    if(place.find(".select-input").hasClass("far-input")){
        $(".par3").text(txt);
        $(".far-input").val(txt);
    }
    if(place.find(".select-input").hasClass("city-input")){
        var txt1=$(this).find("a").text();
        $(".par4").text(txt1);
        $(".city-input").val(txt1);
    }
    if(place.find(".select-input").hasClass("range-input")){
        $(".par5").text(txt);
        $(".range-input").val(txt);
    }
    if($(this).parent().hasClass("city-select")){
        $(this).find("a").css({
            background:"#000",
            color:"#fff"
        });
        $(this).siblings().find("a").css({
            background:"#fff",
            color:"#000"
        });
        //切换城市ajax请求
        YunSpace.Api("",function(){

        })
    }else{
        $(this).siblings().css({
            background:"#fff"
        });
        $(this).css({
            background:"#f2f2f2"
        });
    }
});
$(".select-click").on("click",function(){
    $(".dropDown").hide();
    $(".select-click").removeClass("act");
    $(this).addClass("act");
    $(this).parent().find(".dropDown").fadeIn(200);
    $(".select-click").find("span").removeClass("s-s-active");
    $(this).find("span").addClass("s-s-active");
});

$(".radio").each(function(index,dom){
    $(dom).on("click",function(){
        var demand_id = $(".demand_id").val();
        var radio_Name=$(this).data("name");
        $(this).find("input[name='"+radio_Name+"']").attr("checked","true");
        var temp=$(this).parent().find("input[name='"+radio_Name+"']");
        var title=$(this).parent().find("p").text();
        var q_num=$(this).parent().find(".q_num").val();
        for(var i=0;i<temp.length;i++)
        {
            if(temp[i].checked){
                var answer = temp[i].value;
                //var intHots = temp[i].data('kvalue');
            }
        }
        YunSpace.api("demand/question.json", {
            demand_id:demand_id,
            question: title,
            answer: answer,
            q_num: q_num
            //action: 'events_update'
        }, function (data) {
            if(data.status == 1){
                if( $(this).find("input[name='"+radio_Name+"']").attr("checked")!=true){
                    setTimeout(function(){
                        $(this).parent().addClass("hide");
                        $(".loading").show();
                        setTimeout(function(){
                            if($(".home_question").eq(Math.floor(index/2+1)).length<=0){

                                setTimeout(function(){
                                    $(parent.document).find(".demand-two").animate({
                                        top:"-130%"
                                    },400);
                                    $(parent.document).find(".cover-body").fadeOut(200);
                                    $(".loading").hide();
                                    $(".ajax-form").first().css({
                                        height:"535px"
                                    })
                                    $(".submit-text").html('请完善您的活动信息，云·SPACE场地报价系统将在 <span style="color:#59ebeb;font-size:13px;">30分钟内</span>为您提供多份精准场地报价');
                                    return false;
                                },3000);
                            }
                            $(".loading").hide();
                            $(".home_question").addClass("hide");
                            $(".home_question").eq(data.data.next_q).removeClass("hide");
                            $(".home_question").eq(data.data.next_q).siblings("div.home_question").remove();
                        },1000);
                    },1000);
                }else{
                    return false;
                }
            }else{
                alert(data.msg);
            }
        });
        //if(1){
        //    if( $(this).find("input[name='"+radio_Name+"']").attr("checked")!=true){
        //        setTimeout(function(){
        //            $(this).parent().addClass("hide");
        //            $(".loading").show();
        //            setTimeout(function(){
        //                if($(".home_question").eq(Math.floor(index/2+1)).length<=0){
        //                    $(parent.document).find(".demand-two").animate({
        //                        top:"-130%"
        //                    },400);
        //                    $(parent.document).find(".cover-body").fadeOut(200);
        //                    $(".loading").hide();
        //                    $(".ajax-form").css({
        //                        height:"520px"
        //                    })
        //                    $(".submit-text").html('请完善您的活动信息，云·SPACE场地报价系统将在 <span style="color:#59ebeb;font-size:13px;">30分钟内</span>为您提供多份精准场地报价');
        //                    return false;
        //                }
        //                $(".loading").hide();
        //                $(".home_question").addClass("hide");
        //                $(".home_question").eq(Math.floor(index/2+1)).removeClass("hide");
        //            },1000);
        //        },1000);
        //    }else{
        //        return false;
        //    }
        //}else{
        //    alert("选择未成功！！");
        //}


    });
});
$(document).on(
    ' click',
    function (e) {
        //console.log(e.target)
        var wd=$(".demand-body").width();
        var hd=$(".demand-body").height();
        $(".demand-body").css({
            marginLeft:"-"+wd/2+"px",
            marginHeight:"-"+hd/2+"px"
        })
        if($(e.target).closest(".r-r-select").length === 0){
            $(".r-r-select .dropDown").fadeOut(200,function(){
                $(".select1").find("span").removeClass("s-s-active");
            });
        }
        if($(e.target).closest(".f-method").length === 0){
            $(".f-method .dropDown").fadeOut(200,function(){
                $(".select2").find("span").removeClass("s-s-active");
            });
        }
        if($(e.target).closest(".c-s-c-select2").length === 0){
            $(".c-s-c-select2 .dropDown").fadeOut(200,function(){
                $(".select3").find("span").removeClass("s-s-active");
            });
        }
        if($(e.target).closest(".d-s-input").length === 0){
            $(".d-s-input .dropDown").fadeOut(200,function(){
                $(".select4").find("span").removeClass("s-s-active");
            });
        }
        if($(e.target).closest(".city_guide > li").length === 0){
            $(".city_guide > li .dropDown").fadeOut(200,function(){
                $(".select5").find("span").removeClass("s-s-active");
            });
        }
        //if($(e.target).closest("#datepicker,.dp-table-controller").length === 0){
        //    $(".date-picker").addClass("hide");
        //}
    }
);
