# app/admin/pages.rb
ActiveAdmin.register Page do
  # Only allow editing the Contact and About pages
  filter :title
  index do
    selectable_column
    id_column
    column :title
    column :content do |page|
      truncate(page.content, length: 100)
    end
    actions
  end

  form do |f|
    f.inputs do
      f.input :title
      f.input :content, as: :text, input_html: { rows: 20 }
    end
    f.actions
  end

  show do
    attributes_table do
      row :title
      row :content
    end
  end

  controller do
    # Restrict to only showing and updating the Contact and About pages
    def scoped_collection
      Page.where(title: ['Contact', 'About'])
    end
  end
end
