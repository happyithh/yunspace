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
    <style>
        .readdata p {
            padding: 0
        }

        .text_right {
            margin-bottom: 30px;
            text-align: right;
        }
    </style>

    <script src="{$_assets}plugins/jquery-1.11.0.min.js"
            tab="text/javascript"></script>
    <script src="{$_assets}plugins/bootstrap/js/bootstrap.min.js"
            tab="text/javascript"></script>
    <script tab="text/javascript"
            src="{$_assets}plugins/select2/select2.min.js"></script>
    <script tab="text/javascript"
    <script src="{$_assets}scripts/_page.js"></script>
    <link rel="stylesheet" type="text/css" href="{$_assets}plugins/bootstrap-fileinput/bootstrap-fileinput.css"/>
    <script type="text/javascript" src="{$_assets}plugins/bootstrap-fileinput/bootstrap-fileinput.js"></script>
</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->

<body style="background:#FaFaFa !important">
<div class="portlet tabbable">
<div class="portlet-title">
    <div class="caption">
        <i class="fa fa-database"></i>文章信息
    </div>
</div>
<div class="portlet-body" style="padding:10px 10px">
    <div class="form-body">
    <form class="form-horizontal" role="form" action="?" method="post" enctype="multipart/form-data">
        <input type="hidden" name="case_action" value="case_submit">
        <input type="hidden" name="action" value="case">
        <input type="hidden" name="raiders_id" value="{$_data['id']}">
        <input type="hidden" name="space_id" value="{$spacepedia['id']}">
        <input type="hidden" name="data[logo]" value="{$_data['logo']}">
        <div class="tab-content clearfix">
            <div class="col-md-6">
                <div class="form-group">
                    <label class="control-label col-md-2">标题<span class="required"
                                                                  aria-required="true">*</span></label>
                    <div class="col-md-10">
                        <div class="col-md-10">
                            <input type="text" class="form-control" placeholder="文章标题"
                                   name="data[title]"
                                   value="{$_data['title']}">
                        </div>
                        <div class="col-md-2" style="line-height: 40px;color: #e02222">
                            <input name="data[is_good]" type="checkbox" value="1"  {if $_data['is_good']==1}checked="checked"{/if}/>推荐/加精
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="form-group">
                    <label class="control-label col-md-2">作者</label>
                    <div class="col-md-10">
                        <input type="text" class="form-control" name="data[author]" placeholder="输入作者" value="{$_data['author']}">
                        {*<input name="is_hot" type="checkbox" value="1"  {if $_data['is_hot']==1}checked="checked"{/if}/>设置为云发现轮播图（置顶）*}
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="form-group">
                    <label class="control-label col-md-2">文章来源</label>
                    <div class="col-md-10">
                        <input type="text" class="form-control" name="data[from_url]" placeholder="输入文章来源" value="{$_data['from_url']}">
                        {*<input name="is_hot" type="checkbox" value="1"  {if $_data['is_hot']==1}checked="checked"{/if}/>设置为云发现轮播图（置顶）*}
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="form-group">
                    <label class="control-label col-md-2">副标题</label>

                    <div class="col-md-10">
                        <div class="col-md-8" style="padding-left: 0px;">
                            <input type="text" class="form-control" name="subhead" placeholder="输入副标题" value="{$spacepedia['subhead'][$_data['id']]}">
                        </div>
                        <div class="col-md-4">
                            <span class="required" aria-required="true" style="color: #e02222">（*百科设置副标题专用）</span>
                        </div>
                    </div>
                </div>
            </div>
            {*<div class="col-md-6">*}
                {*<div class="form-group">*}
                    {*<label class="control-label col-md-2">关联百科</label>*}
                    {*<div class="col-md-10">*}
                        {*<input type="text" class="form-control input-sm select2 tags_select2" value="{implode(',',$_data['baike_word'])|default:$spacepedia['space_name']}" name="data[baike_word]"   data-values="{implode(',',$_data['baike_word'])}">*}
                    {*</div>*}
                {*</div>*}
            {*</div>*}
            <div class="col-md-6">
                <div class="form-group">
                    <label class="control-label col-md-2">关联百科</label>
                    <div class="col-md-10">
                        <input type="text" class="form-control input-sm select2 tags_select3" value="{$_data['space_ids']|default:$spacepedia["id"]}" name="data[space_ids]" >
                    </div>
                </div>
            </div>
            <div class="col-md-6" id="category_id">
                <div class="form-group">
                    <label class="control-label col-md-2">类别<span class="required"
                                                                  aria-required="true">*</span></label>
                    <div class="col-md-10">
                        <select class="form-control input-sm category_id" name="data[category_id]" id="library">
                            <option value=''>全部</option>
                            {foreach $category_name as $key=>$value}

                                <option class="parent" {if $_data['category_id']==$value['id']} selected {/if}
                                        value="{$value['id']}"  data-parent="{$value['parent']}">{if $value['parent']==0}{$value['name']}{else}&nbsp;&nbsp;---{$value['name']}{/if}</option>
                            {/foreach}
                        </select>
                    </div>
                </div>
            </div>
            {if $_data['category_id']==25}
            <div class="col-md-6" id="actor">
                <div class="form-group">
                    <label class="control-label col-md-2">演员名<span class="required"
                                                                   aria-required="true">*</span></label>
                    <div class="col-md-10">
                        <input type="text" class="form-control input-sm " value="{$_data['actor']}" name="data[actor]" >
                    </div>
                </div>
            </div>
            {/if}
            <div class="col-md-6">
                <div class="form-group">
                    <label class="control-label col-md-2">状态<span class="required"
                                                                  aria-required="true">*</span></label>

                    <div class="col-md-10">
                        <select name="data[status]" class="form-control input-sm">
                            {foreach $status as $key=>$val}
                                <option {if {$_data['status']}==$key}selected{/if}
                                        value="{$key}">{$val}</option>
                            {/foreach}
                        </select>
                    </div>
                </div>
            </div>

            <div class="col-md-6">
                <div class="form-group">
                    <label class="control-label col-md-2">关键词<span class="required"
                                                                   aria-required="true">*</span></label>
                    <div class="col-md-10">


                        <input type="text" class="form-control input-sm select2 tags_select2" value="{implode(',',$_data['tags_info'])}" name="data[tags_info]"   data-values="{implode(',',$attr)}">

                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="form-group">
                    <label class="control-label col-md-2">修改时间</label>
                    <div class="col-md-10">
                        <input type="text" class="form-control" name="data[create_time]" placeholder="时间格式例如：2015-01-01 00:00:01" {if !empty($_data['create_time'])}value="{date('Y-m-d H:i:s',$_data['create_time'])}"{else}value=""{/if}>
                    </div>
                </div>
            </div>
            <div class="col-md-12">

                <div class="col-md-6">
                    <div class="form-group">
                        <label class="col-md-2 control-label">封面缩略图</label>
                        <div class="col-md-10">
                            <div class="fileinput fileinput-new" data-provides="fileinput">
                                <div class="fileinput-new thumbnail col-md-6" >
                                    {if $_data['logo']}
                                        <img src="{$_data['logo']}" alt=""/>
                                    {else}
                                        <img src="http://www.placehold.it/200x150/EFEFEF/AAAAAA&amp;text=no+image"
                                             alt=""/>
                                    {/if}

                                </div>
                                <div style="margin-top: 50px;" class="col-md-6">
                                    <input name="data[hide_logo]" type="checkbox" value="1"
                                           {if $_data['hide_logo']==1}checked="checked"{/if}/>勾选则在详情页展示
                                    logo，不勾选则不展示
                                </div>
                                <div style="clear:both"></div>
                                <div class="fileinput-preview fileinput-exists thumbnail"
                                     style="max-width: 200px; max-height: 150px;">
                                </div>
                                <div>
                                    <span class="btn btn-default btn-file">
                                        <span class="fileinput-new">选择图片</span>
                                        <span class="fileinput-exists">重新选择</span>
                                        <input type="file" name="logo_f"  accept="image/jpeg,image/png,image/gif">
                                    </span>
                                    <a href="form_component.html#" class="btn btn-danger fileinput-exists"
                                       data-dismiss="fileinput">移除</a>
                                    <span class="required" aria-required="true" style="color: #e02222">（*如栏目选择为活动文库，
                                        请勿上传，封面缩略图建议尺寸为304*185）
                                    </span>

                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="form-group">
                    <label class="control-label col-md-2">跳转链接</label>

                    <div class="col-md-6">
                        <input  class="form-control" name="data[is_jump]" value="{$_data['is_jump']}" placeholder="如果需要文章跳转至专题页，请填写！"/>
                    </div>
                </div>

            </div>
            <div class="col-md-6">
                <div class="form-group">
                    <label class="control-label col-md-2">原文链接</label>

                    <div class="col-md-6">
                        <input  class="form-control" name="data[original_link]" value="{$_data['original_link']}" placeholder="原文链接"/>
                    </div>
                </div>

            </div>

            <div class="col-md-12">
                <div class="form-group">
                    <label class="control-label col-md-1">文章简介<span class="required"
                                                                    aria-required="true">*</span></label>

                    <div class="col-md-11">
                        <textarea class="form-control " rows="3"
                                  name="data[des]">{$_data['des']}</textarea>
                    </div>
                </div>
            </div>
            <div class="col-md-12">
                <div class="form-group">
                    <label class="control-label col-md-1">文章内容<span class="required"
                                                                    aria-required="true">*</span></label>
                    <div class="col-md-11">
                        {include "Admin::inc/html_umeditor.tpl" name="data[cont]" value=$_data['cont'] height=300}
                    </div>
                </div>
            </div>


            <div class="col-md-12" id="accessory" style="display: none">
                <div class="form-group">
                    <label class="control-label col-md-1">上传附件<span class="required"
                                                                    aria-required="true">*</span></label>
                    <div class="col-md-10">
                        <div class="fileinput fileinput-new" data-provides="fileinput">
                            <span class="btn btn-default btn-file">
                                <span class="fileinput-new">选择文件</span>
                                <span class="fileinput-exists">重新选择 </span>
                                <input type="file" accept="zip,rar,pdf,txt,doc,jpg,docx,pptx,ppt,xlsx,xls,png" name="accessory">
                            </span>
                            <span class="fileinput-filename">{$_data['accessory']['filename']}</span>&nbsp;
                            <a href="javascript:void(0)" class="close fileinput-exists"
                               data-dismiss="fileinput"></a>
                            {if $_data['accessory']}
                                <span class="fa fa-file"></span>

                                <input type="hidden" name="accessory[name]" value="{$_data['accessory']['name']}">
                                <input type="hidden" name="accessory[size]" value="{$_data['accessory']['size']}">
                                <input type="hidden" name="accessory[filename]" value="{$_data['accessory']['filename']}">
                            {/if}
                            <br/><span style="font-size:12px; ">(请上传格式为.zip.jpg.rar.pdf.txt.doc.docx.pptx.ppt.xlsx.xls.png的文件，大小不能超过50M)</span>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="form-group">
                    <label class="control-label col-md-2">详情描述1</label>

                    <div class="col-md-10">
                        <input type="text" class="form-control" name="data[detail_des][]"
                               placeholder="如 活动地点：上海长宁区淮海西路570号F211"
                               value="{$_data['detail_des'][0]}">
                    </div>

                </div>
            </div>
            <div class="col-md-6">
                <div class="form-group">
                    <label class="control-label col-md-2">详情描述2</label>

                    <div class="col-md-10">
                        <input type="text" class="form-control" name="data[detail_des][]"
                               placeholder="如 交通方式：地铁3、4、10号线虹桥路站4号口出"
                               value="{$_data['detail_des'][1]}">
                    </div>

                </div>
            </div>
            <div class="col-md-6">
                <div class="form-group">
                    <label class="control-label col-md-2">详情描述3</label>

                    <div class="col-md-10">
                        <input type="text" class="form-control" name="data[detail_des][]"
                               placeholder="如 活动时间：2015-10-1~2015-10-31"
                               value="{$_data['detail_des'][2]}">
                    </div>

                </div>
            </div>
            <div class="col-md-6">
                <div class="form-group">
                    <label class="control-label col-md-2">详情描述4</label>

                    <div class="col-md-10">
                        <input type="text" class="form-control" name="data[detail_des][]"
                               placeholder="如 开放时间：周二至周日10:00-17:30（17:00停止入馆）"
                               value="{$_data['detail_des'][3]}">
                    </div>

                </div>
            </div>
            <div class="col-md-6">
                <div class="form-group">
                    <label class="control-label col-md-2"></label>
                    <div class="col-md-10">
                        <span class="required" aria-required="true" style="color: #e02222">（*详情描述：活动内容或场地内容的附加信息，如活动地点、活动时间、开放时间等信息）
                         </span>
                    </div>
                </div>
            </div>
        </div>
        <div class="form-actions text-center">
            <button type="reset" class="btn btn-default">
                重置
            </button>
            <button type="submit" class="btn btn-success" >
                提交
            </button>
        </div>
    </form>
    </div>
