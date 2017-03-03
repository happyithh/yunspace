<?php
/**
 * Created by PhpStorm.
 * User: adu
 * Date: 2016/12/5
 * Time: 17:37
 */

class Api_Demand_Create_New  extends Api{
        static function handle(){
            return self::create();
        }
        static function create(){
            if(empty($_REQUEST['q'])){
                return Api::request('-1','','缺少参数');
            }
            $q=json_decode($_REQUEST['q'],1);
            $request = Func_Input::filter(array(
                'contact' => 'string',//联系人
                'order_city' => 'string',  //订单城市
                'phone' => 'phone', //手机
                'user_id' => 'int', //用户id
                's_time' => 'string', //活动开始时间
                'e_time' => 'string', //活动结束时间
                'number_of_activities' => 'string',     //活动人数
                'activity_type' => 'string', //活动类型
                'activities_required' => 'string',       //活动要求
                'budget_amount' => 'string', //预算
                'source' => 'string', //来源   ‘办活动’ or  '一键租场'
                'verify' => 'string', //token
                'space'=>'string',  //空间
                'company'=>'string',  //公司
                'change_time'=>'string', //是否可改期
            ), $q);
            //verify 是md5（'yunspace'） 后六位
            if(empty($request['verify'])||$request['verify']!='7dd57a'){
                return self::request('-1','','非法请求');
            }
            if(empty($request['phone'])){
                return Api::request('-1', '', '手机号不能为空');
            }
            if(empty($request['contact'])){
                return Api::request('-1', '', '称呼不能为空');
            }
            $request['price_up']=0;
            $request['price_down']=0;
            if(!empty($request['budget_amount'])){
                $budget = explode('-',$request['budget_amount']);
                $request['price_up'] = $budget[0];
                $request['price_down'] = $budget[1];
            }
            $request['demand'] =array(
                '联系电话' => $request['phone'],
                '活动人数' => $request['number_of_activities'],
                '联系人' => $request['contact'],
                '具体要求' => $request['activities_required'],
                '活动城市' => $request['order_city'],
                '活动类型' => $request['activity_type'],
                '需求类型' => $request['source'],
                '开始时间' => $request['s_time'],
                '结束时间' => $request['e_time'],
            );
            if(isset($request['space'])){
                $request['demand']['空间场地'] =$request['space'];
            }
            if(isset($request['company'])){
                $request['demand']['公司名称'] =$request['company'];
            }
            if(isset($request['change_time'])&& $request['change_time']==1 ){
                $request['demand']['是否可改期'] ='是';
            }
            if(isset($request['user_id'])){
                $request['demand']['新网站用户ID']=$request['user_id'];
            }
            $request['demand_name']='新网站-'.$request['source'];
            $demand = array(
                'phone' => $request['phone'],
                'demand' => $request['demand'],
                'demand_type' => $request['source'],
                'city' => $request['order_city'],
                'demand_name' => $request['demand_name'],
//                'notice_city' => $request['notice_city'],
                'create_time' => time(),
//                'demand_status' => empty($request['demand_status']) ? 0 : $request['demand_status'],
//                'ip' => Func_Input::ip(),
//                'session_id' => session_id(),
//                'account_id' => $request['user_id'],
//                'admin_id' => $request['admin_id'],
//                'demand_name' => $request['demand_name'],
//                'resolve_time' => $request['resolve_time'],
//                'response_account_id' => $request['response_account_id'],
//                'submit_person_account_id' => $request['submit_person_account_id'],
//                'submit_person' => $request['submit_person'],
                'price_up' => $request['price_up'],          //价格上限
                'price_down' => $request['price_down'],
//                'win_id' => $request['win_id'],
                'referer' => 'http://new.yunspace.com.cn',
//                'enter_url' => @$_SESSION['enter'],
//                'is_phone' => $request['is_phone'],
            );

            $status = Data_Mysql_Table_Demand::insert($demand);
            if (!empty($status[0])) {
//                if (empty($request['admin_id'])) {
////                Api_Demand_Notice::noticeCustomerService(array('demand_id' => $status[0]));
//                    Api_Demand_Notice_V2::servicesNotice_new_v1(array(
//                        'demand_id' => $status[0],
//                    ));
//                }

                if(Api_Holiday::isWorkTime()){
                    $new_msg = '您的需求已成功提交，稍候将有云·Space专业人员为您提供后续服务！';
                }else{
                    $new_msg = '您的需求已成功提交，待工作时间将有云·Space专业人员为您提供后续服务！请保持通讯正常  我们工作时间是周一至周五 9：00-18：00';
                }
                return Api::request('success', $status[0], $new_msg);
            }else{
                return Api::request('-1', '', '需求创建失败');
            }
        }
} 