# Remove _wishlist_form, remove button {Add to wishlist} in spree/products/show
# Add button {Add to wishlist} in _cart_form, using replace {data-hook="product_price"}
Deface::Override.new(:virtual_path => "spree/products/_wishlist_form",
:name => "remove_wishlist_form",
:remove => "#wishlist-form")
