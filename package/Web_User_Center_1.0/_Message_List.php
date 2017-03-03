<?php

/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2015/3/9
 * Time: 15:55
 */
class Web_User_Center_Message_List extends Base
{
    static function handle()
    {

        if (empty($_SESSION['user']['id'])) {
            return false;
        }
        $request = Func_Input::filter(array(
            'from_id' => 'int',
        ));
		Tpl_Smarty::assign('from_id', $request['from_id']);
        if (!$request['from_id']) {
            die('参数错误!');
        }
        $conditions1 = array(
            'from_account_id=?'=> $request['from_id'],
            'to_account_id=?'=>$_SESSION['user']['id']
        );
        $conditions2 = array(
            'to_account_id=?' => $request['from_id'],
            'from_account_id=?'=> $_SESSION['user']['id'],
        );
        $conditions = array(
            'from_account_id' => $request['from_id']
        );
        $read_time = Data_Mysql_Table_Message::select('read_time', $conditions, '', 99999);
        $conditions = array(
            'to_account_id=? and read_time=? and from_account_id=?' => array($_SESSION['user']['id'], 0, $request['from_id']),
        );
        $data = array(
            'read_time' => time(),
        );
        Data_Mysql_Table_Message::update($conditions, $data);
        //接收数据
        $data1 = Data_Mysql_Table_Message::select('m.from_account_id,a.username,m.message,m.send_time', $conditions1, 'ORDER BY m.send_time DESC', 999, '{table} AS m
LEFT JOIN {prefix}account AS a ON m.from_account_id = a.id');
        //发送数据
        $data2 = Data_Mysql_Table_Message::select('m.from_account_id,a.username,m.message,m.send_time', $conditions2, 'ORDER BY m.send_time DESC', 999, '{table} AS m
LEFT JOIN {prefix}account AS a ON m.to_account_id = a.id ');
        $data = array();
        static $i = 0;
        foreach ($data1 as $v) {
            $data[$i] = $v;
            $i++;
        }
        foreach ($data2 as $v) {
            $data[$i] = $v;
            $i++;
        }
        $row = array();
        for ($i = 1; $i < count($data); $i++) {
            for ($j = count($data) - 1; $j >= $i; $j--) {
                if ($data[$j]['send_time'] > $data[$j - 1]['send_time']) {
                    $row = $data[$j];
                    $data[$j] = $data[$j - 1];
                    $data[$j - 1] = $row;
                }
            }
        }
        foreach ($data as &$v) {
            $v['send_time'] = date('Y-m-d H:i:s', $v['send_time']);
        }
        Tpl_Smarty::assign('data', $data);
        Tpl_Smarty::assign('session', $_SESSION['user']);
        Tpl_Smarty::display('Web_User_Center', 'message_list.tpl');
    }

	static function sendMessage(){
		$request = Func_Input::filter(array(
			'to_id' => 'int',
			'message'=>'string'
		));
		$conditions1=array(
			'id'=>$_SESSION['user']['id']
		);
		$conditions2=array(
			'id'=>$request['to_id']
		);
		$from_name=Data_Mysql_Table_Account::select('username',$conditions1);
		$to_name=Data_Mysql_Table_Account::select('username',$conditions2);
		$request['send_time']=time();
		$request['to_account_id']=$request['to_id'];
		$request['from_account_id']=$_SESSION['user']['id'];
		$request['from_username']=$from_name[0]['username'];
		$request['to_username']=$to_name[0]['username'];
	    $insert=Data_Mysql_Table_Message::insert($request);
		$json=array();
		if($insert){
			$json['code']= 'success';
			$json['content']='<li class="in">
                     <img class="avatar img-responsive" alt=""  src='.Core::$urls["root"].'user_center/avatar/'.$_SESSION['user']['id'].'.jpg>
                       <div class="message">
                       <span class="arrow">
                        </span>
                        <a href="index.html#" class="name">'.$_SESSION['user']['username'].'</a>
                         <span class="body " style=" word-break: break-all;font-family: \'微软雅黑\', \'microsoft yahei\', Arial, sans-serif;font-weight:bold;font-size: 20px;">
                         '.$request['message'].'</span>
                          <span class="datetime">
                         '.date('Y-m-d H:i:s',$request['send_time']).'</span>
                          </div>
           				 </li>
            <div class="clearfix"></div>';
		}
		echo json_encode($json);
		die();
	}
}
