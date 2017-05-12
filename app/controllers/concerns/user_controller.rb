module UserController
  extend ActiveSupport::Concern

  included do
    def response_to_message message, url
      respond_to do |format|
        format.html {redirect_to url, notice: message}
        format.json {head :no_content}
      end
    end
  end
end
