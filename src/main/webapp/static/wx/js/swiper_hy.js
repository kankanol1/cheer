+function(e) {
    var a, t = function(e) {
        this.initConfig(e),
            this.index = 0
    };
    t.prototype = {
        initConfig: function(t) {
            this.config = e.extend({}, a, t),
                this.activeIndex = this.lastActiveIndex = this.config.initIndex,
                this.config.items = this.config.items.map(function(e, a) {
                    return "string" == typeof e ? {
                        image: e,
                        caption: ""
                    } : e
                }),
                this.tpl = e.t7.compile(this.config.tpl),
            this.config.autoOpen && this.open()
        },
        open: function(a) {
            if (this._open)
                return !1;
            if (!this.modal) {
                this.modal = e(this.tpl(this.config)).appendTo(document.body),
                    this.container = this.modal.find(".swiper-container"),
                    this.wrapper = this.modal.find(".swiper-wrapper");
                var t = new Hammer(this.container[0]);
                t.get("pinch").set({
                    enable: !0
                }),
                    t.on("pinchstart", e.proxy(this.onGestureStart, this)),
                    t.on("pinchmove", e.proxy(this.onGestureChange, this)),
                    t.on("pinchend", e.proxy(this.onGestureEnd, this)),
                    this.modal.on(e.touchEvents.start, e.proxy(this.onTouchStart, this)),
                    this.modal.on(e.touchEvents.move, e.proxy(this.onTouchMove, this)),
                    this.modal.on(e.touchEvents.end, e.proxy(this.onTouchEnd, this)),
                    this.wrapper.transition(0),
                    this.wrapper.transform("translate3d(-" + e(window).width() * this.config.initIndex + "px,0,0)"),
                    this.container.find(".caption-item").eq(this.config.initIndex).addClass("active"),
                    this.container.find(".swiper-pagination-bullet").eq(this.config.initIndex).addClass("swiper-pagination-bullet-active")
            }
            var i = this;
            this.modal.show().height(),
                this.modal.addClass("weui-photo-browser-modal-visible"),
                this.container.addClass("swiper-container-visible").transitionEnd(function() {
                    i.initParams(),
                    void 0 !== a && i.slideTo(a),
                    i.config.onOpen && i.config.onOpen.call(i)
                }),
                this._open = !0
        },
        close: function() {
            this.container.transitionEnd(e.proxy(function() {
                this.modal.hide(),
                    this._open = !1,
                this.config.onClose && this.config.onClose.call(this)
            }, this)),
                this.container.removeClass("swiper-container-visible"),
                this.modal.removeClass("weui-photo-browser-modal-visible")
        },
        initParams: function() {
            return !this.containerHeight && (this.windowWidth = e(window).width(),
                this.containerHeight = this.container.height(),
                this.containerWidth = this.container.width(),
                this.touchStart = {},
                this.wrapperTransform = 0,
                this.wrapperLastTransform = -e(window).width() * this.config.initIndex,
                this.wrapperDiff = 0,
                this.lastScale = 1,
                this.currentScale = 1,
                this.imageLastTransform = {
                    x: 0,
                    y: 0
                },
                this.imageTransform = {
                    x: 0,
                    y: 0
                },
                this.imageDiff = {
                    x: 0,
                    y: 0
                },
                void (this.imageLastDiff = {
                    x: 0,
                    y: 0
                }))
        },
        onTouchStart: function(a) {
            return !this.scaling && (this.touching = !0,
                this.touchStart = e.getTouchPosition(a),
                this.touchMove = null,
                this.touchStartTime = +new Date,
                this.wrapperDiff = 0,
                void (this.breakpointPosition = null))
        },
        onTouchMove: function(a) {
            if (!this.touching || this.scaling)
                return !1;
            if (a.preventDefault(),
                this.gestureImage) {
                var t = this.gestureImage[0].getBoundingClientRect();
                t.left >= 0 || t.right <= this.windowWidth ? this.overflow = !0 : this.overflow = !1
            } else
                this.oveflow = !1;
            var i = this.touchMove = e.getTouchPosition(a);
            if (1 === this.currentScale || this.overflow)
                this.breakpointPosition ? this.wrapperDiff = i.x - this.breakpointPosition.x : this.wrapperDiff = i.x - this.touchStart.x,
                0 === this.activeIndex && this.wrapperDiff > 0 && (this.wrapperDiff = Math.pow(this.wrapperDiff, .8)),
                this.activeIndex === this.config.items.length - 1 && this.wrapperDiff < 0 && (this.wrapperDiff = -Math.pow(-this.wrapperDiff, .8)),
                    this.wrapperTransform = this.wrapperLastTransform + this.wrapperDiff,
                    this.doWrapperTransform();
            else {
                this.gestureImage;
                this.imageDiff = {
                    x: i.x - this.touchStart.x,
                    y: i.y - this.touchStart.y
                },
                    this.imageTransform = {
                        x: this.imageDiff.x + this.imageLastTransform.x,
                        y: this.imageDiff.y + this.imageLastTransform.y
                    },
                    this.doImageTransform(),
                    this.breakpointPosition = i,
                    this.imageLastDiff = this.imageDiff
            }
        },
        onTouchEnd: function(e) {
            if (!this.touching)
                return !1;
            if (this.touching = !1,
                this.scaling)
                return !1;
            var a = +new Date - this.touchStartTime;
            return a < 200 && (!this.touchMove || Math.abs(this.touchStart.x - this.touchMove.x) <= 2 && Math.abs(this.touchStart.y - this.touchMove.y) <= 2) ? void this.onClick() : (this.wrapperDiff > 0 ? this.wrapperDiff > this.containerWidth / 2 || this.wrapperDiff > 20 && a < 300 ? this.slidePrev() : this.slideTo(this.activeIndex, 200) : -this.wrapperDiff > this.containerWidth / 2 || -this.wrapperDiff > 20 && a < 300 ? this.slideNext() : this.slideTo(this.activeIndex, 200),
                this.imageLastTransform = this.imageTransform,
                void this.adjust())
        },
        onClick: function() {
            var e = this;
            this._lastClickTime && +new Date - this._lastClickTime < 300 ? (this.onDoubleClick(),
                clearTimeout(this._clickTimeout)) : this._clickTimeout = setTimeout(function() {
                e.close()
            }, 300),
                this._lastClickTime = +new Date
        },
        onDoubleClick: function() {
            this.gestureImage = this.container.find(".swiper-slide").eq(this.activeIndex).find("img"),
                this.currentScale = this.currentScale > 1 ? 1 : 2,
                this.doImageTransform(200),
                this.adjust()
        },
        onGestureStart: function(e) {
            this.scaling = !0,
                this.gestureImage = this.container.find(".swiper-slide").eq(this.activeIndex).find("img")
        },
        onGestureChange: function(e) {
            var a = this.lastScale * e.scale;
            a > this.config.maxScale ? a = this.config.maxScale + Math.pow(a - this.config.maxScale, .5) : a < 1 && (a = Math.pow(a, .5)),
                this.currentScale = a,
                this.doImageTransform()
        },
        onGestureEnd: function(e) {
            this.currentScale > this.config.maxScale ? (this.currentScale = this.config.maxScale,
                this.doImageTransform(200)) : this.currentScale < 1 && (this.currentScale = 1,
                this.doImageTransform(200)),
                this.lastScale = this.currentScale,
                this.scaling = !1,
                this.adjust()
        },
        doWrapperTransform: function(e, t) {
            if (0 === e) {
                var i = this.wrapper.css("transition-property");
                this.wrapper.css("transition-property", "none").transform("translate3d(" + this.wrapperTransform + "px, 0, 0)"),
                    this.wrapper.css("transition-property", i),
                    t()
            } else
                this.wrapper.transitionEnd(function() {
                    t && t()
                }),
                    this.wrapper.transition(e || a.duration).transform("translate3d(" + this.wrapperTransform + "px, 0, 0)")
        },
        doImageTransform: function(e, a) {
            this.gestureImage && (this.gestureImage.transition(e || 0).transform("translate3d(" + this.imageTransform.x + "px," + this.imageTransform.y + "px, 0) scale(" + this.currentScale + ")"),
                this._needAdjust = !0)
        },
        adjust: function() {
            if (!this._needAdjust)
                return !1;
            var e = this.gestureImage;
            if (!e)
                return !1;
            if (1 === this.currentScale)
                return this.imageTransform = this.imageLastDiff = {
                    x: 0,
                    y: 0
                },
                    void this.doImageTransform(200);
            var a = e[0].getBoundingClientRect();
            a.height < this.containerHeight ? this.imageTransform.y = this.imageLastTransform.y = 0 : a.top > 0 ? this.imageTransform.y = this.imageTransform.y - a.top : a.bottom < this.containerHeight && (this.imageTransform.y = this.imageTransform.y + this.containerHeight - a.bottom),
                this.doImageTransform(200),
                this._needAdjust = !1
        },
        slideTo: function(a, t) {
            a < 0 && (a = 0),
            a > this.config.items.length - 1 && (a = this.config.items.length - 1),
                this.lastActiveIndex = this.activeIndex,
                this.activeIndex = a,
                this.wrapperTransform = -(a * this.containerWidth),
                this.wrapperLastTransform = this.wrapperTransform,
                this.doWrapperTransform(t, e.proxy(function() {
                    return this.lastActiveIndex !== this.activeIndex && (this.container.find(".caption-item.active").removeClass("active"),
                        this.container.find(".swiper-slide-active").removeClass("swiper-slide-active"),
                        this.container.find(".swiper-pagination-bullet-active").removeClass("swiper-pagination-bullet-active"),
                        this.container.find(".caption-item").eq(this.activeIndex).addClass("active"),
                        this.container.find(".swiper-slide").eq(this.activeIndex).addClass("swiper-slide-active"),
                        this.container.find(".swiper-pagination-bullet").eq(this.activeIndex).addClass("swiper-pagination-bullet-active"),
                        this.container.find(".swiper-slide img[style]").transition(0).transform("translate3d(0,0,0) scale(1)"),
                        this.lastScale = 1,
                        this.currentScale = 1,
                        this.imageLastTransform = {
                            x: 0,
                            y: 0
                        },
                        this.imageTransform = {
                            x: 0,
                            y: 0
                        },
                        this.imageDiff = {
                            x: 0,
                            y: 0
                        },
                        this.imageLastDiff = {
                            x: 0,
                            y: 0
                        },
                        void (this.config.onSlideChange && this.config.onSlideChange.call(this, this.activeIndex)))
                }, this))
        },
        slideNext: function() {
            return this.slideTo(this.activeIndex + 1, 200)
        },
        slidePrev: function() {
            return this.slideTo(this.activeIndex - 1, 200)
        }
    },
        a = t.prototype.defaults = {
            items: [],
            autoOpen: !1,
            onOpen: void 0,
            onClose: void 0,
            initIndex: 0,
            maxScale: 3,
            onSlideChange: void 0,
            duration: 200,
            tpl: '<div class="weui-photo-browser-modal">            <div class="swiper-container">              <div class="swiper-wrapper">                {{#items}}                <div class="swiper-slide">                  <div class="photo-container">                    <img src="{{image}}" />                  </div>                </div>                {{/items}}              </div>              <div class="caption">                {{#items}}                <div class="caption-item caption-item-{{@index}}">{{caption}}</div>                {{/items}}              </div>              <div class="swiper-pagination swiper-pagination-bullets">                {{#items}}                <span class="swiper-pagination-bullet"></span>                {{/items}}              </div>            </div>          </div>'
        },
        e.photoBrowser = function(e) {
            return new t(e)
        }
}($);