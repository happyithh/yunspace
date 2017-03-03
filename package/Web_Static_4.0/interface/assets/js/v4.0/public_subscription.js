(function(doc,win,$){
	$(function(){
		var $$={
			subCode:$(".sub-code"),
			subSubmit:$(".sub-submit"),
			subClose:$(".sub-close"),
			subscription:$(".subscription"),
			subOpen:$(".sub-open"),
			subSelectList:$(".sub-select-list"),
			subSelect:$(".sub-select"),
			resend:$(".resend"),
			subPhone:$(".sub-phone"),
			sendTime:$(".send-time"),
			subError:$(".sub-error"),
			publicFixedRight:$(".public-fixed-right"),
			pfrCode:$(".pfr-code"),
			pfrPhone:$(".pfr-phone"),
			pfrTable:$(".pfr-table"),
			pfrTab:$(".pfr-tab"),
			pfrDiv:$(".pfr-div"),
			pfrSubmit:$(".pfr-submit"),
			pfrPhone2:$(".pfr-phone-2"),
			pfrCode2:$(".pfr-code-2"),
			pfrError:$(".pfr-error"),
			pfcB1:$(".pfc-tc-0-b1"),
			pfcB0:$(".pfc-tc-0-b0"),
			publicFixedCenter:$(".public-fixed-center"),
			pfcTcClose:$(".pfc-tc-close"),
			pfcTc1Button:$(".pfc-tc-1-button"),
			pfcTableCell:$(".pfc-table-cell"),
			pfcCodeDiv:$(".pfc-code-div"),
			pfcError:$(".pfc-error"),
			pfcTc1Input:$(".pfc-tc-1-input"),
			pfcRelative:$(".pfc-relative"),
			lookedSpace:$("#looked-space"),
			pfcLookSpace:$("#pfc-look-space")
		};
		var f={
			sendCoded:false,
			logined:false,
			subData:{
				cate:"",
				phone:"",
				code:"",
			},
			siteBikeLook:{},
			prcShowField:{},
			subscriptionClosed:false,
			sended:false,
			init:function(){
				var wh=$(window).height(),subShow=false,stopTime = null,canAutoScroll = true;
				var beforeSt="",afterSt="",stop=false;
				setInterval(function(){
					var st=$(this).scrollTop();
					if(st>=600){
						if(subShow==true){
							return;
						}
						subShow=true;
						$$.subscription.css({
							display:"block"
						});
					}else{
						if(subShow==false){
							return;
						}
						subShow=false;
						f.subscriptionClosed=false;
						stop=false;
						$$.subscription.css({
							display:"none"
						}).removeClass('subscription-closed');
					}
				},10);
				var t1=null;
				$(window).on('scroll',function(){
					if(!subShow|| f.subscriptionClosed)return;
					if(subShow){
						if(t1!=null){
							clearTimeout(t1);
						}
						t1=setTimeout(function(){
							stop=true;
						},1000);
					}
					if(!stop)return;
					$$.subscription.addClass('subscription-closed');
					f.subscriptionClosed=true;
					//if(stopTime!=null){
					//	clearTimeout(stopTime);
					//}
					//beforeSt=$(window).scrollTop();
					//stopTime=setTimeout(function(){
					//	afterSt=$(window).scrollTop();
					//	if(beforeSt==afterSt){
					//		$$.subscription.addClass('subscription-closed');
					//		f.subscriptionClosed=true;
					//	}
					//},500);
				});

				if(window.location.href.indexOf('/site')>-1){
					$("#pfr-code").qrcode({
						//render: "table", //table方式
						width: 120, //宽度
						height:120, //高度
						text: window.location.href //任意内容
					});
				}
				var fix_right=localStorage.getItem('fix_right');
				if(fix_right!=undefined){
					//$$.pfrTable.addClass('none');
				}else{
					localStorage.setItem('fix_right','true');
				}
				if($$.subscription.data('user')){
					f.logined=true;
					f.sendCoded=true;
				};
				f.showSendCode().checkAuthCode().toggleSub().subSelect().sendCode().hoverPfrHover()
					.pfrNext();
					//.closeCenter().toFirstCenter().pfcShow();
			},
			showSendCode:function(){
				$$.subSubmit.on("click",function(){
					if(!f.sendCoded){
						f.sendCoded=true;
						$(this).text('提交');
						$$.subCode.find('input').addClass("sub-code-active");
						setTimeout(function(){
							$$.subCode.find('.resend').removeClass("none2");
							$$.resend.trigger("click");
						},450);
					}else{
						var phone=$$.subPhone.find('input').val();
						var _selected = $$.subSelect.find('span').text();
						if(_selected=="请选择活动专题"){
							$$.subError.text('请选择活动专题！！').addClass("sub-error-active");
							return;
						}
						if(!f.isMobile(phone)){
							$$.subError.text('手机号码格式不正确！！').addClass("sub-error-active");
							return;
						}
						var _data = [], _key = [];
						var _phone = $$.subPhone.find('input').val();
						var _auth_code = $$.subCode.find('input').val();
						var isExist=$(".sub-code-active").attr('type');
						if(isExist && !_auth_code){
							$$.subError.text('填写验证码！').addClass("sub-error-active");
							return f;
						}
						_key[0] = '订阅类型'
						_key[1] = '联系方式'
						_data[0] = _selected
						_data[1] = _phone
						$.ajax({
							url: 'http://' + window.location.host + '/form',
							data: {
								id: 17,        //通用表单
								data: _data,
								key: _key,
								phone:_phone,
								auth_code:_auth_code,
								form_type: 1
							},
							dataType: "json",
							success: function (data) {
								//$$.subPhone.find('input').val("");
								$$.subCode.find('input').val("");
								$$.subscription.addClass('subscription-closed');
								$$.resend.addClass('none2');
								$$.sendTime.addClass('none2');
								$$.subCode.find('input').removeClass("sub-code-active");
								$$.subSubmit.text('订阅+');
								$$.subError.removeClass("sub-error-active");
								f.sended=false;
								f.sendCoded=false;
								clearInterval(window.sendCodeTime);
								setTimeout(function(){
									alert(data.msg);
								},800);
							}
						});
					}
				});
				return f;
			},
            checkAuthCode:function(){
                $$.subCode.find('input').bind('keyup',function(){
                var _auth_code = $(this).val()
                var _phone = $$.subPhone.find('input').val()
                if(_auth_code.length ==6){
                    YunSpace.api('common/check/auth/code.json',{
                        phone: _phone,
                        auth_code:_auth_code
                    },function (data){
                        if(data.status==0){
                            $$.subError.text('验证码错误！').addClass("sub-error-active");
                        }
                    });
                }
            })
                return f;
            },
			sendCode:function(){
				$$.resend.on("click",function(){
					var $this=$(this);
					var phone=$$.subPhone.find('input').val();
					f.handleSendCode($this,phone,$$.sendTime);
				});
				return f;
			},
			toggleSub:function(){
				$$.subClose.on("click",function(){
					$$.subscription.addClass("subscription-closed");
					f.subscriptionClosed=true;
				});
				$$.subOpen.on("click",function(){
					$$.subscription.removeClass("subscription-closed");
					f.subscriptionClosed=false;
				});
				return f;
			},
			subSelect:function(){
				$$.subSelectList.find('ul li').each(function(index,dom){
					var $dom=$(dom);
					$dom.on("click",function(){
						f.subData.cate=$dom.text();
						$$.subSelect.find('p > span').text($dom.text()).css('color',"#222222");
					});
				});
				return f;
			},
			isMobile:function(phone){
			    if(phone==null)return false;
			    var exp= /^(0|86|17951)?(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$/;
			    if(exp.test(phone)){
			        return true;
			    }else{
			        return false;
			    }
			},
			handleSendCode:function(clickObj,phone,showTimeObj){
		        if (!phone||!isMobile(phone)) {
		            $$.subError.text('手机号码格式不正确！！').addClass("sub-error-active");
		            return false;
		        }
		        if(f.sended){
		        	return;
		        }
		        f.sended=true;
		        f.subData.phone=phone;
		        $$.subError.removeClass("sub-error-active");
		        clickObj.addClass('none2');
		        showTimeObj.removeClass('none2');
		        var second =60;
		        var urlPath ="common/send/auth/code.jsonp";
		        window.sendCodeTime = setInterval(function (e) {
		            second--;
		            var info = second + "s";
		            showTimeObj.text(info);
		            if (second < 1) {
		                clickObj.removeClass('none2');
		                showTimeObj.addClass('none2');
		                f.sended=false;
		                clearInterval(window.sendCodeTime);
		            }
		        }, 1000);
		        YunSpace.api(urlPath,{
		            phone: phone,
		            auth_code_img: ''
		        },function(data){
		            //console.log(data.msg);
		        })
			},
			// pfr的js
			hoverPfrHover:function(){
				$$.pfrCode.hover(function(){
					doPfrCode();
				},function(){
				});
				function doPfrCode(){
					$$.pfrCode.addClass("pfr-code-active");
					$$.pfrError.addClass('none');
					//$$.pfrPhone.removeClass("pfr-phone-active");
					//if($$.pfrTable.hasClass('none')){
					//	$$.pfrTable.removeClass('none');
					//}
					$$.pfrTab.find("li").removeClass('pfr-tab-active');
					$$.pfrTab.find("li").eq(1).addClass('pfr-tab-active');
					$$.pfrDiv.eq(0).addClass('none');
					$$.pfrDiv.eq(1).removeClass('none');
				}
				function doPfrPhone(){
					$$.pfrPhone.addClass("pfr-phone-active");
					$$.pfrError.removeClass('none');
					$$.pfrCode.removeClass("pfr-code-active");;
					//if($$.pfrTable.hasClass('none')){
					//	$$.pfrTable.removeClass('none');
					//}
					$$.pfrTab.find("li").removeClass('pfr-tab-active');
					$$.pfrTab.find("li").eq(0).addClass('pfr-tab-active');
					$$.pfrDiv.eq(1).addClass('none');
					$$.pfrDiv.eq(0).removeClass('none');
				}
				$$.pfrPhone.hover(function(){
					doPfrPhone();
				},function(){
					$$.pfrPhone.removeClass("pfr-phone-active");
				});
				$$.pfrTab.find("li").each(function(index,dom){
					var $dom=$(dom);
					$dom.hover(function(){
						if(index==0){
							doPfrPhone();
							return;
						}
						if(index==1){
							doPfrCode();
							return;
						}
					},function(){})
				});
				$$.publicFixedRight.hover(function(e){
				},function(){
					//$$.pfrTable.addClass('none');
				});
				return f;
			},
			pfrNext:function(){
				var next=false;
				if(f.logined){
					next=true;
					$$.pfrSubmit.find('button').text('提交');
				}
				$$.pfrSubmit.find('button').on("click",function(){
					if(next==false){
						var phone=$("#pfr-phone").val();
						if(f.isMobile(phone)){
							next=true;
							$$.pfrCode2.removeClass('none').find('.pfr-send-code').trigger('click');
							$$.pfrSubmit.find('button').text('提交');
						}else{
							$$.pfrError.text("手机号码格式不正确！！").addClass('pfr-error-active');
							setTimeout(function(){
								$$.pfrError.removeClass('pfr-error-active');
							},3000);
						}
					}else{
						//右侧场地数据带着走
						var phone=$("#pfr-phone").val();
						if(!f.isMobile(phone)){
							$$.pfrError.text("手机号码格式不正确！！").addClass('pfr-error-active');
							setTimeout(function(){
								$$.pfrError.removeClass('pfr-error-active');
							},3000);
							return;
						}
                        var _data = [], _key = [];
                        var _auth_code= $$.pfrCode2.find('input').val();
                        var _phone= $$.pfrPhone2.find('input').val();
                        _key[0] = '联系方式'
                        _key[1] = '百科链接'
                        _data[0] =_phone
                        _data[1] = window.location.href
                        $.ajax({
                            url: 'http://' + window.location.host + '/form',
                            data: {
                                id: 18,        //通用表单
                                data: _data,
                                key: _key,
                                phone:_phone,
                                auth_code:_auth_code,
                                form_type: 1
                            },
                            dataType: "json",
                            success: function (data) {
								$("#pfr-phone").val("");
								$(".pfr-code-2").val("");
                                alert(data.msg);
                            }
                        });
						// 验证码报错（请请求后执行）
						// var code=$$.pfrCode2.find('input').val();
						// if(!code){
						// 	$$.pfrError.text("验证码不正确！").addClass('pfr-error-active');
						// 	setTimeout(function(){
						// 		$$.pfrError.removeClass('pfr-error-active');
						// 	},3000);
						// }
					}
				});
				return f;
			},
			// pfc:中间部分
			closeCenter:function(){
				$$.pfcB0.on("click",function(){
 					publicFixedCenterHide();
				});
				$$.pfcTcClose.on('click',function(){
	               publicFixedCenterHide();
				});
				// $(document).on('click',function(e){
				// 	if($(e.target).closest("pfc-table-cell").length==0){
				// 		publicFixedCenterHide();
				// 	}
				// })
				function publicFixedCenterHide(){
					$$.publicFixedCenter.addClass('none');
				}
				return f;
			},
			toFirstCenter:function(){
				var next=false;
				if(f.logined){
					next=true;
					$$.pfcTc1Button.text('提交');
				}
				$$.pfcB1.on("click",function(){
					$(".pfc-tc-0,.pfc-tc-2").addClass('none');
					$(".pfc-tc-1").removeClass('none');
					$$.pfcTableCell.addClass("pfc-table-cell-h");
				});
				$$.pfcTc1Button.on('click',function(){
					var phone=$("#pfc-phone").val();
					var name=$("#pfc-username").val();
					var auth_code=$("#pfc-code").val();
					if(next==false){
						// $$.pfcError.removeClass('none');
						if(f.isMobile(phone)){
							next=true;
							$$.pfcTc1Input.eq(2).removeClass('none');
							$$.pfcCodeDiv.find('button').trigger('click');
							$$.pfcTc1Button.text('提交');
						}else{
							$$.pfcError.text("手机号码格式不正确！！").addClass('pfc-error-active');
							setTimeout(function(){
								$$.pfcError.removeClass('pfc-error-active');
							},3000);
						}
					}else{
						if(name==""){
							$$.pfcError.text("您的称呼未填写！！").addClass('pfc-error-active');
							setTimeout(function(){
								$$.pfcError.removeClass('pfc-error-active');
							},3000);
							return;
						}
						if(!f.isMobile(phone)){
							$$.pfcError.text("手机号码格式不正确！！").addClass('pfc-error-active');
							setTimeout(function(){
								$$.pfcError.removeClass('pfc-error-active');
							},3000);
							return;
						}
						YunSpace.api('demand/create.json',{
							name:name,
							phone:phone,
							auth_code:auth_code,
							action:'baike_popup_form',
                            showString: f.getLocationStorageSiteHistory(),
						},function(data){
							//console.log(data);
							$("#pfc-phone").val("");
							$("#pfc-username").val("");
							$("#pfc-code").val("");
                            alert(data.msg);
                            if(data.status==1){
                                window.location.reload();
                            }
                        });
						// 验证码报错（请请求后执行）
						// var code=$("#pfc-code").val();
						// if(!code){
						// 	$$.pfcError.text("验证码不正确！").addClass('pfc-error-active');
						// 	setTimeout(function(){
						// 		$$.pfcError.removeClass('pfc-error-active');
						// 	},3000);
						// }
					}
				});
				return f;
			},
			pfcShow:function(){
				if(window.location.href.indexOf("site")>-1){
					/*对url进行分析,如果是当前页多次刷新则返回*/
					var localHref= f.getLocationStorageHref();
					if(localHref==undefined){
						f.setLocationStorageHref(window.location.href)
					}else{
						var localHrefArr="";
						if(localHref.indexOf(",")>-1){
							localHrefArr=localHref.split(",");
						}else{
							localHrefArr=localHref;
						}
						if(localHrefArr.indexOf(window.location.href)>-1){
							return;
						}else{
							var localHrefs="";
							if(typeof localHref=='object'){
								localHrefs=localHref.join(",");
							}else{
								localHrefs=localHref;
							}
							localHrefs=localHrefs+","+window.location.href;
							f.setLocationStorageHref(localHrefs);
						}
					}
					/*处理获取当前的纬度,本地存储*/
					var siteLocal=f.getLocationStorageSite();
					var siteVal=$$.lookedSpace.val();
					siteVal=siteVal.split(",,");
					if(siteLocal==undefined){
						f.siteBikeLook.square=parseInt(siteVal[0]||0);
						f.siteBikeLook.address=siteVal[1].replace(/\s+/g,"");
						f.siteBikeLook.type=siteVal[2];
						f.siteBikeLook.price=parseInt(siteVal[3]||0);
						f.setLocationStorageSite(f.siteBikeLook);
					}else{
						//f.siteBikeLook=siteLocal;
						f.siteBikeLook.square=siteLocal.square+","+parseInt(siteVal[0]||0);
						f.siteBikeLook.address=siteLocal.address+","+siteVal[1].replace(/\s+/g,"");
						f.siteBikeLook.type=siteLocal.type+","+siteVal[2];
						f.siteBikeLook.price=siteLocal.price+","+parseInt(siteVal[3]||0);
						f.setLocationStorageSite(f.siteBikeLook);
						f.isShowPfc();
					}
				}
				return f;
			},
			isShowPfc:function(){
				if(f.getLocalStorageBaikeLookStatus()==1){
					return false;
				}
				var squareArr=f.siteBikeLook.square.split(",");
				var addressArr=f.siteBikeLook.address.split(",");
				var typeArr=f.siteBikeLook.type.split(",");
				var priceArr=f.siteBikeLook.price.split(",");
				//console.log(f.siteBikeLook.price);
				if(squareArr.length!=3){
					return;
				}
				//for(var i in squareArr){
				//	var c=countArr(squareArr[i],squareArr);
				//	if(c>1){
				//		f.prcShowField.square=squareArr[i];
				//	}
				//}
				var addressCount={},typeCount={};
				for(var i in addressArr){
					var c=countArr(addressArr[i],addressArr);
					if(c>1){
						addressCount[addressArr[i]]=c;
						f.prcShowField.address=addressArr[i];
					}
				}
				for(var i in typeArr){
					var c=countArr(typeArr[i],typeArr);
					if(c>1){
						typeCount[typeArr[i]]=c;
						f.prcShowField.type=typeArr[i];
					}
				}
				f.prcShowField.price=sortArr(priceArr);
				f.prcShowField.square=sortArr(squareArr);
				//f.prcShowField.address=sortArrTwo(addressCount);
				//f.prcShowField.type=sortArrTwo(typeCount);
				//console.log(f.prcShowField);
				f.prcShowField.address=(f.prcShowField.address!=undefined&f.prcShowField.address!="")?'"'+f.prcShowField.address+'地区"':"";
				f.prcShowField.square=(f.prcShowField.square!=undefined&f.prcShowField.square!="")?',"面积'+f.prcShowField.square+'㎡以上"':"";
				f.prcShowField.type=(f.prcShowField.type!=undefined&f.prcShowField.type!="")?',"类型为'+f.prcShowField.type+'"':"";
				f.prcShowField.price=(f.prcShowField.price!=undefined&f.prcShowField.price!="")?',"价格'+f.prcShowField.price+'元以上"':"";
				var fieldStr=f.prcShowField.address+f.prcShowField.type+f.prcShowField.square+f.prcShowField.price;
				if(fieldStr[0]==","){
					fieldStr=fieldStr.substr(1);
				}
				var siteData =f.getLocationStorageSite();
				var condition =f.prcShowField;
				YunSpace.api('baike/get/pop/popup/form/data.json',{
					data:{
						square:siteData.square,
						city:siteData.address,
						type:siteData.type,
						price:siteData.price
					},
					condition:{
						square:condition.square,
						city:condition.address,
						type:condition.type,
						price:condition.price
					}
				},function(data){
						//console.log(data);
					data.data=2;
					f.setLocalStorageBaikeLookStatus(1);
					f.setLocationStorageSiteHistory(fieldStr);
					$$.publicFixedCenter.removeClass('none');
					$$.pfcLookSpace.html('你正在浏览<span>' + fieldStr + '</span>的场地,预计结果有<code>'+data.data+'</code>个场地符合您的意向!');

				});
				function countArr(v,arr){
					var count=0;
					for(var i in arr){
						if(arr[i]==v){
							count++;
						}
					}
					return count;
				}
				function sortArr(priceArr){
					var priceMin="";
					for(var i in priceArr){
						if(priceArr[i]!=""&&priceArr[i]!=0&&priceMin==""){
							priceMin=parseInt(priceArr[i]);
						}
					}
					for(var i in priceArr){
						if(priceArr[i]!=""&&priceArr[i]!=0){
							if(parseInt(priceArr[i])<=parseInt(priceMin)){
								priceMin=parseInt(priceArr[i]);
							}
						}
					}
					return priceMin;
				}
				function sortArrTwo(arr){
					var countMax="";
					for(var i in arr){
						if(arr[i]!=""&&arr[i]!=0&&countMax==""){
							countMax=i;
						}
					}
					for(var i in arr){
						if(arr[i]!=""&&arr[i]!=0){
							if(parseInt(arr[i])<=parseInt(countMax)){
								countMax=i;
							}
						}
					}
					return countMax;
				}
			},
			setLocationStorageSite:function(obj){
				localStorage.setItem('site_bike_look',JSON.stringify(obj));
			},
			setLocationStorageSiteHistory:function(obj){
                localStorage.setItem('site_bike_look_hisory',obj);
            },
			setLocalStorageBaikeLookStatus:function(status){
				localStorage.setItem('site_bike_look_status',status);
			},
			getLocationStorageSiteHistory:function(){
			   return localStorage.getItem('site_bike_look_hisory');
			},
			getLocalStorageBaikeLookStatus:function(){
			   return localStorage.getItem('site_bike_look_status');
			},
			getLocationStorageSite:function(){
				return JSON.parse(localStorage.getItem('site_bike_look'));
			},
			setLocationStorageHref:function(obj){
				localStorage.setItem('site_bike_href',obj);
			},
			getLocationStorageHref:function(){
				return localStorage.getItem('site_bike_href');
			},
		};
		$(function(){
			f.init();
		})
	});
})(document,window,jQuery)