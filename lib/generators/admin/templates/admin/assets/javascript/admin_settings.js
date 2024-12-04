$('#replace_logo').on('change', function (event) {
    var files = event.target.files;
    var image = files[0]
    var reader = new FileReader();
    reader.onload = function (file) {
        var img = new Image();
        var header_img = new Image();
        img.src = file.target.result;
        header_img.src = file.target.result;
        img.setAttribute("class", "h-14 rounded-lg")
        header_img.setAttribute("class", "h-10 rounded-lg")
        $('#shop_logo_preview').html(img)
        $('#header_logo').html(header_img)
    }
    reader.readAsDataURL(image);
});

function remove_logo_img() {
    var svg = '<svg class="h-10 fill-[#0F0F0F] dark:fill-white" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><g id="SVGRepo_bgCarrier" stroke-width="0"></g><g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g><g id="SVGRepo_iconCarrier"> <path fill-rule="evenodd" clip-rule="evenodd" d="M5.13238 1C4.07859 1 3.10207 1.5529 2.5599 2.45651L0.615776 5.69672C0.17816 6.42608 0.0121122 7.42549 0.508798 8.32014C0.789678 8.82607 1.27459 9.55181 2 10.1205V20C2 21.6569 3.34315 23 5 23H8C9.10457 23 10 22.1046 10 21V15H14V21C14 22.1046 14.8954 23 16 23H19C20.6569 23 22 21.6569 22 20V10.1205C22.7254 9.55181 23.2103 8.82607 23.4912 8.32014C23.9879 7.42548 23.8218 6.42608 23.3842 5.69672L21.4401 2.45651C20.8979 1.5529 19.9214 1 18.8676 1H5.13238ZM20 10.9697C19.8391 10.9895 19.6725 11 19.5 11C18.1259 11 17.1126 10.3216 16.4364 9.60481C16.2632 9.4211 16.1082 9.23119 15.9705 9.04325C15.2167 9.98812 13.9542 11 12 11C10.0458 11 8.7833 9.98812 8.02952 9.04325C7.89183 9.23119 7.73684 9.4211 7.56355 9.60481C6.8874 10.3216 5.87405 11 4.5 11C4.32752 11 4.16089 10.9895 4 10.9697V20C4 20.5523 4.44772 21 5 21H8V15C8 13.8954 8.89543 13 10 13H14C15.1046 13 16 13.8954 16 15V21H19C19.5523 21 20 20.5523 20 20V10.9697ZM4.27489 3.4855C4.45561 3.1843 4.78112 3 5.13238 3H18.8676C19.2189 3 19.5444 3.1843 19.7251 3.4855L21.6692 6.72571C21.8324 6.99765 21.8127 7.2231 21.7426 7.34937C21.2851 8.17345 20.5493 9 19.5 9C18.8448 9 18.323 8.69006 17.8913 8.23245C17.4506 7.76524 17.1659 7.20393 17.0284 6.88399C16.8114 6.37951 16.3329 6.21388 16.0033 6.21248C15.674 6.21109 15.1982 6.37172 14.9752 6.8683C14.6702 7.54754 13.7982 9 12 9C10.2018 9 9.32978 7.54754 9.0248 6.8683C8.80182 6.37172 8.32598 6.21109 7.99667 6.21248C7.66706 6.21388 7.18855 6.37951 6.97164 6.88399C6.83407 7.20393 6.5494 7.76524 6.10869 8.23245C5.67703 8.69006 5.15524 9 4.5 9C3.45065 9 2.71491 8.17345 2.2574 7.34937C2.1873 7.2231 2.1676 6.99765 2.33076 6.72571L4.27489 3.4855Z"></path> </g></svg>'
    var svg1 = '<svg class="h-8 fill-[#0F0F0F] dark:fill-white" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><g id="SVGRepo_bgCarrier" stroke-width="0"></g><g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g><g id="SVGRepo_iconCarrier"> <path fill-rule="evenodd" clip-rule="evenodd" d="M5.13238 1C4.07859 1 3.10207 1.5529 2.5599 2.45651L0.615776 5.69672C0.17816 6.42608 0.0121122 7.42549 0.508798 8.32014C0.789678 8.82607 1.27459 9.55181 2 10.1205V20C2 21.6569 3.34315 23 5 23H8C9.10457 23 10 22.1046 10 21V15H14V21C14 22.1046 14.8954 23 16 23H19C20.6569 23 22 21.6569 22 20V10.1205C22.7254 9.55181 23.2103 8.82607 23.4912 8.32014C23.9879 7.42548 23.8218 6.42608 23.3842 5.69672L21.4401 2.45651C20.8979 1.5529 19.9214 1 18.8676 1H5.13238ZM20 10.9697C19.8391 10.9895 19.6725 11 19.5 11C18.1259 11 17.1126 10.3216 16.4364 9.60481C16.2632 9.4211 16.1082 9.23119 15.9705 9.04325C15.2167 9.98812 13.9542 11 12 11C10.0458 11 8.7833 9.98812 8.02952 9.04325C7.89183 9.23119 7.73684 9.4211 7.56355 9.60481C6.8874 10.3216 5.87405 11 4.5 11C4.32752 11 4.16089 10.9895 4 10.9697V20C4 20.5523 4.44772 21 5 21H8V15C8 13.8954 8.89543 13 10 13H14C15.1046 13 16 13.8954 16 15V21H19C19.5523 21 20 20.5523 20 20V10.9697ZM4.27489 3.4855C4.45561 3.1843 4.78112 3 5.13238 3H18.8676C19.2189 3 19.5444 3.1843 19.7251 3.4855L21.6692 6.72571C21.8324 6.99765 21.8127 7.2231 21.7426 7.34937C21.2851 8.17345 20.5493 9 19.5 9C18.8448 9 18.323 8.69006 17.8913 8.23245C17.4506 7.76524 17.1659 7.20393 17.0284 6.88399C16.8114 6.37951 16.3329 6.21388 16.0033 6.21248C15.674 6.21109 15.1982 6.37172 14.9752 6.8683C14.6702 7.54754 13.7982 9 12 9C10.2018 9 9.32978 7.54754 9.0248 6.8683C8.80182 6.37172 8.32598 6.21109 7.99667 6.21248C7.66706 6.21388 7.18855 6.37951 6.97164 6.88399C6.83407 7.20393 6.5494 7.76524 6.10869 8.23245C5.67703 8.69006 5.15524 9 4.5 9C3.45065 9 2.71491 8.17345 2.2574 7.34937C2.1873 7.2231 2.1676 6.99765 2.33076 6.72571L4.27489 3.4855Z"></path> </g></svg>'
    $('#shop_logo_preview').html(svg)
    $('#header_logo').html(svg1)
    var dataTransfer = new DataTransfer()
    document.getElementById('replace_logo').files = dataTransfer.files
}

