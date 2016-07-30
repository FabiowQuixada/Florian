shared_examples 'an e-mail address table' do
  it 'removes a transient e-mail address' do
    i = 0

    fields.each do |field_name|
      add_email_address field_name, i -= 1
      add_email_address field_name, i -= 1


      expect(first('tr#' + field_name + '_email_address_' + i.to_s)).not_to be_nil, described_class.name + ': ' + field_name
      expect(first('tr#' + field_name + '_email_address_' + i.to_s)).not_to be_nil, described_class.name + ': ' + field_name

      within('tr#' + field_name + '_email_address_' + i.to_s) do
        first('a.' + field_name + '_remove_recipient_btn').click
      end

      sleep(inspection_time = 1)

      expect(first('tr#' + field_name + '_email_address_' + i.to_s)).to be_nil, described_class.name + ': ' + field_name
      expect(first('tr#' + field_name + '_email_address_' + (i + 1).to_s)).not_to be_nil, described_class.name + ': ' + field_name

      # Ensures that other fields are not affected
      fields.each do |field_name_2|
        if field_name != field_name_2
          expect(first('tr#' + field_name + '_email_address_' + (i + 1).to_s)).not_to be_nil, described_class.name + ': ' + field_name + ', ' + field_name_2
        end
      end
    end
  end

  def add_email_address(field_name, i)
    first('input#' + field_name + '_new_recipient_field').set('exemplo' + i.to_s + '@gmail.com')
    first('span#' + field_name + '_add_recipient_btn').click
  end
end
