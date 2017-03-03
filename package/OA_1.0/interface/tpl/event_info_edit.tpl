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
    <link rel="stylesheet" href="plugins/bootstrap-datetimepicker/bootstrap-datetimepicker.min.css"/>
    <script src="{$_assets}plugins/jquery-1.11.0.min.js" type="text/javascript"></script>
</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->
<body style="background:#FaFaFa !important">


<div class="portlet tabbable">
<div class="portlet-title">
    <div class="caption">
        <i class="fa fa-database"></i>{$_table['name']}
    </div>
</div>
<div class="portlet-body form">
<form class="form-horizontal" role="form" action="{$route}?action=update" method="post" enctype="multipart/form-data">


<div class="tabbable tabbable-custom boxless" style="padding: 20px ;">
    <ul class="nav nav-tabs">
        <li class="active">
            <a href="form_image_crop.html#tab_1" data-toggle="tab">产品信息</a>
        </li>
        <li>
            <a href="form_image_crop.html#tab_2" data-toggle="tab">相关图片/文档</a>
        </li>
    </ul>
    <div class="tab-content">
        <div class="tab-pane active" id="tab_1">

            <div class="form-body">
                <div class="form-group" style="display: none">
                    <label class="col-md-3 control-label">活动ID</label>

                    <div class="col-md-6 col-sm-12">
                        <input type="text" class="form-control" placeholder="Title" name="id" value="{$_data[0]['id']}" id="event_id">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-3 control-label">活动标题</label>
                    <div class="col-md-6 col-sm-12">
                        <input type="text" class="form-control" placeholder="Title" name="event_name" value="{$_data[0]['event_name']}">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-3 control-label">活动时间</label>
                    <div class="col-md-6 col-sm-12">
                        <div class='input-group date' id='datetimepicker1'>
                            <input type='text'  id='datetimepicker_input1' class="form-control" placeholder="请选择时间" name="event_time" value="{$_data[0]['event_time']}"/>
                        <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span>
                            </span>
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-3 control-label">活动地址</label>
                    <div class="col-md-6 col-sm-12" style="z-index:8888">
                        <div id="l-map"></div>
                        <input type="text" class="form-control" placeholder="请填写活动地址" name="addr"  id="suggestId" value="{$_data[0]['addr']}">
                    </div>
                </div>


                <div class="form-group">
                    <label class="col-md-3 control-label">活动属性</label>
                    <style>
                        .input-group {
                            margin-bottom: 2px;
                        }
                    </style>
                    <div class="col-md-6 col-sm-12" id="product_attr" >

                            <div class="input-group">
                                <span class="input-group-addon">类型 </span>
                                <input type="text" class="form-control select2 tags_type" name="attr[类型]" data-name="" data-values="{foreach $type as $k=>$v}{implode(',',$v['category'])}{/foreach}" value="{$_data[0]['attr']['类型']}" style="z-index:0"/>
                            </div>
                        <div class="input-group">
                            <span class="input-group-addon">品牌</span>
                            <input type="text" class="form-control select2 tags_brand"  name="attr[品牌]"  data-name="''" data-values="{$_data[0]['attr']['品牌']}" value="{$_data[0]['attr']['品牌']}" style="z-index:0"/>
                        </div>

                        <div class="input-group">

                            <span class="input-group-addon">城市 </span>
                            <input type="text" class="form-control tags_city" name="attr[城市]" value="{$_data[0]['attr']['城市']}" data-values="{implode(',',$city)}" style="z-index:0">
                        </div>

                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-md-3">活动介绍</label>

                    <div class="col-md-9">
                        {*<textarea class="wysihtml5 form-control" rows="8" name="des">{$_data[0]['des']}</textarea>*}
                        {include "Admin::inc/html_umeditor.tpl" name="des" value=$_data[0]['des'] height=200}
                    </div>
                </div>
                {*<div class="form-group">*}
                    {*<label class="control-label col-md-3">补充备注</label>*}

                    {*<div class="col-md-9">*}
                        {*<textarea class=" form-control" rows="8" name="data[memo]">{$_data['memo']}</textarea>*}
                    {*</div>*}
                {*</div>*}
            </div>

        </div>
        <div class="tab-pane" id="tab_2">
            {include file="Admin::inc/plupload.tpl"}
            <script>
                uploader.onFileUploaded = function (file, path) {
                    UploadFiles.add(file, path);
                }
                var UploadFiles = {
                    media_id: 0,
                    add: function (file, path) {
                        if (UploadFiles.media_id < 1) {
                            UploadFiles.media_id = $('#upload_files tr').size() + 10;
                        }
                        UploadFiles.media_id++;
                        var newFile = $('#upload_files').parents('table').find('.hidden').clone().removeClass('hidden');
                        newFile.find('img').attr('src', path);
                        newFile.appendTo('#upload_files');
                        newFile.find('input').each(function () {
                            $(this).attr('name', $(this).attr('name').replace('$$', UploadFiles.media_id));
                        });
                        newFile.find('input:eq(0)').val(path);
                        newFile.find('input:eq(1)').val(file.name);
                        newFile.find('input:eq(2)').select2({
                            tags: UploadFiles.tags.split(',')
                        });
                    },
                    remove: function (o) {
                        $(o).parents('tr').remove();
                    },
                    up: function (o) {
                        var tr = $(o).parents('tr');
                        tr.after(tr.prev());
                    },
                    down: function (o) {
                        var tr = $(o).parents('tr');
                        tr.before(tr.next());
                    },
                    tags: '@主图,外景图片,内景图片,平面图,视频'
                };
            </script>
            <style>
                .table td {
                    text-align: center !important;
                    vertical-align: middle !important;
                }

                .table .thumbnail {
                    margin-bottom: 0;
                }

                .table td img {
                    border-radius: 4px;
                }

                .table .btns i {
                    cursor: pointer;
                }
            </style>
            <table class="table table-hover">
                <thead>
                <tr>
                    <th width="80">缩略图</th>
                    <th>名称</th>
                    <th width="50%">标签</th>
                    <th width="60">操作</th>
                </tr>
                <tr class="hidden">
                    <td>
                        <img src="" style="height: 80px; width: 80px; display: block;">
                    </td>
                    <td>
                        <input type="hidden" name="data[media][$$][path]">
                        <input class="form-control" type="text" name="data[media][$$][name]">
                    </td>
                    <td>
                        <input class="form-control select2" type="text" name="data[media][$$][tags]">
                        <input class="form-control" type="text" name="data[media][$$][video]">
                    </td>
                    <td class="btns">
                        <i class="fa fa-long-arrow-up" onclick="UploadFiles.up(this)"></i>
                        <i class="fa fa-long-arrow-down" onclick="UploadFiles.down(this)"></i>
                        <i class="fa fa-trash-o" onclick="UploadFiles.remove(this)"></i>
                    </td>
                </tr>
                </thead>
                <tbody id="upload_files">
                {foreach $_data[0]['media'] as $k=>$v}
                    <tr>
                        <td>
                            <img src="{$v['path']}" style="height: 80px; width: 80px; ">
                        </td>
                        <td>
                            <input type="hidden" name="data[media][{$k}][path]" value="{$v['path']}">
                            <input class="form-control img_name" type="text" name="data[media][{$k}][name]" value="{$v['name']}" >
                        </td>
                        <td>
                            <input class="form-control select2 tags_select3" type="text" name="data[media][{$k}][tags]" value="{$v['tags']}">
                            <input class="form-control" type="text" name="data[media][{$k}][video]" value="{$v['video']}">
                        </td>
                        <td class="btns">
                            <i class="fa fa-long-arrow-up" onclick="UploadFiles.up(this)"></i>
                            <i class="fa fa-long-arrow-down" onclick="UploadFiles.down(this)"></i>
                            <i class="fa fa-trash-o" onclick="UploadFiles.remove(this)"></i>
                        </td>
                    </tr>
                {/foreach}
                </tbody>
            </table>
        </div>
    </div>
