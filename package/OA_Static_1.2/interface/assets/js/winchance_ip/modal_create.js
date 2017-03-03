/**
 * Created by Administrator on 2016/5/11.
 */
var  figure_id,figure_company,figure_name,figure_note,figure_type,company_type,company_name,company_id,company_note;
$(".figure_edit").on('click',function() {
    figure_company=$(this).data('company');
    figure_name=$(this).data('figure');
    figure_type=$(this).data('type');
    figure_id = $(this).data('figure-id');
    figure_note = $(this).data('figure-note');
});
$("#modal-one").on('show.bs.modal',function() {
    $(this).find(".figure_company").val(figure_company);
    $(this).find(".figure_name").val(figure_name);
    $(this).find(".figure_note").val(figure_note);
    if( figure_type==1){
        $(this).find(".select2-chosen").text("");
    }else{
        $(this).find('.select2-chosen').text(figure_company);
    }
});
$(".company_edit").on('click',function() {
    company_name=$(this).data('company');
    company_type=$(this).data('type');
    company_id=$(this).data('company-id');
    company_note=$(this).data('company-note');
    //company_id = $('.company_edit').data('company-id');
});
$("#modal-two").on('show.bs.modal',function() {
    $(this).find(".company_name").val(company_name);
    $(this).find(".company_note").val(company_note);
});

// 品牌公司创建/编辑
$(".company_create").click(function(){
    var company_name =$('.company_name').val();
    var company_note =$('.company_note').val();
    var url = $('.company_create').data('company-to-url');
    if(company_name==''){
        alert('请填写品牌公司名称！');
        return false;
    }
    //alert(company_note);
    YunSpace.api('winchance/new/company.jsonp', {
        company_id:company_id,company:company_name,note:company_note
    },function (data) {
        if(data.status == 1){
            //alert(data.msg);
            window.location.href=url;
        }else{
            top.alert(data.msg);
        }
    });
});
// 人物形象创建/编辑
$('.figure_create').click(function(){
    var figure_name =$('.figure_name').val();
    var figure_company =$('.figure_company').val();
    var figure_note =$('.figure_note').val();
    var url = $('.figure_create').data('figure-to-url');
    if(figure_name==''){
        alert('请填写人物形象名称！');
        return false;
    }
    if(figure_company==''){
        alert('请选择所属公司！');
        return false;
    }
    YunSpace.api('winchance/new/figure.jsonp', {
        figure_id:figure_id,name:figure_name,company:figure_company,note:figure_note
    },function (data) {
        if(data.status == 1){
            //alert(data.msg);
            window.location.href=url;
        }else{
            top.alert(data.msg);
        }
    });
});


