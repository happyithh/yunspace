/**
 * Created by pzl on 16/1/19.
 */
var plugin={
    clickNodes:[],
    pageController:function(){
        var that=this,getUrl;
        var url=window.location.pathname;
        var urlArr=url.split('/');
        //var em=urlArr[1].indexOf("?");
        //getUrl= urlArr[1].indexOf("?")!=-1? urlArr[1].substr(0,em+1):urlArr[1];
        if(typeof that[urlArr[1]+"Local"]=='function'){
            that[urlArr[1]+"Local"]();
        }
        that.publicSpaceLocal();
    },
    publicSpaceLocal:function(){
        var that=this;
        var clickNodes={
            publicInput:$("#public-input"),
            publicSearch:$(".public-search"),
            publicSelect:$(".public-select>span"),
            searchType:$('input[name="search_type"]'),
            publicInputList:$(".public-input-list")
        };
        that.setLocalAndInitInput('public_space',clickNodes.publicSearch,"",function(data) {
            clickNodes.publicInput.val(data['publicInput']);
            clickNodes.publicSelect.find('code').text(data['publicSelect']);
            clickNodes.searchType.val(data['searchType']);
        },function(){
            var dataJson={
                publicInput:clickNodes.publicInput.val(),
                searchType:clickNodes.searchType.val(),
                publicSelect:clickNodes.publicSelect.find('code').text()
            };
            return JSON.stringify(dataJson);
        });
    },
    /*设置localStorage以及初始化input
    * @ storage:本地存储名(string)
    * @ btn:每次提交的button(dom)
    * @ input:每次提交的input(string)
    * @ fn1,fn2:回调函数(string),fn2必须返回字符串
    * */
    setLocalAndInitInput:function(storage,btn,input,fn1,fn2){
        //var that=this;
        //if(that.localDom.length<1)return;
        var getV=localStorage.getItem(storage);
        getV=JSON.parse(getV);
        if(getV!=null){
            if(typeof fn1=='function'){
                fn1(getV);
            }else{
                console.log('fn1类型必须为function！！');
                return;
            }
        }
        btn.on("click",function(){
            if(input!=""&&input.length>0){
                var v=input.val();
                if(v=="")return;
            }
            if(typeof fn2=='function'){
                var dataJson;
                dataJson=fn2(v);
                localStorage.setItem(storage,dataJson);
            }else{
                console.log('fn2类型必须为function！！');
                return ;
            }
        });
    },
    /*首页*/
    Local:function(){
        var that=this;
        that.clickNodes={
            homeInput:$(".header-body-input").find(".keyword"),
            homeClick:$(".header-body-button")
        };
        that.setLocalAndInitInput('home',that.clickNodes.homeClick,that.clickNodes.homeInput,function(data) {
            that.clickNodes.homeInput.val(data['search_site']);
        },function(val){
            var dataJson={
                search_site:val
            };
            return JSON.stringify(dataJson);
        });
    },
    /*搜索页面*/
    databaseLocal:function(){
        var that=this;
        var url=window.location.pathname;
        var urlArr=url.split('/');
        that.clickNodes={
            homeInput:$(".search_page_input"),
            homeClick:$(".search_page_btn")
        };
        switch(urlArr[2]){
            case "site":
                that.databaseCate().site();
                break;
            case "company":
                that.databaseCate().company();
                break;
            case "paper":
                that.databaseCate().paper();
                break;
        }
    },
    databaseCate:function(){
        var that=this;
        function searchLocal(localName,getName){
            that.clickNodes={
                searchPageInput:$(".search_page_input"),
                searchPageBtn:$(".search_page_btn")
            }
            that.setLocalAndInitInput(localName,that.clickNodes.searchPageBtn,that.clickNodes.searchPageInput,function(data) {
                that.clickNodes.searchPageInput.val(data[getName]);
            },function(val){
                var dataJson={};
                dataJson[getName]=val;
                return JSON.stringify(dataJson);
            });
        }
        return {
            site:function(){
                searchLocal('site','search_paper');
            },
            company:function(){
                searchLocal('company','search_company');
            },
            paper:function(){
                searchLocal('paper','search_paper');
            },
        }
    },
    /*一键租场地*/
    rent_spaceLocal:function(){
        var that=this;
        var url=window.location.search;
        if(url.indexOf('action=form')>-1){
            that.localSpaceForm();
            return;
        }
        if(url.indexOf('action=success')>-1){
            that.localSpaceSuccess();
            return;
        }
        that.clickNodes={
            spaceCateInput:$(".space-cate-input-p"),
            spaceSubmitBtn:$(".space-submit-btn"),
        };
        that.setLocalAndInitInput('rent_space',that.clickNodes.spaceSubmitBtn,"",function(data) {
            that.clickNodes.spaceCateInput.each(function(index,dom){
                var $dom=$(dom);
                switch (index){
                    case 0:
                        $dom.text(data.person);
                        break;
                    case 1:
                        $dom.text(data.cate);
                        break;
                }
            });
        },function(){
            var getJson={};
            that.clickNodes.spaceCateInput.each(function(index,dom){
                var $dom=$(dom);
                switch (index){
                    case 0:
                        getJson.person=$dom.text();
                        break;
                    case 1:
                        getJson.cate=$dom.text();
                        break;
                }
            });
            return JSON.stringify(getJson);
        });
    },
    /*一键租场地form*/
    localSpaceForm:function(){
        var that=this;
        that.clickNodes={
            username:$("#username"),//用户名
            phone:$("#phone_space"),//手机号码
            startTime:$("#start_time"),//开始时间
            endTime:$("#end_time"),//结束时间
            actMoney:$("#act_money"),//活动预算
            actCity:$("#act_city"),//活动城市
            actPersons:$("#act_persons"),//活动人数
            actCate:$("#act_cate"),//活动类型
            actOther:$("#act_other"),//其他要求
            actDemand:$("#act_demand"),//补充要求
            spaceSubmit:$("#space-submit"),//补充要求
            formSelectList:$(".form-select-list")
        };
        that.setLocalAndInitInput('local_space_form',that.clickNodes.spaceSubmit,"",function(data) {
            that.clickNodes.username.val(data["username"]);
            that.clickNodes.phone.val(data["phone"]);
            that.clickNodes.startTime.val(data["startTime"]);
            that.clickNodes.endTime.val(data["endTime"]);
            that.clickNodes.actMoney.val(data["actMoney"]);
            that.clickNodes.actCity.val(data["actCity"]);
            that.clickNodes.actPersons.val(data["actPersons"]);
            that.clickNodes.actCate.val(data["actCate"]);
            that.clickNodes.actOther.val(data["actOther"]);
            that.clickNodes.actDemand.val(data["actDemand"]);
            var cities=that.clickNodes.actCity.val();
            var actOther=that.clickNodes.actOther.val();
            var actMoney=that.clickNodes.actMoney.val();
            var actPersons=that.clickNodes.actPersons.val();
            var actCate=that.clickNodes.actCate.val();
            var actSelect=[actMoney,actPersons,actCate];
            cities=cities.split(',');
            actOther=actOther.split(',');
            $(".form-select-list").each(function(index,dom){
                var $do=$(dom);
                var many=$do.data('many');
                switch(many){
                    case true:
                        $do.find("li").each(function(index,dom){
                            var $dom=$(dom)
                            var txt=$dom.find('a').text();
                            $dom.find('a').removeClass("select-active2");
                            for(var k in cities){
                                if(cities[k]==txt){
                                    $dom.find('a').addClass("select-active2");
                                }
                            }
                            for(var k in actOther){
                                if(actOther[k]==txt){
                                    $dom.find('a').addClass("select-active2");
                                }
                            }
                        });
                        break;
                     default:
                        $do.find("li").each(function(index,dom){
                            var $dom=$(dom)
                            var txt=$dom.find('a').text();
                            for(var k in actSelect){
                                if(actSelect[k]==txt){
                                    $do.find('a').removeClass("select-active1");
                                    $dom.find('a').addClass("select-active1");
                                }
                            }
                        });
                        break;
                }
            });
        },function(){
            var getJson={
                username:that.clickNodes.username.val(),
                phone:that.clickNodes.phone.val(),
                startTime:that.clickNodes.startTime.val(),
                endTime:that.clickNodes.endTime.val(),
                actMoney:that.clickNodes.actMoney.val(),
                actCity:that.clickNodes.actCity.val(),
                actPersons:that.clickNodes.actPersons.val(),
                actCate:that.clickNodes.actCate.val(),
                actOther:that.clickNodes.actOther.val(),
                actDemand:that.clickNodes.actDemand.val()
            };
            return JSON.stringify(getJson);
        });
    },
    localSpaceSuccess:function(){
        var that=this;
        that.clickNodes={
            actImg:$("#act_img"),//活动图片类型
            actPrice:$("#act_price"),//场地价格
            actInfo:$("#act_info"),//基本信息
            company:$("#company"),//公司名称
            actFile:$("#act_file"),//上传的名片
            inputImg:$("#input-img"),//上传的名片
            successSubmitOne:$("#success-submit-one"),
            successSubmitTwo:$("#success-submit-two"),
            uploadFile:$("#upload-file")
        };
        /*成功后第一个表单*/
        that.setLocalAndInitInput('local_space_success',that.clickNodes.successSubmitOne,"",function(data) {
            that.clickNodes.actPrice.val(data["actPrice"]);
            that.clickNodes.actImg.val(data["actImg"]);
            that.clickNodes.actInfo.val(data["actInfo"]);
            var actPrice=that.clickNodes.actPrice.val();
            var actImg=that.clickNodes.actImg.val();
            var actInfo=that.clickNodes.actInfo.val();
            actPrice=actPrice.split(',');
            actImg=actImg.split(',');
            actInfo=actInfo.split(',');
            $(".form-select-list").each(function(index,dom){
                var $do=$(dom);
                var many=$do.data('many');
                if(many==true){
                    $do.find("li").each(function(index,dom){
                        var $dom=$(dom)
                        var txt=$dom.find('a').text();
                        $dom.find('a').removeClass("select-active2");
                        for(var k in actPrice){
                            if(actPrice[k]==txt){
                                $dom.find('a').addClass("select-active2");
                            }
                        }
                        for(var k in actImg){
                            if(actImg[k]==txt){
                                $dom.find('a').addClass("select-active2");
                            }
                        }
                        for(var k in actInfo){
                            if(actInfo[k]==txt){
                                $dom.find('a').addClass("select-active2");
                            }
                        }
                    });
                }
            });
        },function(){
            var getJson={
                actPrice:that.clickNodes.actPrice.val(),
                actImg:that.clickNodes.actImg.val(),
                actInfo:that.clickNodes.actInfo.val(),
            };
            return JSON.stringify(getJson);
        });
        /*成功后第二个表单*/
        that.setLocalAndInitInput('local_space_company',that.clickNodes.successSubmitTwo,"",function(data) {
            that.clickNodes.company.val(data['company']);
            that.clickNodes.inputImg.html(data['inputImg']);
            if(that.clickNodes.inputImg.find('li').length!=0){
                that.clickNodes.uploadFile.addClass("none");
                that.clickNodes.inputImg.find('li:first').hover(function(){
                     var $this=$(this);
                    $this.find(".remove-img").css({display:'block'}).on("click",function(){
                        var $o=$(this);
                        $o.parents("#input-img").html("");
                        that.clickNodes.actFile.val("");
                        that.clickNodes.uploadFile.removeClass("none");
                    });
                },function(){
                    var $this=$(this);
                    $this.find(".remove-img").css({display:'none'});
                });
            }else{
                that.clickNodes.uploadFile.removeClass("none");
            }
        },function(){
            var dataJson={
                company:that.clickNodes.company.val(),
                actFile:that.clickNodes.actFile.val(),
                inputImg:that.clickNodes.inputImg.html()
            };
            return JSON.stringify(dataJson);
        });
    }
}