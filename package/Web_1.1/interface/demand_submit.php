<?php
switch (Core::$urls['action']) {
    //整体方案
    case 'solution':
        $data = Func_Input::filter(array(
            '联系人电话' => 'phone',
            '联系人' => 'string',
            '具体要求' => 'string'
        ), $_REQUEST['data']);
        if (empty($data['联系人电话'])) {
            Func_Header::back('联系人电话必须填写！');
        }
        if (empty($data['联系人'])) {
            Func_Header::back('联系人不能为空！');
        }
        if (empty($data['具体要求'])) {
            Func_Header::back('具体要求必须填写!');
        }
        $r = Data_Mysql_Table_Demand::create('整体方案', $_REQUEST['data']);
        Func_Header::to('您的需求已成功提交，稍候将有云·Space专业人员为您提供后续服务！');
        break;
    case 'vendor_join':
        //供应商加盟
        $request = Func_Input::filter(array(
            'city' => 'array',
            'phone' => 'int',
            'contact_people' => 'string',
            'card' =>'array',
            'media' => 'array',
            'product_des' => 'string',
            'product_name' => 'string',
            'vendor_name' => 'string',
            'product_type' =>'string',

        ), $_REQUEST);
        $data =Api_Vendor_Join::handle($request);
        Func_Header::back($data['msg']);
        break;

    case 'look':
        //带看场地
        Web_Account::handleIsLogin();
        $request = Func_Input::filter(array(
            'id' => 'int',
        ));
        $rs = Data_Mysql_Table_Product_Info::select('id, product_name', array('id' => $request['id'], 'status' => 1));
        if (empty($rs[0]['id'])) {
            Func_Header::notFound();
        }
        if (!empty($_SESSION['demand_product_ids'][$request['id']])) {
            Func_Header::to('请勿重复提交同一个请求！', Core::$urls['referer']);
        } else {
            $_SESSION['demand_product_ids'][$request['id']] = 1;
        }
        $productInfo = $rs[0];
        $r = Data_Mysql_Table_Demand::create('实地看场', array(
            'product_id' => $rs[0]['id'],
            '具体要求' => "我要实地查看: {$rs[0]['product_name']}",
        ));
        Func_Header::to('您的需求已成功提交，稍候将有云·Space专业人员为您提供后续服务！');
        break;
    case 'ask':
        //预约咨询
        $request = Func_Input::filter(array(
            'ask_id' => 'int',
            'ask_type' => 'int',
            '联系人' => 'string',
            '联系电话' => 'string',
            '咨询内容' => 'string',
        ), $_REQUEST['data']);
        if (empty($request['联系人'])) {
            Func_Header::back('请输入您的姓名！');
        }
        if (empty($request['联系电话'])) {
            Func_Header::back('请输入您的联系电话哦！');
        }
        if (empty($request['ask_type'])) {
            Func_Header::back('缺少参数！');
        }
        $rs = $r = '';
        switch ($request['ask_type']) {
            //产品详情页
            case 1:
                $rs = Data_Mysql_Table_Product_Info::select('id, vendor_id,product_name', array('id' => $request['ask_id'], 'status' => 1));
                if (empty($rs[0]['id'])) {
                    Func_Header::notFound();
                }
                $productInfo = $rs[0];
                $demand_data = array(
                    '联系电话' => $request['联系电话'],
                    '联系人' => $request['联系人'],
                    'product_id' => $rs[0]['id'],
                    '具体要求' => "产品咨询: {$rs[0]['product_name']}",
                    '来源类型' => '产品详情页',
                    '咨询内容' => $request['咨询内容'],
                );
                $r = Data_Mysql_Table_Demand::create('预约咨询', $demand_data);

                break;
            //移动版  产品详情页  咨询档期
            case 2:
                $rs = Data_Mysql_Table_Product_Info::select('id,vendor_id, product_name', array('id' => $request['ask_id'], 'status' => 1));
                if (empty($rs[0]['id'])) {
                    Func_Header::notFound();
                }
                $productInfo = $rs[0];
                $demand_data = array(
                    '联系电话' => $request['联系电话'],
                    '联系人' => $request['联系人'],
                    'product_id' => $rs[0]['id'],
                    '具体要求' => "产品档期查询: {$rs[0]['product_name']}-日期：{$request['咨询内容']}",
                    '来源类型' => '移动版产品详情页',
                    '咨询内容' => "产品档期查询: " . $rs[0]['product_name'] . '//' . $request['咨询内容'],
                );
                $r = Data_Mysql_Table_Demand::create('产品档期查询', $demand_data);
                if ($r) {

                        $demand_data['demand_id'] = $r;
                        Api_Demand_AddGroup::addGroup(array('demand'=>$demand_data,'vendor_id'=>$rs[0]['vendor_id']));

                    Func_Output::json('success', '', '您的档期查询成功提交，稍候将有云·Space专业人员为您提供后续服务');
                } else {
                    Func_Output::json('error', '', '信息输入错误，请稍后再试！');
                }
                break;
            //套餐详情页
            case 5:
                $rs = Data_Mysql_Table_Product_Set::select('id, vendor_id,set_name', array('id' => $request['ask_id'], 'status' => 1));
                if (empty($rs[0]['id'])) {
                    Func_Header::notFound();
                }
                $productInfo = $rs[0];
                $demand_data = array(
                    '联系电话' => $request['联系电话'],
                    '联系人' => $request['联系人'],
                    'set_id' => $rs[0]['id'],
                    '具体要求' => "套餐咨询: {$rs[0]['set_name']}",
                    '来源类型' => '套餐详情页',
                    '咨询内容' => $request['咨询内容'],
                );
                $r = Data_Mysql_Table_Demand::create('预约咨询', $demand_data);
                break;
            //  移动版套餐详情页档期查询
            case 6:
                $rs = Data_Mysql_Table_Product_Set::select('id,vendor_id, set_name', array('id' => $request['ask_id'], 'status' => 1));
                if (empty($rs[0]['id'])) {
                    Func_Header::notFound();
                }
                $productInfo = $rs[0];
                $demand_data = array(
                    '联系电话' => $request['联系电话'],
                    '联系人' => $request['联系人'],
                    'set_id' => $rs[0]['id'],
                    '具体要求' => "套餐档期查询: {$rs[0]['set_name']}-日期{$request['咨询内容']}",
                    '来源类型' => '移动版套餐详情页',
                    '咨询内容' => "套餐档期查询:" . $rs[0]['set_name'] . '//日期' . $request['咨询内容'],
                );
                $r = Data_Mysql_Table_Demand::create('套餐档期查询', $demand_data);
                if ($r) {

                        $demand_data['demand_id'] = $r;
                        Api_Demand_AddGroup::addGroup(array('demand'=>$demand_data,'vendor_id'=>$rs[0]['vendor_id']));

                    Func_Output::json('success', '', '您的档期查询成功提交，稍候将有云·Space专业人员为您提供后续服务');
                } else {
                    Func_Output::json('error', '', '信息输入错误，请稍后再试！');
                }
                break;
            //供应商
            case 10:
                $rs = Data_Mysql_Table_Vendor_Info::select('id as  vendor_id, vendor_name', array('id' => $request['ask_id'], 'status' => 1));
                if (empty($rs[0]['vendor_id'])) {
                    Func_Header::notFound();
                }
                $vendorInfo = $rs[0];
                $demand_data = array(
                    '联系电话' => $request['联系电话'],
                    '联系人' => $request['联系人'],
                    'vendor_id' => $rs[0]['vendor_id'],
                    '具体要求' => "联系供应商: {$rs[0]['vendor_name']}",
                    '来源类型' => $request['ask_type'],
                    '咨询内容' => $request['咨询内容'],
                );
                $r = Data_Mysql_Table_Demand::create('联系供应商', $demand_data);

                break;
            default:
                Func_Header::notFound();
                break;
        }
        if ($r) {

            $demand_data['demand_id'] = $r;
            Api_Demand_AddGroup::addGroup(array('demand'=>$demand_data,'vendor_id'=>$rs[0]['vendor_id']));

            Func_Header::to('您的预约咨询成功提交，稍候将有云·Space专业人员为您提供后续服务！');
        } else {
            Func_Header::back('您的预约咨询提交失败！，请稍后再试');
        }

    default:
        //办活动
        session_start();
        $request = Func_Input::filter(array(
            '活动城市' => 'string',
            '联系人' => 'string',
            '联系电话' => 'string',
            '具体要求' => 'string',
        ), $_REQUEST['data']);
        if (empty($request['具体要求'])) {
            Func_Header::back('具体要求必须填写!');
        }
        if (strlen($request['具体要求']) > 500) {
            Func_Header::back('您的具体要内容输入过多!');
        }
        if (empty($_SESSION['user']) && empty($request['联系电话'])) {
            Func_Header::back('未登录用户联系电话必须填写!');
        }
        $r = Data_Mysql_Table_Demand::create('办活动', $request);
        if ($r) {
            $request['demand_id'] = $r;

            Func_Header::to('您的需求已成功提交，稍候将有云·Space专业人员为您提供后续服务！');
        } else {
            Func_Header::back('手机号码格式有误，请重试');
        }
        break;
}