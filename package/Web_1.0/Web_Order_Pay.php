<?php

q(11);
/**
 * Created by PhpStorm.
 * User: liushengchun
 * Date: 15/5/13
 * Time: 10:38
 */
class Web_Order_Pay extends Base
{
    static $banks = array(
        'b2b' => array(
//            '70' => 'bank_icbc.gif',//'工行B2B',
//            '71' => 'bank_abc.gif',//'农行B2B',
//            '82' => 'bank_ccb.gif',//'建行B2B新',
//            '78' => 'bank_cmb.gif',//'招行B2B',
//            '74' => 'bank_ceb.gif',//'光大B2B',
//            '76' => 'bank_spdb.gif',//'浦发B2B',
            '8005' => 'bank_icbc.gif',//'工行B2B',
            '8007' => 'bank_cmb.gif',//'招行借贷',
            '8108' => 'bank_abc.gif',//'农行B2B',
            '8110' => 'bank_ccb.gif',//'建行B2B新',
            '8025' => 'bank_bcom.gif',//'交行',
            '8027' => 'bank_ceb.gif',//'光大',
            '8004' => 'bank_citic.gif',//'中信',
            '8015' => 'bank_cmbc.gif',//'民生',
            '8013' => 'bank_pab.gif',//'平安银行',
            '8021' => 'bank_hxb.gif',//'华夏',
            '8022' => 'bank_spdb.gif',//'浦发B2B',
            '8023' => 'bank_boc.gif',//'中行',
            '8026' => 'bank_gdb.gif',//'广发',
            '8051' => '8051.gif',//'东亚',
            '8109' => 'bank_cib.gif',//'兴业',
            '8034' => '8034.gif',//'青岛',
            '69' => 'bank_shrcc.gif',//'上农商B2C',
            '75' => 'bank_bjrcb.gif',//'北农商B2B',
//            '81' => 'bank_sdb.gif',//'深发B2B',
        ),
        'b2c' => array(
            '23' => 'bank_cmb.gif',//'招行借贷',
            '13' => 'bank_hxb.gif',//'华夏',
            '09' => 'bank_cib.gif',//'兴业',
            '12' => 'bank_cmbc.gif',//'民生',
            '25' => 'bank_icbc.gif',//'工商行',
            '15' => 'bank_bob.gif',//'北京',
            '16' => 'bank_spdb.gif',//'浦发',
            '19' => 'bank_gdb.gif',//'广发',
            '27' => 'bank_ccb.gif',//'建设行',
            '21' => 'bank_bcom.gif',//'交行',
            '49' => 'bank_njcb.gif',//'南京银行',
            '33' => 'bank_citic.gif',//'中信',
            '45' => 'bank_boc.gif',//'中行',
            '40' => 'bank_bjrcb.gif',//'北农商',
            '36' => 'bank_ceb.gif',//'光大',
            '46' => 'bank_post.gif',//'邮储',
            '29' => 'bank_abc.gif',//'农业行',
            '50' => 'bank_pab.gif',//'平安银行',
            '51' => 'bank_hzb.gif',//'杭州银行',
            '53' => 'bank_czb.gif',//'浙商',
            '54' => 'bank_shb.gif',//'上海银行',
            '55' => 'bank_cbhb.gif',//'渤海银行',
//            '61' => '',//'PNR钱管家',
        ),
        'des' => array(
            '8005' => '中国工商银行（ B2B ）

受理对象：拥有中国工商银行企业帐户且开通了企业网上银行的企业客户
支付指引：
1 、插入经办员网银证书后，选择“ ChinaPay ”下的“工商银行 B2B ”，确认支付；
2 、通过网银证书验证后，进入支付页面，选择支付单位和支付帐号；
3 、确认支付信息后，再次选择经办员证书并输入证书密码，完成经办支付申请；
4 、插入复核员网银证书登陆企业网银，通过网银证书验证后，选择“付款业务”，点击“电子商务”项下的“批准指令”，选择日期区间和交易序号，确认支付指令信息后点击“批准”，完成支付。
特别提醒：建议在插入网银证书之前，关闭所有的浏览器窗口。
客服热线： 95588',//'工行B2B',
            '8007' => '招商银行

受理对象：拥有招商银行企业帐户且开通了企业网上银行和商务支付功能的企业客户
1、插入经办员网银证书后，选择“ ChinaPay ”下的“招商银行 B2B ”，确认支付；
2、确认订单信息后，选择“经办”；
3、通过网银证书验证后，进入支付页面，选择付款帐号和结算方式，填写用途和摘要，完成经办支付申请；
4、插入复核员网银证书登陆企业网银，通过网银证书验证后，选择需支付的订单，完成复核支付。
客服热线： 95555
特别提醒：建议在插入网银证书之前，关闭所有的浏览器窗口。',//'招行借贷',
            '8108' => '中国农业银行（B2B）

受理对象：拥有中国农业银行企业帐户并已开通企业网上银行的企业客户
支付指引：
1 、选择“ ChinaPay ”支付页面下的“企业帐户”页面，选择“农业银行 B2B ”，确认支付；
2 、插入操作员USB Key，确认订单信息后，输入企业网银经办员的USB Key用户口令，完成下单；
3 、插入经办员USB Key登陆农行B2B交易系统，选择需要支付的订单和支付帐户后，输入经办员USB Key用户口令，完成制单；
4 、插入复核员USB Key登陆农行B2B交易系统，选择需要复核的订单，确认订单支付信息后，输人复核员USB Key用户口令，完成复核；
5 、复核员返回交易系统界面， 点击“交易发送”，选择待发送的支付交易，输入复核员USB Key用户口令，完成交易发送，支付完成。
特别提醒：建议在插入USB Key之前，关闭所有的浏览器窗口。
客服热线：95599',//'农行B2B',
            '8110' => '中国建设银行（B2B）

受理对象：拥有中国建设银行企业帐户并已开通企业网上银行的企业客户
支付指引：
1 、选择“ ChinaPay ”下的“建设银行 B2B ”，确认支付；
2 、确认订单信息后，输入企业网银的客户识别号，完成下单；
3 、插入经办员网银证书登陆企业网银，点击“网上支付”，选择需要支付的订单和支付帐户后，输入经办员交易密码，完成制单；
4 、插入复核员网银证书登陆企业网银，点击“复核”项下的“网上支付审核”，选择需要审核的订单，确认订单支付信息后，选择“审核通过”，输人复核员交易密码和证书密码，完成支付。
特别提醒：建议在插入网银证书之前，关闭所有的浏览器窗口。
客服热线： 95533',//'建行B2B新',
            '8025' => '交通银行（B2B）

受理对象：拥有交通银行企业帐户且开通了“B2B买方业务”功能的企业客户
支付指引：
1 、商户确定订单后，进入“ ChinaPay ”支付页面，并选择“企业账户”下的“交通银行 B2B ”，进行支付；
2 、输入支付帐号后，插入经办员网银证书，进入网银支付页面，选择支付单位和支付帐号；
3 、点击“专项服务区”菜单，选择“电子商务”，并进入“B2B买方业务”频道，在“订单付款录入”中完成交易订单的信息补全；
4 、选择您需要支付的订单，并点击“付款”，“确定”，完成经办员操作部分；
5 、商户使用复核员权限用户登录交通银行网银，同样点击“专项服务区”菜单，选择“电子商务”，并进入“B2B买方业务”频道，对订单进行授权；
6 、完成整笔B2B订单的支付。
交通银行24小时客服热线： 95588。',//'交行',
            '8027' => '中国光大银行（B2B）

受理对象：拥有中国光大银行企业帐户、开通了企业网上银行且已设置电子支付帐户的企业客户
支付指引：
1、插入经办员网银证书后，选择“ChinaPay”下的“光大银行B2B”，确定支付；
2、通过网银证书验证后，进入支付页面，选择“电子支付”项下的“待支付订单信息”，选择需要支付的订单后点击“支付”；
3、确定支付信息后，点击“确认”，完成待支付订单的录入；
4、插入复合员网银证书登录企业网银，通过网银证书验证后，选择“交易审核”项下的“转帐类交易审核”，选择需要审核的订单后点击“同意”，完成支付。
特别提醒：建议在插入网银证书之前，关闭所有的浏览器窗口。
客服热线：95595。',//'光大',
            '8004' => '中信银行B2B

1、登录中信银行企业网银
2、选择支付帐号，确认订单信息，进行支付办理
3、登录企业“网上银行客户端”
4、在“B2B”栏目下选择“交易审核”
5、查询交易后进行复核，支付完成
客服热线：95558',//'中信',
            '8015' => '民生银行(B2B)

受理对象：开通了民生银行网上银行B2B支付功能的企业客户
支付指引：
1、选择“ ChinaPay ”支付页面下的“企业帐户”页面，选择“民生银行 B2B ”，确认支付；
2、插入经办员USB Key,确认订单信息后，输入网银客户号和操作员号，登入网上银行；
3、企业网银经办员登录成功后，进入“B2B企业服务”对订单进行确认，并输入交易密码，完成订单；
4、企业网银复核员（具备“授权”权限）登录网银，进入“授权”，输入密码以及必要信息，授权改笔订单，直至交易成功。
特别提醒：建议在插入USB Key之前，关闭所有的浏览器窗口
民生银行24小时客户热线：95568',//'民生',
            '8013' => '平安银行（B2B）

受理对象：拥有平安银行企业帐户且开通了企业网上银行的企业客户
支付指引：
1、插入经办员网银证书后，选择"ChinaPay "下的"平安银行 B2B"，确认支付；
2、进入企业网银后，输入用户名、登录密码、验证码及PIN并确认订单信息；
3、确认支付信息后，点击"确认"后指令入录成功；
4、插入复核员网银证书登入企业网银，通过网银证书验证后，选择"交易授权"中"授权人员复核授权"，确认信息后点击"复核通过"。
5、插入授权人网银证书登入企业网银，通过网银证书验证后，选择"交易授权"中"授权人员复核授权"，确认信息后点击"授权通过"后交易成功。
特别提醒：建议在插入网银证书之前，关闭所有的浏览器窗口。
客服热线：95511*3',//'平安银行',
            '8021' => '华夏银行(B2B)

受理对象：拥有华夏银行企业帐户并已开通企业网上银行并开通B2B功能的企业客户
支付指引：
1、选择“ ChinaPay ”支付页面下的“企业帐户”页面，选择“华夏银行 B2B ”，确认支付；
2、插入华夏盾，弹出华夏银行网站首页，点击网站首页左下方“B2B网上支付”下的“登录地址”，在B2B登录页面点击“直接支付模式”下的“企业登录” 并输入经办人代码或别名、登录密码后登录。
3、经办人选择 “交易录入”菜单，显示待处理交易列表; 点击“详细资料”按钮，查看订单详细信息，核对无误后点击“确定”按钮进行交易确认。
4、插入复核员USB Key登陆华夏银行B2B交易系统，选择“交易授权”菜单，显示待授权的交易列表；点击“详细资料”按钮，查看订单详细信息，核对无误后点击“确定”按钮即交易完成。
特别提醒：建议在插入USB Key之前，关闭所有的浏览器窗口。
客服热线：95577',//'华夏',
            '8022' => '上海浦东发展银行(B2B)

业务开通：
1、登录浦发网银，选择“网银管理“-”操作员管理”，将“电子商务支付”功能选中。
2、若企业管理需要，在经办人员操作BtoB支付请求后，还需要授权才能正式进行支付款项，则还需要修改“网银管理”-“授权模式设置”的“电子商务支付”模式。
3、在以上设置修改后，需要网银管理员登录公司网银对刚才的设置进行确认。

支付流程：
1、填写买方客户号，发送信息。
2、订单页面显示订单号、交易时间、商户名称、交易金额等信息。登录公司网银，系统显示“网上支付确认”界面。
3、操作员下拉选择”付款帐号”，审核订单号，交易金额，商户名称等信息，按“确定”按钮提交，系统显示“交易结果信息”。
4、根据“网银管理”->“授权模式设置”模块中对“网上支付”交易类型的设置，若设为“不需要授权”，则网上支付交易完成时，系统直接进行支付帐务处理，否则需授权操作员登录公司网银，进行授权确认后才发生帐务。

注意事项：
若帐户余额不足等原因导致无法支付，企业客户可立刻调拨资金或选择另外帐户来支付。对同一笔订单，客户最多可尝试三次支付。
客服电话：95528',//'浦发B2B',
            '8023' => '中国银行(B2B)
业务开通：
企业需开通网上支付功能，到银行柜台办理业务需要的材料包括：营业执照、组织机构代码证、操作员身份证、经办人身份证。（由于区域不同，请在办理网上支付业务前咨询开户行的客户经理）。


支付流程：
1、企业网银操作员（具备“B2B订单采购”权限）在网上商城上选择商品或服务，生成订单，并选择“中国银行”进行在线支付，将生成支付页面。操作员输入信息进行登录。用户登录成功后，对订单进行确认，并输入动态口令，完成订单采购过程。
2、企业网银操作员（具备“B2B订单复核”权限）登录网银，在“电子商务”-“B2B支付服务”下选择“订单复核”，进入“待复核订单”页面，系统显示用户有权限查看的所有待复核订单列表。用户对采购完成的订单进行复核，点击“订单号”进入“需要复核的订单”页面，用户选择付款人账号，完成复核。
3、企业网银操作员（具备“B2B订单授权”权限）登录网银，在“电子商务”-“B2B支付服务”下选择 “订单授权”，进入“待授权订单”页面，系统显示用户有权限查看的所有待授权订单列表。用户对复核通过的订单进行授权，点击“订单号”进入“需要授权的订单”页面，用户确认订单输入动态口令完成授权。授权通过后，进入“授权结果”页面。
4、企业网银操作员（具备“B2B订单查询”权限）登录网银，进入“B2B支付服务”-“订单查询”，可对订单信息进行查询。如下图所示，可进行单笔订单查询和多笔订单查询。

客服电话：95566',//'中行',
            '8026' => '广发银行(B2B)

业务开通：
1、企业需在广发银行电子支付平台系统开通对公账户支付功能，到银行柜台办理业务需要的材料包括：申请表、营业执照正本复印件、组织机构代码证复印件、法人身份证复印件、经办人身份证复印件、管理员身份证复印件、法人授权书。（由于区域不同，请在办理业务前咨询开户行的客户经理）。
2、企业完成对公账户支付功能开通后，需登录广发银行主页（www.cgbchina.com.cn）,在“在线快捷服务”框架下选择“对公支付密码管理”，完成对公支付初始密码修改。（如U-key密码为初始密码，需要先行进行变更）

支付流程：
1、企业在网上商城上选择商品或服务，生成订单，并选择“广发银行”进行在线支付，跳转至广发银行支付页面。
2、企业操作员输入支付账号信息进行登录。
3、企业登录成功后，对订单进行确认，输入支付密码和登录密码，通过U-KEY操作确认后，完成支付。

客服电话：4008308003',//'广发',
            '8051' => '东亚银行(B2B)

业务开通：
企业需开通网上支付功能，到银行柜台办理业务需要的材料包括：营业执照、组织机构代码证、操作员身份证、经办人身份证。（由于区域不同，请在办理网上支付业务前咨询开户行的客户经理）。

支付流程：
1、 企业网银操作员（具备"B2B支付"权限）在网上商城上选择商品或服务，生成订单，并选择"东亚银行"进行在线支付，将生成支付页面。操作员输入信息进行登录。用户登录成功后，点击"电子商务"中"B2B支付"，对订单进行确认，并输入支付密码，选择是否通知划款人，完成后点击"提交"即完成支付录入。
2、 企业网银操作员（具备"B2B复核"权限）登录网银，在"网银管理"-"授权中心"下选择"待授权交易查询"，点击"操作栏"里"授权"。对订单进行确认后，点击"确认"跳转至"您的授权指令已受理"页面，即完成支付。
客服电话：4008888338',//'东亚',
            '8109' => '兴业银行（B2B）

业务开通：
企业需首先在兴业银行开立活期账户，然后到开户网点领取并填写《兴业银行网上企业银行服务申请表》、《兴业银行网上企业银行服务协议》和《兴业银行网上企业银行客户证书申请表》，并提供营业执照正本或副本复印件、网上银行主管和管理员用户的身份证原件及复印件等资料。银行审核客户提交的资料，并办理网上银行开户手续：柜面人员为客户开通网上银行并打印主管和管理员密码信封，申请预制网盾证书等，完成业务开通。

支付流程：
1、企业网银网上采购员在网上商城上选择商品或服务，生成订单，并选择“兴业银行”进行在线支付，将生成支付页面。采购员在兴业银行页面输入采购员登录名、企业网银密码，确认下单信息。
2、经办人员登录网银，在“企业财务室”-“B2B支付”-“生成指令”下，选择需要支付的指令及选择要支付的账户，指定下一处理人“复核”，点击“提交”，完成经办。
3、复核人员登录网银，在“企业财务室”-“B2B支付”-“复核B2B网上支付指令”下，选择指定下一处理人“授权”，再点击“复核”，完成复核。
4、授权人员登录网银，在“企业财务室”-“B2B支付”-“授权B2B网上支付指令”下，选中要授权的指令，点击“授权”按钮，再点击“确定”按钮，Z最后点击“签名确认”，完成授权，支付成功。
客服电话：95561',//'兴业',
            '8034' => '青岛银行(B2B)

业务开通：
企业首次申请青岛银行企业网上银行应到企业账户的开户网点办理，并提供以下资料：
1、填写完整的《青岛银行网上银行企业客户注册申请表》一式三份，加盖单位公章预留银行印鉴，并保证内容的真实性；
2、提供营业执照正本或副本及复印件（或其他认可的开户有效证件原件及复印件）；
3、组织机构代码证原件及复印件（或其他认可的开户有效证件原件及复印件）；
4、法人代表身份证原件及复印件，委托他人办理的还应提供法人代表授权委托书和经办人身份证件原件及复印件；

支付流程：
1、企业网上采购员在网上商城上选择商品或服务，生成订单，并选择“青岛银行”进行在线支付，将生成支付页面。采购员插入Ukey，在青岛银行页面输入Ukey密码和附加码，点击登录，订单确认成功。
2、企业财务人员登录网银，在“电子商务”-“网上支付”-“买方订单管理”下，输入查询条件，点击查询；在查询结果中选择需要支付的订单，点击“订单付款”；在付款页面确认信息无误后从下来框选择付款账号，点击“提交”，交易成功提交审核人员。
3、企业审核人员登录网银，在“交易管理”-“待审核业务”下，选择待授权类型为“电子商务”的交易，点击进入“电子商务授权列表”，勾选需要审核的交易，点击“同意”，完成审核，支付成功。

客服电话：96588(青岛) 400-66-96588(全国)',//'青岛',
        )
    );

