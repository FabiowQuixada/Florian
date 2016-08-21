require 'rails_helper'

describe ApplicationHelper do
  let(:dummy_class) { Class.new { include ApplicationHelper } }

  it { expect(dummy_class.new.bold('joao')).to eq '<span class="thick">joao</span>' }
end
