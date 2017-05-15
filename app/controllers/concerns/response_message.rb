module ResponseMessage
  extend ActiveSupport::Concern

  included do
    def response_to_message message, url
      respond_to do |format|
        format.html {redirect_to url, notice: message}
        format.json {head :no_content}
      end
    end

    def response_message_errors object
      respond_to do |format|
        format.html {render :new}
        format.json {render json: object.errors, status: :unprocessable_entity}
      end
    end
  end
end
