<?php
/*
 * Created by PhpStorm
 * User: Yangchenglin
 * Date: 2016/5/10
 * Time: 14:51
 */
@session_start();
class OA_Winchance_Order {

    static function handle()
    {
        $action = empty($_REQUEST['action'])?'list':$_REQUEST['action'];
        switch($action)
        {
            case 'list':
                self::orderList();
                break;
            case 'add':
                self::add();
                break;
            case 'add_submit':
                self::addSubmit();
                break;
            case 'edit':
                self::orderEdit();
                break;
            case 'edit_submit':
                self::editSubmit();
                break;
            case 'show_edit':
                self::orderShowEdit();
                break;
            case 'cancel':
                self::orderCancel();
                break;
            case 'log':
                self::orderLog();
                break;
        }
    }
    static function orderCancel(){
        $request = Func_Input::filter(array(
            'order_id'=>'int',  // 订单id
        ),$_REQUEST);
        if(empty($request['order_id'])){
            Func_Header::to('参数错误','?action=list');
        }
        $rs = Data_Mysql_Table_Winchance_Order::select('*',array('id=?'=>$request['order_id']),'',1);
        if(empty($rs)){
            Func_Header::to('订单不存在','?action=list');
        }
        $data=array(
            'status=?'=>-1
        );
        $data['step_time'] = json_decode($rs[0]['step_time'],1);
        $data['step_time']['取消订单']=time();
        $result = Data_Mysql_Table_Winchance_Order::update(array('id=?'=>$rs[0]['id']),$data);
        if($result){
            self::addStatus($rs[0]['id'],-1);
            Func_Header::to(' 取消订单成功 ','?action=list');
        }else{
            Func_Header::back('取消订单失败');
        }
    }
    static function orderList(){
        $request = Func_Input::filter(array(
            'status'=>'string',  // 状态
            'step'=>'string',  // 阶段
            'admin_id'=>'string', // 管理员id
            'city'=>'50',    // 城市
            'keyword'=>'100', //搜索
        ),$_REQUEST);
        $condition =array();
        if(isset($request['status'])&&$request['status']!='all'){
            $condition['status=?']=$request['status'];
        }
        if(isset($request['status'])&&$request['step']!='all'){
            $condition['step=?']=$request['step'];
        }
        if(!empty($request['city'])&&$request['city']!='all'){
            $condition['city=?']=$request['city'];
        }
        $yun_principal = Data_Mysql_Table_Winchance_Order::getTeamUserList();
        $isManager = self::is_manager();
        Tpl_Smarty::assign('is_manager',$isManager);
        Tpl_Smarty::assign('user_id',$_SESSION['administrator']['id']);
        if(!empty($request['admin_id'])&&$isManager){
            $condition['admin_id=?']=$request['admin_id'];
        }else{
            if(!$isManager){
                $condition['admin_id=?']=$_SESSION['administrator']['id'];
            }
        }
        $request['keyword'] = trim($request['keyword']);
        if(!empty($request['keyword'])){
            if(is_numeric($request['keyword'])){
                $condition['id=?']=$request['keyword'];
            }else{
//                $condition["(space_name like '%?%' or active_name=? or final_ip=? )"]=array($request['keyword'],$request['keyword'],$request['keyword']);
                $condition[]="(space_name like '%".$request['keyword']."%' or active_name like '%".$request['keyword']."%' or final_ip like '%".$request['keyword']."%' )";
            }
        }
        $result = Data_Mysql_Table_Winchance_Order::page('','','*',$condition,'order by id desc');
        if(!empty($result['rows'])){
            foreach($result['rows'] as $k=>$v){
                  $result['rows'][$k]['trace_time'] =self::getTraceTime($v['create_time']);
            }
        }
//        Tpl_Smarty::assign('request',$request);
        Tpl_Smarty::assign('data',$result);
        Tpl_Smarty::assign('city_array',Data_Mysql_Table_Winchance_Order::$city_name);
        Tpl_Smarty::assign('yun_principal',$yun_principal);
        Tpl_Smarty::assign('step',Data_Mysql_Table_Winchance_Order::$step);
        Tpl_Smarty::assign('status',Data_Mysql_Table_Winchance_Order::$status);
        Tpl_Smarty::display("OA_Static::winchance_order/winchance_order_list.tpl");
    }
    static function getTraceTime($start_time){
        $cle =time()- $start_time; //得出时间戳差值
        $d = round($cle/3600/24);
        return $d;
    }
    static function is_manager(){
        $yun_principal = Data_Mysql_Table_Winchance_Order::getTeamUserList();
        if(in_array($_SESSION['administrator']['id'],array_keys($yun_principal))){
            $admin_auth_info = $yun_principal[$_SESSION['administrator']['id']];
            if($admin_auth_info['auth']==0){
                return false;
            }else{
                return true;
            }
        }else{
            return false;
        }
    }
    static function add(){
        Tpl_Smarty::assign('weeks', self::weeks());
        Tpl_Smarty::display("OA_Static::winchance_order/winchance_order_add.tpl");
    }

