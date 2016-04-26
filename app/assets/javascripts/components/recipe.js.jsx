var RecipeHeader = React.createClass({
  render: function() {
    return (
      <div className="col-sm-6">
        <div className="row-fluid">
          <div className="page-header">
            <h1>{ this.props.recipe.name }</h1>
          </div>
        </div>
      </div>
    );
  }
});

var Ingredient = React.createClass({
  render: function() {
    return ( <li>{ this.props.data }</li>);
  }
});

var IngredientList = React.createClass({
  render: function() {
    return (
      <div className="row-fluid">
        <div className="jpage-header">
          <ul>
            {this.props.ingredients.map(function(ingr) {
              return <Ingredient key={ ingr.id } data={ ingr } />;
            })}
          </ul>
        </div>
      </div>
    );
  }
});

var Direction = React.createClass({
  render: function() {
    return <li>{this.props.data}</li>;
  }
});

var DirectionList = React.createClass({
  render: function() {
    return (
      <ul>
        {this.props.directions.map(function(ingr) {
          return <Direction key={ ingr.id } data={ ingr } />;
        })}
      </ul>
      );
  }
});

var Recipe = React.createClass({
  render: function() {
    return (
      <div>
        <RecipeHeader recipe={this.props.recipe} />
        <h3>Ingredients</h3>
        <IngredientList ingredients={this.props.ingredients} />
        <DirectionList directions={this.props.directions} />
      </div>
      );
  }
});