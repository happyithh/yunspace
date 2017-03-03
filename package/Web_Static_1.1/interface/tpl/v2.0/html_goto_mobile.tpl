<script>
function uaredirect(murl){ try{  if ((navigator.userAgent.match(/(iPhone|iPod|Android|ios|iPad)/i))) { location.replace(murl); } } catch(err){ } }
{if $url}
{if $not_m}
uaredirect("/{$url}");
{else}
{*uaredirect("http://m.yunspace.com.cn{substr($url,1)}");*}
uaredirect("/{$url}");
{/if}
{else}
uaredirect("/m");
//uaredirect("http://m.yunspace.com.cn/");
{/if}
</script>
{if $url}
<meta name="mobile-agent" content="format=html5;url=http://m.yunspace.com.cn{substr($url,1)}">
{else}
<meta name="mobile-agent" content="format=html5;url=http://m.yunspace.com.cn/">
{/if}