    static function addSubmit(){
        $request = Func_Input::filter(array(
            'space_name'=>'300',  // 场地
            'city'=>'20',  // 场地
            'contact_name'=>'100', // 联系人姓名
            'contact_phone'=>'15',    // 联系人手机号
            'regions'=>'100', //所在区域
            'need_point'=>'300',  // 所需点位
            'need_area'=>'100', // 所需面积
            'active_start_time'=>'string', // 活动开始时间
            'active_end_time'=>'string', // 活动结束时间
            'active_name'=>'50',  // 活动主题名称
            'budget'=>'string',  // 活动预算
            'step'=>'int',  // 活动预算
            'confirm_step'=>'int',//确认第一阶段
            'remarks'=>'string',//确认第一阶段
            'log_data'=>'array'
        ),$_REQUEST);

        if(empty($request['space_name'])){
            Func_Header::back('场地名不能为空');
        }
        if(!empty($request['confirm_step'])) {
            if (empty($request['city'])) {
                Func_Header::back('城市不能为空');
            }
            if (empty($request['contact_name'])) {
                Func_Header::back('联系人姓名不能为空');
            }
            if (empty($request['contact_phone'])) {
                Func_Header::back('联系人手机号不能为空');
            }
            if (empty($request['regions'])) {
                Func_Header::back('所在区域不能为空');
            }
            if (empty($request['need_point'])) {
                Func_Header::back('所需点位不能为空');
            }
            if (empty($request['need_area']) || !is_numeric($request['need_area'])) {
                Func_Header::back('所需面积不能为空并且必须是数字');
            }
            if (empty($request['active_start_time'])) {
                Func_Header::back('活动开始时间不能为空');
            }
            if (empty($request['active_end_time'])) {
                Func_Header::back('活动结束时间不能为空');
            }
            if (empty($request['active_name'])) {
                Func_Header::back('活动主题名称不能为空');
            }
            if (empty($request['budget']) || !is_numeric($request['need_area'])) {
                Func_Header::back('活动预算不能为空并且必须是数字');
            }
        }
        if($request['active_start_time']>$request['active_end_time']){
            Func_Header::back('活动开始时间必须小于结束时间');
        }
        $data =array(
            'space_name'=>$request['space_name'],
            'city'=>$request['city'],
            'contact_name'=>$request['contact_name'],
            'contact_phone'=>$request['contact_phone'],
            'regions'=>$request['regions'],
            'need_point'=>$request['need_point'],
            'need_area'=>$request['need_area'],
            'active_start_time'=>$request['active_start_time'],
            'active_end_time'=>$request['active_end_time'],
            'active_name'=>$request['active_name'],
            'budget'=>$request['budget'],
            'remarks'=>$request['remarks'],
            'admin_id'=>$_SESSION['administrator']['id'],
            'admin_name'=>$_SESSION['administrator']['username'],
        );
        if(!empty($request['confirm_step'])) {
            $data['step']=$request['step'];
            $data['step_time']['了解需求']=time();
        }else{
            $data['step_time']['创建订单']=time();
//            if($request['step']){
                $data['step']=0;
//            }
        }
        $rs = Data_Mysql_Table_Winchance_Order::insert($data);
        if(!empty($rs)){
            //添加日志
            $logdata=array(
                'order_id'=>$rs[0],
                'log_data'=>$request['log_data'],
            );
            self::addLog($logdata);
            //添加记录
            if($data['step']==0){
                self::addStatus($rs[0],0);
//                $status_data =array(
//                    'order_id'=>$rs[0],
//                    'step'=>0,
//                    'confirm_time'=>time(),
//                );
//                Data_Mysql_Table_Winchance_Order_Status::insert($status_data);
            }
            if($data['step']==1){
                self::addStatus($rs[0],0);
                self::addStatus($rs[0],1);
//                $status_data =array(
//                    'order_id'=>$rs[0],
//                    'step'=>0,
//                    'confirm_time'=>time(),
//                );
//                Data_Mysql_Table_Winchance_Order_Status::insert($status_data);
//                $status_data1 =array(
//                    'order_id'=>$rs[0],
//                    'step'=>1,
//                    'confirm_time'=>time(),
//                );
//                Data_Mysql_Table_Winchance_Order_Status::insert($status_data1);
            }
            if(!empty($request['confirm_step'])) {
                //跳转至第二步
                Func_Header::to(' 第一步确认完成 ',"?action=edit&order_id=".$rs[0]."&step=2");
            }else{
                //跳转至第二步
                Func_Header::to(' 保存成功 ',"?action=edit&order_id=".$rs[0]."&step=1");
            }

        }else{
            Func_Header::back('添加失败-_-');
        }
    }

