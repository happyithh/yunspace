<?php

/**
 * Created by PhpStorm.
 * User: yl
 * Date: 15-10-16
 * Time: 上午10:29
 * 场地百科表单提交
 */
class Api_Spacepedia_Submit
{

    /*
     *获取全部场地百科的列表
     * @param:$data  array 数据数组
     * @return:数据更新成功或失败
     */
    static function spacepediaInfoSubmit($data)
    {
        $request = Func_Input::filter(array(
            'space_id' => 'int',
            'space_name' => 'string',
            'nickname' => 'string',
            // 'vendor_id' => 'int',
            'company' => 'string',
            'city' => 'string',
            'addr' => 'string',
            'attr' => 'array',
            'other_demo' => 'array',
            'media' => 'array',
            'media1' => 'array',
            'logo' => 'string',
            'mobile_logo' => 'string',
            'des' => 'html',
            'category_id' => 'int',
            'status'=>'int',
            'level'=>'int',
            'product_id'=>'int',
            'new_id' =>'int',
            'wenchuang_attr' =>'array',
        ), $data);
//        q($request['wenchuang_attr']['获奖记录']);
        // 处理文创数据获奖记录信息
        if($request['wenchuang_attr']['获奖记录']){
            foreach($request['wenchuang_attr']['获奖记录']['win_time'] as $k=>$v){
                $request['wenchuang_attr']['获奖记录'][$k]['win_time']=$v;
                $request['wenchuang_attr']['获奖记录'][$k]['active_name']=$request['wenchuang_attr']['获奖记录']['active_name'][$k];
                $request['wenchuang_attr']['获奖记录'][$k]['win_name']=$request['wenchuang_attr']['获奖记录']['win_name'][$k];
                $request['wenchuang_attr']['获奖记录'][$k]['win_actor']=$request['wenchuang_attr']['获奖记录']['win_actor'][$k];
            }
            unset($request['wenchuang_attr']['获奖记录']['win_time']);
            unset($request['wenchuang_attr']['获奖记录']['active_name']);
            unset($request['wenchuang_attr']['获奖记录']['win_name']);
            unset($request['wenchuang_attr']['获奖记录']['win_actor']);
        }
        $files = Func_Input::filter(array(
            '百科banner' => 'array',
            '百科移动端banner' => 'array',
            '附件'=>'array',
        ), $_FILES);
        if (!empty($files['百科banner']['name'])) {
            $logo = Func_Upload::image('百科banner');
            if (!empty($logo)) {
                $request['logo'] = $logo;
            }
        }
        if (!empty($files['百科移动端banner']['name'])) {
            $mobile_logo = Func_Upload::image('百科移动端banner');
            if (!empty($mobile_logo)) {
                $request['mobile_logo'] = $mobile_logo;
            }
        }
        if (!empty($files['附件']['name'])) {
            preg_match_all('/\.(.*)/',$files['附件']['name'],$match);
            if(!empty($match[0][0])) {
                $type = $match[0][0];
                if($type !== '.pdf') {
                    Func_Header::back('请上传PDF格式的文件！');
                }
            }
            $accessory = Func_Upload::file('附件');
            if (is_array($accessory) && $accessory['code'] == 0) {
                Func_Header::back($accessory['msg']);
            } else {
                $request['other_demo']['附件']['name'] = $accessory;
            }
            $request['other_demo']['附件']['size'] = $files['附件']['size'];
            $request['other_demo']['附件']['filename'] = $files['附件']['name'];
        }
        if (empty($request['space_name'])) {
            return Api::request('error','','场地百科名称不能为空！');
        }
       /* if (empty($request['vendor_id'])) {
            Func_Header::back('所属供应商不能为空！');
        }*/
//        if (empty($request['des'])) {
//            return Api::request('error','','场地描述不能为空！');
//        }
        //判断名称是否重复
        if (!empty($request['space_id'])) {
            $condit['id !=?']=$request['space_id'];
        }
        $condit['space_name =?']=$request['space_name'];
        $name_exists = Data_Mysql_Table_Spacepedia::select("id,space_name",$condit);
        if (!empty($name_exists[0])) {
            return Api::request('error','','该场地百科名称已经存在！');
        }
        $is_space=Web_Global::catIsSpace($request['category_id']);
        if ($is_space && empty($data['is_repeat']) && empty($request['attr'][46])) {
            return Api::request('error','','场地百科城市不能为空！');
        }
        if (!empty($request['media'])) {
            unset($request['media']['$$']);
            $request['media'] = array_values($request['media']);
        }
        $media=array();
        if (!empty($request['media1'])) {
            foreach($request['media1'] as $k=>$v){
                unset($v['$$']);
                $media=array_merge($media,$v);
            }
        }
        $request['media']=empty($media)?$request['media']:$media;
        /* if(!isset($data['status'])){
             $data['status']=2;
         }*/
        //更新数据
        if (!empty($request['space_id'])) {
            $space_id = $request['space_id'];
//            $create_data['space_name'] = $request['space_name'];
//            $create_data['nickname'] = $request['nickname'];
//            $create_data['category_id'] = $request['category_id'];
//            $create_data['vendor_id'] = $request['vendor_id'];
//            $create_data['addr'] = $request['addr'];
//            $create_data['des'] = $request['des'];
//            $create_data['city'] = $request['attr'][46];
//            $create_data['logo'] = $request['logo'];
//            $create_data['mobile_logo'] = $request['mobile_logo'];
//            $create_data['media'] = $request['media'];
//            $create_data['attr'] = $request['attr'];
//            $create_data['other_demo'] = $request['other_demo'];
//            $create_data['level'] = $request['level'];
////            $create_data['status'] = '2';
//            $create_data['product_id'] =$request['product_id'];
//             Data_Mysql_Table_Spacepedia::update($space_id,$create_data);
        }else{
            $create_data['space_name'] = $request['space_name'];
            $create_data['nickname'] = $request['nickname'];
            $create_data['category_id'] = $request['category_id'];
            $create_data['vendor_id'] = $request['vendor_id'];
            $create_data['company'] = $request['company'];
            $create_data['addr'] = $request['addr'];
            $create_data['des'] = $request['des'];
            $create_data['city'] = $request['attr'][46];
            $create_data['logo'] = $request['logo'];
            $create_data['mobile_logo'] = $request['mobile_logo'];
            $create_data['media'] = $request['media'];
            $create_data['attr'] = $request['attr'];
            $create_data['other_demo'] = $request['other_demo'];
            $create_data['level'] = $request['level'];
            $create_data['status'] = '2';
            $create_data['product_id'] =$request['product_id'];
            $create_data['new_id'] = $request['new_id'];
            $create_data['wenchuang_attr'] = $request['wenchuang_attr'];
            $rs = Data_Mysql_Table_Spacepedia::insert($create_data);
            if(!empty($rs[0])){
                $space_id = $rs[0];
            }
        }
        if(empty($space_id)){
            return Api::request('error','','参数错误！');
        }


        //更新历史表中的数据为取消
        self::changeHistoryStatusToCancel($space_id);

        //向历史表中添加一条数据
        $create_history['data_backup']['space_name'] = $request['space_name'];
        $create_history['data_backup']['nickname'] = $request['nickname'];
        $create_history['data_backup']['category_id'] = $request['category_id'];
        $create_history['data_backup']['vendor_id'] = $request['vendor_id'];
        $create_history['data_backup']['company'] = $request['company'];
        $create_history['data_backup']['addr'] = $request['addr'];
        $create_history['data_backup']['des'] = str_replace(">","&gt;",$request['des']) ;
        $create_history['data_backup']['des'] = str_replace("<","&lt;",$create_history['data_backup']['des']) ;
        $create_history['data_backup']['des'] = str_replace('"',"&#34;",$create_history['data_backup']['des']) ;
        $create_history['data_backup']['city'] = $request['attr'][46];
        $create_history['data_backup']['logo'] = $request['logo'];
        $create_history['data_backup']['mobile_logo'] = $request['mobile_logo'];
        $create_history['data_backup']['media'] = $request['media'];
        $create_history['data_backup']['attr'] = $request['attr'];
        $create_history['data_backup']['other_demo'] = $request['other_demo'];
        $create_history['data_backup']['level'] = $request['level'];
        $create_history['data_backup']['space_id'] = $space_id;
        $create_history['data_backup']['new_id'] = $request['new_id'];
        $create_history['data_backup']['wenchuang_attr'] = $request['wenchuang_attr'];
        $create_history['object_id'] = $space_id;
        $create_history['admin_id'] = $_SESSION['administrator']['id'];
        $create_history['create_time'] = time();
        $create_history['status'] = empty($request['status'])?'0':$request['status'];
        $history = Data_Mysql_Table_History::subTable('_baike_' . date("Ym"))->insert($create_history);
        if (empty($history[0])) {
            return Api::request('error','','创建场地百科失败');
        } else {
            //  $space_id = empty($request['space_id']) ? $rs[0] : $space_id;
            return Api::request('success',$space_id,'创建场地百科成功！');
        }
    }
    //更新百科历史表中的待审核数据为取消
    static function changeHistoryStatusToCancel($space_id){
        $history_id = Data_Mysql_Table_History::subTable('_baike_' . date("Ym"))->select('id', array('object_id' => $space_id, 'status' => 0), '', 9999);
        if (!empty($history_id)) {
            $id = array();
            foreach ($history_id as $k => $v) {
                $id[] = $v['id'];
            }
            $ids[] = 'id IN (' . implode(',', $id) . ')';
            $constion['status'] = 3;
            Data_Mysql_Table_History::subTable('_baike_' . date("Ym"))->update($ids, $constion);
        }
        $tmp_date=date("Ym");
        //切割出年份
        $tmp_year=substr($tmp_date,0,4);
        //切割出月份
        $tmp_mon =substr($tmp_date,4,2);
        $tmp_forwardmonth=mktime(0,0,0,$tmp_mon-1,1,$tmp_year);
        $history_idss = Data_Mysql_Table_History::subTable('_baike_' . date("Ym",$tmp_forwardmonth))->select('id', array('object_id' => $space_id, 'status' => 0), '', 9999);
        if (!empty($history_idss)) {
            $id = array();
            foreach ($history_idss as $k => $v) {
                $id[] = $v['id'];
            }
            $ids[] = 'id IN (' . implode(',', $id) . ')';
            $constion['status'] = 3;
            Data_Mysql_Table_History::subTable('_baike_' . date("Ym",$tmp_forwardmonth))->update($ids, $constion);
        }
    }


