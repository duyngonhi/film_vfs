module ExportCsv
  extend ActiveSupport::Concern

  included do
    def respond_to_csv object
      respond_to do |format|
        format.html
        format.csv {send_data object.to_csv}
      end
    end
  end
end
