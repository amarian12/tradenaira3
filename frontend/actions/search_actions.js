import * as APIUtil from '../util/search_util';

export const RECEIVE_SEARCH_RESULTS = "RECEIVE_SEARCH_RESULTS";

export const REMOVE_SEARCH_RESULTS =
"REMOVE_SEARCH_RESULTS";

export const receiveSearchResults = (results) => ({
  type: RECEIVE_SEARCH_RESULTS,
  results
})

export const removeSearchResults = (results) => ({
  type: REMOVE_SEARCH_RESULTS,
  results
})

export const searchDatabase = (query) => (dispatch) => (
  APIUtil.searchDatabase(query).then((results) => dispatch(receiveSearchResults(results)))
)

export const deleteSearches = (query) => (dispatch) => (
  APIUtil.deleteSearches(query).then((res) => dispatch(removeSearchResults(res)))
)
