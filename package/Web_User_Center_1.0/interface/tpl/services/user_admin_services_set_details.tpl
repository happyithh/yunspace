<!DOCTYPE html>
<!--[if IE 8]>
<html lang="en" class="ie8 no-js"> <![endif]-->
<!--[if IE 9]>
<html lang="en" class="ie9 no-js"> <![endif]-->
<!--[if !IE]><!-->
<html lang="en" class="no-js">
<!--<![endif]-->
<head>
    {include 'inc/html_head.tpl'}
</head>
<body>
{include 'inc/header_top.tpl'}
<div class="clearfix"></div>
<div class="page-container">
{include 'inc/header_purchase_nav.tpl' index=2}

<div class="page-content-wrapper">

<div class="page-content" style="min-height: 973px">
<h3 class="page-title">云服务-顾问推荐</h3>
<div class="portlet">
    <div class="portlet-body util-btn-margin-bottom-5" style="height:90px;border-bottom:1px solid #e4e4e4">
        <form action="?action=detail&demand_id={$_REQUEST['demand_id']}&recommend_type=set" method="post" claassetss="pull-right">
            <div class="btn-group pull-left" style="margin-right: 10px;">
                <select class="form-control input-small select2me pull-left" name="category_id">
                    <option {if $_REQUEST['category']==''} selected{/if} value="">全部</option>
                    {foreach $_categories as $k=>$v}
                        <option {if $_REQUEST['category_id']==$k} selected{/if} value="{$k}">{$v}</option>
                    {/foreach}
                </select>
            </div>
            <div class="input-group input-medium">
                <input type="text" name="set_name" value="{$_REQUEST['set_name']}" class="form-control" placeholder="请输入套餐名称">
                <span class="input-group-btn">
                    <button class="btn btn-info" type="submit">
                        <span class="glyphicon glyphicon-search"></span>
                    </button>
                </span>
            </div>
        </form>
    </div>
    <div class="table-responsive" style="border:0px;">
        <table class="table table-hover" style="border:0px;">
            <tbody>
            {if $data['demand_recommend_demo']}
                <tr background="#EEEEEE">
                    <td colspan="3">
                        <h5><strong>推荐详情</strong></h5>
                    </td>
                </tr>
                {foreach $data['demand_recommend_demo'] as $dk=>$dv}
                    <tr>
                        <td colspan="3">
                            <textarea class="form-control" rows="5" disabled>{$dv['demo']}</textarea>
                        </td>
                    </tr>
                {/foreach}
            {/if}
            {if $data['demand_recommend_set']}
                <tr  class="portlet-title">
                    <td colspan="3">
                        <h5><strong>推荐套餐列表</strong></h5>
                    </td>
                </tr>
                {foreach $data['demand_recommend_set']['rows'] as $k=>$v}
                <tr>
                    <td width="270px">
                        <div>
                            <a href="{$_root}set_info/{$v['id']}.html" target="_blank">
                                {if $v['logo']}
                                    <img src="{Data_Config_Site::displayMedia($v['logo'],264)}" style="width:100%;height:100%;max-width: 264px;">
                                {else}
                                    <img src="images/vendor.jpg" style="width:100%;height:100%;max-width: 264px;">
                                {/if}
                            </a>
                        </div>
                        <div>
                            <i class="fa fa-calendar"></i>
                            <span>{date('Y-m-d H:i:s',$v['create_time'])}</span>
                        </div>
                    </td>
                    <td>
                        <div>
                            <h3>
                                <a target="_blank" href="{$_root}set_info/{$v['id']}.html">{$v['set_name']}</a>
                            </h3>
                            <p>
                                地址：{$v['addr']}<br />
                                {if $v['detail']['市场价']}
                                    市场价：￥{$v['detail']['市场价']}<br />
                                {/if}
                                {if $v['detail']['套餐价']}
                                    套餐价：￥{$v['detail']['套餐价']}<br />
                                {/if}
                                套餐类型：{$v['category_name']}<br />
                                {if $v['attr_index']['天数']}
                                    天数：{$v['attr_index']['天数']}<br />
                                {/if}
                                {if $v['attr_index']['开始时间']}
                                    有效期：{$v['attr_index']['开始时间']} 至 {$v['attr_index']['结束时间']}<br />
                                {/if}
                            </p>
                        </div>
                    </td>
                    <td width="300px">
                        <div class="pull-right" style="text-align: center;  width: 232px;background: #EEEEEE;padding: 10px;padding-bottom: 20px;margin-right: 15px;">
                            <p style="  color: #8B8B41;font-size: 30px;text-align: center;line-height: 56px;"><b>推荐理由</b></p>
                            <p>{$v['demo']}</p>
                        </div>
                        <div class="pull-right" style="text-align: center;  width: 232px;margin-top: 20px;">
                            <a target="_blank" class="btn btn-info" href="?action=pdf_set&set_id={$v['id']}">导出PDF</a>
                        </div>
                    </td>
                </tr>
            {/foreach}
            {/if}
            </tbody>
        </table>
        {if $data['demand_recommend_product']['rows']}
            <div style="text-align: center;">
                <ul class="pagination">
                    {if $data['demand_recommend_product']['page']['dpll']}
                        <li class="prev">
                            <a href="{$data['demand_recommend_product']['page']['dup']}1" title="First"><i class="fa fa-angle-double-left"></i></a>
                        </li>
                        <li class="prev">
                            <a href="{$data['demand_recommend_product']['page']['dup']}{$data['demand_recommend_product']['page']['dp']-1}" title="Prev"><i class="fa fa-angle-left"></i></a>
                        </li>
                    {else}
                        <li class="prev disabled">
                            <a href="#" title="First"><i class="fa fa-angle-double-left"></i></a>
                        </li>
                        <li class="prev disabled">
                            <a href="#" title="Prev"><i class="fa fa-angle-left"></i></a>
                        </li>
                    {/if}
                    {for $i=$data['demand_recommend_product']['page']['dpl'] to $data['page']['dpr']}
                        <li{if $i==$data['demand_recommend_product']['page']['dp']} class="active"{/if}>
                            <a href="{$data['demand_recommend_product']['page']['dup']}{$i}">{$i}</a>
                        </li>
                    {/for}
                    <li class="disabled">
                        <a> {$data['demand_recommend_product']['page']['dtp']} ( {$data['demand_recommend_product']['page']['dp']*$data['demand_recommend_product']['page']['dn']}/{$data['demand_recommend_product']['page']['dt']} )</a></li>

                    {if $data['page']['dprr']}
                        <li class="next">
                            <a href="{$data['demand_recommend_product']['page']['dup']}{$data['page']['dp']+1}" title="Next"><i class="fa fa-angle-right"></i></a>
                        </li>
                        <li class="next">
                            <a href="{$data['demand_recommend_product']['page']['dup']}{$data['page']['dtp']}" title="Last"><i class="fa fa-angle-double-right"></i></a>
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
        {/if}
    </div>
<!-- END PAGE CONTENT-->
</div>
</div>

</div>
</div>
{include 'inc/footer_inbox.tpl'}
{include 'inc/footer_script.tpl'}

</body>
</html>