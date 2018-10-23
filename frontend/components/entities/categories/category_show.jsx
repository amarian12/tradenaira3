import React from 'react';
import ProjectIndexContainer from  '../projects/project_index_container';
import CategoryIndexItem from  '../categories/category_index_item';
import { Link } from 'react-router-dom';
import CategoryIndexBar from './category_index_bar';
import Spinner from '../../spinner';
import ProjectIndexStats from '../projects/project_index_stats';

class CategoryShow extends React.Component {
  constructor(props){
    super(props)
    this.state = {loading: true}
  }

  componentDidMount(){
    this.props.fetchProjects();
    this.props.fetchCategory(this.props.match.params.id);
  }

  componentWillReceiveProps(newProps){
     setTimeout(() => this.setState({loading: false}), 750)
       // this.props.fetchCategories();
   }

  render(){

    const categoryItems = this.props.categoryProjects.map(e=> <li key={`${e.title}-${e.id}`}> <CategoryIndexItem project={e} />
    </li>)

    const categoryName = !this.props.category ? "" : this.props.category.name

    const categoryItemCount = !this.props.categoryProjects ? "" : this.props.categoryProjects.length

    const randomIndex = Math.floor(Math.random()*2)

    const picObj = {
      "Arts": "http://artrageousexperience.com/wp-content/uploads/sites/24/2017/06/Three-Painters-Speed-Painting-shows.jpg",
      "Comics":
      "https://ksr-ugc.imgix.net/assets/019/115/594/2b493c46fb203bc49d1c46122c5dd3c0_original.jpg?q=80&blur=false&w=800&fit=true&v=1510093336&auto=format&s=fca0eb481660cc63674216c47a04c6f3",
      "Food":"https://ksr-ugc.imgix.net/assets/019/115/606/d7d53c6c2b2e703c3d6181929f0dcd66_original.jpg?q=80&blur=false&w=800&fit=true&v=1510093381&auto=format&s=1b2a981da3f596ed64284eef38eb5980",
      "Design": "https://ksr-ugc.imgix.net/assets/019/115/599/a851b633cc254a4ba46be2af510cc4de_original.jpg?q=80&blur=false&w=800&fit=true&v=1510093352&auto=format&s=5cb86664247a3b64b2ffba3a282aa693",
      "Film": "https://ksr-ugc.imgix.net/assets/019/115/602/7d070e67abeaa8c23201d79e4972c43a_original.jpg?q=80&blur=false&w=800&fit=true&v=1510093369&auto=format&s=33c82dc177b4a9666cf704ad37030686",
      "Games": "https://ksr-ugc.imgix.net/assets/019/115/620/bc63e96f0bfb9242298237f5af8b2fa0_original.jpg?q=80&blur=false&w=800&fit=true&v=1510093431&auto=format&s=0ac51e4c46e2e173801c693e18eaf764",
      "Music": "https://ksr-ugc.imgix.net/assets/019/224/638/c8575352ca37568fcf91a1e6ec30d7c7_original.jpg?q=80&blur=false&w=800&fit=true&v=1510690335&auto=format&s=4bac3b1ee6062da27f1225e98e21011e",
      "Publishing": "https://ksr-ugc.imgix.net/assets/019/224/616/f29d0c94eba85779e16d05a91dc1ec36_original.jpg?q=80&blur=false&w=800&fit=true&v=1510690238&auto=format&s=31dfd709682b8fff16504bc142f2558d",
      "Fashion": "https://ksr-ugc.imgix.net/assets/019/630/308/8741adbbe297ee62ada3fb5440ddc14c_original.jpg?crop=faces&w=1024&h=576&fit=crop&v=1514968580&auto=format&q=92&s=c58ea2f4c2212ea215646e07a1438fa7"
    }

    const content = categoryItems.length > 0 ? categoryItems : <Link to="/projects/"><h1>"No projects for this yet, how about you create one?"</h1></Link>

  const catProjects = this.props.categoryProjects

    let totalProjects;
    let fundedProjects;
    if (catProjects){
      totalProjects = catProjects.length;
      fundedProjects = catProjects.filter(e=>e.total_amount > 0).length
    }

    if (this.state.loading){
      return (
      <Spinner />
      )
    } else {
    return (
      <div className="category-show-div">
        <div className="category-show-image">
          <img src={picObj[categoryName]}></img>
          <h1 className="category-name">
            {categoryName}
          </h1>
        </div>
        <ProjectIndexStats total={totalProjects}
                          funded={fundedProjects}/>
        <h1 className="category-explore-text">
            Explore <span style={{"color" : "#009e74"}}>
             {categoryItemCount} projects
           </span>
        </h1>

        <ul className="show-categories">
          {
            content
          }
        </ul>

      </div>
    )
  }
  }
}

export default CategoryShow;
