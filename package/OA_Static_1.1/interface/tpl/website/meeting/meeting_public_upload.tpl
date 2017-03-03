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

    {******************************************品牌案例 start *****************************************}


    <div class="tab-content active" >
        <!--      ---------------------------图片/视频  start-------------------------------      -->
        {*<div class="tab-pane active">*}
            <div id="filelist2">您的浏览器不支持 Flash, Silverlight 或 HTML5。
            </div>
            <br/>
            <div id="container2">
                <button id="pickfiles2" type="button" class="btn btn-success">
                    <i class="icon-folder-open"></i> 立即上传
                </button>
                <br/><span style="font-size:12px; ">(<span style="color: red;font-weight: bolder;">多图上传插件比较慢，点击一次就可以上传多张！！！等到大概5-10秒请耐心等待！！！</span> <br />请上传格式为<span style="color: red;">.jpg,.gif,.png,.jpeg</span>的文件，大小不能超过<span style="color: red;">8MB</span> ; 图片最佳尺寸：<span style="color: red;">600*400</span>)</span>
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
                        <input type="hidden" name="info_img[$$][path]">
                        <input class="form-control" style="margin-bottom: 10px;" type="text" name="info_img[$$][name]"  value="">
                        <input class="form-control" type="text" name="info_img[$$][case_name]" placeholder="图片描述" value="">
                    </td>
                    <td class="btns">
                        <i class="fa fa-long-arrow-up" onclick="uploader2.UploadFiles.up(this)"></i>
                        <i class="fa fa-long-arrow-down" onclick="uploader2.UploadFiles.down(this)"></i>
                        <i class="fa fa-trash-o" onclick="uploader2.UploadFiles.remove(this)"></i>
                    </td>
                </tr>
                </thead>
                <tbody id="upload_files2">
                {foreach $info['info_img'] as $k=>$v}
                    <tr>
                        <td>
                            <img src="{$v['path']}" style="height: 80px; width: 80px; ">
                        </td>
                        <td>
                            <input type="hidden" name="info_img[{$k}][path]" value="{$v['path']}">
                            <input style="margin-bottom: 10px;" class="form-control" type="text" name="info_img[{$k}][name]"
                                   value="{$v['name']}">
                            <input class="form-control" type="text" name="info_img[{$k}][case_name]" value="{$v['case_name']}">

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


    var uploader2 = newUploader('container2','pickfiles2','filelist2','upload_files2')

</script>