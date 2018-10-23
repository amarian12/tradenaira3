import React from 'react';
import { connect } from 'react-redux';
import { Route, Redirect, withRouter } from 'react-router-dom';

const Auth = ({component: Component, path, loggedIn}) => {

  return (
    <Route path={path} render={(props) => (
      !loggedIn ? (
        <Component {...props}/>
      ) : (
        <Redirect to="/" />
      )
    )}/>
  );
}

// renders component if logged in, otherwise redirects to the login page
const Protected = ({component: Component, path, loggedIn}) => (
  <Route path={path} render={(props) => (
     loggedIn ? (
      <Component {...props}/>
    ) : (
      <Redirect to="/login"/>
    )
  )}/>
);

// access the Redux state to check if the user is logged in
const mapStateToProps = state => {
  return {loggedIn: Boolean(state.session.currentUser)};
}

// connect Auth to the redux state
export const AuthRoute = withRouter(connect(mapStateToProps, null)(Auth));

// connect Protected to the redux state
export const ProtectedRoute = withRouter(connect(mapStateToProps, null)(Protected));
// In all your projects that use frontend auth you will want this code in a file /frontend/util/route_util.jsx. Then you can simply import these components and use them anywhere you want to need a protected route. For example, suppose we only want users to be able to write reviews if they are logged in.
