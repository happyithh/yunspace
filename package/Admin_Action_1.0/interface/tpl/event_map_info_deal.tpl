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
    <style>
        .mask{ position: fixed; top: 0; left: 0; bottom: 0; right: 0; background-color: #868484; font-size: 20px;
            color: #fff;
            -webkit-box-pack:center;
            -moz-box-pack:center;
            -webkit-box-align:center;
            -moz-box-align:center;

            display: box;
            display: -webkit-box;
            display: -moz-box;
        }
        body .mask{ display: none;}
    </style>

</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->
<body style="background:#FaFaFa !important; position: relative">
<div class="portlet addrConList">
    <div class="portlet-title">
        <div class="caption">
            <i class="fa fa-globe"></i>未收录的公司地址
        </div>
    </div>
    {if $addr==0}
        <script>alert('无数据更新！！')</script>
        {else}
        {foreach $addr as $k=>$v}
            <div class="portlet-body addrCon">
                <span class="label label-danger" style="margin-right: 15px">产品名称:</span>  {$v['event_name']}
                <span class="label label-danger" style="margin:0 20px 0 30px">地址:</span>  {$v['addr']}
                <span class="label label-danger" style="margin:0 20px 0 30px">经纬度:</span> {$v['geo_lat']}，{$v['geo_lng']}
            </div>
        {/foreach}
    {/if}

</div>
<button class="btn btn-primary disabled" id="submitMapInfo" style="width: 250px;margin: auto; display: block">确认更新</button>
<div id="mask" class="mask">正在提交数据...</div>
</body>
<script src="http://libs.baidu.com/jquery/1.9.0/jquery.js"></script>
<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=aaNCRRcGGai6klHMOGZ8yBbP"></script>
<script>
   $(function(){
       window.location.href="{$route}";
   })
</script>
</html>