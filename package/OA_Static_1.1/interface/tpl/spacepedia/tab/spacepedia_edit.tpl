<div class="portlet tabbable">
    <div class="portlet-title">
        <div class="caption">
            <i class="fa fa-database" ></i>场地百科信息修改
            {if $data_edit['object_id']}
            <p style="color:#bd362f;margin-left: 30px;float: right;">(表单内容默认显示下面列表中的第一条，如有需要可点击【查看】切换)</p>
            {/if}
        </div>
    </div>
    <div class="portlet-body" style="padding:10px 10px">
        <div class="form-body" style="min-height: 350px;">
            {if $_data}
            <table class="table-list-h" cellpadding="0" cellspacing="0">
                <tr>
                    <th width="10%">id</th>
                    <th width="30%">百科名称</th>
                    <th width="15%">修改时间</th>
                    <th width="30%">状态</th>
                    <th width="15%">操作</th>
                </tr>

               {foreach $_data as $k => $v}
                <tr>
                    <td>{$v['id']}</td>
                    <td>{$v['data_backup']['space_name']}</td>
                    <td>{date('Y-m-d H:i:s',$v['create_time'] )}</td>
                    <td>
                        {$status[$v['status']]}

                        {if $v['status']==2}
                            <div style="color: #f3565d;">【拒绝原因】:{$v['refuse_reason']}</div>
                        {/if}
                    </td>
                    <td>
                        {if $_REQUEST['history_id']== $v['id'] || empty( $_REQUEST['history_id'])}
                            <button class="btn btn-success btn-xs" disabled>查看</button>
                        {else}
                            <a class="btn btn-primary btn-xs" href="?action=detail&space_id={$v['object_id']}&tab_action=edit_space&tab=2&history_id={$v['id']}">查看</a>
                        {/if}
                    </td>
                </tr>
                {/foreach}
            </table>
            <style>
                .table-list-h{
                    border: 1px solid #ddd;
                    border-left: none;
                    width: 100%;
                    max-width: 1000px;
                    margin: 0 auto 15px;
                }
                .table-list-h th{
                    text-align: center;
                    padding: 5px 0;
                    border-left: 1px solid #ddd;
                }
                .table-list-h td{
                    text-align: center;
                    padding: 5px 0;
                    border-top: 1px solid #ddd;
                    border-left:1px solid #ddd;
                }
            </style>
            {/if}

            <form class="form-horizontal" role="form" action="?" method="post" enctype="multipart/form-data">
                <input type="hidden" name="space_id" value="{$_REQUEST['space_id']}">
                <input type="hidden" name="action" value="{$_REQUEST['action']}">
                <input type="hidden" name="tab_action" value="submit_spacepedia">
                <input type="hidden" name="tab" value="">
                {if $data_edit['object_id']} <input type="hidden" name="data[space_name]" value="{$data_edit['data_backup']['space_name']}">{/if}
                <div class="row">
                    <div class="col-md-6">
                        <div class="form-group">
                            <label class="control-label col-md-2">场地百科名称<span class="required" aria-required="true">*</span></label>

                            <div class="col-md-10">
                                <input type="text" {*{if $data_edit['object_id']} disabled {/if}*}  class="form-control" placeholder="请输入场地百科名称" name="data[space_name]" value="{$data_edit['data_backup']['space_name']}">
                                <input type="hidden" class="form-control" name="data[category_id]" value="{$category_id}">
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label class="control-label col-md-2">百科别名</label>

                            <div class="col-md-10">
                                <input type="text" class="form-control" placeholder="请输入场地百科别名" name="data[nickname]" value="{$data_edit['data_backup']['nickname']}">
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label class="control-label col-md-2">所属公司</label>
                            <div class="col-md-10">
                                <input type="text" class="form-control" placeholder="请输入场地所属公司" name="data[company]" value="{$data_edit['data_backup']['company']}">
                            </div>
                            {* <div class="col-md-10">
                                <input id="select2_sample6" type="hidden" class="form-control select2" name="data[vendor_id]" value="{$data_edit['data_backup']['vendor_id']}">
                            </div> *}
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label class="control-label col-md-2">营销标题</label>

                            <div class="col-md-10">
                                <input type="text" class="form-control" name="data[attr][营销标题]" value="{$data_edit['data_backup']['attr']['营销标题']}">
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label class="control-label col-md-2">特色标签</label>

                            <div class="col-md-10">
                                <input type="hidden" class="form-control select2 select2_special_tags" name="data[attr][特色标签]" data-values="{$data_edit['data_backup']['attr']['特色标签']}" value="{$data_edit['data_backup']['attr']['特色标签']}">
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label class="control-label col-md-2">场地地址</label>

                            <div class="col-md-10">
                                <input type="text" class="form-control" name="data[addr]" value="{$data_edit['data_backup']['addr']}">
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label class="control-label col-md-2">场地指数</label>
                            <div class="col-md-10">
                                <input type="text" class="form-control index_num"  value="">
                                <p class="error_msg" style="color: #87ceeb;margin-top: 8px;"> ps:此指数一般不要修改，只有排名特殊需求时修改。数字越大排名越靠前 最大不超过100 请在地理位置更新以后再修改</p>
                            </div>
                            <br />
                        </div>
                    </div>
                    {if !$_tags_info}
                        <div class="col-md-6">
                            <div class="form-group">
                                <label class="control-label col-md-2">城市</label>

                                <div class="col-md-10">
                                    <input type="text" class="form-control" name="data[attr][46]" value="{$data_edit['data_backup']['attr'][46]}">
                                </div>
                            </div>
                        </div>
                    {/if}
                    {*<div class="col-md-6">*}
                        {*<div class="form-group">*}
                            {*<label class="control-label col-md-2">场地等级</label>*}

                            {*<div class="col-md-10">*}
                                {*{foreach $level as $k=>$v}*}
                                    {*<label class="radio-inline">*}
                                        {*<input type="radio" name="data[level]" value="{$v}" {if $data_edit['data_backup']['level']=={$v}}checked="checked" {/if}>*}
                                        {*{$k}*}
                                    {*</label>*}
                                {*{/foreach}*}
                            {*</div>*}
                        {*</div>*}
                    {*</div>*}
                    <div class="col-md-12">
                        <div class="form-group">
                            <label class="control-label col-md-1">场地描述</label>
                            <div class="col-md-11">
                                {include "Admin::inc/html_umeditor.tpl" name="data[des]" value=$data_edit['data_backup']['des'] height=200}
                            </div>
                        </div>
                    </div>
                    {if $_tags_info}
                    <div class="col-md-12">
                        {foreach $_tags_info as $key=>$value}
                            <div class="form-group">
                                <label class="control-label col-md-1">{$key}</label>

                                <div class="col-md-11">
                                    {foreach $value as $ik=>$iv}
                                        <div class="input-group">
                        <span class="input-group-addon">
                            {if $iv['tags_name'] == '城市'}
                                <span style="color:#C63300">*</span>
                            {/if}
                            {$iv['tags_name']}:
                        </span>
                                            <input type="text" class="form-control select2 tags_attr" name="data[attr][{$ik}]"   value="{$data_edit['data_backup']['attr'][{$ik}]}" data-values="{implode(',',$iv['tags_value'])}">
                                        </div>
                                    {/foreach}
                                </div>
                            </div>
                        {/foreach}
                    </div>
                    {/if}
                    {if $data_edit['data_backup']['other_demo']}
                        <div class="col-md-12">
                            <div class="form-group">
                                <label class="control-label col-md-1">其他属性</label>
                                <div class="col-md-11">
                                    {foreach $data_edit['data_backup']['other_demo'] as $key=>$value}
                                        {if $key !='下载次数' && $key !='附件'}
                                            <div class="input-group">
                                            <span class="input-group-addon">
                                                {$key}:
                                            </span>
                                            <input type="text" class="form-control select2 tags_attr" name="data[other_demo][{$key}]"   value="{$value}" data-values="{implode(',',$value)}">
                                            </div>
                                        {/if}
                                    {/foreach}
                                </div>
                            </div>
                        </div>
                    {/if}
                    {if $data_edit['data_backup']['other_demo']}
                        <div class="col-md-12" id="accessory" style="">
                            <div class="form-group">
                                <label class="control-label col-md-1">上传附件</label>
                                <div class="col-md-10">
                                    <div class="fileinput fileinput-new" data-provides="fileinput">
                                                        <span class="btn btn-default btn-file">
                                                            <span class="fileinput-new">选择文件</span>
                                                            <span class="fileinput-exists">重新选择 </span>
                                                            <input type="file" accept="application/zip,application/pdf" name="附件">
                                                        </span>
                                        <span class="fileinput-filename">{$data_edit['data_backup']['other_demo']['附件']['filename']}</span>&nbsp;
                                        <a href="javascript:void(0)" class="close fileinput-exists"
                                           data-dismiss="fileinput"></a>
                                        {if $data_edit['data_backup']['other_demo']['附件']}
                                            <span class="fa fa-file"></span>

                                            <input type="hidden" name="data[other_demo][附件][name]" value="{$data_edit['data_backup']['other_demo']['附件']['name']}">
                                            <input type="hidden" name="data[other_demo][附件][size]" value="{$data_edit['data_backup']['other_demo']['附件']['size']}">
                                            <input type="hidden" name="data[other_demo][附件][filename]" value="{$data_edit['data_backup']['other_demo']['附件']['filename']}">
                                        {/if}
                                        <br/><span style="font-size:12px; ">(请上传格式为.pdf的文件，大小不能超过8M)</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    {/if}
                    <div class="col-md-12">
                        <div class="form-group">
                            <label class="control-label col-md-1">百科banner</label>
                            <div class="col-md-4">
                                <div class="fileinput fileinput-new" data-provides="fileinput">
                                    <div class="fileinput-new thumbnail" style="width: 200px; height: 150px;">
                                        {if $data_edit['data_backup']['logo']}
                                            <img  class="logo_src" src="{$data_edit['data_backup']['logo']}" alt=""/>
                                        {else}
                                            <img src="http://www.placehold.it/200x150/EFEFEF/AAAAAA&amp;text=no+image"
                                                 alt=""/>
                                        {/if}
                                    </div>
                                    <div class="fileinput-preview fileinput-exists thumbnail"
                                         style="max-width: 200px; max-height: 150px;"></div>
                                    <div>
                                    <span class="btn btn-default btn-file">
                                        <span class="fileinput-new">选择PC端图片</span>
                                        <span class="fileinput-exists">重新选择</span>
                                        <input type="file" name="百科banner" accept="image/jpeg,image/png,image/gif">
                                        <input type="hidden" class="logo" name="data[logo]" value="{$data_edit['data_backup']['logo']}">
                                    </span>
                                    {if $data_edit['data_backup']['logo']}
                                        <a href="javascript:;" class="btn btn-danger remove_logo">移除</a>
                                    {else}
                                        <a href="form_component.html#" class="btn btn-danger fileinput-exists" data-dismiss="fileinput">移除</a>
                                    {/if}
                                    </div>
                                </div>
                                <span class="required" aria-required="true" style="color: #e02222">（*请上传尺寸为1920*520的图片）
                                                                </span>
                            </div>

                            <div class="col-md-4">
                                <div class="fileinput fileinput-new" data-provides="fileinput">
                                    <div class="fileinput-new thumbnail" style="width: 200px; height: 150px;">
                                        {if $data_edit['data_backup']['mobile_logo']}
                                            <img class="mobile_logo_src" src="{$data_edit['data_backup']['mobile_logo']}" alt=""/>
                                        {else}
                                            <img src="http://www.placehold.it/200x150/EFEFEF/AAAAAA&amp;text=no+image"
                                                 alt=""/>
                                        {/if}
                                    </div>
                                    <div class="fileinput-preview fileinput-exists thumbnail"
                                         style="max-width: 200px; max-height: 150px;"></div>
                                    <div>
                                    <span class="btn btn-default btn-file">
                                        <span class="fileinput-new">选择移动端图片</span>
                                        <span class="fileinput-exists">重新选择</span>
                                        <input type="file" name="百科移动端banner" accept="image/jpeg,image/png,image/gif">
                                        <input type="hidden" class="mobile_logo" name="data[mobile_logo]" value="{$data_edit['data_backup']['mobile_logo']}">
                                    </span>
                                    {if $data_edit['data_backup']['mobile_logo']}
                                        <a href="javascript:;" class="btn btn-danger remove_mobile_logo">移除</a>
                                    {else}
                                        <a href="form_component.html#" class="btn btn-danger fileinput-exists"
                                           data-dismiss="fileinput">移除</a>
                                    {/if}
                                    </div>
                                </div>
                                {*<span class="required" aria-required="true" style="color: #e02222">（*请上传尺寸为1920*520的图片）*}
                                                                {*</span>*}
                            </div>
                        </div>
                    </div>
                    <div class="col-md-12">
                        <div class="form-group">
                            <label class="control-label col-md-1">场地图片</label>

                            <div class="col-md-11">
                                {include file="spacepedia/inc/public_upload.tpl"}
                            </div>
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
    </div>
