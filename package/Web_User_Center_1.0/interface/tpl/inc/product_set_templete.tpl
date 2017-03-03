<h1 align="center"><strong>《{$page->info['set_name']}》</strong></h1>
<div style="width:500px;">
    <p><strong>网址：</strong><span><a target="_blank"
                                    href="{Core::$urls['host']}/set_info/{$page->id}.html">点此更多精彩</a></span></p>

    <div>
        <h3>基本信息</h3>
        <table>
            <tr>
                <td style="height: 20px;width:80px;">标签：</td>
                <td> {foreach explode(',',$page->info['attr_index']['标签']) as $val}
                        {$val}&nbsp;,&nbsp;
                    {/foreach}
                </td>
            </tr>
            <tr>
                <td><b>城市：</b></td>
                <td>{$page->info['attr_index']['城市']}</td>
            </tr>
            <tr>
                <td><b>天数：</b></td>
                <td>{$page->info['attr_index']['天数']}</td>
            </tr>
            <tr>
                <td><b>类别：</b></td>
                <td>{$page->info['category_name']}</td>
            </tr>
            <tr>
                <td><b>有效期：</b></td>
                <td>   {if $page->info['attr_index']['开始时间']}
                        {$page->info['attr_index']['开始时间']}
                        至 {$page->info['attr_index']['结束时间']}
                    {else}
                        待定
                    {/if}
                </td>
            </tr>
            <tr>
                <td><b>人数：</b></td>
                <td>  {$page->info['attr_index']['人数']} </td>
            </tr>
            <tr>
                <td><b>地址：</b></td>
                <td> {$page->info['addr']} </td>
            </tr>
        </table>
        <table border="1" style="padding: 5px;">
            <tr>
                <td></td>
                {foreach $page->detail as $key => $val}
                    {if $key==1}
                        <td>配套服务</td>
                    {else}
                        <td>场地</td>
                    {/if}
                {/foreach}

                <td>折扣</td>
                <td>优惠价</td>
            </tr>
            {foreach $page->detail as $key => $val}
                <tr>
                    <td>{$val['名称']} </td>

                    <td>￥{$val['市场价']}</td>
                    <td>{$val['折扣']}&nbsp;折</td>
                    <td>￥{$val['价格']}&nbsp;</td>
                </tr>
            {/foreach}

        </table>
        <div>
            <div>
                套餐详情
            </div>
            <table border="1" style="padding:2px;width:100%;">
                <tr>
                    <th style="background-color: #f8f8f8;width: 30%;">
                        活动场地
                    </th>
                    <th style="background-color: #f8f8f8;width: 70%;"> {$page->space_info['product_name']}
                        <a href="{Core::$urls['host']}/service_info/{$page->info['schedule_product_id']}.html"> 查看详情</a></th>
                </tr>
                {foreach $page->space_info['tags'] as $vk=>$vv}
                    <tr>
                        <td>{$vk}</td>
                        <td>{foreach $vv as $vvk=>$vvv}
                                {if $page->space_info['attr_new'][$vvk]}
                                    <div>{$vvv['tags_name']}
                                        ：{$page->space_info['attr_new'][$vvk]}</div>
                                {/if}
                            {/foreach}</td>
                    </tr>
                {/foreach}
            </table>
            {if $page->space_info['des']}
                <span>
            服务描述
        </span>
                <div>
                    {$page->space_info['des']}}
                </div>
            {/if}
            <div></div>
            <span>配套详情</span>
            {$page->info['detail_des']}
        </div>
        <div>图片介绍</div>
        <div>

            {foreach $page->media as $mk=>$mv}
                {foreach $mv as $vv}
                    <img src="http://{Core::$urls['host']}{Page_Site_Global::displayMedia($vv[1],768,0,0)}"
                         width="768"/>
                {/foreach}
            {/foreach}
        </div>

        {include "Web::inc/product_set_process.tpl" }

