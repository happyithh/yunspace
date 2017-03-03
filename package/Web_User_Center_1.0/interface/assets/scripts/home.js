$(function(){
	$(".con_h_l > ul > li").hover(function(e){
		var index=$(this).index();
		$(".con_h_l > ul > li").eq(index).find(".menu_r").show();
	},function(){
		var index=$(this).index();
		$(".con_h_l > ul > li").eq(index).find(".menu_r").hide();
	});
	

	
	
//	$(".list>ul").find('li').hover(function(){
//		var index=$(this).index();
//		//alert(index);
////		$(".con_h_c>ul").find("li").css("margin-left",-645*index+"px");
////		$(".con_h_c>ul>li:first").animate({'margin-left':'-200px'},1000,function(){
////			//灏嗙涓�釜li鎻掑叆鍒版渶鍚庝竴涓猯i鍚庤竟
////			//姝ゆ椂绗簩涓猯i鍙樻垚绗竴涓猯i
////			$("li:first").css("margin-left",0).insertAfter($("li:last"));
////		});
//	})
	
    //图片轮播
	var ind=1;
	$(".list>ul").find("li").eq(0).find("a").css("color","#a965c8");
	
	var set=setInterval(function(){
		if(ind>$('.list>ul').find('li').length-1){
			ind=0;
		}
		$(".list>ul").find("li").find("a").css("color","#ffffff");
		$(".list>ul").find("li").eq(ind).find("a").css("color","#a965c8");
		$(".con_h_c>ul>li:first").animate({'margin-left':'-645px'},1000,function(){
		$(".con_h_c>ul>li:first").css("margin-left",0).insertAfter($(".con_h_c>ul>li:last"));
		})
		ind++;
	},2000);
	
	$(".con_h_c").hover(function(){
		clearInterval(set);
	})
	
	//推荐显示
	$(".con_c_h_bottom_1").show();
	$(".con_c_h_top").find("button").first().css({color:"#ffffff",background:"#24252f"});
	$(".con_c_h_top").find("button").first().click(function(){
		$(".con_c_h_bottom_2").hide();
		$(".con_c_h_bottom_1").show();
	});
	$(".con_c_h_top").find("button").last().click(function(){
		$(".con_c_h_bottom_1").hide();
		$(".con_c_h_bottom_2").show();
		
	})
})