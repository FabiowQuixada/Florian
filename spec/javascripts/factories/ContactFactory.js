let contact_temp_id = -1;

class ContactFactory {
  static new(
           id = contact_temp_id--,
           name = 'Joao',
           position = '',
           email_address = '',
           telephone = '',
           celphone = '',
           fax = ''
         ) {
    return {
      id,
      name,
      position,
      email_address,
      telephone,
      celphone,
      fax
    };
  }

  static empty(id = contact_temp_id--) {
    return {
      id,
      name: '',
      position: '',
      email_address: '',
      telephone: '',
      celphone: '',
      fax: ''
    };
  }
}

export default ContactFactory
