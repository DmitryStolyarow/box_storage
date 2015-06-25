Spree::OrderContents.class_eval do
  def add_to_line_item(variant, quantity, options = {})
    line_item = grab_line_item_by_variant(variant, false, options)
    opts = { currency: order.currency }.merge ActionController::Parameters.new(options).
                                        permit(Spree::PermittedAttributes.line_item_attributes)
    line_item = order.line_items.new(quantity: quantity,
                                     variant: variant,
                                     options: opts)

    line_item.target_shipment = options[:shipment] if options.has_key? :shipment
    line_item.save!
    line_item
  end

  private

  def filter_order_items(params)
    filtered_params = params.symbolize_keys
    return filtered_params if filtered_params[:line_items_attributes].nil? || filtered_params[:line_items_attributes][:id]

    line_item_ids = order.line_items.pluck(:id)

    params[:line_items_attributes].each_pair do |id, value|
      unless line_item_ids.include?(value[:id].to_i) || value[:variant_id].present?
        filtered_params[:line_items_attributes].delete(id)
      end
      # prevent to update line items with quantity more than 1
      filtered_params[:line_items_attributes][id]['quantity'] = '1' if filtered_params[:line_items_attributes][id]['quantity'].to_i > 1
    end
    filtered_params
  end
end