    static function handleSelectBank($payment)
    {
        $_REQUEST['tab'] = 7;
        Web_Account::handleIsLogin();
        Web_Order_Info::handle($payment['payment_detail']['order_no']);
        $account = Finance_Account::getAccountInfo($_SESSION['user']['id']);
        Tpl_Smarty::assign('banks', self::$banks);
        Tpl_Smarty::assign('account', $account);
        Tpl_Smarty::assign('__user', $_SESSION['user']);
        Tpl_Smarty::assign('payment', $payment);
        Tpl_Smarty::assign('orderinfo', Web_Order_Info::$_orderInfo);
        Tpl_Smarty::display('Web', 'order-info.tpl');
    }

    static function handlePay($payment)
    {
        Web_Account::handleIsLogin();
        $request = Func_Input::filter(array(
            'bank' => 'int',
        ));
        $paymentOrderId = str_pad($payment['account_id'], 8, '0', STR_PAD_LEFT) . date("md") . str_pad($payment['id'], 4, '0', STR_PAD_LEFT);
        //Agent:user1:50.00;Agent:user2:800.00
        //1.商户号请填入你从汇付获得的六位商户号.<br>
        //2.订单号请与贵网站系统中的唯一订单号匹配.<br>
        //3.页面返回地址--当支付完成后跳转回贵网站系统的页面地址.<br>
        //4.后台返回地址--当支付完成后异步返回贵网站系统的地页面地址.<br>
        //5.网关号--当输入此项后，支付页面将直接跳转到网关号所对应的银行支付页面（您可向客服人员索取网关号）.<br>
        //6.分账明细--当存在一笔支付金额分发给不同的商户时使用，无此情况请留空.<br>
        //7.付款人用户号--如果付款人在汇付有账号，请填入此项.
        if ($request['bank'] > 1000) { //银联
            Payment_UnionPay_Buy::handle($paymentOrderId, $payment['amount'], $payment['order_id'], $_SESSION['user']['phone'], "http://" . Core::$urls['host'] . '/' . Core::$urls['route'] . 'return/' . $payment['payment_id'], "http://" . Core::$urls['host'] . '/' . Core::$urls['route'] . 'notify/' . $payment['payment_id'],
                '', $request['bank']);
        } else {
            Payment_Pnr_Buy::handle($paymentOrderId, $payment['amount'], $payment['order_id'], $_SESSION['user']['phone'], "http://" . Core::$urls['host'] . '/order_pay/return/' . $payment['payment_id'], "http://" . Core::$urls['host'] . '/order_pay/notify/' . $payment['payment_id'], '', $request['bank']);
        }
    }
    static function handleReturn($payment)
    {
        Web_Account::handleIsLogin();
        if (!empty($_POST['CuryId'])) {
            $return = Payment_UnionPay_Buy::checkReturn();
        } else {
            $return = Payment_Pnr_Buy::checkReturn();
        }
        q('付款结果:' . $return);
        if ($return) {
            $paymentOrderId = $_POST['OrdId'];
            $paymentId = intval(substr($paymentOrderId, -9));
            if (!$paymentId || $paymentId != $payment['id'] || empty($_POST['Pid']) || $_POST['Pid'] != $payment['order_id']) {
                Func_Header::notFound();
            }
            self::handlePaymentUpdate($payment);
            Func_Header::to('付款成功!', Core::$urls['root'] . 'order_info/' . $payment['payment_detail']['order_no']);
        } else {
            Func_Header::notFound();
        }
    }

