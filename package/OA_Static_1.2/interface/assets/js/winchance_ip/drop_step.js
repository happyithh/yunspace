/**
 * Created by Administrator on 2016/5/11.
 */
$(".drop-step").each(function(index,dom){
    var $dom=$(dom);
});on('click',function(){
    var $this=$(this);
    console.log( $this.find('.tools>a').length);
    $this.find('.tools>a').trigger('click');
});
