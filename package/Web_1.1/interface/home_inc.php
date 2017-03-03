<?php
/**
 * Created by PhpStorm.
 * User: bll
 * Date: 15/9/8
 * Time: 下午5:49
 */
switch(Core::$urls['action']){
    case "form":
        demandFormComplete();
        break;
    case "question":
        demandQuestion();

        break;
}

 function demandFormComplete(){
     $request = Func_Input::filter(array(
         'demand_id' => 'int',
     ), $_REQUEST);
     if(empty($request['demand_id'])){
         Tpl_Smarty::assign("msg","不好意思，您的需求参数错误！<br />请拨打客服热线:400-056-0599");
         Tpl_Smarty::display('Web_Static', 'home.v3.0/inc.form.error.3.0.tpl');
         die();
     }
     $result = Api_Demand_GetInfo::getInfo($request);
     if($result['status']==1){
        if(time()-$result['data']['create_time']>60*5){
            Tpl_Smarty::assign("msg","不好意思，您的需求已超时！<br />请拨打客服热线:400-056-0599");
            Tpl_Smarty::display('Web_Static', 'home.v3.0/inc.form.error.3.0.tpl');
            die();
            Func_Header::back("不好意思，您的需求已超时！，请拨打400-056-0599客服热线");
        }
     }else{
         Tpl_Smarty::assign("msg","不好意思，您的需求参数错误！<br />请拨打客服热线:400-056-0599");
         Tpl_Smarty::display('Web_Static', 'home.v3.0/inc.form.error.3.0.tpl');
         die();
     }
     Tpl_Smarty::assign("demand_id",$request['demand_id']);
     Tpl_Smarty::display('Web_Static', 'home.v3.0/inc.form3.0.tpl');
}

function demandQuestion(){
    $request = Func_Input::filter(array(
        'demand_id' => 'int',
    ), $_REQUEST);
    if(empty($request['demand_id'])){
        Func_Header::to("参数错误");
    }
    Tpl_Smarty::assign("demand_id",$request['demand_id']);
    $question = array(
         array(
            "q"=>"您想举办的活动是面对大众还是针对性群体?",
            "a"=>array(
                "面对大众",
                "针对性群体",
            )
        ),
        array(
            "q"=>"请选择您意向的场地类型?",
            "a"=>array(
                "商场",
                "演艺中心",
                "美术馆",
                "其他",
            ),
        ),
        array(
            "q"=>"请选择您意向的场地类型?",
            "a"=>array(
                "秀场",
                "艺术中心",
                "会所",
                "其他",
            )
        ),
    );
    Tpl_Smarty::assign("question",$question);
    Tpl_Smarty::display('Web_Static', 'home.v3.0/inc.question3.0.tpl');
}