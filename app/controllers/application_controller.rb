class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?

    protected

    def configure_permitted_parameters
        added_attrs = [:username, :nombre,:apellido_paterno,:apellido_materno, :email, :password, :password_confirmation, :remember_me,:area,:subdireccion,:direccion,:departamento,:unidad,:id]
        devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
        devise_parameter_sanitizer.permit :sign_in, keys: [:login, :password]
        devise_parameter_sanitizer.permit :account_update, keys: added_attrs
    end 
end
