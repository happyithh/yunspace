<?php

/**
 * Created by PhpStorm.
 * User: yl
 * Date: 15-6-18
 * Time: 上午11:27
 * 带看场地相关数据调用
 */
class OA_Demand_Handle_Take_Look
{
    static function handle()
    {
        if (!empty($_REQUEST['action']) && $_REQUEST['action'] == 'demand_detail') {
            self::demandDetail();
        } else {
            self::takeElementList();
        }
    }

    /*
     *带看场地列表
     */
    static function takeElementList()
    {
        $data = Api_Demand_Admin_getTakeLook::getTakeLook($_REQUEST);
        if(!empty($data['data'])){
            Tpl_Smarty::assign('_data', $data['data']);
        }
        Tpl_Smarty::display('OA_Static::elements/element_demand_take_look.tpl');
    }

    /*
     *查看需求
     */
    static function demandDetail()
    {
        if (empty($_REQUEST['id'])) {
            Func_Header::back('参数错误！！');
        }
        OA_Demand_Operate::demandDetail();
    }


    /*
     * 需求---带看场地数据提交
    */
    static function takeLookSubmit()
    {
        $request = Func_Input::filter(array(
            'data' => 'array',
        ), $_REQUEST);
        if (empty($request['data']['demand_id'])) {
            Func_Header::notFound();
        }
        if (empty($request['data']['product_id'])) {
            Func_Header::back('请输入正确的产品地址');
        }
        if (empty($request['data']['look_time'])) {
            Func_Header::back('请输入查看场地的时间');
        }
        $p = Data_Mysql_Table_Product_Info::select('id, product_name', array('id' => $request['data']['product_id']));
        if (empty($p[0]['id'])) {
            Func_Header::back('该产品不存在');
        }
        $data['product_id'] = $request['data']['product_id'];
        $data['demo'] = $request['data']['demo'];
        $data['demand_id'] = $request['data']['demand_id'];
        $data['look_time'] = strtotime($request['data']['look_time']);
        $data['admin_id'] = $_SESSION['administrator']['id'];
        $rs = Data_Mysql_Table_Demand_Take_Look::insert($data);
        if ($rs[0] > 0) {
            //向联系记录里添加一条信息
            $content = '带看场地ID:' . $request['data']['product_id'] . "/{$p[0]['product_name']}" . '&nbsp;&nbsp;查看时间：' . $request['data']['look_time'] . '&nbsp;&nbsp;场地地址：http://' . Core::$urls['host'] . '/service_info/' . $request['data']['product_id'] . '.html&nbsp;&nbsp;备注：' . $request['data']['demo'];
            $contacts = OA_My_Customer_Account::getContactsByDemand($request['data']['demand_id']);
            if (empty($contacts)) {
                Func_Header::back('联系人不存在！！');
            }
            $contact_record['content'] = $content;
            $contact_record['contact_id'] = $contacts[0]['id'];
            $contact_record['admin_id'] = $_SESSION['administrator']['id'];
            $contact_record['admin_name'] = $_SESSION['administrator']['username'];
            $contact_record['time'] = time();
            Data_Mysql_Table_Contact_Record::insert($contact_record);
            Func_Header::to(' 带看场地信息添加成功！');
        }
        Func_Header::to('带看场地信息添加失败');
    }

    /*
     * 需求---带看场地数据调用
    */
    static function takeLookList()
    {
        $data = array();
        //获取需求的带看场地列表
        $data = Data_Mysql_Table_Demand_Take_Look::page(0, 0, '{table}.product_id,{prefix}product_info.product_name,{table}.create_time,{table}.demo,{table}.look_time', array('demand_id' => $_REQUEST['demand_id'], '{prefix}product_info.id != ?' => 0), 'ORDER BY {table}.look_time ASC', '
        {table} LEFT JOIN {prefix}product_info on {table}.product_id={prefix}product_info.id');
        return $data;
    }
}