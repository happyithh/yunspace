(function($,win,doc){
    var $$={
        zan:$(".zan")
    };
    setLocal();
    $$.zan.each(function(index,dom){
        var id=$(dom).data('id');
        if(isSetId(id,$(dom))){
            $(dom).addClass('active');
        }
    });

    var zan;
    $(document).delegate(".zan","click",  function(){
        zan=$(this);
        var id=zan.data('id');
        if(isSetId(id)){
            zan.addClass('active');
            return false;
        }else{
            ajaxZan(id);
        };
    });
    function setLocal(){
        var retail_id=localStorage.getItem("classify_id");
        if(retail_id==undefined){
            localStorage.setItem("classify_id",",");
        }
    }
    function isSetId(id,o){
        var idStr=localStorage.getItem("classify_id");
        var idArr=idStr.split(',');
        if($.inArray(id+"", idArr)<0){
            return false;
        }else{
            var z=zan||o;
            z.addClass('active');
            return true;
        }
    }
    function saveId(id){
        var idStr=localStorage.getItem("classify_id");
        var idArr=idStr.split(',');
        idArr.push(id+"");
        idStr=idArr.join(',');
        localStorage.setItem("classify_id",idStr);
        zan.addClass('active');
        var num=parseInt(zan.find('span').text());
        zan.find('span').text(++num);
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