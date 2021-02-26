class AttachmentsController < InheritedResources::Base

  before_action :authenticate_user!

  def destroy
    @attachment = Attachment.find(params[:id])
    gallery = @attachment.gallery

    if gallery.user == current_user
      @image = ActiveStorage::Attachment.find(params[:id])
      @image.purge
      @attachment.delete
    end

    redirect_to edit_gallery_path(gallery)
  end

  private

    def attachment_params
      params.require(:attachment).permit(:caption, :photo)
    end

end
