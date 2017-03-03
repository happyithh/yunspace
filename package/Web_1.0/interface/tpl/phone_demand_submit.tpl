<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-COMPATIBLE" content="IE=edge"/>
    <meta name="viewport" content="width=divice-width,initial-scale=1"/>
    <link rel="stylesheet" href="css/bootstrap.min.css"/>
    <title></title>
    <style>
        a:hover{ text-decoration:none;  }
        body{ position: relative;  font-family:微软雅黑, microsoft yahei, Arial, sans-serif;  background: #eeeeee;  line-height: 24px;  }
        .main{ width:100%;  margin-bottom: 42px;  }
        .title_a h4 { text-align: center; margin-bottom: 10px; }
        .fa { padding: 15px; }
    </style>
</head>

<body>
<div class="main">
    <div class="container-fluid">
        <form action="{$_root}demand_submit/phon_demand_submit" method="post">

            <div class="title_a"><h4>提供免费方案</h4></div>
            <div class="fa row ">
                    <div class="pull-left" style="width: 30%;">
                        活动类型
                    </div>
                    <div class="pull-left" style="width: 70%;">
                        <select class="form-control screening" name="data[活动类型]">
                            {foreach $vendor_attr['活动类型'] as $v}
                                <option>{$v}</option>
                            {/foreach}
                        </select>
                    </div>
                    <div class="clear"></div>
                </div>
                <div class="fa row ">
                    <div class="pull-left"  style="width: 30%;">
                        活动人数
                    </div>
                    <div class="pull-left" style="width: 70%;">
                        <select class="form-control screening" name="data[活动人数]">
                            <option>0-30人</option>
                            <option>30-50人</option>
                            <option>50-100人</option>
                            <option>100-200人</option>
                            <option>200-400人</option>
                            <option>400-600人</option>
                            <option>600-800人</option>
                            <option>800-1000人</option>
                            <option>1000人以上</option>

                        </select>
                    </div>
                    <div class="clear"></div>
                </div>

                <div class="fa row">
                    <div class="pull-left"  style="width: 30%;">
                        活动需求
                    </div>
                    <div class="pull-left" style="width: 70%;">
                        <textarea class="form-control screening1" rows="7" name="data[具体要求]"></textarea>
                    </div>
                    <div class="clear"></div>
                </div>

                <div class="fa row ">
                    <div class="pull-left"  style="width: 30%;">
                        联系人姓名
                    </div>
                    <div class="pull-left" style="width: 70%;">
                        <input class="form-control screening1" name="data[联系人]">
                    </div>
                    <div class="clear"></div>
                </div>
                <div class="fa row">
                    <div class="pull-left"  style="width: 30%;">
                        联系人电话
                    </div>
                    <div class="pull-left" style="width: 70%;">
                        <input class="form-control screening1" name="data[联系电话]">
                    </div>
                    <div class="clear"></div>
                </div>


                <div class="fa row" >
                    <button type="submit" class="btn btn-info" style="width: 100%; padding: 10px 0px" >
                        我要办活动
                    </button>
                </div>
                <p style=" text-align:center; color: #666; margin-top: 10px; font-size: 13px;">
                    工作人员将在30分钟之内与您联系
                </p>
        </form>
        <div class="clear"></div>
    </div>

</div>
</body>
</html>