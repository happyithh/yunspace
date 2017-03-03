$(function(){

    $('.zan-i').on('click',function(){
        if($(this).hasClass('active')) return;
        addLikeState($(this),1)
    });
    $('.cai-i').on('click',function(){
        if($(this).hasClass('active')) return;
        addLikeState($(this),0)
    });

    var likeItem = localStorage.getItem("likeGroupItem");
    var likeItemObj = JSON.parse(likeItem) || {};
    var artId = $('#zan').data('id');

    function addLikeState(ele,status){

        var text = ele.next('.num');
        var state = status == 1? 'like' : 'unlike',
            click_type = status == 1? 'praise' : 'tread';

        if(likeItemObj[artId]) return;

        text.text(parseInt(text.text())+1);

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
                    text.text(parseInt(text.text())-1);
                    ele.removeClass('active');
                }

            },
            error:function(XMLHttpRequest, textStatus, errorThrown){
                text.text(parseInt(text.text())-1);
                ele.removeClass('active');
            }
        });

        ele.addClass('active');
    }

    function getLikeState(){
        if(!likeItemObj) return;

        for( item in likeItemObj){
            if(artId == item){
                if(likeItemObj[item] == 'like'){
                    $('.zan-i').addClass('active');
                }
                if(likeItemObj[item] == 'unlike'){
                    $('.cai-i').addClass('active');
                }
            }
        }
    }
    getLikeState();//获取状态

    var fixedPiece = $('#fixedPiece');
    var offsetTop1 = fixedPiece.offset().top;
    var fixedPieceH = fixedPiece.outerHeight();
    fixedPiece.css({
        'height':fixedPieceH
    });
    if(fixedPiece.offset()){

        //var bottomOffset = $('.footer-outside').offset().top;
        var docHeight = $(document).height();
        var footerH = $('.footer-outside').height() + $('.bottom-outside').height();
        //var sprtH=$('.space-right').height();
        var winH = $(window).height();

        function dealFixed(){
            docHeight = $(document).height();
            var st = $(document).scrollTop();
            var sl = $(document).scrollLeft();
            var offsetLeft = $('.fixed-wrap').offset().left;
            var residue = docHeight - st -winH; //剩余的文档高度
            //alert(residue)

            if( sl > 0){
                offsetLeft -= sl;
            }

            if(st >= offsetTop1){
                fixedPiece.css({
                    'position':'fixed',
                    'left': offsetLeft,
                    'top':'50px'
                });
            }else{
                fixedPiece.css({
                    'position':'relative',
                    'top':'0px',
                    'left': 0,
                    'bottom':'auto'
                });
            }



            //if(residue < footerH){
            //    console.log(footerH);
            //    console.log(residue);
            //    fixedPiece.css({
            //        'position':'fixed',
            //        'left': offsetLeft,
            //        'bottom':footerH - residue,
            //        'top':'auto'
            //    });
            //}

            if( winH < (fixedPieceH+footerH) ){
                if( (winH + residue) < (footerH + fixedPieceH)){
                    fixedPiece.css({
                        'position':'fixed',
                        'left': offsetLeft,
                        'bottom':footerH - residue,
                        'top':'auto'
                    });
                }
            }


        }

        window.onscroll = function(){
            dealFixed();
        };
        window.onresize = function(){
            winH = $(window).height();
            dealFixed()
        };
    }
});
(function($) {
    var _options = {};
    jQuery.fn.fiexd = function(options) {
        var id = $(this).attr("id");
        _options[id] = $.extend({}, $.fn.fiexd.defaults, options);
        var obj = $(this);
        var offsetTop = this.offset().top - parseInt(_options[id].top);
        _scroll($(document).scrollTop() > offsetTop);
        $(window).scroll( function() {
            _scroll($(document).scrollTop() > offsetTop);
        });
        function _scroll(isChange){
            if(isChange){
                obj.css({"position":"fixed", "top":_options[id].top});
                if($.browser.msie && ($.browser.version == 6.0)){
                    obj.css({"position":"absolute", "top":$(document).scrollTop()+parseInt(_options[id].top)});
                }else{
                    obj.css({"position":"fixed", "top":_options[id].top});
                }
            }else{
                obj.css({"position":"", "top":""});
            }
        }
    }
    jQuery.fn.fiexd.defaults = {
        top: '0px'
    };
})(jQuery);