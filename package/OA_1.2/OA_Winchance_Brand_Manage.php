<?php
/**
 * Created by PhpStorm.
 * User: adu
 * Date: 2016/5/7
 * Time: 20:34
 */

class OA_Winchance_Brand_Manage {
    static function handle()
    {
        $action = empty($_REQUEST['action'])?'list':$_REQUEST['action'];
        switch($action)
        {
            case 'list':
                self::brandList();
                break;
            case 'figureDelete':
                self::brandDelete();
                break;
            case 'companyDelete':
                self::companyDelete();
                break;
        }
    }
    static function brandList(){
        $tab = empty($_REQUEST['tab'])?'figure':$_REQUEST['tab'];
        Tpl_Smarty::assign('tab',$tab);
        if($tab=='figure'){
            $data = Api_Winchance_New_Figure::figureList();
        }else{
            $data = Api_Winchance_New_Company::companyList();
        }
        Tpl_Smarty::assign('_data',$data);
        Tpl_Smarty::display("OA_Static::winchance_new/brand_list.tpl");
    }
    static function brandDelete(){
        Core::output('');
        $request = Func_Input::filter(array(
            'id'=>'int',
        ),$_REQUEST);
        if(empty($request['id'])){
            Func_Output::json('error','','ID异常!');
        }
        $res = Data_Mysql_Table_Winchance_Figure::update(array('id'=>$request['id']),array('status'=>-1));
        if(!empty($res[0])){
            Func_Output::json('success','',' 操作成功！');
        }else{
            Func_Output::json('error','','操作失败！');
        }
    }
    static function companyDelete(){
        Core::output('');
        $request = Func_Input::filter(array(
            'id'=>'int',
            'company'=>'string'
        ),$_REQUEST);
        if(empty($request['id'])){
            Func_Output::json('error','','ID异常!');
        }
        $res = Data_Mysql_Table_Winchance_Company::update(array('id'=>$request['id']),array('status'=>-1));
        $da['company'] = '';
        $res_1 = Data_Mysql_Table_Winchance_Figure::update(array('company'=>$request['company']),$da);
        if(!empty($res[0])){
            Func_Output::json('success','',' 操作成功！');
        }else{
            Func_Output::json('error','','操作失败！');
        }
    }
} 