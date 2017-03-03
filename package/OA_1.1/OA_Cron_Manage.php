<?php
/**
 * Created by PhpStorm.
 * User: adu
 * Date: 2015/9/15
 * Time: 16:49
 */
class OA_Cron_Manage {
    static function handle()
    {
        $_REQUEST['action']=empty($_REQUEST['action'])?'cron_list':$_REQUEST['action'];
        switch ($_REQUEST['action']) {
            case 'cron_list':
                self::getCronDataList();
                break;
            default:
                self::getCronDataList();
                break;
        }
    }

    static function getCronDataList(){
        $request = Func_Input::filter(array(
                    'month'=>'string',
                    'class_type'=>'string',
                    'func_type'=>'string',
                    'search'=>'array'
                ),$_REQUEST);
        if(!empty($request['month'])){
            $this_month  = "_".substr(md5(Core::$urls['host']),0,4).'_'.$request['month'];
        }else{
            $this_month  = "_".substr(md5(Core::$urls['host']),0,4).date("_Ym");
        }
        $condition = array();
        if(!empty($request['class_type'])){
            $condition['class'] = $request['class_type'];
        }
        if(!empty($request['func_type'])){
            $condition['func'] = $request['func_type'];
        }
        if(!empty($request['search'])){
                $search = Func_Input::filter(array(
                    'string'=>'string'
                ),$request['search']);
            if($search['string']){
                $condition[] = " args like '%".$search['string']."%'";
            }
        }
        Func_Cron::test('1');

//        Data_Mysql_Table_Cron::debug(1);
       $rs = Data_Mysql_Table_Cron::subTable($this_month)->page(0, 0, "*", $condition, 'order by task_time desc');
        foreach($rs['rows'] as $k=>$v){
            $operation ='';
            $v['args'] = json_decode($v['args'],1);
            if(isset($v['args']['session']['administrator'])){
                $v['args']['session']['administrator']['username'] = isset($v['args']['session']['administrator']['username'])?$v['args']['session']['administrator']['username']:'';
                $operation = $operation."管理员：".$v['args']['session']['administrator']['id']."-".$v['args']['session']['administrator']['username'];
            }
            if(isset($v['args']['session']['user'])){
                $v['args']['session']['user']['username'] =  isset($v['args']['session']['user']['username']) ? $v['args']['session']['user']['username']:'';
                $operation = $operation.";用户：".$v['args']['session']['user']['id']."-". $v['args']['session']['user']['username'];
            }
            if(isset($v['args']['args'])&& !empty($v['args']['args'])){
                $operation = $operation.";参数：".self::ArrayTOString($v['args']['args']);
            }
            $rs['rows'][$k]['args'] = $operation;
//            var_dump($k."----------",$v['args']['args'],$k."------",$rs['rows'][$k]['args']);
        }
        Tpl_Smarty::assign('_data',$rs);
        Tpl_Smarty::display('OA_Static','cron/list.tpl');
        die();
    }

    static function ArrayTOString($arr){
        $str ='';
        if(is_array($arr)){
            foreach($arr as $k=>$v){
                if(is_array($v)){
                    $str = $str.self::ArrayTOString($v);
                }else{
                    $str = $str."--".$k.":".$v;
                }
            }
        }else{
            $str = $arr;
        }
        return $str;
    }
}