<?php
/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2015/7/7
 * Time: 16:53
 */
/*
 * 用于批量导入供应商信息
 * 等同于市场部的快速创建产品的前半部分（无产品创建）
 * 创建账户、创建联系人、创建供应商
 * */
class OA_Quantity_Import_Vendors{
    //处理数据
    static function dealData(){
        $data =  Func_Csv::readRow('temp/vendorsInfoHangzhou.csv',1,2100);
        foreach($data as $k=>$v){
            if(!empty($data[$k]) && !empty($v[0]) && mb_convert_encoding($v[0], "UTF-8", "GBK")!='公司名称'){
                    $dat['company'] =  mb_convert_encoding($v[0], "UTF-8", "GBK");
                    $dat['username'] =  mb_convert_encoding($v[1], "UTF-8", "GBK");
                    $dat['phone'] = mb_convert_encoding($v[2], "UTF-8", "GBK");
                    $dat['addr'] = mb_convert_encoding($v[3], "UTF-8", "GBK");
                    $dat['des'] =  mb_convert_encoding($v[4], "UTF-8", "GBK");
                    self::QuickCreateData($dat);
            }
        }
        Func_Header::back('导入成功！');
    }
    static function QuickCreateData($data){
        //1.判断账号是否存在
        $account_exists = Data_Mysql_Table_Account::select('id,phone',array('phone'=>$data['phone']),'',1);
        if(empty($account_exists[0]) && !isset($account_exists[0])) {
            //2.创建账号
            //账户名去重
            $account_name = Data_Mysql_Table_Account::select("id,username",array('username'=>$data['username']));
            $account_info = array(
                'username'=> empty($account_name[0])?$data['username']:$data['username'].$data['phone'],
                'phone' => $data['phone'],
                'fullname'=>empty($data['company'])?$data['username']:$data['company'],
                'account_type' =>21,
                'password'=>Data_Mysql_Table_Account::makePassword($data['phone']),
                'attr' => array(
                    'register_ip' => Func_Input::ip(),
                    'email' => '',
                    'phone' => $data['phone']
                ),
                'register_time' => time(),
            );
            $res = Data_Mysql_Table_Account::insert($account_info);
            if(!empty($res[0])){
                $account_id = $res[0];
            }
        }else{
            $account_id = $account_exists[0]['id'];
        }
        //3.创建联系人
        //判断联系人是否存在
        $contact_exists = Data_Mysql_Table_Contact_Library::select("id,phone,account_id",array('phone'=>$data['phone']));
        if(!empty($contact_exists[0])){
            if(empty($contact_exists[0]['account_id'])){
                Data_Mysql_Table_Contact_Library::update(array('id'=>$contact_exists[0]['id']),array('account_id'=>$account_id));
            }
        }else{
            $contacts_info['username'] = $data['username'];
            $contacts_info['phone'] = $data['phone'];
            $contacts_info['company'] = $data['company'];
            $contacts_info['account_id']=empty($account_id)?'':$account_id;
            $contacts_info['attr'] = array(
                '公司信息' =>array(
                    '所在行业' => "",
                    '从业年数' => "",
                    '公司地址' => $data['addr'],
                    '人数规模' => "",
                    '其他备注' => ""
                ));
            $contacts_info['type']=21;
            $contacts_info['customer_type']=0;
            $contacts_info['new_demand_time']=0;
            $contacts_info['city']='杭州';
            $contacts_info['create_time']=time();
            Data_Mysql_Table_Contact_Library::insert($contacts_info);
        }
        //4.创建供应商
        //account表里面已经存在供应商信息，则该供应商数据不再写入
        if(empty($account_exists[0]) && !isset($account_exists[0])){
            $vendor_info['vendor_name'] = $data['company'];
            $vendor_info['base_info'] =array(
                '公司电话'=>'',
                '公司传真'=>'',
                '主要联系人'=>$data['username'],
                '联系方式'=>$data['phone']
            );
            $vendor_info['attr']=array(
                '服务范围'=>'',
                '城市'=>'杭州'
            );
            $vendor_info['status']=2;
            $vendor_info['des']=$data['des'];
            $vendor_info['addr'] =$data['addr'];
            $vendor_info['vendor_account_id']=empty($account_id)?'':$account_id;
            $vendor_info['create_time']=time();
            Data_Mysql_Table_Vendor_Info::subTable('_update')->insert($vendor_info);
        }

    }
}