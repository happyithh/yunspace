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
    <link href="style/media.css" rel="stylesheet"/>
    <link href="style/css.css" rel="stylesheet"/>
    {include "Admin::inc/html_head.tpl"}
    <link href="css/bootstrap-datetimepicker.min.css" rel="stylesheet"/>
    <script src="{$_assets}plugins/jquery-1.11.0.min.js"
            type="text/javascript"></script>
    <script src="{$_assets}plugins/bootstrap/js/bootstrap.min.js"
            tab="text/javascript"></script>
    <script src="{$_assets}scripts/_page.js"></script>
    <script type="text/javascript" src="js/moment.min.js"></script>
    <script type="text/javascript" src="js/zh-cn.js"></script>
    <script type="text/javascript" src="js/bootstrap-datetimepicker.min.js"></script>
    <script charset="utf-8" src="http://map.qq.com/api/js?v=2.exp"></script>
</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->

<body style="background:#FaFaFa !important">


<div class="portlet tabbable">
    <div class="portlet-title">
        <div class="caption">
            <i class="fa fa-search"></i>搜索条件
        </div>
    </div>
    <div class="portlet-body">
        <div class="portlet-tabs">
            <div class="clearfix"></div>
            <div>
                <form action="?" method="get" class="clearfix">
                    <input type="hidden" name="handle_type" value="{$_data['other']['handle_type']}">

                    <div class="form-body clearfix">
                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">申请人</label>

                            <div class="col-md-9">
                                <input type="text" class="form-control input-sm" placeholder="申请人名称"
                                       name="search[fullname]" value="{$_REQUEST['search']['fullname']}">
                            </div>
                        </div>
                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">申请时间</label>

                            <div class="col-md-4">
                                <input type='text' class="form-control date" placeholder="请选择开始时间"
                                       name="search[start_time]" value="{$_REQUEST['search']['start_time']}"/>
                            </div>
                            <div class="col-md-4 col-md-offset-1">
                                <input type='text' class="form-control date" placeholder="请选择结束时间"
                                       name="search[end_time]" value="{$_REQUEST['search']['end_time']}"/>
                            </div>
                        </div>
                    </div>
                    <div class="form-actions">
                        <div class="" style="text-align: center">
                            <button type="submit" class="btn btn-primary" style="width: 150px">
                                <i class="fa fa-search"></i>
                                搜索
                            </button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
{*<div class="portlet tent_map" style="display: none">*}
    {*<div id="container" class="col-md-5" style="width:50%; height:300px;float: left;padding: 10px 20px;"></div>*}
    {*<div class="alert  fade in map_poi_list col-md-5" style="width:300px;float: left;"></div>*}
    {*<div class="alert  fade in col-md-4" style="width:300px;">*}
        {*<p>*}
            {*<button class="btn btn-info" id="map_poi" data-lat="" data-lng="">查看周边地区</button>*}
            {*<button class="btn btn-danger" id="close_map" data-lat="" data-lng="">关闭地图</button>*}
        {*</p>*}
    {*</div>*}
{*</div>*}

