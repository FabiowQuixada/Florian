# rubocop:disable all
shared_examples 'an e-mail address table' do |fields|
  let(:fields) { fields }

  it 'removes a transient e-mail address' do
    @id = -1

    fields.each do |field_name|
      check_email_address_life_cycle field_name
    end
  end

  # Helper methods ###############

  def check_email_address_life_cycle(field_name)
    add_email_address field_name
    add_email_address field_name

    remove_last_email_address field_name

    check_if_only_the_correct_row_was_removed field_name, @id + 1
    check_if_no_other_fields_are_affected field_name, @id + 1
  end

  def add_email_address(field_name)
    first('input#' + field_name + '_new_recipient_field').set('exemplo' + @id.to_s + '@gmail.com')
    first('span#' + field_name + '_add_recipient_btn').click

    check_if_email_address_was_added field_name, @id

    @id -= 1
  end

  def check_if_email_address_was_added(field_name, i)
    expect(row(field_name, i)).not_to be_nil, msg(field_name)
  end

  def remove_last_email_address(field_name)
    within('tr#' + field_name + '_email_address_' + (@id + 1).to_s) do
      first('img.' + field_name + '_remove_recipient_btn').click
    end
    
    sleep(inspection_time = 1)
  end

  def check_if_only_the_correct_row_was_removed(field_name, i)
    expect(row(field_name, i)).to be_nil, described_class.name + ': ' + field_name
    expect(row(field_name, i + 1)).not_to be_nil, msg(field_name)
  end

  def check_if_no_other_fields_are_affected(field_name, i)
    fields.each do |field_name_2|
      if field_name != field_name_2
        expect(row(field_name, i + 1)).not_to be_nil, msg(field_name, field_name_2)
      end
    end
  end

  def msg(field_name, field_name_2 = '')
    described_class.name + ': ' + field_name + ', ' + field_name_2
  end

  def row(field_name, i)
    first('tr#' + field_name + '_email_address_' + i.to_s)
  end
end
  # rubocop:enable all
