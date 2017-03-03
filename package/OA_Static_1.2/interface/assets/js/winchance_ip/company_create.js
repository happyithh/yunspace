/**
 * Created by Administrator on 2016/5/9.
 *
 * 文创IP
 */

// 人物形象详情
var figure_id;
$(".figure_edit").on("click",function(){
   figure_id = $('.figure_edit').data('figure-id');
});
$('#modal-one').on('show.bs.modal', function (e) {
    if(figure_id==''){
        alert('id异常！');
        return false;
    }

    //YunSpace.api('winchance/new/figure/detail.jsonp', {
    //    figure_id:figure_id
    //},function (data) {
    //    // 弹出框放这里里面，数据也放着里面
    //    console.log(data);
    //    $(".figure_name").val(data.data.name);
    //    console.log(figure_id);
    //});
});


// 品牌公司详情
var company_id;
$(".company_edit").on("click",function(){
    company_id = $('.company_edit').data('company-id');
});
$('#modal-two').on('show.bs.modal', function (e) {
    if(company_id==''){
        alert('id异常！');
        return false;
    }
    //YunSpace.api('winchance/new/company/detail.jsonp', {
    //    company_id:company_id
    //},function (data) {
    //    // 弹出框放这里里面，数据也放着里面
    //    $(".company_name").val(data.data.company);
    //});
});
var name;
$('#modal-one').on('show.bs.modal', function (e) {
    $(".field-name").text('编辑字段-'+name);
});
$(".edit-one").click(function(){
    name=$(this).parents('tr').find('.name').text();
});
$('.field_submit').click(function(){
   var content = $('#persons').val();
   var url = $('#url').val();
    //alert(content);
    YunSpace.api('winchance/new/field.jsonp', {
        content:content,name:name
    },function (data) {
        if(data.status == 1){
            window.location.href=url;
        }else{
            top.alert(data.msg);
        }
    });
});
