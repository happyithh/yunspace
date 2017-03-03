$(function(){
    /*下拉框*/
    $(".select>p").on("click",function(e){
        $(this).parent().toggleClass("open");
        e.stopPropagation();
    });

    $(".select ul li").on("click",function(e){
        $(this).addClass("selected").siblings().removeClass("selected");
        $(this).parents('.select').find('p').text($(this).text());
        //console.log($(this).text());
        $(".select").removeClass("open");
        e.stopPropagation();
    });
    $(document).on("click",function(){
        $(".select").removeClass("open");
    });
    $('.metformul>li').on('click',function(){
        $(this).find('input').focus();
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

    $('.js-submit').on('click',function(){
        var time=$("input[name='time']").val();
        var company = $("input[name='compyname']").val().replace(/ /g,''),
                username = $("input[name='username']").val().replace(/ /g,''),
                phone= $("input[name='telphone']").val().replace(/ /g,''),
                startTime= time.substr(0,10),
                endTime= time.substr(time.length-10),
                actPersons=$("#peoplenumbs").text(),
                event_type=$("#eventtype").text(),
                space_item =$("input[name='space_item']").val(),
                annual_id =$("input[name='annual_id']").val(),
                auth_token =$("input[name='auth_token']").val();



        /*过滤必填项*/
        if(!company){
            alert('您的公司名称不能为空');
            return false;
        }
        if(!time){
            alert('年会时间不能为空');
            return false;
        }
        if(!event_type){
            alert('活动类型不能为空');
            return false;
        }
        if(!actPersons){
            alert('年会人数不能为空');
            return false;
        }
        if(!username){
            alert('您的称呼不能为空');
            return false;
        }
        if(!isMobile(phone)){
            alert('手机格式不正确');
            return false;
        }
        $('.js-submit').text('正在努力提交,请稍等^_^');
        //else{
        //    alert('提交成功')
        //}
        //console.log(username,phone,startTime,endTime,actPersons,compyname,eventtype);
        //return false;
        YunSpace.api('demand/create.jsonp', {
            username : username,
            phone :phone,
            start_date :startTime,
            end_date :endTime,
            people :actPersons,
            company :company,
            event_type :event_type,
            annual_id :annual_id,
            space_item :space_item,
            //auth_token:auth_token,
            action : 'wanda'
        }, function (data) {
            if (data.status == 1) {
                //$("input[name='time']").val('');
                //$("input[name='username']").val('');
                //$("input[name='telphone']").val('');
                //$("input[name='yzcode']").val('');
                //$("#peoplenumbs").text('');
                //$("#yzm_captcha").show();
                //$('.btnyzcode').hide();
                $('.js-submit').text('提交');
                top.alert(data.msg);
                $('.onekeyorder').addClass('hide');
                $('.pop-mask').addClass('hide');
            } else {
                $('.js-submit').text('提交');
                top.alert(data.msg);
            }
        });


    });
    //弹窗
    function setPopForm(){
        //关闭背景遮罩
        function closemask(){
            $('.pop-mask').addClass('hide');
        }
        //关闭弹窗
        function closepop(){
            $('.onekeyorder').addClass('hide');
        }
        //打开背景遮罩
        function openmask(){
            $('.pop-mask').removeClass('hide');
        }
        //打开弹窗
        function openpop(){
            $('.onekeyorder').removeClass('hide');
        }

        $('.js-showform').on('click',function(){
            //console.log($(this).attr('data-id'),$(this).attr('data-space_name'));
            //return false;
            openpop();
            openmask();
            $('.onekeyorder').find("input[name='space_item']").val($(this).attr('data-space_name'));
            $('.onekeyorder').find("input[name='annual_id']").val($(this).attr('data-id'));
        })
        $('.js-close').on('click',function(){
            closepop();
            closemask();
        });
    }
    setPopForm();

});