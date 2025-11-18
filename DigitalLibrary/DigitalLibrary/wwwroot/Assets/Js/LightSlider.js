$(document).ready(function () {
    $("#lightSlider").lightSlider({
        rtl: true,
        item: 7,
        slideMargin: 10,
        loop: true,
        pager: true,
        auto: true,
        pause: 3000,
        enableTouch: true,
        enableDrag: true,
        responsive: [
            {
                breakpoint: 992,
                settings: {
                    item: 5,
                    slideMargin: 7
                }
            },
            {
                breakpoint: 768,
                settings: {
                    item: 4,
                    slideMargin: 7
                }
            },

            {
                breakpoint: 400,
                settings: {
                    item: 3,
                    slideMargin: 7
                }
            },
        ]
    });

    $("#lightSlider2").lightSlider({
        rtl: true,
        item: 7,
        slideMargin: 10,
        loop: true,
        pager: true,
        auto: true,
        pause: 3000,
        enableTouch: true,
        enableDrag: true,
        responsive: [
            {
                breakpoint: 992,
                settings: {
                    item: 5,
                    slideMargin: 7
                }
            },
            {
                breakpoint: 768,
                settings: {
                    item: 4,
                    slideMargin: 7
                }
            },

            {
                breakpoint: 400,
                settings: {
                    item: 3,
                    slideMargin: 7
                }
            },
        ]
    });
    $("#lightSlider3").lightSlider({
        rtl: true,
        item: 6,
        slideMargin: 10,
        loop: true,
        pager: true,
        auto: true,
        pause: 3000,
        enableTouch: true,
        enableDrag: true,
        responsive: [
            {
                breakpoint: 1100,
                settings: {
                    item: 5,
                    slideMargin: 7
                }
            },
            {
                breakpoint: 992,
                settings: {
                    item: 4,
                    slideMargin: 7
                }
            },

            {
                breakpoint: 768,
                settings: {
                    item: 3,
                    slideMargin: 7
                }
            },

            {
                breakpoint: 600,
                settings: {
                    item: 2,
                    slideMargin: 7
                }
            },

            {
                breakpoint: 430,
                settings: {
                    item: 1,
                    slideMargin: 7
                }
            },
        ]
    });
})
//EndLightBox
