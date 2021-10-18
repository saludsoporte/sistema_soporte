class PagesController < ApplicationController
  def qr_code_generator
    send_data RQRCode::QRCode.new(params[:qr]).as_png(size: 300), type: 'image/png', disposition: 'attachment' 
  end
  
end

