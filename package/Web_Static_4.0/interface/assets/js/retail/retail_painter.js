(function($,win,doc){
    var $$={
        zan:$(".zan")
    };
    setLocal();
    var id=$$.zan.find('a').data('id');
    if(isSetId(id)){
        $$.zan.find('a').addClass('active');
    }
    $$.zan.find('a').on("click",function(){
        var $this=$(this);
        var id=$this.data('id');
        console.log();
        if(isSetId(id)){
            $$.zan.find('a').addClass('active');
            return false;
        }else{
            ajaxZan(id);
        };
    });
    function setLocal(){
        var retail_id=localStorage.getItem("retail_id");
        if(retail_id==undefined){
            localStorage.setItem("retail_id",",");
        }
    }
    function isSetId(id){
        var idStr=localStorage.getItem("retail_id");
        var idArr=idStr.split(',');
        if($.inArray(id+"", idArr)<0){
            return false;
        }else{
            $$.zan.find('a').addClass('active');
            return true;
        }
    }
    function saveId(id){
        var idStr=localStorage.getItem("retail_id");
        var idArr=idStr.split(',');
        idArr.push(id+"");
        idStr=idArr.join(',');
        localStorage.setItem("retail_id",idStr);
        $$.zan.find('a').addClass('active');
        var num=$$.zan.find('span').text();
        $$.zan.find('span').text(++num);
    }
    function  ajaxZan(id){
        YunSpace.api('raiders/handle.jsonp',{
                action:"praise_tread",
                raiders_id:id,
                click_type:"praise"
        },function(data){
            saveId(id);
        })

    }
})(jQuery,window,document);