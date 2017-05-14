import { createStore, combineReducers } from 'redux'
import contacts from './contactsReducer'
import donations from './donationsReducer'

const reducers = {
  donations,
  contacts
}

const reducer = combineReducers(reducers);

export default reducer
