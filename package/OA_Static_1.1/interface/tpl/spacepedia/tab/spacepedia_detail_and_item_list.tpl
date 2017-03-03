{*--------------------------------------------------------------百科详情 START------------------------------------------*}
<div class="portlet tabbable">
    <div class="portlet-title">
        <div class="caption">
            <i class="fa fa-database"></i>场地百科信息#{$_data[0]['id']}
        </div>
    </div>
    <div class="portlet-body" style="padding:10px 10px">
        <blockquote class="hero">
            <div class="form-body">
                <div class="row">
                    <div class="col-md-3">
                        <div class="col-md-12">
                            <img src="{$_data[0]['logo']}" style="width:100%;height: 100%;"/>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="col-md-12">
                            <div class="form-group">
                                <label class="control-label col-md-4"><strong>百科名称</strong></label>

                                <div class="col-md-8">
                                    <p style="font-size: 14px;">
                                        {$_data[0]['space_name']}
                                    </p>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-12">
                            <div class="form-group">
                                <label class="control-label col-md-4"><strong>百科别名</strong></label>

                                <div class="col-md-8">
                                    <p style="font-size: 14px;">
                                        {$_data[0]['nickname']}
                                    </p>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-12">
                            <div class="form-group">
                                <label class="control-label col-md-4"><strong>所属公司</strong></label>

                                <div class="col-md-8">
                                    <p style="font-size: 14px;">
                                        {$_data[0]['company']}
                                    </p>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-12">
                            <div class="form-group">
                                <label class="control-label col-md-4"><strong>地址</strong></label>

                                <div class="col-md-8">
                                    <p style="font-size: 14px;">
                                        {$_data[0]['addr']}
                                    </p>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-12">
                            <div class="form-group">
                                <label class="control-label col-md-4"><strong>城市</strong></label>

                                <div class="col-md-8">
                                    <p style="font-size: 14px;">
                                        {$_data[0]['city']}
                                    </p>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-12">
                            <div class="form-group">
                                <label class="control-label col-md-4"><strong>类型</strong></label>

                                <div class="col-md-8">
                                    <p style="font-size: 14px;">
                                        {$category_info[$_data[0]['category_id']]["name"]}
                                    </p>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-12">
                            <div class="form-group">
                                <label class="control-label col-md-4"><strong>状态</strong></label>

                                <div class="col-md-8">
                                    <p style="font-size: 14px;">
                                        {if $_data[0]['status']==0}
                                            <span>下线</span>
                                        {elseif $_data[0]['status']==1}
                                            <span>上线</span>
                                        {elseif $_data[0]['status']==2}
                                            <span style="color: #ecbc29;">审核中</span>
                                        {elseif $_data[0]['status']==3}
                                            <span style="color: #f3565d;;">审核未通过</span>
                                        {elseif $_data[0]['status']==-1}
                                            <span style="color: #f3565d;;">已删除</span>
                                        {/if}
                                    </p>
                                </div>
                            </div>
                        </div>

                    </div>
                   {* <div class="col-md-3">
                        <form action="?" method="post" enctype="multipart/form-data">
                            <input type="hidden" name="space_id" value="{$_data[0]['id']}">
                            <input type="hidden" name="action" value="card">
                        <div class="fileinput fileinput-new" data-provides="fileinput">
                            <p class="title" style="font-size: 14px;font-weight:bold">名片/营业执照</p>
                            <div class="fileinput-new thumbnail" style="width: 200px; height: 150px;">
                                {if $card['card']}
                                    {foreach $card['card'] as $key => $val}
                                        <img src="{$val['path']}"  alt="">
                                    {/foreach}
                                {else}
                                    <img src="http://www.placehold.it/200x150/EFEFEF/AAAAAA&amp;text=no+image"
                                         alt=""/>
                                {/if}

                            </div>
                            <div class="fileinput-preview fileinput-exists thumbnail"
                                 style="max-width: 200px; max-height: 150px;"></div>
                            <div style="width: 100%">
                                    <span class="btn btn-default btn-file">
                                        <span class="fileinput-new">更换名片/营业执照</span>
                                        <span class="fileinput-exists">重新选择</span>
                                        <input type="file" name="名片card" accept="image/jpeg,image/png,image/gif">
                                        <input type="hidden" name="card" {foreach $card['card'] as $key => $val} value="{$val['path']}" {/foreach}>
                                    </span>
                                <a href="form_component.html#" class="btn btn-danger fileinput-exists"
                                   data-dismiss="fileinput">移除</a>
                            </div>
                            <span class="required" aria-required="true" style="color: #999;font-size:12px;width:200px">【格式为jpg,png,jpeg，大小不超过2M】
                                                                </span>
                            <br />
                            <button type="submit" class="btn btn-success">
                                提交
                            </button>
                           *}{* <button class="btn btn-success" id="space_card" data-id="{$_data[0]['id']}">提交</button>*}{*
                        </div>
                            </form>
                    </div>*}
                    <div class="col-md-3" >
                        <div>
                            <span class="btn btn-default" style="margin-bottom: 10px;">百科二维码</span>
                        </div>
                        <div class="col-md-12"  data-src="{Page_Site_Global::displayMedia($_data[0]['logo'],"30","30")}" id="code"  style="max-width:170px;max-height: 170px;padding: 10px; border: 1px solid #ddd;border-radius: 4px;">
                        </div>

                    </div>
                    <div class="col-md-2" >
                        <div class="col-md-12" style="margin-bottom: 30px;text-align: right;">
                            <a href="?action=detail&space_id={$_data[0]['id']}&tab_action=edit_space&tab=2" class="btn btn-primary">编辑场地百科</a>
                        </div>
                    </div>
                </div>
            </div>
        </blockquote>
    </div>
