<?php


class Api_Demand_Yearmeeting extends Api
{

    static function  handle($args)
    {
        $args['account_id'] = Api_Session::user_id();
        return self::create($args);

        //switch ($args['action']) {
        //    case 'now_consulting':
        //        return self::create($args);
        //        break;
        //    case 'submit_demend':
        //        return self::createYearMeetingDemend($args);
        //        break;
        //}
    }

    /**
     * @param $args
     * @return int
     */
    static function  create($args)
    {
        $request = Func_Input::filter(array(
            //'account_id' => 'int',
            'year_id' => 'int',
            'title' => 'string',
            'ticket_number' => 'int',
            'content' => 'text',
            'contact' => 'string',
            'contact_phone' => 'phone',
        ), $args);

        if (empty($request['contact']) || empty($request['contact_phone']) || empty($request['content'])) {
            return Api::request('error', '', '请将输入框的内容完善~');
        }
        if (strlen($request['content']) > 600) {
            return Api::request('error', '', '不要超过300字~');
        }

        /**
         * 1.判断这个年会投票ID是否存在
         * 2.创建一个年会投票的需求
         * 3 判断需求，不能重复， 一个手机号对于 项目只能提交一次
         */

        //'user_id'             //用户标识
        //'year_id'      //年会主题id或标识)
        //'vote'                //投票数
        //'vote_time'           //投票时间
        //$yearMeeting = Data_Mysql_Table_YearMeeting_Vote::select('year_id,vote,vote_time', array('year_id =?' => $request['year_id']));
        //
        //if (empty($yearMeeting[0]['year_id'])) {
        //    return Api::request('error', '', '该投票已经不存在~，请致电400-056-0599');
        //}
        $demand = array(
            '联系人' => $request['contact'],
            '联系电话' => $request['contact_phone'],
            '咨询项目名称' => isset($request['title']) ? $request['title'] : '',
            '咨询项目内容' => isset($request['content']) ? $request['content'] : '',
            '咨询项目ID' => empty($request['year_id']) ? 0 : $request['year_id'],
            '项目投票数量' => empty($request['ticket_number']) ? 0 : $request['ticket_number'],
        );

        $create = array(
            'demand_type' => '年会咨询',
            'demand' => $demand,
            'phone' => $request['contact_phone'],
            //'account_id' => $request['account_id'],
            'demand_name' => $request['contact'] . '-年会咨询',
        );

        $demand_data = Api_Demand_Create::create($create);
        if ($demand_data['data'] == 0) {
            return Api::request('error', '', '提交失败~，请致电400-056-0599');
        }
        return Api::request('success', '', '您的合作咨询已经提交~稍后客服会和您联系，请您保持电话畅通~');
    }

    static function createYearMeetingDemend($args)
    {
        $request = Func_Input::filter(array(
            'activity_number' => 'int',
            'activity_area' => 'string',
        ), $args);

        if (empty($request['activity_number']) || empty($request['activity_area'])) {
            return Api::request('error', '', '请将选择框的内容完善~');
        }

        $demand = array(
            '活动人数' => $request['activity_number'],
            '活动区域' => $request['activity_area'],
            //'投票项目ID' => $yearMeeting[0]['year_id'],
        );

        $create = array(
            'demand_type' => '我要办年会',
            'demand' => $demand,
            //'account_id' => $request['account_id'],
            //'ym_id' => $request['year_id'],
        );

        $demand_data = Api_Demand_Create::create($create);
        if ($demand_data['data'] == 0) {
            return Api::request('error', '', '提交失败~，请致电400-056-0599');
        }
        return Api::request('success', '', '您的合作咨询已经提交~稍后客服会和您联系，请您保持电话畅通~');
    }
}