{if !$_REQUEST['app']}
<script>
function uaredirect(murl){ try{  if (!(navigator.userAgent.match(/(iPhone|iPod|Android|ios|iPad|windows_phone|blackberry|symbia|nokiabrower|spider|bot)/i))) { location.replace(murl); } } catch(err){ } }
{if Core::$urls['host']=='m.yunspace.com.cn'}
uaredirect("http://www.yunspace.com.cn/{$url}");
{else}
uaredirect("/{$url}");
{/if}
</script>
{/if}