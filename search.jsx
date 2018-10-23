//model
//searching heavy lfting done in backend
// have it in the model that you wan tot search
def self.top_five_results
  param = '%' + query_param.downcase + '%'
  Project.where('lower(title) LIKE ?', param).limit(5) //can user any kind of object: Project, User, Fully Funded (or not).  Ths will return anything that fits the description within the model.
end


//controller
//create index

def random_project
@album = Album.all.sample
render 'api/album/show'

def songs_by_artist
@songs = Song.where


//def index
// @project =  Project.top_five_results(search_params[:query])
// @Users = User.top_five_results(earch_params[:query])
// @funded = Funded.top_five_results(earch_params[:query])
// render index

//def search_params
// params.require(:search).permit(:query, :artist_id, :album_id)
//end


//jsonbuilder - user same patters for other categoies we want to search
@projects.each do |project|
  json.set! project.id do
    json.set! :type, 'artist'
    json.partial! 'api/projects/project', project:
  end
end

//routes
  resources :searches (the controller), only: [:index] do
    get "songs_by_artist", on: :collection
  end


  //API util
export const searchMusicDatabasee = (query) => {
  return $.ajaz({
    method: 'GET',
    url: 'api/music_searches',
    data: { search: { query }}
  })
}

//actions
// RECEIVE SEARCH RESULTS etc...
export const searchDatabse = (query)=> (dispatch) => (
  searchMusicDatabase(query).then(
    (results)
=> dispatch(receieSearchResults(results)))
)

//Reduces
//make nre reducer:
export const SearhcReducer = (state = {}, action) => {
  Object.freeze(state);
  switch(action.type) {
    case RECEIVE_SEARCH_RESULTS:
    return action.searchResults;
    default:
    return state;
  }
}

//import search users into entities

//music search container
const msTP = (state) => ({
  currentUser
})

//creaye ahandleclickoutside
