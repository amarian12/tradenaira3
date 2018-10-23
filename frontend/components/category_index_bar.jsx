import React from 'react';
import { Route, Link, Switch, Redirect } from 'react-router-dom';

const CategoryIndexBar = () => {

    return (
      <div>
      <ul className="category-list-footer">
        <Link to="/">
        <li className="category-list-item-footer">
        Featured</li></Link>
        <Link to="/categories/1/project"><li className="category-list-item-footer">Arts</li></Link>
        <br />
        <Link to="/categories/2/project"><li className="category-list-item-footer">Comics</li></Link>
        <br />
        <Link to="/categories/3/project"><li className="category-list-item-footer">Design</li></Link>
        <br />
        <Link to="/categories/4/project"><li className="category-list-item-footer">Film</li></Link>
        <br />
        <Link to="/categories/5/project"><li className="category-list-item-footer">Food</li></Link>
        <br />
        <Link to="/categories/6/project"><li className="category-list-item-footer">Games</li></Link>
        <br />
        <Link to="/categories/7/project"><li className="category-list-item-footer">Music</li></Link>
        <br />
        <Link to="/categories/8/project"><li className="category-list-item-footer">Publishing</li></Link>
        <br />
        <Link to="/categories/9/project"><li className="category-list-item-footer">Fashion</li></Link>
      </ul>
    </div>
    )

}

export default CategoryIndexBar
