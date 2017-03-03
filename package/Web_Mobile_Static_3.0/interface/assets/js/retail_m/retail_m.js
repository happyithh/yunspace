/**
 * Created by pzl on 16/5/25.
 */
/*
* @$ jqeury对象
* @w window对象
* @d document对象
* */
(function($,w,d){
    var $$={
            citySelect:$("#city_select"),
            needArea:$("#need-area"),
            proType:$("#pro-type"),
            address:$("#address"),
            busGuest:$("#bus-guest"),
            company:$("#company"),
            username:$("#username"),
            phone:$("#phone"),
            guest:$("#guest"),
            needType:$("#need-type"),
            timeDuring:$("#time-during"),
            otherDemand:$("#other-demand"),
            submitStepOne:$(".submit-step-one"),
            submitStepTwo:$(".submit-step-two"),
            stepOneError:$(".step1-error"),
            stepOne:$(".step1"),
            stepTwo:$(".step2"),
            stepThree:$(".step3"),
            partThree:$(".part3"),
            imgChange:$("#img-change"),
            stepList:$(".step-list"),
            soJoin:$(".so-join"),
            stepBn:$(".step-bn"),
            retailImg:$(".retail_img"),
            toTop:$(".to-top"),
            topBn:$(".top-bn"),
            scrollOne:$("#scroll-one"),
            scrollTwo:$("#scroll-two"),
            scrollThree:$("#scroll-three"),
            stepDes:$(".step-des")
            };
    var f={
            partThreeOT:"",
            stepListOT:$$.stepList.offset().top,
            ww:$(w).width(),
            wh:$(w).height(),
            cTouchH:0,
            /*
            * 第一步对象
            * */
            keys:[
                {key:'guest',msg:'商业客流不能为空',pass:true},
                {key:'address',msg:'落位区域至少选一个',pass:true},
                {key:'cate',msg:'场地类型至少选一个',pass:true},
                {key:'area',msg:'所需区域至少选一个',pass:true},
                {key:'city',msg:'城市选择至少选一个',pass:true}
            ],
            /*
            * 第二步验证
            * */
            requiredData:[
                {key:'phone',msg:'手机号码格式不正确',pass:true},
                {key:'username',msg:'你的称呼不能为空',pass:true},
                {key:'company',msg:'公司名称不能为空',pass:true}
            ],
            /*
            * 多选对象
            * */
            moreObj:[
                {$:$$.citySelect,key:'city',parent:'.select_model'},
                {$:$$.needArea,key:'area',parent:'.select_model'},
                {$:$$.proType,key:'cate',parent:'.select_model'},
                {$:$$.address,key:'address',parent:'.select_model'},
                {$:$$.otherDemand,key:'other_demand',parent:'li'}
            ],
            /*
            * 单选对象
            * */
            onlyObj:[
                {$:$$.busGuest,key:'guest',parent:'.select_model'},
                {$:$$.guest,key:'guest_type',parent:'li'},
                {$:$$.timeDuring,key:'calender',parent:'li'}
            ],
            /*
            * text对象
            * */
            textObj:[
                {$:$$.company,key:'company'},
                {$:$$.username,key:'username'},
                {$:$$.phone,key:'phone'},
                {$:$$.needType,key:'produce_type'}
            ],
            //初始化
            doAll:function(){
                $$.topBn.height(f.wh);
                $$.stepDes.height(f.wh);
                $$.topBn.width(f.ww);
                $$.stepDes.width(f.ww);
                $('.swiper-slide').height(f.wh);
                $$.stepOne.fadeIn();
                $$.retailImg.find('.list').eq(0).fadeIn();
                $(w).scrollTop(0);
                f.handleMoreSelect()
                    .handleOnlySelect()
                    .getInfo(f.textObj)
                    .submit([$$.submitStepOne,$$.submitStepTwo])
                    .changeImg($$.imgChange)
                    //.animateStep($(w))
                    //.toForm($$.soJoin)
                    .toTop($(window),$$.toTop)
                    //.doScroll();
            },
            //返回顶部
            toTop:function(o,top){
                var show=false;
                var ws=o.scrollTop();
                o.on("scroll",function(){
                    ws=o.scrollTop();
                    if(ws> f.wh){
                        if(show==true)return;
                        $$.toTop.addClass('to-top-active');
                        show=true;
                    }else{
                        if(show==false)return;
                        $$.toTop.removeClass('to-top-active');
                        show=false;
                    }
                });
                top.on('click',function(){
                    var winOffH=o.scrollTop();
                    var t=setInterval(function(){
                        var st=o.scrollTop();
                        if(st<=0){
                            clearInterval(t);
                        }
                        winOffH-=30;
                        o.scrollTop(winOffH);
                    },1);
                });
                return f;
            },
            //处理多选
            handleMoreSelect:function(){
                f.moreObj.forEach(function(o,k){
                    f.moreSelect(o.$, o.key, o.parent);
                });
                return f;
            },
            //处理单选
            handleOnlySelect:function(){
                f.onlyObj.forEach(function(o,k){
                    f.onlySelect(o.$, o.key, o.parent);
                });
                return f;
            },
            /*
            * 多选事件
            * */
            moreSelect:function (o,key,parent){
                o.on('change',function(){
                    var $this=$(this);
                    var v=o.val();
                    var city,htm="",cityArr=[];
                    if(v==null||v.indexOf(",")==-1){
                        v=v+",";
                    }
                    //city=v.split(",");
                    //for(var k in city){
                    //    if(city[k]!=(""||null)){
                    //        htm+="<li>"+city[k]+"</li>"
                    //    }
                    //}
                    $this.find('option:selected').each(function(k,d){
                        if($(d).text()!='可多选'){
                            cityArr.push($(d).val());
                        }
                    });
                    if(cityArr[0]==""){
                        cityArr=cityArr.slice(1);
                    }
                    for(var k in cityArr){
                        if(cityArr[k]!=(""||null)){
                            htm+="<li>"+cityArr[k]+"</li>"
                        }
                    }
                    if( $this.parents(parent).find('.show_selected > li').length>0){
                        $this.parents(parent).find('.show_selected > li').remove();
                    }
                    if(htm.indexOf('null')>-1||v=='null,'){
                        $this.parents(parent).find('.show_selected > li').remove().addClass('none');
                        $this.parents(parent).find('.show_selected').addClass('none');
                        $(this).parents(parent).find("span").removeClass('active');
                        _data('retail')[key]="";
                        return;
                    }
                    //_data('retail')[key]= v.substr(0,v.length-1);
                    _data('retail')[key]= cityArr.join(",");
                    //_data('retail')[key]=_data('retail')[key].substr(0,_data('retail')[key].length-1);
                    $this.parents(parent).find('.show_selected').append(htm).removeClass('none');
                    $this.parents(parent).find('span').addClass('active');
                });
            },
            /*
            * 单选事件
            * */
            onlySelect:function(o,key,parent){
                o.on('change',function(){
                    var $this=$(this);
                    var v=$this.val();
                    _data('retail')[key]=v;
                    if( $this.parents(parent).find('.show_selected > li').length>0){
                        $this.parents(parent).find('.show_selected > li').remove();
                    }
                    $this.parents(parent).find('.show_selected').append("<li>"+v+"</li>").removeClass('none');
                    $this.parents(parent).find('span').addClass("active");
                })
            },
            /*
            * 下一步/提交
            * */
            stepSubmit:function(o,data,currentDom,nextDom){
                var errArr=[];
                var  secOneH=$(".main").find('.m-page').eq(0).outerHeight();
                var  secTwoH=$(".main").find('.m-page').eq(1).outerHeight();
                data.forEach(function(o,k){
                    o.pass=f.validate(o);
                });
                data.forEach(function(o,k){
                    errArr.push(o.pass);
                });
                if(errArr.indexOf(false)==-1){
                    if(o.hasClass("submit-step-two")){
                        f.submitOk(currentDom,nextDom);
                    }else{
                        currentDom.hide();
                        nextDom.fadeIn(300);
                        $(window).scrollTop(secOneH+secTwoH);
                    }
                }
            },
            /*
            * 提交成功，请求后台
            * */
            submitOk:function(currentDom,nextDom){
                if(_data('retail').city==""){
                    alert("城市选择不能为空!!");
                    return;
                }
                if(_data('retail').area==""){
                    alert("所选区域不能为空!!");
                    return;
                }
                if(_data('retail').cate==""){
                    alert("场地类型不能为空!!");
                    return;
                }
                if(_data('retail').address==""){
                    alert("落位区域不能为空!!");
                    return;
                }
                if(_data('retail').guest==""){
                    alert("场地客流不能为空!!");
                    return;
                }
                if(_data('retail').company==""){
                    alert("公司名称不能为空!!");
                    return;
                }
                if(_data('retail').username==""){
                    alert("您的姓名不能为空!!");
                    return;
                }
                if(_data('retail').phone==""){
                    alert("手机号码不能为空!!");
                    return;
                }
                var  secOneH=$(".main").find('.m-page').eq(0).outerHeight();
                var  secTwoH=$(".main").find('.m-page').eq(1).outerHeight();
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
                    data[11] = _data('retail').other_demand;
                    data[12] = 'mobile';
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
                    key[8] = '目标客群',
                    key[9] = '产品类型',
                    key[10] = '档期周期',
                    key[11] = '其他要求',
                    key[12] = '来源';
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
                            currentDom.hide();
                            nextDom.fadeIn(300);
                            $(window).scrollTop(secOneH+secTwoH);
                        } else {
                           alert('数据提交失败，请重新提交！！')
                        }
                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        console.log(XMLHttpRequest);
                        console.log(textStatus);
                        console.log(errorThrown);
                    }
                });
            },
            /*
            * 验证
            * */
            validate:function(obj){
                if(obj.key=='phone'){
                    var exp=/^(0|86|17951)?(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$/;
                    if(!exp.test(_data('retail').phone.replace(/\s/g , ""))){
                        if( !$$.stepOneError.text(obj.msg).hasClass('active')){
                            $$.stepOneError.text(obj.msg).addClass('active');
                            setTimeout(function(){
                                $$.stepOneError.removeClass('active');
                            },3000);
                        }
                        return false;
                    }
                }
                if(_data('retail')[obj.key].replace(/\s/g, "")==""){
                    //obj.pass=false;
                    if( !$$.stepOneError.text(obj.msg).hasClass('active')){
                        $$.stepOneError.text(obj.msg).addClass('active');
                        setTimeout(function(){
                            $$.stepOneError.removeClass('active');
                        },3000);
                    }
                    return false;
                }
                //obj.pass=true;
                return true;
            },
            /*
             * 赋值company,username,phone数据
             * */
            getInfo:function(){
                arguments[0].forEach(function(o,k){
                    o.$.on('change',function(){
                        _data('retail')[o.key]=$(this).val();
                    })
                });
                return f;
            },
            /*
            * 点击提交
            * */
            submit:function(){
                arguments[0].forEach(function(o,k){
                    o.on('touchend',function(){
                        var $this=$(this);
                        switch(k){
                            case 0:
                                f.stepSubmit($this, f.keys,$$.stepOne,$$.stepTwo);
                                break;
                            case 1:
                                f.stepSubmit($this, f.requiredData,$$.stepTwo,$$.stepThree);
                                break;
                        }
                    });
                });
                return f;
            },
            /*
            切换图片
            * */
            changeImg:function(o){
                o.find('a').each(function(k,d){
                    var $d=$(d);
                    $d.on('touchend',function(){
                        o.find('a').removeClass('tab-active');
                        $(this).addClass('tab-active');
                        $(this).parents('.retail_img').find('.list').hide();
                        $(this).parents('.retail_img').find('.list').eq(k).fadeIn(300);
                    });
                });
                return f;
            },
            //步骤动画
            //animateStep:function(o){
            //    var ani=false;
            //    o.on('scroll',function(){
            //        var ws=$(w).scrollTop(),ww=$(w).height();
            //        if(ws+ww> f.stepListOT){
            //            if(ani==true)return;
            //            //判断是否为微信
            //            $$.stepList.find("li").each(function(k,d){
            //                var $d=$(d);
            //                $d.addClass('active').find('span').addClass('span-active');
            //            });
            //            $$.stepBn.addClass('active');
            //            ani=true;
            //        }
            //    });
            //    return f;
            //},
            //定位表单
            //toForm:function(o){
            //    o.on('click',function(){
            //        f.doScroll();
            //    });
            //    var nStartY,nStartX,nChangY,nChangX;
            //    if(!$$.scrollOne.hasClass("scroll-hidden")||!$$.scrollTwo.hasClass("scroll-hidden")){
            //        document.addEventListener('touchstart', function (e) {
            //            nStartY = e.targetTouches[0].pageY;
            //            nStartX = e.targetTouches[0].pageX;
            //        });
            //        document.addEventListener('touchend', function (e) {
            //            nChangY = e.changedTouches[0].pageY;
            //            nChangX = e.changedTouches[0].pageX;
            //            setTimeout(function(){
            //                if(window.scrollTop==0){
            //                    if(nStartY>nChangY){
            //                        f.doScroll();
            //                    }else{
            //
            //                    }
            //                }
            //
            //
            //            },200);
            //        });
            //    }
            //    return f;
            //},
            //doScroll:function(){
                //var winOffH=$(w).scrollTop();
                //var t=setInterval(function(){
                //    var st=$(w).scrollTop();
                //    if(st>= f.partThreeOT){
                //        clearInterval(t);
                //    }
                //    winOffH+=10;
                //    $(w).scrollTop(winOffH);
                //},1);
                //$$.scrollOne.addClass('scroll-hidden');
                //if( $$.scrollOne.hasClass('none')&&$$.scrollOne.hasClass('scroll-hidden')){
                //    //$$.scrollTwo.addClass('scroll-hidden');
                //    //$$.scrollThree.removeClass('none');
                //    setTimeout(function(){
                //        //$$.scrollTwo.addClass('none');
                //    },600)
                //}else{
                //    $$.scrollTwo.removeClass('none');
                //    setTimeout(function(){
                //        //$$.stepBn.addClass('active');
                //        //$$.scrollOne.addClass('none');
                //        $$.stepList.find("li").each(function(k,d){
                //            var $d=$(d);
                //            //$d.addClass('active').find('span').addClass('span-active');
                //        });
                //    },600);
                //}
                //var mySwiper = new Swiper('.swiper-container', {
                //    autoplay: false,
                //    direction : 'vertical',
                //    onSlideChangeEnd: function(swiper){
                //        if(swiper.activeIndex==1){
                //            $$.stepBn.addClass('l');
                //            setTimeout(function(){
                //                $$.stepBn.addClass('active');
                //            },1);
                //            $$.stepList.find("li").each(function(k,d){
                //                var $d=$(d);
                //                $d.addClass('l');
                //                setTimeout(function(){
                //                    $d.addClass('active').find('span').addClass('span-active');
                //                },1);
                //            });
                //        }else{
                //            $$.stepBn.removeClass('l active')
                //            $$.stepList.find("li").each(function(k,d){
                //                var $d=$(d);
                //                $d.removeClass('l active').find('span').removeClass('span-active');
                //            });
                //        }
                //    }
                //});
                //$$.soJoin.on('click',function(){
                //    mySwiper.slideTo(1, 300, true);
                //});
            //}
        };
    $(function(){
        f.doAll();
    });
    //f.moreSelect($$.citySelect,'city','.select_model');
    //f.moreSelect($$.needArea,'area','.select_model');
    //f.moreSelect($$.proType,'cate','.select_model');
    //f.moreSelect($$.address,'address','.select_model');
    //f.moreSelect($$.otherDemand,'other_demand','li');
})(jQuery,window,document);

//f.onlySelect($$.busGuest,'guest','.select_model');
//f.onlySelect($$.guest,'guest_type','li');
//f.onlySelect($$.timeDuring,'calender','li');