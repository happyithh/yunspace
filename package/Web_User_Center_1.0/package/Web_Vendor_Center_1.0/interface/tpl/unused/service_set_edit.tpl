<!DOCTYPE html>
<!--[if IE 8]>
<html lang="en" class="ie8 no-js"> <![endif]-->
<!--[if IE 9]>
<html lang="en" class="ie9 no-js"> <![endif]-->
<!--[if !IE]><!-->
<html lang="en" class="no-js">
<!--<![endif]-->
<head>
    {include 'Web_User_Center::inc/html_head.tpl' theme='blue'}
</head>
<body>
{include 'Web_User_Center::inc/header_top.tpl' color='#0b679e'}
<div class="clearfix"></div>
<div class="page-container">
    {include 'inc/header_nav.tpl' index=0}

    <div class="page-content-wrapper">
        <div class="page-content">
            <!-- BEGIN PAGE HEADER-->
            <h3 class="page-title" style="float: left;">
                配套服务编辑
            </h3>
            <a href="#" class="back"><<返回</a>
            <div class="clear"></div>
            <div class="portlet">
                <div class="portlet-body">
                     <div>

                         <div class="service_content">
                            <form>
                            <!-- 添加视频弹窗 -->
                            <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                            <h4 class="modal-title" id="myModalLabel">添加视频</h4>
                                        </div>
                                        <div class="modal-body">
                                            <div class="container-fluid">
                                                <div class="row">
                                                    <div class="form-group" style="height: auto; overflow: hidden; padding: 10px 0px;">
                                                        <label class="col-md-3 control-label">视频名称：</label>
                                                        <div class="col-md-9">
                                                            <input class="form-control input-lg" placeholder="请输入视频名称" type="text">
                                                        </div>
                                                    </div>
                                                    <div class="form-group" style="height: auto; overflow: hidden;">
                                                        <label class="col-md-3 control-label">第三方视频地址：</label>
                                                        <div class="col-md-9">
                                                            <input type="text" class="form-control input-sm">
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                                            <button type="button" class="btn btn-success">添加</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                                <div class="container-fluid">
                                    <div class="row">
                                         <div class="form-group" style="height: auto; overflow: hidden; padding: 10px 0px; background-color: #f8f8f8;">
                                              <label class="col-md-2 control-label"><b>服务名称：</b></label>
                                                    <div class="col-md-10">
                                                        <input class="form-control input-lg" placeholder="请输入服务名称" type="text">
                                                    </div>
                                         </div>
                                         <div class="form-group" style="height: auto; overflow: hidden;">
                                            <label class="col-md-2 control-label"><b>服务分类：</b></label>

                                            <div class="col-md-5">
                                                <select class="form-control input-sm">
                                                    <option>服务类型</option>
                                                    <option>服务类型</option>
                                                    <option>服务类型</option>
                                                    <option>服务类型</option>
                                                    <option>服务类型</option>
                                                </select>
                                            </div>
                                            <div class="col-md-5">
                                                <select class="form-control input-sm">
                                                    <option>服务子类</option>
                                                    <option>服务子类</option>
                                                    <option>服务子类</option>
                                                    <option>服务子类</option>
                                                    <option>服务子类</option>
                                                </select>
                                            </div>
                                        </div>
                                         <div class="form-group" style="height: auto; overflow: hidden;">
                                            <label class="col-md-2 control-label"><b>服务标签：</b></label>
                                            <div class="col-md-10">
                                                <input type="text" class="form-control input-sm">
                                            </div>
                                        </div>
                                         <div class="col-md-12"><h5><b>服务标准：</b></h5></div>
                                         <div class="service_standard_border">
                                              <div class="col-md-6">
                                                  <div class="form-group">
                                                      <label>细节描述</label>
                                                      <textarea class="form-control" rows="3"></textarea>
                                                  </div>
                                              </div>
                                              <div class="col-md-1">
                                                  <div class="form-group">
                                                      <label>数量</label>
                                                      <input class="form-control input-sm" type="text">
                                                  </div>
                                              </div>
                                              <div class="col-md-1">
                                                  <div class="form-group">
                                                      <label>单位</label>
                                                      <input class="form-control input-sm" type="text">
                                                  </div>
                                              </div>
                                              <div class="col-md-1">
                                                  <div class="form-group">
                                                      <label>时间</label>
                                                      <input class="form-control input-sm" type="text">
                                                  </div>
                                              </div>
                                              <div class="col-md-1">
                                                  <div class="form-group">
                                                      <label>单价</label>
                                                      <input class="form-control input-sm" type="text">
                                                  </div>
                                              </div>
                                              <div class="col-md-2">
                                                  <div class="form-group">
                                                      <label>备注</label>
                                                      <input class="form-control input-sm" type="text">
                                                  </div>
                                              </div>
                                         </div>
                                        {include 'Web_User_Center::inc/service_edit_pic_upload.tpl'}
                                        <div class="col-md-12" style="margin-top: 20px; padding: 0px;">
                                            <h5><b>视频添加：</b></h5>
                                            <h5><button type="button" class="btn btn-xs btn-success icon-upload-alt" data-toggle="modal" data-target="#myModal" style="padding: 8px 12px;">
                                                    <i class=" fa fa-plus pr5"></i>添加视频
                                                </button></h5>
                                            <table class="table table-striped table-bordered table-advance table-hover table-service">
                                                <thead>
                                                <tr>

                                                    <th>视频名称</th>
                                                    <th>第三方视频地址</th>
                                                    <th>操作</th>
                                                </tr>
                                                </thead>
                                                <tbody>
                                                <tr>

                                                    <td>ChianJoy游戏展视频</td>
                                                    <td><a href="#" class="a">http://www.iqiyi.com/v_19rrno1tc8.html#vfrm=2-3-0-1</a> </td>
                                                    <td class="btns">
                                                        <i class="fa fa-long-arrow-up" onclick="UploadFiles.up(this)"></i>
                                                        <i class="fa fa-long-arrow-down" onclick="UploadFiles.down(this)"></i>
                                                        <i class="fa fa-trash-o" onclick="UploadFiles.remove(this)"></i>
                                                    </td>

                                                </tr>
                                                <tr>

                                                    <td>ChianJoy游戏展视频</td>
                                                    <td><a href="#" class="a">http://www.iqiyi.com/v_19rrno1tc8.html#vfrm=2-3-0-1</a> </td>
                                                    <td class="btns">
                                                        <i class="fa fa-long-arrow-up" onclick="UploadFiles.up(this)"></i>
                                                        <i class="fa fa-long-arrow-down" onclick="UploadFiles.down(this)"></i>
                                                        <i class="fa fa-trash-o" onclick="UploadFiles.remove(this)"></i>
                                                    </td>

                                                </tr>
                                                </tbody>
                                            </table>
                                        </div>

                                        <div class="col-md-12" style="margin-top: 20px; padding: 0px;">
                                            <div class="col-md-12" style="overflow: hidden; height: auto; padding: 0px;">
                                                <h5 class="pull-left"><b>案例添加：</b></h5>
                                                <div class="btn btn-xs btn-default btn-new pull-right" style="margin-bottom: 5px;">
                                                        <i class=" fa fa-plus pr5"></i>添加案例
                                                    </div>
                                            </div>
                                            <div class="clear"></div>
                                            <table class="table table-striped table-bordered table-advance table-hover table-service">
                                                <thead>
                                                <tr>
                                                    <th></th>
                                                    <th>活动名称</th>
                                                    <th>活动类型</th>
                                                    <th>行业标签</th>
                                                    <th>当前状态</th>
                                                    <th colspan="2">操作</th>

                                                </tr>
                                                </thead>
                                                <tbody>
                                                <tr>
                                                    <td>
                                                        <label>
                                                            <input type="checkbox">
                                                        </label>
                                                    </td>
                                                    <td>ChianJoy游戏展</td>
                                                    <td>展览展会</td>
                                                    <td><a href="#" class="a">游戏</a></td>
                                                    <td>
                                                        <select class="form-control">
                                                            <option>上线</option>
                                                            <option>下线</option>
                                                        </select>
                                                    </td>
                                                    <td>
                                                        <a href="#" target="_blank" class="btn btn-xs btn-info">编辑</a>
                                                    </td>
                                                    <td>
                                                        <a href="#" target="_blank" class="btn btn-xs btn-danger">删除</a>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <label>
                                                            <input type="checkbox">
                                                        </label>
                                                    </td>
                                                    <td>ChianJoy游戏展</td>
                                                    <td>展览展会</td>
                                                    <td><a href="#" class="a">游戏</a></td>
                                                    <td>
                                                        <select class="form-control">
                                                            <option>上线</option>
                                                            <option>下线</option>
                                                        </select>
                                                    </td>
                                                    <td>
                                                        <a href="#" target="_blank" class="btn btn-xs btn-info">编辑</a>
                                                    </td>
                                                    <td>
                                                        <a href="#" target="_blank" class="btn btn-xs btn-danger">删除</a>
                                                    </td>
                                                </tr>
                                                </tbody>
                                            </table>
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

                <!-- END BUTTONS PORTLET-->
            </div>
        </div>


    </div>
</div>
</div>

{include 'Web_User_Center::inc/html_form.tpl'}

{include 'Web_User_Center::inc/footer_inbox.tpl'}
{include 'Web_User_Center::inc/footer_script.tpl'}

</body>
</html>