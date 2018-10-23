import React from 'react';
import { Link } from 'react-router-dom';

class ProjectIndexItem extends React.Component {

  render(){
    let categoryName;
    if (this.props.category){
      categoryName = this.props.category.name;
    } else {
      categoryName = "none";
    }

    const percentage = Math.floor((this.props.project.total_amount/this.props.project.funding_goal) * 100)

    const percentageBar = percentage <= 100 ? <div className="percentage-bar" style={{ 'width': `${percentage}%`, 'zIndex': '99'}}></div> : <div className="percentage-bar" style={{ 'width': `100%`}}></div>

  // console.log(this.props.category.filter(e=> e.id === 1))
  // var mdy = this.props.project.end_date.split('/');
  // console.log(mdy)

  function parseDate(str) {
    var mdy = str.split('/');
    if (mdy[2].length === 2){
      mdy[2] = "20"+mdy[2]
    }
    return new Date(mdy[2], mdy[0]-1, mdy[1]);
  }

  const today = new Date().toJSON().split('T')[0].split('-')
  const correctParse = today.slice(1).concat(today.slice(0,1)).join('/')
  const firstDate = parseDate(correctParse)
  const secondDate = parseDate(this.props.project.end_date)
  function daydiff(first, second) {
    return Math.round((second-first)/(1000*60*60*24)).toString() + " days left";
  }


  let daysToGo = daydiff(firstDate, secondDate)

  if (daysToGo < 1){
    daysToGo = "Project Ended"
  }


    return (
      <div className="project-container">
          <Link to={`/projects/${this.props.project.id}`} style={{ textDecoration: 'none' }}>
        <img className="project-img" src={this.props.project.image_url}/>
        </Link>
        <div className="project-text">
          <p className="limit-3-lines">
            <span className="project-title">{this.props.project.title}</span>: <span className="project-blurb">{this.props.project.blurb}</span>
          </p>
          <p><span style={{ 'color': 'black' }}>by {this.props.project.author}</span></p>

        </div>

        <div className="pledge-box">
          {percentageBar}
          <div className="percentage-bar-empty"></div>
          <p className="pledged_amount" style={{ "color":"#009e74"}}>${this.props.project.total_amount} pledged</p>
          <p className="pledge-funding_goal">{percentage}% funded</p>
          <p className="pledge-end_date">{daysToGo}</p>

          <Link className="category-link" to={`categories/${this.props.project.category_id}/project`}><p className="category-link">{categoryName}</p>
        </Link>
        </div>

      </div>
    )
  }
}

export default ProjectIndexItem
