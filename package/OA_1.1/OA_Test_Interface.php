<?php
/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2015/7/22
 * Time: 10:56
 */

class OA_Test_Interface {
    static function handle(){
        $tab = empty($_REQUEST['action']) ? 'list' : $_REQUEST['action'];
        switch($tab){
            case 'list':
                self::handleInterfaceList();
                break;
            case 'add':
                self::handleAddInterface();
                break;
            case 'test':
                self::handleTestInterface();
                break;
        }
    }
    // 测试接口列表(后台)
    static function handleInterfaceList(){
        $res = Api_Test_Interface::testInterfaceList('');
        Tpl_Smarty::assign('_data',$res['data']);
        Tpl_Smarty::display('OA_Static::test_interface/interface_list.tpl');
        die();
    }
    // 添加测试接口及修改页面呈现（后台）
    static function handleAddInterface(){

            $request = Func_Input::filter(array(
                'id'=>'int',
            ));
        $category = Data_Mysql_Table_Test_Interface::$category;
        Tpl_Smarty::assign('category',$category);
        if(!empty($request['id'])){
            $res = Api_Test_Interface::testInterfaceEdit($request);
            if($res['status']==1){
                Tpl_Smarty::assign('info',$res['data'][0]);
            } else{
                Func_Header::back($res['msg']);
            }
        }
        Tpl_Smarty::display('OA_Static::test_interface/interface_add.tpl');
        die();
    }

    // 测试接口的显示
    static function handleTestInterface()
    {
        $data = Api_Test_Interface::InterfaceCategory('');
        Tpl_Smarty::assign('category', $data);
        Tpl_Smarty::display('Web_Static::test/test_interface.tpl');
        die();
    }

}