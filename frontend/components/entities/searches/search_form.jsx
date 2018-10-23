import React from 'react';
import { Link } from 'react-router-dom';

class SearchForm extends React.Component {
  constructor(props){
    super(props)

    this.state = {
      query: "",
      searches: {}
    }

    this.state.searches = this.props.searches
    this.handleChange = this.handleChange.bind(this)
  }


  componentWillReceiveProps(nextProps){
    if(Object.keys(nextProps.searches).length !== Object.keys(this.state.searches).length){
      this.setState({
        searches: nextProps.searches
      })
    }

  }

  // componentWillUnmount(nextProps){
  //   // if (this.state.s.length === 0){
  //   //   this.props.deleteSearches()
  //   // }
  // }


  handleChange(e, query){
    e.preventDefault;
    this.setState({
      [query]: e.target.value
    })
    this.props.searchDatabase(e.target.value);
  }


  clearResults(e){
    e.preventDefault;

    this.setState({
      query: "",
      searches: {}
    })
  }

  render(){
    const foundProjects = Object.values(this.state.searches).map(e=>
       [e.title, e.id, e.image_url]
    )

    const count = foundProjects.length;

    const modalSearchList = this.state.query === "" ? "modal-search-list-off" : "modal-search-list"


    const results = this.state.query != "" && count > 0  ?
    foundProjects.map((e)=>{
        return (
          <Link to={`/projects/${e[1]}`} onClick={()=>   $(".modal").removeClass("is-open")} key={`${e[1]}-link`}>
            <li key={`${e[1]}`} className={modalSearchList}><img src={e[2]} className="modal-img"/>{e[0]}</li></Link>
        )
      }
    ) : <li style={{"listStyle" : "none", "fontSize" : "30px", "textAlign":"center"}} className={modalSearchList}>No match for your query</li>

    
    return(
      <div>
        <input autoFocus className="modal-input-box" type="text" onChange={(e)=> this.handleChange(e, "query")} placeholder="Search" value={this.state.query} />

        <ul className="mid-form">
        {results}
        </ul>
      </div>
    )
  }
}

export default SearchForm;