    //根据百科id或名称向历史表中添加数据
    static function insertHistoryBySpaceIdOrName($space_var,$insert_data=array()){
        if(is_numeric($space_var)){
            $spacedia = Data_Mysql_Table_Spacepedia::select("*", array('id' => $space_var));
        }else{
            $spacedia = Data_Mysql_Table_Spacepedia::select("*", array('space_name' => $space_var));
        }
        if(empty($spacedia[0])){
            return false;
        }
        if(!empty($spacedia[0]['attr'])){
            $attr=json_decode($spacedia[0]['attr'],1);
            $create_history['data_backup']['attr'] = $attr;
            $create_history['data_backup']['city'] = empty($attr[46])?"上海":$attr[46];
        }
        if(!empty($spacedia[0]['media'])){
            $create_history['data_backup']['media']=json_decode($spacedia[0]['media'],1);
        }
        if(!empty($spacedia[0]['other_demo'])){
            $create_history['data_backup']['other_demo']=json_decode($spacedia[0]['other_demo'],1);
        }
        $create_history['data_backup']['space_name'] = $spacedia[0]['space_name'];
        $create_history['data_backup']['nickname'] = $spacedia[0]['nickname'];
        $create_history['data_backup']['category_id'] = $spacedia[0]['category_id'];
        $create_history['data_backup']['vendor_id'] = $spacedia[0]['vendor_id'];
        $create_history['data_backup']['company'] = $spacedia[0]['company'];
        $create_history['data_backup']['addr'] = $spacedia[0]['addr'];
        $create_history['data_backup']['des'] = $spacedia[0]['des'];
        $create_history['data_backup']['des'] = str_replace(">","&gt;",$spacedia[0]['des']) ;
        $create_history['data_backup']['des'] = str_replace("<","&lt;",$create_history['data_backup']['des']) ;
        $create_history['data_backup']['des'] = str_replace('"',"&#34;",$create_history['data_backup']['des']) ;
        $create_history['data_backup']['logo'] = $spacedia[0]['logo'];
        $create_history['data_backup']['mobile_logo'] = $spacedia[0]['mobile_logo'];
        $create_history['data_backup']['space_id'] = $spacedia[0]['id'];
        $create_history['data_backup']['level'] = $spacedia[0]['level'];
        $create_history['data_backup']['level'] = $spacedia[0]['wenchuang_attr'];
        $create_history['object_id'] = $spacedia[0]['id'];
        $create_history['admin_id'] = $_SESSION['administrator']['id'];
        $create_history['create_time'] = time();
        $create_history['status'] = empty($insert_data['status'])?'0':$insert_data['status'];
        if(!empty($insert_data)){
            foreach($insert_data as $k=>$v){
                $create_history['data_backup'][$k]=$v;
            }
        }
        $history = Data_Mysql_Table_History::subTable('_baike_' . date("Ym"))->insert($create_history);
        if(empty($history[0])){
            return false;
        }else{
            return true;
        }


    }

