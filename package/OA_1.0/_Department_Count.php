<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 15-5-11
 * Time: 上午10:53
 */
class OA_Department_Count{
    static function handle($type=1){
        $_REQUEST['tab']=empty($_REQUEST['tab'])?'contact_data':$_REQUEST['tab'];
        $_REQUEST['type']=empty($_REQUEST['type'])?$type:$_REQUEST['type'];
        $city = empty($_REQUEST['city']) ? '' : $_REQUEST['city'];
        if (empty($_REQUEST['city'])) {
            $quota = Api_Administrator_Department_Normal_Api::getMemberInfo($type == 1 ? '销售部' : '市场部', $_SESSION['administrator']['id']);
            if (!empty($quota['city'])) {
                $city = $quota['city'];
            } else {
                $city = '上海';
            }
        }
        $admin_ids=$admin=array();
        $adminInfo = Api_Administrator_Department_Normal_Api::getMemberList($type == 1 ? '销售部' : '市场部', $city, 1);
        if (!empty($adminInfo)) {
            foreach ($adminInfo as $key => $value) {
                $admin_ids[] = $value['admin_id'];
                $admin[$value['admin_id']] = $value['fullname'];
            }
        }
       //q($admin_ids);
        switch($_REQUEST['tab']){
            case 'contact_data':
                self::handleContactData($admin_ids,$admin);
                break ;
            case 'vendor_data':
                self::handleVendorData($admin_ids,$admin,$type);
                break;
            case 'account_data':
                self::handleAccountData();
                break;
            case 'order_data':
                self::handleOrderData($admin_ids,$admin,$type);
                break;
            default :
                Func_Header::notFound();
                break;
        }
//        q($admin);
        Tpl_Smarty::assign('_adminInfo',$admin);
        Tpl_Smarty::assign('categoryList', Data_Mysql_Table_Product_Category::getTreeCache());
        Tpl_Smarty::display('OA','department_count/department_sum.tpl');
    }
    static function handleContactData($admin_ids=array(),$admin=array()){
        $contact_data=array();
        if (!empty($_REQUEST['search'])) {
            $search = Func_Input::filter(array(
                'admin_id' => 'int',
                'start_time' => 'string',
                'end_time' => 'string',
                'business' => 'string',
                'sub_business' => 'string',
            ), $_REQUEST['search']);
            if (!empty($search['admin_id'])) {
                $conditions['{table}.admin_id = ?'] = $search['admin_id'];
            }
            if (!empty($search['business'])) {
                $conditions['{prefix}contact_library.business = ?'] = $search['business'];
            }
            if (!empty($search['sub_business'])) {
                $conditions['{prefix}contact_library.sub_business = ?'] = $search['sub_business'];
            }
            if (!empty($search['start_time']) && !empty($search['end_time'])) {
                if (strtotime($search['start_time']."00:00:00 ") > strtotime($search['end_time']."23:59:59")) {
                    Func_Header::back('请正确选择时间范围！！');
                } else {
                    $conditions['{table}.allocate_time between ? and ?'] = array(strtotime($search['start_time']."00:00:00 "), strtotime($search['end_time']."23:59:59"));
                }
            } elseif (!empty($search['start_time']) && empty($search['end_time'])) {
                $conditions['{table}.allocate_time > ?'] = strtotime($search['start_time']."00:00:00");
            } elseif (empty($search['start_time']) && !empty($search['end_time'])) {
                $conditions['{table}.allocate_time < ?'] = strtotime($search['end_time']."23:59:59");
            }
        }
        $conditions[] = '{table}.admin_id in (' . implode(',', $admin_ids) . ")";
        $cols = array('count({prefix}contact_library.id) as total_num', '{table}.admin_id');
        $order = 'GROUP BY {table}.admin_id ORDER BY total_num DESC';
        $contact_data = Data_Mysql_Table_Contact_Relation::page(0, 100, $cols, $conditions, $order,
            '{table} LEFT JOIN {prefix}contact_library ON {table}.contact_id = {prefix}contact_library.id');

        Tpl_Smarty::assign('contact_data',$contact_data);
        //图表显示
        $userlist = array();
        $usercountlist = array();
        if(!empty($contact_data['rows'])){
            foreach($contact_data['rows'] as $k=>$v){
                $userlist[] = $admin[$v['admin_id']];
                $usercountlist[] = $v['total_num'];
            }
        }
        Tpl_Smarty::assign('userlist',json_encode($userlist));
        Tpl_Smarty::assign('usercountlist',json_encode($usercountlist));
        //下载表格
        if(!empty($_REQUEST['action1']) && $_REQUEST['action1']=="export"){
            $cols = array("排名","员工","联系人数量");
            $list = array();
            foreach($contact_data['rows'] as $k=>$v){
                $list[$k][] = $k+1;
                $list[$k][] = $admin[$v['admin_id']];
                $list[$k][] = $v['total_num'];
            }
             Func_Csv::writeRow($cols,$list,"市场部联系人数量");
            return ;
        }
    }
    static function handleVendorData($admin_ids=array(),$admin=array(),$type){
        $vendor_data=array();
        if (!empty($_REQUEST['search'])) {
            $search = Func_Input::filter(array(
                'admin_id' => 'int',
                'start_time' => 'string',
                'end_time' => 'string',
                'business' => 'string',
                'sub_business' => 'string',
            ), $_REQUEST['search']);
            if (!empty($search['admin_id'])) {
                $conditions['{prefix}contact_relation.admin_id = ?'] = $search['admin_id'];
                $conditions1['{prefix}contact_relation.admin_id = ?'] = $search['admin_id'];
                $conditions2['{prefix}contact_relation.admin_id = ?'] = $search['admin_id'];
            }
            if (!empty($search['business'])) {
                $conditions['{table}.business = ?'] = $search['business'];
                $conditions1['{table}.business = ?'] = $search['business'];
                $conditions2['{table}.business = ?'] = $search['business'];
            }
            if (!empty($search['sub_business'])) {
                $conditions['{table}.sub_business = ?'] = $search['sub_business'];
                $conditions1['{table}.sub_business = ?'] = $search['sub_business'];
                $conditions2['{table}.sub_business = ?'] = $search['sub_business'];
            }
            if (!empty($search['start_time']) && !empty($search['end_time'])) {
                if (strtotime($search['start_time']."00:00:00") > strtotime($search['end_time']."23:59:59")) {
                    Func_Header::back('请正确选择时间范围！！');
                } else {
                    $conditions['{prefix}contact_relation.allocate_time between ? and ?'] = array(strtotime($search['start_time']."00:00:00"), strtotime($search['end_time']."23:59:59"));
                    $conditions1['{prefix}contact_relation.allocate_time between ? and ?'] = array(strtotime($search['start_time']."00:00:00"), strtotime($search['end_time']."23:59:59"));
                    $conditions2['{prefix}contact_relation.allocate_time between ? and ?'] = array(strtotime($search['start_time']."00:00:00"), strtotime($search['end_time']."23:59:59"));
                }
            } elseif (!empty($search['start_time']) && empty($search['end_time'])) {
                $conditions['{prefix}contact_relation.allocate_time > ?'] = strtotime($search['start_time']."00:00:00");
                $conditions1['{prefix}contact_relation.allocate_time > ?'] = strtotime($search['start_time']."00:00:00");
                $conditions2['{prefix}contact_relation.allocate_time > ?'] = strtotime($search['start_time']."00:00:00");
            } elseif (empty($search['start_time']) && !empty($search['end_time'])) {
                $conditions['{prefix}contact_relation.allocate_time < ?'] = strtotime($search['end_time']."23:59:59");
                $conditions1['{prefix}contact_relation.allocate_time < ?'] = strtotime($search['end_time']."23:59:59");
                $conditions2['{prefix}contact_relation.allocate_time < ?'] = strtotime($search['end_time']."23:59:59");
            }
        }
            $conditions[] = '{table}.admin_id in (' . implode(',', $admin_ids) . ")";
            $conditions[] = '{prefix}contact_library.account_id != 0 ';
            $conditions[] = '{prefix}contact_library.type ='.$type;
            $conditions[] = '{prefix}vendor_info.status in(0,1)';
            $cols =  array('count({prefix}vendor_info.id) as total_num','{table}.admin_id');
            $order = 'GROUP BY {table}.admin_id ORDER BY total_num DESC';
//        Data_Mysql_Table_Contact_Relation::debug(1);
            $vendor_data = Data_Mysql_Table_Contact_Relation::page(0, 100, $cols, $conditions,$order,
                   '{table} LEFT JOIN {prefix}contact_library ON {table}.contact_id = {prefix}contact_library.id LEFT JOIN {prefix}vendor_info ON {prefix}contact_library.account_id = {prefix}vendor_info.vendor_account_id');

//        q($vendor_data);
        $conditions1[] = '{table}.admin_id in (' . implode(',', $admin_ids) . ")";
        $conditions1[] = '{prefix}contact_library.account_id != 0 ';
        $conditions1[] = '{prefix}contact_library.type ='.$type;
        $conditions1[] = '{prefix}vendor_info.status = ' . 1;
        $order1 = 'GROUP BY {table}.admin_id ORDER BY total_num DESC';
        $cols1 =  array('count({prefix}vendor_info.id) as total_num','{table}.admin_id');
        $vendor_data1 = Data_Mysql_Table_Contact_Relation::page(0, 100, $cols1, $conditions1,$order1,
            '{table} LEFT JOIN {prefix}contact_library ON {table}.contact_id = {prefix}contact_library.id LEFT JOIN {prefix}vendor_info ON {prefix}contact_library.account_id = {prefix}vendor_info.vendor_account_id');
//        Data_Mysql_Table_Contact_Relation::debug(1);

        $conditions2[] = '{table}.admin_id in (' . implode(',', $admin_ids) . ")";
        $conditions2[] = '{prefix}contact_library.account_id != 0 ';
        $conditions2[] = '{prefix}contact_library.type ='.$type;
        $conditions2[] = '{prefix}vendor_info.status = ' . 0;
        $order2 = 'GROUP BY {table}.admin_id ORDER BY total_num DESC';
        $cols2 =  array('count({prefix}vendor_info.id) as total_num','{table}.admin_id');
        $vendor_data2 = Data_Mysql_Table_Contact_Relation::page(0, 100, $cols2, $conditions2,$order2,
            '{table} LEFT JOIN {prefix}contact_library ON {table}.contact_id = {prefix}contact_library.id LEFT JOIN {prefix}vendor_info ON {prefix}contact_library.account_id = {prefix}vendor_info.vendor_account_id');
//        q($vendor_data,$vendor_data1,$vendor_data2,$admin);
        $arrresult = array();
        foreach($vendor_data['rows'] as $k=>$v){
            $arrresult[$k]['username'] = $admin[$v['admin_id']];
            $arrresult[$k]['all'] = $v['total_num'];
            $arrresult[$k]['up']  =0;
            $arrresult[$k]['down'] =0;
            foreach($vendor_data1['rows'] as $kk =>$vv){
                if($vv['admin_id']==$v['admin_id']){
                    $arrresult[$k]['up'] = $vv['total_num'];
                }
            }
            foreach($vendor_data2['rows'] as $kkk =>$vvv){
                if($vvv['admin_id']==$v['admin_id']){
                    $arrresult[$k]['down'] = $vvv['total_num'];
                }
            }
            if(empty($arrresult[$k]['all'])){
                unset($arrresult[$k]);
            }
        }
//
        Tpl_Smarty::assign('vendor_data',$arrresult);
//        //图表显示
        //q($arrresult);
        $userlist = array();
        $usercountlist = array();
        $useruplist =array();
        $userdownlist = array();
        //q($arrresult);
        if(!empty($vendor_data['rows'])){
            foreach($arrresult as $kk=>$vv){
                    $userlist[] =$arrresult[$kk]['username'];
                    $usercountlist[]=$arrresult[$kk]['all'];
                    $useruplist[]=$arrresult[$kk]['up'];
                    $userdownlist[]=$arrresult[$kk]['down'];

            }
        }
        Tpl_Smarty::assign('userlist',json_encode($userlist));
        Tpl_Smarty::assign('usercountlist',json_encode($usercountlist));
        Tpl_Smarty::assign('useruplist',json_encode($useruplist));
        Tpl_Smarty::assign('userdownlist',json_encode($userdownlist));

        //下载表格
//        q($_REQUEST['action1']);
        if(!empty($_REQUEST['action2']) && $_REQUEST['action2']=="export"){
           $cols = array("排名","员工","供应商数量","未上线数量","已上线数量");
            $list = array();
            foreach($arrresult as $k=>$v){
                $list[$k][] = $k+1;
                $list[$k][] = $v['username'];
                $list[$k][] = $v['all'];
                $list[$k][] = $v['down'];
                $list[$k][] =$v['up'];
            }
             //q($cols,$list);
            Func_Csv::writeRow($cols,$list,"市场部供应商数量");
            return ;
        }

   }


    

