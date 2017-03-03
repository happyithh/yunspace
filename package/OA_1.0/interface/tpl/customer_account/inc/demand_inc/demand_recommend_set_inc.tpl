<div class="portlet-title">
    <div class="caption">
        <i class="fa fa-database"></i>需求推荐
    </div>
</div>
<div class="portlet-body">
    <div class="clearfix">
        <form class="form-horizontal" action="?action=recommend_submit" method="post">
            <input type="hidden" name="data[demand_id]" value="{$_REQUEST['demand_id']}" >
            <div class="form-group">
                <label for="inputEmail12" class="col-md-2">推荐套餐：</label>
                <div class="col-md-4">
                    <div class="input-icon">
                        {*<input type="text" class="form-control" id="inputEmail12" placeholder="请输入产品地址" name="data[product_url]">*}
                        <input name="data[set_id]" placeholder="请输入套餐ID或名称" class="form-control select2"
                               id="set_id" type="hidden">
                    </div>
                </div>
            </div>
            <div class="form-group">
                <label for="inputEmail11" class="col-md-2">推荐理由：</label>
                <div class="col-md-4">
                    <div class="input-icon">
                        <textarea name="data[demo]" class="form-control" rows="5"></textarea>
                    </div>
                </div>
            </div>
            <div class="form-actions">
                <div class="form-group">
                    <div class="col-md-offset-2 col-md-10">
                        <button type="submit" class="btn btn-success">确认推荐</button>
                    </div>
                </div>
            </div>
        </form>
    </div>
</div>
{if $demand_recommend['demand_demo']}
    <div class="portlet-title">
        <div class="caption">
            <i class="fa fa-database"></i>需求回复
        </div>
    </div>
    <div class="tab-pane active" >
        <div>
            <table class="table table-striped table-bordered table-hover" style="word-break: break-all">
                <tr>
                    <th>回复时间</th>
                    <th>回复内容</th>
                </tr>
                {foreach $demand_recommend['demand_demo'] as $dk=>$dv}
                    <tr>
                        <td>{date('Y-m-d H:i:s',$dv['create_time'])}</td>
                        <td>{htmlspecialchars($dv['demo'])}</td>
                    </tr>
                {/foreach}
            </table>
        </div>
    </div>
{/if}
{if $demand_recommend['demand_product']['rows']}

    <div class="portlet-title">
        <div class="caption">
            <i class="fa fa-database"></i>套餐推荐列表
        </div>
    </div>
    <div class="tab-content clearfix">
        <div class="tab-pane active" >
            <table class="table table-striped table-bordered table-hover" style="word-break: break-all">
                <thead>
                <tr>
                    <th>套餐名称</th>
                    <th>推荐理由</th>
                    <th>推荐时间</th>
                    <th>订单号</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                {foreach $demand_recommend['demand_product']['rows'] as $key=>$value}
                    <tr>
                        <td>{$value['set_name']}</td>
                        <td>{$value['demo']}</td>
                        <td>{date('Y-m-d H:i:s',$value['create_time'])}</td>
                        <td>{$value['order_no']}</td>
                        <td>
                            <a target="_blank" href="http://{Core::$urls['host']}/set_info/{$value['set_id']}.html" class="btn btn-success btn-xs">查看</a>
                            <a target="_blank" href="{$_route}list?action=set_pdf&set_id={$value['set_id']}" class="btn btn-primary btn-xs">导出PDF</a>
                           <a  href="{$_route}list?action=create_order&set_id={$value['set_id']}&demand_id={$_REQUEST['demand_id']}" class="btn btn-info btn-xs">生成订单</a>
                        </td>
                    </tr>
                {/foreach}
                </tbody>
            </table>
        </div>
        <div class="pull-right">
            <ul class="pagination">
                {if $demand_recommend['demand_product']['page']['dpll']}
                    <li class="prev">
                        <a href="{$demand_recommend['demand_product']['page']['dup']}1" title="First"><i class="fa fa-angle-double-left"></i></a>
                    </li>
                    <li class="prev">
                        <a href="{$demand_recommend['demand_product']['page']['dup']}{$demand_recommend['demand_product']['page']['dp']-1}" title="Prev"><i class="fa fa-angle-left"></i></a>
                    </li>
                {else}
                    <li class="prev disabled">
                        <a href="#" title="First"><i class="fa fa-angle-double-left"></i></a>
                    </li>
                    <li class="prev disabled">
                        <a href="#" title="Prev"><i class="fa fa-angle-left"></i></a>
                    </li>
                {/if}
                {for $i=$demand_recommend['demand_product']['page']['dpl'] to $demand_recommend['demand_product']['page']['dpr']}
                    <li{if $i==$demand_recommend['demand_product']['page']['dp']} class="active"{/if}>
                        <a href="{$demand_recommend['demand_product']['page']['dup']}{$i}">{$i}</a>
                    </li>
                {/for}
                <li class="disabled">
                    <a> {$demand_recommend['demand_product']['page']['dtp']} ( {$demand_recommend['demand_product']['page']['dp']*$demand_recommend['demand_product']['page']['dn']}/{$demand_recommend['demand_product']['page']['dt']} )</a></li>

                {if $demand_recommend['demand_product']['page']['dprr']}
                    <li class="next">
                        <a href="{$demand_recommend['demand_product']['page']['dup']}{$demand_recommend['demand_product']['page']['dp']+1}" title="Next"><i class="fa fa-angle-right"></i></a>
                    </li>
                    <li class="next">
                        <a href="{$demand_recommend['demand_product']['page']['dup']}{$demand_recommend['demand_product']['page']['dtp']}" title="Last"><i class="fa fa-angle-double-right"></i></a>
                    </li>
                {else}
                    <li class="next disabled">
                        <a href="#" title="Next"><i class="fa fa-angle-right"></i></a>
                    </li>
                    <li class="next disabled">
                        <a href="#" title="Last"><i class="fa fa-angle-double-right"></i></a>
                    </li>
                {/if}
            </ul>
        </div>
    </div>
{/if}
<script>
    $("#set_id").select2({
        placeholder: "选择套餐",
        minimumInputLength: 1,
        ajax: {
            url: "http://{Core::$urls['host']}/static/api/product/search/all.json?action=set",
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
                $.ajax("http://{Core::$urls['host']}/static/api/product/search/all.json?action=set", {
                    data: {
                        set_id: id
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