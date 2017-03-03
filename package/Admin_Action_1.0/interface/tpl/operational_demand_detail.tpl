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
    <link href="style/css.css" rel="stylesheet"/>
</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->
<style>
    td{ word-break: break-all;}
</style>

<body style="background:#FaFaFa !important">
<div class="portlet">
    <div class="portlet-title">
        <div class="caption">
            <i class="fa fa-database"></i>需求详情
        </div>
    </div>
    <div class="portlet-body">
       <div class="container-fluid">
           <div class="row">
               <table class="table table-hover" style="border:0px;">
                   <tbody>
                       <tr>
                           <td>更新时间：</td>
                           <td>{Date('Y-m-d H:i:s',$_demand['create_time'])}</td>
                       </tr>
                       <tr>
                           <td>联系人：</td>
                           <td>{if $_demand['username']}{$_demand['username']}{else}{$_demand['demand_name']}{/if}</td>
                       </tr>
                       <tr>
                           <td>联系电话：</td>
                           <td>{$_demand['phone']}</td>
                       </tr>
                       <tr>
                           <td>活动城市：</td>
                           <td>{$_demand['city']}</td>
                       </tr>
                       {if $_demand['demand_type']=='供应商加盟'}
                       <tr>
                           <td>公司名称：</td>
                           <td>{$_demand['demand']['公司名称']}</td>
                       </tr>
                       <tr>
                           <td>办公电话：</td>
                           <td>{$_demand['demand']['办公电话']}</td>
                       </tr>
                       {/if}
                       <tr>
                           <td>需求类型：</td>
                           <td>{{$_demand['demand_type']}}</td>
                       </tr>
                       <tr>
                           <td>业务类型：</td>
                           <td>{if $_demand['demand']['业务类型']}{$_demand['demand']['业务类型']}{else}{$_demand['demand']['活动类型']}{/if}</td>
                       </tr>

                       <tr>
                           <td>具体要求：</td>
                           <td>
                               {if $_demand['demand']['product_id']}
                                <p><a target="_blank" href="{$_root}service_info/{$_demand['demand']['product_id']}.html">点此查看产品链接</a></p>
                               {/if}
                               {if $_demand['demand']['set_id']}
                                   <p><a target="_blank" href="{$_root}set_info/{$_demand['demand']['set_id']}.html">点此查看产品链接</a></p>
                               {/if}

                               {if $_demand['demand']['vendor_id']}
                                   <p><a target="_blank" href="{$_root}vendor_info/{$_demand['demand']['vendor_id']}.html">点此查看详情</a></p>
                               {/if}
                               <p>{$_demand['demand']['具体要求']}</p>
                           </td>
                       </tr>
                       <tr>
                           <td>其他信息</td>
                           <td>
                               {foreach $_demand['demand'] as $key=>$val}
                                   {if is_array($val)}
                                       <p>{$key}:</p>
                                       {foreach $val as $k=>$v}
                                           <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {$k}:&nbsp;&nbsp;&nbsp;{$v}</p>
                                       {/foreach}
                                   {else}
                                       <p>{$key}：&nbsp;&nbsp;&nbsp;{$val}</p>
                                   {/if}
                               {/foreach}

                           </td>
                       </tr>
                       {if $_demand['demand_status'] == 0}
                       <tr>
                           <td colspan="2" style="background: #EEEEEE">
                               <form  class="pull-right" action="?action=contacts" method="post">
                                   <input type="hidden" value="{$_demand['id']}" name="demand_id">
                                   <input type="hidden" value="{$_demand['account_id']}" name="account_id">
                                   <input type="hidden" value="{$_demand['phone']}" name="phone">
                                   <input type="hidden" value="{if $_demand['username']}{$_demand['username']}{else}{$_demand['demand_name']}{/if}" name="username">
                                   <input type="hidden" value="{$_demand['city']}" name="city">
                                   <input type="hidden" value="{$_demand['account_type']}" name="type">
                                   {if $_demand['demand_type']=='供应商加盟'}
                                       <input type="hidden" value="{$_demand['demand']['公司名称']}" name="company">
                                       <input type="hidden" value="{$_demand['demand']['联系人']}" name="username">
                                       <input type="hidden" value="{$_demand['demand']['业务类型']}" name="business">
                                       <input type="hidden" value="21" name="type">
                                   {/if}
                                   <button type="submit" class="btn btn-success">接受需求</button>
                                   <a class="btn btn-danger" href="?action=abandon&id={$_demand['id']}">放弃需求</a>
                               </form>
                           </td>
                       </tr>
                        {/if}
                   </tbody>
               </table>
       </div>
    </div>
</div>


</body>
<!-- BEGIN JAVASCRIPTS(Load javascripts at bottom, this will reduce page load time) -->
<!-- BEGIN CORE PLUGINS -->
<script src="{$_assets}plugins/jquery-1.11.0.min.js"
        type="text/javascript"></script>
<script src="{$_assets}plugins/jquery-migrate-1.2.1.min.js"
        type="text/javascript"></script>
<!-- IMPORTANT! Load jquery-ui-1.10.3.custom.min.js before bootstrap.min.js to fix bootstrap tooltip conflict with jquery ui tooltip -->
<script src="{$_assets}plugins/jquery-ui/jquery-ui-1.10.3.custom.min.js"
        type="text/javascript"></script>
<script src="{$_assets}plugins/bootstrap/js/bootstrap.min.js"
        type="text/javascript"></script>
<script src="{$_assets}plugins/bootstrap-hover-dropdown/bootstrap-hover-dropdown.min.js"
        type="text/javascript"></script>
<script src="{$_assets}plugins/jquery-slimscroll/jquery.slimscroll.min.js"
        type="text/javascript"></script>
<script src="{$_assets}plugins/jquery.blockui.min.js"
        type="text/javascript"></script>
<script src="{$_assets}plugins/uniform/jquery.uniform.min.js"
        type="text/javascript"></script>
<!-- END CORE PLUGINS -->
<!-- BEGIN PAGE LEVEL PLUGINS -->
<script type="text/javascript"
        src="{$_assets}plugins/select2/select2.min.js"></script>
<script type="text/javascript"
        src="{$_assets}plugins/datatables/media/js/jquery.dataTables.min.js"></script>
<script type="text/javascript"
        src="{$_assets}plugins/datatables/plugins/bootstrap/dataTables.bootstrap.js"></script>
<!-- END PAGE LEVEL PLUGINS -->
<!-- BEGIN PAGE LEVEL SCRIPTS -->
<script src="{$_assets}scripts/app.js"></script>
<script src="{$_assets}scripts/_page.js"></script>
<script>
    jQuery(document).ready(function () {
        App.init();
        TableManaged.init();
    });

</script>
</body>
<!-- END BODY -->
</html>