function preview_color(input, key, color_id1, id1, id2, input_id) {
    var btn = document.getElementById(color_id1).childNodes[1]
    btn.removeAttribute('onclick')
    btn.setAttribute('onclick', `customize("${input.value}", "${key}", "${id1}", "${id2}", "${input_id}")`)
    btn.style.backgroundColor = input.value
}

function preview_color_enter(input, event, key, color_id1, id1, id2) {
    if (event.key === 'Enter') {
        preview_color(input, key, color_id1, id1, id2)
    }
}

function change_shop_name(input) {
    var shop_name = document.getElementById('shop_name')
    var error = document.getElementById('shop_name_error')
    if (input.value.length > 20) {
        error.innerText = 'Name must be less than 20 chars'
        input.value = ""
        shop_name.innerText = '<%= @current_shop.name %>'
    } else {
        shop_name.innerText = input.value
        error.innerText = ""
    }
}

function customize(color, key, id1, id2, input_id) {
    function applyStyle(element, styleKey) {
        if (element) {
            element.forEach(function (ele) {
                if (ele.id.includes('svg')) {
                    ele.style.fill = color;
                } else if (styleKey === 'color' || styleKey === 'backgroundColor' ) {
                    ele.style[styleKey] = color;
                }
            })
        }
    }

    function applyHoverStyle() {
        var parent = document.querySelectorAll('[id*="hover_effect"]');
        parent.forEach(function (parentEle) {
            var count = parentEle.id.split('_')[2]
            var svg = document.getElementById(`admin_sidebar_svg_${count}`)
            var text = document.getElementById(`admin_sidebar_text_${count}`)
            var before_color = document.getElementById('before_color').innerText
            parentEle.addEventListener('mouseenter', (event) => {
                if (event.target.id === parentEle.id) {
                    svg.style.fill = color;
                    text.style.color = color;
                }
            });
            parentEle.addEventListener('mouseleave', (event) => {
                if (event.target.id === parentEle.id) {
                    svg.style.fill = before_color;
                    text.style.color = before_color;
                }
            });
            const style = document.createElement('style');
            style.innerHTML = `
                .sidebar-item:hover::before {
                  background-color: ${color} !important;
                }
              `;
            document.head.appendChild(style);
        })
    }

    var styleKey = (key === 'color') ? 'color' : 'backgroundColor';
    if (id1 === 'admin_sidebar_hover') {
        applyHoverStyle();
    } else {
        if (id1 === 'admin_sidebar_svg') {
            document.getElementById('before_color').innerText = color
            applyStyle(document.querySelectorAll(`[id*="${id1}"]`), styleKey);
            applyStyle(document.querySelectorAll(`[id*="${id2}"]`), styleKey);
        } else {
            applyStyle(document.querySelectorAll(id1), styleKey);
            applyStyle(document.querySelectorAll(id2), styleKey);
        }
    }
    document.getElementById(input_id).value = color
}