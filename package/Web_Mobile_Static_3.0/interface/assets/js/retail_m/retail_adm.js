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
    $('.fill li').on('click',function(){
        $(this).find('input').focus();
    });

   $('.adm_submit').on('click',function(){
       var name=$('.name').val(),
           num=$('.number').val(),
           comy=$('.company').val(),
           needs=$('.needs').val();

       var data = new Array();

       data[0] = name,
       data[1] = num,
       data[2] = comy,
       data[3] = needs;

       var key = new Array();
       key[0] = '姓名',
       key[1] = '电话',
       key[2] = '单位',
       key[3] = '合作事项';

       //是否加载ajax
       function popHide(){
           $('.pop-wrapper').show(300).delay(2000).hide(300);
       }
       if(comy.length<1||needs.length<1||name.length<1||num.length<1||!(/^1(3|4|5|7|8)\d{9}$/.test(num))){
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
               id: 20,
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

});