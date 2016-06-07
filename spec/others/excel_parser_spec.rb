require "rails_helper"

describe ExcelParser do

  it 'loads the companies appropriately from excel file' do
    expect(ExcelParser.parse).to be_empty
  end

end