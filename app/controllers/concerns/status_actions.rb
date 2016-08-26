module StatusActions extend ActiveSupport::Concern

                     include HelperMethods

                     def activate
                       model = model_class.find params[:id]
                       model.active = true
                       model.save

                       render json: { message: model.was('activated'), id: model.id, activated: true }
                     rescue => exc
                       exception_message = handle_exception exc, exc.message
                       return render json: exception_message, status: :unprocessable_entity
                     end

                     def deactivate
                       model = model_class.find params[:id]
                       model.active = false
                       model.save

                       render json: { message: model.was('deactivated'), id: model.id, activated: false }
                     rescue => exc
                       exception_message = handle_exception exc, exc.message
                       return render json: exception_message, status: :unprocessable_entity
                     end
end
