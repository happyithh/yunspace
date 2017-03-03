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
            <a href="javascript:;" data-toggle="tab">视频</a>
        </li>
        <li class="tab_li">
            <a href="javascript:;" data-toggle="tab">品牌图片</a>
        </li>
    </ul>

    {******************************************品牌图片 start *****************************************}

    <div class="tab-content active">
        <!--      ---------------------------图片/视频  start-------------------------------      -->
        <div class="tab-pane active">
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
                <th width="80">视频图片</th>
                <th>视频链接</th>
                <th width="60">操作</th>
            </tr>
            <tr class="hidden">
                <td>
                    <img src="" style="height: 80px; width: 80px; display: block;">
                </td>
                <td>
                    <input type="hidden" name="brand_pic[$$][path]">
                    <input class="form-control" type="text" name="brand_pic[$$][name]" value="">
                    <input class="form-control" type="text" name="brand_pic[$$][url]" value="" placeholder="视频链接">
                    {*<input class="form-control" type="text" name="brand_pic[$$][video_name]" value="" placeholder="视频描述">*}
                </td>

                <td class="btns">
                    <i class="fa fa-long-arrow-up" onclick="uploader.UploadFiles.up(this)"></i>
                    <i class="fa fa-long-arrow-down" onclick="uploader.UploadFiles.down(this)"></i>
                    <i class="fa fa-trash-o" onclick="uploader.UploadFiles.remove(this)"></i>
                </td>
            </tr>
            </thead>
            <tbody id="upload_files">
            {foreach $data['brand_pic'] as $k=>$v}
                <tr>
                    <td>
                        <img src="{$v['path']}" style="height: 80px; width: 80px; ">
                    </td>
                    <td>
                        <input type="hidden" name="brand_pic[{$k}][path]" value="{$v['path']}">
                        <input class="form-control" type="text" name="brand_pic[{$k}][name]" value="{$v['name']}">
                        <input class="form-control" type="text" name="brand_pic[{$k}][url]" value="{$v['url']}">
                        {*<input class="form-control" type="text" name="brand_pic[$$][video_name]" value="{$v['video_name']}">*}
                    </td>
                    <td class="btns">
                        <i class="fa fa-long-arrow-up" onclick="uploader2.UploadFiles.up(this)"></i>
                        <i class="fa fa-long-arrow-down" onclick="uploader2.UploadFiles.down(this)"></i>
                        <i class="fa fa-trash-o" onclick="uploader2.UploadFiles.remove(this)"></i>
                    </td>
                </tr>
            {/foreach}
            </tbody>
        </table>
        </div>
    </div>


    {******************************************品牌图片 end *****************************************}


    {******************************************品牌案例 start *****************************************}


    <div class="tab-content" >
        <!--      ---------------------------图片/视频  start-------------------------------      -->
        {*<div class="tab-pane active">*}
            <div id="filelist2">您的浏览器不支持 Flash, Silverlight 或 HTML5。
            </div>
            <br/>
            <div id="container2">
                <button id="pickfiles2" type="button" class="btn btn-success">
                    <i class="icon-folder-open"></i> 立即上传
                </button>
                <br/><span style="font-size:12px; ">(请上传格式为<span style="color: red;">.rar,.pdf</span>或<span style="color: red;">.jpg,.gif,.png,.jpeg</span>的文件，大小不能超过<span style="color: red;">10MB</span> ; 图片最佳尺寸：<span style="color: red;">1000*680</span>)</span>
            </div>
            <br/>
            <table class="table table-hover">
                <thead>
                <tr>
                    <th width="80">缩略图</th>
                    <th>名称</th>
                    <th width="60">操作</th>
                </tr>
                <tr class="hidden">
                    <td>
                        <img src="" style="height: 80px; width: 80px; display: block;">
                    </td>
                    <td>
                        <input type="hidden" name="brand_case[$$][path]">
                        <input class="form-control" style="margin-bottom: 10px;" type="text" name="brand_case[$$][name]"  value="">
                        <input class="form-control" type="text" name="brand_case[$$][case_name]" placeholder="图片描述" value="">
                    </td>
                    <td class="btns">
                        <i class="fa fa-long-arrow-up" onclick="uploader2.UploadFiles.up(this)"></i>
                        <i class="fa fa-long-arrow-down" onclick="uploader2.UploadFiles.down(this)"></i>
                        <i class="fa fa-trash-o" onclick="uploader2.UploadFiles.remove(this)"></i>
                    </td>
                </tr>
                </thead>
                <tbody id="upload_files2">
                {foreach $data['brand_case'] as $k=>$v}
                    <tr>
                        <td>
                            <img src="{$v['path']}" style="height: 80px; width: 80px; ">
                        </td>
                        <td>
                            <input type="hidden" name="brand_case[{$k}][path]" value="{$v['path']}">
                            <input style="margin-bottom: 10px;" class="form-control" type="text" name="brand_case[{$k}][name]"
                                   value="{$v['name']}">
                            <input class="form-control" type="text" name="brand_case[{$k}][case_name]" value="{$v['case_name']}">

                        </td>
                        <td class="btns">
                            <i class="fa fa-long-arrow-up" onclick="uploader2.UploadFiles.up(this)"></i>
                            <i class="fa fa-long-arrow-down" onclick="uploader2.UploadFiles.down(this)"></i>
                            <i class="fa fa-trash-o" onclick="uploader2.UploadFiles.remove(this)"></i>
                        </td>
                    </tr>
                {/foreach}
                </tbody>
            </table>
        {*</div>*}
    </div>


    {******************************************品牌案例 end *****************************************}

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