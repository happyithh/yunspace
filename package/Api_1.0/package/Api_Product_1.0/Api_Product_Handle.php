<?php
/*
 * Created by PhpStorm
 * User: yl
 * Date: 2015/9/23
 * Time: 17:13
 * 产品处理接口
 */
class Api_Product_Handle extends Api
{
    static function handle($args=""){

        return self::handleProduct($args);
    }
    static function handleProduct($args){
        $action=$args['action'];
        switch($action){
            case "change_status":
                $data=self::handleChangeStatus();
                break;
            case "change_category":
                $data=self::handleChangeCategory();
                break;
            case "reset_product":
                $data=self::handleResetProduct();
                break;
            case "get_commission":
                $data=self::handleGetProductCommission();
                break;
            case "change_commission":
                $data=self::handleChangeProductCommission();
                break;
            default:
                $data=self::request('error','','操作错误！');
                break;
        }
        return $data;
    }

    //更改产品在线状态
    static function handleChangeStatus(){
        $request = Func_Input::filter(array(
            'status' => 'int',
            'product_id' => 'int',
        ));
        if (!$request['product_id']) {
            return self::request('error','','参数缺失！');
        }
        //更新产品状态
        $r = Data_Mysql_Table_Product_Info::query("UPDATE {table} SET status = ? WHERE id = ?", array($request['status'], $request['product_id']), 1);
        $r_update = Data_Mysql_Table_Product_Info::query("UPDATE {table}_update SET status = ? WHERE id = ?", array($request['status'], $request['product_id']), 1);
        $r_search = Data_Mysql_Table_Product_Search::query("UPDATE {table} SET status = ? WHERE id = ?", array($request['status'], $request['product_id']), 1);
        if (empty($r[0])) {
            return self::request('error','','操作失败！');
        }else{
            return self::request('success','','操作成功！');
        }
    }

    //修改产品分类
    static function handleChangeCategory(){
        $request = Func_Input::filter(array(
            'category_id' => 'int',
            'product_id' => 'int',
            'vendor_id'=>'int',
        ));
        if (!$request['product_id']) {
            return self::request('error', '', '缺少参数！');
        }
        //更新产品服务类型
        $r_update = Data_Mysql_Table_Product_Info::subTable('_update')->query("UPDATE {table} SET category_id = ?,status= ? WHERE id = ?", array(
            $request['category_id'],
            2,
            $request['product_id']
        ), 1);
        if (empty($r_update[0])) {
            return self::request('error', '', '修改失败！');
        } else {
            //更改所属供应商的状态
            Data_Mysql_Table_Vendor_Info::subTable('_update')->update(array('id = ? and status != ?' => array($request['vendor_id'], 2)), array('status' => 4));
            return self::request('success', '', ' 修改成功,等待审核中！');
        }
    }

    //重置产品信息
    static function handleResetProduct(){
        $request = Func_Input::filter(array(
            'product_id' => 'int',
        ));
        if (empty($request['product_id'])) {
            return self::request('error', '', '参数错误！！');
        }
        $product = Data_Mysql_Table_Product_Info::select('id, category_id, vendor_id,product_name,attr,attr_new,product_size,logo,media,des,addr,status,price', $request['product_id']);
        if (empty($product[0])) {
            return self::request('error', '', '产品不存在！！');
        }
        $productInfo = $product[0];
        if (!empty($productInfo['attr_new'])) {
            $productInfo['attr_new'] = json_decode($productInfo['attr_new'], 1);
        }
        if (!empty($productInfo['attr'])) {
            $productInfo['attr'] = json_decode($productInfo['attr'], 1);
        }
        if (!empty($productInfo['media'])) {
            $productInfo['media'] = json_decode($productInfo['media'], 1);
        }
        $rs = Data_Mysql_Table_Product_Info::subTable("_update")->update($productInfo);
        if (!empty($rs[0])) {
            return self::request('success', '', ' 操作成功！！');
        } else {
            return self::request('error', '', '操作失败！！');
        }
    }

    //获取产品的成交佣金
    static function handleGetProductCommission(){
        $request=Func_Input::filter(array(
            'product_id'=>'int',
        ));
        if(empty($request['product_id'])){
            return self::request('error',"","参数缺失！");
        }
        $rs = Data_Mysql_Table_Product_Marketing::select('id,recommend_charges', array('id =?' => $request['product_id']));
        if (!empty($rs[0]['recommend_charges'])) {
            return self::request('success', $rs[0]['recommend_charges'] / 100, '获取成功');
        }else{
            return self::request('error',"","未设置佣金");
        }
    }

    //更新产品的成交佣金
    static function handleChangeProductCommission(){
        $request = Func_Input::filter(array(
            'product_id' => 'int',
            'recommend_charges' => 'int',
        ));
        if(empty($request['product_id'])){
            return self::request('error',"","参数缺失！");
        }
        if(!is_numeric($request['recommend_charges'])){
            return self::request('error',"","请输入正确的佣金！");
        }
        $r = Data_Mysql_Table_Product_Marketing::update(array(
            'id' => $request['product_id'],
            'recommend_charges' => $request['recommend_charges'] * 100,
        ));
        if ($r > 0) {
            return self::request('success', '', '  设置成功');
        } else {
            return self::request('error', '', '设置失败');
        }
    }
}