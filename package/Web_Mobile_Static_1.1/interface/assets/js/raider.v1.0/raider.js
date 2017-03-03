window.onload=function(){
    var timer=null;
    var bSys=true;
    //window.onscroll=function(){
    //    if(!bSys){
    //        clearInterval(timer);
    //    }bSys=false;
    //}
    var oBtn=document.getElementById('scrolltop-raider');
    oBtn.onclick=function(){
        timer=setInterval(function(){
            var scrollTop=document.documentElement.scrollTop||document.body.scrollTop;
            var iSpeed=Math.floor(-scrollTop/8);
            if(scrollTop==0){
                clearInterval(timer);
            }
            bSys=true;
            document.body.scrollTop=document.documentElement.scrollTop=scrollTop+iSpeed;
        },30);
    }
}
