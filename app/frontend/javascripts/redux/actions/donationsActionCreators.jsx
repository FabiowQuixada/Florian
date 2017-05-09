import { ADD, REMOVE } from './../constants/donationsConstants';

export const add = donation => ({
  type: ADD,
  donation
});

export const remove = donation => ({
  type: REMOVE,
  donation
});
