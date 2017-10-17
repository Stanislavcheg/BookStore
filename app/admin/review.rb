ActiveAdmin.register Review do
  actions :all, except: %i[edit create destroy new]
  config.filters = false
  permit_params :status
  includes :book, :user
  scope :unprocessed, default: true
  scope :processed

  index do
    column :book
    column :title
    column :date
    column 'User' do |review|
      review.user.email
    end
    column :status
    actions
  end

  show do
    attributes_table do
      row :book
      row :title
      row :date
      row 'User' do |review|
        review.user.email
      end
      row :status
      row :description
      row 'Action' do |review|
        if review.status == 'Unprocessed'
          (link_to 'Approve', approve_admin_review_path(review), method: :put) + ' ' +
          (link_to 'Reject', reject_admin_review_path(review), method: :put)
        end
      end
    end
  end

  member_action :approve, method: :put do
    review = Review.find(params[:id])
    review.update_attributes(status: 'Approved')
    redirect_to admin_reviews_path
  end

  member_action :reject, method: :put do
    review = Review.find(params[:id])
    review.update_attributes(status: 'Rejected')
    redirect_to admin_reviews_path
  end
end
