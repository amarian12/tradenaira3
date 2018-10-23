import { navLink } from '../session/session_form'
import React from 'react';
import { Link } from 'react-router-dom';



const sessionLinks = () => (
  <nav className="login-signup">
    <Link to="/login">Login</Link>
  </nav>
);

const personalGreeting = (currentUser, logout) => (
    <Link to="/login"><li onClick={logout}>Logout</li></Link>
);

const Greeting = ({ currentUser, logout }) => (
  currentUser ? personalGreeting(currentUser, logout) : sessionLinks()
);

export default Greeting;
