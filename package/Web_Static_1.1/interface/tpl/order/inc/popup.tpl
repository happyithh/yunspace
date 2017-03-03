<div class="transfer-popup order-popup">

</div>


<div class="order-popup normal-popup">
    <div class="popup-close">×</div>

{*--------------------用户--------------------*}
    {*预定下单成功*}
    <div class="hide order-success">
        <h2><i class="pop-icon"></i>感谢您的下单，<span class="magenta">商家接单中...</span></h2>
        <p>稍后您可到<span class="black">“采购管理-交易管理”</span>中查看结果!</p>
        {*<a href="" class="btn bg-magenta">知道了</a>*}
    </div>

    {*确认合同*}
    <div class="hide order-conf order-confirm3">
        <h1>确认该合同是与供应商线下签约的合同？</h1>
        <input type="hidden" class="conform_id" name="conform_id">
        <div class="order-confirm hide">
            <div class="secretcode-wp">
                <div class="secretcode">
                    <p class="fl">验证码：</p>
                    <input class="ipt-txt check_code" type="text" name="check_code" placeholder="输入验证码">
                    <input type="hidden" id="buyer-phone-num"  value="{$smarty.session.user.phone}"/>
                    <button class="ipt-submit bg-blue js-send verify-code-send"
                            yun="identify-code.v1.0/identify-code.v1.0.js::sendCode@click" yun-url="{$_root}order_info_new/send_code" yun-phone="#buyer-phone-num"
                            yun-second="60">
                        发送验证码
                    </button>
                </div>
                <p><span class="warning code_warning"></span></p>
                <p>接受验证码的手机号为：{substr($smarty.session.user.phone,0,3)}****{substr($smarty.session.user.phone,-4)}</p>
                <p>如一直收不到手机验证码，可使用交易密码来确认</p>
            </div>
            <div class="btn-wrp">
                <a class="btn-confirm js-btn-confirm conform_assign" data-type="code" href="javascript:;">确认</a>
                <a class="blue btn-code js-btn-code" href="javascript:;" style="margin-top: 10px">我要用交易密码确认</a>
            </div>
        </div>
        <div class="order-confirm2 hide">
            <div class="secretcode-wp">
                <div class="secretcode">
                    <p class="fl">交易密码：</p>
                    <input class="ipt-txt password2" type="password" placeholder="请输入交易密码">
                    <span class="warning password2_warning"></span>
                </div>
                <p>没有交易密码？<a class="blue" target="_blank" href="{$_root}user_center/user_admin/account_security" style="font-size: 12px;text-decoration: underline;">立即设置</a></p>
            </div>
            <div class="btn-wrp">
                <a class="btn-confirm conform_assign" data-type="pwd" href="javascript:;">确认</a>
                <a class="blue btn-code js-btn-yanzh" href="javascript:;" style="margin-top: 10px">我要用验证码确认</a>
            </div>
        </div>
    </div>
    {*确认合同成功*}
    <div class="hide order-conf order-confirm1">
        <h1>确认成功！</h1>
        <div class="gray">合同已签约,等待您支付</div>
    </div>

    {*线上支付*}
    <div class="hide order-payol order-payonline">
         <ul class="payol-ul payonline-ul">
             <li class="clearfix">
                 <p><span>*</span>支付金额</p>
                 <div class="ipt-wp">
                     <input class="ipt-txt amount" type="text" placeholder="请填写本次支付金额" name="data[金额]">
                     <p>最大支付金额{sprintf('%.2f',($orderinfo['order_price']-$orderinfo['order_price_pay']))}元</p>
                 </div>
             </li>
             <li class="clearfix">
                 <p><span>*</span>支付备注</p>
                 <div class="ipt-wp">
                     <input class="ipt-txt payment_title" type="text" placeholder="输入备注详情" name="data[名称]">
                     <p>(请勿与已有支付备注相同)</p>
                 </div>
             </li>
             <li class="clearfix">
                 <p class="p-none"><span></span></p>
                 <span class="warning online_pay_warning"></span>
                 <div class="ipt-wp">
                     <input class="js-payonline-submit ipt-submit bg-green buyer_create_pay_submit" type="button" value="立即支付">
                 </div>
             </li>
         </ul>
    </div>
    {*线上支付成功*}
    <div class="hide order-conf order-payonline-sucs">
        <h1><i class="pop-icon"></i><span>支付成功，</span>等待供应商提供服务吧！</h1>
    </div>
    {*线上支付失败*}
    {*<div class="hide order-conf order-payonline-fail">*}
        {*<h1><i class="pop-icon"></i>支付失败，<span>由于****原因</span></h1>*}
    {*</div>*}
    {*线上支付-身份未认证*}
    <div class="hide order-conf order-payonline-fd">
        <h1><i class="pop-icon"></i>您还未进行身份认证<span>认证后才可支付哦...</span></h1>
        <a href="{$_root}user_center/user_admin/account_identity" target="_blank" class="bg-magenta gocert-btn">立即认证</a>
    </div>

    {*取消订单成功*}
    <div class="hide ormc-ssfd order-success-cancel">
        <h1><i class="pop-icon"></i>取消成功</h1>
    </div>
    {*取消订单待确认*}
    <div class="hide order-conf order-waiting-confirm-cancel">
        <h1><i class="pop-icon"></i><span>您已提交取消订单申请，</span>待{if $orderinfo['is_buyer']}供应商{else}采购方{/if}确认后，<span>订单即可取消成功</span></h1>
    </div>
    {*线下支付款项删除弹框*}
    <div class="hide order-conf delete-payment">
        <h1><i class="pop-icon"></i>确定要删除该支付信息吗?</h1>
        <div class="btn-wrp">
            <a href="javascript:;" data-payId="0" data-amount="0" class="fl bg-magenta gocert-btn1 confirm-delete-payment">确定</a>
            <a href="javascript:;" class="fr btn-confirm cancel-delete-payment">取消</a>
        </div>
    </div>
    {*拒绝合同弹框*}
    <div class="hide order-conf refuse-conform-alter">
        <h1><i class="pop-icon"></i>确定要拒绝此合同吗?</h1>
        <div class="btn-wrp">
            <a href="javascript:;" data-comform-id="0" class="fl bg-magenta gocert-btn1 confirm-refuse-conform">确定</a>
            <a href="javascript:;" class="fr btn-confirm cancel-refuse-conform">取消</a>
        </div>
    </div>

