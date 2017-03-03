<?php
/*
 * Created by PhpStorm
 * User: Yangchenglin
 * Date: 2015/11/27
 * Time: 13:32
 */
//场地方下属的场地
@session_start();
class Api_Demand_Product_Name extends Api
{
    static function handle($args='')
    {
//        Api_Session::checkToken(1);
        return self::handlegetName($args);
    }

    static function handlegetName($args)
    {
        $request = Func_Input::filter(array(
            'phone' => 'string',
        ), $args);
        $conditions = array();
        $conditions['{table}.phone = ?'] = $request['phone'];
        $conditions['{table}.status = ?'] = 1;
        $rs = Data_Mysql_Table_Space_Item::select('{table}.id,{table}.item_name',$conditions,'',20);

        //取得该手机号下所有子空间的id（从百科子空间授权表 -> space_assign）
        $conditions_bb['{table}.phone = ?'] = $request['phone'];
        $rs_assign = Data_Mysql_Table_Space_Assign::select('{table}.space_item_id',$conditions_bb,'',10);
//        q($rs_assign);
        foreach($rs_assign as $k=>$v) {
            $rs_assign[$k]['space_item_id'] = json_decode($v['space_item_id'],1);
        }
        $space_item_ids = $conditions_b = array();
        foreach($rs_assign as $k=>$v) {
            foreach($v as $kk=>$vv) {
                $t = count($vv);
                for($i=0;$i<$t;$i++) {
                    $space_item_ids[] = $vv[$i];
                }
            }
        }
        $space_item_ids = array_unique($space_item_ids);
        $conditions_b[] = 'id IN (' . implode(',', $space_item_ids) . ')';
        $rs_b =Data_Mysql_Table_Space_Item::select('id,item_name',$conditions_b,'',9);
        $rs_total = array_merge($rs,$rs_b);
        $rs_total = self::array_unique_fb($rs_total);

        if(!empty($rs_total)) {
            $result = self::request('success',$rs_total,'成功');
        }else{
            $result = self::request('error','','失败');
        }
        return $result;
    }


    //二维数组去掉重复值 并保留键值
    function array_unique_fb($array2D)
    {
        $temp = $temp2 = array();
        foreach ($array2D as $k=>$v)
        {
            $v = join(",",$v); //降维,也可以用implode,将一维数组转换为用逗号连接的字符串
            $temp[$k] = $v;
        }
        $temp = array_unique($temp); //去掉重复的字符串,也就是重复的一维数组
        foreach ($temp as $k => $v)
        {
            $array=explode(",",$v); //再将拆开的数组重新组装
            $temp2[$k]["id"] =$array[0];
            $temp2[$k]["item_name"] =$array[1];
        }
        return $temp2;
    }

}