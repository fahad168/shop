module Shop
  class Size
    attr_reader :variant_id,  :name, :short_form, :quantity

    def initialize
      super
    end

    # Specific Variant Sizes
    def specific_variant_sizes(variant_id, order, q)
      sizes = Size.where(variant_id: variant_id).order(created_at: order)
      sizes = sizes.where('LOWER(name) ILIKE ? OR LOWER(short_name) ILIKE ? ', "%#{q.downcase}%") if q.present?
      if sizes.present?
        { message: 'Sizes Found Successfully', sizes: sizes, status: :found }
      else
        { message: 'No Sizes Found For This Variant', sizes: nil, status: :not_found }
      end
    end

    # Creates a Single Size
    def create_single_size(variant_id, name, short_form, in_stock)
      size = Size.new(variant_id: variant_id, name: name, short_form: short_form, in_stock: in_stock)
      if size.save
        { message: 'Size Created Successfully', size: size, status: :created }
      else
        { message: size.errors.full_messages, size: nil, status: :unprocessable_entity }
      end
    end

    # Create Multiple Sizes
    def create_multiple_sizes(multiple_sizes_array)
      if Size.insert_all(multiple_sizes_array)
        { message: 'Sizes Created Successfully', size: nil, status: :created }
      else
        { message: "Not Created", size: nil, status: :unprocessable_entity }
      end
    end

    # Updates an existing Size
    def update(size_id, size_hash)
      return { message: 'Size not found', size: nil, status: :not_found } unless (@size = Size.find_by(id: size_id))

      if @size.update(size_hash)
        { message: 'Size Updated Successfully', size: @size, status: :updated }
      else
        { message: @size.errors.full_messages, size: nil, status: :unprocessable_entity }
      end
    end

    # Deletes the Size
    def delete(size_id)
      return { message: 'Size not found', size: nil, status: :not_found } unless (@size = Size.find_by(id: size_id))

      if @size.destroy
        { message: 'Size Deleted Successfully', size: nil, status: :deleted }
      else
        { message: @variant.errors.full_messages, size: nil, status: :unprocessable_entity }
      end
    end
  end
end