</div>
</div>
<script>

    $(document).ready(function(){
        $(".tags_select2").each(function () {
            $(this).select2({
                tags: $(this).data('values').split(',')
            })
        });

        var sel =  $("#library").children('option:selected').val()
        var par = $("#library").children('option:selected').data("parent")
        if(sel == 12 || par ==12){
            $('#accessory').css('display','block');
        }
        $("#library").change(function(){
            var category_id = $(this).children('option:selected').val();
            var parent = $(this).children('option:selected').data("parent");
            if(category_id == 12 || parent == 12){
                $('#accessory').css('display','block');}else{
                $('#accessory').css('display','none');
            }
        });
        $(".tags_select3").select2({
            placeholder          : "请输入要关联的百科",
            minimumInputLength   : 1,
            multiple             : true,
            separator            : ",",                             // 分隔符
            maximumSelectionSize : 5,                               // 限制数量
            initSelection        : function (element, callback) {   // 初始化时设置默认值
                var arr = [];
                $(element.val().split(",")).each(function (index,ele) {
                    if(ele){
                        $.ajax("http://{Core::$urls['host']}/static/api/baike/auto/complete.jsonp", {
                            data: {
                                id: ele
                            },
                            dataType: "json"
                        }).done (function (data) {
                            console.log(data);
                            arr.push(data.results['0']);
                            callback(arr);
                        });
                    }
                });

            },
//            createSearchChoice   : function(term, data) {           // 创建搜索结果（使用户可以输入匹配值以外的其它值）
//                return { id: term, name: term };
//            },
            formatSelection : function (item) { return item.name; },  // 选择结果中的显示
            formatResult    : function (item) { return item.name; },  // 搜索列表中的显示
            ajax :{
                    url      : "http://{Core::$urls['host']}/static/api/baike/auto/complete.jsonp",              // 异步请求地址
                    dataType : "json",                  // 数据类型
                    data     : function (term, page) {  // 请求参数（GET）
                    return { q: term };
                },
                results      : function (data, page) { console.log(data);return data; },  // 构造返回结果
                escapeMarkup : function (m) { return m; }               // 字符转义处理
            }
        });

        // 文创演员名

        if($('.category_id option:selected').text().indexOf("角色")>0 && document.getElementById("actor")==undefined){
            $div= '<div class="col-md-6" id="actor">  <div class="form-group"> <label class="control-label col-md-2">演员名<span class="required" aria-required="true">*</span></label><div class="col-md-10"> ' +
            '<input type="text" class="form-control input-sm select2 tags_select3" value="" name="data[actor]" > </div>' +
            ' </div> </div>';
            $('#category_id').after($div);
        }
        $('.category_id').click(function() {
            var catrgory_name = $('.category_id option:selected').text();
            if(catrgory_name.indexOf("角色")>=0){
                if(document.getElementById("actor")==undefined){
                    $div= '<div class="col-md-6" id="actor">  <div class="form-group"> <label class="control-label col-md-2">演员名<span class="required" aria-required="true">*</span></label><div class="col-md-10"> ' +
                    '<input type="text" class="form-control input-sm select2 tags_select3" value="" name="data[actor]" > </div>' +
                    ' </div> </div>';
                    $('#category_id').after($div);
                }
            }else{
                if(document.getElementById("actor")!=undefined){
                    document.getElementById("actor").remove();
                }

            }
        })


    });
</script>
</body>