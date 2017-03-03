<?php
/**
 * Created by PhpStorm.
 * User: adu
 * Date: 2015/9/10
 * Time: 11:53
 */

class  Api_Demand_Question extends Api
{
    static function handle($args = '')
    {
        return self::handleDemandQuestionCreate($args);
    }

    static function handleDemandQuestionCreate($args)
    {
        $request = Func_Input::filter(array(
            'demand_id' => 'int',
            'question' => 'string',
            'answer' => 'string',
            'q_num' => 'int',
        ), $args);
        if(empty($request['demand_id']) || empty($request['question'])  || empty($request['answer']) || empty($request['q_num'])){
            return self::request('error', '', '请选择一个选项（缺少参数）');
        }
        $rs = Data_Mysql_Table_Demand_Question::select("*",array("demand_id=?"=>$request['demand_id']),'',1);
        if(empty($rs)){
           $demand_question = array(
               $request['q_num']=>array(
                    'q'=>$request['question'],
                    'a'=>$request['answer']
               ),
           );
            $data = array(
                'demand_id' => $request['demand_id'],
                'demand_question' => $demand_question,
                'create_time' => time(),
                'update_time' => time(),
            );
            $result = Data_Mysql_Table_Demand_Question::insert($data);
            if($result){
                $next = explode("_",$request['answer']);
                $request['next_q'] = $next[1];
                return self::request('success', $request, '更新成功');
            }else{
                return self::request('error', '', '更新数据失败');
            }
        }else{
            $demand_question = json_decode($rs[0]['demand_question'],1);
            $demand_question[$request['q_num']] = array(
                'q'=>$request['question'],
                'a'=>$request['answer']
            );
            $data = array(
                'demand_id' => $request['demand_id'],
                'demand_question' => $demand_question,
                'update_time' => time(),
            );
            $result = Data_Mysql_Table_Demand_Question::update(array("demand_id=?"=>$request['demand_id']),$data);
            if($result){
                $next = explode("_",$request['answer']);
                $request['next_q'] = $next[1];
                return self::request('success', $request, '更新成功');
            }else{
                return self::request('error', '', '更新数据失败');
            }


        }


    }
}