<div class="portlet">
    <div class="portlet-title">
        <div class="caption">
            <i class="fa fa-comments"></i>
            公出签到列表
        </div>
    </div>
    <div class="portlet-body">
        <ul class="nav nav-tabs">
            <li {if $status=='all'}class="active"{/if}>
                <a href="?status=all">全部</a>
            </li>
            <li {if $status=='waiting'}class="active"{/if}>
                <a href="?status=waiting">待处理</a>
            </li>
            <li {if $status=='done'}class="active"{/if}>
                <a href="?status=done">待签到</a>
            </li>
            <li {if $status=='sign_done'}class="active"{/if}>
                <a href="?status=sign_done">已签到</a>
            </li>
            <li {if $status=='reject'}class="active"{/if}>
                <a href="?status=reject">审核拒绝</a>
            </li>
        </ul>
        <div class="table-responsive clearfix">
            <table class="table table-striped table-bordered table-hover" id="data_table" style="word-break: break-all">
                <thead>
                <tr>
                    <th>申请人</th>
                    <th>公出时间</th>
                    <th>返回时间</th>
                    <th>公出地址</th>
                    <th>公出事由</th>
                    <th>状态</th>
                    {*<th>供应商名称</th>*}
                    <th>申请时间</th>
                    {*<th>签到位置</th>*}
                    <th>签到时间</th>
                    <th>操作</th
                </tr>
                </thead>
                <tbody>
                {foreach $_data['rows'] as $k=>$v}
                    <tr>
                        <td>{$v['admin_fullname']} <span class="label label-sm label-success complete_check_s" {if $v['admin_status']==0}style="display: none" {/if}>已确认</span></td>
                        <td>{date('Y-m-d h:i',$v['outside_time'])}</td>
                        <td>{date('Y-m-d h:i',$v['back_time'])}</td>
                        <td>{$v['address']}</td>
                        <td>{$v['outside_reason']}</td>
                        <td class="list_size">
                            {if $v['status']==0}
                                待审核
                            {elseif $v['status']==1}
                             待签到
                            {elseif $v['status']==2}
                               已签到
                            {elseif $v['status']==-1}
                                已拒绝
                            {/if}
                        </td>
                        <td>{date('Y-m-d h:i',$v['create_time'])}</td>
                        {*<td class="list_size"> </td>*}
                        <td class="list_size">{if !empty($v['sign_time'])}{date('Y-m-d h:i',$v['sign_time'])}{/if}</td>
                        <td>
                            <button type="button" class="btn btn-info show_map" href="#tent_map" data-addr="{$v['address']}" data-toggle="modal" data-lat="{if $v['latitude']}{$v['latitude']}{/if}" data-lng="{if $v['longitude']}{$v['longitude']}{/if}">
                                查看签到位置
                            </button>
                            {if $v['admin_status']==0}
                            <button type="button" class="btn btn-success complete_check" data-id="{$v['id']}">
                                确认签到
                            </button>
                            {*{else}*}
                                {*<button type="button" class="btn btn-primary">*}
                                    {*已确认签到*}
                                {*</button>*}
                            {/if}

                    </tr>
                {/foreach}
                </tbody>
            </table>
            <div class="pull-left" style="width:30%; padding: 10px 0;">

            </div>
            <div class="pull-right">
                <ul class="pagination">
                    {if $_data['page']['dpll']}
                        <li class="prev">
                            <a href="{$_data['page']['dup']}1" title="First"><i class="fa fa-angle-double-left"></i></a>
                        </li>
                        <li class="prev">
                            <a href="{$_data['page']['dup']}{$_data['page']['dp']-1}" title="Prev"><i
                                        class="fa fa-angle-left"></i></a>
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
                            /{$_data['page']['dt']} )</a>
                    </li>

                    {if $_data['page']['dprr']}
                        <li class="next">
                            <a href="{$_data['page']['dup']}{$_data['page']['dp']+1}" title="Next"><i
                                        class="fa fa-angle-right"></i></a>
                        </li>
                        <li class="next">
                            <a href="{$_data['page']['dup']}{$_data['page']['dtp']}" title="Last"><i
                                        class="fa fa-angle-double-right"></i></a>
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
    </div>
</div>


<div class="modal fade" id="tent_map" tabindex="-1" role="basic" aria-hidden="true" style="display: none;">
    <div class="modal-dialog">
        <div class="modal-content" >
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                <h4 class="modal-title">签到位置</h4>
            </div>
            <div class="modal-body" style="height: 300px;">
                <div id="container" style="width:100%; height:100%;float: left;padding: 10px 20px;"></div>
            </div>
            <div class="modal-footer" style="text-align: left;padding: 5px 10px;">

            </div>
        </div>
    </div>
