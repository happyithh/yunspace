<?php
/**
 * Created by PhpStorm.
 * User: yl
 * Date: 15-11-30
 * Time: 上午9:32
 * 公众号管理
 */
class OA_Public_Number_Management{
    static function handle()
    {
        $action = empty($_REQUEST['action']) ? 'list' : $_REQUEST['action'];
        switch ($action) {
            case 'list':
                self::getPublicNumberList();
                break;
            case 'add_public_number':
                self::addPublicNumber();
                break;
            case 'delete_public':
                self::deletePublic();
                break;


        }
    }

    static function getPublicNumberList(){
        $conditions=array();
        if(!empty($_REQUEST['search'])){
            $search = Func_Input::filter(array(
                'title'=>'string',
                'public_type'=>'string',
                'create_time'=>'string',
            ),$_REQUEST['search']);
            //名称或ID筛选
            if (!empty($search['title'])) {
                if (is_numeric($search['title'])) {
                    $conditions['id'] = $search['title'];
                } else {
                    $conditions['show_name'] =$search['title'];
                    $conditions['public_number'] =$search['title'];
                }
            }
            //公众号类型选择
            if(!empty($conditions['public_type'])){
                $conditions['public_type'] =$search['public_type'];
            }

            //创建时间筛选
            if(!empty($search['create_time'])){
                $conditions['create_time >= ?'] =strtotime($search['create_time']);
            }
        }
        $data=Data_Mysql_Table_Public_Number::page(0,20,'*',$conditions,'ORDER BY update_time DESC');
        if(!empty($data['rows'])){
            foreach($data['rows'] as $k=>$v){
                if(!empty($v['public_type'])){
                    $data['rows'][$k]['public_type']=json_decode($v['public_type'],1);
                    $data['rows'][$k]['public_type_str']=implode(" / ",$data['rows'][$k]['public_type']);
                }
            }
        }
        Tpl_Smarty::assign('_data',$data);
        Tpl_Smarty::display("OA_Static","public_number/public_list.tpl");
    }

    //添加微信号
    static function addPublicNumber(){
        $request=Func_Input::filter(array(
           'public_id'=>'int',
           'public_number'=>'string',
           'show_name'=>'string',
           'public_type'=>'array',
        ));
        if(empty($request['public_number']) || empty($request['show_name'])){
            Func_Header::back('请输入微信号/微信名称！！');
        }
        //判断名称是否重复
        if(!empty($request['public_id'])){
            $condition['id != ?']=$request['public_id'];
        }
        $condition['public_number = ?']=$request['public_number'];
        $is_exists=Data_Mysql_Table_Public_Number::select('id,public_number',$condition);
        if(!empty($is_exists[0])){
            Func_Header::back('该微信号已存在！！');
        }
        $update_data['public_number']=$request['public_number'];
        $update_data['show_name']=$request['show_name'];
        $update_data['public_type']=$request['public_type'];
        if(!empty($request['public_id'])){
            $rs=Data_Mysql_Table_Public_Number::update(array("id"=>$request['public_id']),$update_data);
        }else{
            $rs=Data_Mysql_Table_Public_Number::insert($update_data);
        }
        if(!empty($rs[0])){
            Func_Header::to(' 微信号添加/修改成功！1',"?");
        }else{
            Func_Header::back('微信号添加/修改失败！！');
        }
    }
    //删除公众号
    static function deletePublic(){
        Core::output("");
        $request=Func_Input::filter(array(
            "public_id"=>"int",
        ));
        if(empty($request['public_id'])){
            Func_Output::json('error',"","参数缺失！！");
        }
        $rs=Data_Mysql_Table_Public_Number::delete(array("id"=>$request['public_id']));
        if(empty($rs[0])){
            Func_Output::json('error',"","微信号删除失败！！");
        }else{
            Func_Output::json('success',"","微信号已删除！！");
        }

    }
}