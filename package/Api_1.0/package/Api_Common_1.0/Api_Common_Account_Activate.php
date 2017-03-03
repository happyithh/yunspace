<?php

/**
 * Created by PhpStorm.
 * User: yl
 * Date: 2015/9/7
 * Time: 10:30
 * 激活账号
 */
class  Api_Common_Account_Activate extends Api
{
    /**
     * 接收参数
     * $args= array(
     *      account_id=>用户id
     *      phone=>手机号
     * )
     **
     * 返回结果：
     * 返回状态status （0，返回未成功，1返回成功），
     * 状态消息 msg：返回成功 或返回失败原因
     * 返回结果data：''
     *
     */

    static function  handle($args = '')
    {
        $data=self::handleAccountActivate($args);
        $url_back=Core::$urls['host'];
        if($url_back=="pre0.yunspace.com.cn"){
            $url_back="www.yunspace.com.cn";
        }
        if(!empty($data['status'])){
            Func_Header::to($data['msg'],"http://".$url_back."/service_info/".$data['data'].".html");
        }else{
            Func_Header::to($data['msg'],"http://".$url_back);
        }

    }

    static function handleAccountActivate($args)
    {
        //兼容2015-09-15发送的短信链接
        if(strlen($args['phone']) == 11 && preg_match('/((1[3|4|5|7|8]{1})+\d{9})/i',$args['phone'])){
            $condition['account_id']=$args['account_id'];
            $condition['phone']=$args['phone'];
            $condition['create_time >= ? && create_time <= ?']=array(strtotime("2015-09-15 00:00:00"),strtotime("2015-09-15 23:59:59"));
            $rs_exists=Data_Mysql_Table_Vendor_Expand::select('id',$condition);
            if(!empty($rs_exists[0])){
                $request['phone']=$args['phone'];
                $request['account_id']=$args['account_id'];
                $request['product_id']=$args['product_id'];
            }
        }else{
            //解密字符串
            $args['account_id']=Func_String::decrypt($args['account_id'],'account');
            $args['phone']=Func_String::decrypt($args['phone'],'phone');
            $request = Func_Input::filter(array(
                'account_id' => 'int',
                'phone'=>'phone',
                'product_id'=>'int',
            ), $args);
        }

        if (empty($request['account_id']) || empty($request['phone'])) {
            return self::request('error','','可能由于网络原因，操作失败1！');
        }
        //更新拓展表数据
        $rs=Data_Mysql_Table_Vendor_Expand::update(array('account_id'=>$request['account_id'],'phone'=>$request['phone']),array('status'=>1));
        if (!empty($rs[0])) {
            if(!empty($request['product_id'])){
                return self::request('success',$request['product_id'],'即将前往您的场地信息页，您还可以使用手机号登录云·Space PC网站，维护场地信息。');
            }
        }else{
            return self::request('error','','可能由于网络原因，操作失败2！');
        }
    }

}