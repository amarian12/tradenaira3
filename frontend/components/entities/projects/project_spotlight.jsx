import React from 'react';
import ProjectIndexItem from './project_index_item';
import { Link } from 'react-router-dom';

export const Spotlight = ({props}) => {

  const newestProject = props.map(project=> {
    var images = {
      backgroundImage: `url('` + project.image_url + `')`,
      backgroundRepeat: `no-repeat`,
      backgroundSize: `cover`

    }
    let string = "spotlight"
    return (
    <li key={`${project.title}-${string}`}>
      <div className="newest-container">
        <Link to={`/projects/${project.id}`} style={{ textDecoration: 'none', 'color': 'black' }}>
        <div className="newest-image" style={images}>
          <ul className ="embed-text">
            <li className="newest-title">
              <h1>
                {project.title}
              </h1>
              <p className="newest-author">
                by {project.author.toUpperCase()}
              </p>
            </li>

            <li className="newest-percentage">
              <p>
                {Math.floor((project.total_amount/project.funding_goal)*100)}% funded</p>
            </li>
          </ul>
        </div>
      </Link>
      </div>

   </li>
  )
 }
)[props.length-1]

  let string = "spotlight"
  const recentProjects = props.map(project=>
    <div className="recent-data">
      <Link to={`/projects/${project.id}`} style={{ textDecoration: 'none', 'color': 'black' }}>
      <li key={`${project.title}-${string}`}>
      <div>
        <img src={project.image_url}/>
      </div>
    <div className="recent-div">
      <div className="recent-title">
        {project.title}
      </div>
      <div className="recent-percentage">
        {Math.floor((project.total_amount/project.funding_goal)*100)}% funded
      </div>
    </div>

  </li>
</Link>
</div>
).slice(props.length-5, props.length-1)

function scrolling(){
  var element = document.getElementById("all-projects")
  element.scrollIntoView();
}
    return (
      <div className="spotlight">
        <div className="spotlight-main">
          <div className="spotlight-container">
            <div>
              <h1 className="feature-text">Featured Projects</h1>
              <h2 className="spotlight-header-text">Feature of the day</h2>
              <ul className="newest">{newestProject}</ul>
            </div>
            <div className="recent-items">
              <h1 className="feature-text"><br /></h1>
              <h2 className="spotlight-header-text">New and Noteworthy</h2>
              <ul className="recent">{recentProjects}</ul>
              <div className="to-projects">
                <button onClick={scrolling}>View All</button>
              </div>

            </div>
          </div>
        </div>
        <div className="spotlight-blurb">
          <div className="spotlight-blurb-child">
            <img src="https://thumbs.dreamstime.com/b/funny-cartoon-brain-thumbs-up-clipart-94073330.jpg"></img>
            <h1>"Why KickSTART when you can KickSMART?"</h1>
          </div>
          <div className="spotlight-blurb-child">
            <p>
              - a wiseman once said
            </p>
          </div>
        </div>
      </div>
    )
}