    //通过审核
    static function spacepediaInfoAudit($data)
    {
        $request = Func_Input::filter(array(
            'history_id' => 'int',
            'status' => 'int',
            'month'=>'int'
        ), $data);

        $history = Data_Mysql_Table_History::subTable('_baike_' . $request['month'])->select("*", array('id' => $request['history_id']));
        if (!empty($history[0])) {
            if(!empty($history[0]['data_backup'])){
                $data_backup = json_decode($history[0]['data_backup'], 1);
                //获取旧场地数据
                $old_data=Data_Mysql_Table_Spacepedia::select('id,space_name',array('id'=>$data_backup['space_id']));
                if(empty($old_data[0])){
                    Func_Header::back("数据错误！！");
                }
                $old_space_name=$old_data[0]['space_name'];

                //判断百科是否为空间场地
                $is_space=Web_Global::catIsSpace($data_backup['category_id']);
                if($is_space && empty($data_backup['city'])){
                    Func_Header::back("百科城市不能为空！！");
                }
                $condition['space_name'] = $data_backup['space_name'];
                $condition['nickname'] = $data_backup['nickname'];
                $condition['category_id'] = $data_backup['category_id'];
                $condition['vendor_id'] = intval($data_backup['vendor_id']);
                $condition['company'] = $data_backup['company'];
                $condition['addr'] = $data_backup['addr'];
                $condition['des'] = str_replace("&gt;",'>',$data_backup['des']);
                $condition['des'] = str_replace("&lt;",'<',$condition['des']);
                $condition['des'] = str_replace("&#34;",'"',$condition['des']);
                $condition['city'] = $data_backup['city'];
                $condition['logo'] = $data_backup['logo'];
                $condition['mobile_logo'] = $data_backup['mobile_logo'];
                $condition['media'] = $data_backup['media'];
                $condition['attr'] = $data_backup['attr'];
                $condition['other_demo'] = $data_backup['other_demo'];
                $condition['wenchuang_attr'] = $data_backup['wenchuang_attr'];
                if(!empty($data_backup['level'])){
                    $condition['level'] = $data_backup['level'];
                }
            }
            $condition['status'] = $request['status'];
            $os = Data_Mysql_Table_Spacepedia::update(array('id' => $history[0]['object_id']), $condition);
            if (!empty($os[0])) {
                $constion['status'] = 1;
                $rs = Data_Mysql_Table_History::subTable('_baike_' . $request['month'])->update(array('id' => $request['history_id']), $constion);
                $rs[1] = $history[0]['object_id'];
                //如果更改场地名称，更新该场地的所有旧名称的指向
                if($old_space_name != $condition['space_name']){
                    $redirect_data['space_name']=$old_space_name;
                    $redirect_data['space_id']=$data_backup['space_id'];
//                    $redirect_data['redirect_url']=Func_Url::str_urlencode($condition['space_name']);
                    //添加一条新数据
                    Data_Mysql_Table_Space_Redirect::insert($redirect_data);
//                    //更新场地名称更改的其他旧数据的地址
//                    Data_Mysql_Table_Space_Redirect::update(array('space_id'=>$data_backup['space_id']),array('redirect_url'=>$redirect_data['redirect_url']));
                }

                return $rs;
            } else {
                return false;
            }
        }
    }


    static function spacepediaInfoRefuse($data)
    {
        $request = Func_Input::filter(array(
            'history_id' => 'int',
            'reason' => 'string',
            'month'=>'int',
        ), $data);
        $constion['status'] = '2';
        $constion['refuse_reason'] = $request['reason'];
        $rs = Data_Mysql_Table_History::subTable('_baike_' . $request['month'])->update(array('id' => $request['history_id']),  $constion);
        if(!empty($rs[0])){
            //判断旧数据是否是待审核状态
            $history = Data_Mysql_Table_History::subTable('_baike_' . $request['month'])->select("id,object_id", array('id' => $request['history_id']));
            if(!empty($history[0]) && !empty($history[0]['object_id'])){
                Data_Mysql_Table_Spacepedia::update(array('id'=>$history[0]['object_id'],'status'=>2),array("status"=>3,"refuse_reason"=>$request['reason']));
            }
            $rs[1] = $history[0]['object_id'];
            return $rs;
        }else{
            return false;
        }
    }
}