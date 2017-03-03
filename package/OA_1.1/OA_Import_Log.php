<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 15-9-28
 * Time: 下午3:40
 * 批量上传日志
 */
class OA_Import_Log{
    static function handle(){
        $action=empty($_REQUEST['action'])?"list":$_REQUEST['action'];
        switch($action){
            case "list":
                self::getImportLogList();
                break;
            case "update_data":
                self::updateData();
                break;
            case "update_all_data":
                self::updateAllData();
                break;
        }

    }
    static function getImportLogList(){
        $handle_type=empty($_REQUEST['handle_type'])?"not":$_REQUEST['handle_type'];
        $condition=array();
        if(!empty($_REQUEST['title'])){
            if(is_numeric($_REQUEST['title'])){
                $condition['product_id']=$_REQUEST['title'];
            }else{
                $condition['product_name']=$_REQUEST['title'];
            }
        }
        if(!empty($_REQUEST['phone'])){
            $condition["(phone_old = ? OR phone_new = ? )"]=array($_REQUEST['phone'],$_REQUEST['phone']);
        }
        switch($handle_type){
            case "not":
                $condition['status']=0;
                break;
            case "done":
                $condition['status']=1;
                break;
            case "all":
                break;
        }
        $data=Data_Mysql_Table_Import_Log::page(0,20,"*",$condition,'ORDER BY update_time DESC');
        Tpl_Smarty::assign('handle_type',$handle_type);
        Tpl_Smarty::assign('data',$data);
        Tpl_Smarty::display('OA_Static','import_log/import_log_list.tpl');
    }
    static function updateData(){
        $request=Func_Input::filter(array(
            'product_id'=>'int',
        ));
       if(empty($request['product_id'])){
           Func_Header::back("参数缺失！！");
       }
        $update=self::handleUpdateAction($request['product_id']);
        if($update){
            //更新日志表状态
            $rs=Data_Mysql_Table_Import_Log::update(array('product_id'=>$request['product_id']),array("status"=>1));
            if(empty($rs[0])){
                Func_Header::back("更新失败！！");
            }else{
                Func_Header::to(" 更新成功！！","?");
            }
        }else{
            Func_Header::back("产品不存在！！");
        }

    }

    //批量更新数据
    static function updateAllData(){
        return false;
        Core::output('');
        $request = Func_Input::filter(array(
            'data_arr' => 'array',
        ));
        if (empty($request['data_arr'])) {
            Func_Output::json('error', '', '参数缺失！！');
        }
        foreach ($request['data_arr'] as $k => $v) {
           $product_id=$v['product_id'];
            if(!empty($product_id)){
                $update=self::handleUpdateAction($product_id);
                if($update){
                    //更新日志表状态
                    Data_Mysql_Table_Import_Log::update(array('product_id'=>$product_id),array("status"=>1));
                }
            }
        }
        Func_Output::json('success', '', '数据已更新！');
    }


