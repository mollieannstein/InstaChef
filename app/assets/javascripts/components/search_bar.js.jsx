var SearchBar = React.createClass({

  render: function() {
    return (
      <nav className="navbar bg-grey">
        <div className="row">
          <div className="col-sm-12">
            &lt;%= image_tag("logo.png", alt: 'InstaChef', class: "img-responsive chef-logo")%&gt;
          </div>
        </div>
      </nav>
    );
  }
});
