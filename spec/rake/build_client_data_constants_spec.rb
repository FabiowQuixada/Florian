require 'rails_helper'

describe 'build_client_data:constants' do
  include_context 'rake'

  it 'creates a server constants file to be used by the client' do
    filename = 'app/frontend/javascripts/server_constants.js'
    File.delete filename if File.file? filename
    subject.invoke
    expect(File.file?(filename)).to be true
  end
end
