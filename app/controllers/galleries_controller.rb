class GalleriesController < InheritedResources::Base

  before_action :authenticate_user!, :except => [:index, :show]

  def new
    @attachment = Attachment.new
    @gallery = Gallery.new
  end

  def edit
    @attachment = Attachment.new
    @gallery = Gallery.find(params[:id])
    if !user_owns_gallery?(@gallery)
      redirect_to gallery_path, notice: "You cannot edit this gallery. Sign in and try again!" and return
    end
  end

  def update
    gallery = Gallery.find(params[:id])
    if !user_owns_gallery?(gallery)
      redirect_to gallery_path, notice: "You cannot update this gallery. Sign in and try again!" and return
    end

    params_surrogate = gallery_edit_params.dup

    existing_attachments = params_surrogate.delete(:existing_attachments)
    new_attachments = params_surrogate.delete(:attachments)

    existing_attachments.each do |att|
      attachment = Attachment.find(att[:id])
      attachment.caption = att[:caption]
      attachment.save!
    end

    if !!new_attachments
      fresh_attachments = new_attachments[:photo].map do |photo|
        Attachment.create!(photo: photo)
      end
      gallery.attachments << fresh_attachments
    end
    
    gallery.update!(params_surrogate)
    redirect_to(gallery)
  end

  def create
    attachment_params = params[:gallery].delete(:attachments)
    gallery = Gallery.create!(gallery_params)

    if attachment_params
      attachments = attachment_params[:photo].map do |photo|
        Attachment.create!(photo: photo)
      end
      gallery.attachments << attachments
      gallery.save!      
    end
    
    redirect_to(gallery)
  end

  private

  def user_owns_gallery?(gallery)
    return true if current_user == gallery.user
    return false
  end

  def gallery_params
    params.require(:gallery).permit(:user_id, :description, :title, attachments: [photo:[]])      
  end

  def gallery_edit_params
    params.require(:gallery).permit(:description, :title, existing_attachments: [:id, :caption], attachments: [photo:[]])
  end

end