    static function orderEdit(){
      $request = Func_Input::filter(array(
          'step'=>'int',  //步骤
          'order_id'=>'int',  // 订单id
      ),$_REQUEST);

        if(empty($request['order_id'])){
            Func_Header::to('该订单不存在','?action=list');
        }
        $rs = Data_Mysql_Table_Winchance_Order::select('*',array('id=?'=>$request['order_id']),'',1);
        if(empty($rs)){
            Func_Header::to('该订单不存在','?action=list');
        }
        if($request['step']>$rs[0]['step']+1){
            Func_Header::to('上一步还未确认完成',"?action=edit&order_id=".$rs[0]['id']."&step=".$rs[0]['step']);
        }
        $rs[0]['ip_info']=json_decode($rs[0]['ip_info'],1);
        $rs[0]['agreement_files']=json_decode($rs[0]['agreement_files'],1);
        //日志要显示
        Tpl_Smarty::assign('log_data',self::getLog($rs[0]['id']));
        Tpl_Smarty::assign('weeks', self::weeks());
        Tpl_Smarty::assign('data',  $rs[0]);
        if($rs[0]['status']==-1){
            //已取消的订单
            Tpl_Smarty::display("OA_Static::winchance_order/winchance_order_all_quit.tpl");
        }else{
            if($request['step']==4){
                Tpl_Smarty::display("OA_Static::winchance_order/winchance_order_edit_all.tpl");
            }else{
                Tpl_Smarty::display("OA_Static::winchance_order/winchance_order_edit.tpl");
            }

        }
    }

