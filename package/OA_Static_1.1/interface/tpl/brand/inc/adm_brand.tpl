<div class="portlet tabbable">
    <div class="portlet-title">
        <div class="caption">
            <i class="fa fa-search"></i>搜索条件
        </div>
        <div style="float: right;">
            <a href="?action=add" class="btn btn-info btn-xs" style="font-size:15px!important;"><i
                        class="fa fa-plus"></i>添加ADM参展商户</a>&nbsp;&nbsp;
            {*<a href="?action=site_list" class="btn btn-success btn-xs" style="font-size:15px!important;"><i*}
            {*class="fa "></i>广告位管理</a>&nbsp;&nbsp;*}
        </div>
    </div>
    <div class="portlet-body">
        <div class="portlet-tabs">
            <div class="clearfix"></div>
            <div>
                <form action="?" method="get" class="clearfix">
                    <input type="hidden" name="type" value="{$type}">

                    <div class="form-body clearfix">
                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">品牌/商品名称</label>

                            <div class="col-md-5">
                                <input type='text' class="form-control" placeholder="品牌/商品名称"
                                       name="search[advertising_title]"
                                       value="{$_REQUEST['search']['advertising_title']}"/>
                            </div>
                        </div>
                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">创建时间</label>

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
                    <div class="form-body clearfix">
                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">状态</label>

                            <div class="col-md-5">
                                <select class="form-control input-sm" name="search[status]">
                                    <option value=0>全部</option>
                                    <option {if $_REQUEST['search']['status']==1}selected {/if} value=1>上线</option>
                                    <option {if $_REQUEST['search']['status']==-1}selected {/if} value=-1>下线</option>
                                    <option {if $_REQUEST['search']['status']==-2}selected {/if} value=-2>已删除</option>

                                </select>
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

    <div class="portlet-body">
        <div class="table-responsive clearfix">
            <table class="table table-striped table-bordered table-hover" id="data_table" style="word-break: break-all">
                <thead>
                <tr>
                    <th>ID</th>
                    <th width="10%">品牌/商户名称</th>
                    <th  width="20%">品牌/商户介绍</th>
                    {*<th width="15%">视频链接</th>*}
                    <th>状态</th>
                    <th>创建时间</th>
                    <th>更新时间</th>
                    <th>浏览量</th>
                    <th>操作</th>
                </tr>
                </thead>
                {foreach $data['rows'] as $k=>$v}
                    <tr>
                        <td style="width: 5%">{$v['id']}</td>
                        <td style="width: 10%">{$v['title']}</td>
                        <td style="width: 35%">{mb_substr($v['des'],0,120)}{if !empty($v['des'])}. . .{/if}</td>
                        {*<td><a href="{$v['attr']['video_url']}" target="_blank">{$v['attr']['video_url']}</td>*}
                        <td>{if $v['status']==1}上线{else}下线{/if}</td>
                        <td>{if !empty($v['create_time'])}{date('Y-m-d H:i:s',$v['create_time'])}{/if}</td>
                        <td>{if !empty($v['update_time'])}{date('Y-m-d H:i:s',$v['update_time'])}{/if}</td>
                        <td>{$v['click']}</td>
                        <td>
                            {if $v['status']==-1}
                                <a href="?action=update&id={$v['id']}&status=1" class="btn btn-danger btn-xs"><i
                                            class="fa fa-eye"></i>
                                    恢复</a>
                            {else}
                            <a href="?action=add&id={$v['id']}" class="btn btn-info btn-xs"><i
                                        class="fa fa-pencil"></i>
                                修改</a>
                            <a href="?action=delete&id={$v['id']}" class="btn btn-danger btn-xs"><i
                            class="fa fa-eye"></i>
                            删除</a>
                            {/if}
                        </td>
                    </tr>
                {/foreach}
                <tbody>

            </table>
            <div class="pull-left" style="width:30%; padding: 10px 0;">

            </div>
            <div class="pull-right">
                <ul class="pagination">
                    {if $data['page']['dpll']}
                        <li class="prev">
                            <a href="{$data['page']['dup']}1" title="First"><i class="fa fa-angle-double-left"></i></a>
                        </li>
                        <li class="prev">
                            <a href="{$data['page']['dup']}{$data['page']['dp']-1}" title="Prev"><i
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
                    {for $i=$data['page']['dpl'] to $data['page']['dpr']}
                        <li{if $i==$data['page']['dp']} class="active"{/if}>
                            <a href="{$data['page']['dup']}{$i}">{$i}</a>
                        </li>
                    {/for}
                    <li class="disabled">
                        <a> {$data['page']['dtp']}
                            ( {$data['page']['dp']*$data['page']['dn']}
                            /{$data['page']['dt']} )</a>
                    </li>

                    {if $data['page']['dprr']}
                        <li class="next">
                            <a href="{$data['page']['dup']}{$data['page']['dp']+1}" title="Next"><i
                                        class="fa fa-angle-right"></i></a>
                        </li>
                        <li class="next">
                            <a href="{$data['page']['dup']}{$data['page']['dtp']}" title="Last"><i
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
