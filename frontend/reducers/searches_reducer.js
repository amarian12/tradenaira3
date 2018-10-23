import { RECEIVE_SEARCH_RESULTS, REMOVE_SEARCH_RESULTS } from '../actions/search_actions';

import merge from 'lodash/merge';

const searchReducer = (state = {}, action) => {
  // console.log(state, action)
  Object.freeze(state);
  switch(action.type){
    case RECEIVE_SEARCH_RESULTS:
      return action.results;
    case REMOVE_SEARCH_RESULTS:
    // console.log(action.results)
      delete action.results;
      return action.results;
    default:
      return state;
  }
}

export default searchReducer;
