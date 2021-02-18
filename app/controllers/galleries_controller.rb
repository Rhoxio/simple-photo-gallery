class GalleriesController < InheritedResources::Base

  before_action :authenticate_user!, :except => [:index, :show]

  def new
    @attachment = Attachment.new
    @gallery = Gallery.new
  end

  def edit
    @attachment = Attachment.new
    @gallery = Gallery.find(params[:id])
    if !validate_user_gallery_ownership(@gallery)
      redirect_to gallery_path, notice: "You cannot edit this gallery. Sign in and try again!" and return
    end
  end

  def update
    gallery = Gallery.find(params[:id])
    validate_user_gallery_ownership(gallery)

    params_surrogate = gallery_edit_params.dup

    existing_attachments = params_surrogate.delete(:existing_attachments)
    new_attachments = params_surrogate.delete(:attachments)

    existing_attachments.each do |att|
      attachment = Attachment.find(att[:id])
      attachment.caption = att[:caption]
      attachment.save!
    end

    fresh_attachments = new_attachments[:photo].map do |photo|
      Attachment.create!(photo: photo)
    end

    gallery.attachments << fresh_attachments
    gallery.update!(params_surrogate)

  end

  def create
    attachment_params = params[:gallery].delete(:attachments)
    gallery = Gallery.create!(gallery_params)

    attachments = []
    attachment_params[:photo].each do |photo|
      a = Attachment.create!(photo: photo)
      attachments.push(a)
    end

    gallery.attachments << attachments
    gallery.save!
    redirect_to(gallery)
  end

  private

  def validate_user_gallery_ownership(gallery)
    return true if current_user == gallery.user
    return false
  end

  def gallery_params
    params.require(:gallery).permit(:description, :title, attachments: [photo:[]])      
  end

  def gallery_edit_params
    params.require(:gallery).permit(:description, :title, existing_attachments: [:id, :caption], attachments: [photo:[]])
  end

end
