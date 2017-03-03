<div class="fl clearfix">
    <div class="related">
        <div class="relate-title">相关推荐</div>
        <ul class="product_list get_more_list">
            {foreach $page->getRandList as $k=>$v}
            <li>
                <div class="product_img">
                    <a href="{$_root}service_info/{$v['id']}.html">
                        {if $v['logo']}
                            <img src="{Page_Site_Global::displayMedia($v['logo'],275,195)}" alt="{$v['product_name']}">
                        {else}
                            <img src="images/vendor.jpg">
                        {/if}
                    </a>
                </div>
                <h1>
                    <a href="{$_root}service_info/{$v['id']}.html">{$v['product_name']}</a><br>
                    <small>
                        <a href="{$_root}vendor_info/{$v['vendor_id']}.html">{$v['vendor_name']}</a>
                    </small>
                </h1>
            </li>
            {/foreach}
            {*<li>*}
                {*<div class="product_img">*}
                    {*<a href="/service_info/4599.html">*}
                        {*<img src="/uploads/275_195/201505/o_19m51j18qpb51h1mrjg3f78q6b.png" alt="">*}
                    {*</a>*}
                {*</div>*}
                {*<h1>*}
                    {*<a href="/service_info/4599.html">平安银行-员工宣传片</a><br>*}
                    {*<small>*}
                        {*<a href="/vendor_info/3723.html">上海众庶文化传播有限公司</a>*}
                    {*</small>*}
                {*</h1>*}
            {*</li>*}
            {*<li>*}
                {*<div class="product_img">*}
                    {*<a href="/service_info/4609.html">*}
                        {*<img src="/uploads/275_195/201505/o_19m530ihn1vglsc914h11r493o8b.png" alt="">*}
                    {*</a>*}
                {*</div>*}
                {*<h1>*}
                    {*<a href="/service_info/4609.html">芝华士宣传片 蔡永康篇</a><br>*}
                    {*<small>*}
                        {*<a href="/vendor_info/3175.html">上海觉品文化传播有限公司</a>*}
                    {*</small>*}
                {*</h1>*}
            {*</li>*}

        </ul>
    </div>
</div>
<script type="text/javascript" src="js/no_result.js"></script>
