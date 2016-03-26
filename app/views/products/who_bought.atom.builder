atom_feed do |feed|
	feed.title "Who bought #{@product.title}"

	feed.updated @latest_order.try(:updated_at)

	@product.orders.each do |order|
		feed.entry(order) do |entry|
			entry.title "Order #{order_id}"
			entry.summary type: 'xhtml' do |xhtml|
				xhtml.p "Shipped to #{order.address}"

				xhtml.table do
					xhtml.tr do
						xhtml.th 'Product'
						xhtml.th 'Quantity'
						xhtml.th 'Total Price'
					end

					order.line_items.each do |item|
						xhtml.tr do
							xhtml.th item.product.title
							xhtml.th item.quantity
							xhtml.th number_to_currency item.total_price
						end
					end

					xhtml.tr do
						xhtml.th 'total', colspan: 2
						xhtml.th number_to_currency \
						    order.line_items.map(&:total_price).sum
					end
				end

				xhtml.p "Paid by #{order.pay_type}"
			end
			entry.author do |author|
				author.name order.name
				author.email order.email
			end
		end
	end
end

