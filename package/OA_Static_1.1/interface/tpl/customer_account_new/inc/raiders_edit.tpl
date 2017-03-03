
<div class="portlet tabbable">
    <div class="portlet-title">
        <div class="caption">
            <i class="fa fa-database"></i>文章信息
        </div>
    </div>
    <form class="form-horizontal" role="form" action="?" method="post" enctype="multipart/form-data">
        <div class="portlet-body form">
            <input type="hidden" name="product_id" value="{$_REQUEST['product_id']}">
            <input type="hidden" name="set_id" value="{$_REQUEST['set_id']}">
            <input type="hidden" name="action" value="{$_REQUEST['action']}">
            <input type="hidden" name="is_submit_deliver" value="1">
            <input type="hidden" name="tab" value="{$_REQUEST['tab']}">
            <input type="hidden" name="vendor_id" value="{$_REQUEST['vendor_id']}">
            <div class="form-body">
                <div class="row">
                    <div class="col-md-6">
                        <div class="form-group">
                            <label class="control-label col-md-2">标题<span class="required"
                                                                          aria-required="true">*</span></label>

                            <div class="col-md-10">
                                <input type="text" class="form-control" placeholder="文章标题"
                                       name="title"
                                       value="{$_data['title']}">
                            </div>
                        </div>
                    </div>


                    <div class="col-md-6">
                        <div class="form-group">
                            <label class="control-label col-md-2">作者/来源</label>

                            <div class="col-md-10">
                                <div class="col-md-6" style="padding-left: 0px;">
                                <input type="text" class="form-control" name="author" placeholder="输入作者" value="{$_data['author']}">
                                    </div>
                                <div class="col-md-6" style="line-height: 40px;color: #e02222">
                                    <input name="is_hot" type="checkbox" value="1"  {if $_data['is_hot']==1}checked="checked"{/if}/>设置为云发现轮播图（置顶）&nbsp;&nbsp;&nbsp;&nbsp;<input name="is_good" type="checkbox" value="1"  {if $_data['is_good']==1}checked="checked"{/if}/>推荐
                                </div>

                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label class="control-label col-md-2">类别<span class="required"
                                                                          aria-required="true">*</span></label>
                            <div class="col-md-10">
                                <select class="form-control input-sm" name="category_id" id="library">
                                    <option value=''>全部</option>
                                    {foreach $category_name as $key=>$value}

                                        <option class="parent" {if $_data['category_id']==$value['id']} selected {/if}
                                                value="{$value['id']}"  data-parent="{$value['parent']}">{if $value['parent']==0}{$value['name']}{else}&nbsp;&nbsp;---{$value['name']}{/if}</option>
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


                                <input type="text" class="form-control input-sm select2 tags_select2" value="{implode(',',$_data['tags_info'])}" name="tags_info[]"   data-values="{implode(',',$attr)}">

                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label class="col-md-2 control-label">封面缩略图</label>
                                <div class="col-md-10">
                                    <div class="fileinput fileinput-new" data-provides="fileinput">
                                        <div class="fileinput-new thumbnail col-md-5" >
                                            {if $_data['logo']}
                                                <img src="{$_data['logo']}" alt=""/>
                                            {else}
                                                <img src="http://www.placehold.it/200x150/EFEFEF/AAAAAA&amp;text=no+image"
                                                     alt=""/>
                                            {/if}

                                        </div>
                                        <div style="margin-top: 50px;" class="col-md-7">
                                            <input name="hide_logo" type="checkbox" value="1"
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

                                        </div>
                                        <p class="required" aria-required="true" style="color: #e02222">（*如栏目选择为活动文库，
                                            请勿上传，封面缩略图建议尺寸为304*185）
                                        </p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label class="control-label col-md-2">跳转链接</label>

                            <div class="col-md-6">
                                <input  class="form-control" name="is_jump" value="{$_data['is_jump']}" placeholder="如果需要文章跳转至专题页，请填写！"/>
                            </div>
                        </div>

                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label class="control-label col-md-2">原文链接</label>

                            <div class="col-md-6">
                                <input  class="form-control" name="original_link" value="{$_data['original_link']}" placeholder="原文链接"/>
                            </div>
                        </div>

                    </div>
                    <div class="col-md-12">
                        <div class="form-group">
                            <label class="control-label col-md-1">文章简介<span class="required"
                                                                            aria-required="true">*</span></label>

                            <div class="col-md-11">
                                <textarea class="form-control " rows="3"
                                          name="des">{$_data['des']}</textarea>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-12">
                        <div class="form-group">
                            <label class="control-label col-md-1">文章内容<span class="required"
                                                                            aria-required="true">*</span></label>
                            <div class="col-md-11">
                                {include "Admin::inc/html_umeditor.tpl" name="cont" value=$_data['cont'] height=300}
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
                                <input type="text" class="form-control" name="detail_des[]"
                                       placeholder="如 活动地点：上海长宁区淮海西路570号F211"
                                       value="{$_data['detail_des'][0]}">
                            </div>

                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label class="control-label col-md-2">详情描述2</label>

                            <div class="col-md-10">
                                <input type="text" class="form-control" name="detail_des[]"
                                       placeholder="如 交通方式：地铁3、4、10号线虹桥路站4号口出"
                                       value="{$_data['detail_des'][1]}">
                            </div>

                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label class="control-label col-md-2">详情描述3</label>

                            <div class="col-md-10">
                                <input type="text" class="form-control" name="detail_des[]"
                                       placeholder="如 活动时间：2015-10-1~2015-10-31"
                                       value="{$_data['detail_des'][2]}">
                            </div>

                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label class="control-label col-md-2">详情描述4</label>

                            <div class="col-md-10">
                                <input type="text" class="form-control" name="detail_des[]"
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
<link rel="stylesheet" type="text/css" href="{$_assets}plugins/bootstrap-fileinput/bootstrap-fileinput.css"/>
<script type="text/javascript" src="{$_assets}plugins/bootstrap-fileinput/bootstrap-fileinput.js"></script>
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
    });
</script>