</div>

{*--------------------------------------------------------------百科详情 END------------------------------------------*}




{*--------------------------------------------------------------子空间列表 START------------------------------------------*}

<div class="portlet tabbable">
    <div class="portlet-title">
        <div class="caption">
            <i class="fa fa-database"></i>子空间列表
        </div>
    </div>

    <div class="tab-pane active">
        <div class="pull-right">
            <ul class="pagination">
                {if $item_list['page']['dpll']}
                    <li class="prev">
                        <a href="{$item_list['page']['dup']}1" title="First"><i
                                    class="fa fa-angle-double-left"></i></a>
                    </li>
                    <li class="prev">
                        <a href="{$item_list['page']['dup']}{$item_list['page']['dp']-1}" title="Prev"><i
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
                {for $i=$item_list['page']['dpl'] to $item_list['page']['dpr']}
                    <li{if $i==$item_list['page']['dp']} class="active"{/if}>
                        <a href="{$item_list['page']['dup']}{$i}">{$i}</a>
                    </li>
                {/for}
                <li class="disabled">
                    <a> {$item_list['page']['dtp']} ( {$item_list['page']['dp']*$item_list['page']['dn']}
                        /{$item_list['page']['dt']} )</a></li>

                {if $item_list['page']['dprr']}
                    <li class="next">
                        <a href="{$item_list['page']['dup']}{$item_list['page']['dp']+1}" title="Next"><i
                                    class="fa fa-angle-right"></i></a>
                    </li>
                    <li class="next">
                        <a href="{$item_list['page']['dup']}{$item_list['page']['dtp']}" title="Last"><i
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

        <div style=" margin-top: 10px;margin-left: 10px;">
            <a href="?action=detail&tab_action=edit_item&space_id={$_REQUEST['space_id']}"
               class="btn btn-success"><span class="glyphicon glyphicon-plus"></span>添加子空间</a>
        </div>

        <table class="table table-striped table-bordered table-hover" id="data_table" style="word-break: break-all">
            <thead>
            <tr>
                <th>更新时间</th>
                <th>子空间ID</th>
                <th>子空间名称</th>
                <th>城市</th>
                <th>联系人</th>
                <th>手机号</th>
                <th>邮箱</th>
                <th>当前状态</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody>
            {foreach $item_list['rows'] as $key=>$value}
                <tr role="row" data-iid="{$value['id']}">
                    <td>{Func_Time::format($value['update_time'])}</td>
                    <td>{$value['id']}</td>
                    <td>{$value['item_name']}</td>
                    <td>{$value['city']|default:$_data[0]['city']}</td>
                    <td>{$value['contacts']}</td>
                    <td>{$value['phone']}</td>
                    <td>{$value['email']}</td>
                    <td style="position: relative!important;">
                        {if $value['status']==2}
                            <span style="color: #ecbc29;">审核中</span>
                        {elseif $value['status']==0 || $value['status']==1}
                            <select class="form-control input-sm" onchange="OperateSpaceItem.online(this)">
                                <option value="1" {if $value['status']==1}selected {/if}>上线</option>
                                <option value="0" {if $value['status']==0}selected {/if}>下线</option>
                            </select>
                        {elseif $value['status']==3}
                            <span style="color: #f3565d;;">已拒绝</span>
                            <div class="show_reason_item"></div>
                            <a class="btn btn-danger btn-xs alert_reason_item" style="width:60px;"
                               onclick="OperateSpaceItem.alertReason(this)" reason="{$value['refuse_reason']}"
                               style="margin-left: 0px;"><span class="look_reason_item">查看理由</span>
                            </a>
                        {elseif $value['status']==-1}
                            <span style="color: #f3565d;;">已删除</span>
                        {/if}
                    </td>
                    <td>
                        <a href="?action=detail&space_id={$_REQUEST['space_id']}&item_id={$value['id']}&tab_action=edit_item"
                           class="btn btn-primary btn-xs"><i class="fa fa-pencil"></i>修改</a>
                        {if $value['status']==-1}
                            <a href="javascript:;" onclick="OperateSpaceItem.delSpaceItem(this)" data-status="2" class="btn btn-success btn-xs list_size"><i class="fa fa-eye"></i>恢复</a>
                        {else}
                            <a href="javascript:;" onclick="OperateSpaceItem.delSpaceItem(this)" data-status="-1" class="btn btn-danger btn-xs list_size"><i class="fa fa-eye"></i>删除</a>
                        {/if}
                    </td>
                </tr>
            {/foreach}
            </tbody>
        </table>
    </div>
