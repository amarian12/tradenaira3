import React from 'react';
import { Link } from 'react-router-dom';
import Spinner from '../../spinner'

class CategoryIndex extends React.Component{
  constructor(props){
    super(props)
    this.state = {loading: true}
  }

  componentWillMount(){
    this.props.fetchCategories();
  }

  componentWillReceiveProps(newProps){
     setTimeout(() => this.setState({loading: false}), 750)
       // this.props.fetchCategories();
   }

  render(){


    const categories = Object.values(this.props.categories).map(category =>
    category)

    const randomImages = ["https://static.vecteezy.com/system/resources/previews/000/100/646/non_2x/watercolor-banana-tree-vectors.jpg","https://hikingartist.files.wordpress.com/2015/04/oldcouple_fritsal.jpg?w=1165","http://freedesignfile.com/upload/2015/10/Watercolor-drawn-karate-vector-graphics-03.jpg","https://i.pinimg.com/564x/4c/b5/2f/4cb52f6bf8a6a2a75e5edd584c129a40.jpg","https://i.pinimg.com/564x/97/ff/66/97ff663fac15ea87418d992d01a2160f.jpg"]

    const randomIndex = Math.floor(Math.random()*4)
    if (this.state.loading){
      return (
      <Spinner />
      )
    } else {
    return(
      <div className="categories">
        <ul className="index-categories">
          {
            categories.map(category=>
              <li key={`${category.title}-${category.id}`} className="category-index-item"><Link to={`/categories/${category.id}/project`}>{category.name}</Link>
              </li>
            )
          }
        </ul>
        <img src={randomImages[randomIndex]}></img>
      </div>
    )
    }
  }
}

export default CategoryIndex;
