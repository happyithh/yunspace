/**
 * Created by Administrator on 2016/5/9.
 */
$("#persons").select2({
    tags: []
});
$("#feature_tag").select2({
    tags: []
});
var $space_item=$("#space_item");
var space_item_url=$space_item.data('url');
var space_itemText;
function formatRepo (repo) {
    if (repo.loading) return repo.text;
    var markup = "<div>"+repo.name+"</div>";
    return markup;
}
function formatRepoSelection (repo) {
    console.log(repo,12312);
    return repo.full_name || repo.name;
}
$space_item.select2({
    ajax: {
        url: space_item_url,
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
            //params.page = params.page || 1;
            if(data){
                return {
                    results: data.results
                    //pagination: {
                    //    more: (params.page * 10) < data.total_count
                    //}
                };
            }else{
                return {
                    results: ''
                    //pagination: {
                    //    more: (params.page * 10) < data.total_count
                    //}
                };
            }

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
    $('input[name="space_item_name"]').val(r.val);
    //space_itemText=r.val;
    //console.log($('input[name="company"]').val());
    //$('.hidden-company').val(r.val);

    //console.log($('input[name="company"]').val());
});
