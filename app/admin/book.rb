ActiveAdmin.register Book do
  includes :authors, :category
  permit_params :id, :name, :price, :description, :year, :dimensions,
  :materials, :category_id, {images:[]}, author_ids: []

  filter :name
  filter :authors
  filter :category
  filter :price

  index do
    selectable_column
    column 'Image' do |book|
      image_tag(book.images.first.url(:thumb)) if book.images.size >0
    end
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
      row 'Images' do |book|
        book.images.map{|i| image_tag(i.url(:normal)) }.join.html_safe
      end
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
      f.input :height
      f.input :width
      f.input :depth
      f.input :year
      hint = f.object.images.map{|i| image_tag(i.url(:thumb)) }.join.html_safe
      f.input :images, as: :file, required: true, input_html: { multiple: true }, hint: hint
    end
    f.actions
  end
end
