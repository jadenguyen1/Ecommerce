json.extract! order_item, :id, :order_id, :book_id, :quantity, :unit_price, :created_at, :updated_at
json.url order_item_url(order_item, format: :json)