    static function editSubmit(){
        $request = Func_Input::filter(array(
            'step'=>'int',  //步骤
            'id'=>'int',  // 活动预算
        ),$_REQUEST);
        if(empty($request['step'])||empty($request['id'])){
            Func_Header::back('参数错误');
        }
        switch($request['step']){
            case 1:
                self::step1();
                break;
            case 2:
                self::step2();
                break;
            case 3:
                self::step3();
                break;
            case 4:
                self::step4();
                break;
            default:
                Func_Header::back('修改数据');
                break;
        }
    }
    static function step1(){
        $request = Func_Input::filter(array(
            'id'=>'300',  // 订单id
            'space_name'=>'300',  // 场地
            'city'=>'20',  // 场地
            'contact_name'=>'100', // 联系人姓名
            'contact_phone'=>'15',    // 联系人手机号
            'regions'=>'100', //所在区域
            'need_point'=>'300',  // 所需点位
            'need_area'=>'100', // 所需面积
            'active_start_time'=>'string', // 活动开始时间
            'active_end_time'=>'string', // 活动结束时间
            'active_name'=>'50',  // 活动主题名称
            'budget'=>'string',  // 活动预算
            'step'=>'int',  // 活动预算
            'confirm_step'=>'int',//确认第一阶段
            'remarks'=>'string',//确认第一阶段
            'log_data'=>'array'
        ),$_REQUEST);
        $rs = Data_Mysql_Table_Winchance_Order::select('*',array('id=?'=>$request['id']),'',1);
        if(empty($rs)){
            Func_Header::to('订单不存在','?action=list');
        }
        if(empty($request['space_name'])){
            Func_Header::back('场地名不能为空');
        }
        if(!empty($request['confirm_step'])) {
            if (empty($request['city'])) {
                Func_Header::back('城市不能为空');
            }
            if (empty($request['contact_name'])) {
                Func_Header::back('联系人姓名不能为空');
            }
            if (empty($request['contact_phone'])) {
                Func_Header::back('联系人手机号不能为空');
            }
            if (empty($request['regions'])) {
                Func_Header::back('所在区域不能为空');
            }
            if (empty($request['need_point'])) {
                Func_Header::back('所需点位不能为空');
            }
            if (empty($request['need_area']) || !is_numeric($request['need_area'])) {
                Func_Header::back('所需面积不能为空并且必须是数字');
            }
            if (empty($request['active_start_time'])) {
                Func_Header::back('活动开始时间不能为空');
            }
            if (empty($request['active_end_time'])) {
                Func_Header::back('活动结束时间不能为空');
            }
            if (empty($request['active_name'])) {
                Func_Header::back('活动主题名称不能为空');
            }
            if (empty($request['budget']) || !is_numeric($request['need_area'])) {
                Func_Header::back('活动预算不能为空并且必须是数字');
            }
        }
        $data =array(
            'space_name'=>$request['space_name'],
            'city'=>$request['city'],
            'contact_name'=>$request['contact_name'],
            'contact_phone'=>$request['contact_phone'],
            'regions'=>$request['regions'],
            'need_point'=>$request['need_point'],
            'need_area'=>$request['need_area'],
            'active_start_time'=>$request['active_start_time'],
            'active_end_time'=>$request['active_end_time'],
            'active_name'=>$request['active_name'],
            'budget'=>$request['budget'],
            'remarks'=>$request['remarks'],
        );
        if(!empty($request['confirm_step'])&&$rs[0]['step']==0) {
            $data['step']=1;
            $data['step_time'] = json_decode($rs[0]['step_time'],1);
            if(!isset($data['step_time']['了解需求'])){
                $data['step_time']['了解需求']=time();
            }
        }
        $result = Data_Mysql_Table_Winchance_Order::update(array('id=?'=>$rs[0]['id']),$data);
        if(!empty($result)){
            //添加日志
            $log_data=array(
                'order_id'=>$rs[0]['id'],
                'log_data'=>$request['log_data'],
            );
            self::addLog($log_data);
            //添加记录
            if(!empty($request['confirm_step'])||$rs[0]['step']==1){
                self::addStatus($rs[0]['id'],1);
//                $status_data1 =array(
//                    'order_id'=>$rs[0]['id'],
//                    'step'=>1,
//                    'confirm_time'=>time(),
//                );
//                Data_Mysql_Table_Winchance_Order_Status::insert($status_data1,1);
            }
            //跳转至第二步
            if(!empty($request['confirm_step'])||$rs[0]['step']==1){
                Func_Header::to(' 第一步确认完成 ',"?action=edit&order_id=".$rs[0]['id']."&step=2");
            }else{
                Func_Header::to(' 保存成功 ',"?action=edit&order_id=".$rs[0]['id']."&step=1");
            }

        }else{
            Func_Header::back('修改失败-_-');
        }
    }
    static function step2(){
        $request = Func_Input::filter(array(
            'id'=>'300',  // 订单id
            'ip_info'=>'array',  // 所选ip信息
            'final_ip'=>'300',  // 最终IP
            'step'=>'int',  // 活动预算
            'confirm_step'=>'int',//确认第一阶段
            'remarks'=>'string',//备注
            'log_data'=>'array'
        ),$_REQUEST);
        $rs = Data_Mysql_Table_Winchance_Order::select('*',array('id=?'=>$request['id']),'',1);
        if(empty($rs)){
            Func_Header::to('订单不存在','?action=list');
        }
        if($request['step']>$rs[0]['step']+1){
            Func_Header::to('上一步还未确认完成',"?action=edit&order_id=".$rs[0]['id']."&step=2");
        }
        if(!empty($request['confirm_step'])&&empty($request['final_ip'])){
            Func_Header::back('完成此阶段需要确认最终意向IP');
        }
        $data=array(
            'ip_info'=>$request['ip_info'],  // 所选ip信息
            'final_ip'=>$request['final_ip'],  // 最终IP
            'remarks'=>$request['remarks'],
        );
        if(!empty($request['confirm_step'])&&!empty($request['final_ip'])&&$rs[0]['step']==1){
            $data['step']=2;
            $data['step_time'] = json_decode($rs[0]['step_time'],1);
            if(!isset($data['step_time']['明确需求'])){
                $data['step_time']['明确需求']=time();
            }
        }
       $result =  Data_Mysql_Table_Winchance_Order::update(array('id=?'=>$rs[0]['id']),$data);
        if($result){
            //添加日志
            $log_data=array(
                'order_id'=>$rs[0]['id'],
                'log_data'=>$request['log_data'],
            );
            self::addLog($log_data);
            //添加记录
            if((!empty($request['confirm_step'])&&!empty($request['final_ip']))||$rs[0]['step']==2){
                self::addStatus($rs[0]['id'],2);
//                $status_data1 =array(
//                    'order_id'=>$rs[0]['id'],
//                    'step'=>2,
//                    'confirm_time'=>time(),
//                );
//                Data_Mysql_Table_Winchance_Order_Status::insert($status_data1,1);
            }
            //跳转至第二步
            if((!empty($request['confirm_step'])&&!empty($request['final_ip']))||$rs[0]['step']==2){
                Func_Header::to(' 第二步确认完成  ',"?action=edit&order_id=".$rs[0]['id']."&step=3");
            }else{
                Func_Header::to(' 保存成功 ',"?action=edit&order_id=".$rs[0]['id']."&step=2");
            }
        }else{
            Func_Header::back('修改失败-_-');
        }
    }
    static function step3(){
        $request = Func_Input::filter(array(
            'id'=>'300',  // 订单id
            'protocol_content'=>'int',//协议内容制定
            'authorization_qualification'=>'int',//授权资质
            'legal_audit'=>'int',//对方法务审核
            'protocol_back'=>'int',//协议发回
            'sign_completion'=>'int',//签订完成
            'agreement_files'=>'array',//协议文件
            'step'=>'int',  // 活动预算
            'confirm_step'=>'int',//确认第一阶段
            'remarks'=>'string',//备注
            'log_data'=>'array'
        ),$_REQUEST);
        $rs = Data_Mysql_Table_Winchance_Order::select('*',array('id=?'=>$request['id']),'',1);
        if(empty($rs)){
            Func_Header::to('订单不存在','?action=list');
        }
        if($request['step']>$rs[0]['step']+1){
            Func_Header::to('上一步还未确认完成',"?action=edit&order_id=".$rs[0]['id']."&step=2");
        }
        unset($request['agreement_files']['$$']);
        if(!empty($request['confirm_step'])&&(empty($request['protocol_content'])||empty($request['authorization_qualification'])||empty($request['legal_audit'])||empty($request['protocol_back'])||empty($request['sign_completion'])||empty($request['agreement_files']))){
            Func_Header::back('必须所有选项都完成，并且上传文件才能完成此阶段');
        }
        $data=array(
            'protocol_content'=>$request['protocol_content'],
            'authorization_qualification'=>$request['authorization_qualification'],
            'legal_audit'=>$request['legal_audit'],
            'protocol_back'=>$request['protocol_back'],
            'sign_completion'=>$request['sign_completion'],
            'agreement_files'=>$request['agreement_files'],
            'remarks'=>$request['remarks'],
        );
        if(!empty($request['confirm_step'])&&!empty($request['protocol_content'])&&!empty($request['authorization_qualification'])&&!empty($request['legal_audit'])&&!empty($request['protocol_back'])&&!empty($request['sign_completion'])&&!empty($request['agreement_files'])&&$rs[0]['step']==2){
            $data['step']=3;
            $data['step_time'] = json_decode($rs[0]['step_time'],1);
            if(!isset($data['step_time']['合同流程'])){
                $data['step_time']['合同流程']=time();
            }
        }
        $result =  Data_Mysql_Table_Winchance_Order::update(array('id=?'=>$rs[0]['id']),$data);
        if($result){
            //添加日志
            $log_data=array(
                'order_id'=>$rs[0]['id'],
                'log_data'=>$request['log_data'],
            );
            self::addLog($log_data);
            //添加记录
            if(!empty($request['confirm_step'])&&!empty($request['protocol_content'])&&!empty($request['authorization_qualification'])&&!empty($request['legal_audit'])&&!empty($request['protocol_back'])&&!empty($request['sign_completion'])&&!empty($request['agreement_files'])&&$rs[0]['step']==2){
                self::addStatus($rs[0]['id'],3);
//                $status_data1 =array(
//                    'order_id'=>$rs[0]['id'],
//                    'step'=>3,
//                    'confirm_time'=>time(),
//                );
//                Data_Mysql_Table_Winchance_Order_Status::insert($status_data1,1);
            }
            //跳转至第四步
            if(!empty($request['confirm_step'])||$rs[0]['step']==3){
                Func_Header::to(' 第三步确认完成 ',"?action=edit&order_id=".$rs[0]['id']."&step=4");
            }else{
                Func_Header::to(' 保存成功 ',"?action=edit&order_id=".$rs[0]['id']."&step=3");
            }
        }else{
            Func_Header::back('修改失败-_-');
        }

    }
    static function step4(){
        $request = Func_Input::filter(array(
            'id'=>'300',  // 订单id
            'step'=>'int',  // 活动预算
            'confirm_step'=>'int',//确认第一阶段
            'remarks'=>'string',//备注
            'log_data'=>'array'
        ),$_REQUEST);
        $rs = Data_Mysql_Table_Winchance_Order::select('*',array('id=?'=>$request['id']),'',1);
        if(empty($rs)){
            Func_Header::to('订单不存在','?action=list');
        }
        if($request['step']>$rs[0]['step']+1){
            Func_Header::to('上一步还未确认完成',"?action=edit&order_id=".$rs[0]['id']."&step=3");
        }
        $data=array(
            'remarks'=>$request['remarks'],
        );
        if(!empty($request['confirm_step'])&&$rs[0]['step']==3){
            $data['step']=4;
            $data['status']=1;
            $data['step_time'] = json_decode($rs[0]['step_time'],1);
            if(!isset($data['step_time']['已签约待进行'])){
                $data['step_time']['已签约待进行']=time();
            }
            if(!isset($data['step_time']['完成订单'])){
                $data['step_time']['完成订单']=time();
            }
        }
        $result =  Data_Mysql_Table_Winchance_Order::update(array('id=?'=>$rs[0]['id']),$data);
        if($result){
            //添加日志
            $log_data=array(
                'order_id'=>$rs[0]['id'],
                'log_data'=>$request['log_data'],
            );
            self::addLog($log_data);
            //添加记录
            if(!empty($request['confirm_step'])&&$rs[0]['step']==3){
                self::addStatus($rs[0]['id'],4);
//                $status_data1 =array(
//                    'order_id'=>$rs[0]['id'],
//                    'step'=>4,
//                    'confirm_time'=>time(),
//                );
//                Data_Mysql_Table_Winchance_Order_Status::insert($status_data1,1);
            }
            //跳转至第二步
            if(!empty($request['confirm_step'])||$rs[0]['step']==4){
                Func_Header::to(' 活动结束完成订单 ',"?action=edit&order_id=".$rs[0]['id']."&step=4");
            }else{
                Func_Header::to(' 保存成功 ',"?action=edit&order_id=".$rs[0]['id']."&step=4");
            }
        }else{
            Func_Header::back('修改失败-_-');
        }
    }


