<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="css/v1.0/ionicons/ionicons.min.css">
    <title></title>
</head>
<body>
<form action="" data-validate="true"  yun="form-validate/form-validate.js::formSubmit" >
    {*验证用户名*}
    <input type="text" yun="form-validate/form-validate.js::typeValidate@keyup" yun-ok="格式正确"
           {literal}yun-exp="/^(0|86|17951)?(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$/"{/literal}   yun-style="color:#666666,font-size:10px" data-validate="true" yun-error="格式错误"/>
    <input type="email" yun="form-validate/form-validate.js::typeValidate@keyup"
           yun-type="email" yun-ok="格式正确" yun-error="格式错误" yun-style="color:#666666,font-size:10px" data-validate="true"
            {literal} yun-exp="/^(\w-*\.*)+@(\w-?)+(\.\w{2,})+$/"{/literal} />
    <input type="phone" yun="form-validate/form-validate.js::typeValidate@keyup"
           yun-type="phone" yun-ok="格式正确" yun-error="格式错误" yun-style="color:#666666,font-size:10px" data-validate="true"/>
    <button type="submit">提交</button>
</form>
{static "core/yunspace.js"}
</body>
</html>