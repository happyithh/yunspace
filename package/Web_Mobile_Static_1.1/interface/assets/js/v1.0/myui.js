var myUi = {
	msgbox:function(msg,callback){
		var nr = '<div style="text-align:center;">'+msg+'<br><br><button type="button" class="btn btn-warning" data-dismiss="modal">确定</button></div>';
		myUi.showWindow('消息提示',nr,callback);
	},
	showWindow:function(title,nr,callback){
		if(callback == undefined || callback == null){
			callback = function(e){}
		}
		if($('#mymsgbox').length < 1){
			var html = '<div class="modal fade" id="mymsgbox" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">'+
						'<div class="modal-dialog">'+
						'<div class="modal-content">'+
						'<div class="modal-header">'+
						'<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>'+
						'<h4 class="modal-title">'+title+'</h4>'+
						'</div>'+
						'<div class="modal-body">'+nr+'</div>'+
						'</div>'+
						'</div>'+
						'</div>';
			$('body').append(html);
		}else{
			$('#mymsgbox .modal-title').html(title);
			$('#mymsgbox .modal-body').html(nr);
		}
		$('#mymsgbox').modal('show');
		$('#mymsgbox').on('hidden.bs.modal',callback);
	}
}