</div>

{*--------------------------------------------------------------子空间列表 END------------------------------------------*}
<link rel="stylesheet" type="text/css" href="{$_assets}plugins/bootstrap-fileinput/bootstrap-fileinput.css"/>
<script type="text/javascript" src="{$_assets}plugins/bootstrap-fileinput/bootstrap-fileinput.js"></script>
{static "qrcode/jquery.qrcode.min.js"}

<script>
    $(document).ready(function(){
        var src="http://"+window.location.host+$("#code").data("src");
        console.log(src);
        //生成二维码
        $("#code").qrcode({
            render: "canvas",
            size:150,
            src:src,
            text: "http://{Core::$urls['host']}/m/site/{Func_Url::str_urlencode($data_edit['data_backup']['space_name'])}-讨论组-PC-Go", //任意内容
            background : "#ffffff",//背景颜色
            foreground: "#000000" //前景颜色
        });
    })


    OperateSpaceItem = {
        online: function (obj) {
            var online = $(obj).val();
            if (online == 0) {
                var msg = "下线";
            } else {
                var msg = "上线";
            }
            var rs = confirm("是否确定" + msg + "该子空间？");
            if (rs == true) {
                var item_id = $(obj).parents('tr').data('iid');
                $.post('http://{Core::$urls['host']}/static/api/space/item/handle.jsonp', {
                    item_id: item_id,
                    status: online,
                    action:'change_status'
                }, function (data) {
                    if(data.status==1){
                        top.alert(" "+data.msg);
                        window.location.reload();
                    }else{
                        top.alert(data.msg);
                    }
                },"json")
            } else {
                $(obj).find("option[value!='" + online + "']").attr("selected", true);
            }
        },
        delSpaceItem: function (e) {
            var status = $(e).attr('data-status');
            if(status==-1 && !confirm('您确定要删除吗？？')){
                return false;

            }
            var item_id = $(e).parents('tr').data('iid');
            $.get('http://{Core::$urls['host']}/static/api/space/item/handle.jsonp', {
                status: status,
                item_id: item_id,
                action: 'change_status'
            }, function (data) {
                if(data.status==1){
                    top.alert(" "+data.msg);
                    window.location.reload();
                }else{
                    top.alert(data.msg);
                }
            },"json");
        },
        alertReason: function (o) {
            var info = $(o).attr('reason');
            $(o).parent().find(".show_reason_item").text(info);
            var height = $(o).parent().outerHeight();
            $(o).parent().find(".show_reason_item").css({
                top: height + "px"
            })
            if ($(o).parent().find(".show_reason_item").hasClass("block")) {
                $(o).parent().find(".show_reason_item").removeClass("block");
                $(o).parent().find(".show_reason_item").html("");
                $(".alert_reason_item").find(".look_reason_item").text("查看理由");
            } else {
                $(o).parent().find(".look_reason_item").text("关闭");
                $(".show_reason_item").removeClass("block");
                $(o).parent().find(".show_reason_item").addClass("block");
            }
        }
    }
</script>