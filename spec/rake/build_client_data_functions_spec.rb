require 'rails_helper'

describe 'build_client_data:functions' do
  include_context 'rake'

  it 'creates a server functions file to be used by the client' do
    filename = 'app/frontend/javascripts/server_functions.js'
    File.delete filename if File.file? filename
    subject.invoke
    expect(File.file?(filename)).to be true
  end
end
