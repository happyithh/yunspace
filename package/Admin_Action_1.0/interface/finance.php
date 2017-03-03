<?php
/**
 * Created by PhpStorm.
 * User: liushengchun
 * Date: 15/4/2
 * Time: 19:54
 */
switch (Core::$urls['action']) {
    //汇付收款对账
    case 'income_check/pnr':
        OA_Finance_Income::handlePnr();
        break;
    // 快钱收款对账
    case 'income_check/99bill':
        break;
    //提现代发对账
    case 'cash_check/pnr':
        OA_Finance_Cash::handlePnr();
        break;
    //平台收支统计
    case 'global_static':
        OA_Finance_Income::handleAll();
        break;
    //自动提现
    case 'auto_cash':
        OA_Finance_Auto_Cash::handle();
        break;
}