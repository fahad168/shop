document.addEventListener('DOMContentLoaded', function () {
    document.getElementById('special_products').classList.add('show');
    document.getElementById('categories_showcase').classList.add('show');
    document.getElementById('shops_showcase').classList.add('show');
})

// Categories Slider
var category_splide = new Splide( '#category-carousel', {
    perPage: 3,
    pagination: false
} );
arrows_mount(category_splide)
category_splide.mount();

// Shops Slider
var shop_splide = new Splide( '#shops-carousel', {
    perPage: 3,
    pagination: false
} );
arrows_mount(shop_splide)
shop_splide.mount();

// Special Products Slider
var special_products_carousel = new Splide( '#special-products-carousel', {
    perPage: 6,
    pagination: false
} );
arrows_mount(special_products_carousel)
special_products_carousel.mount();

// Animations
function animateOnScroll(entries, observer) {
    entries.forEach(entry => {
        if (entry.isIntersecting) {
            entry.target.classList.add('show');
            entry.target.classList.add('showed');
        } else {
            entry.target.classList.remove('show');
            // if (entry.target.classList.contains('showed')) {
            //     if (scrollDetect() === 'up') {
            //         entry.target.classList.remove('!-translate-x-full')
            //     } else {
            //         entry.target.classList.add('!-translate-x-full')
            //     }
            // }
        }
    });
}
var lastScroll = 0;

function scrollDetect(){
    var scroll_container = document.getElementById('scroll_container')
    let currentScroll = scroll_container.scrollTop || scroll_container.scrollTop;

    if (currentScroll > 0 && lastScroll <= currentScroll){
        lastScroll = currentScroll;
        return 'down'
    }else{
        lastScroll = currentScroll;
        return 'up'
    }
}

function arrows_mount(splide) {
    splide.on( 'arrows:mounted', function (event) {
        $('.splide__arrow').each(function () {
            if ($(this).prop('disabled') === true) {
                $(this).toggleClass('hidden');
            }
        });
    });
    splide.on('arrows:updated', function () {
        $('.splide__arrow').each(function () {
            if ($(this).prop('disabled') === true) {
                $(this).addClass('hidden');
            } else {
                $(this).removeClass('hidden');
            }
        });
    });
}

const options = {
    root: null,
    rootMargin: '0px',
};
const observer = new IntersectionObserver(animateOnScroll, options);

const categories_showcase = document.getElementById('categories_showcase');
const shops_showcase = document.getElementById('shops_showcase');
const div2 = document.getElementById('div2');
observer.observe(div2);
observer.observe(categories_showcase);
observer.observe(shops_showcase);


var main = new Splide( '#image-carousel', {
    type      : 'fade',
    rewind    : true,
    pagination: true,
    arrows    : false,
    rewindByDrag: true,
    autoplay: true
} );

main.mount();

var new_main = new Splide( '#image-carousel', {
    type      : 'fade',
    rewind    : true,
    arrows    : false,
    rewindByDrag: true,
} );

var thumbnails = new Splide( '#thumbnail-carousel', {
    rewind          : true,
    fixedWidth      : 80,
    fixedHeight     : 90,
    isNavigation    : true,
    gap             : 10,
    pagination      : false,
    cover           : true,
    arrows          : false,
    rewindByDrag    : true,
    dragMinThreshold: {
        mouse: 4,
        touch: 10,
    },
    breakpoints : {
        640: {
            fixedWidth  : 66,
            fixedHeight : 38,
        },
    },
} );

new_main.sync( thumbnails );
new_main.mount();
thumbnails.mount();


function imageZoom(imgID, resultID) {
    var img, lens, result, cx, cy;
    img = document.getElementById(imgID);
    result = document.getElementById(resultID);
    result.style.display = 'block'
    lens = document.createElement("DIV");
    lens.setAttribute("class", "img-zoom-lens");
    img.parentElement.insertBefore(lens, img);
    cx = result.offsetWidth / lens.offsetWidth;
    cy = result.offsetHeight / lens.offsetHeight;
    result.style.backgroundImage = "url('" + img.src + "')";
    result.style.backgroundSize = (img.width * cx) + "px " + (img.height * cy) + "px";
    lens.addEventListener("mousemove", moveLens);
    img.addEventListener("mousemove", moveLens);
    /* And also for touch screens: */
    lens.addEventListener("touchmove", moveLens);
    img.addEventListener("touchmove", moveLens);
    function moveLens(e) {
        var pos, lensX, lensY, x, y;
        e.preventDefault();
        pos = getCursorPos(e);
        lensX = pos.x - (lens.offsetWidth / 2);
        lensY = pos.y - (lens.offsetHeight / 2);
        if (lensX > img.width - lens.offsetWidth) {
            lensX = img.width - lens.offsetWidth;
        }
        if (lensX < 0) {
            lensX = 0;
        }
        if (lensY > img.height - lens.offsetHeight) {
            lensY = img.height - lens.offsetHeight;
        }
        if (lensY < 0) {
            lensY = 0;
        }
        lens.style.left = lensX + "px";
        lens.style.top = lensY + "px";
        x = lensX * cx;
        y = lensY * cy;
        result.style.backgroundPosition = `-${x}px -${y}px`;
    }
    function getCursorPos(e) {
        var a, x = 0, y = 0;
        e = e || window.event;
        a = img.getBoundingClientRect();
        x = e.pageX - a.left;
        y = e.pageY - a.top;
        x = x - window.pageXOffset;
        y = y - window.pageYOffset;
        return {x : x, y : y};
    }
}

function hideZoom() {
    document.getElementById('image_zoom').style.display = 'none';
    $('.img-zoom-lens').remove()
}