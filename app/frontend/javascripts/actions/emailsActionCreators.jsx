import { ADD, REMOVE } from './../constants/emailsConstants';

export const add = email => ({
  type: ADD,
  email: {
    is_persisted: "false",
    address: email
  }
});

export const remove = email => ({
  type: REMOVE,
  email
});
