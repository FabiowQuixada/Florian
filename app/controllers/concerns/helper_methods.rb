module HelperMethods extend ActiveSupport::Concern

  private

                     def model_class
                       Object.const_get model_class_name
                     end

                     def model_class_name
                       self.class.name[0..-11].singularize
                     end

                     def model_index_path
                       send(model_class.model_name.route_key + '_path')
                     end

                     def model_params
                       send(@model.model_name.singular + '_params')
                     end

                     included do
                       before_action :authenticate_user!
                       load_and_authorize_resource
                     end
end
