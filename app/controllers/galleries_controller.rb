class GalleriesController < InheritedResources::Base

  # before_filter :set_attachment
  # def set_attachment
  #   @attachment = Attachment.new
  # end

  def new
    p params
    @attachment = Attachment.new
    @gallery = Gallery.new
  end

  def edit
    @attachment = Attachment.new
    @gallery = Gallery.find(params[:id])
  end

  def create
    # p params[:gallery][:attachments]
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

end
