import { ADD, UPDATE, LOAD_TO_FORM, REMOVE, CANCEL_EDITION } from './../constants/contactsConstants';

export const add = contact => ({
  type: ADD,
  contact
});

export const update = contact => ({
  type: UPDATE,
  contact
});

export const load = contact => ({
  type: LOAD_TO_FORM,
  contact
});

export const remove = contact => ({
  type: REMOVE,
  contact
});

export const cancel_edition = () => ({
  type: CANCEL_EDITION
});
