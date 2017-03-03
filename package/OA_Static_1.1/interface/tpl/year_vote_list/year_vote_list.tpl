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
    <link href="css/bootstrap-datetimepicker.min.css" rel="stylesheet"/>


</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->

<body style="background:#FaFaFa !important">


<div class="portlet tabbable">
    <div class="portlet-title">
        <div class="caption">
            <i class="fa fa-search"></i>搜索条件
        </div>
    </div>
    <div class="portlet-body">
        <div class="portlet-tabs">
            <div class="clearfix"></div>
            <div>
                <form action="?" method="get" class="clearfix">
                    <input type="hidden" name="handle_type" value="{$handle_type}">
                    <div class="form-body clearfix">
                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">年会主题</label>
                            <div class="col-md-9">
                                <select class="form-control input-sm" name="search[year_id]">
                                    <option value=''>全部
                                    </option>
                                        <option {if {$_REQUEST['search']['year_id']==1}}selected{/if} value="1">文艺表演</option>
                                        <option {if {$_REQUEST['search']['year_id']==2}}selected{/if} value="2">度假旅游</option>
                                        <option {if {$_REQUEST['search']['year_id']==3}}selected{/if} value="3">创意内容</option>
                                        <option {if {$_REQUEST['search']['year_id']==4}}selected{/if} value="4">特色餐饮</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">手机号</label>
                            <div class="col-md-9">
                                <input type="text" class="form-control input-sm" placeholder="请填写投票人手机号" name="search[phone]" value="{$_REQUEST['search']['phone']}">
                            </div>
                        </div>
                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">微信昵称</label>
                            <div class="col-md-9">
                                <input type="text" class="form-control input-sm" placeholder="请填写投票人微信昵称" name="search[nickname]" value="{$_REQUEST['search']['nickname']}">
                            </div>
                        </div>
                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">投票时间</label>
                            <div class="col-md-4">
                                <input type='text' class="form-control date" placeholder="请选择开始时间"
                                       name="search[start_time]" value="{$_REQUEST['search']['start_time']}"/>
                            </div>
                            <div class="col-md-4 col-md-offset-1">
                                <input type='text' class="form-control date" placeholder="请选择结束时间"
                                       name="search[end_time]" value="{$_REQUEST['search']['end_time']}"/>
                            </div>
                        </div>
                    </div>
                    <div class="form-actions">
                        <div class="" style="text-align: center">
                            <button type="submit" class="btn btn-primary" style="width: 150px">
                                <i class="fa fa-search"></i>
                                搜索
                            </button>
                        </div>
                    </div>
                </form>
            </div>

        </div>
    </div>
