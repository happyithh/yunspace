<?php
/**
 * Created by PhpStorm.
 * User: liusc
 * Date: 16/5/19
 * Time: 下午1:43
 */

$list_category = Data_Mysql_Table_Spacepedia::getChildrenByCid(112);

$temp_data = array();
foreach(array_keys($list_category) as $k=>$v){
    $tables = '{table} as tb1 left join {prefix}spacepedia as tb2 on tb1.space_id=tb2.id';
//    Data_Mysql_Table_Space_Item::debug(1);
    $temp= Data_Mysql_Table_Space_Item::select('tb2.city,tb1.status',array('tb2.category_id=?'=>$v,'tb2.type_level in(1,2)'),'',1000,$tables);
//    $temp[$v] = Data_Mysql_Table_Space_Item::select('count(tb1.id) as total_num,tb2.city',array('tb2.category_id=?'=>$v,'tb1.status=?'=>1),'group by tb2.city',100,$tables);
//    $list_data_1 = Data_Mysql_Table_Space_Item::select('count(tb1.id) as total_num_on,tb2.city',array('tb2.category_id=?'=>$v,'tb1.status=?'=>1,'tb2.type_level in(1,2)'),'group by tb2.city',100,$tables);
//    $list_data_2 = Data_Mysql_Table_Space_Item::select('count(tb1.id) as total_num_down,tb2.city',array('tb2.category_id=?'=>$v,'tb1.status!=?'=>1,'tb2.type_level in(1,2)'),'group by tb2.city',100,$tables);
    $city_data = array();
    foreach($temp as $kk=>$vv){
        if(isset($city_data[$vv['city']])){
            if($vv['status']==1){
                $city_data[$vv['city']][1]++;
            }else{
                $city_data[$vv['city']][2]++;
            }
        }else{
            $city_data[$vv['city']]=array(
                $vv['city'],0,0
            );
            if($vv['status']==1){
                $city_data[$vv['city']][1]++;
            }else{
                $city_data[$vv['city']][2]++;
            }
        }
    }
    $temp_data[$v] =$city_data;
}
$data = array();
foreach($temp_data as $k=>$v){
    $category_name  = $list_category[$k];
   foreach($v as $kk=>$vv){
       $data[] =array(
           $vv[0],$category_name,$vv[1],$vv[2]
       );
   }
}
Func_Csv::writeRow(array(
    '城市',
    '空间类型',
    '上线数量',
    '未上线数量'
), $data);

/**
if (empty($_REQUEST['pwd']) || $_REQUEST['pwd'] != 'qwe') {
    Func_Header::notFound();
}
$rs = Data_Mysql_Table_Demand::select('*',
    array('demand_status' => 1, 'demand_type <>"供应商加盟"'),
    'ORDER BY id DESC', 10000);
$data = array();
foreach ($rs as $k => $r) {
    $r['demand'] = json_decode($r['demand'], 1);
    $data[] = @array(
        '联系人' => $r['demand']['联系人'] ? $r['demand']['联系人'] : $r['demand']['联系人姓名'],
        '联系电话' => $r['phone'],
        '活动类型' => $r['demand']['活动类型'],
        '具体要求' => $r['demand']['具体要求'],
        '活动人数' => $r['demand']['活动人数'],
        '活动城市' => $r['demand']['活动城市'],
        '公司名称' => $r['demand']['公司名称'],
    );
}
Func_Csv::writeRow(array(
    '联系人',
    '联系电话',
    '活动类型',
    '具体要求',
    '活动人数',
    '活动城市',
    '公司名称'
), $data);
 * */