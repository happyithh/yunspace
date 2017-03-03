/**
 * Created by pzl on 15/11/27.
 */
var plugin={
    init:function(){
        var __self=this;
        __self.updateOrder().changePanel();
        $(".datePicker").on("click",function(){
            $(".date,.site_change_cover").fadeIn(200);
        });
        $(".site_change_cover").on("click",function(){
            $(".date,.site_change_cover").fadeOut(200);
        });
    },
    //页面切换
    changePanel:function(){
        $(".panel_change:eq(0)").on("click",function(){
           $(".schedule_info_panel:last").removeClass("none");
        });
        $(".panel_change:eq(1)").on("click",function(){
            $(".schedule_info_panel:last").addClass("none");
        });
    },
    updateOrder:function(){
        var __self=this;
        var sub=false;
        if(sub==true)return;
        $(".change_btn").on("click",function(e){
            //e.stopPropagation();
            e.preventDefault();
            var state=$("select[name='status']").val()||'',
                actStartTime=$("input[name='activity_start_time']").val()||'',
                actEndTime=$("input[name='activity_end_time']").val()||'',
                demand_product_id=$("#demand_product_id").val()||'',
                //itemId=$("input[name='item_info']").val()||0,
                itemId=$("select[name='item_info']").val()||'',
                fromWhere=$("select[name='from_where']").val()||'',
                detail= {
                    'price': $("#detail_price").val()||'',
                    'per_price': $("#day").val()||'',
                    'other_price': $("#detail_other_price").val()||'',
                    'per_other_price': $("#other_day").val()||'',
                    '活动名称': $("#act_name").val()||'',
                    '活动人数': $("#act_person_num").val()||'',
                    '活动类型': $("#act_type").val()||'',
                    '活动备注': $("#act_other").val()||''
                },
                demand= {
                    'people': $("#act_user").val()||'',
                    'phone': $("#act_phone").val()||'',
                    'email': $("#act_email").val()||'',
                    'company': $("#act_company").val()||'',
                    'company_type': $('#company_type').val()||''
                };
            var patt=new RegExp(/^(0|86|17951)?(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$/);
            if(actStartTime==""||actEndTime==""){
                alert("请选择活动日期！！");return false;
            }
            if(detail['活动名称']==""){
                alert("请填写活动名称！！");return false;
            }
            if(demand['people']==""){
                alert("请填写真实姓名！！");return false;
            }
            if(demand['phone']==""||!patt.test(demand['phone'])){
                alert("请正确填写手机号码！！");return false;
            }
            var save=$(".change_btn").data("save");
            var url=$(".change_btn").data("url");
            if(sub==true){return;}
            //console.log(actStartTime,actEndTime,detail,demand);
            //return false;
            YunSpace.api('demand/product/submit.json', {
                id:demand_product_id,
                status:state,
                activity_start_time:actStartTime,
                activity_end_time:actEndTime,
                item_id:itemId,
                from_where:fromWhere,
                detail:detail,
                demand:demand
            }, function (data) {
                //console.log(data);
                sub=true;
                if(data.status=="1"){
                    if(save==1){
                        alert('提交成功!!');
                        window.location.href=url;
                    }else{
                        alert('修改成功!!');
                        window.location.href=url;
                    }
                }else{
                    if(save==1){
                        alert('提交失败!!');
                    }else{
                        alert('修改失败!!');
                    }
                }
            });
        });
        return __self;
    }

}