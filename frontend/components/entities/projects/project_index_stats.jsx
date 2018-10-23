import React from 'react';

class ProjectIndexStats extends React.Component {

  constructor(props){
    super(props)

  }

  componentDidMount(){
    // this.props.props.fetchProjects()
  }

  render(){
    const year = new Date().getFullYear()
    const date = new Date().getDate()
    const month = new Date().getMonth()+1
    const wha = new Date().toLocaleDateString()
    return (
      <div className="project-index-stats">
        <ul className="project-stat-list">
          <li className="psl-left">{wha}<br/> <span style={{"fontWeight":"bolder"}}>Bringing creative projects to life.</span></li>
          <li className="psl-mid">TOTAL BACKERS<br /><span style={{"fontWeight":"bolder"}}>1000</span></li>
          <li className="psl-mid">FUNDED PROJECTS<br /><span style={{"fontWeight":"bolder"}}>{this.props.funded}</span></li>
          <li className="psl-right">LIVE PROJECTS<br /><span style={{"fontWeight":"bolder"}}>{this.props.total}</span></li>
        </ul>
      </div>
    );
  }
}

export default ProjectIndexStats;
