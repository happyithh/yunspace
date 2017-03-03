<div class="tab-pane fade active in" id="tab_1_1">
<div class="portlet tabbable">
    <div class="portlet-title">
        <div class="caption">
            其他信息
        </div>
    </div>
    <div class="portlet-body" style="padding:10px 10px">
        <div class="clearfix col-md-12" style="font-size: 12px">
            <div class="table-responsive" style="border:0px;">
                <table class="table table-hover" style="border:0px;">
                    <tbody>
                    <tr>
                        <td>公司名称</td>
                        <td>{$data['company']}</td>
                    </tr>
                    <tr>
                        <td>公司电话</td>
                        <td>{$data['tel']}</td>
                    </tr>
                    <tr>
                        <td>公司职务</td>
                        <td>{$data['position']}</td>
                    </tr>

                    {foreach $data['attr']['基本信息'] as $k=>$v}
                        <tr>
                            <td width="300">{$k}:</td>
                            <td>{$v}</td>
                        </tr>
                    {/foreach}
                    {if $data['is_my']}
                        {foreach $data['attr']['联系方式'] as $k=>$v}
                            <tr>
                                <td>{$k}:</td>
                                <td>{$v}</td>
                            </tr>
                        {/foreach}
                    {/if}
                    {foreach $data['attr']['公司信息'] as $k=>$v}
                        <tr>
                            <td>{$k}:</td>
                            <td>{$v}</td>
                        </tr>
                    {/foreach}
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
</div>