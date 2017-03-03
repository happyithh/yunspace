<?php

/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 2015/11/24
 * Time: 9:44
 *  场地搜索
 * 1.用于OA后台搜索
 * 2.启用场地百科表查询   TODO::
 */
class  Api_Space_Item_Search extends Api
{
    static function  handle($args = '')
    {
        return self::handleSpaceItemAutoComplete($args);
    }


    //场地搜索
    static function handleSpaceItemAutoComplete($args)
    {
        Core::output('');
        $request = Func_Input::filter(array(
            'id' => 'int',
            'q' => 'string',
            'account_id' => 'int',
        ), $args);
        if (empty($request['id']) && empty($request['q'])) {
            return self::request('error', '', '缺少参数或者参数不正确，请检查参数合法性');
        }
        if (!empty($request['id'])) {
            //TODO::场地百科表

        } else {

        }

        return self::request('success', $rs, '成功');
    }

}