</div>
<div class="form-actions text-center">
    <button type="reset" class="btn btn-default">
        重置
    </button>
    <button type="submit" class="btn btn-success">
        提交
    </button>
</div>
</form>
</div>

<!-- BEGIN JAVASCRIPTS(Load javascripts at bottom, this will reduce page load time) -->
<!-- BEGIN CORE PLUGINS -->
<script src="{$_assets}plugins/jquery-migrate-1.2.1.min.js" type="text/javascript"></script>
<!-- IMPORTANT! Load jquery-ui-1.10.3.custom.min.js before bootstrap.min.js to fix bootstrap tooltip conflict with jquery ui tooltip -->
<script src="{$_assets}plugins/jquery-ui/jquery-ui-1.10.3.custom.min.js" type="text/javascript"></script>
<script src="{$_assets}plugins/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
<script src="{$_assets}plugins/bootstrap-hover-dropdown/bootstrap-hover-dropdown.min.js"
        type="text/javascript"></script>
<script src="{$_assets}plugins/jquery-slimscroll/jquery.slimscroll.min.js" type="text/javascript"></script>
<script src="{$_assets}plugins/jquery.blockui.min.js" type="text/javascript"></script>
<script src="{$_assets}plugins/uniform/jquery.uniform.min.js" type="text/javascript"></script>
<!-- END CORE PLUGINS -->
<!-- BEGIN PAGE LEVEL PLUGINS -->
<link rel="stylesheet" type="text/css" href="{$_assets}plugins/jquery-tags-input/jquery.tagsinput.css"/>
<link rel="stylesheet" type="text/css" href="{$_assets}plugins/typeahead/typeahead.css">
<link rel="stylesheet" type="text/css" href="{$_assets}plugins/bootstrap-wysihtml5/bootstrap-wysihtml5.css"/>
{*<link rel="stylesheet" type="text/css" href="{$_assets}plugins/select2/select2.css"/>*}
<script type="text/javascript" src="{$_assets}plugins/select2/select2.min.js"></script>
<script type="text/javascript" src="{$_assets}plugins/jquery-tags-input/jquery.tagsinput.min.js"></script>
<script src="{$_assets}plugins/typeahead/handlebars.min.js" type="text/javascript"></script>
<script src="{$_assets}plugins/typeahead/typeahead.bundle.min.js" type="text/javascript"></script>
<script type="text/javascript" src="{$_assets}plugins/datatables/media/js/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="{$_assets}plugins/datatables/plugins/bootstrap/dataTables.bootstrap.js"></script>
<script type="text/javascript" src="{$_assets}plugins/bootstrap-wysihtml5/wysihtml5-0.3.0.js"></script>
<script type="text/javascript" src="{$_assets}plugins/bootstrap-wysihtml5/bootstrap-wysihtml5.js"></script>
<script type="text/javascript" src="{$_assets}plugins/moment.min.js"></script>
<script type="text/javascript" src="js/moment.min.js"></script>
<script type="text/javascript" src="js/zh-cn.js"></script>
<script type="text/javascript" src="js/jquery.lazyload.js"></script>
<script type="text/javascript" src="js/bootstrap-datetimepicker.min.js"></script>
<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=aaNCRRcGGai6klHMOGZ8yBbP"></script>
<!-- END PAGE LEVEL PLUGINS -->
<!-- BEGIN PAGE LEVEL SCRIPTS -->
<script src="{$_assets}scripts/app.js"></script>
<script src="{$_assets}scripts/_page.js"></script>
<script>
    $(function() {
//        $('.form_datetime').datetimepicker({
//            //language:  'fr',
//            weekStart: 1,
//            todayBtn:  1,
//            autoclose: 1,
//            todayHighlight: 1,
//            startView: 2,
//            forceParse: 0,
//            showMeridian: 1
//        });
        $('#datetimepicker1').datetimepicker({
            format: 'YYYY-MM-DD HH',
            locale: 'zh-cn'
        });
        $('#datetimepicker_input1').datetimepicker({
            format: 'YYYY-MM-DD HH',
            locale: 'zh-cn'
        });
    })
