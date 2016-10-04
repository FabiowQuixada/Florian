require 'rails_helper'

describe RegistrationsController, type: :controller do
  before :each do
    sign_in User.first
  end
end