</div>
<link rel="stylesheet" type="text/css" href="{$_assets}plugins/bootstrap-fileinput/bootstrap-fileinput.css"/>
<script type="text/javascript" src="{$_assets}plugins/bootstrap-fileinput/bootstrap-fileinput.js"></script>
{static "core/yunspace.js"}
{*<script type="text/javascript" src="{$_assets}plugins/bootstrap-fileinput/bootstrap-fileinput.js"></script>*}
<script>
    $(document).ready(function(){
        var space_id=$('.form-horizontal').find("input[name=space_id]").val();
        YunSpace.api('spacepedia/level/by/id.jsonp',{
            space_id: space_id,
            action:'get'
        },function(data){
            if(data.status==1){
               localStorage.space_index=data.data;
                $(".index_num").val(data.data);
            }else{
                localStorage.space_index=-1;
                $(".index_num").val(0);
            }
        })
        $('.index_num').blur(function(){
            var index_num = $(this).val();
           if(!isNum(index_num)||parseInt(index_num)>100||parseInt(index_num)<0){
               $('.error_msg').css('color','red');
               $('.error_msg').html('请填写0-100之间的正整数');
               $(".error_msg").show();
               setTimeout('$(".error_msg").hide()',3000);
               return false;
           }
            if(index_num!=localStorage.space_index&&localStorage.space_index!=-1){
                YunSpace.api('spacepedia/level/by/id.jsonp',{
                    space_id: space_id,
                    index_num: index_num,
                    action:'set'
                },function(data){
                    if(data.status==1){
                        localStorage.space_id=index_num;
                        $('.error_msg').css('color','green');
                        $('.error_msg').html(data.msg);
                        $(".error_msg").show();
                        setTimeout('$(".error_msg").hide()',3000);
                    }else{
                        $('.error_msg').css('color','red');
                        $('.error_msg').html(data.msg);
                        $(".error_msg").show();
                        setTimeout('$(".error_msg").hide()',3000);
                    }
                })
            }
        });
    });
    $(".tags_attr").each(function () {
        $(this).select2({
            tags: $(this).data('values').split(',')
        })
    });
    $('.select2_special_tags').each(function(){
        $(this).select2({
            tags: $(this).data('values').split(',')
        })
    });
    //移除logo
    $(".remove_logo").click(function(){
        $(".logo").val("");
        $(".logo_src").attr("src",'http://www.placehold.it/200x150/EFEFEF/AAAAAA&amp;text=no+image');
    });
    //移除移动端logo
    $(".remove_mobile_logo").click(function(){
        $(".mobile_logo").val("");
        $(".mobile_logo_src").attr("src",'http://www.placehold.it/200x150/EFEFEF/AAAAAA&amp;text=no+image');
    });
    // $("#select2_sample6").select2({
    //     placeholder: "选择供应商",
    //     minimumInputLength: 1,
    //     ajax: { // instead of writing the function to execute the request we use Select2's convenient helper
    //         url:"http://{Core::$urls['host']}/static/api/vendor/auto/complete.jsonp",
    //         data: function (term, page) {
    //             return {
    //                 q: term, // search term
    //                 page_limit: 10
    //             };
    //         },
    //         dataType: 'json',
    //         results: function (data, page) { // parse the results into the format expected by Select2.
    //             // since we are using custom formatting functions we do not need to alter remote JSON data
    //             return {
    //                 results: data.data.items
    //             };
    //         }
    //     },
    //     initSelection: function (element, callback) {
    //         var id = $(element).val();
    //         if (id !== "") {
    //             $.ajax("http://{Core::$urls['host']}/static/api/vendor/auto/complete.jsonp", {
    //                 data: {
    //                     id: id
    //                 },
    //                 dataType: "json"
    //             }).done(function (data) {
    //                         console.log(data);
    //                         callback(data.data.items[0]);
    //                     });
    //         }
    //     },
    //     formatResult: formatRepo, // omitted for brevity, see the source of this page
    //     formatSelection: formatRepoSelection, // omitted for brevity, see the source of this page
    //     escapeMarkup: function (m) {
    //         return m;
    //     } // we do not want to escape markup since we are displaying html in results
    // });
    // function formatRepo(repo) {
    //     if (repo.loading) return repo.text;
    //     return repo.full_name;
    // }

    // function formatRepoSelection(repo) {
    //     return repo.full_name || repo.text;
    // }
    function isNum(code){
        var exp= /^\d+$/;
        if(exp.test(code)){
            return true;
        }else{
            return false;
        }
    }
</script>

