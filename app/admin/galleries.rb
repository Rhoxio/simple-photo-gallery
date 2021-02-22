ActiveAdmin.register Gallery do

  index do
    selectable_column
    id_column
    column :title
    li do
      label :description, class: 'trix-editor-label'
      f.rich_text_area :description
    end
    column :created_at
    column :updated_at
    column "Attached Photo Count" do |gallery|
      gallery.attachments.length
    end    
    actions
  end  

  show do |gallery|
    default_main_content
    attributes_table do
      row :attachments do |gallery|
        gallery.attachments.each do |att|        
          if att.photo.attached?
            image_tag att.photo, class: 'admin-image', width: 200
          end
        end
      end
    end
  end 
  
end
