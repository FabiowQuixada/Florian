shared_examples 'an e-mail address table' do |fields|
  let(:fields) { fields }

  it 'removes a transient e-mail address' do
    fields.each { |field_name| check_email_address_life_cycle field_name }
  end

  # Helper methods ###############

  def check_email_address_life_cycle(field_name)
    email_1 = add_email_address field_name
    add_email_address field_name

    remove_email_address field_name, email_1

    check_if_only_the_correct_row_was_removed field_name, email_1
    check_if_no_other_fields_are_affected field_name, email_1
  end

  def add_email_address(field_name)
    email = Faker::Internet.email
    find("input##{field_name}_new_recipient_field").set email
    find("span##{field_name}_add_recipient_btn").click

    check_if_email_address_was_added field_name, email
    email
  end

  def check_if_email_address_was_added(field_name, email)
    expect(row(field_name, email)).not_to be_nil, nil_msg(field_name)
  end

  def remove_email_address(field_name, email)
    row(field_name, email).find('.remove_btn').click
  end

  def check_if_only_the_correct_row_was_removed(field_name, email)
    expect(row(field_name, email)).to be_nil, not_nil_msg(field_name)
  end

  def check_if_no_other_fields_are_affected(field_name, email)
    rows_other_than(field_name, email).each do |row|
      expect(row).not_to be_nil, nil_msg(field_name, email)
    end
  end

  def not_nil_msg(field_name, field_name_2 = '')
    "Expected to be nil - #{described_class.name}: #{field_name}, #{field_name_2}"
  end

  def nil_msg(field, field_name_2 = '')
    "Expected not to be nil - #{described_class.name}: #{field}, #{field_name_2}"
  end

  def row(field_name, email)
    find "##{field_name}_recipients_table tr", text: email
  rescue
    nil
  end

  def rows_other_than(field_name, email)
    result = []
    temp = find "##{field_name}_recipients_table tr"
    temp.each { |row| result << row unless row.has_content? email }
    result
  rescue
    []
  end
end
