/**
 * Created by pzl on 16/5/13.
 */
(function($,win,doc){
    Array.prototype.indexOf = function(val) {
        for (var i = 0; i < this.length; i++) {
            if (this[i] == val) return i;
        }
        return -1;
    };
    Array.prototype.remove = function(val) {
        var index = this.indexOf(val);
        if (index > -1) {
            this.splice(index, 1);
        }
    };
    var $$={
        citySelect:$(".city_select"),
        guestSelect:$(".guest_select"),
        areaSelect:$(".area_select"),
        cateSelect:$(".cate_select"),
        addressSelect:$(".address_select"),
        nextStep:$(".to-step2"),
        formBody:$(".form-body"),
        guestTypeSelect:$(".guest_type_select"),
        calendarSelect:$(".calendar_select"),
        otherSelect:$(".other_select"),
        company:$(".company"),
        username:$(".username"),
        phone:$(".phone"),
        formGroupList:$(".form-group-list"),
        device:$(".device"),
        submitStep:$(".to-step3"),
        reContentTwo:$(".re-content-two"),
        inputDrop:$(".input-drop"),
        numInput:$('.num'),
        priceInput:$(".price"),
        toPre:$(".to-pre"),
        stepOneForm:$(".step1-form")
    };
    var scrollre=$$.reContentTwo.offset().top;
    $$.formBody.eq(0).show();
    onlySelect($$.guestSelect,'guest');
    onlySelect($$.guestTypeSelect,'guest_type');
    onlySelect($$.calendarSelect,'calender');
    moreSelect($$.citySelect,'city');
    moreSelect($$.areaSelect,'area');
    moreSelect($$.cateSelect,'cate');
    moreSelect($$.addressSelect,'address');
    moreSelect($$.otherSelect,'other_demand');
    inputData($$.company,'company');
    inputData($$.username,'username');
    inputData($$.phone,'phone');
    _data('retail').company=$$.company.val().replace(/\s/g, "");
    _data('retail').username=$$.username.val().replace(/\s/g, "");
    _data('retail').phone=$$.phone.val().replace(/\s/g, "");
    function inputData(o,dataKey){

        o.on('blur',function(){
            _data('retail')[dataKey]=o.val().replace(/\s/g, "");
        });
    }
    function onlySelect(o,dataKey){
        _data('retail')[dataKey]="无";
        if(o.hasClass("required")){
            _data('retail')[dataKey]=o.find('li').eq(0).text();
        }
        o.find('li').each(function(index,dom){
            var $dom=$(dom);
            $dom.on('click',function(){
                var text=$(this).text();
                o.find('li').removeClass('only-active');
                $(this).addClass('only-active');
                _data('retail')[dataKey]=text;
            });
        });
    }
    function moreSelect(o,dataKey){
        var select_arr=[];
        var retail=_data('retail');
        retail[dataKey]="无";
        if(o.hasClass("required")){
            select_arr.push(o.find('li').eq(0).text());
            var s=select_arr.join(',');
            retail[dataKey]=s;
        }
        o.find('li').each(function(index,dom){
            var $dom=$(dom);
            $dom.on('click',function(){
                var $this=$(this);
                var text=$this.text();
                $this.toggleClass('more-active');
                if($this.hasClass("more-active")){
                    select_arr.push(text);
                }else{
                    select_arr.remove(text);
                }
                var s=select_arr.join('，');
                retail[dataKey]=s;
                if(select_arr.length==0){
                    retail[dataKey]="无";
                }
            })
        })
    }
    $$.nextStep.on("click",function(){
        $(".error").hide();
        if(_data('retail').city==""||_data('retail').city=="无"){
            $('.step1-form').find(".error").eq(0).show();
            return;
        }
        if(_data('retail').area==""||_data('retail').area=="无"){
            $('.step1-form').find(".error").eq(1).show();
            return;
        }
        if(_data('retail').cate==""||_data('retail').cate=="无"){
            $('.step1-form').find(".error").eq(2).show();
            return;
        }
        if(_data('retail').address==""||_data('retail').address=="无"){
            $('.step1-form').find(".error").eq(3).show();
            return;
        }
        $(window).scrollTop(scrollre);
        $$.formBody.eq(0).hide();
        $$.formBody.eq(1).fadeIn(500);
    });
    $$.toPre.on('click',function(){
        $$.formBody.eq(1).hide();
        $$.formBody.eq(0).fadeIn(500);
        $(window).scrollTop(scrollre);
    });
    var product_type={
        '快闪电/体验店':"",
        'DP点(售卖机/展示点)':"",
        '品牌特卖':"",
        '店中店':"",
        '其他':""
    };
    $$.formGroupList.find('li').each(function(index,dom){
        var $dom=$(dom),
            inputGroup;
            switch(index){
                case 0:
                    inputGroup={'快闪电/体验店':{'数量':"**",'价格':"**",'面积':"**",'层高':"**"}};
                    getProduct($(this),inputGroup,'快闪电/体验店');
                    break;
                case 10:
                    inputGroup={'DP点(售卖机/展示点)':{'数量':"**",'价格':"**",'面积':"**",'层高':"**"}};
                    getProduct($(this),inputGroup,'DP点(售卖机/展示点)');
                    break;
                case 20:
                    inputGroup={'品牌特卖':{'数量':"**",'价格':"**",'面积':"**",'层高':"**"}};
                    getProduct($(this),inputGroup,'品牌特卖');
                    break;
                case 30:
                    inputGroup={'店中店':{'数量':"**",'价格':"**",'面积':"**",'层高':"**"}};
                    getProduct($(this),inputGroup,'店中店');
                    break;
                case 40:
                    inputGroup={'其他':""};
                    $(this).find('.other-pro-type').on('blur',function(){
                        product_type['其他']= $(this).val().replace(/\s/g, "")==""?"**":'其他:'+$(this).val().replace(/\s/g, "");
                        if(product_type['其他']!="**"){
                            $(this).parents('li').addClass("cate-type-active1");
                        }else{
                            $(this).parents('li').removeClass("cate-type-active1");
                        }
                    });
                    break;
            }
    });
    function getProduct(o,inputGroup,index){
        o.find('.num').on('blur',  function(){
            inputGroup[index]['数量']=$(this).val().replace(/\s/g, "")==""?"**":$(this).val().replace(/\s/g, "");
            var inputStr=index+":"+JSON.stringify(inputGroup[index]);
            inputStr=inputStr.replace(/\"/g, "");
            product_type[index]=inputStr;
            if(inputGroup[index]['数量']!="**"){
                $(this).parents('li').addClass("cate-type-active1");
            }else{
                $(this).parents('li').removeClass("cate-type-active1");
            }
        });
        o.find(".price").on('blur',function(){
            inputGroup[index]['价格']=$(this).val().replace(/\s/g, "")==""?"**":$(this).val().replace(/\s/g, "");
            var inputStr=JSON.stringify(inputGroup[index]);
            inputStr=index+":"+inputStr.replace(/\"/g, "");
            product_type[index]=inputStr;
            if(inputGroup[index]['价格']!="**"){
                $(this).parents('li').addClass("cate-type-active2");
            }else{
                $(this).parents('li').removeClass("cate-type-active2");
            }
        });
        o.find('.input-drop li').on('click',function(){
            var text=$(this).text();
            $(this).parents('.input-drop').find('span:first').text(text).removeClass('placeholder');
            var cla=$(this).parents('.input-drop').find('span:first').attr('class');
            if(cla.indexOf('square')>-1){
                inputGroup[index]['面积']=text+"㎡";
            }
            if(cla.indexOf('floor')>-1){
                inputGroup[index]['层高']=text+"m";
            }
            var inputStr=JSON.stringify(inputGroup[index]);
            inputStr=inputStr.replace(/\"/g, "");
            product_type[index]=index+":"+inputStr;
            if(inputGroup[index]['面积']!="**"||inputGroup[index]['层高']!="**"){
                $(this).parents('li').addClass("cate-type-active3");
            }else{
                $(this).parents('li').removeClass("cate-type-active3");
            }
        });
    }
    deviceData($$.device.find('.device_size'));
    deviceData($$.device.find('.device_power'));
    deviceData($$.device.find('.device_sx'));
    function deviceData(o){
        var size,power,sx;
        o.on('blur',function(){
            size=$$.device.find('.device_size').val()?'长*搞*宽:'+$$.device.find('.device_size').val()+"m/":"";
            power=$$.device.find('.device_power').val()?"用电功率:"+$$.device.find('.device_power').val()+"w/":"";
            sx=$$.device.find('.device_sx').val()?"上下水:"+$$.device.find('.device_sx').val()+"m³":"";
            _data('retail')['device_size']=size+power+sx;
        });
    }

    $$.submitStep.on("click",function(){
        $(window).scrollTop(scrollre);
        $(".error").hide();
        if(_data('retail').company==""){
            $('.step2-form').find(".error").eq(0).show();
            $(".company").focus();
            return ;
        }
        if(_data('retail').username==""){
            $('.step2-form').find(".error").eq(1).show();
            $(".username").focus();
            return ;
        }
        var exp=/^(0|86|17951)?(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$/;
        if(_data('retail').phone==""||!exp.test(_data('retail').phone)){
            $('.step2-form').find(".error").eq(2).show();
            $(".phone").focus();
            return ;
        }
        showData();
    });
    function showData(){
        var t1,t2,t3,t4,t5;
        t1=product_type['快闪电/体验店']==""?"":product_type['快闪电/体验店'];
        t2=product_type['DP点(售卖机/展示点)']==""?"": ";"+product_type['DP点(售卖机/展示点)'];
        t3=product_type['品牌特卖']==""?"":";"+product_type['品牌特卖'];
        t4=product_type['店中店']==""?"":";"+product_type['店中店'];
        t5=product_type['其他']==""?"":";"+product_type['其他'];
        var allOther=t1+t2+t3+t4+t5==""?"无":"("+t1+t2+t3+t4+t5+")";
        _data('retail').produce_type=allOther;
        var data = new Array();
        data[0] = _data('retail').city,
        data[1] = _data('retail').area,
        data[2] = _data('retail').cate,
        data[3] = _data('retail').address,
        data[4] = _data('retail').guest,
        data[5] = _data('retail').company,
        data[6] = _data('retail').username,
        data[7] = _data('retail').phone,
        data[8] = _data('retail').guest_type,
        data[9] = _data('retail').produce_type,
        data[10] = _data('retail').calender,
        data[11] = _data('retail').device_size,
        data[12] = _data('retail').other_demand;
        var key = new Array();
        //所需城市、所需城市、场地分类、位置要求、客户人群、公司名称、您的称呼、手机号码 、
        key[0] = '所需城市',
        key[1] = '所需区域',
        key[2] = '场地类型',
        key[3] = '落位区域',
        key[4] = '商业客流',
        key[5] = '公司名称',
        key[6] = '您的称呼',
        key[7] = '手机号码';
        key[8] = '目标客群';
        key[9] = '产品类型';
        key[10] = '档期周期';
        key[11] = '装置尺寸';
        key[12] = '其他要求';
        var url=$('body').data('form');
        $.ajax({
            type: "post",
            url: url,
            data: {
                id: 16,
                data: data,
                key: key,
                form_type: 1
            },
            async: false,
            dataType: "json",
            success: function (data) {
                if (data.status == 1) {
                    $$.formBody.eq(1).hide();
                    $$.formBody.eq(2).fadeIn(500);
                } else {
                    $$.joinTip.text('提交失败，请重新提交！！').show().fadeOut(5000);
                }
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                console.log(XMLHttpRequest);
                console.log(textStatus);
                console.log(errorThrown);
            }
        });
    }
   function showCode(index){
        $(".person-code-img-one").hide();
        $(".person-code-img-one").eq(index).fadeIn();
        $(".cover-one").fadeIn();
        var ml=$(".person-code-one").outerWidth();
        $(".person-code-one").css({marginLeft:"-"+ml/2+"px"});
        $(".person-code-one").slideDown();
        $(".person-code-close-one,.cover-one").on("click",function(){
            $('.cover-one,.person-code-one').hide();
        });
    }
    $(".show-code").each(function(index,dom){
        $(dom).on('click',function(){
            showCode(index);
        })
    })

})(jQuery,window,document);


//$$.formGroupList.find('li').each(function(index,dom){
//    var $dom=$(dom);
//    var num="**",price="**",square,floor,product_type=[];
//    $dom.on('click',function(){
//        var $this=$(this);
//        //$$.formGroupList.find('li').removeClass('cate-type-active');
//        $this.toggleClass('cate-type-active');
//        if($this.find('.other-pro-type').length!=0){
//            $this.find('.other-pro-type').on('blur',function(){
//                _data('retail')['produce_type']=$this.find('.other-pro-type').val();
//            });
//            return;
//        }
//        if($this.hasClass('cate-type-active')){
//            var title=$this.find('input-label');
//            if($this.find('.square').hasClass('placeholder')){
//                square='**';
//            }else{
//                square=$this.find('.square').text();
//            }
//            if($this.find('.floor').hasClass('placeholder')){
//                floor="**";
//            }else{
//                floor=$this.find('.floor').text();
//            }
//            $this.find('.num').on('blur',function(){
//                var $i=$(this);
//                num=$i.val()==""?"**":$i.val();
//                _data('retail')['produce_type']=$this.find('.input-label').text()+"(数量:"+num+"个/预算:"+price+"万元/面积:"+square+"m²/层高:"+floor+")".replace(/\s/g, "");
//            });
//            $this.find('.price').on('blur',function(){
//                var $i=$(this);
//                price=$i.val()==""?"**":$i.val();
//                _data('retail')['produce_type']=$this.find('.input-label').text()+"(数量:"+num+"个/预算:"+price+"万元/面积:"+square+"m²/层高:"+floor+")".replace(/\s/g, "");
//            });
//            $$.inputDrop.each(function(index,dom){
//                var $dom=$(dom);
//                $dom.find("li").on('click',function(){
//                    var text=$(this).text();
//                    $dom.find('span:first').text(text).removeClass('placeholder');
//                    if($(this).find('square').length>0){
//                        square=$this.find('.square').text();
//                    }else{
//                        floor=$this.find('.floor').text();
//                    }
//                    _data('retail')['produce_type']=$this.find('.input-label').text()+"(数量:"+num+"个/预算:"+price+"万元/面积:"+square+"m²/层高:"+floor+")".replace(/\s/g, "");
//
//                });
//            })
//        }
//        _data('retail')['produce_type']=$this.find('.input-label').text()+"(数量:"+num+"个/预算:"+price+"万元/面积:"+square+"m²/层高:"+floor+")".replace(/\s/g, "");
//    });
//});