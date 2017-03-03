$(document).ready(function(){

    $('.news_good').on('click',function(){
        if($(this).hasClass('news_good_active')) return;
        addLikeState($(this),1)
    });
    $('.news_bad').on('click',function(){
        if($(this).hasClass('news_bad_active')) return;
        addLikeState($(this),0)
    });
    var likeItem = localStorage.getItem("likeGroupItem");
    var likeItemObj = JSON.parse(likeItem) || {};

    function addLikeState(ele,status){


        var $parent = ele.parents('.news_list'),
            artId = $parent.data('id'),
            state = status == 1? 'like' : 'unlike',
            click_type = status == 1? 'praise' : 'tread';

        if(likeItemObj[artId]) return;
        ele.text(parseInt(ele.text())+1);

        $.ajax({
            type: "post",
            url: "/static/api/raiders/handle.jsonp",
            dataType: 'json',
            data:{
                action:'praise_tread',
                raiders_id:artId,
                click_type:click_type
            },
            success:function(data){
                if( data.status == 1){
                    likeItemObj[artId] = state;
                    var json = JSON.stringify(likeItemObj);
                    localStorage.setItem('likeGroupItem',json);
                }else{

                    if(status == 1){ //判断是不是点赞
                        ele.removeClass('news_good_active');
                    }else{
                        ele.removeClass('news_bad_active');
                    }
                    ele.text(parseInt(ele.text())-1);
                }

            },
            error:function(XMLHttpRequest, textStatus, errorThrown){

                if(status == 1){ //判断是不是点赞
                    ele.removeClass('news_good_active');
                }else{
                    ele.removeClass('news_bad_active');
                }
                ele.text(parseInt(ele.text())-1);
            }
        });

        if(status == 1){
            ele.addClass('news_good_active');
        }else{
            ele.addClass('news_bad_active');
        }

    }
    function getLikeState(){
        if(!likeItemObj) return;
        $('.news_list').each(function(){
            var artId = $(this).data('id');
            for( item in likeItemObj){
                if(artId == item){
                    if(likeItemObj[item] == 'like'){
                        $(this).find('.news_good').addClass('news_good_active');
                    }
                    if(likeItemObj[item] == 'unlike'){
                        $(this).find('.news_bad').addClass('news_bad_active');
                    }
                }
            }

        })
    }
    getLikeState();//获取状态
   //$('.news_good').click(function(){
   //    var good_n=$('.news_good').html();
   //    var good_num=parseInt(good_n)+1;
   //    if($('.news_good').hasClass('news_good_active')){
   //        return false;
   //    }else if($('.news_bad').hasClass('news_bad_active')) {
   //        return false;
   //    }else{
   //        $(this).html(good_num);
   //    }
   //    if($('.news_bad').hasClass('news_bad_active')){
   //        return false;
   //    }else{
   //        $(this).addClass('news_good_active');
   //    }
   //
   //});
   // $('.news_bad').click(function(){
   //     var bad_n=$('.news_bad').html();
   //     var bad_num=parseInt(bad_n)+1;
   //     if($('.news_bad').hasClass('news_bad_active')){
   //         return false;
   //     }else if($('.news_good').hasClass('news_good_active')) {
   //         return false;
   //     }else{
   //         $(this).html(bad_num);
   //     }
   //     if($('.news_good').hasClass('news_good_active')){
   //         return false;
   //     }else{
   //         $(this).addClass('news_bad_active');
   //     }
   //
   // });
});