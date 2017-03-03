<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <title>云SPACE</title>
</head>
<body style="font-family:微软雅黑,microsoft yahei,Arial,sans-serif; background-color:#e0e0e0; padding:0px; margin:0px;">
<table width="750" border="1" align="center" cellpadding="0" cellspacing="0"
       style="background-color:#fff;">


    {if $data}
        {foreach $data as $key =>$val}
            {if $key==0}
                <tr>
                    <td colspan="2" ><h1> 新需求</h1></td>
                </tr>
            {/if}
            {if $key==1}
                <tr>
                    <td colspan="2" > <h1> 新最近需求</h1></td>
                </tr>
            {/if}
            <tr>
                <td align="center" >
                    ID
                </td>
                <td align="center">
                    {$val['id']}
                </td>
            </tr>
            <tr>
                <td align="center" >
                    手机
                </td>
                <td align="center">
                    {$val['phone']}
                </td>
            </tr>
            <tr>
                <td align="center" >
                    城市
                </td>
                <td align="center">
                    {$val['city']}
                </td>
            </tr>
            <tr>
                <td align="center" >
                    IP
                </td>
                <td align="center">
                    {$val['ip']}
                </td>
            </tr>
            <tr>
                <td align="center" >
                    类型
                </td>
                <td align="center">
                    {$val['demand_type']}
                </td>
            </tr>
            <tr>
                <td align="center" >
                    需求主体
                </td>
                <td align="center">
                    <table style="text-align: left;float: left">
                        {foreach  $val['demand'] as $k=>$v}
                            <tr>
                                <td>{$k}:</td>
                                <td>{$v}</td>
                            </tr>
                        {/foreach}
                    </table>
                </td>
            </tr>
            <tr style="border-bottom: 2px;border-color: #0000cc">
                <td align="center">
                创建时间
                </td>
                <td align="center">
                {Date('Y-m-d H:i:s ',$val['create_time'])}
                </td>
            </tr>
            <tr style="border-bottom: 2px;border-color: #0000cc">
                <td align="center">

                </td>
                <td align="center">

                </td>
            </tr>
        {/foreach}
    {/if}
</table>

</body>
</html>