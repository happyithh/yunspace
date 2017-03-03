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
            <i class="fa fa-reorder"></i>套餐详情
        </div>
    </div>
    <div class="portlet-body">
        <table class="table table-striped table-bordered table-advance">
            <tbody>
            <tr>
                <td style="width: 20%;">
                    <div class="information_left">
                        套餐名称
                    </div>
                </td>
                <td>
                    <div class="hidden-xs" style="padding-left: 90px;">
                        {$data['set_name']}
                        {if $data['status']==1}
                            <a href="http://{Core::$urls['host']}/set_info/{$data['id']}.html" class="btn btn-info btn-xs" target="_blank"><i class="fa fa-link"></i>点此查看套餐链接</a>
                        {/if}
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="information_left">
                        所属供应商
                    </div>
                </td>
                <td>
                    <div class="hidden-xs" style="padding-left: 90px;">
                        {$data['vendor_name2']}
                        {if $data['vendor_id']}
                            <a href="http://{Core::$urls['host']}/vendor_info/{$data['vendor_id']}.html" class="btn btn-info btn-xs" target="_blank"><i class="fa fa-link"></i>点此查看供应商链接</a>
                        {/if}
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="information_left">
                        类别
                    </div>
                </td>
                <td>
                    <div class="hidden-xs" style="padding-left: 90px;">
                        {$category_name[$data['category_id']]}
                    </div>
                </td>
            </tr>
            <tr>
            <tr>
                <td>
                    <div class="information_left">
                        场地ID
                    </div>
                </td>
                <td>
                    <div class="hidden-xs" style="padding-left: 90px;">
                        {$data['schedule_product_id']}
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="information_left">
                        版本
                    </div>
                </td>

                <td>
                    <div class="hidden-xs" style="padding-left: 90px;">
                        {$data['version']}
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="information_left">
                        标签
                    </div>
                </td>
                <td>
                    <div class="hidden-xs" style="padding-left: 90px;">
                        {$data['attr_index']['标签']}
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="information_left">
                        人数
                    </div>
                </td>
                <td>
                    <div class="hidden-xs" style="padding-left: 90px;">
                        {$data['attr_index']['人数']}
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="information_left">
                        城市
                    </div>
                </td>
                <td>
                    <div class="hidden-xs" style="padding-left: 90px;">
                        {$data['attr_index']['城市']}
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="information_left">
                        小时数(整数)
                    </div>
                </td>
                <td>
                    <div class="hidden-xs" style="padding-left: 90px;">
                        {$data['hours']}
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="information_left">
                        天数（展示用）
                    </div>
                </td>
                <td>
                    <div class="hidden-xs" style="padding-left: 90px;">
                        {$data['attr_index']['天数']}
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="information_left">
                        地址
                    </div>
                </td>
                <td>
                    <div class="hidden-xs" style="padding-left: 90px;">
                        {$data['addr']}
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="information_left">
                        有效期
                    </div>
                </td>
                <td>
                    <div class="hidden-xs" style="padding-left: 90px;">
                        {$data['attr_index']['开始时间']} -- {$data['attr_index']['结束时间']}
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="information_left">
                        工作日
                    </div>
                </td>
                <td>
                    <div class="hidden-xs" style="padding-left: 90px;">
                        {if !$_data['attr_index']||$_data['attr_index']['工作日可选']}工作日可选{/if}
                         &nbsp;&nbsp;
                        {if $_data['attr_index']['节假日可选']}节假日可选{/if}
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="information_left">
                        市场价和套餐价
                    </div>
                </td>
                <td>
                    <div class="hidden-xs" style="padding-left: 90px;">
                        {if $data['detail']['市场价']}
                            市场价：￥{$data['detail']['市场价']}
                        {/if}
                        &nbsp;&nbsp;
                        {if $data['detail']['套餐价']}
                            套餐价：￥{$data['detail']['套餐价']}
                        {/if}
                    </div>
                </td>
            </tr>
            {if $data['detail']['计价单位']}
                <tr>
                    <td>
                        <div class="information_left">
                            计价单位
                        </div>
                    </td>
                    <td>
                        <div class="hidden-xs" style="padding-left: 90px;">{$data['detail']['计价单位']}</div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div class="information_left">
                            计价上限/下限
                        </div>
                    </td>
                    <td>
                        <div class="hidden-xs" style="padding-left: 90px;">{$data['detail']['计价上限']}{$data['detail']['计价单位']} ~ {$data['detail']['计价下限']}{$data['detail']['计价单位']}</div>
                    </td>
                </tr>
            {/if}
            <tr>
                <td>
                    <div class="information_left">
                        服务清单
                    </div>
                </td>
                <td>
                    <div class="hidden-xs" style="padding-left: 90px;">
                        {$data['detail']['清单']}
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="information_left">
                        套餐简介
                    </div>
                </td>
                <td>
                    <div class="hidden-xs" style="padding-left: 90px;">
                        {$data['des']}
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="information_left">
                        服务详情
                    </div>
                </td>
                <td>
                    <div class="hidden-xs" style="padding-left: 90px;">
                        {$data['detail_des']}
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="information_left">
                        相关图片/视频
                    </div>
                </td>
                <td>
                    <div class="hidden-xs" style="padding-left: 90px;">
                        {foreach $data['media'] as $k=>$v}
                            <p>
                                <c>缩略图
                                    ：
                                </c>
                                <img src="{$v['path']}" style="height: 120px; width: 120px; "></p>
                            <p>
                                <c>名称
                                    ：
                                </c>{$v['name']}</p>
                            <p>
                                <c>标签：
                                </c>{$v['tags']}</p>
                            {if !empty({$data['media'][$k+1]})}
                                <hr>
                            {else}
                            {/if}

                        {/foreach}
                    </div>
                </td>
            </tr>
            </tbody>
        </table>
    </div>
</div>
</body>
<!-- END BODY -->
</html>