    static function handleNotify($payment)
    {
        if (!empty($_POST['CuryId'])) {
            $return = Payment_UnionPay_Buy::checkNotify();
        } else {
            $return = Payment_Pnr_Buy::checkNotify();
        }
        if ($return) {
            $paymentOrderId = $_POST['OrdId'];
            $paymentId = intval(substr($paymentOrderId, -9));
            if (!$paymentId || $paymentId != $payment['id'] || empty($_POST['Pid']) || $_POST['Pid'] != $payment['order_id']) {
                Func_Header::notFound();
            }
            self::handlePaymentUpdate($payment);
            Finance_Payment::updatePaymentTime($payment['payment_id']);
        }
    }

    static function handlePaymentUpdate($payment)
    {
        $r = Finance_Payment::updatePaymentTime($payment['payment_id']);
        if ($r && !empty($payment['payment_detail']['payment_title']) && !empty($payment['order_id'])) {
            //更新订单已支付金额
            Data_Mysql_Table_Order_Info::update($payment['order_id'], array(
                'order_price_pay = order_price_pay+?' => $payment['amount'],
            ));
            //判断是否第一笔付款
            if (!empty($payment['payment_detail']['is_first']) || intval($payment['payment_detail']['payment_title']) == 1) {
                //收取经纪人佣金.
                if (!empty($payment['payment_detail']['deal_account_id']) && !empty($payment['payment_detail']['order_commission_deal'])) {
                    //从余额中扣除佣金
                    /*
                     *      (n    >   供应商账户)                              --------订单佣金-------->                       (n    >   推广人员账户)
                     */
                    $payment['payment_detail'] = $payment['agreement_title'] . " - 经纪人佣金";
                    Finance_Account::addDetail($payment['payment_detail']['deal_account_id'], $payment['payment_detail']['vendor_account_id'], $payment['payment_detail']['order_commission_deal'], '经纪人佣金', $payment['payment_id'], $payment['payment_detail']);
                }
            }
        }
    }
}