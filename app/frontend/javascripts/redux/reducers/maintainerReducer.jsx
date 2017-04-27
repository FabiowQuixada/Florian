import { createStore, combineReducers } from 'redux'
import contacts from './contactsReducer'

const reducers = {
  contacts
}

const reducer = combineReducers(reducers);

export default reducer
