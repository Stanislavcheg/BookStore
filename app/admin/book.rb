ActiveAdmin.register Book do
  includes :authors, :category
  permit_params :id, :name, :price, :description, :year, :dimensions,
  :materials, :category_id, author_ids: []

  filter :name
  filter :authors
  filter :category
  filter :price

  index do
    selectable_column
    column :image
    column :category
    column :name
    column 'Authors' do |book|
      (book.authors.map{ |author| author.to_s }).join(', ').html_safe
    end
    column :short_description
    column 'Price', :price_euro
    actions
  end

  show do
    attributes_table do
      row :id
      row :name
      row 'Authors' do |book|
        (book.authors.map{ |author| author.to_s }).join(', ').html_safe
      end
      row :description
      row 'Price' do |book|
        book.price_euro
      end
      row :category
      row :materials
      row :dimensions
      row :year
      row :created_at
      row :updated_at
    end
  end

  form html: { multipart: true } do |f|
    f.inputs 'Book details' do
      f.input :name
      f.input :authors
      f.input :description
      f.input :price
      f.input :category
      f.input :materials
      f.input :dimensions
      f.input :year
    end
    f.actions
  end
end
