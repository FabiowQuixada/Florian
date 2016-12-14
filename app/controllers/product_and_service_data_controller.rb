class ProductAndServiceDataController < ApplicationController

  include IndexAction
  include CreationActions
  include ModificationActions
  include DestroyAction

  private ###########################################################################################

  def product_and_service_datum_params
    params.require(:product_and_service_datum).permit(:id, :competence,
                                                      product_and_service_weeks_attributes: [:id, :number, :start_date, :end_date,
                                                                                             service_data_attributes: [:id, :psychology, :physiotherapy, :plastic_surgery, :mesh, :gynecology, :occupational_therapy],
                                                                                             product_data_attributes: [:id, :mesh, :cream, :protector, :silicon, :mask, :foam, :skin_expander, :cervical_collar]])
  end

  def breadcrumbs
    if params[:action] == 'index'
      Hash[I18n.t('menu.emails') => '', plural_of(model_class) => '']
    else
      Hash[I18n.t('menu.emails') => '', plural_of(model_class) => index_path]
    end
  end

  def index_query
    @q = ProductAndServiceDatum.ransack(params[:q])
    @q.result.eager_load(product_and_service_weeks: [:product_data, :service_data]).order(competence: :desc).page(params[:page])
  end

end
