/**
 * Created by bll on 15/9/4.
 */
/**
 * Created by bll on 15/8/3.
 */
yun("global/jquery-1.9.1.min.js");
var plugin={
    config:"",
    validate:false,
    empty:[],
    times:0,
    formValidate:function(ele,args,callback){
        var self=this;
        self.config=args;
        var tip=$(ele).data("tip");
        if($(tip).length>0){
            $(tip).hide();
        }
        var l=$(ele).val().length;
        if(self.config.length!=undefined&&l<self.config.length)return false;
        var v=$(ele).val();
        if(self.config.style!=undefined){
            var style=self.config.style.split(",");
        }
        var sty={};
        var validate=$(ele).data("validate");
        if(validate!=true){
            //console.log("验证表单需添加必须验证参数（data-validate='true'）");
            return false;
        }
        if(self.config.style!=undefined) {
            for (var k in style) {
                style[k] = style[k].split(":");
                sty[style[k][0]] = style[k][1];
            }
        }
        //0.3秒后验证
        var rr="ion-minus-circled icon-minus-sign fa fa-minus-square";
        var kk="ion-checkmark icon-ok";
        var set=setTimeout(function() {
            if(self.matchExp(self.config.exp, v)){
                $(ele).removeClass("error");
                $(ele).nextAll("span").remove();
                if(self.config.ok==undefined){
                    var info="";
                }else{
                    if(self.config.ok==""){
                        var info="<span></span>";
                    }else{
                        var info="<span>"+self.config.ok+"</span>";
                    }
                }
                $(ele).after(info);
                //$(ele).next("span").css(sty).prepend("<i></i>");
                //$(ele).next("span").find("i").removeClass("ion-minus-circled").addClass("ion-checkmark");
                $(ele).next("span").css(sty);

                $(ele).next("span").removeClass(rr).addClass(kk);
            }else{
                if(self.config.error==undefined){
                    //console.log("无错误提示！！");
                    return false;
                }
                $(ele).removeClass("error").addClass("error");
                $(ele).nextAll("span").remove();
                var info="<span>"+self.config.error+"</span>";
                $(ele).after(info);
                //$(ele).next("span").css(sty).prepend("<i></i>");
                //$(ele).next("span").find("i").removeClass("ion-checkmark").addClass("ion-minus-circled");
                $(ele).next("span").css(sty);
                $(ele).next("span").removeClass(kk).addClass(rr);
            }
        },300);
    },
    matchExp:function(pattern,string){
        var patt=new RegExp(pattern);
        if(string==null){
            return false;
        }
        if(patt.test(string)){
            return true;
        }else{
            return false;
        }
    },
    typeValidate:function(ele,args,callback){
        $(ele).css({
            background:"#fff"
        })
        var self=this;
        switch (args.type){
            case "email":
                //console.log(args.exp);
                args.exp=eval(args.exp)|| /^(\w-*\.*)+@(\w-?)+(\.\w{2,})+$/;
                self.formValidate(ele,args,callback);
                break;
            case "phone":
                var l=$(ele).val().length;
                if(l<11){return false;}
                args.exp=eval(args.exp)|| /^(0|86|17951)?(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$/ ;
                self.formValidate(ele,args,callback);
                break;
            case "repass":
                var password=$(args.password).val();
                var repass=$(ele).val();
                if(password!=repass){
                    $(ele).addClass("error");
                    $(args.tip).show();
                }else{
                    $(ele).removeClass("error");
                    $(args.tip).hide();
                }
                break;
            case "code":
                var auth_code=$(ele).val();
                var phone=$(args.phone).val();
                var l=$(ele).val().length;
                if(!phone&&l<6)return false;
                YunSpace.api('common/check/auth/code.jsonp', {
                    phone: phone,
                    auth_code:auth_code
                }, function (data) {
                    if(data['status']==1){
                        $(ele).removeClass("error");
                        $(args.tip).addClass("none");
                        if($(".fast-login").length>0){
                            $(".fast-login").attr("disabled",false);
                            $(".fast-login").css({
                                background:"#17a8d5"
                            });
                        }
                        if($(".fast-login1").length>0){
                            $(".fast-login1").attr("disabled",false);
                            $(".fast-login1").css({
                                background:"#3bd5bb"
                            });
                        }
                        if($(".fast-login2").length>0){
                            $(".fast-login2").attr("disabled",false);
                            $(".fast-login2").css({
                                background:"#3bd5bb"
                            });
                        }
                        if($(".login_input_group .login").length>0){
                            $(".login_input_group .login").attr("disabled",false);
                            $(".login_input_group .login").css({
                                background:"#0090ff"
                            });
                        }
                        if($("#comment-login").length>0){
                            $("#comment-login").attr("disabled",false).css({
                                background: "rgba(122,122,250,0.8)"
                            });
                        }
                        /*if(l>5){
                            $(".d-s-error").css({
                                color:"#00ff00"
                            });
                            $(".d-s-error").html("验证码正确");;

                        }*/
                    }else{
                        $(ele).addClass("error");
                        $(args.tip).removeClass("none");
                        if($(".fast-login").length>0){
                            $(".fast-login").attr("disabled",true);
                            $(".fast-login").css({
                                background:"#b5bfd2"
                            });
                        }
                        if($(".fast-login1").length>0){
                            $(".fast-login1").attr("disabled",true);
                            $(".fast-login1").css({
                                background:"#ddd"
                            });
                        }
                        if($(".fast-login2").length>0){
                            $(".fast-login2").attr("disabled",true);
                            $(".fast-login2").css({
                                background:"#e0e0e0"
                            });
                        }
                        if($(".login_input_group .login").length>0){
                            $(".login_input_group .login").attr("disabled",true);
                            $(".login_input_group .login").css({
                                background:"#ddd"
                            });
                        }
                        if($("#comment-login").length>0){
                            $("#comment-login").attr("disabled",true).css({
                                background:"#c1c1fb"
                            });
                        }
                       /* if(l>5){
                            $(".d-s-error").html("验证码错误");
                            $(".show-error").text(data.msg);
                            $(".show-error").fadeIn(1000);
                            $(".show-error").fadeOut(500);
                        }*/



                    }
                });
                break;
            default:
                if(args.exp!=undefined&&args.exp!=''){
                    args.exp=eval(args.exp);
                }
                self.formValidate(ele,args,callback);
        }
    },
    formSubmit:function(element,args,callback){
        this.times++;
        if(this.times>1){this.times=0;return false;}
        var self=this;
        var vk=0;
        var sum=0; //验证必须验证的表单是否为空
        var error_place=args.error_place||false;
        var index=$(element).data("id")||0;
        var form= $("form[data-validate='true']:eq("+index+")");
        $(element).submit(function(){
            //验证需要验证的input是否为空
            form.find("input[data-validate='true']").each(function(index,dom){
                self.empty.length=0;
                self.validate=$(dom).data("validate");
                //if(self.validate==undefined&&self.validate!=true){ //所验证表单是否添加data-validate
                //    return false;
                //}
                var value=$(dom).val();
                if(self.validate==true&&value==''){
                    self.empty[vk]=++sum;
                    sum=0
                }else{
                    self.empty[vk]=0;
                }
                vk++;
            });
            var arr=[];
            for(var k in self.empty){
                arr.push(self.empty[k]);
                //console.log(arr);
            }
            arr.pop();
            var l= form.find("input[data-validate='true']").length;
            //console.log(l);
            if($("texearea[data-validate='true']").length>0){
                l+=1;
            }
            var sError;
            //console.log($("input[data-validate='true']").length);
            //console.log(eval(arr.slice(-l).join('+')));
            if(eval(arr.slice(-l).join('+'))!=0){
                if(form.find("texearea[data-validate='true']").length>0){
                    var va=$("texearea[data-validate='true']").val();
                    if(va==""){
                        $(".error-info").html("必填项不能为空!!");
                    }
                }
                if($(".error-info").length>0){
                    $(".error-info").html("必填项不能为空!!");
                }
                form.find("input[data-validate='true']").each(function(index,dom){
                    var fv=$(dom).val();
                    var error=$(dom).data("error");
                    if(fv==""){
                        $(dom).trigger("focus");
                        sError=error;
                        if(error_place){
                            var errP=$(dom).data("tip");
                            if($(errP).length>0){
                                $(errP).show();
                            }else{
                                console.log(errP+"不存在！！");
                            }
                        }else{
                            if($(args.error).length>0&&args.error!=undefined){
                                $(args.error).text(sError);
                            }else{
                                console.log(args.error+"不存在！！");
                            }
                        }
                        return false;
                    }
                })
                return false;
            }
            //验证长度
            form.find("input[data-validate='true']").each(function(index,dom){
                var fv=$(dom).val();
                var error=$(dom).data("error");
                //验证手机长度
                if($(dom).data("length")!=undefined){
                    if(fv.length<($(dom).data("length")||1)){
                        $(dom).trigger("focus");
                        $(dom).css({
                            background:"#ffebeb"
                        });
                        sError=error;
                        if(error_place){
                            var errP=$(dom).data("tip");
                            $(errP).show();
                        }else{
                            if($(args.error).length>0&&args.error!=undefined){
                                $(args.error).text(sError);
                            }
                        }
                        return false;
                    }
                }
            });

            //有错误阻止提交
            if(form.find("input[data-validate='true']").hasClass("error")){
                return false;
            }
            if($(".error1").length>0){
                return false;
            }
        });
    },
    ajaxSubmit:function(element,args,callback) {
        var self=this;
        var vk=0;
        var sum=0; //验证必须验证的表单是否为空
        var index=$(element).data("id")||0;
        var form=$(args.form+"[data-validate='true']:eq("+index+")");
        var items=[];
        var itemsJson={};
        var href=window.location.href;
        $(element).removeClass("ok");
        //验证需要验证的input是否为空
        form.find("input[data-validate='true']").each(function(index,dom){
            self.empty.length=0;
            self.validate=$(dom).data("validate");
            var value=$(dom).val();
            if(self.validate==true&&value==''){
                self.empty[vk]=++sum;
                sum=0
            }else{
                self.empty[vk]=0;
            }
            vk++;
        });
        var arr=[];
        for(var k in self.empty){
            arr.push(self.empty[k]);
            //console.log(arr);
        }
        arr.pop();
        var l= form.find("input[data-validate='true']").length;
        //console.log(l);
        if(form.find("texearea[data-validate='true']").length>0){
            l+=1;
        }
        var sError;
        //console.log($("input[data-validate='true']").length);
        //console.log(eval(arr.slice(-l).join('+')));
        //判断是否有空值
        if(eval(arr.slice(-l).join('+'))!=0){
            if(form.find("texearea[data-validate='true']").length>0){
                var va=form.find("texearea[data-validate='true']").val();
                if(va==""){
                    $(".error-info").html("必填项不能为空!!");
                }
            }
            if($(".error-info").length>0){
                $(".error-info").html("必填项不能为空!!");
            }
            form.find("input[data-validate='true']").each(function(index,dom){
                if(href.indexOf("/m/")>=0){
                    //手机验证提示（为空值时）
                    self.errorCallTwo(form,args);
                }else{
                    var fv=$(dom).val();
                    var error=$(dom).data("error");
                    if(fv==""){
                        $(dom).trigger("focus");
                        $(dom).css({
                            background:"#ffebeb"
                        });
                        sError=error;
                        var errInfo="<span>"+sError+"</span>";
                        //报错样式提示
                        self.errorOne(dom);
                        return false;
                    }
                    $(args.error).text(sError);
                }
            });
            return false;
        }
        //验证长度
        var lengthBool=[];
        form.find("input[data-validate='true']").each(function(index,dom){
                if(href.indexOf("/m/")>=0){
                    //手机验证提示（为空值时）
                    lengthBool[index]=self.errorLength(dom);
                }else{
                    var fv=$(dom).val();
                    var error=$(dom).data("error");
                    //验证手机长度
                    if($(dom).data("length")!=undefined){
                        //console.log($(dom).data("length"));
                        if(fv.length<$(dom).data("length")){
                            $(dom).trigger("focus");
                            sError=error;
                            $(args.error).text(sError);
                            $(dom).css({
                                background:"#ffebeb"
                            })
                            $(dom).addClass("error");
                            self.errorOne(dom);
                            return false;
                        }
                    }
                }
        });
        if(lengthBool.indexOf(false)>=0){
            return false;
        }

        if($('.js-y-code').hasClass("error")){
            $(".d-s-error").html("验证码错误");
            $(".show-error").text("验证码错误");
            $(".show-error").fadeIn(1000);
            $(".show-error").fadeOut(500);
            $(".d-s-error").fadeIn(1000);
            $(".d-s-error").fadeOut(500);
            $(".error-all > span").text('验证码错误');
            $(".error-all").removeClass("none").addClass("error-all-active");
            setTimeout(function(){
                $(".error-all").addClass("none").removeClass("error-all-active");
            },3000);
            return false;
        }


        //有错误阻止提交
        if(form.find("input[data-validate='true']").hasClass("error")){
            return false;
        }
        //将获取到的input值转换为json对象
        form.find("input").each(function(index,dom){
            var value=$(dom).val();
            var name=$(dom).attr("name");
            items[name]=value;
        });
        for(var i in items){
            itemsJson[i]=items[i];
        }
        //console.log(itemsJson);
        $(element).addClass("ok");
        //ajax请求
        if(args.url!=undefined&&args.ajax!=undefined){
            //console.log(args.url,args.ajax);
            //    ajax,成功之后
            switch(args.ajax){
                case "demand":
                    self.demandSuccess(args.url);
                    break;
                case "demand_next":
                    self.demandFull(args.url);
                    break;
                case "demand_new":
                    self.demandNew(args.url);
                    break;
                case "year_submit":
                    self.yearSuccess(args.url);
                    break;
                case "site_login":
                    self.siteLogin(args.url);
                    break;
                case "new_events":
                    //查询档期和价格
                    self.demandNewEvents(args.url);
                    break;
                case "ip_demand_new":
                    self.ipDemandNew(args.url);
                    break;
                case 'ip_join':
                    self.ipJoin();
                    break;
            }

        }
    },
    demandSuccess:function(url){
        //请求成功之后
        var clicked=true;
        var contact_name=$(".ajax-form input[name='username']").val();
        var contact_phone=$(".ajax-form input[name='phone']").val();
        var content=$(".ajax-form .person-input").val();
        var demand_style=$(".ajax-form .cate-input").val();
        var demand_city = $(".ajax-form input[name='city']").val();
        var demand_other_need = '';
        var  demand_other = 0;
        if($("#demand_other_4").is(":checked")){
            demand_other = 1;
        }
        //避免网络问题，处理多次提交
        if(clicked==true){
            $(".ajax-form .demand-submit-btn").attr("disabled",true).css({
                background:"#06E1CE"
            });
            clicked=false;
        }else{
            $(".ajax-form .demand-submit-btn").attr("disabled",false).css({
                background:"#fe6a3a"
            });
            return;
        }
        YunSpace.api(url, {
            demand_city: demand_city,
            people: content,
            username: contact_name,
            phone: contact_phone,
            content: demand_style+'--'+content+demand_other_need,
            demand_style:demand_style,
            demand_other:demand_other,
            action: 'events'
        }, function (data) {
            setTimeout(function(){
                $(".demand-submit-btn").attr("disabled",false).css({
                    background:"#fe6a3a"
                });
                clicked=true;
            },2000);
            $(".demand-ok").attr("disabled",false);
            //alert(data.msg);
            //console.log(data);
            if (data.status == 1) {
                var iframe=' <iframe src="" style="border: 0px; width:100%;height:100%" class="iframe" id="home-frame" name="home-frame">'+
                    '</iframe>';
                if($(".show2").find(".iframe").length<=0){
                    $(".show2").append(iframe);
                }
                $(".demand-one").animate({
                    top:"-130%"
                },400,function(){
                    $(".demand-one").hide();
                });
                setTimeout(function(){
                    $(".demand-two").show();

                    var wH = $(window).height();
                    if (wH < 760) {
                        var sT = $(window).scrollTop();
                        $('.demand-body').css({
                            'position': 'absolute'
                        });
                        $(".demand-two").animate({
                            top: sT + wH * 0.1 + 'px'
                        }, 400)
                    } else {
                        $('.demand-body').css({
                            'position': 'fixed'
                        });
                        $(".demand-two").animate({
                            top: "10%"
                        }, 400)
                    }
                    $(".demand-two .ajax-form").css({
                        height:"525px"
                    })
                },200);
                $(".iframe").attr("src","/home_inc/form?demand_id="+data.data);
                $(".bottom-submit").eq(1).removeClass("hide");
                $(".d-s-error").html("");
                $(".submit-text").html('请完善您的活动信息，云·SPACE场地报价系统将在 <span style="color:#59ebeb;font-size:13px;">30分钟内</span>为您提供多份精准场地报价!!').css({
                    textAlign:"left"
                });
                $("input").css({
                    background:"#fff"
                });
                $(".show2").css({
                    height:"450px"
                });
            }else{
                alert(data.msg);
            }
        });
    },
    demandFull:function(url){
        var clicked=true;
        var range= $(window.frames["home-frame"].document).find(".range-input").val();
        var actDate_start= $(window.frames["home-frame"].document).find(".act_date_start").val();
        var actDate_end= $(window.frames["home-frame"].document).find(".act_date_end").val();
        var  demand_id = $(window.frames["home-frame"].document).find(".demand_id").val();
        //console.log(range,actDate,demand_id);
        //return;
        //避免网络问题，处理多次提交
        if(clicked==true){
            $(".demand-ok").attr("disabled",true).css({
                background:"#06E1CE"
            });
            clicked=false;
        }else{
            $(".demand-ok").attr("disabled",false).css({
                background:"#fe6a3a"
            });
            return;
        }
        YunSpace.api(url, {
            demand_id:demand_id,
            price_range: range,
            start_time: actDate_start,
            end_time: actDate_end,
            action: 'events_update'
        }, function (data) {
            //console.log(data);
            setTimeout(function(){
                $(".demand-ok").attr("disabled",false).css({
                    background:"#fe6a3a"
                });
                clicked=true;
            },2000);
            if (data.status == 1) {
                $(".ajax-form").first().css({
                    height:"535px"
                });
                $(".ajax-form").eq(1).css({
                    height:"250px"
                });
                $(".iframe").attr("src","/home_inc/question?demand_id="+data.data.demand_id);
                $(".submit-text").text("云·SPACE正在为您查找匹配，30分钟后为您提供报价！！").css({
                    textAlign:"center"
                });
                $(".bottom-submit").eq(1).addClass("hide");
                setTimeout(function(){
                    $(parent.document).find(".demand-two").animate({
                        top:"-130%"
                    },400);
                    $(parent.document).find(".cover-body").fadeOut(200);
                },3000)
            }else{
                alert(data.msg);
            }
        });
        //ajax请求
        //if(1){
        //    //$(".show-demand").html("");
        //    $(".ajax-form1").css({
        //        height:"250px"
        //    })
        //    $(".iframe").attr("src","home_inc/question");
        //    $(".submit-text").text("云·SPACE正在为您查找匹配，30分钟后为您提供报价！！").css({
        //        textAlign:"center"
        //    });
        //    $(".bottom-submit").eq(1).addClass("hide");
        //
        //}
    },
    errorCallTwo:function(o,args){
        var href=window.location.href;
        if(href.indexOf("/m/")){
            var sError;
            o.find("input[data-validate='true']").each(function(index,dom){
                var fv=$(dom).val();
                var error=$(dom).data("error");
                if(fv==""){
                    $("input").css({  background:"#fff" })
                    $(dom).trigger("focus");
                    if($(".enquiry-con-input").length>0){
                        $(".enquiry-con-input").css({background:"#fff"});
                        $(dom).parents(".enquiry-con-input").css({
                            background:"rgb(255, 235, 235)"
                        });
                    }
                    if($(".error-all").length>0){
                        $(".error-all > span").text(error);
                        $(".error-all").removeClass("none").addClass("error-all-active");
                        setTimeout(function(){
                            $(".error-all").addClass("none").removeClass("error-all-active");
                        },3000);
                    }
                    if($(".site_error").length>0){
                        $(".site_error").text(error);
                        $(".site_error").animate({
                            top:"50px"
                        },500);
                        setTimeout(function(){
                            $(".site_error").animate({
                                top:"0px"
                            },500);
                        },2000);
                    }
                    if($(".comment-error").length>0){
                        $(".comment-error").text(error);
                        $(".comment-error").animate({
                            top:"5%"
                        },500);
                        setTimeout(function(){
                            $(".comment-error").animate({
                                top:"-50px"
                            },500);
                        },2000);
                    }
                    $(dom).css({
                        background:"#ffebeb"
                    });
                    return false;
                }
            });
        }

    },
    errorLength:function(dom){
        var href=window.location.href;
        if(href.indexOf("/m/")){
            var sError,fv=$(dom).val(),error=$(dom).data("error");
            //验证手机长度
            if($(dom).data("length")!=undefined){
                if(fv.length<$(dom).data("length")){
                    if($(".enquiry-con-input").length>0){
                        $(".enquiry-con-input").css({background:"#fff"});
                        $(dom).parents(".enquiry-con-input").css({
                            background:"rgb(255, 235, 235)"
                        });
                    }
                    $("input").css({  background:"#fff" })
                    $(dom).trigger("focus");
                    sError=error;
                    if($(".error-all").length>0){
                        $(".error-all > span").text(sError);
                        $(".error-all").removeClass("none").addClass("error-all-active");
                        setTimeout(function(){
                            $(".error-all").addClass("none").removeClass("error-all-active");
                        },3000);
                    }
                    if($(".site_error").length>0){
                        $(".site_error").text(error);
                        $(".site_error").animate({
                            top:"50px"
                        },500);
                        setTimeout(function(){
                            $(".site_error").animate({
                                top:"0px"
                            },500);
                        },2000);
                    }
                    if($(".comment-error").length>0){
                        $(".comment-error").text(error);
                        $(".comment-error").animate({
                            top:"5%"
                        },500);
                        setTimeout(function(){
                            $(".comment-error").animate({
                                top:"-50px"
                            },500);
                        },2000);
                    }
                    $(dom).css({
                        background:"#ffebeb"
                    });
                    return false;
                }
            }
        }
    },
    demandNew:function(){
        var price=[];
        $(".enquiry-checked").each(function(index,dom){
            if($(dom).val()){
                price.push($.trim($(dom).val()));
            }
        });
        var price_list=price.join(",");
        var username = $(".ajax-form input[name='username']").val();
        var phone = $("input[name='phone']").val();
        var content = $("textarea[name='content']").val();
        var people = $("input[name='people']").val();
        var demand_city = $("input[name='city']").val();
        var demand_date= $("input[name='date_start']").val()+" - "+$("input[name='date_end']").val();
        var demand_style = $("input[name='date_activity']").val();
        var space_name = $(".ajax-form input[name='space_name']").val();
        var item_name = $(".ajax-form input[name='item_name']").val();
        var item_id = $(".ajax-form input[name='item_id']").val();
        var item_price = $(".ajax-form input[name='item_price']").val();
        var other_demand = $(".ajax-form textarea[name='other_demand']").text();
        YunSpace.api('demand/create.jsonp', {
            username : username,
            phone :phone,
            content :content,
            people :people,
            demand_date:demand_date,
            demand_style :demand_style,
            demand_city:demand_city,
            price_list :price_list,
            action: 'spacepedia_price',
            is_mobile:1,
            space_name:space_name,
            item_name:item_name,
            item_id:item_id,
            item_price:item_price,
            other_demand:other_demand
        }, function (data) {
            if (data.status == 1) {
                localStorage.removeItem("ProductList");
                alert(data.msg);
                window.location.href="http://"+window.location.host;
            } else {
                top.alert(data.msg);
            }
        });
    },
    ipDemandNew:function(){
        var username = $(".ajax-form input[name='username']").val();
        var ip_id = $("input[name='ip_id']").val();
        var active_name = $("input[name='active_name']").val();
        var phone = $("input[name='phone']").val();
        var demand_city = $("input[name='city']").val();
        var demand_date= $("input[name='date_start']").val()+" - "+$("input[name='date_end']").val();
        var demand_style = $("input[name='date_activity']").val();
        var other_demand = $(".ajax-form textarea[name='other_demand']").text();
        YunSpace.api('winchance/create/order.jsonp', {
            username : username,
            phone :phone,
            ip_id :ip_id,
            active_name :active_name,
            demand_date:demand_date,
            demand_style :demand_style,
            demand_city:demand_city,
            other_demand:other_demand
        }, function (data) {
            if (data.status == 1) {
                alert(data.msg);
                window.location.href="http://"+window.location.host;
            } else {
                top.alert(data.msg);
            }
        });
    },
    ipJoin:function(){
        var username = $(".ajax-form input[name='username']").val();
        var action = $("input[name='action']").val();
        var phone = $("input[name='phone']").val();
        var demand_style = $("input[name='date_activity']").val();
        //var other_demand = $(".ajax-form textarea[name='other_demand']").text();
        YunSpace.api('winchance/create/order.jsonp', {
            username : username,
            phone :phone,
            action :action,
            demand_style :demand_style
            //other_demand:other_demand
        }, function (data) {
            if (data.status == 1) {
                alert(data.msg);
                window.location.href="http://"+window.location.host;
            } else {
                top.alert(data.msg);
            }
        });
    },
    demandNewEvents:function(){
        var space_id=$("input[name='space_id']").val();
        var space_ids=$("input[name='space_ids']").val();
        if(space_ids == undefined){
            space_ids='';
        }
        var space_names=$("input[name='space_names']").val();
        if(space_names  == undefined){
            space_names='';
        }
        var space_name=$("input[name='space_name']").val();
        var username = $(".ajax-form input[name='username']").val();
        var phone = $("input[name='phone']").val();
        var content = $("textarea[name='content']").val();
        var demand_city = $("input[name='city']").val();
        var start_time= $("input[name='date_start']").val()
        var end_time=$("input[name='date_end']").val();
        var from_type = $("input[name='from_type']").val();
        var price =  $("input[name='price']").val();
        var change_date =  $("input[name='change_date']").val();
        var date_start =  $("input[name='date_start']").val();
        var date_end =  $("input[name='date_end']").val();
        var date_activity =  $("input[name='date_activity']").val();
        YunSpace.api('demand/create.jsonp', {
            username : username,
            phone :phone,
            content :content,
            start_time:start_time,
            end_time:end_time,
            object_id:space_id,
            object_ids:space_ids,
            object_name:space_name,
            object_names:space_names,
            from_type:from_type,
            price:price,
            change_date:change_date,
            date_start:date_start,
            date_end:date_end,
            demand_city:demand_city,
            date_activity:date_activity,
            action: 'new_events',
            object_type: "site",
            is_mobile:1
        }, function (data) {
            if (data.status == 1) {
                alert(data.msg);
                window.location.href="http://"+window.location.host;
            } else {
                top.alert(data.msg);
            }
        });
    },
    errorOne:function(o) {
        if ($(".show-error").length > 0) {
            var err = $(o).data("error");
            $(".show-error").text(err);
            $(".show-error").fadeIn(1000);
            setTimeout(function () {
                $(".show-error").fadeOut(500);
            }, 2000);
        }
    },
    yearSuccess:function(url){
        var btn = $(".year-submit-btn").find("button");
        var ym_id= btn.attr("data-year_id");
        var ym_number= btn.attr("data-ticket_number");
        var ym_title= btn.attr("data-year_title");
        var ym_user= $("input[name='yearmeeting_username']").val();
        var ym_phone= $("input[name='yearmeeting_phone']").val();
        var ym_con= $("textarea[name='content']").val();
        if(ym_con==""){
            this.errorOne(".year-remand");
            return;
        }
        $(".year-submit-btn1").attr("disabled",true).css({ background:"#ddd" });
        YunSpace.api(url, {
            'year_id': ym_id,
            'contact': ym_user,
            'contact_phone': ym_phone,
            'content':ym_con,
            'title': ym_title,
            'ticket_number': ym_number
            //'action' : 'now_consulting'
        }, function (data) {
            if (data.status == 1) {
                $(".show-error").css({
                    width:"500px",
                    marginLeft:"-250px",
                    'box-shadow':"1px 1px 1px #666"
                });
                $(".show-error").text(data.msg);
                $(".show-error").fadeIn(1000);
                setTimeout(function () {
                    $(".show-error").hide();
                    $(".year-submit-btn1").attr("disabled",false).css({ background:"#00c0ff"});
                    $(".show-error").css({
                        background:"#ff0000",
                        width:"300px",
                        marginLeft:"-150px",
                        color:"#fff",
                    });
                    $(".year-submit").find("input,textarea").val("");
                }, 3000);
                $('.year-submit-close').click();
            }else{
                $(".show-error").text(data.msg);
                $(".show-error").fadeIn(1000);
            }
        });
    },
    siteLogin:function(){
        var phone=$(".phone").val();
        var code=$(".short").val();
        //console.log(phone,code);
        YunSpace.api('demand/product/login.json', {
                phone:phone,
                code:code
            },
            function(data){
                //console.log(data);
                if(data.status==1){
                    //alert("登陆成功！！");
                    window.location.href="/m/site_management";
                }else{
                    //alert('网络异常或填写错误，请重新登陆！！');
                    alert(data.msg);
                }
            });
    }

}
