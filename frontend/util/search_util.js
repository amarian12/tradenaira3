export const searchDatabase = (query) => (
  $.ajax({
    method: 'GET',
    url: 'api/searches',
    data: { search: { query }}
  })
)

export const deleteSearches = (query) => (
  $.ajax({
    method: 'DELETE',
    url: 'api/searches'
  })
)

//??
