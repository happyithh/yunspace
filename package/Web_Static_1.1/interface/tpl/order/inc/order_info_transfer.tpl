{*线下支付*}
<div class="popup-close">×</div>
<div class="order-payol order-payline">
    <ul class="payol-ul payline-ul">
        <li class="clearfix">
            <p><span>*</span>支付金额</p>
            <div class="ipt-wp">
                <input class="ipt-txt transfer_amount" type="text" placeholder="请填写本次支付金额" value="{$paymentInfo['payment']['amount']}">
                <p>最大支付金额{sprintf("%.2f",($orderinfo['order_price'] - $orderinfo['order_price_pay']))}元</p>
            </div>
        </li>
        <li class="clearfix">
            <p><span>*</span>支付凭证</p>
            <div class="ipt-wp">
                <div class="hidden pay_certify">
                    <div class="pay_certify_file">
                        <span></span>
                        <input type="hidden" class="certify-path">
                        <input type="hidden" class="certify-name">
                    </div>
                </div>
                <div id="pay_certify">
                </div>
                {include file="Admin::inc/plupload.tpl" upload_url="{$_root}order_info_new/upload"}
                <script>
                    var fileIndex = $('#pay_certify>div').size() + 10;
                    uploader.onFileUploaded = function (file, path) {
                        if (!path) {
                            return alert(file.name + ' 上传失败!');
                        }
                        addCertifyFile(file.name, path);
                    }
                    function addCertifyFile(name, path) {
                        fileIndex++;
                        var newFile = $('.pay_certify .pay_certify_file').eq(0).clone();
                        newFile.find('input:eq(0)').val(path);
                        newFile.find('input:eq(1)').val(name);
                        newFile.find('span').html(name+'<a href="javascript:;" class="upload-close" onclick="removeFile(this)">×</a>');
                        newFile.find('span').hide();
                        newFile.appendTo('#pay_certify');
                    }
                    function removeFile(o) {
                        $(o).parent().parent().remove();
                    }
                    {if $paymentInfo['payment_info']['media']}
                        {foreach $paymentInfo['payment_info']['media'] as $k=>$v}
                            addCertifyFile("{$v['name']}","{$v['path']}");
                            $('#pay_certify span').show();
                        {/foreach}
                    {/if}
                </script>
            </div>

        </li>

        <li class="clearfix ipt-submit-wp">
            <p><span>*</span>支付备注</p>
            <div class="ipt-wp">
                <input class="ipt-txt transfer_title" type="text" value="{$paymentInfo['payment']['payment_detail']['payment_title']}" placeholder="输入备注详情">
                <p>(请勿与已有支付备注相同)</p>
            </div>
        </li>
        <li class="clearfix">
            <p class="p-none"><span></span></p>
            <div class="ipt-wp">
                <span class="warning transfer_pay_warning"></span>
                <input class="js-payline-submit ipt-submit bg-green pay-transfer-submit" type="button" value="确认">
            </div>
        </li>
    </ul>
</div>
{*线下支付-上传成功*}
<div class="hide order-conf order-payline-sucs">
    <h1><i class="pop-icon"></i><span>上传成功，</span>供应商准备中...</h1>
</div>
{*线下支付-上传失败*}
{*<div class="hide order-conf order-payline-fd">*}
    {*<h1><i class="pop-icon"></i>支付失败，<span>由于***原因</span></h1>*}
{*</div>*}
