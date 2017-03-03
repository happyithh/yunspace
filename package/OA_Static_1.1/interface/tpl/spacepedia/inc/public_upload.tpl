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
            <a href="javascript:;" data-toggle="tab">外景图片</a>
        </li>
        <li class="tab_li">
            <a href="javascript:;" data-toggle="tab">内景图片</a>
        </li>
        <li class="tab_li">
            <a href="javascript:;" data-toggle="tab">平面图</a>
        </li>
        <li class="tab_li">
            <a href="javascript:;" data-toggle="tab">视频</a>
        </li>
    </ul>

    {******************************************外景图片 start *****************************************}

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
                    <th width="80">缩略图</th>
                    <th>名称</th>
                    <th width="60">操作</th>
                </tr>
                <tr class="hidden">
                    <td>
                        <img src="" style="height: 80px; width: 80px; display: block;">
                    </td>
                    <td>
                        <input type="hidden" name="data[media1][外景图片][$$][path]">
                        <input class="form-control" type="text" name="data[media1][外景图片][$$][name]">
                        <input class="form-control" type="text" name="data[media1][外景图片][$$][tags]" value="外景图片">
                    </td>
                    <td class="btns">
                        <i class="fa fa-long-arrow-up" onclick="uploader.UploadFiles.up(this)"></i>
                        <i class="fa fa-long-arrow-down" onclick="uploader.UploadFiles.down(this)"></i>
                        <i class="fa fa-trash-o" onclick="uploader.UploadFiles.remove(this)"></i>
                    </td>
                </tr>
                </thead>
                <tbody id="upload_files">
                {foreach $data_edit['data_backup']['media1']['外景图片'] as $k=>$v}
                    <tr>
                        <td>
                            <img src="{$v['path']}" style="height: 80px; width: 80px; ">
                        </td>
                        <td>
                            <input type="hidden" name="data[media1][外景图片][{$k}][path]" value="{$v['path']}">
                            <input class="form-control" type="text" name="data[media1][外景图片][{$k}][name]"
                                   value="{$v['name']}">
                            <input type="hidden" name="data[media1][外景图片][{$k}][tags]" value="外景图片">
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


    {******************************************外景图片 end *****************************************}


    {******************************************内景图片 start *****************************************}


    <div class="tab-content">
        <!--      ---------------------------图片/视频  start-------------------------------      -->
        {*<div class="tab-pane active">*}
            <div id="filelist2">您的浏览器不支持 Flash, Silverlight 或 HTML5。
            </div>
            <br/>
            <div id="container2">
                <button id="pickfiles2" type="button" class="btn btn-success">
                    <i class="icon-folder-open"></i> 立即上传
                </button>
                <br/><span style="font-size:12px; ">(请上传格式为.rar,.pdf或.jpg,.gif,.png,.jpeg的文件，大小不能超过10MB)</span>
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
                        <input type="hidden" name="data[media1][内景图片][$$][path]">
                        <input class="form-control" type="text" name="data[media1][内景图片][$$][name]">
                        <input class="form-control" type="text" name="data[media1][内景图片][$$][tags]" value="内景图片">
                    </td>
                    <td class="btns">
                        <i class="fa fa-long-arrow-up" onclick="uploader2.UploadFiles.up(this)"></i>
                        <i class="fa fa-long-arrow-down" onclick="uploader2.UploadFiles.down(this)"></i>
                        <i class="fa fa-trash-o" onclick="uploader2.UploadFiles.remove(this)"></i>
                    </td>
                </tr>
                </thead>
                <tbody id="upload_files2">
                {foreach $data_edit['data_backup']['media1']['内景图片'] as $k=>$v}
                    <tr>
                        <td>
                            <img src="{$v['path']}" style="height: 80px; width: 80px; ">
                        </td>
                        <td>
                            <input type="hidden" name="data[media1][内景图片][{$k}][path]" value="{$v['path']}">
                            <input class="form-control" type="text" name="data[media1][内景图片][{$k}][name]"
                                   value="{$v['name']}">
                            <input type="hidden" name="data[media1][内景图片][{$k}][tags]" value="内景图片">

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


    {******************************************内景图片 end *****************************************}


    {******************************************平面图 start *****************************************}


    <div class="tab-content">
        <!--      ---------------------------图片/视频  start-------------------------------      -->
        {*<div class="tab-pane active">*}
            <div id="filelist3">您的浏览器不支持 Flash, Silverlight 或 HTML5。
            </div>
            <br/>
            <div id="container3">
                <button id="pickfiles3" type="button" class="btn btn-success">
                    <i class="icon-folder-open"></i> 立即上传
                </button>
                <br/><span style="font-size:12px; ">(请上传格式为.rar,.pdf或.jpg,.gif,.png,.jpeg的文件，大小不能超过10MB)</span>
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
                        <input type="hidden" name="data[media1][平面图][$$][path]">
                        <input class="form-control" type="text" name="data[media1][平面图][$$][name]">
                        <input class="form-control" type="text" name="data[media1][平面图][$$][tags]" value="平面图">
                    </td>
                    <td class="btns">
                        <i class="fa fa-long-arrow-up" onclick="uploader3.UploadFiles.up(this)"></i>
                        <i class="fa fa-long-arrow-down" onclick="uploader3.UploadFiles.down(this)"></i>
                        <i class="fa fa-trash-o" onclick="uploader3.UploadFiles.remove(this)"></i>
                    </td>
                </tr>
                </thead>
                <tbody id="upload_files3">
                {foreach $data_edit['data_backup']['media1']['平面图'] as $k=>$v}
                    <tr>
                        <td>
                            <img src="{$v['path']}" style="height: 80px; width: 80px; ">
                        </td>
                        <td>
                            <input type="hidden" name="data[media1][平面图][{$k}][path]" value="{$v['path']}">
                            <input class="form-control" type="text" name="data[media1][平面图][{$k}][name]"
                                   value="{$v['name']}">
                            <input type="hidden" name="data[media1][平面图][{$k}][tags]" value="平面图">

                        </td>
                        <td class="btns">
                            <i class="fa fa-long-arrow-up" onclick="uploader3.UploadFiles.up(this)"></i>
                            <i class="fa fa-long-arrow-down" onclick="uploader3.UploadFiles.down(this)"></i>
                            <i class="fa fa-trash-o" onclick="uploader3.UploadFiles.remove(this)"></i>
                        </td>
                    </tr>
                {/foreach}
                </tbody>
            </table>
        {*</div>*}
    </div>


    {******************************************平面图 end *****************************************}


    {******************************************视频 start *****************************************}


    <div class="tab-content">
        <!--      ---------------------------图片/视频  start-------------------------------      -->
        {*<div class="tab-pane active">*}
            <div id="filelist4">您的浏览器不支持 Flash, Silverlight 或 HTML5。
            </div>
            <br/>
            <div id="container4">
                <button id="pickfiles4" type="button" class="btn btn-success">
                    <i class="icon-folder-open"></i> 立即上传
                </button>
                <br/><span style="font-size:12px; ">(请上传格式为.rar,.pdf或.jpg,.gif,.png,.jpeg的文件，大小不能超过10MB)</span>
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
                        <input type="hidden" name="data[media1][视频][$$][path]">
                        <input class="form-control" type="text" name="data[media1][视频][$$][name]">
                        <input class="form-control" type="text" name="data[media1][视频][$$][tags]" value="视频">
                    </td>
                    <td class="btns">
                        <i class="fa fa-long-arrow-up" onclick="uploader4.UploadFiles.up(this)"></i>
                        <i class="fa fa-long-arrow-down" onclick="uploader4.UploadFiles.down(this)"></i>
                        <i class="fa fa-trash-o" onclick="uploader4.UploadFiles.remove(this)"></i>
                    </td>
                </tr>
                </thead>
                <tbody id="upload_files4">
                {foreach $data_edit['data_backup']['media1']['视频'] as $k=>$v}
                    <tr>
                        <td>
                            <img src="{$v['path']}" style="height: 80px; width: 80px; ">
                        </td>
                        <td>
                            <input type="hidden" name="data[media1][视频][{$k}][path]" value="{$v['path']}">
                            <input class="form-control" type="text" name="data[media1][视频][{$k}][name]"
                                   value="{$v['name']}">
                            <input type="hidden" name="data[media1][视频][{$k}][tags]" value="视频">

                        </td>
                        <td class="btns">
                            <i class="fa fa-long-arrow-up" onclick="uploader4.UploadFiles.up(this)"></i>
                            <i class="fa fa-long-arrow-down" onclick="uploader4.UploadFiles.down(this)"></i>
                            <i class="fa fa-trash-o" onclick="uploader4.UploadFiles.remove(this)"></i>
                        </td>
                    </tr>
                {/foreach}
                </tbody>
            </table>
        {*</div>*}
    </div>

    {******************************************视频 end *****************************************}


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
    var uploader3 = newUploader('container3','pickfiles3','filelist3','upload_files3')
    var uploader4 = newUploader('container4','pickfiles4','filelist4','upload_files4')

</script>