<!DOCTYPE html>
<!--[if IE 8]>
<html lang="en" class="ie8 no-js"> <![endif]-->
<!--[if IE 9]>
<html lang="en" class="ie9 no-js"> <![endif]-->
<!--[if !IE]><!-->
<html lang="en" class="no-js">
<!--<![endif]-->
<head>
    {include 'Web_User_Center::inc/html_head.tpl'}
</head>
<body>
{include 'Web_User_Center::inc/header_top.tpl'}
<div class="clearfix"></div>
<div class="page-container">
    {include 'Web_User_Center::inc/header_nav.tpl' index=3}

    <div class="page-content-wrapper">
        <div class="page-content" style="min-height:973px">
            <h3 class="page-title pull-left" style="width:1000px;"> 个人信息管理</h3>

                  <div class="row">
                    <div class="col-md-6" style="margin:auto;">
                        <div class="portlet">
                            <div class="portlet-title">
                                <div class="caption">
                                    <i class="fa fa-reorder"></i>账户信息设置
                                </div>
                                <div class="tools">
                                    <a href="javascript:;" class="collapse"></a>
                                    <a href="ui_tabs_accordions_navs.html#portlet-config" data-toggle="modal" class="config"></a>
                                </div>
                            </div>
                            <div class="portlet-body">
                                <div class="tab-content">
                                    <div class="tab-pane fade active in" id="tab_1_1">
                                        <form role="form" style="margin:auto">
                                            <div class="form-body">
                                                <h3>基本信息修改</h3>
                                                <div class="form-group">
                                                    <label>用户名</label>
                                                    <input type="text" class="form-control" placeholder="Disabled" disabled>
                                                </div>

                                                <div class="form-group">
                                                    <label>账户等级</label>
                                                    <input type="text" class="form-control" placeholder="Disabled" disabled>
                                                </div>
                                                <div class="form-group">
                                                    <label for="exampleInputEmail1">账户信息</label>
                                                    <input type="email" class="form-control" id="exampleInputEmail1" placeholder="Enter text">
                                                </div>

                                                <div class="form-group">
                                                    <label>电子邮箱</label>
                                                    <div class="input-group">
                                                    <span class="input-group-addon">
                                                    <i class="fa fa-envelope"></i>
                                                    </span>
                                                        <input type="text" class="form-control" placeholder="Email Address">
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label>安全等级</label>
                                                    <select class="form-control">
                                                        <option>低</option>
                                                        <option>中</option>
                                                        <option>高</option>
                                                    </select>
                                                </div>

                                                <div class="form-group">
                                                    <label>上传头像</label>
                                                    <input type="file"/><img src="#" alt="tupian"/>
                                                </div>




                                                <div class="form-actions">
                                                    <button type="submit" class="btn btn-info" >提交</button>
                                                    <button type="button" class="btn btn-default">取消</button>
                                                </div>
                                            </div>
                                        </form>
                                    </div>
                                    <div class="tab-pane fade active in" id="tab_1_2">
                                        <form role="form" style="margin:auto">
                                            <div class="form-body">
                                                <h3>密码修改</h3>
                                                <div class="form-group">
                                                    <label>原始密码</label>
                                                    <input type="password" class="form-control" placeholder="password" >
                                                </div>

                                                <div class="form-group">
                                                    <label>修改密码</label>
                                                    <input type="password" class="form-control" placeholder="password" >
                                                </div>
                                                <div class="form-group">
                                                    <label>确认密码</label>
                                                    <input type="password" class="form-control" placeholder="password" >
                                                </div>

                                                <div class="form-actions">
                                                    <button type="submit" class="btn btn-info" >确认修改</button>
                                                    <button type="button" class="btn btn-default">取消</button>
                                                </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                  </div>

               <div class="clearfix"></div>
        </div>
    </div>
</div>

<div style="margin-top:50px;" class="mt50"></div>
{include file="Web_Static::v2.0/html_footer.tpl"}
{include 'Web_User_Center::inc/footer_script.tpl'}

</body>
</html>