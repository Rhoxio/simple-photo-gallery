ActiveAdmin.register Attachment do

  index do
    selectable_column
    id_column
    column :caption
    column :created_at
    column :updated_at
    column "Photo" do |attachment|
      image_tag attachment.photo, class: 'admin-image', width: 200
    end    
    actions
  end  

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :caption, :gallery_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:caption, :gallery_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