    static function handleUpdateAction($product_id){
        return false;
        //获取更新的数据
        $data=Data_Mysql_Table_Import_Log::select("*",array('product_id'=>$product_id));
        if(empty($data[0])){
            return false;
        }

        //获取更新的产品信息
        $product=Data_Mysql_Table_Product_Info::subTable('_update')->select('id,vendor_id,attr,attr_new,category_id,product_name',array("id"=>$product_id));
        if(!empty($product[0])){
            $productInfo=$product[0];
            if(!empty($data[0]['price'])){
                $update_product['price']=$data[0]['price']*100;
            }
            if(!empty($data[0]['unit'])){
                $update_product['attr_new']['计价单位']=$data[0]['unit'];
                $update_product['attr_new']['计价下限']=$data[0]['min'];
                $update_product['attr_new']['计价上限']=$data[0]['max'];
            }
            if(!empty($data[0]['is_lowest'])){
                $update_product['attr_new']['起价']=1;
            }
            if(!empty($data[0]['size'])){
                $update_product['product_size']=$data[0]['size'];
            }
            $update_product['status']=1;
            if(!empty($productInfo['attr_new'])){
                $productInfo['attr_new']=json_decode($productInfo['attr_new'],1);
            }
            $productInfo['attr_new'][46]=empty($productInfo['attr_new'][46])?"上海":$productInfo['attr_new'][46];
            $update_product['attr_new'][46]=$productInfo['attr_new'][46];
            //更新产品信息
            $rs_product=Data_Mysql_Table_Product_Info::subTable('_update')->update(array('id'=>$product_id),$update_product);
            //将产品直接上线
            $cols = array("id ,status,price,product_size,attr_new,vendor_id");
            $update_data = Data_Mysql_Table_Product_Info::subTable('_update')->select($cols, array('id' =>$product_id));
            $product_online=Data_Mysql_Table_Product_Info::update($update_data[0]);

            if(empty($productInfo['vendor_id'])){
                $data_vendor['vendor_name']=$productInfo['product_name'];
                $data_vendor['categories_id']=$productInfo['category_id'];
                $data_vendor['attr']['城市']=empty($productInfo['attr_new'][46])?"上海":$productInfo['attr_new'][46];
                $data_vendor['attr_index']=Data_Mysql_Table_Vendor_Info::attrToIndex($data_vendor['attr']);
                $data_vendor['status']=2;
                $rs_vendor=Data_Mysql_Table_Vendor_Info::subTable('_update')->insert($data_vendor);
                if(!empty($rs_vendor[0])){
                    $rs_product=Data_Mysql_Table_Product_Info::subTable('_update')->update(array('id'=>$product_id),array('vendor_id'=>$rs_vendor[0]));
                    $rs_product_online=Data_Mysql_Table_Product_Info::update(array('id'=>$product_id),array('vendor_id'=>$rs_vendor[0]));
                    $productInfo['vendor_id']=$rs_vendor[0];
                }
            }

            //更新手机号
            if(!empty($data[0]['phone_new']) && preg_match('/((1[3|4|5|7|8]{1})+\d{9})/i',$data[0]['phone_new'] ) && !empty($productInfo['vendor_id'])){
                $request_contacts['phone']=$data[0]['phone_new'];
                $request_contacts['username']=$data[0]['username'];
                $request_contacts['vendor_id']=$productInfo['vendor_id'];
                self::updateAccount($request_contacts);
            }
            if(!empty($rs_product[0]) && !empty($product_online[0])){
                return true;
            }else{
                return false;
            }
        }
        return false;
    }

    static function updateAccount($request_contacts){
        //1.判断账号是否存在且是否绑定供应商
        $account_exists = Data_Mysql_Table_Account::select('id,phone', array('phone' => $request_contacts['phone']));
        if (empty($account_exists[0])) {
            //1.1.创建账号
            $password = rand(10000, 99999) . rand(111, 999);
            $status = Api_Account_Register::quickRegister(array(
                'phone' => $request_contacts['phone'],
                'password' => $password,
                'username'=>empty($request_contacts['username'])?$request_contacts['phone']:$request_contacts['username'],
            ));
            $accountInfo=$status['data'];
            //1.2.绑定账号
            Data_Mysql_Table_Vendor_Info::subTable('_update')->update(array('id'=>$request_contacts['vendor_id']),array('vendor_account_id'=>$accountInfo['id']));
            Data_Mysql_Table_Vendor_Info::update(array('id'=>$request_contacts['vendor_id']),array('vendor_account_id'=>$accountInfo['id']));

        } else {
            //2.1已有账户,判断是否已经拓展，没有拓展的继续进行
            $expand=Data_Mysql_Table_Vendor_Expand::select("id,vendor_id",array('phone'=>$request_contacts['phone']));
            if(empty($expand[0])){
                $accountInfo=$account_exists[0];
                //2.2判读该账号是否已绑定供应商
                $rs_vendor=Data_Mysql_Table_Vendor_Info::select('id,vendor_account_id',array('vendor_account_id'=>$accountInfo['id']));
                if(empty($rs_vendor[0])){
                    //2.2.1如果没有绑定，则绑定供应商到原有账户
                    Data_Mysql_Table_Vendor_Info::subTable('_update')->update(array('id'=>$request_contacts['vendor_id']),array('vendor_account_id'=>$accountInfo['id']));
                    Data_Mysql_Table_Vendor_Info::update(array('id'=>$request_contacts['vendor_id']),array('vendor_account_id'=>$accountInfo['id']));
                }else{
                    //2.2.2将原供应商与该账户解除绑定,将该供应商绑定到该账号上,
                    Data_Mysql_Table_Vendor_Info::update(array('id'=>$rs_vendor[0]['id']),array('vendor_account_id'=>0));
                    Data_Mysql_Table_Vendor_Info::subTable('_update')->update(array('id'=>$rs_vendor[0]['id']),array('vendor_account_id'=>0));

                    Data_Mysql_Table_Vendor_Info::subTable('_update')->update(array('id'=>$request_contacts['vendor_id']),array('vendor_account_id'=>$accountInfo['id']));
                    Data_Mysql_Table_Vendor_Info::update(array('id'=>$request_contacts['vendor_id']),array('vendor_account_id'=>$accountInfo['id']));
                }
            }
        }
    }
}