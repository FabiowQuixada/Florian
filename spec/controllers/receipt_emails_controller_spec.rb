require 'rails_helper'

describe ReceiptEmailsController, type: :controller do
  include LocaleHelper

  before :each do
    sign_in User.first
  end

  include_examples 'index request tests'
  include_examples 'new request tests'
  include_examples 'create request tests'
  include_examples 'edit request tests'
  include_examples 'update request tests', recipients_array: 'remark', value: 1.14
  include_examples 'destroy tests'

  # == E-mail deliveries =======================================================================================

  describe 'POST #resend' do
    context 'with valid attributes' do
      let(:model) { create :receipt_email }
      let(:expected) do
        {
          message: model.was('resent'),
          date: I18n.localize(Date.today, format: :default_i),
          maintainer: model.maintainer.name,
          value: ActionController::Base.helpers.number_to_currency(model.value),
          type: I18n.t('enums.email_history.send_type.resend'),
          user: model.history.last.user.name
        }.to_json
      end


      before :each do
        post :resend, id: model.id, competence: '06/2016', receipt_email: attributes_for(:receipt_email, recipients_array: 'aa@aa.com')
      end

      it { expect(response.body).to eq(expected) }
      it { expect(response).to be_success }
    end

    context 'with invalid attributes' do
      let(:model) { create :receipt_email }

      it 'displays an invalid competence message' do
        post :resend, id: model.id, competence: Date.today, receipt_email: attributes_for(:receipt_email, recipients_array: 'aa@aa.com')

        expect(response.body).to eq I18n.t('alert.email.invalid_competence')
      end

      it 'displays a invalid e-mail error message' do
        post :resend, id: model.id, competence: '06/2016', receipt_email: attributes_for(:receipt_email, recipients_array: nil)

        expected = {
          recipients_array: [I18n.t('errors.email.one_recipient')]
        }.to_json

        expect(response.body).to eq(expected)
      end

      it 'handles invalid competence' do
        model = create :receipt_email
        post :resend, id: model.id, competence: '076/2016', receipt_email: attributes_for(:receipt_email, recipients_array: 'aa@aa.com')
        expect(response.body).to eq(I18n.t('alert.email.invalid_competence'))
      end

      it 'handles invalid data' do
        model = create :receipt_email
        post :resend, id: model.id, competence: '06/2016'
        expect(response.body).to eq I18n.t('alert.email.error_resending')
      end
    end

    describe 'POST #send_test' do
      context 'with valid attributes' do
        let(:model) { create :receipt_email, :with_history }
        let(:expected) do
          {
            message: model.was('test_sent'),
            date: I18n.localize(Date.today, format: :default_i),
            maintainer: model.maintainer.name,
            value: ActionController::Base.helpers.number_to_currency(model.value),
            type: I18n.t('enums.email_history.send_type.test'),
            user: User.first.name
          }.to_json
        end

        before(:each) do
          post :send_test, id: model.id, competence: '06/2016', receipt_email: attributes_for(:receipt_email, recipients_array: 'aa@aa.com')
        end

        it { expect(response.body).to eq(expected) }
      end

      context 'with invalid attributes' do
        let(:model) { create :receipt_email }

        it 'displays an invalid competence message' do
          post :resend, id: model.id, competence: Date.today, receipt_email: attributes_for(:receipt_email, recipients_array: 'aa@aa.com')

          expect(response.body).to eq I18n.t('alert.email.invalid_competence')
        end

        it 'displays a invalid e-mail error message' do
          post :resend, id: model.id, competence: '06/2016', receipt_email: attributes_for(:receipt_email, recipients_array: nil)

          expected = {
            recipients_array: [I18n.t('errors.email.one_recipient')]
          }.to_json

          expect(response.body).to eq(expected)
        end
      end

      it 'handles invalid competence' do
        model = create :receipt_email
        post :send_test, id: model.id, competence: '076/2016', receipt_email: attributes_for(:receipt_email, recipients_array: 'aa@aa.com')
        expect(response.body).to eq(I18n.t('alert.email.invalid_competence'))
      end

      it 'handles invalid data' do
        model = create :receipt_email
        post :send_test, id: model.id, competence: '06/2016'
        expect(response.body).to eq I18n.t('alert.email.error_sending_test')
      end
    end
  end
end
