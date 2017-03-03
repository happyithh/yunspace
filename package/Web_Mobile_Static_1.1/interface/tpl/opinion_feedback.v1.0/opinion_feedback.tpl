<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no,minimal-ui">
    <meta name="format-detection" content="telephone=no"/>
    <title>意见反馈</title>
  {*  <script src="js/jquery.min.js"></script>*}
    <link type="text/css" href="css/opinion_feedback/view.css" rel="stylesheet">
</head>
<body>
<div class="view-title">
    <h2>感谢您的意见和反馈，我们会努力优化、提高体验，感谢您的支持</h2>
</div>
{*<form action="{$root}/form" method="post" >*}
    <input type="hidden" name="data[用户id]" value="{$data['id']}" class="userid"/>
    <input id="id" name="id" value="12" type="hidden">
    {* <input type="hidden" name="data[]" value="{$data['id']}">
    <input type="hidden" name="data[id]" value="{$data['id']}">*}
<div class="comn">
    <h3>反馈内容</h3>
    <div class="contr">
        <textarea placeholder="请输入您的意见和反馈" name="data[内容]" class="reason"></textarea>
    </div>
</div>
<div class="comn">
    <h3>联系方式</h3>
    <div class="contr">
        <input type="text" placeholder="请输入邮箱或手机号（选填）" name="data[联系方式]" class="email" value="{$_REQUEST['phone']}">
    </div>
</div>
<div class="view-btn-wrap">
    <button class="view-btn" data-url="{$_root}pinion_feedback/form" data-tijiao="{$_root}form">提交</button>
</div>
{*</form>*}
</body>
{*<script src="js/jquery.min.js"></script>*}
<script src="js/v1.0/jquery-1.11.1.min.js"></script>
<script type="text/javascript">
    $('.view-btn').click(function(){
                var reason = $('.reason').val();
                if(!reason){
                    alert('内容不能为空');
                    return false;
                }
                var email = $('.email').val();
                var id = $('#id').val();
                var userid = $('.userid').val();
                var form_type = 1;
                var data= new Array();
                data[0]= reason
                data[1] = email
                data[2] = userid
                var key = new Array();
                key[0] = '内容'
                key[1]='联系方式'
                key[2]='用户id'
        $.ajax({
            type: "post",
            url: "http://pre0.yunspace.com.cn/form",
            data: {
                id:id,
                data:data,
                key:key,
                form_type:form_type
            },
            async: false,
            dataType: "json",
            success: function (data){
                console.log(data);
                if(data.status ==1){
                    alert('提交成功');
                    window.location.href='http://pre0.yunspace.com.cn/m/opinion_feedback';
                }else {
                    alert('提交失败');
                }
            }
        })
            }
    )
</script>
</html>