{*--------------------商户--------------------*}
    {*接单成功*}
    <div class="hide ormc-ssfd order-success-m">
        <h1><i class="pop-icon"></i>接单成功</h1>
    </div>

    {*等待上传合同-身份认证*}
    <div class="hide order-conf ormc-cert-fd">
        <h1><i class="pop-icon"></i>您还未进行身份认证，<span>认证后再上传合同吧...</span></h1>
        <a href="" class="bg-magenta gocert-btn">立即认证</a>
    </div>
    {*上传合同*}
    <div class="hide ormc-cert">
        <ul class="payol-ul">
            <li class="clearfix">
                <p><span>*</span>合同名称</p>
                <div class="ipt-wp">
                    <input class="ipt-txt" type="text" placeholder="请输入合同名称" name="conform_title">
                </div>
            </li>
            <li class="clearfix">
                <p><span>*</span>合同金额</p>
                <div class="ipt-wp">
                    <input class="ipt-txt" type="text" placeholder="请输入合同金额" name="conform_amount">
                </div>
            </li>
            <li class="clearfix">
                <p><span>*</span>导入合同</p>
                <div class="ipt-wp">
                    <div class="hidden jyyd_files">
                        <div class="fujian">
                            <span></span>
                            <input type="hidden" class="adjunct-path" name="">
                            <input type="hidden" class="adjunct-name">
                        </div>
                    </div>
                    <div id="jyyd_files">
                    </div>
                    <div id="jyyd_files1">
                    </div>
                    {include file="Admin::inc/plupload.tpl" upload_url="{$_root}order_info_new/upload"}
                    <script>
                        var fileIndex = $('#jyyd_files>div').size() + 10;
                        uploader.onFileUploaded = function (file, path) {
                            if (!path) {
                                return alert(file.name + ' 上传失败!');
                            }
                            addFile(file.name, path);
                        }
                        function addFile(name, path) {
                            fileIndex++;
                            var newFile = $('.jyyd_files .fujian').eq(0).clone();
                            newFile.find('input:eq(0)').val(path);
                            newFile.find('input:eq(1)').val(name);
                            newFile.find('span').html(name+'<a href="javascript:;" class="upload-close" onclick="removeFile(this)">×</a>');
                            newFile.find('span').hide();
                            newFile.appendTo('#jyyd_files');
                        }
                        function removeFile(o) {
                            $(o).parent().parent().remove();
                        }
                    </script>
                </div>
            </li>
            <li class="clearfix ipt-submit-wp">
                <p class="p-none"><span></span></p>
                <span class="warning conform-warning"></span>
                <div class="ipt-wp">
                    <input class="js-ormc-upldcert ipt-submit bg-green add_conform" type="button" value="确认">
                </div>
            </li>
        </ul>
    </div>
    {*上传合同-上传成功*}
    <div class="hide ormc-ssfd ormc-cert-sucs">
        <h1><i class="pop-icon"></i>上传成功</h1>
        <div class="gray">
            <p><span class="magenta">线上支付时，</span>您的收款默认到<span class="black">“我的钱包”，</span></p>
            <p>如需更改可关闭弹窗后在此页面设置。</p>
        </div>
    </div>
    {*删除合同*}
    <div class="hide order-conf delete-conform">
        <h1><i class="pop-icon"></i>确定要删除此合同吗?</h1>
        <div class="btn-wrp">
            <a href="javascript:;" data-cid="0" data-title="" class="fl bg-magenta gocert-btn1 confirm-delete-conform">确定</a>
            <a href="javascript:;" class="fr btn-confirm cancel-delete-conform">取消</a>
        </div>
    </div>
    {*下载合同*}
    <div class="hide js-download-conform">
        <div class="hide">
            <p class="js-download-p" style="text-align: center">
                {*<a href="" class="blue weblink file_name"></a>&nbsp;&nbsp;&nbsp;&nbsp;*}
                <span class="blue weblink file_name"></span>&nbsp;&nbsp;&nbsp;&nbsp;
                <a href="" target="_blank" class="magenta weblink file_path ion-arrow-down-a">预览/下载</a>
            </p>
        </div>
    </div>
    <div class="download-show hide">
    </div>
    {*签约前买方取消理由*}
    <div class="hide cancel-reason">
        <input type="hidden" name="status" class="order_status_cancel">
            <ul class="payol-ul">
                <li class="clearfix">
                    <p>取消理由</p>
                    <div class="ipt-wp">
                        {if $orderinfo['is_buyer']}
                            <select name="cancel_reason">
                                <option>不想买了/拍错了</option>
                                <option>信息填写错误，想重拍</option>
                                <option>协商不能达成一致，无法签约</option>
                                <option>其他原因</option>
                            </select>
                        {else}
                            <select name="cancel_reason">
                                <option>采购方不想买了/拍错了</option>
                                <option>采购方信息填写错误，想重拍</option>
                                <option>协商不能达成一致，无法签约</option>
                                <option>恶意采购方/同行捣乱</option>
                                <option>其他原因</option
                            </select>
                        {/if}
                    </div>
                </li>
                <li class="clearfix">
                    <p class="p-none"><span></span></p>
                    <input class="ipt-submit bg-green cancel_order" type="submit" value="确认">
                </li>
            </ul>
    </div>
    {*签约前拒绝理由*}
    <div class="hide refuse-reason">
        <input type="hidden" name="status" class="order_status_refuse">
        <ul class="payol-ul">
            <li class="clearfix">
                <p>拒绝理由</p>
                <div class="ipt-wp">
                    <select name="refuse_reason">
                        <option>档期有冲突</option>
                        <option>不能满足采购方的需求</option>
                        <option>其他原因</option>
                    </select>
                </div>
            </li>
            <li class="clearfix">
                <p class="p-none"><span></span></p>
                <input class="ipt-submit bg-green refuse_order" type="submit" value="确认">
            </li>
        </ul>
    </div>
    {*签约后拒绝理由*}
    <div class="hide order-conf refuse-cancel">
        <input type="hidden" name="status" class="status_refuse_cancel">
        <h1><i class="pop-icon"></i>确定要拒绝此取消订单的请求吗?</h1>
        <div class="btn-wrp">
            <a href="javascript:;" class="fl bg-magenta gocert-btn1 refuse_cancel_order">确定</a>
            <a href="javascript:;" class="fr btn-confirm cancel-refuse_cancel_order">取消</a>
        </div>
    </div>
    {*<div class="hide refuse-cancel">*}
        {*<input type="hidden" name="status" class="status_refuse_cancel">*}
        {*<ul class="payol-ul">*}
            {*<li class="clearfix">*}
                {*<p>拒绝理由</p>*}
                {*<div class="ipt-wp">*}
                    {*<select name="refuse_cancel_reason">*}
                        {*<option>采购方不想买了/拍错了</option>*}
                        {*<option>采购方信息填写错误，想重拍</option>*}
                        {*<option>协商不能达成一致，无法签约</option>*}
                        {*<option>恶意采购方/同行捣乱</option>*}
                        {*<option>其他原因</option*}
                    {*</select>*}
                {*</div>*}
            {*</li>*}
            {*<li class="clearfix">*}
                {*<p><span></span></p>*}
                {*<div class="ipt-wp">*}
                    {*<input class="ipt-submit bg-green refuse_cancel_order" type="button" value="确认">*}
                {*</div>*}
            {*</li>*}
        {*</ul>*}
    {*</div>*}

    {*拒绝合同弹框----暂时不用*}
    <div class="hide refuse-conform">
        <input type="hidden" name="conform_id" class="conform_id">
        <ul class="payol-ul">
            <li class="clearfix">
                <p>拒绝理由</p>
                <div class="ipt-wp">
                    <select name="refuse_conform_reason">
                        <option>拒绝合同理由1</option>
                        <option>拒绝合同理由2</option>
                        <option>拒绝合同理由3</option>
                        <option>其他</option>
                    </select>
                </div>
            </li>
            <li class="clearfix">
                <p class="p-none"><span></span></p>
                <input class="ipt-submit bg-green refuse_conform" type="button" value="确认">
            </li>
        </ul>
    </div>
    {*拒绝合同理由显示----暂时不用*}
    <div class="hide refuse-conform-reason"></div>
    {*拒绝线下支付弹框*}
    {*<div class="hide refuse-transfer">*}
        {*<input type="hidden" name="payment_id" class="payment_id">*}
        {*<ul class="payol-ul">*}
            {*<li class="clearfix">*}
                {*<p>拒绝理由</p>*}
                {*<div class="ipt-wp">*}
                    {*<select name="refuse_transfer_reason">*}
                        {*<option>拒绝线下支付理由1</option>*}
                        {*<option>拒绝线下支付理由2</option>*}
                        {*<option>拒绝线下支付理由3</option>*}
                        {*<option>其他</option>*}
                    {*</select>*}
                {*</div>*}
            {*</li>*}
            {*<li class="clearfix">*}
                {*<p><span></span></p>*}
                {*<div class="ipt-wp">*}
                    {*<input class="ipt-submit bg-green refuse-transfer-submit" type="button" value="确认">*}
                {*</div>*}
            {*</li>*}
        {*</ul>*}
    {*</div>*}
    {*查看线下支付凭证*}
    <div class="hide show-transfer-pay-div">
        <div class="hide">
            <p class="show-transfer-pay-p">
                {*<a  href="" class="blue weblink file_name"></a>&nbsp;&nbsp;&nbsp;&nbsp;*}
                <span class="blue weblink file_name"></span>&nbsp;&nbsp;&nbsp;&nbsp;
                <a  href="" target="_blank" class="magenta weblink file_path ion-arrow-down-a">预览/下载</a>
            </p>
        </div>
    </div>
    <div class="show-transfer-pay hide">
    </div>
    {*订单完成*}
    <div class="hide ormc-ssfd order-complete">
        <h1><i class="pop-icon"></i>订单已完成</h1>
    </div>
    {*确认线下支付弹框*}
    <div class="hide order-conf transfer-pay-alter">
        <h1><i class="pop-icon"></i>确定已收到该笔款项吗?</h1>
        <div class="btn-wrp">
            <a href="javascript:;" data-pid="0" class="fl bg-magenta gocert-btn1 confirm-transfer-pay-submit">确定</a>
            <a href="javascript:;" class="fr btn-confirm cancel-confirm-transfer-pay">取消</a>
        </div>
    </div>
    {*拒绝线下支付弹框*}
    <div class="hide order-conf refuse-transfer-pay-alter">
        <h1><i class="pop-icon"></i>确定未收到该笔款项吗?</h1>
        <div class="btn-wrp">
            <a href="javascript:;" data-pid="0" class="fl bg-magenta gocert-btn1 refuse-transfer-pay-submit">确定</a>
            <a href="javascript:;" class="fr btn-confirm cancel-refuse-transfer-pay">取消</a>
        </div>
    </div>
    {*更换收款账户提示*}
    <div class="hide ormc-ssfd change_account_show">
        <h1><i class="pop-icon"></i><span></span></h1>
    </div>
</div><!--order-popup-end-->



