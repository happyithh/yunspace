/**
 * Created by Administrator on 2016/5/9.
 */
$("#persons").select2({
    tags: []
});
$("#feature_tag").select2({
    tags: []
});
var $brand=$("#brand"),
    $figure=$("#figure"),
    $preIp=$("#pre_ip");
var brand_url=$brand.data('url');
var figure_url=$figure.data('url'),
    pre_ip_url=$preIp.data('url'),
    brandText;
$figure.select2({
    placeholder:"string",
    ajax: {
        url:figure_url,
        dataType: 'json',
        delay: 250,
        data: function (term) {
            return {
                q: term,company:brandText // search term
            };
        },
        createSearchChoice   : function(term, data) {           // 创建搜索结果（使用户可以输入匹配值以外的其它值）
            return { id: term, name: term };
        },
        results: function (data, params) {
            params.page = params.page || 1;
            return {
                results: data.results,
                pagination: {
                    more: (params.page * 10) < data.total_count
                }
            };
        },
        cache: true
    },
    escapeMarkup: function (markup) { return markup; }, // let our custom formatter work
    minimumInputLength: 1,
    formatSelection : function (item) { return item.name; },  // 选择结果中的显示
    formatResult    : function (item) { return item.name; },  // 搜索列表中的显示
    templateResult: formatRepo, // omitted for brevity, see the source of this page
    templateSelection: formatRepoSelection // omitted for brevity, see the source of this page
}).on('change',function(r){
    $('input[name="figure"]').val(r.val);
    console.log($('input[name="figure"]').val());
});
function formatRepo (repo) {
    if (repo.loading) return repo.text;
    var markup = "<div>"+repo.name+"</div>";
    return markup;
}
function formatRepoSelection (repo) {
    console.log(repo,12312);
    return repo.full_name || repo.name;
}
$brand.select2({
    ajax: {
        url: brand_url,
        dataType: 'json',
        delay: 250,
        data: function (term) {
            return {
                q: term // search term
            };
        },
        createSearchChoice   : function(term, data) {           // 创建搜索结果（使用户可以输入匹配值以外的其它值）
            return { id: term, name: term };
        },
        results: function (data, params) {
            params.page = params.page || 1;
            return {
                results: data.results,
                pagination: {
                    more: (params.page * 10) < data.total_count
                }
            };
        },
        cache: true
    },
    escapeMarkup: function (markup) { return markup; }, // let our custom formatter work
    minimumInputLength: 1,
    formatSelection : function (item) { return item.name; },  // 选择结果中的显示
    formatResult    : function (item) { return item.name; },  // 搜索列表中的显示
    templateResult: formatRepo, // omitted for brevity, see the source of this page
    templateSelection: formatRepoSelection // omitted for brevity, see the source of this page
}).on('change',function(r){
    $('input[name="company"]').val(r.val);
    brandText=r.val;
    //console.log($('input[name="company"]').val());
    //$('.hidden-company').val(r.val);

    //console.log($('input[name="company"]').val());
});
$(".company-name").find('.select2-chosen').text($('.hidden-company').val());
$(".figure-name").find('.select2-chosen').text($('.hidden-figure').val());
var allHtm="",allIP=[],allModal=false;
function addIPHt(num,title){
    var addIPHtm=' <div class="form-group clearfix ip_num">'+
        '<input type="hidden" name="ip_info['+num+'][name]" value="'+title+'">'+
        '<label class="col-md-1 control-label col-xs-2">意向IP'+num+'</label>'+
        '<div class="col-md-3 col-xs-4">'+
        '<div class="alert alert-success title" style="padding:7px;">'+
                title+
        '</div>'+
        '</div>'+
        ' <div class="col-md-1 col-xs-3">'+
        '<button class="btn btn-success show-modal show-modal-btn2" type="button" data-value="'+title+'" data-toggle="modal" data-title="确认最终IP" data-text="确认选择'+title+'作为该订单的最终IP吗? 选择后不可更改哦！"  >选为最终IP</button>'+
        ' </div>'+
        ' <div class="col-md-4 col-xs-6" style="margin-left: 25px;">'+
        ' <input type="text" name="ip_info['+num+'][remarks]" class="form-control " placeholder="这里可以填写此IP的备注"  value="">'+
        ' </div>'+
        ' </div>';
    return addIPHtm;
}
var preIP;
$preIp.select2({
    ajax: {
        url: pre_ip_url,
        dataType: 'json',
        delay: 250,
        data: function (term) {
            return {
                q: term // search term
            };
        },
        createSearchChoice   : function(term, data) {           // 创建搜索结果（使用户可以输入匹配值以外的其它值）
            return { id: term, name: term };
        },
        results: function (data, params) {
            params.page = params.page || 1;
            return {
                results: data,
                pagination: {
                    more: (params.page * 10) < data.total_count
                }
            };
        },
        cache: true
    },
    escapeMarkup: function (markup) { return markup; }, // let our custom formatter work
    minimumInputLength: 1,
    formatSelection : function (item) { return item.name; },  // 选择结果中的显示
    formatResult    : function (item) { return item.name; },  // 搜索列表中的显示
    templateResult: formatRepo, // omitted for brevity, see the source of this page
    templateSelection: formatRepoSelection // omitted for brevity, see the source of this page
}).on('change',function(r){
    preIP= r.val;
});
var index=0;
$("#add-pre-ip").on("click",function(){
    if(allIP.indexOf(preIP)>-1){
        alert('该IP已添加，请勿重复添加！！');
        return;
    }
    if(!preIP){
        alert('请搜索选择要添加的IP');
        return;
    }
    var ip_num = $("#all-IP").find(".ip_num").length;
    $("#all-IP").append(addIPHt(ip_num+1,preIP));
    allIP.push(preIP);
    selectFinal();
});
selectFinal();
function selectFinal(){
    $(".show-modal-btn2").on("click",function(){
        var btn2=$(this);
        var modalOne=$('#modal-one');
        modalOne.modal('show');
        var title1= $(this).data('title');
        var title2= $(this).attr('data-value');
        var text1= $(this).data('text');
        modalOne.find(".modal-title").text(title1);
        modalOne.find(".modal-text").text(text1);
        $('.modal-ok-one').on('click',function(){
            //var $this=$(this);
            /*点击确认ajax请求*/
            $("#final_ip").val(title2);
            btn2.parents('.form-group').find('.title').append('<code style="float: right">最终IP</code>');
            modalOne.modal('hide');
            $("#all-IP").find('.show-modal-btn2').remove();
            $(".add-pre-IP").remove();
        })
    });
}
$('#modal-two,#modal-one').on('show.bs.modal', function (e) {
    $(window).scrollTop(0);
});
var title2,text2,url2,title1,text1,url1;
showModalTwoText('.show-modal-a');
showModalOneText('.show-modal-btn',function(){
    //$('#modal-one').modal('hide');
});
showModalOneText('.show-modal-btn2',function(){
    $('#modal-one').modal('hide');
});
/*有链接的modal*/
function showModalTwoText(o){
    var o=$(o);
    o.on('click',function(){
        title2= o.data('title');
        text2= o.data('text');
        url2= o.data('url');
    });
    $('#modal-two').on('show.bs.modal', function (e) {
        $(this).find(".modal-title").text(title2);
        $(this).find(".modal-text").text(text2);
        $(this).find(".modal-url").attr('href',url2);
    });
}
/*无链接的modal*/
function showModalOneText(o,fn){
    var o=$(o);
    o.on('click',function(){
        title1= o.data('title');
        text1= o.data('text');
        console.log(title1);
    });
    $('#modal-one').on('show.bs.modal', function (e) {
        $(this).find(".modal-title").text(title1);
        $(this).find(".modal-text").text(text1);
        $(this).find('.modal-ok-one').on('click',function(){
            fn();
       })
    });
}
if($(".company-name").find('.select2-chosen').text()==''){
    $(".company-name").find('.select2-chosen').text("请输入IP品牌公司名称");
}
if($(".company-name").find('.select2-chosen').text()=='请输入IP品牌公司名称'){
    $(".company-name").find('.select2-chosen').css("color","#909090");
}
if($(".figure-name").find('.select2-chosen').text()==''){
    $(".figure-name").find('.select2-chosen').text("请输入IP形象名称");
}
if($(".figure-name").find('.select2-chosen').text()=='请输入IP形象名称'){
    $(".figure-name").find('.select2-chosen').css("color","#909090");
}