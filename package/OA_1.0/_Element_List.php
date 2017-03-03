<?php

/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 15-5-8
 * Time: 上午9:46
 */
class OA_Element_List
{
    static function handle()
    {
        if (!empty($_REQUEST['action']) && $_REQUEST['action'] == 'detail') {
            self::productDetail();
        } elseif (!empty($_REQUEST['action']) && $_REQUEST['action'] == 'edit') {
            self::productEdit();
        } elseif (!empty($_REQUEST['is_submit'])) {
            self::productEditSubmit();
        } else {
            self::productList();
        }
    }

    /*
     * 产品列表页
     */
    static function productList()
    {
       $res = Api_Element_Product_List::elementProductList($_REQUEST);
        Tpl_Smarty::assign('_data',$res['data']);
        Tpl_Smarty::display('OA_Static::elements/element_product_list.tpl');
    }

    /*
     * 产品详情页
     */
    static function productDetail()
    {
        if (empty($_REQUEST['id'])) {
            Func_Header::back('参数错误！！');
        }
        $productInfo = self::getProductInfoById($_REQUEST['id']);
        $tags = array();
        if (!empty($productInfo['media'])) {
            $media = array();
            foreach ($productInfo['media'] as $k => $v) {
                if (empty($v['name'])) {
                    $v['name'] = '其他图片';
                }
                if (!empty($v['tags'])) {
                    $tags = explode(',', $v['tags']);
                    foreach ($tags as $tv) {
                        if (empty($tv)) {
                            $tv = '其他';
                        }
                        $media[$tv][1][$k] = array($v['name'], $v['path']);
                    }
                } else {
                    $media['其他'][1][$k] = array($v['name'], $v['path']);
                }
            }
            $i = 1;
            foreach ($media as $k => $v) {
                $media[$k][0] = $i;
                $i += count($v[1]);
            }
            $productInfo['media'] = $media;
        }
        $isSales = Admin_Authority::checkUrl('sales/my_demand_list', 0);
        if ($isSales && $productInfo['vendor_id']) {
            $librarylist=array();
            $rs = Data_Mysql_Table_Vendor_Info::select('id,vendor_account_id', array('id' => $productInfo['vendor_id']));
            if(empty($rs[0])){
                $rs = Data_Mysql_Table_Vendor_Info::subTable("_update")->select('id,vendor_account_id', array('id' => $productInfo['vendor_id']));
            }
            if (!empty($rs[0]['vendor_account_id'])) {
               $librarylist=Data_Mysql_Table_Account::select('*',array('id'=>$rs[0]['vendor_account_id']));
                if(!empty($librarylist[0]) && !empty($librarylist[0]['attr'])){
                    $librarylist[0]['attr']=json_decode($librarylist[0]['attr'],1);
                }
            }
            Tpl_Smarty::assign('librarylist', $librarylist);
        }

//        if ($isSales && $productInfo['vendor_id']) {
//            $rs = Data_Mysql_Table_Vendor_Info::select('*', array('{table}.id=?' => $productInfo['vendor_id']), '', 1, '{table}');
//            if (!empty($rs[0]['vendor_account_id'])) {
//                $librarylist = Data_Mysql_Table_Contact_Library::select("*", array('account_id' => $rs[0]['vendor_account_id']), '', 100, '{table}');
//                if (empty($librarylist)) {
//                    $librarylist = Data_Mysql_Table_Contact_Library::select("*", array('vendor_id' => $productInfo['vendor_id']), '', 100, '{table}');
//                }
//            } else {
//                $librarylist = Data_Mysql_Table_Contact_Library::select("*", array('vendor_id' => $productInfo['vendor_id']), '', 100, '{table}');
//            }
//            Tpl_Smarty::assign('librarylist', $librarylist);
//        }


        if (!empty($productInfo['category_id'])) {
            $tags = Data_Mysql_Table_Product_Category::getTagsInfo($productInfo['category_id']);
        }
        //获取该产品下已完成的订单信息
        $order = Api_Order_Normal_Api::getOrder('product',$_REQUEST['id']);
        Tpl_Smarty::assign('order', $order);
        Tpl_Smarty::assign('tags', $tags);
        Tpl_Smarty::assign('data', $productInfo);
        Tpl_Smarty::assign('is_admin', Admin_Authority::checkUrl('marketing/contact_urgent_list', 0));
        Tpl_Smarty::assign('is_sales', $isSales);
        Tpl_Smarty::display('OA_Static', 'elements/element_product_detail.tpl');
    }

    /*
     *产品编辑
     */
    static function productEdit()
    {
        if (!Admin_Authority::checkUrl('marketing/contact_urgent_list', 0)) {
            Func_Header::back('没有权限！！');
        }
        if (empty($_REQUEST['id'])) {
            Func_Header::back('参数错误！！');
        }
        $productInfo = self::getProductInfoById($_REQUEST['id']);
        $tags = array();
        if (!empty($productInfo['category_id'])) {
            $tags = Data_Mysql_Table_Product_Category::getTagsInfo($productInfo['category_id']);
        }
        $conditions['id'] = $productInfo['vendor_id'];
        $account_id = Data_Mysql_Table_Vendor_Info::select("vendor_account_id", $conditions);
        Tpl_Smarty::assign("account_id", !empty($account_id[0]['vendor_account_id']) ? $account_id[0] : array('vendor_account_id' => 415));
        Tpl_Smarty::assign('_tags_info', $tags);
        Tpl_Smarty::assign('_data', $productInfo);
        Tpl_Smarty::display('OA_Static', 'elements/element_product_edit.tpl');
    }


    /*
     *产品编辑修改提交
     */
    static function productEditSubmit()
    {
        if (!Admin_Authority::checkUrl('marketing/contact_urgent_list', 0)) {
            Func_Header::back('没有权限！！');
        }
        $_REQUEST['edit'] = '1';
        $rs = Api_Product_Submit::handle($table="update",$_REQUEST);
        if($rs['status']==0) {
            Func_Header::back($rs['msg']);
        }
        if (!empty($rs['data']) && $rs['data'] > 0) {
            //更改所属供应商的状态
            Data_Mysql_Table_Vendor_Info::subTable('_update')->update(array('id = ? and status != ?' => array($_REQUEST['data']['vendor_id'], 2)), array('status' => 4));
            if(!empty($_REQUEST['is_back'])) {
                $back_url = str_replace('my_vendor_list','vendor_candidate',Core::$urls['path']);
                Func_Header::to(' 数据处理成功！', $back_url);
            }else{
                Func_Header::to(' 产品更新已提交，正在审核！！');
            }
        }
        Func_Header::to('操作错误！！');

    }

    /*
     *获取产品信息
     */
    static function getProductInfoById()
    {
        $productInfo = array();
        $condition['{table}.id = ?'] = $_REQUEST['id'];
        $product = Data_Mysql_Table_Product_Info::select('*,{table}.id,{table}_update.status as update_status', $condition, '', 1, '{table} LEFT JOIN {prefix}product_remark ON {table}.id = {prefix}product_remark.product_id LEFT JOIN {table}_update ON {table}_update.id={table}.id');
        if (empty($product[0])) {
            Func_Header::back('产品不存在！！');
        }
        $productInfo = $product[0];
        if (!empty($productInfo['price'])) {
            $productInfo['price'] = $productInfo['price'] / 100;
        }
        if (!empty($productInfo['attr_new'])) {
            $productInfo['attr_new'] = json_decode($productInfo['attr_new'], 1);
        }
        if (!empty($productInfo['media'])) {
            $productInfo['media'] = json_decode($productInfo['media'], 1);
        }
        return $productInfo;
    }

}