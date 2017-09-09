class BookAttachmentsController < InheritedResources::Base

  private

    def book_attachment_params
      params.require(:book_attachment).permit(:book_id, :image)
    end
end

