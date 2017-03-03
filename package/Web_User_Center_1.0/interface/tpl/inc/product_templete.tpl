<h1 align="center"><strong>《{$data['product_name']}》</strong></h1>
<div style="width:500px;">
    <p><strong>网址：</strong><span><a target="_blank" href="{Core::$urls['host']}/service_info/{$data['id']}.html">点此更多精彩</a></span></p>
    <div>
        <h3>基本信息</h3>
        <table>
            <tr>
                <td  style="height: 20px;width:80px;"><b>产品名称：</b></td>
                <td>{$data['product_name']}</td>
            </tr>
            <tr>
                <td style="height: 20px;width:80px;"><b>地址：</b></td>
                <td>{$data['addr']}</td>
            </tr>
            <tr>
                <td style="height: 20px;width:80px;"><b>供应商：</b></td>
                <td>{$data['vendor_name']}</td>
            </tr>
            <tr>
                <td style="height: 20px;width:80px;"><b>空间类型：</b></td>
                <td>{$data['category_name']}</td>
            </tr>
        </table>

    </div>
    <div>
        <h3>产品属性</h3>
        <table>
            <tr>
                <td  style="height: 20px;width:80px;"><b>所属商圈：</b></td>
                <td>{$data['attr']['基本信息>所属商圈']}</td>
            </tr>
            <tr>
                <td  style="height: 20px;width:80px;"><b>行政区域：</b></td>
                <td>{$data['attr']['基本信息>行政区域']}</td>
            </tr>
            <tr>
                <td  style="height: 20px;width:80px;"><b>停车位：</b></td>
                <td>{$data['attr']['基本信息>停车位']}</td>
            </tr>
            <tr>
                <td  style="height: 20px;width:80px;"><b>人数上限：</b></td>
                <td>{$data['attr']['基本信息>人数上限']}</td>
            </tr>
            <tr>
                <td  style="height: 20px;width:80px;"><b>面积：</b></td>
                <td>{$data['attr']['基本信息>面积']}</td>
            </tr>
            <tr>
                <td  style="height: 20px;width:80px;"><b>适合活动类型：</b></td>
                <td>{$data['attr']['基本信息>适合活动类型']}</td>
            </tr>
            <tr>
                <td  style="height: 20px;width:80px;"><b>餐饮配套：</b></td>
                <td>{$data['attr']['基本信息>餐饮配套']}</td>
            </tr>
        </table>
    </div>
    <div>
        <h3>空间介绍</h3>
        <p>{$data['des']}</p>
    </div>

    {if $data['media']}
    <div>
        <h3>产品图片</h3>
        <div>
            {foreach $data['media'] as $k=>$v}

                    <div>
                        <img width="680px" src="http://{Core::$urls['host']}{Data_Config_Site::displayMedia($v['path'],768,0,0)}">
                    </div>

            {/foreach}
        </div>
    </div>
    {/if}
    <div>
        <h3>活动案例</h3>

        {foreach $caseData as $key=>$data}
        <div>
            <div>活动名称：{$data['case_name']}</div>
            <div>活动简介：{$data['case_name']}</div>
            <div>活动图片：</div>
            {foreach $data['media'][1] as $k=>$v}
                   <div>
                        <img width="680px" src="http://{Core::$urls['host']}{Data_Config_Site::displayMedia($v['path'],768,0,0)}">
                    </div>
            {/foreach}
        </div>
        {/foreach}
    </div>

</div>