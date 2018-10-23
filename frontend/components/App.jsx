import React from 'react';
import GreetingContainer from './greetings/greeting_container';
import SessionFormContainer from './session/session_form_container';
import { Route, Link, Switch, Redirect } from 'react-router-dom';
import { AuthRoute, ProtectedRoute } from '../util/route_util';
import ProjectIndexContainer from './entities/projects/project_index_container';
import ProjectShowContainer from './entities/projects/project_show_container';
import ProjectFormContainer from './entities/projects/project_form_container';
import RewardFormContainer from './entities/rewards/reward_form_container';
import RewardIndexContainer from './entities/rewards/reward_index_container';
import PledgeFormContainer from './entities/pledges/pledge_form_container';
import SearchFormContainer from './entities/searches/search_form_container';
import CategoryIndexContainer from './entities/categories/category_index_container';
import CategoryShowContainer from './entities/categories/category_show_container';
import SplashVid from '../splash-video.js';
import Spinner from './spinner';

const App = () => (
  <div className="app">
    <header className="top-line">
      <div className="hamburger-menu">
        <a href="#" className="js-modal-dropdown-open"><img src="https://upload.wikimedia.org/wikipedia/commons/b/b2/Hamburger_icon.svg"></img>
        </a>
      </div>
      <div className="left-col">
        <ul className="header-list">
          <Link to="/categories"><li>Explore</li></Link>
          <Link to="/projects"><li>Start a project</li></Link>
        </ul>
      </div>
      <div className="center-logo">
        <Link to="/" style={{ textDecoration: 'none' }}>
          <h1 id="logo">KickSmarter</h1>
        </Link>
      </div>
      <div className="right-col">
        <ul className="header-list">
          <li><a href="#" className="js-modal-open">Search</a></li>
          <Route path="/"><GreetingContainer /></Route>
        </ul>
      </div>
      <div className="h-menu-close"></div>
    </header>

    <div className="modal-dropdown">
      <ul>
        <li>
          <Link to="/categories" onClick={()=>   $(".modal-dropdown").removeClass("is-open")}>
            Explore</Link>
        </li>
        <li>
          <Link to="/projects" onClick={()=>   $(".modal-dropdown").removeClass("is-open")}>Start a project</Link>
        </li>
        <li>
          <Link to="/" onClick={()=>   $(".modal-dropdown").removeClass("is-open")}>
            Index
          </Link>
        </li>
        <li>
          <a href="#" className="js-modal-open" onClick={()=>   $(".modal-dropdown").removeClass("is-open")}>Search</a></li>
        <p onClick={()=>   $(".modal-dropdown").removeClass("is-open")}>
          <Route path="/"><GreetingContainer /></Route>
        </p>

      </ul>
    <div className="modal-dropdown-screen js-modal-dropdown-close"></div>
    </div>
    <div className="main-page">
        <Switch>
          <ProtectedRoute exact path="/categories" component={CategoryIndexContainer}/>
          <ProtectedRoute exact path="/categories/:id/project" component={CategoryShowContainer}/>
          <ProtectedRoute path="/projects/:projectId/rewards" component={RewardIndexContainer}/>
          <ProtectedRoute exact path="/projects/:projectId/rewards" component={RewardFormContainer}/>
          <ProtectedRoute path="/projects/:projectId/pledges" component={PledgeFormContainer}/>
          <ProtectedRoute exact path="/projects/:projectId" component={ProjectShowContainer} />
          <ProtectedRoute exact path="/projects/:projectId/edit" component={ProjectFormContainer} />
          <ProtectedRoute exact path="/projects" component={ProjectFormContainer} />
          <ProtectedRoute exact path="/" component={ProjectIndexContainer}/>
          <AuthRoute path="/login" component={SessionFormContainer} />
          <AuthRoute path="/signup" component={SessionFormContainer} />
          <Redirect to="/"></Redirect>
        </Switch>
      </div>
    <br />
    <br />

      <div className="modal">
        <form autoFocus className="modal-form">
          <span className="modal-close js-modal-close">&times;</span>
            <SearchFormContainer/>
        </form>
      <div className="modal-screen js-modal-close"></div>
      </div>



    <footer>
      <ul>
        <li>&copy; Ricki Nelson</li>
        <li><a href="https://github.com/rnelson082/kicksmarter"><img src="https://assets-cdn.github.com/images/modules/logos_page/GitHub-Mark.png"></img></a></li>
        <li><a href="https://www.linkedin.com/in/ricki-nelson-7885043a/"><img src="https://n6-img-fp.akamaized.net/free-icon/linkedin-logo-button_318-84979.jpg?size=338c&ext=jpg"></img></a></li>
      </ul>
    </footer>
  </div>
)

export default App;
