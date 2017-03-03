
/**
 * Created by Administrator on 2016/5/9.
 */
(function($,win,doc){
    $("input[name='czr']").on("change",function(){
        var v= $("input[name='czr']:checked").val();
        if(v=='1'){
            $(".czr").css({
                display:'block'
            });
            $("input[name='czr_name']").attr('required','required');
        }else{
            $(".czr").css({
                display:'none'
            });
            $("input[name='czr_name']").attr('required',false);
        }
    });
    //if($("#step1").hasClass("shou")){
    //    $("#step1 .tools>a").on('click',function(){
    //        return false;
    //        $(this).attr('class','collapse');
    //    })
    //}
    //$('.shou').css({
    //   display:"none"
    //});
    //$('.shou .tools>a').attr('class','collapse');
})(jQuery,window,document);
