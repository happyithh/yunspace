<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <form class="form-horizontal" action="{$_root}order_operate" method="post">
                <input type="hidden" name="action" value="buyer_complete">
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
                        <label for="inputEmail3" class="col-sm-3 control-label">订单评价</label>

                        <div class="col-sm-9">
                            <label class="radio-inline">
                                <input type="radio" name="data[订单评价]" value="5" checked>
                                5
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="data[订单评价]" value="4">
                                4
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="data[订单评价]" value="3">
                                3
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="data[订单评价]" value="2">
                                2
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="data[订单评价]" value="1">
                                1
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">问题意见</label>

                        <div class="col-sm-8">
                            <textarea class="form-control" name="data[问题意见]">{$orderinfo['order_complete']['问题意见']}</textarea>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">订单金额</label>

                        <div class="col-sm-5">
                            <div class="input-group">
                                <input type="text" class="form-control" value="{$orderinfo['order_complete']['订单金额']|default:$orderinfo['order_conform']['交易总计']}" readonly>

                                <div class="input-group-addon">
                                    元
                                </div>
                            </div>
                            <input type="hidden" class="form-control" value="{$orderinfo['order_conform']['交易总计']}" name="data[订单金额]">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">待结算金额</label>

                        <div class="col-sm-5">
                            <div class="input-group">
                                <input type="text" class="form-control" value="{$orderinfo['order_price_settle']}" readonly name="data[待结算金额]">

                                <div class="input-group-addon">
                                    元
                                </div>
                            </div>
                            <input type="hidden" class="form-control" value="{$orderinfo['order_price_settle']}" name="data[待结算金额]">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">结算金额</label>

                        <div class="col-sm-5">
                            <div class="input-group">
                                <input type="text" disabled class="form-control" placeholder="Amount" value="{$orderinfo['order_complete']['结算金额']|default:$orderinfo['order_price_settle_in']}" name="data[结算金额]">
                                <div class="input-group-addon">
                                    元
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">发票</label>
                        <div class="col-sm-5">
                            <label class="checkbox-inline"><input class="" type="checkbox" name="data[确认已收到发票]" value="有" {if $orderinfo['order_complete']['确认已收到发票']}checked="checked" {/if}>
                                确认已收到发票</label>
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