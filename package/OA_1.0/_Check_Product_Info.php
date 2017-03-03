<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 15-5-7
 * yl
 * 供应商产品审核
 */
$_REQUEST['action'] = empty($_REQUEST['action']) ? 'check_product' : $_REQUEST['action'];

class OA_Check_Product_Info
{
    static function handle()
    {
        if (!empty($_REQUEST['handle_type']) && $_REQUEST['handle_type'] == 'refuse') {
            self::handleProductRefuse();
        } elseif (!empty($_REQUEST['handle_type']) && $_REQUEST['handle_type'] == 'pass') {
            self::handleProductPass();
        } else {
            self::handleProductDetail();
        }
    }

    /*
    *供应商产品信息详情页
    */
    static function handleProductDetail()
    {
        $categories = Data_Mysql_Table_Product_Category::getInfoCache();
        if (empty($_REQUEST['id'])) {
            Func_Header::notFound();
        }
        $conditions = array('id' => $_REQUEST['id']);
        $cols = array("{table}.id , {table}.category_id,  {table}.product_name,{table}.product_size,{table}.attr_new,{table}.price, {table}.status,{table}.attr,{table}.addr,{table}.des,{table}.media,{table}.create_time,{table}.update_time,{table}.order_lv,{prefix}vendor_info.vendor_name");
        $product = Data_Mysql_Table_Product_Info::subTable('_update')->select($cols, $conditions, '', 1, '{table} LEFT JOIN {prefix}vendor_info ON {table}.vendor_id = {prefix}vendor_info.id');
        if (empty($product[0])) {
            Func_Header::notFound();
        }
        $productInfo = $product[0];
        $productInfo['attr'] = json_decode($productInfo['attr'], 1);
        $productInfo['attr_new'] = json_decode($productInfo['attr_new'], 1);
        $productInfo['media'] = json_decode($productInfo['media'], 1);
        $productInfo['price'] /= 100;
        if (!empty($categories[$productInfo['category_id']][0])) {
            $productInfo['category_name'] = $categories[$productInfo['category_id']][0];
        }
        $_tags_info = array();
        if (!empty($productInfo['category_id'])) {
            $_tags_info = Data_Mysql_Table_Product_Category::getTagsInfo($productInfo['category_id']);
        }
        $reason = array(
            '证件不全','资历不够','其他原因'
        );
        Tpl_Smarty::assign('rejectreason', $reason);
        Tpl_Smarty::assign('data', $productInfo);
        Tpl_Smarty::assign('_tags_info', $_tags_info);
        Tpl_Smarty::display('OA', 'check/product_detail_scan.tpl');
    }

    /*
     *产品通过审核
     */
    static function handleProductPass()
    {
        if (empty($_REQUEST['id'])) {
            Func_Header::notFound();
        }
        $cols = array("id ,category_id,logo, product_name,price,addr,product_size,attr,attr_index,attr_new,des,media,media_num,vendor_id,create_time,admin_id,order_lv,create_by_quick");
        $data = Data_Mysql_Table_Product_Info::subTable('_update')->select($cols, array('id' => $_REQUEST['id']));

        if (!empty($data[0]['attr'])) {
            $data[0]['attr'] = json_decode($data[0]['attr'], 1);
        }
        if (!empty($data[0]['attr_new'])) {
            $data[0]['attr_new'] = json_decode($data[0]['attr_new'], 1);
        }
        if (empty($data[0]['attr_new'][46])) {
            Func_Header::back('城市信息没有正确填写,不能通过审核！');
        }
        if (!empty($data[0]['attr_index'])) {
            $data[0]['attr_index'] = json_decode($data[0]['attr_index'], 1);
        }
        if (!empty($data[0]['media'])) {
            $data[0]['media'] = json_decode($data[0]['media'], 1);
        }
        if (!$data[0]['admin_id']) {
            $data[0]['admin_id'] = $_SESSION['administrator']['id'];
        }
        //如果之前被拒绝过则去掉名称“|”以及后面之前的拒绝理由
        if (!empty($data[0]['product_name'])) {
            $data[0]['product_name'] = preg_replace('/\|.*/','',$data[0]['product_name']);
        }
        //更新产品状态，主表和update表信息
        $condition = array('id' => $_REQUEST['id']);
        $update_data = array('status' => 1,'refuse_reason' => '');
        $update_rs = Data_Mysql_Table_Product_Info::subTable('_update')->update($condition, $update_data);
        //产品通过并上线
        if(isset($_REQUEST['upstatus'])){
            $data[0]['status'] = 1;
        }
        if ($update_rs[0] > 0) {
            //将信息放入主表中
            $rs = Data_Mysql_Table_Product_Info::update($data[0]);
            if ($rs[0] > 0) {
                //创建操作日志
                $vendorInfo = Data_Mysql_Table_Vendor_Info::select('id,vendor_account_id', array('id' => $data[0]['vendor_id']));
                if (!empty($vendorInfo[0])) {
                    Data_Mysql_Table_Account_Log::insertAccountLog($vendorInfo[0]['vendor_account_id'], $_SESSION['administrator']['id'], '产品通过审核', '审核产品', $data[0]['id']);
                }
                //创建历史记录
                $history_data = array('object_id' => $data[0]['id'], 'admin_id' => $_SESSION['administrator']['id'], 'operate_type' => 1, 'data_backup' => $data[0]);
                Data_Mysql_Table_History::subTable('_product' . date("_Ym"))->insert($history_data);
                Func_Header::to(' 产品信息审核成功！', Core::$urls['path'] . "?action=waiting&vendor_id=" . $_REQUEST['vendor_id'] . '&admin_name=' . $_REQUEST['admin_name'].'&time='.time());
            }
        }
        Func_Header::back('产品信息审核失败，请重试！');
    }

