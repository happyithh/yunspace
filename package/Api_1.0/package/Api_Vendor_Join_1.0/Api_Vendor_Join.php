<?php

/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 2015/8/13
 * Time: 16:13
 */

/**
 * Class Api_Vendor_Join
 * @供应商加盟
 * 1.未登录提交表单需要验证手机号， 验证码。
 * 2.未注册的手机号会注册一个账户，密码发送至手机，
 * 3.表单数据提交后，会自动登录到供应商管理页面
 */
class Api_Vendor_Join extends Api
{

    /**
     * @args = array(
     *
     *
     * )
     *
     */
    static function handle($args = '')
    {
        return self::join($args);
    }

    static function join($args)
    {
        $request = Func_Input::filter(array(
            'city' => 'string',
            'phone' => 'int',
            'contact_people' => 'string',
            'card' => 'string',
            'media' => 'string',
            'product_des' => 'string',
            'product_name' => 'string',
            'vendor_name' => 'string',
            'category_id' => 'string',
            'other' => 'html',
            'auth_code' => 'int',
        ), $args);

        if (empty($request['phone']) || empty($request['contact_people']) || empty($request['vendor_name'])) {
            return Api::request('error', '', '缺少参数或者参数不正确，如有问题请致电400-056-5699');
        }

        //检查登录情况
        $accountInfo = Api_Session::user_info();
        if ($accountInfo) {
            $account = $accountInfo;
        } else {
            if (!empty($request['auth_code'])) {
                $checkPhone = Api_Vendor_Join_CheckAccount::CheckAccountByPhone(array('phone' => $request['phone'],
                    'auth_code' => $request['auth_code'],
                    'username' => $request['contact_people']));
                if ($checkPhone['status'] == 1) {
                    $account = $checkPhone['data'];
                } else {
                    $checkPhone['status'] = 3;
                    return $checkPhone;
                }
            } else {
                return array(
                    'status' => 2,
                    'data' => '',
                    'msg' => '未登录用户,请先登录！'
                );

            }
        }
        $is_exist = Data_Mysql_Table_Vendor_Join::select('id', array(
            'account_id=?' => $account['id'],
            'status >=?' => 0));
        if (!empty($is_exist[0])) {
            return Api::request('error', '', '您的账号已提交过供应商加盟信息，请勿重复提交，如有问题请致电400-056-0599');
        }
        /*if (!empty($account['vendor_name'])) {
            return Api::request('error', '', '该手机号未注册');
        }*/
        $insert = array(
            'account_id' => $account['id'],
            'phone' => $request['phone'],
            'contact_people' => $request['contact_people'],
            'media' => self::MediaFormat($request['media']),
            'card' => self::MediaFormat($request['card']),
            'category_id' => $request['category_id'],
            'product_des' => $request['product_des'],
            'product_name' => $request['product_name'],
            'city' => $request['city'],
            'vendor_name' => $request['vendor_name'],
            'create_time' => time(),
            'other' => $request['other'],
            'ip' => Func_Input::ip(),
            'status' => 0,
        );
        $data = Data_Mysql_Table_Vendor_Join::insert($insert);
        if ($data[0] > 0) {
            //注册一个供应商
            $vendor = array(
                'vendor_name' => $request['vendor_name'],
                'categories_id' => $request['category_id'],
                'vendor_account_id' => $account['id'],
                'attr' => array('城市' => $request['city']),
                'attr_index' => array('城市' => $request['city']),
                'city' =>$request['city'],
                'status' => -10,
                'create_by_quick' => '2',
            );
            $vendor_id = Data_Mysql_Table_Vendor_Info::subTable('_update')->insert($vendor);
            $product = array(
                'category_id' => $insert['category_id'],
                'vendor_id' => $vendor_id[0],
                'product_name' => $insert['product_name'],
                'media' => $insert['media'],
                'des' => $insert['product_des'],
                'count_product' => 1,
                'attr_new' => array(Page_Site_Global::tagsName('城市') => $request['city']),
                'status' => 0,        //审核中             审核后转成正式表中的数据
            );
            Data_Mysql_Table_Product_Info::subTable('_update')->insert($product);

            //进行登录
            Api_Account_Login_AutoLoginSession::auto(array('account_id' => $account['id']));

            $_SESSION['url_back'] = Core::$urls['root'] . 'vendor_center/vendor_admin/vendor_edit?vendor_id=' . $vendor_id;

            return Api::request('success', $vendor_id[0], "申请成功，请耐心等待审核。\n记得要去完善供应商及商品信息哦，炫出特色来吧！   如有问题请致电400-056-0599");
        }
        return Api::request('error', '', '申请失败，如有问题请致电400-056-0599');
    }

    //获取account
    static function  isExistAccount($phone)
    {
        $table = "{table} as t1 LEFT JOIN {prefix}vendor_info as t2 ON t1.id = t2.vendor_account_id";
        $conditions['phone=?'] = $phone;
        $data = Data_Mysql_Table_Account::select('t1.id,t1.phone,t2.vendor_name', $conditions, '', 1, $table);

        if (empty($data[0])) {
            return false;
        }
        return $data[0];

    }

    static function  MediaFormat($media)
    {
        $media = explode(',', $media);
        $formatMedia = array();
        foreach ($media as $k => $val) {
            if (!empty($val)) {
                $formatMedia[$k]['path'] = $val;
                $formatMedia[$k]['tags'] = '';
                $formatMedia[$k]['name'] = '';
                $formatMedia[$k]['video'] = '';
            }
        }
        return $formatMedia;
    }

}