    static function handleAccountData(){

    }

    static function handleOrderData($admin_ids=array(),$admin=array(),$type){
        $order_data=array();
        if (!empty($_REQUEST['search'])) {
            $search = Func_Input::filter(array(
                'admin_id' => 'int',
                'start_time' => 'string',
                'end_time' => 'string',
                'business' => 'string',
                'sub_business' => 'string',
            ), $_REQUEST['search']);
            if (!empty($search['admin_id'])) {
                $conditions['{table}.admin_id = ?'] = $search['admin_id'];
            }
            if (!empty($search['business'])) {
                $conditions['{prefix}contact_library.business = ?'] = $search['business'];
            }
            if (!empty($search['sub_business'])) {
                $conditions['{prefix}contact_library.sub_business = ?'] = $search['sub_business'];
            }
            if (!empty($search['start_time']) && !empty($search['end_time'])) {
                if (strtotime($search['start_time']."00:00:00") > strtotime($search['end_time']."23:59:59")) {
                    Func_Header::back('请正确选择时间范围！！');
                } else {
                    $conditions['{table}.allocate_time between ? and ?'] = array(strtotime($search['start_time']."00:00:00"), strtotime($search['end_time']."23:59:59"));
                }
            } elseif (!empty($search['start_time']) && empty($search['end_time'])) {
                $conditions['{table}.allocate_time > ?'] = strtotime($search['start_time']."00:00:00");
            } elseif (empty($search['start_time']) && !empty($search['end_time'])) {
                $conditions['{table}.allocate_time < ?'] = strtotime($search['end_time']."23:59:59");
            }
        }
        $conditions[] = '{table}.admin_id in (' . implode(',', $admin_ids) . ")";
        $cols =  array('count({prefix}order_info.create_time) as total_num','{table}.admin_id');
        $order = 'GROUP BY {table}.admin_id ORDER BY total_num DESC';
       // Data_Mysql_Table_Contact_Relation::debug(1);
        $order_data = Data_Mysql_Table_Contact_Relation::page(0, 100, $cols, $conditions, $order,
            '{table} LEFT JOIN {prefix}contact_library ON {table}.contact_id = {prefix}contact_library.id LEFT JOIN {prefix}order_info ON {prefix}contact_library.account_id = {prefix}order_info.vendor_account_id');
        $conditions1[] = '{table}.admin_id in (' . implode(',', $admin_ids) . ")";
        $cols1 = array('{table}.admin_id','{prefix}order_info.create_time','{prefix}order_info.create_time3','{prefix}order_info.create_time4','{prefix}order_info.order_price','{prefix}order_info.order_commission');
        $order_data1 = Data_Mysql_Table_Contact_Relation::page(0, 100, $cols1, $conditions1,"",
            '{table} LEFT JOIN {prefix}contact_library ON {table}.contact_id = {prefix}contact_library.id LEFT JOIN {prefix}order_info ON {prefix}contact_library.account_id = {prefix}order_info.vendor_account_id');
        $result = array();
        foreach($order_data['rows'] as $k=>$v){
            $result[$k]['username'] = $admin[$v['admin_id']];
            $result[$k]['new_order'] = $v['total_num'];//交易签约数量
            $result[$k]['price'] = 0;//交易签约金额
            $result[$k]['commission'] = 0;//交易利润金额
            $result[$k]['num'] = 0;//新增订单数量
            foreach($order_data1['rows'] as $kk =>$vv){
                if($vv['admin_id']==$v['admin_id']){
                    if(!empty($vv['create_time3'])){
                        $result[$k]['price'] += $vv['order_price'];
                        $result[$k]['commission'] += $vv['order_commission'];
                    }
                    if(!empty($vv['create_time3'])){
                        $result[$k]['num'] ++;
                    }
                }
            }
        }
        Tpl_Smarty::assign('order_data',$result);

        //图标显示
        $userlist = array();
        $usercountlist = array();
        $userpricelist =array();
        $usercomlist = array();
        $usernewlist = array();
        if(!empty($order_data['rows'])){
            foreach($result as $kk=>$vv){
                $userlist[] =$result[$kk]['username'];
                $usercountlist[]=$result[$kk]['num'];
                $userpricelist[]=$result[$kk]['price'];
                $usercomlist[]=$result[$kk]['commission'];
                $usernewlist[]=$result[$kk]['new_order'];
            }
        }
        Tpl_Smarty::assign('userlist',json_encode($userlist));
        Tpl_Smarty::assign('usercountlist',json_encode($usercountlist));
        Tpl_Smarty::assign('userpricelist',json_encode($userpricelist));
        Tpl_Smarty::assign('usercomlist',json_encode($usercomlist));
        Tpl_Smarty::assign('usernewlist',json_encode($usernewlist));

        if(!empty($_REQUEST['action3']) && $_REQUEST['action3']=="export"){
            $cols = array("排名","员工","交易签约数量","新增订单数量","交易签约金额",'交易利润金额');
            $list = array();
            foreach($result as $k=>$v){
                $list[$k][] = $k+1;
                $list[$k][] = $v['username'];
                $list[$k][] = $v['num'];
                $list[$k][] = $v['new_order'];
                $list[$k][] = $v['price'];
                $list[$k][] =$v['commission'];
            }
            //q($cols,$list);
            Func_Csv::writeRow($cols,$list,"市场部成交数据");
            return ;
        }

    }
}