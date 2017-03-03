<!DOCTYPE html>
<!--[if IE 8]>
<html lang="en" class="ie8 no-js"> <![endif]-->
<!--[if IE 9]>
<html lang="en" class="ie9 no-js"> <![endif]-->
<!--[if !IE]><!-->
<html lang="en" class="no-js">
<!--<![endif]-->
<!-- BEGIN HEAD -->
<head>
    <title>{$title}</title>
    <meta content="" name="description"/>
    {include "Admin::inc/html_head.tpl"}
</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->

<body style="background:#FaFaFa !important">
<div class="portlet">
    <div class="portlet-title">
        <div class="caption">
            <i class="fa fa-database"></i>竞标详情
        </div>
    </div>
    <div class="portlet-body">

        <div class="container-fluid">
            <div class="row">
                <table class="table table-hover" style="border:0px;">

                    <tbody>
                    <tr>
                        <td>更新时间：</td>
                        <td>{Date('Y-m-d H:i:s',$data['create_time'])}</td>
                    </tr>
                    <tr>
                        <td>需求ID：</td>
                        <td>{$data['demand_id']}</td>
                    </tr>
                    <tr>
                        <td>需求名称：</td>
                        <td>{$data['demand_name']}</td>
                    </tr>
                    <tr>
                        <td>联系电话：</td>
                        <td>{$data['phone']}</td>
                    </tr>
                    <tr>
                        <td>活动城市：</td>
                        <td>{$data['city']}</td>
                    </tr>
                   {* <tr>
                        <td>方案：</td>
                        <td>{foreach $_data as $k=>$V}
                                {foreach json_decode($v['scheme']) as $key => $val}
                                    <p>{$k}：{$v}</p>
                                {/foreach}
                            {/foreach}
                        </td>
                    </tr>*}

                    <tr>
                        <td>供应商手机号：</td>
                        <td>{foreach json_decode($data['phones']) as $k => $v}
                                <p>{$v}</p>
                            {/foreach}</td>

                    </tr>
                    <tr>
                        <td>需求类型：</td>
                        <td>{{$data['demand_type']}}</td>
                    </tr>
                    <tr>
                        <td>发送总数：</td>
                        <td>{$data['send_total_num']}</td>
                    </tr>


                  {*  <tr>
                        <td>匹配产品：</td>
                        <td>
                            *}{*<p>{$data['product_sum']}次</p>*}{*
                            {foreach json_decode($data['product_ids']) as $key =>$val}
                                <p style="color: #00ff00">&nbsp;&nbsp;第{$key}次
                                    {foreach $val as $k =>$v}
                                        <span style="color: #0000cc">&nbsp;&nbsp;&nbsp;&nbsp;{$k}:</span>
                                        <a href="{$_root}service_info/{md5($v)}/{$v}.html"
                                           style="text-decoration: none" target="_blank">{$v}</span></a>
                                    {/foreach}
                                </p>
                            {/foreach}
                        </td>
                    </tr>
                    <tr>
                        <td>匹配供应商：</td>
                        <td>

                            {foreach $vendor_id as $k =>$v}
                                <p style="color: #00ff00">&nbsp;&nbsp;第{$k}次
                                    {foreach $v as $ken => $value}
                                        {foreach $vendor as $key => $val}
                                            {if $value == $val['id']}
                                                {$ken}:
                                                <span style="background-color: #c7ddef;color: #0e0e0e">id :{$value}</span>
                                                <span style="background-color: #c7ddef;color: #0e0e0e">名称：{$val['vendor_name']}</span>
                                               *}{* <span style="background-color: #c7ddef;color: #0e0e0e">地址：{$val['addr']}</span>*}{*
                                                *}{*<span style="background-color: #c7ddef;color: #0e0e0e">联系人：{$val['contacts']}</span>*}{*
                                                *}{* <span style="background-color: #c7ddef;color: #0e0e0e">介绍：{$val['des']}</span>*}{*

                                            {/if}

                                        {/foreach}
                                    {/foreach}
                                </p>
                            {/foreach}


                        </td>

                    </tr>*}
                    <tr>
                        <td>方案总数：</td>
                        <td>
                           {$data['scheme_sum']}

                        </td>
                    </tr>


                       {* <tr>
                            <td>价格：</td>

                            <td>{foreach $_data as $k=>$V}{$v['quote']}{/foreach}</td>
                        </tr>
*}
                    </tbody>

                </table>
            </div>
        </div>

    </div>
    {include "OA_Static::demands_tender/inc/demand_scheme.tpl"}
    {include "OA_Static::demands_tender/inc/demand_product.tpl"}



</body>
<!-- END BODY -->
</html>