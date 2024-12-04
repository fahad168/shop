var loader = document.getElementById('loader')
var overlay = document.getElementById('overlay')

function update_cart_product(product_id, variant_id, size_id, quantity, amount, key, item_id, in_stock) {
    loader.style.display = 'flex'
    overlay.classList.remove('hidden')
    var csrfToken = $('meta[name="csrf-token"]').attr('content');
    $.ajax({
        url: '/shop/user/cart/add_to_cart',
        type: 'POST',
        data: {authenticity_token: csrfToken, key: key, product_id: product_id, variant_id: variant_id, size_id: size_id, quantity: quantity, amount: amount},
        success: function (res) {
            var input = document.getElementById(`counter-input-${item_id}`)
            if (key === 'add') {
                input.value = parseInt(input.value) + quantity
            } else {
                input.value = parseInt(input.value) - quantity
            }
            var decrBtn = document.getElementById(`decrement-button-${item_id}`)
            var incrBtn = document.getElementById(`increment-button-${item_id}`)
            var itemAmount = document.getElementById(`item-amount-${item_id}`)
            input.value === '1' ? decrBtn.style.display = 'none' : decrBtn.style.display = 'flex'
            parseInt(input.value) === parseInt(in_stock) ? incrBtn.style.display = 'none' : incrBtn.style.display = 'flex'
            itemAmount.innerText = `$${parseFloat(res?.cart_item?.amount)}`
            loader.style.display = 'none'
            overlay.classList.add('hidden')
        }
    })
}

function remove_item(item_id) {
    loader.style.display = 'flex'
    overlay.classList.remove('hidden')
    var csrfToken = $('meta[name="csrf-token"]').attr('content');
    $.ajax({
        url: '/shop/user/cart/remove_from_cart',
        type: 'POST',
        data: {authenticity_token: csrfToken, item_id: item_id},
        success: function (res) {
            $('#cart_items_display').html(res?.items)
            loader.style.display = 'none'
            overlay.classList.add('hidden')
            toastr.success(res?.message)
        }
    })
}


document.addEventListener('DOMContentLoaded', function () {
    document.getElementById('show_slider').classList.add('show');
    document.getElementById('product_details').classList.add('show');
})

function get_variant_details(id) {
    $.ajax({
        url: `/shop/user/products/variant?id=${id}`,
        type: 'GET',
        success: function (res) {
            $('#sizes').html(res?.sizes)
            $('#show_slider').html(res?.slider)
            $('#variant_color').text(res?.color);
            adjust_cart_item(res?.product_id, res?.variant_id, res?.size_id, res?.price)
            document.querySelectorAll('[id*="variant"]').forEach(function (variant) {
                if (variant.id.includes(id)) {
                    variant.style.border = '1px solid black'
                } else {
                    variant.style.border = 'none'
                }
            })
        }
    })
}

function replace_size_name(name, index, product_id, variant_id, size_id, price) {
    document.getElementById('size_name').innerText = name
    adjust_cart_item(product_id, variant_id, size_id, price)
    document.querySelectorAll('[id*="size_name_radio"]').forEach(function (size) {
        if (size.id.includes(index)) {
            size.style.border = '1px solid black'
        } else {
            size.style.border = 'none'
        }
    })
}

function adjust_cart_item(product_id, variant_id, size_id, price) {
    var btn = document.getElementById('add_to_cart_button')
    btn.removeAttribute('onclick')
    btn.setAttribute('onclick', `add_to_cart('${product_id}', '${variant_id}', '${size_id}', 1, '${price}', 'add')`)
}

function showcase_image(li) {
    li.click()
}

function add_to_cart(product_id, variant_id, size_id, quantity, amount, key) {
    var loader = document.getElementById('loader')
    var overlay = document.getElementById('overlay')
    loader.style.display = 'flex'
    overlay.classList.remove('hidden')
    var csrfToken = $('meta[name="csrf-token"]').attr('content');
    if (check_signed_in() === 'true') {
        $.ajax({
            url: '/shop/user/cart/add_to_cart',
            type: 'POST',
            data: {authenticity_token: csrfToken, key: key, product_id: product_id, variant_id: variant_id, size_id: size_id, quantity: quantity, amount: amount},
            success: function (res) {
                loader.style.display = 'none'
                overlay.classList.add('hidden')
                toastr.success(res?.message)
            }
        })
    } else {
        toastr.error('Please <a href="/" style="color: #fff; text-decoration: underline;">Sign in</a> to add items to your cart.')
    }
}

function buy_now() {
    if (check_signed_in() === 'true') {

    } else {
        toastr.error('Please <a href="/" style="color: #fff; text-decoration: underline;">Sign in</a> to proceed with your order.');
    }
}

function check_signed_in() {
    return '<%= current_user.present? %>'
}