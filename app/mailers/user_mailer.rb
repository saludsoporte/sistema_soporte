class UserMailer < ApplicationMailer
  #  default from: "omarvaladez59@gmail.com"
    #Ex:- :default =>''
    def welcome_email(user_id,folio)        
        @folio=folio
        @user = User.find(user_id)
        unless @user.email.nil?
          mail(to: @user.email.to_s,subject:"Solicitud Terminada !!!!")        
        end 
    end

    def solicitud_cancelada(user_id)
     
      @user = User.find(user_id)
      unless @user.email.nil?
        mail(to: @user.email.to_s,subject:"La Solicitud no ha procedido !!!!")        
      end
    end
end
