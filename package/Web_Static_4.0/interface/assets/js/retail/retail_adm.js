$(function(){
    //我要参展表单提交ajax
    $('.fill li input').on('focus',function(){
        $(this).siblings('.error').hide();
    });
    $('.fill li input').on('blur',function(){
        var $val=$(this).val();
        if($val.length<1){
            $(this).siblings('.error').show();
        }

        if($(this).hasClass('number')){
            if($val.length<1){
                $(this).siblings('.error').show();
                $(this).siblings('.error').text("手机号码不能为空！");
            }

            var aa=$('.number').val();
            if (!(/^1(3|4|5|7|8)\d{9}$/.test(aa))) {

                $(this).siblings('.error').show();
                if($val.length>=1){
                    $(this).siblings('.error').text("手机号码格式不正确！");
                }
            }
        }

    });
    //$('.number').on('keydown',function(){
    //
    //});

   $('.adm_submit').on('click',function(){
       var comy=$('.company').val(),
           name=$('.name').val(),
           num=$('.number').val(),
           site=$('.website').val();

       var data = new Array();
       data[0] = comy,
       data[1] = site,
       data[2] = name,
       data[3] = num;

       var key = new Array();
       key[0] = '公司/品牌',
       key[1] = '合作事项',
       key[2] = '联系人',
       key[3] = '联系方式';

       //是否加载ajax
       function popHide(){
           $('.pop-wrapper').show(300).delay(2000).hide(300);
       }
       if(comy.length<1||name.length<1||num.length<1||!(/^1(3|4|5|7|8)\d{9}$/.test(num))){

           popHide();
           $('.pop-wrapper h2').text('提交失败');
           $('.pop-wrapper p').text('请正确填写表格信息！');
           return false;
       }
       //ajax开始
       var url=$('.section-admform').data('form');
       $.ajax({
           type: "post",
           url: url,
           data: {
               id: 19,
               data: data,
               key: key,
               form_type: 1
           },
           async: false,
           dataType: "json",
           success: function (data) {
               if (data.status == 1) {
                   popHide();
                   $('.pop-wrapper h2').text('提交成功');
                   $('.pop-wrapper p').text('我们会在1天内联系您，请注意接听来电');
                   setTimeout('window.location.reload()',1000);
               } else {
                   popHide();
                   $('.pop-wrapper h2').css('margin-top','53px');
                   $('.pop-wrapper h2').text('提交失败');
                   $('.pop-wrapper p').text(data.msg);
               }
           }
       });
   });

    //表单点击加红色边框
    $('.section-admform li input').on('focus',function(){
        $('.section-admform li').removeClass('red');
        $(this).parents('li').addClass('red');
    });
    $(document).bind("click",function(event){//点击非表格时选中效果消失
        var e = event || window.event;
        var elem = e.srcElement||e.target;
        if(elem){
            if($(elem).parents(".fill").length<=0){
                $('.section-admform li').removeClass('red');
            }
        }
    });


    //它们通过云SPACE来到2016ADM-查看更多
    var numli=$('.section-yun2016adm>ul li').length;
    if(numli<9){//小于9个元素时隐藏 查看更多按钮
        $('.loadmore-btn').hide();
    }

    var dp=1;
    $(document).on('click','.loadmore-btn',function(){//查看更多功能
        dp++;
        YunSpace.api('retail/adm/list.jsonp', {
            dp:dp
        },function (data){
            var str='';
            $.each(data.data,function(v,k){
                if(data.status == 1){
                    str+='<li>'+
                    '<a href="'+ k.url+'.html">'+
                    '<img src="'+ k.logo+'">'+
                    '<p>'+ k.title+'</p>'+
                    '<div class="text-bg"></div>'+
                    '</a>'+
                    '</li>'
                };
            });
            if(data.data.length==0){
                $('.loadmore-btn').text('没有更多了');
                $('.loadmore-btn').css({
                    'text-indent': 0,
                    'background-image':'none'
                });
            }
            $('.section-yun2016adm>ul').append(str);
        });
    });



    /////零售专题详情页面
    //带缩略图的轮播图
    $('.succesny').olvSlides({
        thumb: true,
        thumbPage: true,
        thumbDirection: "Y",
        effect: 'fade',
        play: 5000000
    });

    //当图片的个数小于6个时停止缩略图自动滚动
    var hhnumb=$('.thumbCont>ul li').length;
    var cssStr = 'top: 0px !important;';
    function add_css(name,css){
        var cssText = name + '{ '+ css +' }';
        var style = document.createElement('style');
        document.head.appendChild(style);
        style.sheet='';
        style.sheet.insertRule(cssText,0);
    }
    if(hhnumb < 6){
        add_css('.thumbCont ul',cssStr);
    }

    //点击前后按钮/缩略图-暂停
    var player=$('.emplayer')[0];
    var myPlayer = videojs('my-video');
    var myPauseBtn=$('.ssprev,.ssnext,.thumbWrap ul li');
    myPauseBtn.on('click',function(){
        myPlayer.pause();
        player.Pause();
    });


});