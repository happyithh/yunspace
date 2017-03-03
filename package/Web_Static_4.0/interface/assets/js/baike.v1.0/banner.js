;(function($, window, document,undefined) {

    var YunSlide = function(ele, opt) {
        var self = this;
        self.$context = ele;
        self.defaults = {
            autoplay: false,
            delay: 5000,
            speed : 800,
            next : '',
            prev : ''
        };
        self.interval = null;
        self.$slides = null; //滚动的piece
        self.wrap = null;

        self.perWidth = 0;
        self.current = 0;
        self.total = 0;
        self.options = $.extend({}, this.defaults, opt);

        self.nav = null;
        self.nextButton = null;
        self.prevButton = null;

        self.init = function(){
            self.wrap = self.$context.find('.wrap');
            self.$slides =  self.$context.find('.wrap .item');
            self.total = self.$slides.length;
            self.wrap.css({
                'width' : self.total * 100 + '%'
            });
            self.nav = $(self.options.nav);

            for(var i = 0; i< self.total; i++ ){

                if(i == 0){
                    self.nav.append('<a class="current" href="javascript:;">' +
                    '</a>');
                }else{
                    self.nav.append('<a href="javascript:;">' +
                    '</a>');
                }

            }
            var perWidth = 100/self.total;
            self.$slides.each(function(index,dom){
                var imgUrl = $(this).find('img').attr('src');
                $(this).css({
                    'background-image' : 'url('+imgUrl+')',
                    'background-size': '100% 100%',
                    'width' : perWidth + '%'
                })
            });

            self.nav.find('a').on('click',function(){
                self.current = $(this).index();
                self.cycle();
                self.slide();
            });

            self.nextButton = $(self.options.next);
            self.prevButton = $(self.options.prev);

            self.nextButton.on('click',function(){self.next();self.cycle();});
            self.prevButton.on('click',function(){self.prev();self.cycle();});

            if(self.total > 1) self.cycle();

        };

        self.next = function(){

            self.current += 1;
            if(self.current >= self.total) {
                self.current = 0;
            }
            self.slide();
        };

        self.prev = function(){
            self.current -= 1;
            if(self.current < 0) {
                self.current = self.total - 1;
            }
            self.slide();
        };

        self.slide = function(){

            self.wrap.stop().animate({
                'left': -(self.current) * 100 + '%'
            },self.options.speed);

            self.nav.find('a').eq(self.current).addClass('current').siblings().removeClass('current');
        };

        self.cycle = function(){

            clearInterval(self.interval);
            self.interval = setInterval(function(){
                self.next()
            },self.options.delay);

        };

        return self.init();
    };
    //定义Beautifier的方法
    //YunSlide.prototype = {
    //
    //    init : function(){
    //        alert(1);
    //    },
    //    start : function(){
    //
    //    },
    //    beautify: function() {
    //        return this.$element.css({
    //            'color': this.options.color,
    //            'fontSize': this.options.fontSize,
    //            'textDecoration': this.options.textDecoration
    //        });
    //    },
    //    slide : function(){
    //
    //    }
    //};
    //在插件中使用Beautifier对象
    $.fn.YunSlide = function(options) {

        return new YunSlide(this, options);
    };

})(jQuery, window, document);

(function($) {
    var YunCarousel = function(ele, opt) {
        var self = this;
        self.$context = ele;
        self.defaults = {
            autoplay: false,
            next : '.next',
            prev : '.prev'
        };
        self.$slides = null; //滚动的piece
        self.wrap = null;

        self.width = 0;
        self.wrapWidth = 0;

        self.length = 0;
        self.total = 0;
        self.current = 0;
        self.options = $.extend({}, this.defaults, opt);

        self.nextButton = null;
        self.prevButton = null;


        self.init = function(){

            self.wrap = self.$context.find('ul');

            self.$slides = self.wrap.find('li');

            self.width = self.$context.width();

            var width = self.$slides.eq(0).outerWidth(true);

            self.length = self.$slides.length;

            self.wrapWidth = self.length * width;

            self.wrap.width(self.wrapWidth);

            self.total = Math.ceil(self.wrapWidth/self.width);

            self.nextButton = $(self.options.next);
            self.prevButton = $(self.options.prev);

            self.nextButton.on('click',function(){
                self.next();
            });

            self.prevButton.on('click',function(){
                self.prev();
            });

            self.initButton();

        };

        self.next = function(){

            if(self.total <= 1 || self.current == (self.total-1)) return;


            if( self.current == (self.total - 2) ){//最后一次滚动
                self.current += 1;
                var leftWidth =  self.width - self.wrapWidth;
                self.slide(leftWidth);
                return;
            }

            if(self.current < (self.total - 1) ) {

                self.current += 1;

            }else{

            }
            self.slide();

        };

        self.prev = function(){

            if(self.total <= 1) return;

            if(self.current <= 0) return;

            self.current -= 1;


            self.slide();

        };

        self.slide = function(width){

            var distance = 0;
            if(Math.abs(width)){
                distance = Math.abs(width);
            }else{
                distance = (self.current) * self.width;
            }

            self.wrap.stop().animate({
                'left': -distance + 'px'
            },self.speed);

            self.initButton();

        };

        self.initButton = function(){

            if(self.current == 0){
                self.prevButton.css('opacity','0.2');
            }else{
                self.prevButton.css('opacity','1');
            }

            if(self.current >= (self.total - 1) ){
                self.nextButton.css('opacity','0.2');
            }else{
                self.nextButton.css('opacity','1');
            }

        };

        return self.init();
    };

    $.fn.YunCarousel = function(options) {
        //创建实体
        return new YunCarousel(this, options);

    };

})(jQuery);