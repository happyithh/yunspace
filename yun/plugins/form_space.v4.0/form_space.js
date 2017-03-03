/**
 * Created by pzl on 15/12/24.
 */
var plugin={
    nodes:{},
    init:function(){
        this.nodes={
            doc:$(document),
            win:$(window),
            username:$("#username"),//用户名
            phone:$("#phone_space"),//手机号码
            startTime:$("#start_time"),//开始时间
            endTime:$("#end_time"),//结束时间
            actMoney:$("#act_money"),//活动预算
            actCity:$("#act_city"),//活动城市
            actPersons:$("#act_persons"),//活动人数
            actCate:$("#act_cate"),//活动类型
            actOther:$("#act_other"),//其他要求
            actDemand:$("#act_demand"),//补充要求
            dateSelect:$("#date-select"),
            inputDate:$("#input-date"),
            formSelectList:$(".form-select-list"),
            spaceSubmit:$("#space-submit"),
            itemSubmit:$("#item-submit"),
            successProLine:$(".success-pro-line"),
            circle:$(".circle"),
            actImg:$("#act_img"),//活动图片类型
            actPrice:$("#act_price"),//场地价格
            actInfo:$("#act_info"),//基本信息
            company:$("#company"),//公司名称
            actFile:$("#act_file"),//上传的名片
            successSubmitOne:$("#success-submit-one"),
            successSubmitTwo:$("#success-submit-two"),
            uploadFile:$("#upload-file"),
            dpDate:$(".dp-date"),
            jsyzm:$('.js-yzm')
        };
        this.nodes.successProLine.first().addClass("success-pro-line-ok");
        this.nodes.circle.first().find(".oked").addClass("oked-active");
        this.docEvent().inputRequired().dateShow().selectEvent().initSelect(this.nodes.formSelectList)
            .spaceSubmit().itemSubmit().successSubmitOne().successSubmitTwo().uploadFile();
        var that=this;
        var dateInterval=setInterval(function(){
            var v=that.nodes.endTime.val();
            if(that.nodes.endTime.length>0&&v.length!=0){
                that.nodes.endTime.removeClass("error");
                that.nodes.startTime.removeClass("error");
                that.nodes.endTime.parents(".form-input").find(".input-error").text("").removeClass("err").addClass("ok");
                clearInterval(dateInterval);
            }
        },500);

    },
    isPhone:function(phone){
        var pattern=/^(0|86|17951)?(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$/;
        var patt=new RegExp(pattern);
        if(patt.test(phone)){
            return true;
        }else{
            return false;
        }
    },
    /*必填项验证*/
    inputRequired:function(){
        var that=this;
        //手机号码验证
        that.nodes.phone.on("keyup blur",function(){
            var $this=$(this);
            var v=$this.val();
            if(v.length<11){
                if(!$this.hasClass("error")){
                    $this.addClass("error");
                }
                $this.parents(".form-input").find(".input-error").removeClass("err ok").text(" 请输入11位有效的手机号码");
                return that;
            }
            if(that.isPhone(v)){
                $this.removeClass("error");
                $this.parents(".form-input").find(".input-error").text("").removeClass("err").addClass("ok");
            }else{
                if(!$this.hasClass("error")){
                    $this.addClass("error");
                }
                $this.parents(".form-input").find(".input-error").text("").removeClass("ok").addClass("err");
            }

            //验证码框
            if(!$this.hasClass("error")){
                that.nodes.jsyzm.on('click',function(){
                    $(this).siblings('.yzm-ipt').show();
                    $(this).parents('.input-yzm').siblings('.input-error').hide();
                });
            }
        });



        //姓名验证
        that.nodes.username.on("keyup blur",function(){
            var $this=$(this);
            var v=$this.val();
            if(v.length==0){
                if(!$this.hasClass("error")){
                    $this.addClass("error");
                }
                $this.parents(".form-input").find(".input-error").removeClass("err ok").text("保证姓名的真实性，方便客服与您联系");
            }else{
                $this.removeClass("error");
                $this.parents(".form-input").find(".input-error").text("").removeClass("err").addClass("ok");
            }
        });
        return that;
    },
    initSelect:function(obj){
        var that=this;
        obj.each(function(index,dom){
            var $dom=$(dom);
            var vf=$dom.find("a").first().text();
            if($dom.data("initDisabled")=="true"){
                return;
            }
            if(!$dom.parents(".form-input").find("input").val()){
                $dom.parents(".form-input").find("input").val(vf);
            }
        });
        return that;
    },
    //选择类
    selectEvent:function(){
        var that=this;
        that.nodes.formSelectList.find("a").on("click",function(){
            var $this=$(this);
            var many=$this.parents(".form-select-list").data("many");
            if(many){
            //    多选
                that.selectMore($this);
            }else{
            //    单选
                that.selectOne($this);
            }
            //删除
            if($this.hasClass("select-active2")||$this.hasClass("select-active1")){
                that.getSelect($this,many);
            }else{
                that.deleteSelect($this);
            }

        })
        return that;
    },
    selectMore:function(obj){
        obj.toggleClass("select-active2");
    },
    selectOne:function(obj){
        //var that=this;
        obj.parents(".form-select-list").find("a").removeClass("select-active1");
        obj.toggleClass("select-active1");
    },
    //get选择的select的值
    getSelect:function(obj,many){
        var val=obj.text()||"",
            input=obj.parents(".form-input").find("input");
        var that=this;
       if(val!=undefined){

           switch (many){
               //多选情况下
               case true:
                   var inV=input.val();
                   val=inV+","+val;
                   input.val(val);
                   break;
               //单选情况下
               default :
                   input.val(val);
           }
       }else{
            return ;
       }
    },
    deleteSelect:function(obj){
        var v1=obj.text(),
            input=obj.parents(".form-input").find("input");
        var v2=input.val();
        var inArr=v2.split(",");
        for(var k in inArr){
            if(inArr[k]==v1){
                inArr.splice(k,1);
            }
        }
        var inStr=inArr.join(",");
        input.val(inStr);
    },
    spaceSubmit:function(){
        var that=this;
        that.nodes.actCity.val("");
        that.nodes.spaceSubmit.on("click",function(){
            var username=that.nodes.username.val(),
                phone=that.nodes.phone.val(),
                startTime=that.nodes.startTime.val(),
                endTime=that.nodes.endTime.val(),
                actMoney=that.nodes.actMoney.val(),
                actCity=that.nodes.actCity.val(),
                actPersons=that.nodes.actPersons.val(),
                actCate=that.nodes.actCate.val(),
                actOther=that.nodes.actOther.val(),
                actDemand=that.nodes.actDemand.val(),
                space_name=$('body').data('name'),
                auth_code=$(".yzm-ipt").val();
            if (actCity.substr(0,1)==',')
                actCity=actCity.substr(1);
            if(that.nodes.username.hasClass("error")){
                that.nodes.username.focus();
                that.nodes.username.parents(".form-input").find(".input-error").text("称呼不能为空").removeClass("ok").addClass("err");
                return that;
            }
            if(that.nodes.phone.hasClass("error")){
                that.nodes.phone.focus();
                that.nodes.phone.parents(".form-input").find(".input-error").text("请输入11位的有效数字号码").removeClass("ok").addClass("err");
                return that;
            }
            if(!that.nodes.startTime.val()||!that.nodes.endTime.val()){
                var offsetT=that.nodes.startTime.offset().top;
                $(that.nodes.win).scrollTop(offsetT);
                that.nodes.inputDate.trigger('click');
                that.nodes.startTime.parents(".form-input").find(".input-error").text("请选择活动日期").removeClass("ok").addClass("err");
                return that;
            }
            that.nodes.spaceSubmit.text('正在努力提交^_^ 请稍等……');
            //TODO::提交表单
            //YunSpace.api('common/check/auth/code.json', {
            //    phone: phone,
            //    auth_code: auth_code
            //}, function (data) {
            //    if (data.status == 1) {
                    YunSpace.api("demand/create.jsonp",{
                        username : username,
                        phone :phone,
                        start_date :startTime,
                        end_date :endTime,
                        demand_budget :actMoney,
                        demand_city:actCity,
                        people :actPersons,
                        demand_style :actCate,
                        demand_other :actOther,
                        demand_supply :actDemand,
                        space_name:space_name,
                        action: 'rent_space'
                    },function(data){
                        if(data.status==1){
                            window.location.href="?action=success&demand_id="+data.data["demand_id"]+"&phone="+data.data['phone'];
                        }else{
                            that.nodes.spaceSubmit.text('提交');
                            alert(data.msg);
                        }
                    })
            //    }else{
            //        alert("验证码不正确！！");
            //    }
            //});
        });
        return that;
    },
    itemSubmit:function(){
        var that=this;
        // that.nodes.actCity.val("");
        that.nodes.itemSubmit.on("click",function(){
            if(that.nodes.itemSubmit.hasClass("disabled")){
                return false;
            }
            var username=that.nodes.username.val(),
                phone=that.nodes.phone.val(),
                startTime=that.nodes.startTime.val(),
                endTime=that.nodes.endTime.val(),
                actMoney=that.nodes.actMoney.val(),
                // actCity=that.nodes.actCity.val(),
                actPersons=that.nodes.actPersons.val(),
                actCate=that.nodes.actCate.val(),
                actOther=that.nodes.actOther.val(),
                actDemand=that.nodes.actDemand.val(),
                space_name=$('body').data('name'),
                item_id=$('body').data('item_id'),
                space_item_name=$('.item_space_name').text(),
                demand_city=$("#demand_city").val(),
                auth_code=$(".yzm-ipt").val();
            // if (actCity.substr(0,1)==',')
            //     actCity=actCity.substr(1);
            if(that.nodes.username.hasClass("error")){
                that.nodes.username.focus();
                that.nodes.username.parents(".form-input").find(".input-error").text("称呼不能为空").removeClass("ok").addClass("err");
                return that;
            }
            if(that.nodes.phone.hasClass("error")){
                that.nodes.phone.focus();
                that.nodes.phone.parents(".form-input").find(".input-error").text("请输入11位的有效数字号码").removeClass("ok").addClass("err");
                return that;
            }
            if(!that.nodes.startTime.val()||!that.nodes.endTime.val()){
                var offsetT=that.nodes.startTime.offset().top;
                $(that.nodes.win).scrollTop(offsetT);
                that.nodes.inputDate.trigger('click');
                that.nodes.startTime.parents(".form-input").find(".input-error").text("请选择活动日期").removeClass("ok").addClass("err");
                return that;
            }
            that.nodes.itemSubmit.text('正在努力提交^_^ 请稍等……');
            //YunSpace.api('common/check/auth/code.json', {
            //    phone: phone,
            //    auth_code: auth_code
            //}, function (data) {
            //    if (data.status == 1) {
                    //TODO::提交表单
                    YunSpace.api("demand/create.jsonp",{
                        username : username,
                        phone :phone,
                        start_date :startTime,
                        end_date :endTime,
                        // demand_budget :actMoney,
                        demand_city:demand_city,
                        people :actPersons,
                        demand_style :actCate,
                        demand_other :actOther,
                        // demand_supply :actDemand,
                        space_item_name:space_item_name,
                        space_name:space_name,
                        item_id:item_id,
                        action: 'rent_item'
                    },function(data){
                        console.log(data);
                        if(data.status==1){
                            that.nodes.itemSubmit.text('提交');
                            that.nodes.itemSubmit.addClass("disabled");
                        }
                        alert(data.msg);
                    });
            //    }else{
            //        alert("验证码不正确！！");
            //    }
            //});
   
        });
        return that;
    },
    uploadFile:function(){
        var that=this;
        that.nodes.uploadFile.on("click",function(){
            var $this=$(this);
            var v=$this.parents(".form-input").find("input").val();
            if(v!=""){
                that.nodes.uploadFile.unbind("click");
                return false;
            }
        });
        return that;
    },
    //  TODO::成功后第一个表单提交
    successSubmitOne:function(){
        var that=this;
        that.nodes.actImg.val("");
        that.nodes.actInfo.val("");

        that.nodes.successSubmitOne.on("click",function(){
            var demand_id=$("input[name=demand_id]").val(),
                phone=$("#rent_phone").val(),
               /* price=that.nodes.actPrice.val(),*/
                img=that.nodes.actImg.val(),
                info=that.nodes.actInfo.val();
            if (img.substr(0,1)==',')
                img=img.substr(1);
            if (info.substr(0,1)==',')
                info=info.substr(1);
            YunSpace.api("demand/update.jsonp",{
                demand_id : demand_id,
                phone :phone,
              /*  price :price,*/
                img :img,
                info :info,
                level:1
            },function(data){
                if(data.status==1){
                    $('.success-process-list li').eq(1).find(".success-pro-name p").addClass('success-ok ok-one');
                    $('.success-process-list li').eq(1).find(".success-pro-line").addClass('success-pro-line-ok');
                    $('.success-process-list li').eq(1).find(".oked").addClass('oked-active');
                    $(".success-process-body").eq(0).addClass('none');
                    $(".success-process-body").eq(1).removeClass('none');

//                    window.location.href="?action=success&demand_id="+data.data["demand_id"]+"&phone="+data.data['phone']+"&level=2";
                }else{
                    alert(data.msg);
                }
            });

        });
        return that;
    },
    //  TODO::成功后第二个表单提交
    successSubmitTwo:function(){
        var that=this;
        that.nodes.successSubmitTwo.on("click",function(){
            var demand_id=$("input[name=demand_id]").val(),
                phone=$("#rent_phone").val(),
                company=that.nodes.company.val(),
                card=that.nodes.actFile.val();

            YunSpace.api("demand/update.jsonp",{
                demand_id : demand_id,
                phone :phone,
                company :company,
                card :card,
                level:2
            },function(data){
                if(data.status==1){
                    $('.success-process-list li').eq(2).find(".success-pro-name p").addClass('success-ok ok-one');
                    $('.success-process-list li').eq(2).find(".success-pro-line").addClass('success-pro-line-ok');
                    $('.success-process-list li').eq(2).find(".oked").addClass('oked-active');
                    $(".success-process-body").eq(0).addClass('none');
                    $(".success-process-body").eq(1).addClass('none');
                    $(".success-process-body").eq(2).removeClass('none');
//                    window.location.href="?action=success&level=3";
                }else{
                    alert(data.msg);
                }
            });
        });
        return that;
    },
    //    显示日历
    dateShow:function(){
        var that=this;
        that.nodes.inputDate.on("click",function(){
            var $this=$(this);
            that.nodes.dateSelect.slideDown();
        });
        return that;
    },
    //    document事件
   docEvent:function(){
       var that=this;
       that.nodes.doc.on("click",function(e){
           if($(e.target).closest("#date-select,#input-date").length==0){;
               that.nodes.dateSelect.hide();
           }
       });
       return that;
   }
}

