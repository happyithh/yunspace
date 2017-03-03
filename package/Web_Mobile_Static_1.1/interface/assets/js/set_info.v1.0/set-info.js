/**
 * Created by Administrator on 2015/6/10.
 */
$(document).ready(function(){
    var offsetTop = $(".top").height()+$(".image-content-area").height()+$(".top-info-area").height()-$(".choose-set").height()-20;
    $(".version-choose").css("top", offsetTop);
});
$(function(){
    $('.version').click(function(){
        $(".cover,.version-choose").show();
    });
    $(".cate-name").click(function(){
        $(".cate-name").removeClass('active');
        $(this).addClass('active');

        var version=$(this).data("text");
        var schedule_id=$(".image-content-area").data("id");
        var category_id=$(".category").data("id");
        var id=$(".image-content-area").data("text");
        $(".cover,.version-choose").hide();
        $.ajax({
            type:"post",
            url:id+".html?action=version",
            data:{
                "id":id,
                "version":version,
                'category_id':category_id,
                'schedule_id':schedule_id
            },
            dataType:"json",
            success:function(data){
                console.log(data);
                var set_id=data['id'];
                if(data['info']=='success'){
                    var info=$(this).html();
                    $(".cate-title").html(info);
                    window.location.href=set_id+".html";
                }else{
                    alert('此版本正在筹划中！！');
                }
            }
        })
    });
    $(".close-cate, .cover").click(function(){
        $(".cover,.version-choose").hide();
    });
})
