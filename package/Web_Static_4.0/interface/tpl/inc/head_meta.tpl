<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
{if isset($seo) && !empty($seo)}
    <title>{$seo['网页标题']}</title>
    <meta name="keywords" content="{$seo['网页关键词']}"/>
    <meta name="description" content="{$seo['网页简介']}"/>
{else}
    <title>{$page->seo['网页标题']}</title>
    <meta name="keywords" content="{$page->seo['网页关键词']}"/>
    <meta name="description" content="{$page->seo['网页简介']}"/>
{/if}
<meta property="og:image" content="http://{Core::$urls['host']}/package/Web_Static_4.0/interface/assets/img/logo_0520.png"/>
<meta name="baidu-site-verification" content="TRqlXNyKHX" />
<link rel="dns-prefetch" href="//www.yunspace.com.cn">
{static "v4.0/common.css"}
{static "js/jquery-1.9.1.min.js"}
{if Core::$urls['host']=='yunspace.com.cn'}
<base href="http://www.yunspace.com.cn/"/>
{/if}

<script type='text/javascript'>
    var _vds = _vds || [];
    window._vds = _vds;
    (function(){
        _vds.push(['setAccountId', 'ba86658b1197615b']);
        (function() {
            var vds = document.createElement('script');
            vds.type='text/javascript';
            vds.async = true;
            vds.src = ('https:' == document.location.protocol ? 'https://' : 'http://') + 'dn-growing.qbox.me/vds.js';
            var s = document.getElementsByTagName('script')[0];
            s.parentNode.insertBefore(vds, s);
        })();
    })();
</script>