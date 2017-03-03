<?php
/**
 * Created by PhpStorm.
 * User: adu
 * Date: 2016/5/12
 * Time: 14:54
 */

class OA_Winchance_Order_Statistical {

    static function handle(){
        self::statisticalOrder();
    }

    static function statisticalOrder(){
        $request = Func_Input::filter(array(
            'admin_id'=>'string', // 管理员id
            'type'=>'100', //搜索
            'city'=>'string', //搜索
            'start_time'=>'string', //搜索
            'end_time'=>'string', //搜索
        ),$_REQUEST);
        $condition = array();
        if(!empty($request['admin_id'])){
            $condition['tb2.admin_id=?']=$request['admin_id'];
        }
        if(!empty($request['city'])&&$request['city']!='all'){
            $condition['tb2.city=?']=$request['city'];
        }
        if(empty($request['start_time'])&&empty($request['end_time'])){
            $request['start_time'] = date("Y-m-d",strtotime("-1 month"));
            $request['end_time']=date("Y-m-d",time());
        }
        if(empty($request['start_time'])&&!empty($request['end_time'])){
            $request['start_time'] =date("Y-m-d",strtotime("-1 month",strtotime($request['end_time'])));
        }
        if(!empty($request['start_time'])&&empty($request['end_time'])){
            $request['end_time']=date("Y-m-d",strtotime("+1 months",strtotime($request['start_time'])));
        }
        if(!empty($request['start_time'])&&!empty($request['end_time'])&&$request['start_time']>$request['end_time']){
            Func_Header::back('日期开始时间必须小于结束时间');
        }
        if(!empty($request['start_time'])){
            $request['start_time'] = strtotime($request['start_time']);
            $condition['tb1.confirm_time>?']=$request['start_time'];
        }
        if(!empty($request['end_time'])){
            $request['end_time'] = strtotime($request['end_time']."23:59:59");
            $condition['tb1.confirm_time<?']=$request['end_time'];
        }
        switch($request['type']){
            case 'weeks':
                $type = "FROM_UNIXTIME(tb1.confirm_time,'%Y年第%u周') as weeks";
                $order_type = 'weeks';
                break;
            case 'days':
                $type = "FROM_UNIXTIME(tb1.confirm_time,'%Y年%m月%d日') as days";
                $order_type = 'days';
                break;
            case 'months':
                $type = "FROM_UNIXTIME(tb1.confirm_time,'%Y年%m月') as months";
                $order_type = 'months';
                break;
            default:
                $type = "FROM_UNIXTIME(tb1.confirm_time,'%Y年第%u周') as weeks";
                $order_type = 'weeks';
                break;
        }
        $cols ='count(*) as total,tb1.step,'.$type;
        $table = "{table} as tb1 LEFT JOIN {prefix}winchance_order as tb2 ON tb1.order_id=tb2.id";
        $order = "GROUP BY ".$order_type.",step";
        $result = Data_Mysql_Table_Winchance_Order_Status::select($cols,$condition,$order,99999,$table);
        $time_interval = self::timeInterval($request['start_time'],$request['end_time'],$order_type);
        $new_result = array();
        if($result){
            foreach($time_interval as $k=>$v){
                $new_result[$v][0]='';
                $new_result[$v][1]='';
                $new_result[$v][2]='';
                $new_result[$v][3]='';
                $new_result[$v][4]='';
                $new_result[$v][-1]='';
            }

            foreach($time_interval as $k=>$v){
                foreach($result as $kk=>$vv){
                    if($v==$vv[$order_type]){
                        $new_result[$v][$vv['step']]=$vv['total'];
                    }
                }
            }
        }
        Tpl_Smarty::assign('result',$new_result);
        Tpl_Smarty::assign('is_manager',OA_Winchance_Order::is_manager());
        Tpl_Smarty::assign('yun_principal',Data_Mysql_Table_Winchance_Order::getTeamUserList());
        Tpl_Smarty::assign('city_array',Data_Mysql_Table_Winchance_Order::$city_name);
        Tpl_Smarty::display("OA_Static::winchance_order/winchance_order_statistical.tpl");
    }