</div>
<div class="portlet">
    <div class="portlet-title">
        <div class="caption">
            <i class="fa fa-comments"></i>
            年会投票数据列表
        </div>
    </div>
    <div class="portlet-tabs">
    </div>
    <div class="portlet-body">
        <div class="table-responsive clearfix">
            <table class="table table-striped table-bordered table-hover" id="data_table" style="word-break: break-all">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>投票账户名</th>
                    <th>微信昵称</th>
                    <th>微信头像</th>
                    <th>手机号</th>
                    <th>投票主题</th>
                    <th>投票时间</th>
                </tr>
                </thead>
                <tbody>
                {foreach $_data['rows'] as $k=>$v}
                    {*<tr role="row">*}
                        {*<td>#{$v['id']}</td>*}
                        {*<td>{$v['username']}</td>*}
                        {*<td>{$v['user_info']['nickname']}</td>*}
                        {*<td>{if !empty($v['user_info']['headimgurl'])}<img src="{$v['user_info']['headimgurl']}" style="width: 35px;height: 35px;"/>{/if}</td>*}
                        {*<td>{$v['phone']}</td>*}
                        {*<td>*}
                            {*{if $v['year_id']==1}文艺表演{elseif $v['year_id']==2}度假旅游{elseif $v['year_id']==3}创意内容{elseif $v['year_id']==4}特色餐饮{/if}*}
                        {*</td>*}
                        {*<td>{date('Y-m-d H:i:s',$v['vote_time'])}</td>*}
                    {*</tr>*}

                    <tr role="row">
                        <td>#{$v->id}</td>
                        <td>{$v->username}</td>
                        <td>{$v->user_info['nickname']}</td>
                        <td>{if !empty($v->user_info['headimgurl'])}<img src="{$v->user_info['headimgurl']}" style="width: 35px;height: 35px;"/>{/if}</td>
                        <td>{$v->phone}</td>
                        <td>
                            {if $v->year_id==1}文艺表演{elseif $v->year_id==2}度假旅游{elseif $v->year_id==3}创意内容{elseif $v->year_id==4}特色餐饮{/if}
                        </td>
                        <td>{date('Y-m-d H:i:s',$v->vote_time)}</td>
                    </tr>

                {/foreach}
                </tbody>
            </table>
            <div class="pull-left" style="width:30%; padding: 10px 0;">
            </div>
            <div class="pull-right">
                <ul class="pagination">
                    {if $_data['page']['dpll']}
                        <li class="prev">
                            <a href="{$_data['page']['dup']}1" title="First"><i class="fa fa-angle-double-left"></i></a>
                        </li>
                        <li class="prev">
                            <a href="{$_data['page']['dup']}{$_data['page']['dp']-1}" title="Prev"><i
                                        class="fa fa-angle-left"></i></a>
                        </li>
                    {else}
                        <li class="prev disabled">
                            <a href="#" title="First"><i class="fa fa-angle-double-left"></i></a>
                        </li>
                        <li class="prev disabled">
                            <a href="#" title="Prev"><i class="fa fa-angle-left"></i></a>
                        </li>
                    {/if}
                    {for $i=$_data['page']['dpl'] to $_data['page']['dpr']}
                        <li{if $i==$_data['page']['dp']} class="active"{/if}>
                            <a href="{$_data['page']['dup']}{$i}">{$i}</a>
                        </li>
                    {/for}
                    <li class="disabled">
                        <a> {$_data['page']['dtp']}
                            ( {$_data['page']['dp']*$_data['page']['dn']}
                            /{$_data['page']['dt']} )</a>
                    </li>

                    {if $_data['page']['dprr']}
                        <li class="next">
                            <a href="{$_data['page']['dup']}{$_data['page']['dp']+1}" title="Next"><i
                                        class="fa fa-angle-right"></i></a>
                        </li>
                        <li class="next">
                            <a href="{$_data['page']['dup']}{$_data['page']['dtp']}" title="Last"><i
                                        class="fa fa-angle-double-right"></i></a>
                        </li>
                    {else}
                        <li class="next disabled">
                            <a href="#" title="Next"><i class="fa fa-angle-right"></i></a>
                        </li>
                        <li class="next disabled">
                            <a href="#" title="Last"><i class="fa fa-angle-double-right"></i></a>
                        </li>
                    {/if}
                </ul>
            </div>
        </div>
    </div>
</div>

<!-- BEGIN JAVASCRIPTS(Load javascripts at bottom, this will reduce page load time) -->
<!-- BEGIN CORE PLUGINS -->
<script src="{$_assets}plugins/jquery-1.11.0.min.js"
        type="text/javascript"></script>
<script src="{$_assets}scripts/_page.js"></script>
<script type="text/javascript" src="js/moment.min.js"></script>
<script type="text/javascript" src="js/zh-cn.js"></script>
<script type="text/javascript" src="js/bootstrap-datetimepicker.min.js"></script>
<script type="text/javascript">
    $(document).ready(function () {
        $('.date').datetimepicker({
            format: 'YYYY-MM-DD',
            locale: 'zh-cn'
        });
    });

    ListOperator = {
        delVendorCandidate: function (e) {
            if (!confirm('您确定要删除吗？？')) {
                return false;
            }
            var Candidate_id = $(e).parents('tr').data('pid');
            $.get("?", {
                del: 1,
                id: Candidate_id,
                action: 'vendor_candidate_list'
            }, function (data) {
                top.alert(data.msg);
                if (data.status == 1) {
                    $(e).parents('tr').hide();
                }
            });
        }
    }
</script>
</body>
<!-- END BODY -->
</html>