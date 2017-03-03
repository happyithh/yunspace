{static "winchance/pop_consl.css"}
<div class="pop-consl">
    <div class="close js-close"></div>
    <table class="consl" cellpadding="0" cellspacing="0">
        <tr>
            <th width="25%">合作咨询</th>
            <th width="75%"></th>
        </tr>
        <tr>
            <td><span class="imp">*</span>城市</td>
            <td>
                <input class="ipt-text" type="text" placeholder="请输入您所在的城市" value="{$_COOKIE['city']}">
            </td>
        </tr>
        <tr>
            <td><span class="imp">*</span>您的称呼</td>
            <td>
                <input class="ipt-text" name="winchance_username" type="text" placeholder="请输入您的姓名" value="">
            </td>
        </tr>
        <tr>
            <td><span class="imp">*</span>您的联系方式</td>
            <td>
                <input class="ipt-text" type="text" name="winchance_phone" placeholder="请输入您的联系方式：手机号或者电话" value="">
            </td>
        </tr>
        <tr class="bdn">
            <td><span class="imp">*</span>您想咨询的内容</td>
            <td>
                <textarea class="txtra" name="content" placeholder="您想咨询的内容，300字以内.."></textarea>
            </td>
        </tr>
        <tr class="bdn">
            <td></td>
            <td>
                <p style="margin-left: 60px;">关注云·SPACE服务号，获取最新回复</p>

                <div class="consl-code"><img src="img/winchance/space_fwh.jpg"></div>
            </td>
        </tr>
    </table>

    <div class="conls-btn clearfix">
        <button class=" btn btn-cancel js-close">取消</button>
        <button class=" btn btn-confirm">提交</button>
        {*<button class=" btn btn-cancel js-close">取消</button>*}
    </div>
</div>