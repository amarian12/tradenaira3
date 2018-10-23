import { RECEIVE_CATEGORY, RECEIVE_CATEGORIES } from '../actions/category_actions';
import merge from 'lodash/merge';

const categoryReducer = (state = {}, action) => {
  Object.freeze(state);
  const newState = merge({}, state)
  switch(action.type){
    case RECEIVE_CATEGORIES:
      return action.categories;
    case RECEIVE_CATEGORY:

      newState[action.category.id] = action.category
      return newState;
    default:
      return state;
  }
}

export default categoryReducer;
