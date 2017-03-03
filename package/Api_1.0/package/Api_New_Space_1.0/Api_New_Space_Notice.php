<?php

/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 2015/7/27
 * Time: 16:15
 * 是否创建群组
 */
class Api_New_Space_Notice extends Api
{

    /**
     *param $args =>array(
     *           'space_id' => 'int',
     *
     * );
     * 通知到场地审核人
     */
    static function  noticeSpaceRefuse($args)
    {
        $request = Func_Input::filter(array(
            'space_id' => 'int',
        ), $args);
        //1. 根据 $demandId 查询 需求
        $conditions['id =?'] =$request['space_id'];
        $data = Data_Mysql_Table_New_Space::select('*',$conditions);
       $categoryTree = Data_Mysql_Table_Product_Category::getTreeCache();
        if (empty($data[0])) {
            return false;
        }
        $rs = $data[0];
        $title = ' 您有新提交的场地需要审核';
       $rs['card'] = json_decode($rs['card'],1);
        //q($rs['card']);
        foreach($categoryTree[112] as $k =>$v){
            if ($rs['category_id']==$k){
                $rs['category'] = $v;
            }
        }
        $title = "【通知】您有新提交的场地需要审核";
        $msg = "{$title}<br><dl>";
        $msg .= "<hr><dt>简单联系方式:</dt><dd>联系人:{$rs['contacts']}<br>\n联系电话:{$rs['phone']}<br>邮箱:{$rs['email']}";
        $msg .= "</dd><hr><dt>场地信息:</dt><dd>";
        $msg .= "<br>场地名称: {$rs['space_name']}<br>场地类型: {$rs['category']}<br>城市: {$rs['city']}<br>场地地址: {$rs['addr']}<br>名片/营业执照:<br><img src='http://www.yunsapce.com.cn{$rs['card'][0]['path']}' width='20%'>";
        $msg .= '</dd><br/>';
        $email = Data_Config_Demand_Notice::get('场地出租审核人');
        Func_Mail::send($email, $title, $msg . '</dl>');

    }

  /*  static function  noticeCustomerService($args)
    {
        $request = Func_Input::filter(array(
            'space_id' => 'int',
            'email' =>'string',
        ), $args);
        $conditions['t1.id =?'] =$request['space_id'];
        $table ='{table} as t1 LEFT JOIN {prefix}space_item as t2 ON t1.id=t2.space_id';
        $data = Data_Mysql_Table_Spacepedia::select('t1.addr,t1.refuse_reason,t1.status,t1.id,t1.space_name,t1.category_id,t1.city,t1.create_time,t2.contacts,t2.phone,t2.email,t1.card',$conditions,'',1,$table);
        $categoryTree = Data_Mysql_Table_Product_Category::getTreeCache();
        if (empty($data[0])) {
            return false;
        }
        $rs = $data[0];
        $title = ' 有出租场地需要审核';
        $email = $request['email'];
      foreach($categoryTree[112] as $k =>$v){
            if ($rs['category_id']==$k){
                $rs['category'] = $v;
            }
        }
        $title = "【通知】有场地需要时间审核";
        $msg = "{$title}<br><dl>";
        $msg .= "<hr><dt>简单联系方式:</dt><dd>联系人:{$rs['contacts']}<br>\n联系电话:{$rs['phone']}<br>\邮箱:{$rs['email']}";
        $msg .= "</dd><hr><dt>场地信息:</dt><dd>";
        $msg .= "<br>\场地名称: {$rs['sapce_name']}<br>\场地类型: {$rs['category']}<br>\城市: {$rs['city']}<br>\场地地址: {$rs['addr']}<br>\名片/营业执照: ";
        $msg .= '</dd><br/>';
        Func_Mail::send($email, $title, $msg . '</dl>');
    }*/

}
