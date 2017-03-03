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
                    <input type="hidden" name="type" value="{$type}">

                    <div class="form-body clearfix">
                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">负责人</label>

                            <div class="col-md-9">
                                <select class="form-control input-sm" name="search[admin_id]">
                                    <option value=0>全部</option>
                                    {foreach $admin as $key=>$value}
                                        <option {if {$_REQUEST['search']['admin_id']==$value['admin_id']}}selected {/if}
                                                value="{$value['admin_id']}">{$value['fullname']}</option>
                                    {/foreach}
                                    <option {if $_REQUEST['search']['admin_id']==9}selected {/if}
                                            value="9">报价系统
                                    </option>
                                </select>
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
                            <label class="col-md-3 control-label">城市</label>

                            <div class="col-md-4">
                                <select class="form-control input-sm" name="search[city]">
                                    <option value=0>全部</option>
                                    {foreach $_REQUEST['cities'] as $value}
                                        {if $is_city_partner==1}
                                            {if $value=='北京' || $value=='深圳' || $value=='广州' || $value=='上海'}{else}
                                                <option {if $value==$_REQUEST['search']['city']}selected {/if}
                                                        value="{$value}">{$value}</option>
                                                {/if}
                                        {else}
                                        <option {if $value==$_REQUEST['search']['city']}selected {/if}
                                                value="{$value}">{$value}</option>
                                        {/if}
                                    {/foreach}
                                </select>
                            </div>
                        </div>

                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">类型</label>

                            <div class="col-md-4">
                                <select class="form-control input-sm" name="search[demandType]">
                                    <option value=0>全部</option>
                                    {foreach $_demandType as $val}
                                        <option value="{$val}"
                                                {if $_REQUEST['search']['demandType'] == $val}selected{/if}>{$val}</option>
                                    {/foreach}
                                </select>
                            </div>
                        </div>

                    </div>
                    <div class="form-body clearfix">
                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">ID</label>

                            <div class="col-md-4">
                                <input type='text' class="form-control " placeholder="需求ID"
                                       name="search[demand_id]" value="{$_REQUEST['search']['demand_id']}"/>
                            </div>
                        </div>
                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">手机号</label>

                            <div class="col-md-6">
                                <input type='text' class="form-control " placeholder="客户手机号"
                                       name="search[phone]" value="{$_REQUEST['search']['phone']}"/>
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
