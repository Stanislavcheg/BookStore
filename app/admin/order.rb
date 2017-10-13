ActiveAdmin.register Order do
  permit_params :order_status
  config.filters = false
  actions :all, except: [:show, :create, :destroy, :new]

  scope :in_progress, default: true
  scope :delivered
  scope :canceled

  index do
    column 'Number', :order_number
    column 'State' do |order|
      order.order_status.html_safe + ' ' +
      (link_to 'Change', edit_admin_order_path(order))
    end
    column 'Date of creation', :created_at
  end

  form html: { multipart: true } do |f|
    f.inputs 'Change status' do
      f.input :order_status, as: :select, collection: order.decorate.available_statuses,
      include_blank: false
    end
    f.actions
  end
end
