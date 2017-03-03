<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 15-6-25
 * Time: 下午12:08
 */
class OA_Finance_Auto_Cash{
    static function handle(){
        $action=empty($_REQUEST['action'])?'list':$_REQUEST['action'];
        switch($action){
            case 'list':
                self::getAutoCashList();
                break;
            case "excel":
                self::getExcel();
                break;
            case "create_pup_no":
                self::getPupNo();
                break;
        }
    }
    static function getAutoCashList(){
        $conditions = array();
        $auto = array();
        //筛选条件
        if (!empty($_REQUEST['search'])) {
            $search = Func_Input::filter(array(
                'title' => 'string',
                'end_time' => 'string',
                'start_time' => 'string',
            ), $_REQUEST['search']);
            //名称筛选
            if (!empty($search['title'])) {
                if (is_numeric($_REQUEST['search']['title'])) {
                    $conditions['account_id'] = $search['title'];
                } else {
                    $conditions['account_name'] = $search['title'];
                }
            }
            //更新时间筛选
            if (!empty($search['start_time']) && !empty($search['end_time'])) {
                if (strtotime($search['start_time']) > strtotime($search['end_time'])) {
                    Func_Header::back('请正确选择时间范围！！');
                } else {
                    $conditions['update_time between ? and ?'] = array(strtotime($search['start_time']), strtotime($search['end_time']));
                }
            } elseif (!empty($search['start_time']) && empty($search['end_time'])) {
                $conditions['update_time > ?'] = strtotime($search['start_time']);
            } elseif (empty($search['start_time']) && !empty($search['end_time'])) {
                $conditions['update_time < ?'] = strtotime($search['end_time']);
            }
        }
        $handle_type = empty($_REQUEST['handle_type']) ? 'all' : $_REQUEST['handle_type'];
        switch ($handle_type) {
            case "open":
                $conditions['status'] = 1;
                break;
            case "close":
                $conditions['status'] = -1;
                break;
            case "all":
                break;
        }
        $auto = Data_Mysql_Table_Auto_Cash::page(0, 20, '*', $conditions, 'ORDER BY {table}.update_time DESC');
        Tpl_Smarty::assign('handle_type',$handle_type);
        Tpl_Smarty::assign('_data',$auto);
        Tpl_Smarty::display('OA','finance/finance_auto_cash_list.tpl');
    }

    static function getPupNo(){
        $request=Func_Input::filter(array('auto_id'=>'int'));
        if(empty($request['auto_id'])){
            Func_Header::back('参数错误！！');
        }
        $data = Data_Mysql_Table_Auto_Cash::select('*', $request['auto_id']);
        if(empty($data[0])){
            Func_Header::back('数据不存在！！');
        }
        $pup_no ="808080201309620***".$request['auto_id'];
        //更新自动提现中的信息
        $rs=Data_Mysql_Table_Auto_Cash::update($request['auto_id'],array('pup_no'=>$pup_no));
        if(empty($rs[0])){
            Func_Header::back('商户号生成失败！！');
        }else{
            //更新finance_account中的信息
            Finance_Account::update($data[0]['account_id'],$data[0]['account_name'],'',$data[0]['bank_account_no'],$pup_no[0][0]);
            Func_Header::to(' 商户号已生成！！','?');
        }
    }
    //下载表格
    static function getExcel(){
        $cols = array("商户号","分支机构名称","开户行账号","开户行名称（全称）","分支机构账户名称","账户所在城市");
        $auto=array();
        $data = Data_Mysql_Table_Auto_Cash::select('*', array('status'=>1),'',9999999);
        if(!empty($data)){
            foreach($data as $k=>$v){
                $auto[$k][0] =$v['pup_no'];
                $auto[$k][1] =$v['bank_account'];
                $auto[$k][2] =substr($v['bank_account_no'],0,4).'****'.substr($v['bank_account_no'],-4);
                $auto[$k][3] =$v['bank_name'];
                $auto[$k][4] =$v['bank_account'];
                $auto[$k][5] =$v['bank_city'];
            }
            Func_Csv::writeRow($cols,$auto,"银联在线-自动提现");
        }
        return ;
    }
}