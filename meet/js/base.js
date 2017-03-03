$(function(){
    /*下拉框*/
    $(".select>p").on("click",function(e){
        $(".select").toggleClass("open");
        e.stopPropagation();
    });

    $(".select ul li").on("click",function(e){
        $(this).addClass("selected").siblings().removeClass("selected");
        $(".select>p").text($(this).text());
        $(".select").removeClass("open");
        e.stopPropagation();
    });
    $(document).on("click",function(){
        $(".select").removeClass("open");
    });
    $('.metformul>li').on('click',function(){
        $(this).find('input').focus();
    });

    /*侧边显示/隐藏、返回顶部*/
    $(document).on('scroll',function(){
        var docScrollTop=$(document).scrollTop();
        if(docScrollTop>1000){
            $('.sidefu').removeClass('hide');
        }else{
            $('.sidefu').addClass('hide');
        }
    });
    $('.js-backtop').on('click',function(){
        $('body,html').animate({scrollTop:0},1000);
        return false;
    });

    /**日历初始化**/
    $('#config-demo').daterangepicker({
        autoApply: true,
        language:  'zh-CN',
        opens : 'left',
        autoUpdateInput : false,
        locale : {
            format: "YYYY/MM/DD",
            separator: ' - '
        }
    }, function(start, end, label) {
        $('#config-demo').val(start.format('YYYY/MM/DD')+' - '+ end.format('YYYY/MM/DD'));
    });


    //手机号过滤
    function isMobile(phone){
        if(phone==null)return false;
        var exp= /^(0|86|17951)?(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$/;
        if(exp.test(phone)){
            return true;
        }else{
            return false;
        }
    }
    /*验证码*/
    $('.btnyzcode').on('click',function(){
        var nmb=60;
        var $this=$(this);
        $this.addClass('bggray');
        $this.attr('disabled',true);
        var settime=setInterval(function(){
            nmb--;
            var str='('+nmb+')'+'秒后重新发送';
            $this.text(str);
            if(nmb<1){
                str='重新发送';
                clearInterval(settime);
                $this.removeClass('bggray');
                $this.text(str);
                $this.attr('disabled',false);
            }

        },1000);

    });
    $('.js-submit').on('click',function(){
        var time=$("input[name='time']").val();
        var username = $("input[name='username']").val().replace(/ /g,''),
            phone= $("input[name='telphone']").val().replace(/ /g,''),
            startTime= time.substr(0,10),
            endTime= time.substr(time.length-10),
            actPersons=$("#peoplenumbs").text(),
            yzcode=$("input[name='yzcode']").val().replace(/ /g,'');

        /*过滤必填项*/
        if(!username){
            alert('您的称呼不能为空');
        }else if(!time){
            alert('年会时间不能为空');
        }else if(!isMobile(phone)){
            alert('手机格式不正确')
        }else{
            alert('提交成功')
        }

        $.ajax({
            type: "post",
            url: "http://yun.com/static/api/demand/create.jsonp",
            data: {
                username : username,
                phone :phone,
                start_date :startTime,
                end_date :endTime,
                people :actPersons,
                action : 'events'
            },
            success: function(data){

            }

        });
    });






































});