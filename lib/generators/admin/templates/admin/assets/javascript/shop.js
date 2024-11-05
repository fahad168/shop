Coloris({
    themeMode: 'white',
    alpha: true,
    formatToggle: true,
    focusInput: true,
    swatches: ['#EF4444', '#F97316', '#FACC15', '#4ADE80', '#2DD4BF', '#3B82F6', '#6366F1', '#EC4899', '#F43F5E', '#D946EF', '#8B5CF6', '#8B5CF6', '#10B981', '#84CC16'],
    defaultColor: '#000000',
})

$('.nice-select').niceSelect();
$('.country_select').chosen({
    disable_search_threshold: 10,
    placeholder_text_multiple: 'Select Country',
    no_results_text: 'No Size found',
    width: '100%'
})

$('#product_form').on('submit', function (e) {
    e.preventDefault()
    if (variant_count > 0) {
        this.submit()
    } else {
        document.getElementById('variant_error').innerText = 'There must be one variant against product'
    }
})

function show_variants_fields() {
    $.ajax({
        url: `/shop/admin/products/variant_fields?count=${count}`,
        method: 'GET',
        success: function (res) {
            document.getElementById('variants').insertAdjacentHTML('beforeend', res?.entries);
            createFileInput(count)
            $(`.chosen-select${count}`).chosen({
                disable_search_threshold: 10,
                placeholder_text_multiple: 'Select',
                no_results_text: 'No Size found',
                width: '100%'
            }).change(function () {
                const selectedValues = $(this).val();
                const quantity_count = this.id
                var main_div = $(`#quantity${quantity_count}`)
                if (selectedValues.length === 0) {
                    main_div.empty()
                }
                const inputIds = Array.from(main_div[0].childNodes).map(child => child.querySelector('input')?.id).filter(Boolean);
                selectedValues.forEach(function (value) {
                    if (main_div[0].childNodes.length > 0) {
                        removeQuantityElement(inputIds, selectedValues, main_div)
                        if (!inputIds.includes(value)) {
                            create_quantity_field(value, `quantity${quantity_count}`, `variant${quantity_count}`);
                        }
                    } else {
                        create_quantity_field(value, `quantity${quantity_count}`, `variant${quantity_count}`);
                    }
                })
            });
            count += 1
            variant_count += 1
            var submitButton = document.getElementById('product_submit')
            submitButton.removeAttribute('disabled')
            submitButton.style.cursor = 'pointer'
        }
    })
}

function create_quantity_field(value, id, name) {
    const mainDiv = document.createElement('div');
    mainDiv.classList.add('mb-6');

    const innerDiv = document.createElement('div');
    innerDiv.classList.add('w-full', 'sm:max-w-[327px]');

    const label = document.createElement('label');
    label.classList.add('block', 'mb-2', 'text-sm', 'font-normal', 'text-[#000000]', 'dark:text-white');
    label.textContent = `Quantity (${value})`;

    const input = document.createElement('input');
    input.setAttribute('type', 'number');
    input.classList.add(
        'border', 'border-[#e8e8e8]', 'rounded-[5px]', '!outline-none',
        'text-[#000000]', 'text-sm', 'placeholder-black', 'block', 'w-full', 'px-5', 'py-[10px]',
        'dark:text-white', 'dark:bg-gray-700', 'dark:placeholder-gray-400', 'dark:border-none'
    );
    input.setAttribute('id', `${value}`)
    input.setAttribute('placeholder', 'Enter');
    input.required = true;
    input.setAttribute('name', `${name}[in_stock][]`)

    innerDiv.appendChild(label);
    innerDiv.appendChild(input);
    mainDiv.appendChild(innerDiv);
    document.getElementById(id).appendChild(mainDiv)
}

function removeQuantityElement(inputIds, selectedValues, main_div) {
    inputIds.forEach(function (id) {
        if (!selectedValues.includes(id)) {
            const inputElement = main_div[0].querySelector(`input[id='${id}']`);
            if (inputElement) {
                inputElement.parentElement.parentElement.remove();
            }
        }
    })
}

function delete_variant(count, id) {
    var ids = document.getElementById(`product_variants`)
    if (ids) {
        var idsArray = JSON.parse(ids.value)
        const filteredArray = idsArray.filter(variant_id => variant_id !== id);
        ids.value = JSON.stringify(filteredArray)
    }
    $(`#variant${count}`).remove()
    variant_count -= 1
    if (variant_count === 0) {
        var submitButton = document.getElementById('product_submit')
        submitButton.setAttribute('disabled', 'true')
        submitButton.style.cursor = 'no-drop'
    }
}

function removeImageWithId(count, filename, id) {
    var ids = document.getElementById(`variant_edit_images_${count}`)
    var idsArray = JSON.parse(ids.value)
    const filteredArray = idsArray.filter(file_id => file_id !== id);
    ids.value = JSON.stringify(filteredArray)
    if(filteredArray.length === 0) {
        var selectedImages = document.getElementById(`dropzone-file-${count}`);
        if(selectedImages.files.length === 0) {
            selectedImages.setAttribute('required', 'true')
        }
    }
    document.getElementById(`selected_div_${count}_${filename}`).remove()
}

function show_selected_images(count, event) {
    var dataTransfer = new DataTransfer();
    Array.from(event.target.files).forEach(function (file) {
        dataTransfer.items.add(file);
    });

    var existingFiles = document.getElementById(`previously_selected_${count}`).files;
    if (existingFiles?.length > 0) {
        Array.from(existingFiles).forEach(function (file) {
            dataTransfer.items.add(file);
        });
    }
    var files = Array.from(dataTransfer.files);
    document.getElementById(`previously_selected_${count}`).files = dataTransfer.files
    document.getElementById(`dropzone-file-${count}`).files = dataTransfer.files
    $(`#selectedImages${count}`).empty()
    var cross = document.getElementById('cross_circle')

    files.forEach(function (file) {
        var reader = new FileReader();
        var filename = file.name
        reader.onload = function (loadedFile) {
            var div = document.createElement('div')
            div.classList.add('relative')
            div.setAttribute('id', `selected_div_${count}_${filename}`)
            var element = new Image()
            element.src = loadedFile.target.result;
            element.setAttribute("class", "object-cover w-[150px] h-[150px] rounded-2xl")
            var image = new Image()
            image.src = cross.src
            image.classList.add('absolute', 'w-4', 'h-4', 'right-[4%]', 'top-[4%]', 'cursor-pointer', 'hover:opacity-75')
            image.setAttribute('id', `image_${count}_${filename}`)
            image.addEventListener('click', function () {
                removeImage(count, filename)
            })
            element.setAttribute("id", `selected`)
            div.appendChild(image)
            div.appendChild(element)
            var main_div = document.getElementById(`selectedImages${count}`)
            main_div.appendChild(div)
        }
        reader.readAsDataURL(file);
    })
}

function removeImage(count, filename) {
    var previousSelectedImages = document.getElementById(`previously_selected_${count}`);
    var selectedImages = document.getElementById(`dropzone-file-${count}`);
    var filesArray = Array.from(previousSelectedImages.files);
    const filteredFiles = filesArray.filter(file => file.name !== filename);
    const dataTransfer = new DataTransfer();
    for (var i = 0; i < filteredFiles.length; i++) {
        dataTransfer.items.add(filteredFiles[i]);
    }
    selectedImages.files = dataTransfer.files
    previousSelectedImages.files = dataTransfer.files
    if(selectedImages.files.length === 0) {
        selectedImages.setAttribute('required', 'true')
    }
    document.getElementById(`selected_div_${count}_${filename}`).remove()
}