    /*
     *产品未通过审核
     */
    static function handleProductRefuse()
    {
        $request = Func_Input::filter(array(
            'id' => 'id',
            'reason' => 'string',
        ));
        if (empty($request['id'])) {
            Func_Header::notFound();
        }
        if (empty($request['reason'])) {
            Func_Header::back('请输入拒绝理由');
        }
        //更新产品update表状态
        $condition = array('id' => $_REQUEST['id']);
        $data = array(
            'status' => 3,
//            'product_name = CONCAT(product_name,"|",?)' => $request['reason'],
            'refuse_reason' => $request['reason'],
        );
        $update_rs = Data_Mysql_Table_Product_Info::subTable('_update')->update($condition, $data);
        if ($update_rs[0] > 0) {
            $vendorInfo = Data_Mysql_Table_Vendor_Info::select('{table}.vendor_account_id,{prefix}product_info_update.id', array('{prefix}product_info_update.id = ?' => $request['id']), '', 1, '{table} LEFT JOIN {prefix}product_info_update ON {table}.id = {prefix}product_info_update.vendor_id');

            //审核拒绝则发送邮件
            $admin_name = empty($_REQUEST['admin_name']) ? '' : $_REQUEST['admin_name'];
            $id = empty($_REQUEST['id']) ? '' : $_REQUEST['id'];
            $vendor_id = empty($_REQUEST['vendor_id']) ? '' : $_REQUEST['vendor_id'];
            $href = 'http://www.yunspace.com.cn/vendor_center/vendor_admin/product_edit?product_id='.$id;
            if($_REQUEST['action'] = 'check_product') {
                $sort = '产品';
            }else{
                $sort = '';
            }
            //根据供应商产品id查询出相关数据
            if(!empty($id)) {
                $rs = Data_Mysql_Table_Product_Info::subTable('_update')->select("id,product_name",array('id = ?'=> $id));
                $rs[0]['product_name'] = preg_replace('/\|.*/','',$rs[0]['product_name']);
            }
            //根据供应商id查询出相关数据
            if(!empty($vendor_id)) {
                $r = Data_Mysql_Table_Vendor_Info::subTable('_update')->select("vendor_name",array('id = ?'=> $vendor_id));
                $r[0]['vendor_name'] = preg_replace('/\|.*/','',$r[0]['vendor_name']);
            }
            //有负责人则发送邮件给负责人
            if(!empty($admin_name))
            {
                OA_Account_Check::refuseMailtoAdmin($admin_name,$request['reason'],$r[0]['vendor_name'],$sort,$rs[0]['id'],$rs[0]['product_name']);
            } else {
                //发送邮件给供应商账户
                OA_Account_Check::refuseMailtoAccount($vendorInfo[0]['vendor_account_id'],$request['reason'],$r[0]['vendor_name'],$sort,$rs[0]['id'],$rs[0]['product_name'],$href);
            }

            //创建操作日志
            if (!empty($vendorInfo[0])) {
                Data_Mysql_Table_Account_Log::insertAccountLog($vendorInfo[0]['vendor_account_id'], $_SESSION['administrator']['id'], '产品未通过审核', '审核产品', $request['id']);
            }
            Func_Header::to(' 该产品未通过审核！', Core::$urls['path'] . "?action=waiting&vendor_id=" . $_REQUEST['vendor_id'] . '&admin_name=' . $_REQUEST['admin_name']);
        }
        Func_Header::back('拒绝理由字数不能超过100字！');
    }
}