</div>
<script>
    $(document).ready(function () {

        $('.date').datetimepicker({
            format: 'YYYY-MM-DD',
            locale: 'zh-cn'
        });
        $('.select2_public_type').each(function(){
            $(this).select2({
                tags: $(this).data('values').split(',')
            })
        });

        $('.show_map').click(function(){
            var lat = $(this).attr('data-lat');
            var lng = $(this).attr('data-lng');
            var addr =$(this).attr('data-addr');
            if(!lat||!lng){
                alert('地理位置不存在，他的签到失败了！');
                return false;
            }else{

//                $('#map_poi').attr('data-lat',lat);
//                $('#map_poi').attr('data-lng',lng);
//                var marker = null;
                $('#tent_map').show();
                var citylocation,map,marker = null;
                var map = new qq.maps.Map(document.getElementById("container"), {
                    center: new qq.maps.LatLng(lat,lng),      // 地图的中心地理坐标。
                    zoom:16                                             // 地图的中心地理坐标。
                });
                var latLng = new qq.maps.LatLng(lat, lng);
                if (marker != null) {
                    marker.setMap(null);
                }
                //设置marker标记
                marker = new qq.maps.Marker({
                    map: map,
                    position: latLng,
                    zoom:16
                });
                $.post('http://{Core::$urls['host']}/static/api/sign/in/get/poi.jsonp', {
                    'lat':lat,
                    'lng':lng
                }, function (data) {
                    if (data.status==0) {
                        top.alert(data.msg);
                    } else {
                        var html_str='';
                        html_str +='<p style="margin: 5px 0 5px 20px;color: #31708f;">公出地址:'+addr+'</p>';
                        html_str +='<p style="margin: 5px 0 5px 20px;color: #3c763d;">签到位置：'+data.data.result.address+'<br />位置描述:'+data.data.result.formatted_addresses.recommend+'</p>';
                        $('.modal-footer').empty();
                        $('.modal-footer').append(html_str);
                    }
                },"json")
//                $.get('http://apis.map.qq.com/ws/geocoder/v1/?address=北京市海淀区彩和坊路海淀西大街74号&key=4L2BZ-R5BW4-7KLUH-XTW4L-X42TO-3EBKD&callback=?', '', function (data) {
//                    console.log(data);
////                    if (data.status==0) {
////                        top.alert(data.msg);
////                    } else {
////                        var html_str='';
////                        html_str +='<p class="alert alert-info">签到位置：'+data.data.result.address+'<br />位置描述:'+data.data.result.formatted_addresses.recommend+'</p>';
////                        $('.modal-footer').empty();
////                        $('.modal-footer').append(html_str);
////                    }
//                },"jsonp")
//                $.ajax({
//                    url:"http://apis.map.qq.com/ws/geocoder/v1/?address=北京市海淀区彩和坊路海淀西大街74号&key=4L2BZ-R5BW4-7KLUH-XTW4L-X42TO-3EBKD&callback=?",
//                    dataType:"jsonp",
//                    jsonpCallback:"person",
//                    success:function(data){
//                        alert(222,data.message);
//                        console.log(data);
////                        alert(data.name + " is a a" + data.sex);
//                    }
//                });
//                $.getJSON("http://apis.map.qq.com/ws/geocoder/v1/?address=北京市海淀区彩和坊路海淀西大街74号&key=4L2BZ-R5BW4-7KLUH-XTW4L-X42TO-3EBKD", function(json){
//                    alert("JSON Data: ");
//                    console.log(json);
//                });
//                $.getJSON("http://apis.map.qq.com/ws/geocoder/v1/?address=北京市海淀区彩和坊路海淀西大街74号&key=4L2BZ-R5BW4-7KLUH-XTW4L-X42TO-3EBKD&jsoncallback=?", function(data){
////                        $.each(data.items, function(i,item){
////                            $("<img/>").attr("src", item.media.m).appendTo("#images");
////                            if ( i == 3 ) return false;
////                        });
//                    console.log(data);
//            });
            }
        });
        $('.complete_check').click(function(){
            var sign_id = $(this).attr('data-id');
            var that = $(this);
            $.post('http://{Core::$urls['host']}/static/api/sign/in/update/status.jsonp', {
                'id':sign_id,
                'status':1
            }, function (data) {
                if (data.status==1) {
                    that.parent().parent().find('.complete_check_s').show();
                    that.remove();
                } else {
                    top.alert(data.msg);
                }
            },"json")
        })
    })
</script>
<!-- BEGIN JAVASCRIPTS(Load javascripts at bottom, this will reduce page load time) -->
<!-- BEGIN CORE PLUGINS -->


</body>
<!-- END BODY -->
</html>