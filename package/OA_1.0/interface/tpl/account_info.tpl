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
    <link href="style/media.css" rel="stylesheet"/>
    <link href="css/bootstrap-datetimepicker.min.css" rel="stylesheet"/>
</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->

<body style="background:#FaFaFa !important">
<div class="portlet">
    <!--<div class="portlet-title">
        <div class="caption">
            <i class="fa fa-database"></i>账号列表 (当前共<a href="#"> {$_data['page']['dt']} </a>个注册账号)
        </div>
    </div>-->
    <div class="portlet-title" >
        <div class="caption">
            <i class="fa fa-database"></i>账号列表
        </div>
    </div>
    <form action="?" method="get">
        <input type="hidden" name="is_submit" value="1">
        <div  style="width: 150px;float: left;margin: 10px 10px 0 10px;">
            <select class="form-control input-sm" name="type">
                <option value="0" {if $_REQUEST['type']==0}selected="selected" {/if}>请选择搜索条件</option>
                <option value="1" {if $_REQUEST['type']==1}selected="selected" {/if}>用户名</option>
                <option value="2" {if $_REQUEST['type']==2}selected="selected" {/if}>真实姓名</option>
                <option value="3" {if $_REQUEST['type']==3}selected="selected" {/if}>电话</option>
                <option value="4" {if $_REQUEST['type']==4}selected="selected" {/if}>邮箱</option>
                <option value="5" {if $_REQUEST['type']==5}selected="selected" {/if}>ID</option>
            </select>
        </div>
        <div   style="width: 250px;float: left;margin: 10px 0px 0 0px;">
            <input type="text" class="form-control"  placeholder="用户名 /真实姓名 /电话 /邮箱 /来源(默认用户名)" name="serchtext" value="{$_REQUEST['serchtext']}">
        </div>
        <div  style="width: 300px;float: left;margin: 10px 10px 0 10px;">
            <label style="width: 100px;float: left;margin-top: 5px;margin-left: 10px;">注册来源：</label>
            <select style="width:150px;float: left;" class="form-control input-sm" name="source">
                <option value="" {if $_REQUEST['source']==""}selected="selected" {/if}>全部</option>
                <option value="1" {if $_REQUEST['source']==1}selected="selected" {/if}>用户注册</option>
                <option value="2" {if $_REQUEST['source']==2}selected="selected" {/if}>后台生成</option>
            </select>
        </div>
        <div   style="width: 365px;float: left;margin: 10px 10px 0 10px;">
            <span style="display: block;float: left;width: 80px;line-height: 30px;height: 30px;text-align: center;">注册时间段：</span>
            <div class="col-md-4 "  style="width: 130px;float: left;margin-left: 5px;padding: 0;">
                <input type='text' class="form-control date" placeholder="请选择开始时间" name="start_time" value="{$_REQUEST['start_time']}"/>
            </div>
            <div style="display: block;float: left;line-height: 30px;height: 30px;text-align: center;margin-left: 2px;">--</div>
            <div class="col-md-4 " style="width: 130px;float: left;margin-left: 5px;padding: 0;">
                <input type='text' class="form-control date" placeholder="请选择结束时间" name="end_time" value="{$_REQUEST['end_time']}"/>
            </div>
        </div>
        <div  style="width: 100px;float: left;margin: 10px 10px 0 10px;">
            <span style="display: block;width: 80px;line-height: 30px;height: 30px;text-align: center;font-size: 16px;">
                <input type="checkbox" name="account_type" value="1" {if $_REQUEST['account_type']==1}checked{/if} style="margin-right: 3px;"> 供应商</span>
        </div>
        <input class="btn btn-info" type="submit"  name="submit" value="搜索" style="margin-top: 7px"/>
    </form>
    <div class="portlet-body">
        <div class="tab-content clearfix">
            <div class="table-responsive">
                <table class="table table-striped table-bordered table-advance table-hover">
                    <thead>
                    <tr>
                        <th>#ID</th>
                        <th>用户名</th>
                        <th>真实姓名</th>
                        <th>电话</th>
                        <th class="list_none">Email</th>
                        <th class="list_none">注册时间</th>
                        <th>登陆次数</th>
                        <th>注册来源</th>
                    </tr>
                    </thead>
                    <tbody>
                    {foreach $_data['rows'] as $k=>$v}
                        <tr>
                            <td>{$v['id']}</td>

                            <td>{$v['username']}</td>
                            <td >{$v['fullname']}</td>
                            <td>{$v['phone']}</td>
                            <td class="list_none">{$v['email']}</td>
                            <td class="list_none">{Func_Time::format($v['register_time'])}</td>
                            <td>
                                {$v['login_times']}
                            </td>
                            <td>
                                {if !empty($v['adminuser'])}
                                    后台生成【{$v['adminuser']}】
                                {else}
                                  用户注册
                                {/if}
                            </td>
                        </tr>
                    {/foreach}
                    </tbody>
                </table>
            </div>
            <div class="container-fluid">
                <div class="row">
                    <div class="col-md-12" style="padding: 0px;">
                        <ul class="pagination" style="float: left">
                            {if $_data['page']['dpll']}
                                <li class="prev">
                                    <a href="{$_data['page']['dup']}1" title="First"><i class="fa fa-angle-double-left"></i></a>
                                </li>
                                <li class="prev">
                                    <a href="{$_data['page']['dup']}{$_waiting['page']['dp']-1}" title="Prev"><i class="fa fa-angle-left"></i></a>
                                </li>
                            {else}
                                <li class="prev disabled">
                                    <a href="#" title="First"><i class="fa fa-angle-double-left"></i></a>
                                </li>
                                <li class="prev disabled">
                                    <a href="#" title="Prev"><i class="fa fa-angle-left"></i></a>
                                </li>
                            {/if}
                            {for $i=$_data['page']['dpl'] to $_data['page']['dpr']}
                                <li{if $i==$_data['page']['dp']} class="active"{/if}>
                                    <a href="{$_data['page']['dup']}{$i}">{$i}</a>
                                </li>
                            {/for}
                            <li class="disabled">
                                <a> {$_data['page']['dtp']}
                                    ( {$_data['page']['dp']*$_data['page']['dn']}
                                    /{$_data['page']['dt']}
                                    )</a></li>

                            {if $_data['page']['dprr']}
                                <li class="next">
                                    <a href="{$_data['page']['dup']}{$_data['page']['dp']+1}" title="Next"><i class="fa fa-angle-right"></i></a>
                                </li>
                                <li class="next">
                                    <a href="{$_data['page']['dup']}{$_data['page']['dtp']}" title="Last"><i class="fa fa-angle-double-right"></i></a>
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
                        <div class="caption" style="float: left;margin-top: 15px;margin-left: 20px;font-size: 16px;">
                            <i class="fa fa-database"></i> (当前共<a href="#"> {$_data['page']['dt']} </a>个注册账号)
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="{$_assets}plugins/jquery-1.11.0.min.js"
        type="text/javascript"></script>
<script src="{$_assets}scripts/_page.js"></script>
<script type="text/javascript" src="js/moment.min.js"></script>
<script type="text/javascript" src="js/zh-cn.js"></script>
<script type="text/javascript" src="js/bootstrap-datetimepicker.min.js"></script>
<script>
    $(document).ready(function(){
        $('.date').datetimepicker({
            format: 'YYYY-MM-DD',
            locale: 'zh-cn'
        });
    })
</script>

</body>

<!-- END BODY -->
</html>