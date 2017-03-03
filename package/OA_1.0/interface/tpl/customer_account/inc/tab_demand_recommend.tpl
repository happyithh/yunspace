<div class="portlet">
    <div class="portlet-title">
        <div class="caption">
            <i class="fa fa-database"></i>需求详情
        </div>
    </div>
    <div class="portlet-body">
        <div class="clearfix">
        <div class="container-fluid">
            <div class="clearfix col-md-12">
                <div class="col-md-10">
                    <div class="form-group clearfix readdata">
                        <label class="control-label col-md-3">联系人:</label>
                        <div class="col-md-9">
                            <p class="form-control-static">{$demand['username']}</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-10">
                    <div class="form-group clearfix readdata">
                        <label class="control-label col-md-3">联系方式:</label>
                        <div class="col-md-9">
                            <p class="form-control-static">{$demand['phone']}</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-10">
                    <div class="form-group clearfix readdata">
                        <label class="control-label col-md-3">具体要求:</label>
                        <div class="col-md-9">
                            <p class="form-control-static">{$demand['demand']['具体要求']}</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        </div>
    </div>
    {if $_REQUEST['recommend_type']=='take_look'}
        {include file="customer_account/inc/demand_inc/take_look.tpl"}
    {elseif $_REQUEST['recommend_type']=='product'}
        {include file="customer_account/inc/demand_inc/demand_recommend_inc.tpl"}
    {elseif $_REQUEST['recommend_type']=='set'}
        {include file="customer_account/inc/demand_inc/demand_recommend_set_inc.tpl"}
    {/if}
</div>
<script>
    $("#product_id").select2({
        placeholder: "选择产品",
        minimumInputLength: 1,
        ajax: {
            {*url: "{$_route}list?action=auto_complete_product",*}
            url:  "http://{Core::$urls['host']}/static/api/product/search/all.json?action=product",
            dataType: 'json',
            data: function (term, page) {
                return {
                    q: term // search term
//                    query_product: 1
                };
            },
            results: function (data, page) { // parse the results into the format expected by Select2.
                // since we are using custom formatting functions we do not need to alter remote JSON data
                return {
                    results: data.data
                };
            }
        },
        initSelection: function (element, callback) {
            var id = $(element).val();
            if (id !== "") {
                $.ajax("http://{Core::$urls['host']}/static/api/product/search/all.json?action=product", {
                    data: {
                        product_id: id
                    },
                    dataType: "json"
                }).done(function (data) {
                            callback(data.data);
                        });
            }
        },
        formatResult: formatRepo, // omitted for brevity, see the source of this page
        formatSelection: formatRepoSelection, // omitted for brevity, see the source of this page
        escapeMarkup: function (m) {
            return m;
        } // we do not want to escape markup since we are displaying html in results
    });
    function formatRepo(repo) {
        if (repo.loading) return repo.text;
        return repo.name;
    }

    function formatRepoSelection(repo) {
        return repo.name || repo.text;
    }
</script>

