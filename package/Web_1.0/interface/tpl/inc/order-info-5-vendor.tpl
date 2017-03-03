<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <form class="form-horizontal" action="{$_root}order_operate" method="post">
                <input type="hidden" name="action" value="vendor_complete">
                <input type="hidden" name="order_no" value="{$orderinfo['order_no']}">

                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h4 class="modal-title" id="myModalLabel">
                        交易结算</h4>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label class="col-sm-3 control-label">应付金额</label>

                        <div class="col-sm-5">
                            <div class="input-group">
                                <input type="text" class="form-control" value="{$orderinfo['order_complete']['应付金额']|default:$orderinfo['order_conform']['交易总计']}" readonly name="data[实付金额]">

                                <div class="input-group-addon">
                                    元
                                </div>
                            </div>
                            <input type="hidden" class="form-control" value="{$orderinfo['order_conform']['交易总计']}" name="data[应付金额]">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">实付金额</label>

                        <div class="col-sm-5">
                            <div class="input-group">
                                <input type="text" class="form-control" placeholder="Amount" value="{$orderinfo['order_price'] - $orderinfo['order_price_settle_in'] +($orderinfo['order_complete']['结算金额'])}" readonly name="data[实付金额]">
                                <div class="input-group-addon">
                                    元
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">结算金额</label>

                        <div class="col-sm-5">
                            <div class="input-group">
                                <input type="text" class="form-control" disabled placeholder="Amount" value="{$orderinfo['order_complete']['结算金额']}" readonly name="data[实付金额]">
                                <div class="input-group-addon">
                                    元
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">交易密码</label>

                        <div class="col-sm-5">
                            <input type="password" class="form-control" name="password2">
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">
                        取消
                    </button>
                    <button type="submit" class="btn btn-primary">
                        确认结算
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>