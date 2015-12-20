module MainConcern extend ActiveSupport::Concern

  module ClassMethods
    attr_reader :arguable_opts

    private

    def arguable(opts={})
      @arguable_opts = opts
    end

    def get_arguable_opts
      if self.class.arguable_opts.blank? && self.class.superclass.arguable_opts.present?
        opts = self.class.superclass.arguable_opts
      elsif self.class.arguable_opts.present? && self.class.superclass.arguable_opts.present?
        opts = self.class.superclass.arguable_opts.merge(self.class.arguable_opts)
      else
        opts = self.class.arguable_opts
      end
      opts || {}
    end

  end

  def index
    @list = model_class.order order_attribute

    #parse
  end

  def new
    render '_form'
  end

  def create

    @model = model_class.new params_validation

    if @model.save
      redirect_to send(@model.model_name.route_key + "_path"), notice: genderize_tag(@model, 'created')
    else
      render '_form'
    end
  end

  def edit
    render '_form'
  end

  def show
    render '_form'
  end

  def update
    if @model.update params_validation
      redirect_to send(@model.model_name.route_key + "_path"), notice: genderize_tag(@model, 'updated')
    else
      render '_form'
    end
  end

  private

  def model_class
    self.class.arguable_opts[:model_class]
  end

  included do
    before_action :before_new, only: [:new, :create]
    before_action :before_edit, only: [:edit, :update]
    before_action :before_show, only: [:show]
    before_action :before_index, only: [:index]
    before_action :authenticate_user!
  end

  def before_index
    @model = model_class.new

    @breadcrumbs = Hash[@model.model_name.human(:count => 2) => ""]
  end

  def before_new
    @model = model_class.new

    @breadcrumbs = Hash[@model.model_name.human(:count => 2) => send(@model.model_name.route_key + "_path"), t(@model.genderize('helpers.action.new')) => ""]
  end

  def before_edit
    @model = model_class.find(params[:id])

    @breadcrumbs = Hash[@model.model_name.human(:count => 2) => send(@model.model_name.route_key + "_path"), t('helpers.action.edit') => ""]
  end

  def before_show
    @model = model_class.find(params[:id])

    @breadcrumbs = Hash[@model.model_name.human(:count => 2) => send(@model.model_name.route_key + "_path"), t('helpers.action.show') => ""]
  end

  def order_attribute
    "created_at ASC"
  end

    def parse

         file = Roo::Excel.new(Rails.root.join('app', 'assets', 'test.xls'))

         file.worksheets.each_with_index do |sheet, index|

          # Get companies
          for r in 5..(sheet.count-1)

              row = sheet.rows[r]

              byebug if index > 0

              byebug if row.nil?

              company = parse_company row, (index+1)

              if !company.save
                  puts company.errors
                  byebug if index > 0
              end
          end # Row loop end

         end # Sheet loop end
    end

    private

    def parse_company(row, group)

      col = 1
      company = Company.new

      company.trading_name = row[col]
      company.name = row[col]

      cat = 1#0 ##########################################################
      col += 1
      if row[col] == 'I'
        cat = 1
        elsif row[col] == 'II'
          cat = 2
      elsif row[col] == 'III'
        cat = 3
      end

      company.category = cat
      company.group = group

      company.cnpj = row[col += 1]
      company.address = row[col += 1]
      company.neighborhood = row[col += 1]
      company.cep = row[col += 1]
      company.city = row[col += 1]
      company.state = row[col += 1]
      company.email_address = row[col += 1]
      company.website = row[col += 1]

      # Contacts
      col = 11

      contact1 = Contact.new

      contact1.name = row[col += 1]
      contact1.position = row[col += 1]
      col += 1
      contact1.telephone = '85' + row[col].to_s unless row[col].nil?
      col += 1
      contact1.fax = '85' + row[col].to_s unless row[col].nil?
      col += 1
      contact1.celphone = '85' + row[col].to_s unless row[col].nil?
      contact1.email_address = row[col += 1]
      contact1.contact_type = 0

      contact2 = Contact.new
      contact2.name = row[col += 1]
      contact2.position = 'Secretária'
      col += 1
      contact2.telephone = '85' + row[col].to_s unless row[col].nil?
      col += 1
      contact2.celphone = '85' + row[col].to_s unless row[col].nil?
      contact2.email_address = row[col += 1]
      contact2.contact_type = 1

      col += 1
      contact3 = Contact.new
      contact3.name = row[col += 1]
      contact3.position = 'Setor financeiro'
      col += 1
      contact3.telephone = '85' + row[col].to_s unless row[col].nil?
      col += 1
      contact3.celphone = '85' + row[col].to_s unless row[col].nil?
      contact3.email_address = row[col += 1]
      contact3.contact_type = 2

      company.contacts.clear
      company.contacts.push contact1
      company.contacts.push contact2
      company.contacts.push contact3

      # Donation fields ####################################################
      # company.payment_frequency = row[28]
      # company.payment_period = row[29]
      # company.first_parcel = row[30]
      # company.contract =row[32]

      company
  end

end