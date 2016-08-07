# require 'rails_helper'

# describe User, type: :request do
#   let(:signature) { 'lalala' }

#   before :each do
#     login_as_admin
#   end

#   it 'updates logged user info' do
#     visit edit_user_registration_path

#     fill_fields

#     click_on 'Atualizar'

#     visit edit_user_registration_path

#     # expect(first('#user_signature').value).to eq signature
#   end

#   # == Helper methods =============================================================

#   def fill_fields
#     fill_in 'Assinatura', with: signature
#     fill_in 'Senha atual', with: 'fulano0123'
#   end
# end