</script>
<script>
    jQuery(document).ready(function () {
        App.init();
        var id=$(":input[name='event_id']").val()
        $('.tags').tagsInput({
            width: 'auto'
        });
        $(".tags_type").each(function () {
            $(this).select2({
                tags: $(this).data('values').split(',')
            })
        });
        $(".tags_city").each(function () {
            $(this).select2({
                tags: $(this).data('values').split(',')
            })
        });
        $(".tags_brand").each(function () {
            $(this).select2({
                tags: $(this).data('values').split(',')
            })
        });
        $(".tags_img").each(function () {
            $(this).select2({
                tags: $(this).data('values').split(',')
            })
        });



    $("#select2_sample6").select2({
            placeholder: "选择供应商",
            minimumInputLength: 1,
            ajax: { // instead of writing the function to execute the request we use Select2's convenient helper
                url: "{$_route}list?vendor_auto_complete=1",
                dataType: 'json',
                data: function (term, page) {
                    return {
                        q: term, // search term
                        page_limit: 10
                    };
                },
                results: function (data, page) { // parse the results into the format expected by Select2.
                    // since we are using custom formatting functions we do not need to alter remote JSON data
                    return {
                        results: data.items
                    };
                }
            },
            initSelection: function (element, callback) {
                var id = $(element).val();
                if (id !== "") {
                    $.ajax("{$_route}list?vendor_auto_complete=1", {
                        data: {
                            id: id
                        },
                        dataType: "json"
                    }).done(function (data) {
                        console.log(data);
                        callback(data.items[0]);
                    });
                }
            },
            formatResult: formatRepo, // omitted for brevity, see the source of this page
            formatSelection: formatRepoSelection, // omitted for brevity, see the source of this page
            escapeMarkup: function (m) {
                return m;
            } // we do not want to escape markup since we are displaying html in results
        });
        $(".tags_select3").each(function () {
            $(this).select2({
                tags: UploadFiles.tags.split(',')
            })
        });
        {foreach $_data['attr'] as $k=>$v}
        $('#product_attr').data('{$k}', '{$v}');
        {/foreach}
        $('.wysihtml5').wysihtml5();
    });

    function formatRepo(repo) {
        if (repo.loading) return repo.text;
        return repo.full_name;
    }

    function formatRepoSelection(repo) {
        return repo.full_name || repo.text;
    }
