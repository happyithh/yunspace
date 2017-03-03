yun('global/jquery-1.9.1.min.js');
yun('json.js::get', {did:1}, function(data){

});
var plugin = {
    isInit:{},
    init:function(ele, args){
        $('body').prepend("<div id='modal_"+args.tpl+"'>"+args.tpl+"</div>");
        $('#modal_'+args.tpl).hide();
        this.isInit[args.tpl] = true;
    },
    open:function(ele, args){
        var self = this;
        if(!this.isInit[args.tpl]){
            return  this.init(ele, args, function(){
                self.open(ele, args);
            });
        }
        $('#modal_'+args.tpl).show();
    }
}