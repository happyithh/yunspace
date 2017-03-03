<?php
/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2015/8/12
 * Time: 15:34
 */
@session_start();
class Api_Broke_ListPreview extends Api
{
    /**
     * param $args =array(
     *
     *          'search_time'=>''    // 查询的爆料时间
     * )
     *
     *
     *       'submit_person_account_id'=>''  //爆料人账户ID（爆料的唯一标识）
     * */
    static function handle($args=""){
        Api_Session::checkToken();
        return self::brokeListPreview($args);
    }
    //查询爆料数量
    static function brokeListPreview($args=""){
        if(!isset($_SESSION['user']['id'])){
            $result=self::request('error','',"请先登录！再来爆料");
            return $result;
        }
        $conditions = array();
        $request =Func_Input::filter(
            array(
                'search_time'=>'string',
            ),$args);
//        $request['account_id'] =$_SESSION['user']['id'];
//        $request['submit_person_account_id']=$request['account_id'];
        $search_time = self::getMonth($request['search_time']);
        $conditions['submit_person_account_id=?']=$_SESSION['user']['id'];;
        $conditions['create_time between ? and ? '] =array($search_time['month_start_day'],$search_time['month_end_day']);
//        Data_Mysql_Table_Demand::debug(1);
        $res = Data_Mysql_Table_Demand::select('submit_person_account_id,demand_status',$conditions,'',9999);
        //组装数据
        $doneBroke=0;       //通过审核
        $waitingBroke=0;    //正在审核
        $abandonBroke=0;    //未过审核
        if(!empty($res)){
            foreach($res as $k=>$v){
                if($v['demand_status']==0){
                    $waitingBroke =$waitingBroke+1;
                }elseif($v['demand_status']==-1){
                    $abandonBroke =$abandonBroke+1;
                }else{
                    $doneBroke =$doneBroke+1;
                }
            }
            $data = array(
                'doneBroke'=>$doneBroke,
                'waitingBroke'=>$waitingBroke,
                'abandonBroke'=>$abandonBroke,
                'sumBroke'=>count($res),    //爆料总数
            );
            $reward = self::getReward($data['doneBroke']);
            $data['reward'] = $reward;
            $result=self::request('success',$data,'');
            return $result;
        }else{
            $result=self::request('error','','您 '.$request['search_time'].' 没有爆料过哦!');
            return $result;
        }
    }

    //获取月份的起止时间
    static function getMonth($search_time){
        // 对接收的时间参数进行处理
        if(empty($search_time)){
            $search_time = date('Y-m',time());
        }
        $timestamp = strtotime($search_time);
        $mdays = date('t', $timestamp);
        $month = array(
            'month_start_day' => strtotime(date('Y-m-01', $timestamp).'00:00:00'),
            'month_end_day' => strtotime(date('Y-m-'.$mdays, $timestamp).'23:59:59')
        );
        return $month;
    }
    //  爆料规则下的数据整理
    static function getReward($data)
    {
        $reward = array(
            'reward' => 0,          //奖励金额
            'num' => 0,             //小云提醒
            'reward_price' => 0,    //小云提醒奖励额度
            'price'=>10             //实际奖励额度
        );

        if ($data >= 0 && $data<= 10) {
            $reward['reward'] = $data * 10;
            $reward['num'] = 11 - $data;
            $reward['price'] =10;
            $reward['reward_price'] = 15;
        } elseif ($data > 10 && $data <= 30) {
            $reward['reward'] = $data * 15;
            $reward['num'] = 31 - $data;
            $reward['price'] =15;
            $reward['reward_price'] = 20;
        } elseif ($data> 30 && $data <= 60) {
            $reward['reward'] = $data * 20;
            $reward['num'] = 61 - $data;
            $reward['price'] =20;
            $reward['reward_price'] = 25;
        } elseif ($data > 60 && $data <= 100) {
            $reward['reward'] = $data * 25;
            $reward['num'] = 101 - $data;
            $reward['price'] =25;
            $reward['reward_price'] = 50;
        } elseif ($data > 100) {
            $reward['reward'] = $data * 50;
            $reward['num'] = 0;
            $reward['price'] =50;
            $reward['reward_price'] = 50;
        }
        return $reward;
    }
}
