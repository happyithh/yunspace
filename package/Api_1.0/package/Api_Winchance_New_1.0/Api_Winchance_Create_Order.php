<?php
/**
 * Created by PhpStorm.
 * User: adu
 * Date: 2016/8/17
 * Time: 18:29
 */

class Api_Winchance_Create_Order  extends Api{

        static function handle(){
            return self::createOrder($_REQUEST);
        }

        static function createOrder($args){
            $request = Func_Input::filter(array(
                'username'=>'100', // 联系人姓名
                'active_name'=>'string', // 联系人姓名
                'ip_id'=>'int', // 联系人姓名
                'phone'=>'15',    // 联系人手机号
                'demand_date'=>'string', // 活动日期
                'demand_style'=>'string', // 场地类型
                'demand_city'=>'string',  // 活动城市
                'other_demand'=>'string',  // 活动预算
                'action'=>'string',  // 活动预算
            ),$_REQUEST);
            if(empty($request['username'])){
                return self::request('error','','称呼不能为空');
            }
            if(empty($request['phone'])){
                return self::request('error','','联系方式不能为空');
            }
            if(empty($request['action'])){
                if(empty($request['demand_city'])){
                    return self::request('error','','活动城市不能为空');
                }
                if(empty($request['demand_style'])){
                    return self::request('error','','场地类型不能为空');
                }
                if(empty($request['demand_date'])){
                    return self::request('error','','活动日期不能为空');
                }
            }
            $demand_date = explode('-',$request['demand_date']);
            $data = array(
                'city'=>$request['demand_city'],
                'contact_name'=>$request['username'],
                'contact_phone'=>$request['phone'],
                'active_start_time'=>str_replace('/','-',$demand_date[0]),
                'active_end_time'=>str_replace('/','-',$demand_date[1]),
                'remarks'=>"场地类型：".$request['demand_style'].',--其他需求'.$request['other_demand'],
                'source'=>1,
            );
            if(!empty($request['active_name'])){
                $data['active_name']=$request['active_name'];
            }
            if(!empty($request['ip_id'])){
                $data['remarks']=$data['remarks'].",感兴趣的ip的ID是:".$request['ip_id'];
            }
            if(!empty($request['action'])&&$request['action']=='join'){
                $data['source']=2;
            }
            $rs = Data_Mysql_Table_Winchance_Order::insert($data);
            if($data['source']==1){
                $subject="有新的文创订单进来！！！请到后台->IP订单管理->IP订单列表查看";
            }else{
                $subject="有新的文创项目加盟！！！请到后台->IP订单管理->IP订单列表查看";
            }
            if($rs){
                $content = "有新的文创订单进来！！！请到后台->IP订单管理->IP订单列表查看,订单id是：".$rs[0];
                Func_Mail::send("apple.cheng@yunspace.com.cn",$subject,$content);
                return self::request('success','','您的需求已成功提交，稍候将有云·Space专业人员为您提供后续服务！');
            }else{
                return self::request('error','','抱歉，发生错误了，如有问题请致电400-056-0599');
            }
        }
} 