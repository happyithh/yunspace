//用法
//ducalendar.showCalendar('#calendar',2015,3,function(){});
var ducalendar = {
	getDays:function(y,m){
		if(m == 2){
			return y % 4 == 0 && y % 100 != 0 || y % 400 == 0 ? 29 : 28;
		}else if(m == 1 || m == 3 || m == 5 || m == 7 || m == 8 || m == 10 || m == 12){
			return 31;
		}else{
			return 30;
		}
	},
	showCalendar:function(obj,y,m,fun){
		var current = new Date();
		var days = parseInt(ducalendar.getDays(y,m));
		var d = new Date(y,m-1,1);
		d = parseInt(d.getDay());
		var rows =  Math.ceil((days-(7-d))/7);
		
		if($('#ducalendar').length<1){
			var html = '<table id="ducalendar" border="0" cellspacing="0" cellpadding="0"><tr class="ducalendar-week"><td>日</td><td>一</td><td>二</td><td>三</td><td>四</td><td>五</td><td>六</td></tr></table>';
			$(obj).html(html);
			for(var i=0;i<=rows;i++){
				$('#ducalendar').append('<tr class="ducalendar-days"><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>');
			}
		}
		
		$('.ducalendar-days td').removeClass('today').html('&nbsp;');
		var eq = 0;
		var week = 0;
		$('.ducalendar-days td').removeClass('ducalendar-today').removeAttr('my-date');
		for(var i = 1;i<=days;i++){
			eq = d;
			//获取每一个星期名
			week = new Date(y,m-1,i);
			week = week.getDay();
			$('.ducalendar-days td').eq(eq).html(i).attr('my-date',y+'-'+m+'-'+i).attr('my-weekday',week);
			
			if(parseInt(current.getFullYear())==y && parseInt(current.getMonth())+1==m && parseInt(current.getDate())==i){
				$('.ducalendar-days td').eq(eq).addClass('ducalendar-today');
			}
			d ++;
		}
		if(typeof(fun) != 'undefined' && typeof(fun) === 'function'){
			fun();
		}
	}
}