    static function timeInterval($start_time='',$end_time='',$type){
        if(empty($start_time)&&empty($end_time)){
            $start_time=strtotime("-1 month");
            $end_time=time();
        }
        $time_arr=array();
        switch($type){
            case 'weeks':
                $time_arr = self::getWeek($start_time,$end_time);
                break;
            case 'days':
                $time_arr = self::getDay($start_time,$end_time);
                break;
            case 'months':
                $time_arr = self::getMonth($start_time,$end_time);
                break;
            default:
                break;
        }
        return $time_arr;
    }
    //获取一段时间内的天
    static function getDay($start_date, $end_date){
        $arr = array();
        //参数不能为空
        if(!empty($start_date) && !empty($end_date))
        {
            //开始日期不能大于结束日期
            if($start_date <= $end_date)
            {
                for($i=$start_date;$i<=$end_date;$i+=(24*3600)){
                        $arr[] =date('Y年m月d日',$i);
                }
//                $end_date_new = strtotime("next day", $end_date);
//                if(date("w", $start_date)==1)
//                {
//                    $start_date_new = $start_date;
//                }
//                else
//                {
//                    $start_date_new = strtotime("last monday",$start_date);
//                }
//                //计算时间差多少周
//                $count_day = ($end_date_new - $start_date_new)/(24*3600);
//                for($i=0;$i<$count_day;$i++)
//                {
//                    $arr[] = date('YW',$ed);
//                    $sd = date("Y-m-d", $start_date_new);
//                    $ed = strtotime("+ 6 days", $start_date_new);
//                    $eed = date("Y-m-d", $ed);
////                    $arr[] = array('start_date' => $sd, 'end_date' => $eed);
//
//                    $start_date_new = strtotime("+ 1 day", $ed);
//                }
            }
        }
        return $arr;
    }
    //获得一段时间内的月
    static function getMonth($start_date, $end_date)
    {

        $arr = array();
        //参数不能为空
        if(!empty($start_date) && !empty($end_date))
        {
            //先把两个日期转为时间戳
//            $start_date = strtotime($start_date);
//            $end_date = strtotime($end_date);
            //开始日期不能大于结束日期
            if($start_date <= $end_date)
            {
                //结束时间的年份、月份
                $end_year = date('Y', $end_date);
                $end_month = date('m', $end_date);
                //开始时间的年份、月份
                $start_year = date('Y', $start_date);
                $start_month = date('m', $start_date);
                //相隔月数
                $month = abs($end_year - $start_year)*12 + $end_month - $start_month;
                for($i=0;$i<=$month;$i++)
                {
                    $start_time_last = date('Y-m-01', strtotime("+".$i." month", $start_date));
//                    $end_time_last = date('Y-m-t', strtotime($start_time_last));
//                    $arr[] = array('start_date' => $start_time_last, 'end_date' => $end_time_last);
                    $arr[] = date('Y年m月', strtotime($start_time_last));;
                }
            }
        }
        return $arr;
    }

//获得一段时间内的周
   static  function getWeek($start_date, $end_date)
    {
        $arr = array();
        //参数不能为空
        if(!empty($start_date) && !empty($end_date))
        {
            //先把两个日期转为时间戳
//            $start_date = strtotime($start_date);
//            $end_date = strtotime($end_date);
            //开始日期不能大于结束日期
            if($start_date <= $end_date)
            {
                $end_date_new = strtotime("next monday", $end_date);
                if(date("w", $start_date)==1)
                {
                    $start_date_new = $start_date;
                }
                else
                {
                    $start_date_new = strtotime("last monday",$start_date);
                }
                //计算时间差多少周
                $count_week = ($end_date_new - $start_date_new)/(7*24*3600);
                for($i=0;$i<$count_week;$i++)
                {
                    $sd = date("Y-m-d", $start_date_new);
                    $ed = strtotime("+ 6 days", $start_date_new);
                    $eed = date("Y-m-d", $ed);
//                    $arr[] = array('start_date' => $sd, 'end_date' => $eed);
                    $arr[] = date('Y年第W周',$ed);
                    $start_date_new = strtotime("+ 1 day", $ed);
                }
            }
        }
        return $arr;
    }
} 