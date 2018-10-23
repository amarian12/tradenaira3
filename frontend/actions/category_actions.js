import * as APIUtil from '../util/category_util';

export const RECEIVE_CATEGORIES = "RECEIVE_CATEGORIES";
export const RECEIVE_CATEGORY = "RECEIVE_CATEGORY";

export const receiveCategories = (categories) => ({
  type: "RECEIVE_CATEGORIES",
  categories
});

export const receiveCategory = (category) => ({
  type: "RECEIVE_CATEGORY",
  category
});

export const fetchCategories = () => (dispatch) => (
  APIUtil.fetchCategories().then((categories)=> dispatch(receiveCategories(categories))),
  err => (dispatch(receiveErrors(err.responseJSON)))
)

export const fetchCategory = (id) => (dispatch) => (
  APIUtil.fetchCategory(id).then((category)=> dispatch(receiveCategory(category))),
  err => (dispatch(receiveErrors(err.responseJSON)))
)
