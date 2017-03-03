<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2015/5/22
 * Time: 15:56
 */
class App_Api_Broker_Account
{
	//用户钱包
	static  function  getUserAdminMoney(){
		if(empty($_REQUEST['user_id'])){
			App_Api_Broker_Main::jsonReturn('','缺少参数',-1001);
		}

		$account = Finance_Account::getAccountInfo($_REQUEST['user_id']);
		if(empty($account)){
			App_Api_Broker_Main::jsonReturn('','没有该用户',-2);
		}

		if(isset($_REQUEST['date'])){
			$date = strtotime($_REQUEST['date']);
			$accountDetail = Finance_Account::getDetailList($_REQUEST['user_id'],$date);
		}else{
			$accountDetail = Finance_Account::getDetailList($_REQUEST['user_id']);
		}
		$data['account']= $account;
		$data['account_detail'] = $accountDetail;
		$totalAmount = array(0, 0);
		foreach ($accountDetail as $v) {
			if ($v['amount'] > 0) {
				$totalAmount[0] += $v['amount'];
			} else {
				$totalAmount[1] -= $v['amount'];
			}
		}
		$totalAmount[0] = Finance_Account::amountFormat($totalAmount[0]);
		$totalAmount[1] = Finance_Account::amountFormat($totalAmount[1]);
		$data['total_amount'] =$totalAmount;
		$dates = array();
		$timeNow = time();
		do {
			$dates[] = date("Y-m", $timeNow);
			$timeNow -= 86400 * 30;
		} while ($timeNow > '1425279172');
		$data['dates'] =$dates;
        Func_Return ::jsonReturn($data,'成功获取',1);
	}

	//获取账户交易列表---加载更多
	//参数用户id , limit=0,10
	static function getAccountDetailLoadMore()
	{
		if(empty($_REQUEST['user_id'])){
			App_Api_Broker_Main::jsonReturn('','缺少参数！',-1001);
		}
		if(empty($_REQUEST['page'])){
			$limit='0,9';
		}else{
			$srart = ($_REQUEST['page']-1)*10;
			$end = ($_REQUEST['page'])*10-1;
			$limit = "$srart,$end";
		}
		$accountDetail = Finance_Account::getDetailList($_REQUEST['user_id'],'','',$limit);
		$data['account_detail'] = $accountDetail;
        Func_Return ::jsonReturn($data,'获取成功！',1);
	}
}