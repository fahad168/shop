module Shop
  class Variant
    attr_reader :product_id, :variant_id, :name, :color

    # Get Specific Product Variants
    def specific_product_variants(product_id, order, q)
      variants = if q.present?
                   ::Variant.where("LOWER(name) ILIKE :query OR LOWER(color) ILIKE :query ", query: "%#{q.downcase}%")
                 else
                   ::Variant.where(product_id: product_id).order(created_at: order)
                 end
      return_response(variants)
    end

    # Creates a new Variant
    def create(product_id, name, color)
      variant = ::Variant.new(product_id: product_id, name: name, color: color)
      if variant.save
        { message: "Variant Created Successfully", variant: variant, status: :created }
      else
        { message: variant.errors.full_messages, variant: nil, status: :unprocessable_entity }
      end
    end

    # Updates an existing Variant
    def update(variant_id, variant_hash)
      return { message: "Variant not found", variant: nil, status: :not_found } unless (variant =  ::Variant.find_by(id: variant_id))

      if variant.update(variant_hash)
        { message: "Variant Updated Successfully", variant: variant, status: :updated }
      else
        { message: variant.errors.full_messages, variant: nil, status: :unprocessable_entity }
      end
    end

    # Deletes the Variant
    def delete(variant_id)
      return { message: "Variant not found", variant: nil, status: :not_found } unless (variant =  ::Variant.find_by(id: variant_id))

      if variant.destroy
        { message: "Variant Deleted Successfully", variant: nil, status: :deleted }
      else
        { message: variant.errors.full_messages, variant: nil, status: :unprocessable_entity }
      end
    end

    private

    def return_response(variants)
      if variants.present?
        { message: "Variants Found Successfully", variants: variants, status: :found }
      else
        { message: "No Variants Found For This Product", variants: nil, status: :not_found }
      end
    end
  end
end
