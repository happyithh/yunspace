<div class="portlet-title">
    <div class="caption">
        <i class="fa fa-database"></i>带看场地
    </div>
</div>
<div class="portlet-body">
    <div class="clearfix">
        <form class="form-horizontal" action="{$_route}list?action=take_look_submit" method="post">
            <input type="hidden" name="data[demand_id]" value="{$_REQUEST['demand_id']}" >
            <div class="form-group">
                <label for="inputEmail12" class="col-md-2">场地ID：</label>
                <div class="col-md-4">
                    <input name="data[product_id]" placeholder="请输入场地ID或名称" class="form-control select2"
                               id="product_id" type="hidden">
                </div>
            </div>
            <div class="form-group">
                <label for="inputEmail12" class="col-md-2">时间：</label>
                <div class="col-md-4">
                    <input type="text" class="form-control date" name="data[look_time]" placeholder="请选择要查看的场地时间">
                </div>
            </div>
            <div class="form-group">
                <label for="inputEmail11" class="col-md-2">备注：</label>
                <div class="col-md-4">
                    <textarea name="data[demo]" class="form-control" rows="5"></textarea>
                </div>
            </div>
            <div class="form-actions">
                <div class="form-group">
                    <div class="col-md-offset-2 col-md-10">
                        <button type="submit" class="btn btn-success">提交带看场地信息</button>
                    </div>
                </div>
            </div>
        </form>
    </div>
</div>
{if $demand_recommend['rows']}
    <div class="portlet-title">
        <div class="caption">
            <i class="fa fa-database"></i>带看场地列表
        </div>
    </div>
    <div class="tab-content clearfix">
        <div class="tab-pane active" >
            <table class="table table-striped table-bordered table-hover" style="word-break: break-all">
                <thead>
                <tr>
                    <th>产品名称</th>
                    <th>场地查看时间</th>
                    <th>备注</th>
                    <th>创建时间</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                {foreach $demand_recommend['rows'] as $key=>$value}
                    <tr>
                        <td>{$value['product_name']}</td>
                        <td>{date('Y-m-d',$value['look_time'])}</td>
                        <td>{$value['demo']}</td>
                        <td>{date('Y-m-d H:i:s',$value['create_time'])}</td>
                        <td>
                            <a target="_blank" href="http://{Core::$urls['host']}/service_info/{$value['product_id']}.html" class="btn btn-success btn-xs">查看</a>
                            <a target="_blank" href="{$_route}list?action=pdf&product_id={$value['product_id']}" class="btn btn-primary btn-xs">导出PDF</a>
                            <a  href="{$_route}list?action=create_order&product_id={$value['product_id']}&demand_id={$_REQUEST['demand_id']}" class="btn btn-info btn-xs">生成订单</a>
                        </td>
                    </tr>
                {/foreach}
                </tbody>
            </table>
        </div>
        <div class="pull-right">
            <ul class="pagination">
                {if $demand_recommend['page']['dpll']}
                    <li class="prev">
                        <a href="{$demand_recommend['page']['dup']}1" title="First"><i class="fa fa-angle-double-left"></i></a>
                    </li>
                    <li class="prev">
                        <a href="{$demand_recommend['page']['dup']}{$demand_recommend['page']['dp']-1}" title="Prev"><i class="fa fa-angle-left"></i></a>
                    </li>
                {else}
                    <li class="prev disabled">
                        <a href="#" title="First"><i class="fa fa-angle-double-left"></i></a>
                    </li>
                    <li class="prev disabled">
                        <a href="#" title="Prev"><i class="fa fa-angle-left"></i></a>
                    </li>
                {/if}
                {for $i=$demand_recommend['page']['dpl'] to $demand_recommend['page']['dpr']}
                    <li{if $i==$demand_recommend['page']['dp']} class="active"{/if}>
                        <a href="{$demand_recommend['page']['dup']}{$i}">{$i}</a>
                    </li>
                {/for}
                <li class="disabled">
                    <a> {$demand_recommend['page']['dtp']} ( {$demand_recommend['page']['dp']*$demand_recommend['page']['dn']}/{$demand_recommend['page']['dt']} )</a></li>

                {if $demand_recommend['page']['dprr']}
                    <li class="next">
                        <a href="{$demand_recommend['page']['dup']}{$demand_recommend['page']['dp']+1}" title="Next"><i class="fa fa-angle-right"></i></a>
                    </li>
                    <li class="next">
                        <a href="{$demand_recommend['page']['dup']}{$demand_recommend['page']['dtp']}" title="Last"><i class="fa fa-angle-double-right"></i></a>
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

<script type="text/javascript" src="js/moment.min.js"></script>
<script type="text/javascript" src="js/zh-cn.js"></script>
<script type="text/javascript" src="js/bootstrap-datetimepicker.min.js"></script>
<script>
    $(document).ready(function () {
        $(".date").datetimepicker({
//           autoclose: true,

            //format: "dd MM YYYY - hh"
            format: "YYYY-MM-DD HH:mm"
            //pickerPosition: (App.isRTL() ? "bottom-right" : "bottom-left")
//            format: "YYYY-MM-DD HH:ii",
//            language: 'zh-CN'
//            show: true,
//            format: "yyyy-MM-DD HH:ii"
//            language: 'zh-CN',
//            weekStart: 1,
//            autoclose: true,
//            orientation:'right',
//            todayBtn:'linked'

        });
    });
</script>