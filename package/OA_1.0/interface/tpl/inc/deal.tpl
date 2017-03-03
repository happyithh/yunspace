<div class="container-fluid">
    <div class="row mb10">
        <div class="col-md-6">
            <div class="form-group">
                <label class="col-md-3 control-label">业务类型</label>
                <div class="col-md-9">
                    <select class="form-control input-sm">
                        <option>Option 1</option>
                        <option>Option 2</option>
                        <option>Option 3</option>
                        <option>Option 4</option>
                        <option>Option 5</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="form-group">
                <label class="col-md-3 control-label">业务子类</label>
                <div class="col-md-9">
                    <select class="form-control input-sm">
                        <option>Option 1</option>
                        <option>Option 2</option>
                        <option>Option 3</option>
                        <option>Option 4</option>
                        <option>Option 5</option>
                    </select>
                </div>
            </div>
        </div>
    </div>
    <div class="row mb10">
        <div class="col-md-6">
            <div class="form-group">
                <label class="col-md-3 control-label">开始日期</label>
                <div class="col-md-9">
                    <div class="form-group che">
                        {if $start_time}
                            <input type='text' class="form-control" readonly value="{date('Y-m-d',$end_time)}"/>
                        {else}
                            <div class='input-group date' id='datetimepicker2'>
                                <input type='text' class="form-control" placeholder="请选择" name="data[end_date]"/>
                            <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span>
                            </span>
                            </div>
                        {/if}
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="form-group">
                <label class="col-md-3 control-label">结束日期</label>
                <div class="col-md-9">
                    <div class="form-group che">
                        {if $start_time}
                            <input type='text' class="form-control" readonly value="{date('Y-m-d',$end_time)}"/>
                        {else}
                            <div class='input-group date' id='datetimepicker2'>
                                <input type='text' class="form-control" placeholder="请选择" name="data[end_date]"/>
                            <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span>
                            </span>
                            </div>
                        {/if}
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="row mb10">
        <div class="col-md-12 mb10">
            <div class="radio-list">
                <label class="radio-inline">
                    <div id="uniform-optionsRadios4" class="radio"><input name="optionsRadios" id="optionsRadios4" value="option1" checked="" type="radio"></div>&nbsp; 上周</label>
                <label class="radio-inline">
                    <div id="uniform-optionsRadios5" class="radio"><input name="optionsRadios" id="optionsRadios5" value="option2" type="radio"></div>&nbsp; 上月
                </label>
                <label class="radio-inline">
                    <div id="uniform-optionsRadios5" class="radio"><input name="optionsRadios" id="optionsRadios5" value="option2" type="radio"></div>&nbsp; 上季度
                </label>
                <label class="radio-inline">
                    <div id="uniform-optionsRadios5" class="radio"><input name="optionsRadios" id="optionsRadios5" value="option2" type="radio"></div>&nbsp; 上年度
                </label>
            </div>
        </div>
        <div class="col-md-12"> <a href="?action=edit" class="btn btn-primary">搜索</a></div>
    </div>
</div>
<hr class="hr1">
<div class="portlet-body">
    <div class="table-scrollable">
        <table class="table table-striped table-bordered table-hover">
            <thead>
            <tr>
                <th scope="col">排名</th>
                <th scope="col">员工</th>
                <th scope="col">新增订单数量</th>
                <th scope="col">交易签约数量</th>
                <th scope="col">交易签约金额</th>
                <th scope="col">交易利润金额</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td>Table data</td>
                <td>Table data</td>
                <td>Table data</td>
                <td>Table data</td>
                <td>Table data</td>
                <td>Table data</td>
            </tr>
            <tr>
                <td>Table data</td>
                <td>Table data</td>
                <td>Table data</td>
                <td>Table data</td>
                <td>Table data</td>
                <td>Table data</td>
            </tr>
            <tr>
                <td>Table data</td>
                <td>Table data</td>
                <td>Table data</td>
                <td>Table data</td>
                <td>Table data</td>
                <td>Table data</td>
            </tr>
            <tr>
                <td>Table data</td>
                <td>Table data</td>
                <td>Table data</td>
                <td>Table data</td>
                <td>Table data</td>
                <td>Table data</td>
            </tr>
            <tr>
                <td class="total">总计</td>
                <td colspan="5" class="total"></td>

            </tr>
            </tbody>
        </table>
    </div>
    <a href="?action=edit" class="btn btn-success">数据导出</a>
</div>