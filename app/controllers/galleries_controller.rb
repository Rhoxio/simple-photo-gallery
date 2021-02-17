class GalleriesController < InheritedResources::Base

  def new
    @attachment = Attachment.new
    @gallery = Gallery.new
  end

  def edit
    @attachment = Attachment.new
    @gallery = Gallery.find(params[:id])
  end

  def update
    p gallery_edit_params
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

  def gallery_params
    params.require(:gallery).permit(:description, :title, attachments: [photo:[]])      
  end

  def gallery_edit_params
    params.require(:gallery).permit(:description, :title, existing_attachments: [:id, :caption], attachments: [photo:[]])
  end

end
