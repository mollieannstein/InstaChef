var Procedure = React.createClass({

  getInitialState: function() {
    return {
      procedure: this.props.procedure,
    }
  },

  render: function() {
    return (
      <div className="procedure-card">
        <h2>{ this.state.procedure.term }</h2>
        <p>{ this.state.procedure.instructions }</p>
      </div>
      );
  }
});

