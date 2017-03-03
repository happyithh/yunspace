<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2016/4/28
 * Time: 11:51
 */

header("Content-type: text/html;charset=utf-8");
//读取文件
$file=Func_Csv::readRow(__DIR__.'\head_img_new.csv',2,258);
foreach($file as $k=>$v){
    if(!empty($v)){
        $account_id=-1-$k;
        if(!Func_String::isUtf8($v[1])){
            $nickname=trim(iconv('gbk','utf-8',$v[1]));
        }else{
            $nickname=trim($v[1]);
        }
        //获取旧account信息
        $old_data=Data_Mysql_Table_Account_Wechat::select('user_info',array("account_id"=>$account_id));
        if(!empty($old_data[0])){
            $old_userInfo=json_decode($old_data[0]['user_info'],1);
            $userInfo['headimgurl']=$old_userInfo['headimgurl'];
            $userInfo['nickname']=$nickname;
            $userInfo['openid']=md5(-1-$k);
            Data_Mysql_Table_Account_Wechat::update(array("account_id"=>$account_id),array('user_info'=>$userInfo));
        }
    }
}
die("结束");
