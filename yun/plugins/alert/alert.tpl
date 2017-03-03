<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<title>演示：漂亮实用的提示框插件SweetAlert</title>
<meta name="keywords" content="Javascript" />
<meta name="description" content="Helloweba文章结合实例演示HTML5、CSS3、jquery、PHP等WEB技术应用。" />
{*<link rel="stylesheet" type="text/css" href="../css/main.css" />*}
{static "v1.0/sweetalert.css"}
{static "core/yunspace.js"}
<style>
.demo{
	width:300px; margin:60px auto 10px auto
}
@media only screen and (min-width: 420px) {
	.demo{
		width:500px; margin:60px auto 10px auto
	}
}
button, .button {
  background-color: #AEDEF4;color: white;border: none;box-shadow: none;
  font-size: 17px;font-weight: 500;font-weight: 600;
  border-radius: 3px;padding: 15px 35px;margin: 26px 5px 0 5px;cursor: pointer;
}
button:hover, .button:hover {
	background-color: #a1d9f2;
}
</style>
</head>
<body>
<div id="main">
	<div class="demo">
		<div class="demo_1"  >
			基本示例：<button  yun="alert/alert.js::showAlert@click" yun-title="这是一个modal框" yun-custom="simple">点击这里</button>
		</div>
		<div class="demo_2">
			提示成功：<button  yun="alert/alert.js::showAlert@click" yun-title="这是一个框" yun-custom="success" yun-text="hehehheheheh">
					点击这里</button>
		</div>
		<div class="demo_3">
			提示失败：<button yun="alert/alert.js::showAlert@click" yun-title="这是一个框" yun-custom="error" yun-text="cuocuoc"
					>点击这里</button>
		</div>
		<div class="demo_4">
			提示确认：<button yun="alert/alert.js::showAlert@click" yun-title="这是一个框" yun-custom="delete" yun-text="cuocuoc"
						 yun-imageUrl=images/thumbs-up.jpg" yun-confirm_text="确定删除" yun-ajax_url="{$_root}"
			>点击这里</button>
		</div>
		<div class="demo_5">
			定义内容：<button  yun="alert/alert.js::showAlert@click" yun-title="这是一个框" yun-custom="timer" yun-text="5秒后自动关闭"
						  yun-time="5000" yun-imageUrl="images/thumbs-up.jpg" yun-confirm_text="确定删除">点击这里</button>
		</div>
		<div class="demo_6">
			确认输入：<button yun="alert/alert.js::showAlert@click" yun-title="这是一个框" yun-custom="input" yun-text="cuocuoc"
						 yun-placeholder="请输入您的用户名">点击这里</button>
		</div>
	</div>
</div>

<script>
{*$(function(){*}
	{*$(".demo_1 button").click(function(){*}
		{*swal("这是一个信息提示框!");*}
	{*});*}
	{*$(".demo_2 button").click(function(){*}
		{*swal("Good!", "弹出了一个操作成功的提示框", "success");*}
	{*});*}
	{*$(".demo_3 button").click(function(){*}
		{*swal("OMG!", "弹出了一个错误提示框", "error");*}
	{*});*}
//	$(".demo_4 button").click(function(){
//		 swal({
//			title: "您确定要删除吗？",
//			text: "您确定要删除这条数据？",
//			type: "warning",
//			showCancelButton: true,
//			closeOnConfirm: false,
//			confirmButtonText: "是的，我要删除",
//			confirmButtonColor: "#ec6c62"
//			}, function() {
//				$.ajax({
//					url: "do.php",
//					type: "DELETE"
//				}).done(function(data) {
//					swal("操作成功!", "已成功删除数据！", "success");
//				}).error(function(data) {
//					swal("OMG", "删除操作失败了!", "error");
//				});
//			});
//	});
	{*$(".demo_5 button").click(function(){*}
		{*swal({   *}
			{*title: "Good!",   *}
			{*text: '自定义<span style="color:red">图片</span>、<a href="#">HTML内容</a>。<br/>5秒后自动关闭。',   *}
			{*imageUrl: "images/thumbs-up.jpg",*}
			{*html: true,*}
			{*timer: 5000,   *}
			{*showConfirmButton: false*}
		{*});*}
	{*});*}
	{*$(".demo_6 button").click(function(){*}
		{*swal({   *}
			{*title: "输入框来了",   *}
			{*text: "这里可以输入并确认:",   *}
			{*type: "input",   *}
			{*showCancelButton: true,   *}
			{*closeOnConfirm: false,   *}
			{*animation: "slide-from-top",   *}
			{*inputPlaceholder: "填点东西到这里面吧" *}
		{*}, function(inputValue){   *}
			{*if (inputValue === false) return false;      *}
			{*if (inputValue === "") {     *}
				{*swal.showInputError("请输入!");     *}
				{*return false   *}
			{*}      *}
			{*swal("棒极了!", "您填写的是: " + inputValue, "success"); *}
		{*});*}
	{*});*}
{*});*}
</script>
</body>
</html>