    static function addStatus($order_id,$step){
       $rs =  Data_Mysql_Table_Winchance_Order_Status::select('id',array('order_id=?'=>$order_id,'step=?'=>$step),'',1);
        if(empty($rs)){
            $data =array(
                'order_id'=>$order_id,
                'step'=>$step,
                'confirm_time'=>time(),
            );
            Data_Mysql_Table_Winchance_Order_Status::insert($data);
        }
    }


    static function orderShowEdit(){
        Tpl_Smarty::display("OA_Static::winchance_order/winchance_order_edit_all.tpl");
    }
    static function orderLog(){
        $request = Func_Input::filter(array(
            'order_id'=>'int',  // 订单id
        ),$_REQUEST);
        if(empty($request['order_id'])){
            Func_Header::back('参数错误');
        }
        $condition= array(
            'tb1.order_id=?'=>$request['order_id'],
        );
        $tables ="{table} as tb1 LEFT JOIN {prefix}winchance_order as tb2 ON tb1.order_id=tb2.id";
        $rs =Data_Mysql_Table_Winchance_Order_Log::select('tb1.*,tb2.step_time,tb2.status,tb2.space_name,tb2.step',$condition,'',1,$tables);
        if($rs){
            $rs[0]['log_data'] = json_decode($rs[0]['log_data'],1);
            $rs[0]['step_time'] = json_decode($rs[0]['step_time'],1);
        }
        $data = $rs[0];
        Tpl_Smarty::assign('data',$data);
        Tpl_Smarty::assign('step',Data_Mysql_Table_Winchance_Order::$step);
        Tpl_Smarty::assign('status',Data_Mysql_Table_Winchance_Order::$status);
        Tpl_Smarty::display("OA_Static::winchance_order/winchance_order_log.tpl");
    }
    static function addLog($data){
        $log_data = Func_Input::filter(array(
            'order_id'=>'int',  // 订单id
            'log_data'=>'array'
        ),$data);
        if(empty($log_data['order_id'])){
            Func_Header::back('订单id出错，计划和总结保存失败');
        }
        $rs = Data_Mysql_Table_Winchance_Order_Log::select('*',array('order_id=?'=>$log_data['order_id']),'',1);
        if(empty($rs)){
            $log_data['create_time']  =time();
            $log_data['update_time']  =time();
            Data_Mysql_Table_Winchance_Order_Log::insert($log_data);
        }else{
            $log_data_old = json_decode($rs[0]['log_data'],1);
            if(!empty($log_data['log_data'])){
                $array_ky = array_keys($log_data['log_data']);
                foreach($array_ky as $k=>$v){
                    $log_data_old[$v]=$log_data['log_data'][$v];
                }

                $data_update = array(
                    'log_data'=>$log_data_old, // 联系人姓名
                    'update_time'=>time(),//修改时间
                );
                Data_Mysql_Table_Winchance_Order_Log::update(array('order_id=?'=>$log_data['order_id']),$data_update);
            }
        }
    }
    static function getLog($order_id){
        if(empty($order_id)){
            return false;
        }
        $rs = Data_Mysql_Table_Winchance_Order_Log::select('*',array('order_id=?'=>$order_id),'',1);
        if(empty($rs)){
            return false;
        }else{
            $rs[0]['log_data'] = json_decode($rs[0]['log_data'],1);
            return $rs[0]['log_data'];
        }
    }


    static function weeks(){
        $week_data=array();
        $date = date("Y-m-d");  //当前日期
        $first=1; //$first =1 表示每周星期一为开始时间 0表示每周日为开始时间
        $w = date("w", strtotime($date));  //获取当前周的第几天 周日是 0 周一 到周六是 1 -6
        $d = $w ? $w - $first : 6;  //如果是周日 -6天
        $now_start = date("m/d", strtotime("$date -".$d." days")); //本周开始时间
        $now_end = date("m/d", strtotime("$now_start +6 days"));  //本周结束时间
        $week_data['start'] = $now_start;
        $week_data['end'] = $now_end;
        $week_data['week_num'] = date("Y").'年第'.date('W',strtotime($date))."周";
        return $week_data;
    }


}