<?php

/**
 * Created by PhpStorm.
 * User: liushengchun
 * Date: 15/3/19
 * Time: 14:16
 */
class Finance_FundAccount extends Base
{
    static function create($orderId, $fromAccountId, $toAccountId, $amount, $detail)
    {

    }


    static function getListByOrderNo($orderNo)
    {

    }


    static function getOneById($receiveId)
    {

    }

    static function getListByUnResolve($startTime, $endTime)
    {

    }

    static function resolve($receiveId)
    {

    }

    static function getListByUnAudit($startTime, $endTime)
    {

    }

    static function audit($receiveId, $status, $memo)
    {
    }

    static function getListByAudited($status, $startTime, $endTime)
    {

    }


}