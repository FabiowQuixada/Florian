shared_examples 'an e-mail address table' do |fields|
  let(:fields) { fields }

  it 'removes a transient e-mail address' do
    fields.each do |field_name|
      @id = -1
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
    first("input##{field_name}_new_recipient_field").set Faker::Internet.email
    first("span##{field_name}_add_recipient_btn").click

    check_if_email_address_was_added field_name, @id

    @id -= 1
  end

  def check_if_email_address_was_added(field_name, i)
    sleep 1
    expect(row(field_name, i)).not_to be_nil, nil_msg(field_name)
  end

  def remove_last_email_address(field_name)
    within("tr##{field_name}_email_address_#{@id + 1}") do
      first("img.#{field_name}_remove_recipient_btn").click
    end

    sleep 1
  end

  def check_if_only_the_correct_row_was_removed(field_name, i)
    expect(row(field_name, i)).to be_nil, not_nil_msg(field_name)
    expect(row(field_name, i + 1)).not_to be_nil, nil_msg(field_name)
  end

  def check_if_no_other_fields_are_affected(field_name, i)
    fields.each do |field_name_2|
      if field_name != field_name_2
        expect(row(field_name, i + 1)).not_to be_nil, nil_msg(field_name, field_name_2)
      end
    end
  end

  def not_nil_msg(field_name, field_name_2 = '')
    "Expected to be nil - #{described_class.name}: #{field_name}, #{field_name_2}"
  end

  def nil_msg(field, field_name_2 = '')
    "Expected not to be nil - #{described_class.name}: #{field}, #{field_name_2}"
  end

  def row(field_name, i)
    first("tr##{field_name}_email_address_#{i}")
  end
end
