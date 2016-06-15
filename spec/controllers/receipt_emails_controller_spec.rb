require 'rails_helper'

describe ReceiptEmailsController, type: :controller do
  before(:each) do
    sign_in User.first
  end

  describe 'GET #index' do
    before(:each) do
      get :index
    end

    it { expect(response).to have_http_status(:ok) }
    it { expect(response).to render_template('index') }
    it { expect(response).to be_success }
  end

  describe 'GET #new' do
    before(:each) do
      get :new
    end

    it { expect(response).to have_http_status(:ok) }
    it { expect(response).to render_template '_form' }
    it { expect(response).to be_success }
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates a new receipt_email' do
        expect { post :create, receipt_email: build(:receipt_email).attributes }.to change { ReceiptEmail.count }.by(1)
      end

      it 'redirects to index' do
        post :create, receipt_email: build(:receipt_email).attributes

        expect(response).to have_http_status(:found)
        expect(response).to redirect_to receipt_emails_path
      end
    end

    context 'with invalid attributes' do
      it 'does not create a new receipt_email' do
        expect { post :create, receipt_email: attributes_for(:receipt_email, :invalid) }.not_to change { ReceiptEmail.count }
      end

      it 're-renders new' do
        post :create, receipt_email: attributes_for(:receipt_email, :invalid)

        expect(response).to have_http_status(:ok)
        expect(response).to render_template('_form')
      end
    end
  end

  describe 'GET #edit' do
    before(:each) do
      get :edit, id: create(:receipt_email)
    end

    it { expect(response).to have_http_status(:ok) }
    it { expect(response).to be_success }
  end

  describe 'PUT #update' do
    context 'with valid attributes' do
      before(:each) do
        @model = create :receipt_email
        put :update, id: @model.id, receipt_email: attributes_for(:receipt_email, recipients_array: 'remark', value: 1.14)
        @model.reload
      end

      it { expect(response).to have_http_status(:found) }
      it { expect(response).to redirect_to receipt_emails_path }
      it { expect(assigns(:receipt_email)).to eq(@model) }
      it { expect(@model.recipients_array).to eq('remark') }
      it { expect(@model.value).to eq(ActionController::Base.helpers.number_to_currency(1.14)) }
    end

    context 'with invalid attributes' do
      before(:each) do
        @model = create :receipt_email
        put :update, id: @model.id, receipt_email: attributes_for(:receipt_email, recipients_array: nil, value: nil)
        @model.reload
      end

      it { expect(response).to have_http_status(:ok) }
      it { expect(response).to render_template('_form') }
      it { expect(assigns(:receipt_email)).to eq(@model) }
      it { expect(@model.recipients_array).not_to be_nil }
      it { expect(@model.value).not_to eq(ActionController::Base.helpers.number_to_currency(1.14)) }
    end
  end

  # == E-mail deliveries =======================================================================================

  describe 'POST #resend' do
    context 'with valid attributes' do
      before(:each) do
        @model = create :receipt_email
        post :resend, id: @model.id, competence: '06/2016', receipt_email: attributes_for(:receipt_email, recipients_array: 'aa@aa.com')

        @expected = {
          message: 'E-mail de recibo reenviado com sucesso!',
          date: I18n.localize(Date.today, format: :default_i),
          company: @model.company.name,
          value: ActionController::Base.helpers.number_to_currency(@model.value),
          type: 'Reenvio',
          user: @model.history.last.user.name
        }.to_json
      end

      it { expect(response.body).to eq(@expected) }
      it { expect(response).to be_success }
    end

    context 'with invalid attributes' do
      it 'displays an invalid competence message' do
        @model = create :receipt_email
        post :resend, id: @model.id, competence: Date.today, receipt_email: attributes_for(:receipt_email, recipients_array: 'aa@aa.com')

        expect(response.body).to eq('Competência inválida;')
      end

      it 'displays a invalid e-mail error message' do
        @model = create :receipt_email
        post :resend, id: @model.id, competence: '06/2016', receipt_email: attributes_for(:receipt_email, recipients_array: nil)

        @expected = {
          recipients_array: ['O e-mail deve ter pelo menos um destinatário;']
        }.to_json

        expect(response.body).to eq(@expected)
      end

      #  TODO If FlorianMailer raises an exception
      # it 'displays a unkown error message' do
      #   @model = create :receipt_email
      #   post :resend, id: @model.id, competence: '06/2016', receipt_email: attributes_for(:receipt_email, recipients_array: 'aa@aa.com')
      #   expect(response.body).to eq(@expected)
      # end
    end

    describe 'POST #send_test' do
      context 'with valid attributes' do
        before(:each) do
          @model = create :receipt_email
          post :send_test, id: @model.id, competence: '06/2016', receipt_email: attributes_for(:receipt_email, recipients_array: 'aa@aa.com')

          @expected = {
            message: 'E-mail de recibo de teste enviado com sucesso!',
            date: I18n.localize(Date.today, format: :default_i),
            company: @model.company.name,
            value: ActionController::Base.helpers.number_to_currency(@model.value),
            type: 'Teste',
            user: @model.history.last.user.name
          }.to_json
        end

        it { expect(response.body).to eq(@expected) }
      end

      context 'with invalid attributes' do
        it 'displays an invalid competence message' do
          @model = create :receipt_email
          post :resend, id: @model.id, competence: Date.today, receipt_email: attributes_for(:receipt_email, recipients_array: 'aa@aa.com')

          expect(response.body).to eq('Competência inválida;')
        end

        it 'displays a invalid e-mail error message' do
          @model = create :receipt_email
          post :resend, id: @model.id, competence: '06/2016', receipt_email: attributes_for(:receipt_email, recipients_array: nil)

          @expected = {
            recipients_array: ['O e-mail deve ter pelo menos um destinatário;']
          }.to_json

          expect(response.body).to eq(@expected)
        end
      end

      #  TODO If FlorianMailer raises an exception
      # it 'displays a unkown error message' do
      #   @model = create :receipt_email
      #   post :resend, id: @model.id, competence: '06/2016', receipt_email: attributes_for(:receipt_email, recipients_array: 'aa@aa.com')
      #   expect(response.body).to eq(@expected)
      # end
    end
  end

  describe 'Successfully deletes model as admin' do
    # Admin, xhr, if there was an error
    before(:each) do
      sign_in User.first
      create :receipt_email
      @n = ReceiptEmail.count
      @model = ReceiptEmail.first
      
      @sucess_msg = { message: @model.was('destroyed'), success: true }.to_json
      @error_msg = { message: I18n.t('errors.deletion'), success: false }.to_json
      @non_admin_msg = { message: I18n.t('errors.unpermitted_action'), success: false }.to_json
    end

    context 'Successfully destroys model via ajax' do
      before(:each) do
        xhr :delete, :destroy, id: @model.id
      end
      
      it { expect(ReceiptEmail.count).to eq(@n-1) }
      it { expect(response.body).to eq(@sucess_msg) }
    end
  end

  describe 'Doesnt destroy model as common user' do
    before(:each) do
      sign_in User.last
      create :receipt_email
      @n = ReceiptEmail.count
      @model = ReceiptEmail.first
      
      @sucess_msg = { message: @model.was('destroyed'), success: true }.to_json
      @error_msg = { message: I18n.t('errors.deletion'), success: false }.to_json
      @non_admin_msg = { message: I18n.t('errors.unpermitted_action'), success: false }.to_json
    end

    context 'Common user cant destroy model via ajax' do
      before(:each) do
        xhr :delete, :destroy, id: @model.id
      end
      
      it { expect(ReceiptEmail.count).to eq(@n) }
      it { expect(response.body).to eq(@non_admin_msg) }
    end
  end
end
