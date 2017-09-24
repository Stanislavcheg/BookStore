AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?
OrderStatus.create!([{ name: 'In progress' }, { name: 'Waiting for processing' },
  { name: 'In delivery' }, { name: 'Delivered' }, { name: 'Canceled' }])
Delivery.create!([{ method: 'Standard Shipping', days: "10-14 days", price: 34.22 },
  { method: 'Priority Shipping', days: "2-5 days", price: 65.49 }])
Coupon.create!([{ code: 'book_store', discount: 0.15 }])
Category.create!([{name: 'Mobile development'}, {name: 'Web development'}, {name: 'Web design'}, {name: 'Photo'}])

