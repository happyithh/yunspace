<style>
    .table td {
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

    .table1 td {
        padding: 5px;
    }
    .tab-content{
        display:none;
    }
    .tab-content.active{
        display:block;
    }
</style>

{include file="Admin::inc/plupload3.tpl"}
<div class="tabbable tabbable-custom boxless">
    <ul class="nav nav-tabs">
        <li class="active tab_li">
            <a href="javascript:;" data-toggle="tab">协议上传</a>
        </li>

    </ul>

    {******************************************合同附件 start *****************************************}

    <div class="tab-content active">
        <!--      ---------------------------图片/视频  start-------------------------------      -->
        {*<div class="tab-pane active">*}
        <div id="filelist">您的浏览器不支持 Flash, Silverlight 或 HTML5。
        </div>
        <br/>
        <div id="container">
            <button id="pickfiles" type="button" class="btn btn-success">
                <i class="icon-folder-open"></i> 立即上传
            </button>
            <br/><span style="font-size:12px; ">(请上传格式为.rar,.pdf或.jpg,.gif,.png,.jpeg的文件，大小不能超过10MB)</span>
        </div>
        <br/>
        <table class="table table-hover">
            <thead>
            <tr>
                {*<th width="80">缩略图</th>*}
                <th>名称</th>
                <th width="60">操作</th>
            </tr>
            <tr class="hidden">
                {*<td>*}
                    {*<img src="" style="height: 80px; width: 80px; display: block;">*}
                {*</td>*}
                <td>
                    <input type="hidden" name="agreement_files[$$][path]">
                    <input class="form-control" type="text" name="agreement_files[$$][name]" value="">
                </td>
                <td class="btns">
                    <i class="fa fa-long-arrow-up" onclick="uploader.UploadFiles.up(this)"></i>
                    <i class="fa fa-long-arrow-down" onclick="uploader.UploadFiles.down(this)"></i>
                    <i class="fa fa-trash-o" onclick="uploader.UploadFiles.remove(this)"></i>
                </td>
            </tr>
            </thead>
            <tbody id="upload_files">
            {if !empty($data['agreement_files'])}
            {foreach $data['agreement_files'] as $k=>$v}
                <tr>
                    {*<td>*}
                        {*<img src="{$v['path']}" style="height: 80px; width: 80px; ">*}
                    {*</td>*}
                    <td>
                        <input type="hidden" name="agreement_files[{$k}][path]" value="{$v['path']}">
                        <input class="form-control" type="text" name="agreement_files[{$k}][name]"
                               value="{$v['name']}">
                    </td>
                    <td class="btns">
                        <i class="fa fa-long-arrow-up" onclick="uploader.UploadFiles.up(this)"></i>
                        <i class="fa fa-long-arrow-down" onclick="uploader.UploadFiles.down(this)"></i>
                        <i class="fa fa-trash-o" onclick="uploader.UploadFiles.remove(this)"></i>
                    </td>
                </tr>
            {/foreach}
            {/if}
            </tbody>
        </table>
        {*</div>*}
    </div>


    {******************************************合同附件 end *****************************************}


</div>
<script>

    $('.nav-tabs .tab_li').click(function(){
        var index = $(this).index();
        $(this).addClass('active').show().siblings().removeClass('active');
        $('.tab-content').eq(index).show().addClass('active').siblings().removeClass('active').hide();
        $('.nav-tabs').show();
    });

    var uploader = newUploader('container','pickfiles','filelist','upload_files')
    var uploader2 = newUploader('container2','pickfiles2','filelist2','upload_files2')

</script>