</script>
<script type="text/javascript">

    // 百度地图API功能
    function G(id) {
        return document.getElementById(id);
    }

    var map = new BMap.Map("l-map");
    map.centerAndZoom("北京",12);                   // 初始化地图,设置城市和地图级别。

    var ac = new BMap.Autocomplete({    //建立一个自动完成的对象
             "input" : "suggestId"
            ,"location" : map
        });

    ac.addEventListener("onhighlight", function(e) {  //鼠标放在下拉列表上的事件
        var str = "";
        var _value = e.fromitem.value;
        var value = "";
        if (e.fromitem.index > -1) {
            value = _value.province +  _value.city +  _value.district +  _value.street +  _value.business;
        }
        str = "FromItem<br />index = " + e.fromitem.index + "<br />value = " + value;

        value = "";
        if (e.toitem.index > -1) {
            _value = e.toitem.value;
            value = _value.province +  _value.city +  _value.district +  _value.street +  _value.business;
        }
        str += "<br />ToItem<br />index = " + e.toitem.index + "<br />value = " + value;


        G("searchResultPanel").innerHTML = str;
    });

    var myValue;
    ac.addEventListener("onconfirm", function(e) {    //鼠标点击下拉列表后的事件
        var _value = e.item.value;
        myValue = _value.province +  _value.city +  _value.district +  _value.street +  _value.business;
        G("searchResultPanel").innerHTML ="onconfirm<br />index = " + e.item.index + "<br />myValue = " + myValue;

        setPlace();
    });

    function setPlace(){
        map.clearOverlays();    //清除地图上所有覆盖物
        function myFun(){
            var pp = local.getResults().getPoi(0).point;    //获取第一个智能搜索的结果
            map.centerAndZoom(pp, 18);
            map.addOverlay(new BMap.Marker(pp));    //添加标注
        }
        var local = new BMap.LocalSearch(map, { //智能搜索
            onSearchComplete: myFun
        });
        local.search(myValue);
    }
    $(".tags_select3").each(function () {
        $(this).select2({
            tags: UploadFiles.tags.split(',')
        })
    });
</script>
</body>

<!-- END BODY -->
</html>