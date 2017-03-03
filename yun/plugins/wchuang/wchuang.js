/**
 * Created by lxh on 16/08/02.
 */
var plugin={
    init:function(){

        this.wchAni()
    },

    //一键找文创按钮
    wchAni:function(){
        window.onscroll = function(){
            var docTop=$(document).scrollTop();
            if(docTop>400){
                $('.wch-btn').addClass('wchbtn-show');
            }else{
                $('.wch-btn').removeClass('wchbtn-show');
            }

            if(docTop>350) {
                $('.wch-adg1-list li .img').addClass('sircleAni');
            }else{
                $('.wch-adg1-list li .img').removeClass('sircleAni');
            }

            if(docTop>700) {
                //$('.wch-adg2-l1').animate({
                //    left:'0'
                //},500);
                //$('.wch-adg2-l2').animate({
                //    left:'50%'
                //},800);
                //$('.wch-adg2-l3').animate({
                //    left:'100%'
                //},1200);
                $('.wch-adg2-l1').addClass('yearAni1');
                $('.wch-adg2-l2').addClass('yearAni2');
                $('.wch-adg2-l3').addClass('yearAni3');
            }else{
                $('.wch-adg2-l1').removeClass('yearAni1');
                $('.wch-adg2-l2').removeClass('yearAni2');
                $('.wch-adg2-l3').removeClass('yearAni3');
            }


            /*兼容公共返回顶部按钮*/
            if (docTop < 100) {
                $("#topcontrol").css("display","none");
            } else {
                $("#topcontrol").css("display","block");
            }
        };
    }


}














