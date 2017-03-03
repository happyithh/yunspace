<footer class="site_footer">
    <div>
        <div class="site_footer_tab">
            <a href="{$_root}m/site_management" class="external">
                <p><img style="width: 24px;height: 24px;" {if $action=="site_management"}src="img/site_management/dangqi-up.png"{else}src="img/site_management/dangqi-down.png"{/if} alt=""/></p>
                <p {if $action=="site_management"}style="color:#0090ff;"{else}{/if}>档期管理</p>
            </a>
        </div>
        <div class="site_footer_tab">
            <a href="{$_root}m/test_site/site_list" class="external">
            <p><img style="width: 24px;height: 24px;" {if $action=="test_site"}src="img/site_management/changdi-up.png"{else}src="img/site_management/changdi-down.png"{/if} alt=""/></p>
            <p {if $action=="test_site"}style="color:#0090ff;"{else}{/if}>场地管理</p>
            </a>
        </div>
        <div class="site_footer_tab more_click">
            <p><img style="width: 24px;height: 24px;" src="img/site_management/more-down.png" alt=""/></p>
            <p>更多</p>
        </div>
    </div>
</footer>
<script>
    $(".more_click").click(function() {
        alert("正在开发中，敬请期待!");
    });
</script>