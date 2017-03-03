<?php

if(isset($_REQUEST['action'])){
    switch ($_REQUEST['action']){
        case 'getMessage':
            Message_Ctl :: getMessage($orderInfo);
            break;
        default:
            Json_Product_Schedule_Ctl::getScheduleInfo();
            break;
    }
}else{
    Json_Product_Schedule_Ctl::getScheduleInfo();
}

class Json_Product_Schedule_Ctl{

    static  function getScheduleInfo(){
        $json =array();
        $request = Func_Input::filter(array(
            'product_id' => 'int',
        ), $_REQUEST);
        $conditions['product_id']=$request['product_id'];
        $conditions[]='status > 0';
        $r = Data_Mysql_Table_Product_Schedule::select('id,status,start_time,end_time',$conditions,'',100);

        foreach($r as $k=>$v){
            if($v['status']=='1'){
                //意向预定
                $json[$k]['start'] = date('Y-m-d',$v['start_time']);
                $json[$k]['end'] = date('Y-m-d',$v['end_time']+86400);
                $json[$k]['rendering'] = 'background';
                $json[$k]['color'] = '#00c3c3';
            }
            if($v['status']=='2'){
                //已预定   灰色
                $json[$k]['start'] = date('Y-m-d',$v['start_time']);
                $json[$k]['end'] = date('Y-m-d',$v['end_time']+86400);
                $json[$k]['rendering'] = 'background';
                $json[$k]['color'] = '#999';
            }
        }
        echo json_encode(array_values($json));
        die();
    }

}

//Data_Mysql_Table_Product_Info::insert();
//Data_Mysql_Table_Product_Info::subTable('_search')->insert();