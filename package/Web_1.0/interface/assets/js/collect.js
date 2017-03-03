$(document).ready(function () {
    var collect_type=$('.collect').attr('data-type');
    var id=$('.collect').attr('data-id');
    var url=$('.collect').attr('data-url');
    $.post(url,{collect_type:collect_type,follow_id:id,action:'getstatus'} ,function (data) {
        if (data == '1') {
            $('.collect span').text('取消收藏') ;
            $('.collect').attr('data-status',1).find('i').removeClass('glyphicon-heart-empty').addClass('glyphicon-heart');
        }else{
            $('.collect span').text('加入收藏') ;
            $('.collect').attr('data-status',0).find('i').removeClass('glyphicon-heart').addClass('glyphicon-heart-empty');
        }

    });
	//收藏
	$('.collect').click(function(){
        var status=$('.collect').attr('data-status');
		if(status=="1"){
			var is_cancel=0;
			var message='加入收藏';
			var changeclass='glyphicon-heart-empty';
			var oldclass='glyphicon-heart';
		}else{
			var is_cancel=1;
			var message='取消收藏';
			var changeclass='glyphicon-heart';
			var oldclass='glyphicon-heart-empty';
		}
		// 保存用户收藏信息
		$.ajax({
		    type:"post",
		    url:url,
		    data:{is_cancel:is_cancel,follow_id:id,collect_type:collect_type,action:'collect'},
		    data_type:'json',
		    success:function(data){
                if(data=='alert'){
                    alert("您需要登录后才能收藏！");
                    return false;
                }else{
                    $('.collect span').text(message);
                    $('.collect').attr('data-status',is_cancel);
                    $('.collect').find('i').removeClass(oldclass).addClass(changeclass);
                }

		    }
		})	
	})
})